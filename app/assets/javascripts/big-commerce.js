BigCommerce = {};

BigCommerce.Template = {
	NewTemplate : function() {
		$(document).ready(function() {
			$('.event_type_id').on('change', function(){
			})
		});
	},

	InsertAtCaretPosition: function(){
		$(document).ready(function(){
	    $("#template_variables").on('click', function() {
	        insertTextAtCursor($(this).val());
	        $("#template_body").val($('#summernote').code());
	    });
	  });

	  function insertTextAtCursor(text) {
    var sel, range, html;
		    if (document.getSelection) {
		        sel = document.getSelection();
		        if (sel.getRangeAt && sel.rangeCount) {
		            range = sel.getRangeAt(0);
		            range.deleteContents();
		            element_class = range.startContainer.parentNode.closest('div.note-editable').className;
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
