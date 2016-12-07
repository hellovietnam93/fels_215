// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  if ($('#duration_lesson').length) {
    initCountdown();
    if ((typeof $counter) !== 'undefined') {
      clearInterval($counter);
    }
    $counter = setInterval(countdown, 1000);
  }

  $('input:radio').change(function(){
    $('#number-select').html($(":radio:checked").length);
  });
});

function initCountdown() {
  $duration = parseInt($('#duration_lesson').attr('value'));
  $minutes = Math.floor($duration/60);
  $seconds = $duration - $minutes*60;
}

function countdown() {
  $('#lesson-countdown').html($minutes + ' : ' + $seconds);
  $seconds--;
  if ($seconds <= -1) {
    if ($minutes <= 0) {
      clearInterval($counter);
      $('form').submit();
    }
    $seconds = 59;
    $minutes--;
  }
}
