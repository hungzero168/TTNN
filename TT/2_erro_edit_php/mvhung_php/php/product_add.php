<?php
require_once 'conect.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Check required fields
    if (empty($_POST['product_name']) || empty($_POST['sku']) || empty($_POST['product_price'])) {
        echo json_encode(['status' => 'error', 'message' => 'Product name, SKU, and price are required.']);
        exit;
    }

    // Start a transaction
    mysqli_begin_transaction($conn);

    try {
        $product_name = mysqli_real_escape_string($conn, $_POST['product_name']);
        $sku = mysqli_real_escape_string($conn, $_POST['sku']);
        $product_price = floatval($_POST['product_price']);
        
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
        $sql = "INSERT INTO products (sku, title, price) VALUES (?, ?, ?)";
        $stmt = mysqli_prepare($conn, $sql);
        mysqli_stmt_bind_param($stmt, "ssd", $sku, $product_name, $product_price);
        
        if (!mysqli_stmt_execute($stmt)) {
            throw new Exception('Failed to insert product: ' . mysqli_error($conn));
        }

        $product_id = mysqli_insert_id($conn);

        // Handle featured image upload if provided (optional)
        if (isset($_FILES['featured_image']) && $_FILES['featured_image']['error'] === UPLOAD_ERR_OK) {
            $upload_dir = '../img/uploads/';
            if (!is_dir($upload_dir)) {
                if (!mkdir($upload_dir, 0755, true)) {
                    throw new Exception('Failed to create upload directory.');
                }
            }

            $featured_image = $_FILES['featured_image'];
            $featured_image_name = uniqid() . '_' . basename($featured_image['name']);
            $featured_image_path = $upload_dir . $featured_image_name;

            if (!move_uploaded_file($featured_image['tmp_name'], $featured_image_path)) {
                throw new Exception('Failed to upload featured image.');
            }

            $sql_update = "UPDATE products SET featured_image = ? WHERE id = ?";
            $stmt_update = mysqli_prepare($conn, $sql_update);
            mysqli_stmt_bind_param($stmt_update, "si", $featured_image_path, $product_id);
            if (!mysqli_stmt_execute($stmt_update)) {
                throw new Exception('Failed to update product with featured image: ' . mysqli_error($conn));
            }
        }

        // Handle gallery image upload if provided (optional)
        if (isset($_FILES['gallery_image']) && $_FILES['gallery_image']['error'] === UPLOAD_ERR_OK) {
            $upload_dir = '../img/uploads/';
            if (!is_dir($upload_dir)) {
                if (!mkdir($upload_dir, 0755, true)) {
                    throw new Exception('Failed to create upload directory.');
                }
            }

            $gallery_image = $_FILES['gallery_image'];
            $gallery_image_name = uniqid() . '_' . basename($gallery_image['name']);
            $gallery_image_path = $upload_dir . $gallery_image_name;

            if (!move_uploaded_file($gallery_image['tmp_name'], $gallery_image_path)) {
                throw new Exception('Failed to upload gallery image.');
            }

            $sql_gallery = "INSERT INTO product_gallery (product_id, gallery_image) VALUES (?, ?)";
            $stmt_gallery = mysqli_prepare($conn, $sql_gallery);
            mysqli_stmt_bind_param($stmt_gallery, "is", $product_id, $gallery_image_path);
            if (!mysqli_stmt_execute($stmt_gallery)) {
                throw new Exception('Failed to insert gallery image: ' . mysqli_error($conn));
            }
        }

        // Insert categories if provided (optional)
        if (isset($_POST['Category']) && !empty($_POST['Category'])) {
            $categories = json_decode($_POST['Category']);
            $sql_category = "INSERT INTO product_categories (product_id, category_id) VALUES (?, ?)";
            $stmt_category = mysqli_prepare($conn, $sql_category);
            foreach ($categories as $category_id) {
                mysqli_stmt_bind_param($stmt_category, "ii", $product_id, $category_id);
                if (!mysqli_stmt_execute($stmt_category)) {
                    throw new Exception('Failed to insert category: ' . mysqli_error($conn));
                }
            }
        }

        // Insert tags if provided (optional)
        if (isset($_POST['Tag']) && !empty($_POST['Tag'])) {
            $tags = json_decode($_POST['Tag']);
            $sql_tag = "INSERT INTO product_tags (product_id, tag_id) VALUES (?, ?)";
            $stmt_tag = mysqli_prepare($conn, $sql_tag);
            foreach ($tags as $tag_id) {
                mysqli_stmt_bind_param($stmt_tag, "ii", $product_id, $tag_id);
                if (!mysqli_stmt_execute($stmt_tag)) {
                    throw new Exception('Failed to insert tag: ' . mysqli_error($conn));
                }
            }
        }

        // Commit the transaction
        mysqli_commit($conn);

        // Return success JSON response
        echo json_encode(['status' => 'success', 'message' => 'Product added successfully']);

    } catch (Exception $e) {
        // Rollback the transaction on error
        mysqli_rollback($conn);
        
        // Return detailed error JSON response
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
} else {
    // Return error JSON response for invalid request method
    echo json_encode(['status' => 'error', 'message' => 'Invalid request method']);
}

?>