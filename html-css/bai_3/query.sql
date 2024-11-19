
INSERT INTO products (sku, title, price, sale_price, featured_image, description, created_date, modified_date) VALUES ('SKU001', 'Product 1', 100, 80, 'image1.jpg', 'Description 1', '2023-01-01 00:00:00', '2023-01-01 00:00:00');

UPDATE products SET price = 120 WHERE id = 51;

DELETE FROM products WHERE id = 51;



SELECT p.id, p.sku, p.title, p.price, p.sale_price, p.featured_image, 
       p.description, p.created_date, p.modified_date,
       GROUP_CONCAT(g.gallery_image) AS gallery,
       GROUP_CONCAT(c.category_name) AS categories,
       GROUP_CONCAT(t.tag_name) AS tags
FROM products p
LEFT JOIN product_gallery g ON p.id = g.product_id
LEFT JOIN product_categories pc ON p.id = pc.product_id
LEFT JOIN categories c ON pc.category_id = c.id
LEFT JOIN product_tags pt ON p.id = pt.product_id
LEFT JOIN tags t ON pt.tag_id = t.id
GROUP BY p.id;


SELECT p.id, p.sku, p.title, p.price, p.sale_price, p.featured_image, 
       p.description, p.created_date, p.modified_date,
       GROUP_CONCAT( g.gallery_image) AS gallery,
       GROUP_CONCAT( c.category_name) AS categories,
       GROUP_CONCAT( t.tag_name) AS tags
FROM products p
LEFT JOIN product_gallery g ON p.id = g.product_id
LEFT JOIN product_categories pc ON p.id = pc.product_id
LEFT JOIN categories c ON pc.category_id = c.id
LEFT JOIN product_tags pt ON p.id = pt.product_id
LEFT JOIN tags t ON pt.tag_id = t.id
WHERE c.category_name IN ('Audio', 'Smartphones') OR t.tag_name IN ('Apple', 'Android')
GROUP BY p.id
LIMIT 5 OFFSET 10;


SELECT p.id, p.sku, p.title, p.price, p.sale_price, p.featured_image, 
       p.description, p.created_date, p.modified_date,
       GROUP_CONCAT(g.gallery_image) AS gallery,
       GROUP_CONCAT(c.category_name) AS categories,
       GROUP_CONCAT(t.tag_name) AS tags
FROM products p
LEFT JOIN product_gallery g ON p.id = g.product_id
LEFT JOIN product_categories pc ON p.id = pc.product_id
LEFT JOIN categories c ON pc.category_id = c.id
LEFT JOIN product_tags pt ON p.id = pt.product_id
LEFT JOIN tags t ON pt.tag_id = t.id
WHERE p.title LIKE '%Apple%'
GROUP BY p.id
LIMIT 5 OFFSET 0;  


SELECT p.id, p.sku, p.title, p.price, p.sale_price, p.featured_image, 
       p.description, p.created_date, p.modified_date,
       GROUP_CONCAT(g.gallery_image) AS gallery,
       GROUP_CONCAT(c.category_name) AS categories,
       GROUP_CONCAT(t.tag_name) AS tags
FROM products p
LEFT JOIN product_gallery g ON p.id = g.product_id
LEFT JOIN product_categories pc ON p.id = pc.product_id
LEFT JOIN categories c ON pc.category_id = c.id
LEFT JOIN product_tags pt ON p.id = pt.product_id
LEFT JOIN tags t ON pt.tag_id = t.id
GROUP BY p.id
ORDER BY p.price ASC, p.title DESC, p.created_date ASC
LIMIT 5 OFFSET 0;


