BigCommerce = {};

BigCommerce.Template = {
	NewTemplate : function() {
		$(document).ready(function() {
			// Initialize summernote plugin
			$('#summernote').summernote({
				placeholder : 'Write body here...'
			});

			// Onload set the default value to the template_body
			$("#template_body").val($('#summernote').code());

			var selected = $("#template_event_type_id option:selected").text();
			console.log(selected)
			if ($(selected && $("#template_event_id option:selected").text() == 'order' && "#template_event_type_id option:selected").text() == 'order created') {
				$('#summernote').code($("#default-template-body-order").html());
				$("#template_body").val($('#summernote').code())
				console.log('test488')
			} else if($(selected && $("#template_event_id option:selected").text() == 'shipment' && "#template_event_type_id option:selected").text() == 'shipment created') {
				$('#summernote').code($("#default-template-body-shipment").html());
				$("#template_body").val($('#summernote').code())
				console.log('test45')
			}else{
				$('#summernote').code("<p>Default template will be displayed soon once you select event and event type</p>")
				$("#template_body").val($('#summernote').code())
				console.log('test44')
			}

			// summernote.change
			$('.note-editable').on('keyup', function() {
				$("#template_body").val($('#summernote').code());
			});
			$("#template_event_type_id").on('change', function() {
				var selected = $("#template_event_type_id option:selected").text();
				console.log(selected)
				if (selected && $("#template_event_id option:selected").text() == 'order' && $("#template_event_type_id option:selected").text() == 'order created') {
					console.log('test1')
					$('#summernote').code($("#default-template-body-order").html());
					$("#template_body").val($('#summernote').code())
				} else if( selected && $("#template_event_id option:selected").text() == 'shipment' && $("#template_event_type_id option:selected").text() == 'shipment created'){
					console.log('test2')
					$('#summernote').code($("#default-template-body-shipment").html());
					$("#template_body").val($('#summernote').code())
				}else{
					console.log('test3')
					$('#summernote').code("<p>Default template will be displayed soon once you select event and event type</p>");
					$("#template_body").val($('#summernote').code())
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
