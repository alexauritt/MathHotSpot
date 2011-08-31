MHS.Worksheet.Util = {
  hideFormAndShowLink: function() {
    $('#title-update').hide('fast', MHS.Worksheet.Util.showLink);
    return false;
  },
  hideLinkAndShowForm: function() {
    $('#current-title').hide('fast', MHS.Worksheet.Util.showForm);
    return false;
  },
  showForm: function() {
    $('#title-update').show('fast');
    return false;
  },
  showLink: function() {
    $('#current-title').show('fast');
  }
}

$(function() {
  $('#title-update').hide();
  $('#title-edit-link').show();
  $('#cancel-title-update input').live('click', MHS.Worksheet.Util.hideFormAndShowLink);
  $('#title-edit-link input').live('click', MHS.Worksheet.Util.hideLinkAndShowForm);
});