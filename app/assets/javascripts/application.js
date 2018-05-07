//= require jquery
//= require rails-ujs
//= require Chart.min
//= require materialize-sprockets
//= require materialize-form
//= require vue
//= require_tree .


// $( document ).ready(function () {
//     $('select').material_select();
//     $('.datepicker').pickadate({
//     format: 'mmmm dd, yyyy',
//     formatSubmit: 'mmmm dd, yyyy',
//     selectMonths: true, // Creates a dropdown to control month
//     selectYears: 15, // Creates a dropdown of 15 years to control year,
//     today: 'Today',
//     clear: 'Clear',
//     close: 'Ok',
//     closeOnSelect: false // Close upon selecting a date,
//   });
// });
// Flash fade
$(function() {
   $('.alert-box').fadeIn('normal', function() {
      $(this).delay(3700).fadeOut();
   });
});

// Sticky footer js
// Thanks to Charles Smith for this -- http://foundation.zurb.com/forum/posts/629-sticky-footer
$(window).bind("load", function () {
  var footer = $("#footer");
  var pos = footer.position();
  var height = $(window).height();
  height = height - pos.top;
  height = height - footer.height();
  if (height > 0) {
      footer.css({
          'margin-top': height + 'px'
      });
  }
});

// Search submit on enter
$(document).ready(function() {
  function submitForm() {
    document.getElementById("search").submit();
  }
  document.onkeydown = function () {
    if (window.event.keyCode == '13') {
        submitForm();
    }
  }
   $(".dropdown-button").dropdown();
  $( "#search-area" )
    .mouseenter(function() {
      $('#search').delay( 500 ).fadeIn( 600 );
      $("#search").css("background-color", "#eaebed");
      $("#search-section").css("background-color", "#eaebed");
    })
    .mouseleave(function() {
    $("#search-section").css("background-color", "#fff");
    $('#search').delay( 500 ).fadeOut( 400 );
    $("#search").css("background-color", "#fff");
  });
});
