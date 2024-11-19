<?php
include 'conect.php'; // Include your database connection file

if (isset($_POST['id'])) {
    $id = mysqli_real_escape_string($conn, $_POST['id']); // Get product ID from the POST request

    // Prepare and execute the delete query
    $query = "DELETE FROM products WHERE id = '$id'";

    if (mysqli_query($conn, $query)) {
        // Successful deletion
        echo json_encode(['status' => 'success', 'message' => 'Product deleted successfully.']);
    } else {
        // Deletion failed
        echo json_encode(['status' => 'error', 'message' => 'Failed to delete product.']);
    }
} else {
    echo json_encode(['status' => 'error', 'message' => 'No product ID provided.']);
}
?>
