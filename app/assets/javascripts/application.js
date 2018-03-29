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
//= require typeahead
//= require_tree .
//= require bootstrap-sprockets
//= require jquery3

var ready;
ready = function() {
    var engine = new Bloodhound({
        datumTokenizer: function(d) {
            console.log(d);
            return Bloodhound.tokenizers.whitespace(d.title);
        },
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: '../users/autocomplete?query=%QUERY',
            wildcard: '%QUERY'
        }
    });

    var promise = engine.initialize();

    promise
        .done(function() { console.log('success!'); })
        .fail(function() { console.log('err!'); });

    $('#user_search').typeahead(null, {
        name: 'engine',
        displayKey: 'title',
        source: engine.ttAdapter()
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);

$(document).on('turbolinks:load', function(){
  $('.alert').delay(5000).fadeOut(2000);
  $('#document_child_assent_file').hide();
  $('#child_assent_label').hide();
  $('#chair-comment').hide();
  $('#boardSearch').hide();


  $('#edit-chair-comment').click(function() {
    $('#chair-comment').toggle(500);
  });
  $('#searchButton').click(function() {
    $('#boardSearch').toggle(500);
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

  $("#checkAll").click(function(){
    $('input:checkbox').not(this).prop('checked', this.checked);
  });
});
