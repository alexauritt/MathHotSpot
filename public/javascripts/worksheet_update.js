MHS.Worksheet.Updater = {
  hideFormAndShowLink: function() {
    $('#title-update').hide('fast', MHS.Worksheet.Updater.showLink);
    return false;
  },
  hideLinkAndShowForm: function() {
    $('#current-title').hide('fast', MHS.Worksheet.Updater.showForm);
    return false;
  },
  showForm: function() {
    $('#title-update').show('fast');
    return false;
  },
  showLink: function() {
    $('#current-title').show('fast');
    return false;
  }
}

$(function() {
  $('#title-update').hide();
  $('#title-edit-link').show();
  $('#cancel-title-update input').live('click', MHS.Worksheet.Updater.hideFormAndShowLink);
  $('#title-edit-link input').live('click', MHS.Worksheet.Updater.hideLinkAndShowForm);
});