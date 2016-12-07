// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require moment
//= require jquery.slimscroll.min
//= require bootstrap.min
//= require jquery.easing.min
//= require bootstrap-clockpicker.min
//= require bootstrap-datepicker.min
//= require bootstrap-datetimepicker.min
//= require bootstrap-editable.min
//= require jquery.flot
//= require jquery.flot.pie
//= require jquery.flot.resize
//= require homer
//= require jquery.bootstrap-touchspin.min
//= require index
//= require metisMenu.min
//= require icheck.min
//= require summernote.min

$(document).ready(function() {
  $("#active_store_template_email_type_id").on('change', function(){
    if($("#active_store_template_email_type_id option:selected").text() == 'order'){
    	console.log("order");
    	$("#template-selection-area-order").show();
    	$("#template-selection-area-order-label").show();
    	$("#template-selection-area-shipment").hide();
    	$("#template-selection-area-shipment-label").hide();
    }else{
    	console.log("shipment");
    	$("#template-selection-area-order").hide();
    	$("#template-selection-area-order-label").hide();
    	$("#template-selection-area-shipment").show();
    	$("#template-selection-area-shipment-label").show();
    }
  });
});

