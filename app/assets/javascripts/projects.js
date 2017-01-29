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
  $('.ui.checkbox#show_variability').checkbox({
    onChecked: function() {
      $('.variability').show();
      document.cookie = "show_variability=1";
    },
    onUnchecked: function() {
      $('.variability').hide();
      document.cookie = "show_variability=0";
    }
  });

  $('.ui.config.button').popup({
    inline: true,
    position: 'bottom right',
    on: 'click',
    variation: "wide"
  });

  $('.ui.sus_confidence.dropdown').dropdown({
    onChange: function(value, text, $choice) {
      if (!this.target) {
        this.target = $('#' + $(this).data('target'));
      }
      document.cookie = "ci_level=" + text;
      this.target.text(value);
      this.target.transition('flash');
    }
  });

  $('.ui.attrakdiff_confidence.dropdown').dropdown({
    onChange: function(value, text, $choice) {
      if (!this.target_QP || !this.target_QHS || !this.target_QHI || !this.target_ATT ) {
        this.target_QP  = $('#' + $(this).data('target') + '_QP');
        this.target_QHS = $('#' + $(this).data('target') + '_QHS');
        this.target_QHI = $('#' + $(this).data('target') + '_QHI');
        this.target_ATT = $('#' + $(this).data('target') + '_ATT');
      }
      document.cookie = "ci_level=" + text;
      value = value.split("_");
      this.target_QP.text(value[0]);
      this.target_QHS.text(value[1]);
      this.target_QHI.text(value[2]);
      this.target_ATT.text(value[3]);
      this.target_QP.transition('flash');
      this.target_QHS.transition('flash');
      this.target_QHI.transition('flash');
      this.target_ATT.transition('flash');
    }
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

  $('.ui.form.evaluation-project')
    .form({
      fields: {
        'project[questionnaire_id]'       : 'empty',
        'project[questionnaire_language]' : 'empty',
        'project[product_type]'           : 'empty',
        'project[product_name]'           : 'empty',
        'project[project_code]'           : 'empty',
        'project[end_date]'               : 'empty'
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

  $('.ui.form.deep')
    .form({
      fields: {
        'response_deep[Q1]' : 'checked',
        'response_deep[Q2]' : 'checked',
        'response_deep[Q3]' : 'checked',
        'response_deep[Q4]' : 'checked',
        'response_deep[Q5]' : 'checked',
        'response_deep[Q6]' : 'checked',
        'response_deep[Q7]' : 'checked',
        'response_deep[Q8]' : 'checked',
        'response_deep[Q9]' : 'checked',
        'response_deep[Q10]' : 'checked',
        'response_deep[Q11]' : 'checked',
        'response_deep[Q12]' : 'checked',
        'response_deep[Q13]' : 'checked',
        'response_deep[Q14]' : 'checked',
        'response_deep[Q15]' : 'checked',
        'response_deep[Q16]' : 'checked',
        'response_deep[Q17]' : 'checked',
        'response_deep[Q18]' : 'checked',
        'response_deep[Q19]' : 'checked'
      }
    })
  ;

  // Show rich text editor (modal) and define actions
  $('a.show_editor_modal')
    .on('click', function(event) {
      event.preventDefault();
      $('#instructions_editor_modal').modal({
        //blurring: true,
        inverted: true
      }).modal('show');
    });

  // Show help to choose which questionnaire does what (modal)
  $('a.show_questionnaire_help_modal')
    .on('click', function(event) {
      event.preventDefault();
      $('#questionnaire_help_modal').modal({
        //blurring: true,
        inverted: true,
        cancel  : '.cancel',
        approve  : '.approve'
      }).modal('show');
    });

  // Show references of questionnaires (modal)
  $('a.show_questionnaire_references_modal')
    .on('click', function(event) {
      event.preventDefault();
      $('#questionnaire_references_modal').modal({
        //blurring: true,
        inverted: true,
        cancel  : '.cancel',
        approve  : '.approve'
      }).modal('show');
    });

  // Show terms (modal)
  $('a.show_terms_modal')
    .on('click', function(event) {
      event.preventDefault();
      $('#terms_modal').modal({
        //blurring: true,
        inverted: true,
        cancel  : '.cancel',
        approve  : '.approve',
        onApprove: function(what) {
          $('.ui.form.signup input#terms').prop('checked', true);
        }
      }).modal('show');
    });
});
