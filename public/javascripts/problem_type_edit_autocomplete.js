$(function(){
  var problemID = $('#info').data("problem_type_name");
  var availableProblemURL = "/problem_types/" + problemID + "/available_tags/search";
  $("#problem_type_new_tag").autocomplete({
        source: availableProblemURL
  });
});