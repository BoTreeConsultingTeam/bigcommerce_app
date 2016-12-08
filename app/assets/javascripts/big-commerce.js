BigCommerce = {};

BigCommerce.Template = {
	NewTemplate : function() {
		$(document).ready(function() {
			// Initialize summernote plugin
			$('#summernote').summernote({
				placeholder : 'Write body here...'
			});

			// Onload set the default value to the template_body
			$("#template_body").val($('.summernote').code());

			// summernote.change
			$('.note-editable').on('keyup', function() {
				$("#template_body").val($('#summernote').code());
			});
			$("#template_email_type_id").on('change', function() {
				var selected = $("#template_email_type_id option:selected").text();
				if ($("#template_email_type_id option:selected").text() == 'order') {
					$('#summernote').code($("#default-template-body-order").html());
				} else {
					$('#summernote').code($("#default-template-body-shipment").html());
				}
			});
		});
	},

	NewActiveTemplate : function() {
		$(document).ready(function() {
			$("#active_store_template_email_type_id").on('change', function() {
				if ($("#active_store_template_email_type_id option:selected").text() == 'order') {
					$("#template-selection-area-order").show();
					$("#template-selection-area-order-label").show();
					$("#template-selection-area-shipment").hide();
					$("#template-selection-area-shipment-label").hide();
				} else {
					$("#template-selection-area-order").hide();
					$("#template-selection-area-order-label").hide();
					$("#template-selection-area-shipment").show();
					$("#template-selection-area-shipment-label").show();
				}
			});
		});

		$(document).ready(function() {
			$("#template_id").val($('#active_store_template_order_template_id option:selected').val());

			$("#active_store_template_email_type_id").on('change', function() {
				if ($("#active_store_template_email_type_id option:selected").text() == 'order') {
					$("#template_id").val($('#active_store_template_order_template_id option:selected').val());
					console.log($("#template_id").val());
				} else {
					console.log("shipment");
					$("#template_id").val($('#active_store_template_shipment_template_id option:selected').val());
					console.log($("#template_id").val());
				}
			});

			$("#active_store_template_order_template_id").on('change', function() {
				console.log("test" + this);
			});

			$("#active_store_template_shipment_template_id").on('change', function() {
				var current_val = $('active_store_template_shipment_template_id option:selected').val();
				console.log("test" + current_val);
				$("#template_id").val(current_val);
			});
		});
	}
};