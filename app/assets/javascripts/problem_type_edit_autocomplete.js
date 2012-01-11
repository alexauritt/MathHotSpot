$(function(){
  var problemID = $('#info').data("problem_type_name");
  var availableProblemURL = "/problem_types/" + problemID + "/available_tags/search";
  $("#problem_type_add_tag").autocomplete({
        source: availableProblemURL
  });
});