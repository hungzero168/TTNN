document.addEventListener('DOMContentLoaded', function () {
    
    $(document).ready(function() {
        $('.ui.dropdown').dropdown();
        $('.ui.dropdown .dropdown.icon').removeClass('dropdown icon').addClass('chevron down icon');
    });
    
    $(document).ready(function () {
        $('#addProductBtn').on('click', function () {
            $('#addProductPopup').modal('show');
        });

        $('#cancelBtn').on('click', function () {
            $('#addProductPopup').modal('hide');
        });

        $('#deleteProductBtn').on('click', function () {
            if (confirm('Are you sure you want to delete all products?')) {
                $.ajax({
                    url: 'php/del_all_product.php',
                    type: 'POST',
                    data: { delete_all_products: true },
                    success: function (data) {
                        alert('All products have been deleted.');
                        location.reload();
                    },
                    error: function (xhr, status, error) {
                        console.error("Error deleting products:", error);
                        alert('An error occurred while deleting the products. Please try again.');
                    }
                });
            }
        });

        $('#filterBtn').on('click', function () {
            var filter = {
                date: $('#Date').val(),
                order: $('#Order').val(),
                category: $('#Category').val(),
                tag: $('#Tag').val(),
                create_date: $('#create_date').val(),
                update_date: $('#update_date').val(),
                price_from: $('#price_from').val(),
                price_to: $('#price_to').val()
            };
            $.ajax({
                url: 'php/filter.php',
                type: 'POST',
                data: { filter: filter },
                dataType: 'json',
                success: function (response) {
                    var tableBody = $('#productTableBody');
                    tableBody.empty(); 
                    if (response.status === 'success') {
                        var products = response.products;
                        var productsPerPage = 5;
                        var totalPages = Math.ceil(products.length / productsPerPage);
                        var currentPage = 1;

                        function displayProducts(page) {
                            var start = (page - 1) * productsPerPage;
                            var end = start + productsPerPage;
                            var pageProducts = products.slice(start, end);

                            tableBody.empty();
                            $.each(pageProducts, function (i, product) {
                                var row = $('<tr>');
                                var date = new Date(product.created_date);
                                var formattedDate = date.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric' }).replace(/\//g, '/');
                                row.append($('<td>').text(formattedDate));
                                row.append($('<td>').text(product.title));
                                row.append($('<td>').text(product.sku));
                                row.append($('<td>').text("$" + parseFloat(product.price).toFixed(2)));

                                if (product.featured_image) {
                                    var featuredImage = $('<img>').attr('src', product.featured_image.replace('../', '')).css({
                                        'width': '30px',
                                        'height': '30px',
                                        'object-fit': 'cover',
                                    });
                                    row.append($('<td>').html(featuredImage));
                                } else {
                                    row.append($('<td>').text('No img'));
                                }

                                var galleryImages = product.gallery ? product.gallery.replace('../', '').split(',') : [];
                                var firstGalleryImage = galleryImages[0];

                                if (firstGalleryImage) {
                                    var galleryImage = $('<img>').attr('src', firstGalleryImage).css({
                                        'width': '30px',
                                        'height': '30px',
                                        'object-fit': 'cover'
                                    });
                                    row.append($('<td>').html(galleryImage));
                                } else {
                                    row.append($('<td>').text('No img'));
                                }

                                row.append($('<td>').text(product.categories).css('max-width', '100px').css('white-space', 'nowrap').css('overflow', 'hidden').css('text-overflow', 'ellipsis'));
                                row.append($('<td>').text(product.tags).css('max-width', '100px').css('white-space', 'nowrap').css('overflow', 'hidden').css('text-overflow', 'ellipsis'));
                                row.append($('<td>').html('<i class="edit icon editIcon"></i><i class="trash icon trashIcon"></i>'));
                                tableBody.append(row);
                            });

                            updatePagination(currentPage, totalPages);
                        }

                        function updatePagination(currentPage, totalPages) {
                            var paginationContainer = $('#pagination_product');
                            paginationContainer.empty();

                            for (var i = 1; i <= totalPages; i++) {
                                var pageLink = $('<a>').addClass('item').text(i);
                                if (i === currentPage) {
                                    pageLink.addClass('active');
                                }
                                pageLink.on('click', function() {
                                    currentPage = parseInt($(this).text());
                                    displayProducts(currentPage);
                                });
                                paginationContainer.append(pageLink);
                            }

                            paginationContainer.show();
                        }

                        displayProducts(currentPage);
                    } else {
                        tableBody.append($('<tr>').append($('<td colspan="9">').text(response.message)));
                        $('#pagination_product').hide();
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error filtering products:", error);
                    var tableBody = $('#productTableBody');
                    tableBody.empty();
                    try {
                        var errorResponse = JSON.parse(xhr.responseText);
                        tableBody.append($('<tr>').append($('<td colspan="9">').text('An error occurred while filtering the products: ' + errorResponse.message)));
                    } catch (e) {
                        tableBody.append($('<tr>').append($('<td colspan="9">').text('An unexpected error occurred while filtering the products. Please check the server logs.')));
                    }
                    $('#pagination_product').hide();
                }
            });
        });

        // add property
        $('#addPropertyBtn').on('click', function () {
            $('#addPropertyPopup').modal('show');
        });

        $('#cancelPropertyBtn').on('click', function () {
            $('#addPropertyPopup').modal('hide');
        });
        $('#submitPropertyBtn').on('click', function () {
            var property_type = $('#propertyType').val();
            var property_name = $('#propertyName').val();
            $.ajax({
                url: 'php/add_category_tag.php',
                type: 'POST',
                data: { property_type: property_type, property_name: property_name },
                dataType: 'json',
                success: function (response) {
                    if (response.success) {
                        alert(response.message);
                        $('#addPropertyPopup').modal('hide');
                        location.reload();
                    } else {
                        alert('Failed to add property: ' + response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error adding property:", error);
                    alert('An error occurred while adding the property. Please try again.');
                }
            });
        });

        // search product
        let searchTimeout;
        $('#searchProduct').on('keyup', function () {
            clearTimeout(searchTimeout);  // Clear the previous timeout
            var product_name = $(this).val();  // Get the search input value

            searchTimeout = setTimeout(function () {
                if (product_name.length >= 1) {  // Only search if input length is at least 1
                    $.ajax({
                        url: 'php/product_find.php',  // PHP file that handles the search
                        type: 'GET',
                        data: { product_name: product_name },  // Data sent to PHP
                        dataType: 'json',  // Expect JSON response
                        success: function (response) {
                            console.log(response);

                            if (response.status === 'success') {
                                // Display products in table
                                displayProductsInTable(response.products);
                            } else {
                                $('#productTableBody').html('<tr><td colspan="7">No products found</td></tr>');
                            }
                        },
                        error: function (xhr, status, error) {
                            console.error("Error searching products:", error);
                            $('#productTableBody').html('<tr><td colspan="7">Error searching products</td></tr>');
                        }
                    });
                } else {
                    // If input is empty, reload the original product table
                    loadProducts(currentPage);
                }
            }, 300);  // Delay of 300ms
        });

        // Function to display products in table
        function displayProductsInTable(products) {
            let tableBody = $('#productTableBody');
            tableBody.empty();
            products.forEach(function (product) {
                let row = $('<tr>');
                var date = new Date(product.created_date);
                var formattedDate = date.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric' }).replace(/\//g, '/');
                row.append($('<td>').text(formattedDate));

                row.append($('<td>').text(product.title));
                row.append($('<td>').text(product.sku));
                if (product.price === 0 || product.price === '0' || product.price === '0.00' || product.price === 0.00) {
                    row.append($('<td>').text(""));
                } else {
                    row.append($('<td>').text("$" + parseFloat(product.price).toFixed(2)));
                }
                // row.append($('<td>').text('$' + parseFloat(product.price).toFixed(2)));

                row.append($('<td>').html(`<img src="${product.featured_image}"}" style="width: 50px; height: 50px;">`));
                row.append($('<td>').html(`<img src="${product.gallery}"}" style="width: 50px; height: 50px;">`));
                row.append($('<td>').text(product.categories.join(', ')));
                row.append($('<td>').text(product.tags.join(', ')));
                row.append($('<td>').html('<i class="edit icon"></i><i class="trash icon"></i>'));
                tableBody.append(row);
            });
        }
    });

});

document.addEventListener('DOMContentLoaded', function () {
    $(document).ready(function () {
        const urlParams = new URLSearchParams(window.location.search);
        const message = urlParams.get('message');
        const detail = urlParams.get('details');
        if (message) {
            let alertMessage = decodeURIComponent(message);
            if (detail) {
                alertMessage += '\n\n' + decodeURIComponent(detail);
            }
            alert(alertMessage);

            const newUrl = window.location.pathname;
            window.history.replaceState({}, document.title, newUrl);
        }
    });
});
// Category
document.addEventListener('DOMContentLoaded', function () {
    $(document).ready(function () {
        $('.ui.dropdown').dropdown();

        $.ajax({
            url: 'php/category_view.php',
            type: 'GET',
            dataType: 'json',

            success: function (data) {
                var select = $('#Category');
                select.empty();
                $.each(data.categories, function (i, category) {
                    select.append($('<option></option>').val(category.id).text(category.category_name));
                });

                select.dropdown('refresh');
            },
            error: function (xhr, status, error) {
                console.error("Error fetching categories:", error);
            }
        });
    });
});
// Category add product
document.addEventListener('DOMContentLoaded', function () {
    $(document).ready(function () {
        $('#AddProductCategory').dropdown({
            placeholder: 'Categories'
        });
        $.ajax({
            url: 'php/category_view.php',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                var select = $('#AddProductCategory');
                select.empty();
                $.each(data.categories, function (i, category) {
                    select.append($('<option></option>').val(category.id).text(category.category_name));
                });
                select.dropdown('refresh');
            },
            error: function (xhr, status, error) {
                console.error("Error fetching categories:", error);
            }
        });
    });
});
// tag
document.addEventListener('DOMContentLoaded', function () {
    $(document).ready(function () {
        $('#Tag').dropdown({
            placeholder: 'Tags'
        });
        $.ajax({
            url: 'php/tag_view.php',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                var select = $('#Tag');
                select.empty();
                $.each(data.tags, function (i, tag) {
                    select.append($('<option></option>').val(tag.id).text(tag.tag_name));
                });

                select.dropdown('refresh');
            },
            error: function (xhr, status, error) {
                console.error("Error fetching tags:", error);
            }
        });
    });
});
// tag add product
document.addEventListener('DOMContentLoaded', function () {
    $(document).ready(function () {
        $('#AddProductTag').dropdown({
            placeholder: 'Tags'
        });
        $.ajax({
            url: 'php/tag_view.php',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                var select = $('#AddProductTag');
                select.empty();
                $.each(data.tags, function (i, tag) {
                    select.append($('<option></option>').val(tag.id).text(tag.tag_name));
                });
                select.dropdown('refresh');
            },
            error: function (xhr, status, error) {
                console.error("Error fetching tags:", error);
            }
        });
    });
});



// Product
document.addEventListener('DOMContentLoaded', function () {
    $('#cancelEditBtn').on('click', function () {
        $('#editProductPopup').modal('hide');
    });
    $('#productTableBody').on('click', '.editIcon', function () {
        $('#editProductPopup').modal('show');
    });

    $(document).ready(function () {
        let currentPage = 1;
        const limit = 5;

        function loadProducts(page) {
            $.ajax({
                url: 'php/product_view.php',
                type: 'GET',
                dataType: 'json',
                data: { page: page },
                success: function (data) {
                    
                    const tableBody = $('#productTableBody');
                    tableBody.empty();
                    $.each(data.products, function (i, product) {
                        var row = $('<tr>');
                        var date = new Date(product.created_date);
                        var formattedDate = date.toLocaleDateString('vi-VN', { day: '2-digit', month: '2-digit', year: 'numeric' }).replace(/\//g, '/');
                        row.append($('<td>').text(product.id).css('display', 'none'));
                        row.append($('<td>').text(formattedDate));
                        row.append($('<td>').text(product.title));
                        row.append($('<td>').text(product.sku));
                        if (product.sale_price !== null && product.sale_price !== 0.00 && product.sale_price !== '0.00' && product.sale_price !== '0') {
                            row.append($('<td>').text("$" + parseFloat(product.sale_price).toFixed(2)));
                        } else if (product.price === 0 || product.price === '0' || product.price === '0.00' || product.price === 0.00) {
                            row.append($('<td>').text(""));
                        } else {
                            row.append($('<td>').text("$" + parseFloat(product.price).toFixed(2)));
                        }

                        if (product.featured_image) {
                            var featuredImage = $('<img>').attr('src', product.featured_image.replace('../', '')).css({
                                'width': '30px',
                                'height': '30px',
                                'object-fit': 'cover',
                                // 'border-radius': '5px'
                            });
                            row.append($('<td>').html(featuredImage));
                        } else {
                            row.append($('<td>').text('No img'));
                        }

                        var galleryImages = product.gallery ? product.gallery.replace('../', '').split(',') : [];
                        var firstGalleryImage = galleryImages[0];

                        if (firstGalleryImage) {
                            var galleryImage = $('<img>').attr('src', firstGalleryImage).css({
                                'width': '30px',
                                'height': '30px',
                                'object-fit': 'cover'
                            });
                            row.append($('<td>').html(galleryImage));
                        } else {
                            row.append($('<td>').text('No img'));
                        }

                        row.append($('<td>').text(product.categories).css('max-width', '100px').css('white-space', 'nowrap').css('overflow', 'hidden').css('text-overflow', 'ellipsis'));
                        row.append($('<td>').text(product.tags).css('max-width', '100px').css('white-space', 'nowrap').css('overflow', 'hidden').css('text-overflow', 'ellipsis'));
                        row.append($('<td>').html('<i class="edit icon editIcon"></i><i class="trash icon trashIcon"></i>'));
                        tableBody.append(row);
                    });

                    updatePagination(data.total);
                },
                error: function (xhr, status, error) {
                    console.error("Error fetching products:", error);
                }
            });
        }

        function updatePagination(total) {
            const totalPages = Math.ceil(total / limit);
            const paginationMenu = $('.pagination.menu');
            paginationMenu.empty();

            paginationMenu.append('<a class="item" href="#" id="prevBtn"><i class="arrow left icon"></i></a>');

            for (let i = 1; i <= totalPages; i++) {
                paginationMenu.append('<a class="item' + (i === currentPage ? ' active' : '') + '" href="#">' + i + '</a>');
            }

            paginationMenu.append('<a class="item" href="#" id="nextBtn"><i class="arrow right icon"></i></a>');

            paginationMenu.find('.item').click(function (e) {
                e.preventDefault();
                const targetPage = $(this).text();
                if ($(this).is('#prevBtn')) {
                    if (currentPage > 1) {
                        currentPage--;
                        loadProducts(currentPage);
                    }
                } else if ($(this).is('#nextBtn')) {
                    if (currentPage < totalPages) {
                        currentPage++;
                        loadProducts(currentPage);
                    }
                } else {
                    currentPage = parseInt(targetPage);
                    loadProducts(currentPage);
                }
            });
        }

        loadProducts(currentPage);
    });

});



// Edit product
document.addEventListener('DOMContentLoaded', function () {
    // category edit product
    $(document).ready(function () {
        $('#EditProductCategory').dropdown({
            placeholder: 'Categories'
        });
        $.ajax({
            url: 'php/category_view.php',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                var select = $('#EditProductCategory');
                select.empty();
                $.each(data.categories, function (i, category) {
                    select.append($('<option></option>').val(category.id).text(category.category_name));
                });
                select.dropdown('refresh');
            },
            error: function (xhr, status, error) {
                console.error("Error fetching categories:", error);
            }
        });
    });
    // tag edit product
    $(document).ready(function () {
        $('#EditProductTag').dropdown({
            placeholder: 'Tags'
        });
        $.ajax({
            url: 'php/tag_view.php',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                var select = $('#EditProductTag');
                select.empty();
                $.each(data.tags, function (i, tag) {
                    select.append($('<option></option>').val(tag.id).text(tag.tag_name));
                });
                select.dropdown('refresh');
            },
            error: function (xhr, status, error) {
                console.error("Error fetching tags:", error);
            }
        });
    });
    // edit add information product
    $(document).ready(function () {
        $('#productTableBody').on('click', '.editIcon', function () {
            var sku = $(this).closest('tr').find('td:nth-child(3)').text();

            // Reset form
            $('#EditProductForm')[0].reset();
            $('#EditProductCategory').dropdown('clear');
            $('#EditProductTag').dropdown('clear');

            // Hide image previews by default
            $('#EditProductFeaturedImagePreview').hide();
            $('#EditProductGalleryPreview').empty();

            $.ajax({
                url: 'php/product_edit.php',
                type: 'GET',
                dataType: 'json',
                data: { id: $(this).closest('tr').find('td:first-child').text() },
                success: function (data) {
                    if (data.status === 'success') {

                        var product = data.product;

                        // Populate the edit form with product details
                        $('#EditProductID').val(product.id);
                        $('#EditProductName').val(product.title);
                        $('#EditProductSKU').val(product.sku);
                        $('#EditProductPrice').val(product.price);
                        $('#EditProductSalePrice').val(product.sale_price);

                        // Set featured image preview if it exists
                        if (product.featured_image) {
                            $('#EditProductFeaturedImagePreview')
                                .attr('src', product.featured_image.replace('../', ''))
                                .show();
                        }

                        // Add event listener for new image selection
                        $('#EditProductFeaturedImage').on('change', function (e) {
                            var file = e.target.files[0];
                            if (file) {
                                var reader = new FileReader();
                                reader.onload = function (e) {
                                    $('#EditProductFeaturedImagePreview')
                                        .attr('src', e.target.result)
                                        .show();
                                };
                                reader.readAsDataURL(file);
                            }
                        });

                        // Handle gallery images

                        function createGalleryImage(imagePath) {
                            var imgContainer = $('<div>', {
                                class: 'gallery-image-container',
                                style: 'display: inline-block; position: relative; margin: 5px;'
                            });

                            var imgElement = $('<img>', {
                                src: imagePath.replace('../', '').trim(),
                                style: 'max-width: 100px; max-height: 100px;'
                            });

                            imgContainer.append(imgElement);
                            return imgContainer;
                        }

                        // Populate existing gallery image
                        if (product.gallery && product.gallery.length > 0) {
                            var imagePath = product.gallery[0];
                            if (imagePath) {
                                $('#EditProductGalleryPreview').empty().append(createGalleryImage(imagePath));
                            }
                        }

                        // Add event listener for new gallery image
                        $('#EditProductGalleryImage').off('change').on('change', function (e) {
                            var file = e.target.files[0];
                            if (file) {
                                var reader = new FileReader();
                                reader.onload = function (e) {
                                    $('#EditProductGalleryPreview').empty().append(createGalleryImage(e.target.result));
                                };
                                reader.readAsDataURL(file);
                            }
                        });


                        // Set selected categories and tags
                        $('#EditProductCategory').dropdown('set selected', product.category_ids);
                        $('#EditProductTag').dropdown('set selected', product.tags);


                    } else {
                        alert('Product not found.');
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error fetching product details:", error);
                }
            });
        });


    });
});




// delete product
document.addEventListener('DOMContentLoaded', function () {
    $('#productTableBody').on('click', '.trashIcon', function () {
        var id = $(this).closest('tr').find('td:first-child').text();
        if (confirm('Confirm delete this product?')) {
            $.ajax({
                url: 'php/product_delete.php',
                type: 'POST',
                data: { id: id },
                success: function (data) {
                    var response = JSON.parse(data);
                    if (response.status === 'success') {
                        alert(response.message);
                        location.reload();
                    } else {
                        alert(response.message);
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error deleting product:", error);
                    alert('An error occurred while deleting the product. Please try again.');
                }
            });
        }
    });
});


document.addEventListener('DOMContentLoaded', function () {
    let processedProducts = new Set();
    const PRODUCTS_PER_BATCH = 5;
    let currentPage = 1;
    let totalNewProducts = 0;

    $('#syncVillaThemeBtn').on('click', function () {
        $(this).text('Syncing...').prop('disabled', true);
        processedProducts.clear();
        totalNewProducts = 0;
        fetchProducts('https://villatheme.com/extensions/');
    });

    function fetchProducts(url) {
        $.ajax({
            url: 'php/proxy.php',
            type: 'GET',
            data: { target: url },
            dataType: 'html',
            success: function (data) {
                var $html = $(data);
                var $products = $html.find('.product');
                var productLinks = $products.map(function() {
                    return $(this).find('.woocommerce-loop-product__title a').attr('href');
                }).get();

                processProducts(productLinks, 0);
            },
            error: function(xhr, status, error) {
                console.log('Error fetching page:', error);
                updateSyncButton();
            }
        });
    }

    function processProducts(productLinks, index) {
        if (index < productLinks.length && totalNewProducts < PRODUCTS_PER_BATCH) {
            processProduct(productLinks[index], function(isNewProduct) {
                if (isNewProduct) {
                    totalNewProducts++;
                }
                processProducts(productLinks, index + 1);
            });
        } else {
            updateSyncButton();
            location.reload();
        }
    }

    function processProduct(productUrl, callback) {
        $.ajax({
            url: 'php/product_detal_villa.php',
            type: 'GET',
            data: { url: productUrl },
            dataType: 'json',
            success: function (productData) {
                
                if (processedProducts.has(productData.sku)) {
                    console.log('Product already processed:', productData.title);
                    callback(false);
                    return;
                }

                var dataToSave = {
                    title: productData.title,
                    sku: productData.sku,
                    price: productData.price,
                    sale_price: productData.sale_price,
                    featured_image: productData.featured_image,
                    gallery: productData.gallery,
                    category: productData.category,
                    tags: productData.tags
                };

                $.ajax({
                    url: 'php/product_save_villa.php',
                    type: 'POST',
                    data: JSON.stringify(dataToSave),
                    contentType: 'application/json',
                    success: function(response) {
                        try {
                            // Remove any HTML warnings from the response
                            var cleanResponse = response.replace(/<br \/>\s*<b>Warning<\/b>:.*?<br \/>/gs, '');
                            var result = JSON.parse(cleanResponse);
                            
                            if (result.status === 'success') {
                                if (result.is_new_product) {
                                    processedProducts.add(productData.sku);
                                    console.log('New product added:', result.message);
                                    callback(true);
                                } else {
                                    console.log('Product updated:', result.message);
                                    callback(false);
                                }
                            } else {
                                console.log('Product not saved:', result.message);
                                callback(false);
                            }
                        } catch (e) {
                            console.error('Error parsing response:', e);
                            console.error('Raw response:', response);
                            callback(false);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error saving product:', error);
                        console.error('Response text:', xhr.responseText);
                        callback(false);
                    }
                });
            },
            error: function(xhr, status, error) {
                console.error('Error fetching product details:', error);
                console.error('Response text:', xhr.responseText);
                callback(false);
            }
        });
    }

    function updateSyncButton() {
        $('#syncVillaThemeBtn').text('Sync VillaTheme').prop('disabled', false);
    }
});
