// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

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
