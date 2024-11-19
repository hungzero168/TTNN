$(document).ready(function () {
    $(".example-form").hide();

    // Lấy dữ liệu từ localStorage và hiển thị
    var formData = localStorage.getItem("formData");
    if (formData) {
        formData = $.parseJSON(formData);
        displayFormData(formData);
    }

    function displayFormData(data) {
        $(".form-preview").empty();
        data.forEach(function (field) {
            var newForm = $(".example-form ." + field.formClass).clone();
            if (field.formClass === "form-field") {
                newForm.find("#type").val(field.type);
                newForm.find("#label").val(field.label);
                newForm.find("#name").val(field.name);
                newForm.find("#id").val(field.id);
                newForm.find("#placeholder").val(field.placeholder).attr("type", field.type);
                newForm.find("#require").prop("checked", field.require === "on");
            } else if (field.formClass === "form-textarea-field") {
                newForm.find("#textarea-label").val(field.label);
                newForm.find("#textarea-name").val(field.name);
                newForm.find("#textarea-id").val(field.id);
                newForm.find("#textarea-placeholder").val(field.placeholder);
                newForm.find("#textarea-require").prop("checked", field.require === "on");
            } else if (field.formClass === "form-button-field") {
                newForm.find("#button-label").val(field.label);
                newForm.find("#button-name").val(field.name);
                newForm.find("#button-id").val(field.id);
            }
            $(".form-preview").append(newForm).show();
        });
    }

    function addNewForm(formClass) {
        var newForm = $(".example-form " + formClass).clone();
        newForm.find("input").val("");
        newForm.find("input[type='checkbox']").prop("checked", false);
        $(".form-preview").append(newForm).show();
    }

    $(".btn-add-input-field").on("click", function () {
        addNewForm(".form-field");
    });

    $(".btn-add-textarea-field").on("click", function () {
        addNewForm(".form-textarea-field");
    });

    $(".btn-add-button-field").on("click", function () {
        addNewForm(".form-button-field");
    });

    $(".btn-reset-form").on("click", function () {
        $(".form-preview").empty().hide();
        $(".form-container").show();
        localStorage.removeItem("formData");
    });

    $(document).on("click", ".close-button", function () {
        $(this).closest(".form-field, .form-textarea-field, .form-button-field").remove();
        if ($(".form-preview").children().length === 0) {
            $(".form-preview").hide();
        }
    });

    $(".form-preview").sortable({
        cursor: "move",
        containment: ".form-preview",
        handle: ".form-field-header",
        helper: "clone",
        appendTo: ".form-preview",
        forceHelperSize: true, // Force the helper to be the same size as the form item
        forcePlaceholderSize: true,
        scroll: true,
        scrollSensitivity: 100,
        scrollSpeed: 20,
        tolerance: "pointer",

        start: function (event, ui) {
            ui.item.addClass("dragging");
            ui.placeholder.height(ui.item.height());
            ui.placeholder.css({
                "background-color": "#f0f0f0",
                "border": "1px dashed #ccc"
            });
        },

        stop: function (event, ui) {
            ui.item.removeClass("dragging");
        }
    });




    $(".btn-save-form").on("click", function () {
        var isValid = true;
        var formData = [];
        if ($(".form-preview").children().length === 0) {
            alert("Null");
            return false;
        }
        $(".form-preview .form-field:visible, .form-preview .form-textarea-field:visible, .form-preview .form-button-field:visible").each(function () {
            var inputs = $(this).find('input[type!="checkbox"], textarea, select');
            inputs.each(function () {
                if ($(this).val().trim() === "" || $(this).val().trim() === null) {
                    isValid = false;
                    return false;
                }
            });
            if (!isValid) return false;
        });

        if (isValid) {
            $(".form-preview .form-field, .form-preview .form-textarea-field, .form-preview .form-button-field").each(function () {
                var fieldData = {
                    formClass: $(this).attr("class")
                };
                if ($(this).hasClass("form-field")) {
                    fieldData.type = $(this).find("select#type").val();
                    fieldData.label = $(this).find("input#label").val();
                    fieldData.name = $(this).find("input#name").val();
                    fieldData.id = $(this).find("input#id").val();
                    fieldData.placeholder = $(this).find("input#placeholder").val();
                    fieldData.require = $(this).find("input#require").prop("checked") ? "on" : "off";
                } else if ($(this).hasClass("form-textarea-field")) {
                    fieldData.label = $(this).find("input#textarea-label").val();
                    fieldData.name = $(this).find("input#textarea-name").val();
                    fieldData.id = $(this).find("input#textarea-id").val();
                    fieldData.placeholder = $(this).find("input#textarea-placeholder").val();
                    fieldData.require = $(this).find("input#textarea-require").prop("checked") ? "on" : "off";
                } else if ($(this).hasClass("form-button-field")) {
                    fieldData.label = $(this).find("input#button-label").val();
                    fieldData.name = $(this).find("input#button-name").val();
                    fieldData.id = $(this).find("input#button-id").val();
                }
                formData.push(fieldData);
            });

            localStorage.setItem("formData", JSON.stringify(formData));
            alert("Đã lưu!");
        } else {
            alert("điền đầy đủ thông tin!");
        }
    });

    $(document).on("change", "#type", function () {
        var type = $(this).val();
        var placeholderInput = $(this).closest('.form-field').find('#placeholder');
        placeholderInput.attr("type", type);
    });
});