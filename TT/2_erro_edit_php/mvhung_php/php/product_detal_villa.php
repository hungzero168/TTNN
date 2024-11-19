<?php
header('Content-Type: application/json');

$url = $_GET['url'] ?? '';
if (empty($url)) {
    echo json_encode(['error' => 'URL is required']);
    exit;
}

$content = @file_get_contents($url);

if ($content === false) {
    echo json_encode(['error' => 'Failed to fetch content from URL']);
    exit;
}

// Title
preg_match('/<h1 class="product_title entry-title">(.*?)<\/h1>/', $content, $title_match);
$title = $title_match[1] ?? null;
$title = str_replace('&#8211;', '-', $title);

// SKU
$sku_pattern = '/SKU:\s*<span class="sku">([^<]+)<\/span>/';
preg_match($sku_pattern, $content, $sku_match);
$sku = $sku_match[1] ?? null;

// Price 
$pattern_sale = '/<p class="price">.*?<del.*?>(.*?)<\/del>.*?<ins.*?>(.*?)<\/ins>.*?<\/p>/s';
$pattern_regular = '/<p class="price">(.*?)<\/p>/s';

if (preg_match($pattern_sale, $content, $matches)) {
    $original_price = preg_replace('/[^0-9.]/', '', strip_tags($matches[1]));
    $current_price = preg_replace('/[^0-9.]/', '', strip_tags($matches[2]));
    
    // Check if the price starts with '36'
    if (strpos($original_price, '36') === 0) {
        $original_price = substr($original_price, 2);
    }
    if (strpos($current_price, '36') === 0) {
        $current_price = substr($current_price, 2);
    }

    $original_price = $original_price === '' ? null : $original_price;
    $current_price = $current_price === '' ? null : $current_price;
} elseif (preg_match($pattern_regular, $content, $matches)) {
    $price_text = $matches[1] ?? '';
    $original_price = preg_replace('/[^0-9.]/', '', strip_tags($price_text));
    // Remove leading '36' if present
    $original_price = (strpos($original_price, '36') === 0) ? substr($original_price, 2) : $original_price;
    $current_price = $original_price;
} else {
    $original_price = '';
    $current_price = '';
}


// Featured image
preg_match('/<img.*?class="wp-post-image".*?src="(.*?)"/', $content, $featured_image_match);
$featured_image = $featured_image_match[1] ?? null;






// Gallery
$pattern = '/<div[^>]*class="[^"]*woocommerce-product-gallery__image[^"]*"[^>]*>(.*?)<\/div>/s';
preg_match_all($pattern, $content, $gallery_matches);

$gallery = [];
$first_preview_removed = false;
foreach ($gallery_matches[0] as $match) {
    if (preg_match('/data-src="([^"]+)"/', $match, $src_match)) {
        $image_url = $src_match[1];
    }
    elseif (preg_match('/src="([^"]+)"/', $match, $src_match)) {
        $image_url = $src_match[1];
    }
    else {
        continue;
    }
    
    // Chỉ loại bỏ ảnh đầu tiên có chữ preview
    if (strpos($image_url, 'preview') !== false && !$first_preview_removed) {
        $first_preview_removed = true;
        continue;
    }
    
    $gallery[] = $image_url;
}

$gallery = array_values(array_unique($gallery));









// preg_match_all('/<img[^>]+src="([^">]+)"[^>]*srcset="([^">]+)"/i', $content, $matches);

// $images = [];

// foreach ($matches[1] as $index => $src) {
//     // Get srcset and split it by commas
//     $srcset = $matches[2][$index];
//     $srcset_items = explode(',', $srcset);

//     // Initialize array to store URL and width
//     $resolutions = [];

//     // Extract URL and size from each srcset item
//     foreach ($srcset_items as $item) {
//         $item = trim($item);
//         // Split URL and size
//         list($url, $size) = explode(' ', $item);
//         // Store size as an integer (remove 'w' character)
//         $resolutions[(int) $size] = $url;
//     }

//     // Get the URL with the highest resolution (largest size)
//     krsort($resolutions); // Sort by size descending
//     $best_image_url = reset($resolutions);

//     // Add to result array
//     $images[] = $best_image_url;
// }

// // Remove the first image and the last 8 images
// if (count($images) > 9) {
//     array_shift($images); // Remove the first image
//     $images = array_slice($images, 0, -8); // Remove the last 8 images
// }
// $gallery = $images;





// Category
preg_match('/<span class="posted_in">Category: <a href=".*?" rel="tag">(.*?)<\/a><\/span>/', $content, $category_match);
$category = $category_match[1] ?? null;

// Tags
preg_match('/<span class="tagged_as">Tags: (.*?)<\/span>/', $content, $tags_match);
$tags_string = $tags_match[1] ?? '';
$tags = !empty($tags_string) ? explode(', ', strip_tags($tags_string)) : null;

// Return the result
$result = [
    'title' => $title, 
    'sku' => $sku, 
    'price' => $original_price, 
    'sale_price' => $current_price, 
    'featured_image' => $featured_image, 
    'gallery' => $gallery, 
    'category' => $category, 
    'tags' => $tags
];

// Ensure proper JSON encoding
echo json_encode($result, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);
?>
