// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var MHS = {
	Worksheet: {}
}

$(function() {
	jQuery.ajaxSetup({ 
	  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript");}
	})
});
