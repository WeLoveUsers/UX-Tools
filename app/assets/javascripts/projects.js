$(document).on('turbolinks:load', function() {

  $('.ui.calendar.date').calendar({
    type: 'date'
  });

  $('.ui.pointing.menu .item').tab();
  $('.ui.form select').dropdown();

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

  $('.ui.form.password')
    .form({
      fields: {
        'user[email]'     : 'email'
      }
    })
  ;

  $('.ui.form.login')
    .form({
      fields: {
        'user[email]'     : 'email',
        'user[password]'  : 'empty'
      }
    })
  ;

  $('.ui.form.signup')
    .form({
      fields: {
        'user[email]'                 : 'email',
        'user[password]'              : 'minLength[6]',
        'user[password_confirmation]' : 'match[user[password]]'
      }
    })
  ;

  $('.ui.form.attrakdiff')
    .form({
      fields: {
        'response_attrak_diff[QP1]' : 'checked',
        'response_attrak_diff[QP2]' : 'checked',
        'response_attrak_diff[QP3]' : 'checked',
        'response_attrak_diff[QP4]' : 'checked',
        'response_attrak_diff[QP5]' : 'checked',
        'response_attrak_diff[QP6]' : 'checked',
        'response_attrak_diff[QP7]' : 'checked',
        'response_attrak_diff[QHS1]' : 'checked',
        'response_attrak_diff[QHS2]' : 'checked',
        'response_attrak_diff[QHS3]' : 'checked',
        'response_attrak_diff[QHS4]' : 'checked',
        'response_attrak_diff[QHS5]' : 'checked',
        'response_attrak_diff[QHS6]' : 'checked',
        'response_attrak_diff[QHS7]' : 'checked',
        'response_attrak_diff[QHI1]' : 'checked',
        'response_attrak_diff[QHI2]' : 'checked',
        'response_attrak_diff[QHI3]' : 'checked',
        'response_attrak_diff[QHI4]' : 'checked',
        'response_attrak_diff[QHI5]' : 'checked',
        'response_attrak_diff[QHI6]' : 'checked',
        'response_attrak_diff[QHI7]' : 'checked',
        'response_attrak_diff[ATT1]' : 'checked',
        'response_attrak_diff[ATT2]' : 'checked',
        'response_attrak_diff[ATT3]' : 'checked',
        'response_attrak_diff[ATT4]' : 'checked',
        'response_attrak_diff[ATT5]' : 'checked',
        'response_attrak_diff[ATT6]' : 'checked',
        'response_attrak_diff[ATT7]' : 'checked'
      }
    })
  ;

  $('.ui.form.attrakdiff')
    .form({
      fields: {
        'response_attrak_diff[QP1]' : 'checked',
        'response_attrak_diff[QP2]' : 'checked',
        'response_attrak_diff[QP3]' : 'checked',
        'response_attrak_diff[QP4]' : 'checked',
        'response_attrak_diff[QP5]' : 'checked',
        'response_attrak_diff[QP6]' : 'checked',
        'response_attrak_diff[QP7]' : 'checked',
        'response_attrak_diff[QHS1]' : 'checked',
        'response_attrak_diff[QHS2]' : 'checked',
        'response_attrak_diff[QHS3]' : 'checked',
        'response_attrak_diff[QHS4]' : 'checked',
        'response_attrak_diff[QHS5]' : 'checked',
        'response_attrak_diff[QHS6]' : 'checked',
        'response_attrak_diff[QHS7]' : 'checked',
        'response_attrak_diff[QHI1]' : 'checked',
        'response_attrak_diff[QHI2]' : 'checked',
        'response_attrak_diff[QHI3]' : 'checked',
        'response_attrak_diff[QHI4]' : 'checked',
        'response_attrak_diff[QHI5]' : 'checked',
        'response_attrak_diff[QHI6]' : 'checked',
        'response_attrak_diff[QHI7]' : 'checked',
        'response_attrak_diff[ATT1]' : 'checked',
        'response_attrak_diff[ATT2]' : 'checked',
        'response_attrak_diff[ATT3]' : 'checked',
        'response_attrak_diff[ATT4]' : 'checked',
        'response_attrak_diff[ATT5]' : 'checked',
        'response_attrak_diff[ATT6]' : 'checked',
        'response_attrak_diff[ATT7]' : 'checked'
      }
    })
  ;

  $('.ui.form.sus')
    .form({
      fields: {
        'response_su[Q1]' : 'checked',
        'response_su[Q2]' : 'checked',
        'response_su[Q3]' : 'checked',
        'response_su[Q4]' : 'checked',
        'response_su[Q5]' : 'checked',
        'response_su[Q6]' : 'checked',
        'response_su[Q7]' : 'checked',
        'response_su[Q8]' : 'checked',
        'response_su[Q9]' : 'checked',
        'response_su[Q10]' : 'checked'
      }
    })
  ;
});
