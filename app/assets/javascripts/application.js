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
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require jquery3
$(document).on('turbolinks:load', function(){
  $('.alert').delay(5000).fadeOut(2000);
  $('#document_child_assent_file').hide();
  $('#child_assent_label').hide();

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

  $('#addChairSearch').click(function() {
    $('#addChairSearch').show(500);
  });

  $('#addBoardSearch').click(function() {
    $('#addBoardSearch').show(500);
  })

  $('#removeChairSearch').click(function() {
    $('#removeChairSearch').show(500);
  });

  $('#removeBoardSearch').click(function() {
    $('#removeBoardSearch').show(500);
  })

    $('.assignCombo').show(500);
    $('#assignBtn').toggle('slow', function() {
      // Animation complete.
    });
  });

  $("#checkAll").click(function(){
    $('input:checkbox').not(this).prop('checked', this.checked);
  });
});
