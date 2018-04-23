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
//= require jquery3
//= require jquery-ui
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets


$(document).on('turbolinks:load', function(){
  // Hide all these things on page load
  $('.alert').delay(5000).fadeOut(2000);
  $('#document_child_assent_file').hide();
  $('#child_assent_label').hide();
  $('#chair-comment').hide();
  $('#boardSearch').hide();
  $('#boardSearch2').hide();

  // When you click these various divs and ids, show other divs and ids
  $('#edit-chair-comment').click(function() {
    $('#chair-comment').toggle(500);
  });
  $('#searchButton').click(function() {
    $('#boardSearch').toggle(500);
  });

  $('#searchButton2').click(function() {
    $('#boardSearch2').toggle(500);
  });


  $('#yesMinors').on('change', function() {
    $('#document_child_assent_file').show(500);
    $('#child_assent_label').show(500);
  });

  $('#noMinors').on('change', function() {
    $('#document_child_assent_file').hide(500);
    $('#child_assent_label').hide(500);
  });

  $('.check').on('change', function() {
    $('#document_child_assent_file').show(500);
    $('#child_assent_label').show(500);
  });

  $('#showCheck').click(function() {
    $('.checkLabel').toggle('slow', function() {
      // Animation complete.
    });
    $('.assignCombo').show(500);
    $('#assignBtn').toggle('slow', function() {
      // Animation complete.
    });
  });
  // This was removed but is still here incase we need a check all feature
  $("#checkAll").click(function(){
    $('input:checkbox').not(this).prop('checked', this.checked);
  });
  // Grab stuff from the autocomplete and put them in these divs
  $("#user_search").autocomplete({
      appendTo: "#suggestions-container",
      source: "/users/autocomplete"
  });
  $("#user_search2").autocomplete({
      appendTo: "#suggestions-container2",
      source: "/users/autocomplete"
  });
});
