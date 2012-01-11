// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_self
//= require_tree .

(function($) {
  $.fn.displayErrorMsg = function(msg) {
    var error = $('div.error_display', this);
    $('div.problem_links', this).hide();
    $('div.error_display', this).html(msg).fadeIn(MHS.Worksheet.errorFadeInTime, this.hideErrorMsg);
  };
  $.fn.hideErrorMsg = function() {
    $(this).delay(MHS.Worksheet.errorHideDelay).fadeOut('slow', function() {
      $('div.problem_links', $(this).parent()).show();
    });
  };
})(jQuery);

var MHS = {
	Worksheet: {
	  errorFadeInTime: 'fast',
	  errorHideDelay: 1500
	}
}

$(function() {
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
	})
});
