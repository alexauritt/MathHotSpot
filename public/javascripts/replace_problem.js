MHS.Worksheet.Replacer = {
	getWorksheetID: function() { return parseInt($('div.worksheet').attr('id').match(/[0-9]+/)); },
}

MHS.Routes = {
	WorksheetProblemReplacer: {
	  create: function() { return '/worksheet_problem_replacer';}
	},
	Tags: {
	  index: function() { return '/tags/'; }
	}
}

$(function() {
  $('input.replace_problem_submit').throbber('click', {'image':"/images/throbber.gif"} );
  $('.replace_problem_form').live('submit', function() {
    var worksheet_id = MHS.Worksheet.Replacer.getWorksheetID();
    var problemNumber = $(this).attr('id').match(/\d+/)[0];
    $.ajax({ url: MHS.Routes.WorksheetProblemReplacer.create(), type: "POST", data: {'worksheet_problem_replacer[problem_number]':problemNumber, 'worksheet_problem_replacer[worksheet_id]':worksheet_id} });
    return false;
   });
});