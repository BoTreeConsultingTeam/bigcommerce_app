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

	InsertAtCaretPosition: function(){
		$(document).ready(function(){
	    $("#template_variables").on('click', function() {
	        insertTextAtCursor($(this).val());
	    });
	  });

	  function insertTextAtCursor(text) {
	    var sel, range, html;
	    if (window.getSelection) {
	        sel = window.getSelection();
	        if (sel.getRangeAt && sel.rangeCount) {
	        	  console.log("inside if");
	            range = sel.getRangeAt(0);
	            range.deleteContents();
	            element_class = $(range.startContainer.parentElement).closest('div[data-gramm_editor="true"]').attr('class');
	            console.log(element_class);
	            if (element_class == 'note-editable'){
	            	range.insertNode( document.createTextNode(text) );
	            }
	        }
	    } else if (document.selection && document.selection.createRange) {
	        document.selection.createRange().text = text;
	    }
		}
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
			$("#template_id").val($('#active_store_template_order_template_id option:selected').val());

			$("#active_store_template_email_type_id").on('change', function() {
				if ($("#active_store_template_email_type_id option:selected").text() == 'order') {
					$("#template_id").val($('#active_store_template_order_template_id option:selected').val());
				} else {
					$("#template_id").val($('#active_store_template_shipment_template_id option:selected').val());
				}
			});

			$("#active_store_template_order_template_id").on('change', function() {

				var current_val = $('#active_store_template_order_template_id option:selected').val();
				$("#template_id").val(current_val);
			});

			$("#active_store_template_shipment_template_id").on('change', function() {
				var current_val = $('#active_store_template_shipment_template_id option:selected').val();
				$("#template_id").val(current_val);
			});
		});
	}
};
