MHS.Worksheet.ReplaceProblem = {
	// setupReplaceButtons: function() {
	// 	$('input.replace_problem').click(function(e) {
	// 		e.preventDefault();
	// 		var worksheet_id = MHS.Worksheet.Util.getWorksheetID();
	// 		var problemNumber = MHS.Worksheet.ReplaceProblem.getProblemNumber(this.id)[0];
	// 		var response = $.ajax({
	// 			url: MHS.Routes.Worksheets.update(worksheet_id),
	// 			type: "PUT",
	// 			data: ({ 'problem_number': problemNumber }),
	// 			success: MHS.Worksheet.ReplaceProblem.insertResponse 
	// 		});
	// 	});
	// },
	// insertResponse: function(response, status, xhr) {
	// 	var targetID = $(response).find('div.worksheet_problem').attr('id');
	// 	$('div#' + targetID).html('new stuff here');
	// 	var d = $(response).find('div.worksheet_problem');
	// 	console.log("d is " + d);
		// // console.log("d is " + MHS.Worksheet.Util.getNumberFromID(d.attr('id')));
		// MHS.Worksheet.Util.problem(7).html("DJDJD");
	// },
	// getProblemNumber: function(elem) { return elem.match(/\d/); },
	// extractDatabaseIDFromDivID: function(divID) { return parseInt(divID.match(/\d/)); }
}

MHS.Worksheet.Util = {
	// problem: function(number) { return $('div.worksheet_problem#problem_' + number); },
	// getNumberFromID: function(id) { return parseInt(id.match(/\d/)); },
	getWorksheetID: function() { return parseInt($('div.worksheet').attr('id').match(/\d/)); }	
}

MHS.Routes = {
	Worksheets: {
		update: function(worksheet_id) { return '/worksheets/' + worksheet_id; }
	}
}


$(function() {
	// $('.replace_problem_form').submit(function() {
	// 	var worksheet_id = MHS.Worksheet.Util.getWorksheetID();
	// 	var problemNumber = $(this).attr('id').match(/\d+/)[0];
	// 	$.ajax({ url: MHS.Routes.Worksheets.update(worksheet_id), type: "PUT", data: {'problem_number':problemNumber} });
	// 	return false;
	// });
});