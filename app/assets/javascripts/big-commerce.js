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
	}
};