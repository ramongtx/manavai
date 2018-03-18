$(function() {
  $('form[data-remote]').on('ajax:beforeSend', function(event, xhr, settings) {
    target = $(this).find('#updatable').val();
    $(target).html('<div class="progress"><div class="indeterminate"></div></div>');
  });
});
