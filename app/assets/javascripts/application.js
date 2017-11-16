// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require jquery3
$(document).on('turbolinks:load', function(){
  $('.alert').delay(2000).fadeOut(2000);
  $('#document_risks_label').hide();
  $('#document_risks').hide();
  $('#document_child_assent_file').hide();
  $('#child_assent_label').hide();

  $('#yesRisks').on('change', function() {
    $('#document_risks_label').show(500);
    $('#document_risks').show(500);
  });
  $('#noRisks').on('change', function() {
    $('#document_risks_label').hide(500);
    $('#document_risks').hide(500);
  });
  $('#yesMinors').on('change', function() {
    $('#document_child_assent_file').show(500);
    $('#child_assent_label').show(500);
  });
  $('#noMinors').on('change', function() {
    $('#document_child_assent_file').hide(500);
    $('#child_assent_label').hide(500);
  });
});
