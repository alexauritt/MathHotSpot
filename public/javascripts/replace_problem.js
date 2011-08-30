MHS.Worksheet.Util = {
	getWorksheetID: function() { return parseInt($('div.worksheet').attr('id').match(/[0-9]+/)); },
}

MHS.Routes = {
	Worksheets: {
		update: function(worksheet_id) { return '/worksheets/' + worksheet_id; }
	},
	Tags: {
	  index: function() { return '/tags/'; }
	}
}

$(function() {
  $('input.replace_problem_submit').throbber('click', {'image':"/images/throbber.gif"} );
	$('.replace_problem_form').live('submit', function() {
		var worksheet_id = MHS.Worksheet.Util.getWorksheetID();
		var problemNumber = $(this).attr('id').match(/\d+/)[0];
		$.ajax({ url: MHS.Routes.Worksheets.update(worksheet_id), type: "PUT", data: {'problem_number':problemNumber} });
		return false;
	});
});