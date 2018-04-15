$(function() {
  $('form[data-remote]').on('ajax:beforeSend', function(event, xhr, settings) {
    target = $(this).find('#updatable_list').val();
    $(target).html('<div class="progress"><div class="indeterminate"></div></div>');

    target = $(this).find('#updatable_album').val();
    $(target).html('<div class="progress"><div class="indeterminate"></div></div>');
  });
});
