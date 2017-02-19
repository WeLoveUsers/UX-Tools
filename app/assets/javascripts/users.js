$(document).on('turbolinks:load', function() {

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
        'user[password_confirmation]' : 'match[user[password]]',
        'terms'                       : 'checked'
      }
    })
  ;

});
