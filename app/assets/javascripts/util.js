$(document).on('turbolinks:load', function() {

  $('.ui.calendar.date').calendar({
    type: 'date',
    firstDayOfWeek: 1,
    monthFirst: false,
    minDate: new Date(),
    text: {
      days: ['L', 'M', 'M', 'J', 'V', 'S', 'D'],
      months: ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'],
      monthsShort: ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jui', 'Jul', 'Aou', 'Sep', 'Oct', 'Nov', 'Dec'],
      today: "Aujourd'hui",
      now: 'Maintenant',
      am: 'AM',
      pm: 'PM'
    },
    onChange: function (date, text) {
      $(this).next("input[type='hidden']").val(date.getDate() + '/' + (date.getMonth() + 1) + '/' + date.getFullYear());
    }
  });

  $('.ui.pointing.menu .item').tab();
  $('.ui.form select').dropdown();
  $('.ui.checkbox').checkbox();

  $('.ui.config.button').popup({
    inline: true,
    position: 'bottom right',
    on: 'click',
    variation: "wide"
  });

  $('.message .close')
    .on('click', function() {
      $(this)
        .closest('.message')
        .transition('fade')
      ;
    });

  $('form input.field-popup')
    .popup({
      on: 'focus'
    })
  ;

  $('input[data-confirm]').each(function(){
    var e = $(this);
    var message = e.data('confirm');
    var form = e.parent('form');
    // var confirmationHeader = $('<div class="header">Confirmation</div>');
    // var confirmationContent = $('<div class="content">' + message + '</div>');
    // var confirmationActions = $('<div class="actions"><div class="ui cancel inverted button">Annuler</div><div class="ui approve button">Confirmer</div></div>');
    // var confirmationModal = $('<div class="ui small modal"></div>');
    var confirmationModal = $('<div class="ui small modal"><div class="header">Confirmation</div><div class="content">' + message + '</div><div class="actions"><div class="ui cancel inverted button">Annuler</div><div class="ui approve button">Confirmer</div></div></div>');
    //confirmationModal.append(confirmationHeader).append(confirmationContent).append(confirmationActions);
    form.append(confirmationModal);
    form.confirmed = false;
    var modal = confirmationModal.modal({
      approve  : '.approve',
      cancel   : '.cancel',
      inverted: true,
      onApprove: function(){
        form.confirmed = true;
        form.submit();
      }
    });
    form.on('submit', function(event) {
      if (form.confirmed) {
        return true;
      } else {
        modal.modal('show');
        event.preventDefault();
      }
    });
  });

});
