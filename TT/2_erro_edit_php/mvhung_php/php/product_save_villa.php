<?php

include 'conect.php';

// Check if $conn is set and is a valid database connection
if (!isset($conn) || !($conn instanceof mysqli)) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed']);
    exit;
}

// Get the JSON data from the POST request
$productData = json_decode(file_get_contents('php://input'), true);

// Function to check if a product exists by title
function productExistsByTitle($conn, $title) {
    $stmt = $conn->prepare("SELECT id FROM products WHERE title = ?");
    $stmt->bind_param('s', $title);
    $stmt->execute();
    $stmt->store_result();
    $exists = $stmt->num_rows > 0;
    $stmt->close();
    return $exists;
}

// Function to get product ID by title
function getProductIdByTitle($conn, $title) {
    $stmt = $conn->prepare("SELECT id FROM products WHERE title = ?");
    $stmt->bind_param('s', $title);
    $stmt->execute();
    $id = null; // Initialize the variable
    $stmt->bind_result($id);
    $stmt->fetch();
    $result = $id; // Store the result before closing the statement
    $stmt->close();
    return $result;
}

// Check if product has a title or any other key data to proceed
if (!empty($productData['title'])) {
    try {
        // Check if product already exists by title
        $productExists = productExistsByTitle($conn, $productData['title']);
        
        // Ensure price and sale_price are not null
        $price = !empty($productData['price']) ? $productData['price'] : '0';
        $sale_price = !empty($productData['sale_price']) ? $productData['sale_price'] : $price;
        
        if ($productExists) {
            // If the product exists, update all its information
            $product_id = getProductIdByTitle($conn, $productData['title']);
            $stmt = $conn->prepare("UPDATE products SET sku = ?, price = ?, sale_price = ?, featured_image = ?, modified_date = NOW() WHERE id = ?");
            $stmt->bind_param('ssssi', $productData['sku'], $price, $sale_price, $productData['featured_image'], $product_id);
            $stmt->execute();
            $affected_rows = $stmt->affected_rows;
            $stmt->close();

            // Update gallery images
            $stmt = $conn->prepare("DELETE FROM product_gallery WHERE product_id = ?");
            $stmt->bind_param('i', $product_id);
            $stmt->execute();
            $stmt->close();

            if (!empty($productData['gallery'])) {
                $stmt = $conn->prepare("INSERT INTO product_gallery (product_id, gallery_image) VALUES (?, ?)");
                foreach ($productData['gallery'] as $image) {
                    $image = trim($image);
                    if (!empty($image)) {
                        $stmt->bind_param('is', $product_id, $image);
                        if (!$stmt->execute()) {
                            throw new Exception('Failed to insert gallery image: ' . $stmt->error);
                        }
                    }
                }
                $stmt->close();
            }

            // Update categories
            $stmt = $conn->prepare("DELETE FROM product_categories WHERE product_id = ?");
            $stmt->bind_param('i', $product_id);
            $stmt->execute();
            $stmt->close();

            if (!empty($productData['category'])) {
                $stmt = $conn->prepare("INSERT IGNORE INTO categories (category_name) VALUES (?)");
                $stmt_link = $conn->prepare("INSERT IGNORE INTO product_categories (product_id, category_id) VALUES (?, ?)");
                $stmt->bind_param('s', $productData['category']);
                if (!$stmt->execute()) {
                    throw new Exception('Failed to insert category: ' . $stmt->error);
                }
                $category_id = $stmt->insert_id;
                if ($category_id == 0) {
                    $stmt_get_id = $conn->prepare("SELECT id FROM categories WHERE category_name = ?");
                    $stmt_get_id->bind_param('s', $productData['category']);
                    $stmt_get_id->execute();
                    $stmt_get_id->bind_result($category_id);
                    $stmt_get_id->fetch();
                    $stmt_get_id->close();
                }
                $stmt_link->bind_param('ii', $product_id, $category_id);
                if (!$stmt_link->execute()) {
                    throw new Exception('Failed to link product to category: ' . $stmt_link->error);
                }
                $stmt->close();
                $stmt_link->close();
            }

            // Update tags
            $stmt = $conn->prepare("DELETE FROM product_tags WHERE product_id = ?");
            $stmt->bind_param('i', $product_id);
            $stmt->execute();
            $stmt->close();

            if (!empty($productData['tags'])) {
                $stmt = $conn->prepare("INSERT IGNORE INTO tags (tag_name) VALUES (?)");
                $stmt_link = $conn->prepare("INSERT IGNORE INTO product_tags (product_id, tag_id) VALUES (?, ?)");
                foreach ($productData['tags'] as $tag) {
                    $stmt->bind_param('s', $tag);
                    if (!$stmt->execute()) {
                        throw new Exception('Failed to insert tag: ' . $stmt->error);
                    }
                    $tag_id = $stmt->insert_id;
                    if ($tag_id == 0) {
                        $stmt_get_id = $conn->prepare("SELECT id FROM tags WHERE tag_name = ?");
                        $stmt_get_id->bind_param('s', $tag);
                        $stmt_get_id->execute();
                        $stmt_get_id->bind_result($tag_id);
                        $stmt_get_id->fetch();
                        $stmt_get_id->close();
                    }
                    $stmt_link->bind_param('ii', $product_id, $tag_id);
                    if (!$stmt_link->execute()) {
                        throw new Exception('Failed to link product to tag: ' . $stmt_link->error);
                    }
                }
                $stmt->close();
                $stmt_link->close();
            }

            echo json_encode(['status' => 'success', 'message' => 'Product updated successfully', 'is_new_product' => false]);
        } else {
            // If not exists, insert the product
            $stmt = $conn->prepare("INSERT INTO products (sku, title, price, sale_price, featured_image, created_date) VALUES (?, ?, ?, ?, ?, NOW())");
            $stmt->bind_param('sssss', $productData['sku'], $productData['title'], $price, $sale_price, $productData['featured_image']);
            if (!$stmt->execute()) {
                throw new Exception('Failed to insert product: ' . $stmt->error);
            }
            $product_id = $stmt->insert_id;
            $stmt->close();

            // Handle gallery images
            if (!empty($productData['gallery'])) {
                $stmt = $conn->prepare("INSERT INTO product_gallery (product_id, gallery_image) VALUES (?, ?)");
                foreach ($productData['gallery'] as $image) {
                    $image = trim($image);
                    if (!empty($image)) {
                        $stmt->bind_param('is', $product_id, $image);
                        if (!$stmt->execute()) {
                            throw new Exception('Failed to insert gallery image: ' . $stmt->error);
                        }
                    }
                }
                $stmt->close();
            }

            // Handle categories
            if (!empty($productData['category'])) {
                $stmt = $conn->prepare("INSERT IGNORE INTO categories (category_name) VALUES (?)");
                $stmt_link = $conn->prepare("INSERT IGNORE INTO product_categories (product_id, category_id) VALUES (?, ?)");
                $stmt->bind_param('s', $productData['category']);
                if (!$stmt->execute()) {
                    throw new Exception('Failed to insert category: ' . $stmt->error);
                }
                $category_id = $stmt->insert_id;
                if ($category_id == 0) {
                    $stmt_get_id = $conn->prepare("SELECT id FROM categories WHERE category_name = ?");
                    $stmt_get_id->bind_param('s', $productData['category']);
                    $stmt_get_id->execute();
                    $stmt_get_id->bind_result($category_id);
                    $stmt_get_id->fetch();
                    $stmt_get_id->close();
                }
                $stmt_link->bind_param('ii', $product_id, $category_id);
                if (!$stmt_link->execute()) {
                    throw new Exception('Failed to link product to category: ' . $stmt_link->error);
                }
                $stmt->close();
                $stmt_link->close();
            }

            // Handle tags
            if (!empty($productData['tags'])) {
                $stmt = $conn->prepare("INSERT IGNORE INTO tags (tag_name) VALUES (?)");
                $stmt_link = $conn->prepare("INSERT IGNORE INTO product_tags (product_id, tag_id) VALUES (?, ?)");
                foreach ($productData['tags'] as $tag) {
                    $stmt->bind_param('s', $tag);
                    if (!$stmt->execute()) {
                        throw new Exception('Failed to insert tag: ' . $stmt->error);
                    }
                    $tag_id = $stmt->insert_id;
                    if ($tag_id == 0) {
                        $stmt_get_id = $conn->prepare("SELECT id FROM tags WHERE tag_name = ?");
                        $stmt_get_id->bind_param('s', $tag);
                        $stmt_get_id->execute();
                        $stmt_get_id->bind_result($tag_id);
                        $stmt_get_id->fetch();
                        $stmt_get_id->close();
                    }
                    $stmt_link->bind_param('ii', $product_id, $tag_id);
                    if (!$stmt_link->execute()) {
                        throw new Exception('Failed to link product to tag: ' . $stmt_link->error);
                    }
                }
                $stmt->close();
                $stmt_link->close();
            }

            echo json_encode(['status' => 'success', 'message' => 'Product saved successfully', 'is_new_product' => true]);
        }
    } catch (Exception $e) {
        echo json_encode(['status' => 'error', 'message' => $e->getMessage()]);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid product data']);
}

$conn->close();
