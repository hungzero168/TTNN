<?php
require_once 'conect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Start a transaction
    mysqli_begin_transaction($conn);

    try {
        $product_name = mysqli_real_escape_string($conn, $_POST['product_name']);
        $sku = mysqli_real_escape_string($conn, $_POST['sku']);
        $product_price = floatval($_POST['product_price']);
        
        // Ensure the upload directory exists
        $upload_dir = '../img/uploads/';
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0755, true);
        }

        // Handle the featured image upload
        if (isset($_FILES['featured_image']) && $_FILES['featured_image']['error'] === UPLOAD_ERR_OK) {
            $featured_image = $_FILES['featured_image'];
            $featured_image_name = uniqid() . '_' . basename($featured_image['name']);
            $featured_image_path = $upload_dir . $featured_image_name;

            if (!move_uploaded_file($featured_image['tmp_name'], $featured_image_path)) {
                throw new Exception('Failed to upload featured image.');
            }
        } else {
            throw new Exception('Featured image is required.');
        }
        // Check if the SKU already exists
        $check_sku_sql = "SELECT id FROM products WHERE sku = ?";
        $check_sku_stmt = mysqli_prepare($conn, $check_sku_sql);
        mysqli_stmt_bind_param($check_sku_stmt, "s", $sku);
        mysqli_stmt_execute($check_sku_stmt);
        mysqli_stmt_store_result($check_sku_stmt);
        
        if (mysqli_stmt_num_rows($check_sku_stmt) > 0) {
            throw new Exception('SKU already exists.');
        }
        
        // Insert the product into the database
        $sql = "INSERT INTO products (sku, title, price, featured_image) 
                VALUES (?, ?, ?, ?)";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "ssds", $sku, $product_name, $product_price, $featured_image_path);
        
        if (!mysqli_stmt_execute($stmt)) {
            throw new Exception('Failed to insert product.');
        }

        $product_id = mysqli_insert_id($conn);

        // Handle gallery images upload
        if (isset($_FILES['gallery_images'])) {
            foreach ($_FILES['gallery_images']['error'] as $key => $error) {
                if ($error === UPLOAD_ERR_OK) {
                    $gallery_image_tmp = $_FILES['gallery_images']['tmp_name'][$key];
                    $gallery_image_name = uniqid() . '_' . basename($_FILES['gallery_images']['name'][$key]);
                    $gallery_image_path = $upload_dir . $gallery_image_name;

                    if (move_uploaded_file($gallery_image_tmp, $gallery_image_path)) {
                        $sql_gallery = "INSERT INTO product_gallery (product_id, gallery_image) VALUES (?, ?)";
                        $stmt_gallery = mysqli_prepare($conn, $sql_gallery);
                        mysqli_stmt_bind_param($stmt_gallery, "is", $product_id, $gallery_image_path);
                        mysqli_stmt_execute($stmt_gallery);
                    }
                }
            }
        }

        // Insert categories
        if (isset($_POST['category'])) {
            $sql_category = "INSERT INTO product_categories (product_id, category_id) VALUES (?, ?)";
            $stmt_category = mysqli_prepare($conn, $sql_category);
            foreach ($_POST['category'] as $category_id) {
                mysqli_stmt_bind_param($stmt_category, "ii", $product_id, $category_id);
                mysqli_stmt_execute($stmt_category);
            }
        }

        // Insert tags
        if (isset($_POST['tag'])) {
            $sql_tag = "INSERT INTO product_tags (product_id, tag_id) VALUES (?, ?)";
            $stmt_tag = mysqli_prepare($conn, $sql_tag);
            foreach ($_POST['tag'] as $tag_id) {
                mysqli_stmt_bind_param($stmt_tag, "ii", $product_id, $tag_id);
                mysqli_stmt_execute($stmt_tag);
            }
        }

        // Commit the transaction
        mysqli_commit($conn);

        // Redirect to success page
        header('Location: ../index.html?message=successfully');
        exit();

    } catch (Exception $e) {
        // Rollback the transaction on error
        mysqli_rollback($conn);
        
        // Redirect to error page
        header('Location: ../index.html?message=error&details=' . urlencode($e->getMessage()));
        exit();
    }
}
?>