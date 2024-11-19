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
              WHERE 1=1";

    $where_conditions = array();

    if (!empty($filter['date'])) {
        $where_conditions[] = "YEAR(p.created_date) = '" . mysqli_real_escape_string($conn, $filter['date']) . "'";
    }

    if (!empty($filter['category'])) {
        $categories = implode(',', array_map('intval', (array) $filter['category']));
        $where_conditions[] = "c.id IN ($categories)";
    }

    if (!empty($filter['tag'])) {
        $tags = implode(',', array_map('intval', (array) $filter['tag']));
        $where_conditions[] = "t.id IN ($tags)";
    }

    if (!empty($filter['create_date'])) {
        $where_conditions[] = "DATE(p.created_date) = '" . mysqli_real_escape_string($conn, $filter['create_date']) . "'";
    }

    if (!empty($filter['update_date'])) {
        $where_conditions[] = "DATE(p.modified_date) = '" . mysqli_real_escape_string($conn, $filter['update_date']) . "'";
    }

    if (!empty($filter['price_from']) && !empty($filter['price_to'])) {
        $where_conditions[] = "(CASE WHEN p.sale_price != 0.00 THEN p.sale_price ELSE p.price END) BETWEEN " . floatval($filter['price_from']) . " AND " . floatval($filter['price_to']);
    } elseif (!empty($filter['price_from'])) {
        $where_conditions[] = "(CASE WHEN p.sale_price != 0.00 THEN p.sale_price ELSE p.price END) >= " . floatval($filter['price_from']);
    } elseif (!empty($filter['price_to'])) {
        $where_conditions[] = "(CASE WHEN p.sale_price != 0.00 THEN p.sale_price ELSE p.price END) <= " . floatval($filter['price_to']);
    }

    if (!empty($where_conditions)) {
        $query .= " AND " . implode(" AND ", $where_conditions);
    }

    $query .= " GROUP BY p.id";

    if (!empty($filter['order'])) {
        $order = $filter['order'] === 'DESC' ? 'DESC' : 'ASC';
        $query .= " ORDER BY p.created_date " . $order;
    }

    $result = mysqli_query($conn, $query);

    if ($result && mysqli_num_rows($result) > 0) {
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