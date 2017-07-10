$(document).ready(function() {
  $('#micropost_picture').bind('change', function() {
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert(I18n.t('java.alert.picture_size'));
    }
  });

  $('span.timestamp').timeago();
});
