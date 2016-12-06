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
//= require turbolinks
//= require ckeditor/init
//= require_tree .

$(document).ready(function() {
  $("#active_store_template_email_type_id").on('change', function(){
    if($("#active_store_template_email_type_id option:selected").text() == 'order'){
    	$("#template-selection-area-order").show();
    	$("#template-selection-area-shipment").hide();
    }else{
    	$("#template-selection-area-order").hide();
    	$("#template-selection-area-shipment").show();
    }
  });
});

