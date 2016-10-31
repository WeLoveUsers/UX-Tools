$(document).on('turbolinks:load', function() {
  $('.ui.calendar.date').calendar({
    type: 'date'
  });
  $('.message .close')
    .on('click', function() {
      $(this)
        .closest('.message')
        .transition('fade')
      ;
    });
});
