<?php
include 'conect.php';

// Check if filter data exists, either from GET or POST
$filter = isset($_POST['filter']) ? $_POST['filter'] : $_GET;

if ($filter) {
    $query = "SELECT p.id, p.sku, p.title, p.price, p.sale_price, p.featured_image,
              p.description, p.created_date, p.modified_date,
              GROUP_CONCAT(DISTINCT pg.gallery_image) AS gallery,
              GROUP_CONCAT(DISTINCT c.category_name) AS categories,
              GROUP_CONCAT(DISTINCT t.tag_name) AS tags
              FROM products p
              LEFT JOIN product_gallery pg ON p.id = pg.product_id
              LEFT JOIN product_categories pc ON p.id = pc.product_id
              LEFT JOIN categories c ON pc.category_id = c.id
              LEFT JOIN product_tags pt ON p.id = pt.product_id
              LEFT JOIN tags t ON pt.tag_id = t.id
              WHERE 1=1";  // Use a placeholder for WHERE clause

    $where_conditions = array();

    // Category filtering
    if (!empty($filter['Category'])) {
        $categories = implode(',', array_map('intval', (array) $filter['Category']));
        $where_conditions[] = "c.id IN ($categories)";
    }

    // Tag filtering
    if (!empty($filter['Tag'])) {
        $tags = implode(',', array_map('intval', (array) $filter['Tag']));
        $where_conditions[] = "t.id IN ($tags)";
    }

    // Create date filter
    if (!empty($filter['create_date'])) {
        $where_conditions[] = "DATE(p.created_date) = '" . mysqli_real_escape_string($conn, $filter['create_date']) . "'";
    }

    // Update date filter
    if (!empty($filter['update_date'])) {
        $where_conditions[] = "DATE(p.modified_date) = '" . mysqli_real_escape_string($conn, $filter['update_date']) . "'";
    }

    // Price range filter
    if (!empty($filter['price_from']) && !empty($filter['price_to'])) {
        $where_conditions[] = "(CASE 
                                  WHEN p.sale_price != 0.00 
                                  THEN p.sale_price 
                                  ELSE p.price 
                                END BETWEEN " . floatval($filter['price_from']) . " AND " . floatval($filter['price_to']) . ")";
    } elseif (!empty($filter['price_from'])) {
        $where_conditions[] = "(CASE 
                                  WHEN p.sale_price != 0.00 
                                  THEN p.sale_price 
                                  ELSE p.price 
                                END >= " . floatval($filter['price_from']) . ")";
    } elseif (!empty($filter['price_to'])) {
        $where_conditions[] = "(CASE 
                                  WHEN p.sale_price != 0.00 
                                  THEN p.sale_price 
                                  ELSE p.price 
                                END <= " . floatval($filter['price_to']) . ")";
    }

    // Append where conditions if any exist
    if (!empty($where_conditions)) {
        $query .= " AND " . implode(" AND ", $where_conditions);
    }

    $query .= " GROUP BY p.id"; // Group by product id

    // Sorting based on Date, Name, SKU, or Price
    if (!empty($filter['Date']) && !empty($filter['Order'])) {
        $field = mysqli_real_escape_string($conn, $filter['Date']);
        $order = $filter['Order'] === 'DESC' ? 'DESC' : 'ASC';
        
        switch ($field) {
            case 'date':
                $query .= " ORDER BY p.created_date " . $order;
                break;
            case 'name':
                $query .= " ORDER BY p.title " . $order;
                break;
            case 'sku':
                $query .= " ORDER BY p.sku " . $order;
                break;
            case 'price':
                $query .= " ORDER BY CASE WHEN p.sale_price != 0.00 THEN p.sale_price ELSE p.price END " . $order;
                break;
        }
    }

    // Log the final query for debugging
    error_log($query); // This will log the query in your PHP error log

    $result = mysqli_query($conn, $query);

    if ($result === false) {
        // Log the error message
        error_log("MySQL Error: " . mysqli_error($conn));
        echo json_encode(['status' => 'error', 'message' => 'Database query error.']);
    } elseif (mysqli_num_rows($result) > 0) {
        $products = mysqli_fetch_all($result, MYSQLI_ASSOC);
        echo json_encode(['status' => 'success', 'products' => $products]);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'No products found.']);
    }

    mysqli_close($conn);
    exit();
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid request.']);
    mysqli_close($conn);
    exit();
}
?>
