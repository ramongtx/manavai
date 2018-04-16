$(document).on('turbolinks:load ready', function() {
  elem = document.querySelector('#left-sidenav');
  instance = new M.Sidenav(elem, {});
  M.updateTextFields();
});

$(document).on('ready turbolinks:before-visit', function() {
  elem = document.querySelector('#left-sidenav');
  instance = M.Sidenav.getInstance(elem);
  instance.destroy();
});