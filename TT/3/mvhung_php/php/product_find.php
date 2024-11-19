<?php
include 'conect.php';

// Sanitize input to avoid SQL injection
$product_name = mysqli_real_escape_string($conn, $_GET['product_name']);

// Prepare SQL query
$sql = "SELECT * FROM products WHERE title LIKE '%$product_name%'";

// Execute query
$result = mysqli_query($conn, $sql);

if ($result) {
    // Check if any products were found
    if (mysqli_num_rows($result) > 0) {
        $products = mysqli_fetch_all($result, MYSQLI_ASSOC);
        
        // Fetch categories and tags for each product
        foreach ($products as &$product) {
            $product_id = $product['id'];
            
            // Fetch categories
            $category_sql = "SELECT c.category_name FROM categories c
                             JOIN product_categories pc ON c.id = pc.category_id
                             WHERE pc.product_id = $product_id";
            $category_result = mysqli_query($conn, $category_sql);
            $categories = mysqli_fetch_all($category_result, MYSQLI_ASSOC);
            $product['categories'] = array_column($categories, 'category_name');
            
            // Fetch tags
            $tag_sql = "SELECT t.tag_name FROM tags t
                        JOIN product_tags pt ON t.id = pt.tag_id
                        WHERE pt.product_id = $product_id";
            $tag_result = mysqli_query($conn, $tag_sql);
            $tags = mysqli_fetch_all($tag_result, MYSQLI_ASSOC);
            $product['tags'] = array_column($tags, 'tag_name');
        }
        
        echo json_encode(['status' => 'success', 'products' => $products]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No products found']);
    }
} else {
    // Return SQL error if query fails
    echo json_encode(['status' => 'error', 'message' => 'Query failed: ' . mysqli_error($conn)]);
}

// Close connection
mysqli_close($conn);
?>
