var firstPassage_b = true;

$(document).ready(function () {
  var iw_calendar = document.getElementById('calendar');

  var required_fields = $("#mandatory").val().split(';');
  var required_fields_privileges = $("#mandatory_privileges").val().split(';');
  var required_fields_config = $("#mandatory_config").val().split(';');

  var privileges_mode_choisie = "readwrite";

  var pref_planning_web_view = 'timeGridWeek';

  var global_eve_hb_id = '';
  var global_eve_hb_nom = '';
  var global_eve_id = '';
  var global_eve_owner_name = '';

  var custom_view_nav = '';
  var custom_view_date = '';

  var custom_view_nav = getUrlParameter('view');
  var custom_view_date = getUrlParameter('date');
  var custom_view_referenceID = getUrlParameter('hebergeReferenceID');

  var global_fiche_event_popup = '';

  var var_global_event_popup = '';

  var global_current_user_autorisation = 'readwrite';
  var global_current_user_autorisation_event = 'readonly';

  var action_type = getUrlParameter('atype');
  var id_event = '';

  //-------- Event variables --------------//
  var var_eve_type = '';
  var var_eve_presence = '';
  var var_eve_rappel = '';
  var var_eve_recurrence = '';

  var var_eve_titre = '';
  var var_eve_notes = '';
  var var_eve_usager_nom = '';
  var var_eve_hb_id = '';

  User_PLA_Get_Autorisations();

  if (action_type != 'eventbyid') {
    Get_Preference('planning_web_view', true);
  }

  //=================== Calendar =================================//

  var calendar = new FullCalendar.Calendar(iw_calendar, {
    plugins: ['interaction', 'dayGrid', 'timeGrid', 'list'],
    customButtons: {
      btn_dayGridMonth: {
        text: 'Mois',
        click: function (e) {
          calendar.changeView('dayGridMonth');
          Set_Preferences('planning_web_view', 'dayGridMonth');

        }
      },
      btn_timeGridWeek: {
        text: 'Semaine',
        click: function () {
          calendar.changeView('timeGridWeek');
          Set_Preferences('planning_web_view', 'timeGridWeek');
        }
      },
      btn_timeGridDay: {
        text: 'Jour',
        click: function () {
          calendar.changeView('timeGridDay');
          Set_Preferences('planning_web_view', 'timeGridDay');
        }
      },
      btn_listWeek: {
        text: 'Liste de la semaine',
        click: function () {
          calendar.changeView('listWeek');
          Set_Preferences('planning_web_view', 'listWeek');
        }
      },
    },
    header: {
      left: 'prev,next today',
      center: 'title',
      right: 'btn_dayGridMonth,btn_timeGridWeek,btn_timeGridDay,btn_listWeek' //,dayGridMonth,timeGridWeek,timeGridDay,listWeek
    },
    allDayDefault: false,
    allDay: false,
    nextDayThreshold: '00:00:00',
    timezone: 'false',
    defaultView: 'timeGridWeek',
    editable: true,
    navLinks: true, // can click day/week names to navigate views
    eventLimit: true, // allow "more" link when too many events
    selectable: true,
    selectHelper: true,
    businessHours: {
      // days of week. an array of zero-based day of week integers (0=Sunday)
      daysOfWeek: [0, 1, 2, 3, 4, 5, 6], // Monday - Thursday

      startTime: '08:00', // a start time (10am in this example)
      endTime: '18:30', // an end time (6pm in this example)
    },
    minTime: "06:00:00",
    eventClick: function (info) {

      $("#id_selected").val(info.event.id);

      DATA_GET_EVENT(info.event.id, false, true, true);

      // change the border color just for fun
      info.el.style.borderColor = 'green';

    },
    select: function (start) {

      if (global_current_user_autorisation == 'readwrite') {

        //================= INITIALISATION DES DATES ET HEURES ===============//
        eve_date_du = UTL_Date_Format(start.startStr, 2);
        eve_date_au = UTL_Date_Format(start.endStr, 2);

        var t = Date.parse(start.startStr);
        var d = new Date(t);
        eve_heure_du = UTL_minTwoDigits(d.getHours()) + ':' + UTL_minTwoDigits(d.getMinutes());

        var t = Date.parse(start.endStr);
        var d = new Date(t);
        eve_heure_au = UTL_minTwoDigits(d.getHours()) + ':' + UTL_minTwoDigits(d.getMinutes());

        if ((calendar.view.viewSpec.type == 'dayGridMonth') || (calendar.view.viewSpec.type == 'timeGridWeek')) {

          var fix_date_interval = 'false';

          if ((calendar.view.viewSpec.type == 'dayGridMonth') || ((start.startStr.length == 10))) {
            eve_heure_du = '08:00';
            eve_heure_au = '12:00';
            fix_date_interval = 'true';
          }
          // pour régler le problème du décalage  
          if ((start.startStr != start.endStr) && (fix_date_interval == 'true')) {

            var var_month = parseInt(d.getMonth()) + 1;
            var var_jour = parseInt(d.getDate()) - 1;

            eve_date_au = UTL_minTwoDigits(var_jour) + "/" + UTL_minTwoDigits(var_month) + "/" + d.getFullYear();

          }

        }
        //==========================================================================//

        if ($("#pla_granted_users").val() != '-1') {

          FORM_EVENT_SHOW('', false, true);

        } else {

          $.alert({
            title: 'Alerte!',
            content: 'Vous devez sélectionner un utilisateur',
            icon: 'fa fa-warning',
            animation: 'scale',
            closeAnimation: 'scale',
            columnClass: 'iw_alert',
            buttons: {
              okay: {
                text: 'Ok',
                btnClass: 'btn-blue'
              }
            }
          });

        }

      } else {

        $.alert({
          title: 'Alerte!',
          content: 'Vous n\'avez pas les autorisations requises pour créer des événements pour l\'utilisateur sélectionné',
          icon: 'fa fa-warning',
          animation: 'scale',
          closeAnimation: 'scale',
          columnClass: 'iw_alert',
          buttons: {
            okay: {
              text: 'Ok',
              btnClass: 'btn-blue'
            }
          }
        });


      }

    },
    editable: true,
    eventDrop: function (info) {

      if (global_current_user_autorisation == 'readwrite') {

        $.confirm({
          title: 'Modification',
          content: 'Êtes-vous sûr de ce changement ?',
          icon: 'fa fa-warning',
          animation: 'scale',
          closeAnimation: 'zoom',
          columnClass: 'iw_alert',
          buttons: {
            confirm: {
              text: 'Oui',
              btnClass: 'btn-orange',
              action: function () {


                //================= INITIALISATION DES DATES ET HEURES ===============//
                eve_date_du = UTL_Date_Format(info.event.start.toISOString(), 2);
                eve_date_au = UTL_Date_Format(info.event.end.toISOString(), 2);


                //var date = "Sun Nov 28 2019 06:30:00 GMT+0200 (EET)";
                var t = Date.parse(info.event.start.toISOString());
                var d = new Date(t);
                eve_heure_du = UTL_minTwoDigits(d.getHours()) + ':' + UTL_minTwoDigits(d.getMinutes());

                var t = Date.parse(info.event.end.toISOString());
                var d = new Date(t);
                eve_heure_au = UTL_minTwoDigits(d.getHours()) + ':' + UTL_minTwoDigits(d.getMinutes());

                //==========================================================================//

                Event_Drag_Drop(info.event.id, eve_date_du, eve_heure_du, eve_date_au, eve_heure_au);




              }
            },
            cancel: {
              text: 'Non',
              action: function () {

                info.revert();

              }
            }
          }
        });

      } else {

        $.alert({
          title: 'Alerte!',
          content: 'Vous n\'avez pas les autorisations requises pour déplacer cet événement.',
          icon: 'fa fa-warning',
          animation: 'scale',
          closeAnimation: 'scale',
          columnClass: 'iw_alert',
          buttons: {
            okay: {
              text: 'Ok',
              btnClass: 'btn-blue'
            }
          }
        });

        info.revert();
      }

    },
    eventResize: function (info) {

      if (global_current_user_autorisation == 'readwrite') {

        $.confirm({
          title: 'Modification',
          content: 'Êtes-vous sûr de ce changement ?',
          icon: 'fa fa-warning',
          animation: 'scale',
          closeAnimation: 'zoom',
          columnClass: 'iw_alert',
          buttons: {
            confirm: {
              text: 'Oui',
              btnClass: 'btn-orange',
              action: function () {
                var t = Date.parse(info.event.end.toISOString());
                var d = new Date(t);

                eve_heure_au = UTL_minTwoDigits(d.getHours()) + ':' + UTL_minTwoDigits(d.getMinutes());
                Event_Resize(info.event.id, eve_heure_au);
              }
            },
            cancel: {
              text: 'Non',
              action: function () {
                info.revert();
              }
            }
          }
        });

      } else {

        $.alert({
          title: 'Alerte!',
          content: 'Vous n\'avez pas les autorisations requises pour effectuer cette modification.',
          icon: 'fa fa-warning',
          animation: 'scale',
          closeAnimation: 'scale',
          columnClass: 'iw_alert',
          buttons: {
            okay: {
              text: 'Ok',
              btnClass: 'btn-blue'
            }
          }
        });

        info.revert();
      }

    },
    events: {
      url: '/USR?action=planning-data',
      failure: function () {
        document.getElementById('script-warning').style.display = '';
      }
    },
    loading: function (bool) {
      document.getElementById('loading').style.display =
        bool ? 'block' : 'none';

        if (custom_view_referenceID != "") {
          $('#pla_granted_heberges option[value="' + custom_view_referenceID + '"]').prop('selected', true);
          $('#pla_granted_heberges').change();

          if ($('#pla_granted_heberges').val() != "") {
            $("#iw_btn_plan_activer_alert").removeClass("d-none");
          }
          
          custom_view_referenceID = "";
        }

    }
  });

  calendar.setOption('locale', 'fr-fr');
  calendar.render();

  //=================== Other =================================//

  function Calendar_scrollToTime($time) {

    if (pref_planning_web_view == 'timeGridDay') {
      var targets = $('.fc-minor');

      $time = $time + ':00';

      $time_array = $time.split(':');
      $time_hour = $.trim($time_array[0]);

      $.each(targets, function () {
        var scrollable = $(this);
        var closestTime = $(this).attr('data-time');

        $closestTime_array = closestTime.split(':');
        $closestTime_hour = $.trim($closestTime_array[0]);

        if ($closestTime_hour === $time_hour) {

          $([document.documentElement, document.body]).animate({
            scrollTop: scrollable.offset().top - 100
          }, 1000);

        }

      });

    }
  };

  function FORM_EVENT_SHOW($id, $drag_event, $load_data_popup) {

    if ($id == '') { // nouvelle fiche
      $('#titre_popup').html('Nouvelle fiche - ' + $("#pla_granted_users option:selected").text());
      $("#id_selected").val('');

      Event_Init_Variables('');
    }
    
    var_global_event_popup = $('#iw_form_popup').html();
    $('#iw_form_popup').html('');

    global_fiche_event_popup = $.confirm({
      title: '',
      columnClass: 'popup_event_class',
      content: '' +
        '<div>' + var_global_event_popup +
        '</div>',
      buttons: {
        cancel: {
          text: 'Fermer',
          btnClass: 'btn-blue iw_eve_btn_close',
          action: function () {
            $('#iw_form_popup').html(var_global_event_popup);
          }
        },
        formSubmit: {
          text: 'Enregistrer',
          btnClass: 'btn-blue iw_eve_btn_save',
          action: function () {

            if (Check_Required_Fields(required_fields)) {
              Mark_All_Required_Fields(required_fields);

              $.alert({
                title: 'Champs obligatoires!',
                content: 'Vous devez remplir tous les champs obligatoires!',
                icon: 'fa fa-warning',
                animation: 'scale',
                closeAnimation: 'scale',
                columnClass: 'iw_alert',
                buttons: {
                  okay: {
                    text: 'Ok',
                    btnClass: 'btn-blue'
                  }
                }
              });

              return false;
            } else {
              Save_Record(false);

              $('#iw_form_popup').html(var_global_event_popup);
              return true;
            }

          }
        },
        alerte: {
          text: 'Alertes',
          btnClass: 'btn-red iw_eve_btn_close',
          action: function () {
            var $value_t = $('#pla_granted_heberges').val();
            
            $('#pla_granted_heberges option[value="' + $("#eve_hb_id").val() + '"]').prop('selected', true);
            $('#pla_granted_heberges').change();
            
            if ($value_t == "Tous") {
              $("#iw_btn_plan_activer_alert").removeClass("d-none");
            }

            $('#iw_form_popup').html(var_global_event_popup);
            $("#iw_btn_plan_activer_alert").click();
          }
        },
        Supprimer: {
          text: 'Supprimer',
          btnClass: 'btn-red iw_eve_btn_delete',
          keys: ['del'],
          isHidden: false,
          isDisabled: false,
          action: function (heyThereButton) {


            $.confirm({
              title: 'Suppression',
              content: 'Voulez-vous vraiment supprimer cet événement ?',
              icon: 'fa fa-warning',
              animation: 'scale',
              closeAnimation: 'zoom',
              columnClass: 'iw_alert',
              buttons: {
                confirm: {
                  text: 'Oui',
                  btnClass: 'btn-orange',
                  action: function () {

                    $('#iw_form_popup').html(var_global_event_popup);

                    Event_Remove('check');

                  }
                },
                cancel: {
                  text: 'Non',
                  action: function () {

                    $('#iw_form_popup').html(var_global_event_popup);

                  }
                }
              }
            });



          }
        }
      },
      onContentReady: function () {
        // bind to events
        var jc = this;
        this.$content.find('form').on('submit', function (e) {
          e.preventDefault();
          jc.$$formSubmit.trigger('click'); // reference the button and click it
        });

        if ($id == '') {
          global_current_user_autorisation_event = global_current_user_autorisation;
        }

        Form_HG_LISTE();
        FORM_SET_ENTERABLE();

        Init_Autocomplete('#eve_usager_nom', '#eve_hb_id', 'GB', 'get_autocomplete_heberges');

        if (global_current_user_autorisation_event == 'readwrite') {

          $('#eve_date_du').datepicker({
            format: 'dd/mm/yyyy'
          });

          $('#eve_date_du').change(function () {

            UTL_Time_Picker_Formatted($('#eve_date_du').val(), '#eve_heure_du');

          });

          $('#eve_date_au').datepicker({
            format: 'dd/mm/yyyy'
          });

          $('#eve_date_au').change(function () {

            UTL_Time_Picker_Formatted($('#eve_date_au').val(), '#eve_heure_au');

          });

          $('#eve_heure_du').datetimepicker({
            pickDate: false,
            minuteStep: 15,
            pickerPosition: 'bottom-right',
            autoclose: true,
            //showMeridian: true,
            startView: 1,
            maxView: 1,
            timeOnly: true,
            format: 'hh:i',
            dateFormat: 'dd/mm/yyyy',
            timeFormat: 'hh:mm TT'
          });

          $('#eve_heure_au').datetimepicker({
            pickDate: false,
            minuteStep: 15,
            pickerPosition: 'bottom-right',
            autoclose: true,
            startView: 1,
            maxView: 1,
            format: 'hh:i',
            dateFormat: 'dd/mm/yy',
            timeFormat: 'hh:mm TT'
          });

          $("#eve_heure_du").datetimepicker().focus(function () {
            $(".prev").hide();
            $(".next").hide();
            $(".switchs").hide();
          });

          $("#eve_heure_au").datetimepicker().focus(function () {
            $(".prev").hide();
            $(".next").hide();
          });
        }

        if ($load_data_popup == true) {
          UTL_Date_Picker_Formatted(eve_date_du, '#eve_date_du', global_current_user_autorisation_event);
          UTL_Date_Picker_Formatted(eve_date_au, '#eve_date_au', global_current_user_autorisation_event);

          $("#eve_heure_du").val(eve_heure_du);
          $("#eve_heure_au").val(eve_heure_au);

          UTL_Time_Picker_Formatted($('#eve_date_du').val(), '#eve_heure_du', global_current_user_autorisation_event);
          UTL_Time_Picker_Formatted($('#eve_date_au').val(), '#eve_heure_au', global_current_user_autorisation_event);

          $('#eve_type > [value="' + var_eve_type + '"]').attr('selected', 'true');
          $('#eve_presence > [value="' + var_eve_presence + '"]').attr('selected', 'true');
          
          var inputName_c = var_eve_rappel.split(";")
          
          inputName_c.forEach(element => {
            $("input[type='checkbox'][name='" + element + "']").attr("checked", true);
          });
          //$('#eve_rappel > [value="' + var_eve_rappel + '"]').attr('selected', 'true');
          $('#eve_recurrence > [value="' + var_eve_recurrence + '"]').attr('selected', 'true');

          $("#eve_titre").attr('value', var_eve_titre);
          $("#eve_notes").attr('value', var_eve_notes);
          $("#eve_usager_nom").attr('value', var_eve_usager_nom);
          $("#eve_hb_id").attr('value', var_eve_hb_id);
        }

        $('#eve_participants_ids').multiSelect({
          // selectableHeader: '<input type="text" id="search" class="search span2"  autocomplete="off" >'
        });

        DATA_Get_Participants();

        $("#filter_usager").change(function () {
          DATA_Get_Participants();
        });

        // Un peu de mise en forme
        $(".checkbox_list-label").remove();
        $('.checkbox-input--services').css('cssText', 'margin: 0px 0px 0px 20px!important');

        $('.fdp-border').css('cssText', 'padding: 0.6rem 0.75rem 0.6rem 0.75rem!important; border-radius: 0px!important');
        $('.fdp-border > ul').css('cssText', 'margin: 0px!important');
        $('.fdp-border > ul > li').css('cssText', 'display: inline-block; line-height: 0px');
        $('.fdp-border > ul > li > label').css('cssText', 'margin: 0px!important; line-height: normal; width: 110px');
        $('.fdp-border > ul > li > label > input').css('cssText', 'position: initial!important; margin: 0px 0px 0px 20px!important; float: right');

        $('.checkbox-span').css('cssText', 'padding: 0px!important');
        $(".jconfirm-type-default").css("cssText", "max-width: 100%!important;");

        $("#filter_usager").closest(".control-group").addClass("g-width-100x");
        $("#btn_email_participant").closest(".iw_cg_width_one_third").insertAfter(".iw_groupe_parent");
        $(".iw_groupe_parent").addClass("g-float-left g-width-75x");
      }
    });
  }

  Autocomplete_After = function () {

    Privileges_Get_Default();

  }

  function FORM_SET_ENTERABLE() {

    if (global_current_user_autorisation_event == 'readwrite') {

      $("#event_ligne input[type=text]").each(function () {
        var input = $(this);
        if (input.attr('type') == 'text') {
          input.attr('readonly', false);
        }
      });

      $("#event_ligne textarea").each(function () {
        var input = $(this);
        input.prop('disabled', false);
      });

      $("#event_ligne select").each(function () {
        var input = $(this);
        input.prop('disabled', false);
      });

      $("#event_ligne button").each(function () {
        var input = $(this);
        input.removeClass('iw_display_none');
      });

      $('.iw_eve_btn_save').removeClass('iw_display_none');
      $('.iw_eve_btn_delete').removeClass('iw_display_none');

      $('.iw_cg_pla_participants').removeClass('iw_display_none');
      $('.iw_groupe_parent').removeClass('iw_display_none');

    } else {

      $("#event_ligne input[type=text]").each(function () {
        var input = $(this);
        if (input.attr('type') == 'text') {
          input.attr('readonly', true);
        }
      });

      $("#event_ligne textarea").each(function () {
        var input = $(this);
        input.prop('disabled', true);
      });

      $("#event_ligne select").each(function () {
        var input = $(this);
        input.prop('disabled', true);
      });



      $("#event_ligne button").each(function () {
        var input = $(this);
        input.removeClass('iw_display_none');
        input.addClass('iw_display_none');
      });

      $('.iw_eve_btn_save').removeClass('iw_display_none');
      $('.iw_eve_btn_save').addClass('iw_display_none');
      $('.iw_eve_btn_delete').removeClass('iw_display_none');
      $('.iw_eve_btn_delete').addClass('iw_display_none');

      $('.iw_cg_pla_participants').removeClass('iw_display_none');
      $('.iw_cg_pla_participants').addClass('iw_display_none');

      $('.iw_groupe_parent').removeClass('iw_display_none');
      $('.iw_groupe_parent').addClass('iw_display_none');
    }

  }

  function Show_Popup_Fiche_HG() {

    $('#titre_popup_hg').html("Création des fiches d'hébergements pour l'usager " + global_eve_hb_nom);

    $('#iw_form_popup_hg').show();

  }

  $('#btn_popup_save').click(function () {

    $.confirm({
      title: 'Notification',
      content: 'Êtes-vous sûr de vouloir créer ces fiches pour ' + global_eve_hb_nom + ' ? ',
      icon: 'fa fa-warning',
      animation: 'scale',
      closeAnimation: 'zoom',
      columnClass: 'iw_alert',
      buttons: {
        confirm: {
          text: 'Oui',
          btnClass: 'btn-orange',
          action: function () {

            HG_Creation_Fiches();


          }
        },
        cancel: {
          text: 'Non',
          action: function () {

            Event_Form_Reset();
          }
        }
      }
    });

  });

  $('#btn_popup_close').click(function () {

    $('#iw_form_popup_hg').hide();

    Event_Form_Reset();

  });

  function Event_Init_Variables($type = '') {

    //================= INIT =====================//
    $("#eve_titre").attr('value', '');
    $("#eve_notes").attr('value', '');
    $("#eve_usager_nom").attr('value', '');
    $("#eve_hb_id").attr('value', '');
    $('#eve_type').prop('selectedIndex', 0);
    $('#eve_presence').prop('selectedIndex', 0);
    $('#eve_rappel').prop('selectedIndex', 0);
    $('#eve_recurrence').prop('selectedIndex', 0);

    var_eve_type = '';
    var_eve_presence = '';
    var_eve_rappel = '';
    var_eve_recurrence = '';

    var_eve_titre = '';
    var_eve_notes = '';
    var_eve_usager_nom = '';
    var_eve_hb_id = '';

    global_eve_hb_id = '';
    global_eve_hb_nom = '';

    if ($type == 'all') {

      eve_date_du_iso = '';

      eve_date_du = '';
      eve_date_au = '';
      eve_heure_du = '';
      eve_heure_au = '';

      global_eve_id = '';

    }

    //=============================================//
  }

  function Event_Form_Reset() {
    $(location).attr('href', '/USR?action=planning');
  }

  function HG_Creation_Fiches() {

    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });


    $.LoadingOverlay("show");

    var data_pla = {
      "id_event": $('#id_selected').val(),
      "ids_centres": $('#eve_centre_hg_id').val(),
      "groupe": $('#eve_groupe_hg').val()
    }

    var data = {
      "zone": "usr",
      "action": "set_pla",
      "data": {
        "pla": data_pla
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    var $status = '';
    var $msg = '';

    $.getJSON("/USR?action=hg_creation_fiches", data_json, function (data) {

      var compteur = 0;


      $.each(data, function (key, value) {

        if (compteur == 0) {
          $status = value;
        } else {
          $msg = value;
        }

        compteur = compteur + 1;

      });

    }).done(function () {//success

    })
    .fail(function () { //error

    })
    .always(function () { //complete

      if ($status == 'success') {

        $.alert({
          title: 'Succès',
          content: $msg,
          icon: 'fa fa-check',
          animation: 'scale',
          closeAnimation: 'scale',
          columnClass: 'iw_alert',
          buttons: {
            okay: {
              text: 'Ok',
              btnClass: 'btn-blue',
              action: function () {
                $('#iw_form_popup_hg').hide();
                Event_Form_Reset();
              }
            }
          }
        });

      } else {

        $.alert({
          title: "Échec",
          content: $msg,
          icon: 'fa fa-warning',
          animation: 'scale',
          closeAnimation: 'scale',
          columnClass: 'iw_alert',
          buttons: {
            okay: {
              text: 'Ok',
              btnClass: 'btn-blue'
            }
          }
        });

      }

      $.LoadingOverlay("hide");
    });

  }

  function Configuration_Fiche() {


    $('#titre_popup_config').html('Configuration');
    $("#id_selected").val('');


    var var_popup = $('#iw_form_popup_config').html();
    $('#iw_form_popup_config').html('');

    $.confirm({
      title: '',
      content: '' +
        '<div>' + var_popup +
        '</div>',
      buttons: {
        formSubmit: {
          text: 'Enregistrer',
          btnClass: 'btn-blue',
          action: function () {

            if (Check_Required_Fields(required_fields_config)) {
              Mark_All_Required_Fields(required_fields_config);

              $.alert({
                title: 'Champs obligatoires!',
                content: 'Vous devez remplir tous les champs obligatoires!',
                icon: 'fa fa-warning',
                animation: 'scale',
                closeAnimation: 'scale',
                columnClass: 'iw_alert',
                buttons: {
                  okay: {
                    text: 'Ok',
                    btnClass: 'btn-blue'
                  }
                }
              });

              return false;
            } else {
              Save_Record_Configuration();

              $('#iw_form_popup_config').html(var_popup);
              return true;
            }

          }
        },
        cancel: {
          text: 'Fermer',
          action: function () {

            $('#iw_form_popup_config').html(var_popup);


          }
        },
      },
      onContentReady: function () {
        // bind to events
        var jc = this;
        this.$content.find('form').on('submit', function (e) {
          // if the user submits the form by pressing enter in the field.
          e.preventDefault();
          jc.$$formSubmit.trigger('click'); // reference the button and click it


        });

        DATA_Settings_Get();



      }
    });

  }

  function Privileges_Fiche() {
    $('#titre_popup_privileges').html('Privilèges');
    $("#id_selected").val('');

    var var_popup = $('#iw_form_popup_privileges').html();
    $('#iw_form_popup_privileges').html('');

    $.confirm({
      title: '',
      content: '' +
        '<div>' + var_popup +
        '</div>',
      buttons: {
        formSubmit: {
          text: 'Enregistrer',
          btnClass: 'btn-blue',
          action: function () {

            if (Check_Required_Fields(required_fields_privileges)) {
              Mark_All_Required_Fields(required_fields_privileges);

              $.alert({
                title: 'Champs obligatoires!',
                content: 'Vous devez remplir tous les champs obligatoires!',
                icon: 'fa fa-warning',
                animation: 'scale',
                closeAnimation: 'scale',
                columnClass: 'iw_alert',
                buttons: {
                  okay: {
                    text: 'Ok',
                    btnClass: 'btn-blue'
                  }
                }
              });

              return false;
            } else {
              Save_Record_Privileges('planning_web_privileges');

              $('#iw_form_popup_privileges').html(var_popup);
              return true;
            }

          }
        },
        cancel: {
          text: 'Fermer',
          action: function () {

            $('#iw_form_popup_privileges').html(var_popup);


          }
        },
      },
      onContentReady: function () {
        // bind to events
        var jc = this;
        this.$content.find('form').on('submit', function (e) {
          // if the user submits the form by pressing enter in the field.
          e.preventDefault();
          jc.$$formSubmit.trigger('click'); // reference the button and click it


        });




        Init_Autocomplete('#pla_priv_usr_nom', '#pla_priv_usr_id', 'GB', 'get_autocomplete_utilisateurs');



        $('#pla_priv_usr_ids').multiSelect({
        });

        DATA_Get_Privileges();
        Privileges_Get_Default();

        $("#filter_utilisateur").change(function () {

          if ($("#filter_utilisateur").val() != '') {
            DATA_Get_Privileges();
          }


        });


        $("#pla_priv_usr_nom").blur(function () {
          DATA_Get_Privileges(true);
          //console.log('id :'+$("#pla_priv_usr_nom").val());
          //Privileges_Get_Default();
        });


        $(document).on('change', 'input[type="checkbox"]', function (e) {
          setFiltres(e);
        });



      }
    });

  }

  function setFiltres(e) {

    var pref_readonly = document.getElementById("pref_readonly");
    var pref_readwrite = document.getElementById("pref_readwrite");

    if (e.target.id == 'pref_readonly') {
      pref_readwrite.checked = false;
      privileges_mode_choisie = 'readonly';
    } else {
      pref_readonly.checked = false;
      privileges_mode_choisie = 'readwrite';
    }
  }

  function Drag_Drop($id, $drag_event) {

    $("#id_selected").val($id);


    $('#eve_date_du').datepicker({
      format: 'dd/mm/yyyy'
    });


    $('#eve_date_au').datepicker({
      format: 'dd/mm/yyyy'
    });


    $('#eve_heure_du').datetimepicker({
      pickDate: false,
      minuteStep: 15,
      pickerPosition: 'bottom-right',
      autoclose: true,
      //showMeridian: true,
      startView: 1,
      maxView: 1,
      timeOnly: true,
      format: 'hh:i',
      dateFormat: 'dd/mm/yyyy',
      timeFormat: 'hh:mm TT'
    });

    $('#eve_heure_au').datetimepicker({
      pickDate: false,
      minuteStep: 15,
      pickerPosition: 'bottom-right',
      autoclose: true,
      startView: 1,
      maxView: 1,
      format: 'hh:i',
      dateFormat: 'dd/mm/yy',
      timeFormat: 'hh:mm TT'
    });


    UTL_Date_Picker_Formatted(eve_date_du, '#eve_date_du');
    UTL_Date_Picker_Formatted(eve_date_au, '#eve_date_au');

    $("#eve_heure_du").val(eve_heure_du);
    $("#eve_heure_au").val(eve_heure_au);

    UTL_Time_Picker_Formatted($('#eve_date_du').val(), '#eve_heure_du');
    UTL_Time_Picker_Formatted($('#eve_date_au').val(), '#eve_heure_au');



    $('#eve_participants_ids').multiSelect({

      // selectableHeader: '<input type="text" id="search" class="search span2"  autocomplete="off" >'
    });

    DATA_Get_Participants();

    Save_Record(false);



  }

  function Get_Preference($type, $show_progress) {

    if ($show_progress == true) {

      $.LoadingOverlaySetup({
        background: "rgba(0, 0, 0, 0.5)",
        imageColor: "#fff"
      });


      $.LoadingOverlay("show");

    }

    $result = '';

    var data_specific = {
      "pref_type": $type
    };

    var data_search = {
      "zone": "usr",
      "action": "get_preference",
      "data": data_specific
    };

    var data_json = 'json=' + JSON.stringify(data_search);

    $.getJSON("/USR?action=get_preference", data_json, function (data) {
      console.log(data);

      if (data.length > 0) {

        $.each(data, function (key, value) {
          pref_planning_web_view = value.pref_value_1;
        });

      }

    }).done(function () {//success
    })
    .fail(function () { //error 
    })
    .always(function () { //complete

      if ($show_progress == true) {
        
        if ((custom_view_nav != '') && (custom_view_date != '')) {
          Set_Preferences('planning_web_view', 'timeGridDay');

          pref_planning_web_view = 'timeGridDay';
          calendar.changeView(custom_view_nav);
          calendar.gotoDate(custom_view_date);

          var newURL = location.href.split("&")[0];
          window.history.pushState('object', document.title, newURL);
        } else {
          calendar.changeView(pref_planning_web_view);
        }

        $.LoadingOverlay("hide");
      }

      $(".fc-btn_" + pref_planning_web_view + "-button").addClass("fc-button-active");
    });
  }

  function DATA_Get_Participants() {
    var tb_selected_hb_list = [];

    $('#eve_participants_ids > option:selected').each(function () {
      var heberger_data = {
        "id": $(this).val(),
        "value": $(this).text()
      };

      tb_selected_hb_list.push(heberger_data);
    });

    $('#eve_participants_ids').empty();

    tb_selected_hb_list.forEach(function (item) {
      $('#eve_participants_ids').append('<option value="' + item.id + '" selected>' + item.value + '</option>');
    });

    var data_specific = {
      "search_nom": $("#filter_usager").val(),
      "id_selected": $("#id_selected").val()
    };

    var data_search = {
      "zone": "usr",
      "action": "pla_get_participants",
      "data": data_specific
    };

    var data_json = 'json=' + JSON.stringify(data_search);

    $.getJSON("/USR?action=pla_get_participants", data_json, function (data) {
      console.log(data);
      if (data.length > 0) {

        if (global_current_user_autorisation_event == 'readonly') {
          var main_table_data = '<div class="pla_liste_participants_ro">';

          main_table_data = main_table_data + '<span>Liste des participants</span>';
          main_table_data = main_table_data + '<ul class="ms-list">';
        }

        $.each(data, function (key, value) {

          if (UTL_Select_OptionExists(value.userid, 'eve_participants_ids') == false) {
            $('#eve_participants_ids').append('<option value="' + value.userid + '" ' + value.status + '>' + value.user_nom_prenom + '</option>');

            if (global_current_user_autorisation_event == 'readonly') {

              if (value.status == 'selected') {
                main_table_data = main_table_data + '<li class="ms-elem-selectable">';
                main_table_data = main_table_data + value.user_nom_prenom;
                main_table_data = main_table_data + '</li>';
              }

            }

          }

        });

        if (global_current_user_autorisation_event == 'readonly') {
          main_table_data = main_table_data + '</ul>';
          main_table_data = main_table_data + '</div>';

          $("#event_ligne fieldset pla_liste_participants_ro").remove();
          $("#event_ligne fieldset").append(main_table_data);
        }

      }

    }).done(function () {//success

    })
    .fail(function () { //error 

    })
    .always(function () { //complete
      $('#eve_participants_ids').multiSelect('refresh');
      $('#iw_selected_list_title').html("Liste des participants");
      $('#iw_selectable_list_title').html("Liste des utilisateurs");
    });

  }

  function DATA_Get_Privileges($reset) {

    /*$.LoadingOverlaySetup({
        background      : "rgba(0, 0, 0, 0.5)",
        imageColor      : "#fff"
    });

 
    $.LoadingOverlay("show");*/


    if ($reset == false) {

      var tb_selected_usr_list = [];

      $('#pla_priv_usr_ids > option:selected').each(function () {

        var usr_data = {
          "id": $(this).val(),
          "value": $(this).text()
        };


        tb_selected_usr_list.push(usr_data);

      });


      $('#pla_priv_usr_ids').empty();

      tb_selected_usr_list.forEach(function (item) {

        $('#pla_priv_usr_ids').append('<option value="' + item.id + '" selected>' + item.value + '</option>');


      });

    } else {
      $('#pla_priv_usr_ids').empty();
    }



    var data_specific = {
      "id_selected": $("#pla_priv_usr_id").val(),
      "search_nom": $("#filter_utilisateur").val()
    };

    var data_search = {
      "zone": "gb",
      "action": "data_get_utilisateurs",
      "data": data_specific
    };

    var data_json = 'json=' + JSON.stringify(data_search);


    $.getJSON("/USR?action=pla_get_privileges", data_json, function (data) {

      if (data.length > 0) {

        $.each(data, function (key, value) {

          //console.log(value);

          if (UTL_Select_OptionExists(value.userid, 'pla_priv_usr_ids') == false) {

            $('#pla_priv_usr_ids').append('<option value="' + value.userid + '" ' + value.status + '>' + value.user_nom_prenom + '</option>');

          }

        });

      }

    }).done(function () {//success

    })
      .fail(function () { //error 

      })
      .always(function () { //complete


        $('#pla_priv_usr_ids').multiSelect('refresh');
        $('#iw_selected_list_title').html("Liste des utilisateurs autorisés");
        $('#iw_selectable_list_title').html("Liste des utilisateurs");




        // $.LoadingOverlay("hide"); 
      });




  }

  function User_PLA_Get_Autorisations() {

    var data_specific = {
      "id_selected": $('#pla_granted_users option:selected').val()
    };

    var data_search = {
      "zone": "gb",
      "action": "get_pla_autorisations",
      "data": data_specific
    };

    var data_json = 'json=' + JSON.stringify(data_search);

    $.getJSON("/USR?action=get_pla_autorisations", data_json, function (data) {

      if (data.length > 0) {

        $.each(data, function (key, value) {
          global_current_user_autorisation = value.autorisation;
        });
      }

    }).done(function () {//success
    })
    .fail(function () { //error           
    })
    .always(function () { //complete

      if (action_type == 'eventbyid') {

        id_event = getUrlParameter('id_event');

        $("#id_selected").val(id_event);

        DATA_GET_EVENT(id_event, false, true, true);

      }

    });

  }

  function Privileges_Get_Default() {



    //============================================//
    // Utilisateur
    //============================================//
    //  if( $('#pla_priv_usr_nom').val()==''){

    var data_specific = {
      "id_selected": $("#pla_priv_usr_id").val()
    };

    var data_search = {
      "zone": "gb",
      "action": "get_usr_info",
      "data": data_specific
    };

    var data_json = 'json=' + JSON.stringify(data_search);

    $.getJSON("/GB?action=get_usr_info", data_json, function (data) {
      if (data.length > 0) {
        $.each(data, function (key, value) {

          $('#pla_priv_usr_nom').val(value.user_nom_prenom);
          $('#pla_priv_usr_id').val(value.userid);
          $('#titre_popup_privileges').html('Privilèges : ' + value.user_nom_prenom);
        });
      }

    }).done(function () {//success
    })
      .fail(function () { //error           
      })
      .always(function () { //complete
      });

    //}

    //============================================//

  }

  function UTL_Select_OptionExists(element_value, element_id) {
    var exists = false;

    $('#' + element_id + '  option').each(function () {
      if (this.value == element_value) {
        exists = true;
      }
    });

    return exists;
  }

  function DATA_Settings_Get() {

    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });

    $.LoadingOverlay("show");
    $result = '';

    var data_specific = {
      "type": "structure",
      "pref_type": "planning_web_configuration"
    };

    var data_search = {
      "zone": "usr",
      "action": "get_preference",
      "data": data_specific
    };

    var data_json = 'json=' + JSON.stringify(data_search);

    $.getJSON("/USR?action=get_preference", data_json, function (data) {

      if (data.length > 0) {

        $.each(data, function (key, value) {

          $("#pref_sms_token").val(value.pref_value_1);
          $("#pref_sms_sender").val(value.pref_value_2);
          $("#pref_sms_message").val(value.pref_value_3);

        });

      }

    }).done(function () {//success

    })
    .fail(function () { //error 

    })
    .always(function () { //complete
      $.LoadingOverlay("hide");
    });

  }

  function DATA_GET_EVENT($id, $drag_event, $show_form, $load_data_popup) {

    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });


    $.LoadingOverlay("show");

    $('#titre_popup').html('Modification');


    var data_pla = {
      "id": $id
    };

    var data = {
      "zone": "usr",
      "action": "get_pla",
      "data": {
        "pla": data_pla
      }
    };

    //================= INIT =====================//
    $("#eve_titre").attr('value', '');
    $("#eve_notes").attr('value', '');
    $("#eve_usager_nom").attr('value', '');
    $("#eve_hb_id").attr('value', '');
    global_eve_owner_name = '';
    eve_date_du_iso = '';
    global_current_user_autorisation_event = '';

    eve_date_du = '';
    eve_date_au = '';
    eve_heure_du = '';
    eve_heure_au = '';

    var_eve_type = '';
    var_eve_presence = '';
    var_eve_rappel = '';
    var_eve_recurrence = '';

    var_eve_titre = '';
    var_eve_notes = '';
    var_eve_usager_nom = '';
    var_eve_hb_id = '';

    $('#eve_type').prop('selectedIndex', 0);
    $('#eve_presence').prop('selectedIndex', 0);
    $('#eve_rappel').prop('selectedIndex', 0);
    $('#eve_recurrence').prop('selectedIndex', 0);

    global_eve_hb_id = '';
    global_eve_hb_nom = '';
    global_eve_id = '';
    //=============================================//
    global_eve_owner_name = '';

    var data_json = 'json=' + JSON.stringify(data);

    $.getJSON("/USR?action=get_event", data_json, function (data) {

      $.each(data, function (key, value) {
        var_eve_titre = value.eve_titre;
        var_eve_notes = value.eve_notes;
        var_eve_usager_nom = value.eve_usager_nom;
        var_eve_hb_id = value.eve_hb_id;

        $("#eve_titre").attr('value', value.eve_titre);
        $("#eve_notes").attr('value', value.eve_notes);
        $("#eve_usager_nom").attr('value', value.eve_usager_nom);
        $("#eve_hb_id").attr('value', value.eve_hb_id);

        global_eve_owner_name = value.eve_owner_name;
        eve_date_du_iso = value.eve_date_du_iso;

        global_current_user_autorisation_event = value.privilege;

        if ($drag_event == false) {
          eve_date_du = UTL_Date_Format(value.eve_date_du, 2);
          eve_date_au = UTL_Date_Format(value.eve_date_au, 2);

          eve_heure_du = value.eve_heure_du;
          eve_heure_au = value.eve_heure_au;

          var_eve_type = value.eve_type;
          var_eve_presence = value.eve_presence;
          var_eve_rappel = value.eve_rappel;
          var_eve_recurrence = value.eve_recurrence;
        }

        global_eve_hb_id = $('#eve_hb_id').val();
        global_eve_hb_nom = $('#eve_usager_nom').val();
        global_eve_id = $('#id_selected').val();
      });

    }).done(function () {//success

    })
    .fail(function () { //error

    })
    .always(function () { //complete
      $.LoadingOverlay("hide");
      $('#titre_popup').html('Modification - ' + global_eve_owner_name);

      if (global_current_user_autorisation_event != 'readwrite') {
        $('#titre_popup').html('Visualisation - ' + global_eve_owner_name);
      }

      if ($drag_event == true) {
        Drag_Drop($id, $drag_event);
      }

      if (action_type == 'eventbyid') {
        Set_Preferences('planning_web_view', 'timeGridDay');

        pref_planning_web_view = 'timeGridDay';
        calendar.changeView(pref_planning_web_view);
        calendar.gotoDate(eve_date_du_iso);

        var newURL = location.href.split("&")[0];
        window.history.pushState('object', document.title, newURL);

        if ($show_form == true) {
          setTimeout(function () {
            FORM_EVENT_SHOW($id, false, $load_data_popup);
          }, 1000);
        }

        action_type = '';
        Calendar_scrollToTime(eve_heure_du);
      } else {

        if ($show_form == true) {
          FORM_EVENT_SHOW($id, false, $load_data_popup);
        }

      }

    });

  }

  $("#iw_btn_plan_create").click(function (ev) {
    FORM_EVENT_SHOW('', false, false);

    return false;
  });

  $("#iw_btn_plan_privileges").click(function (ev) {

    Privileges_Fiche();

    return false;

  });

  $("#iw_btn_plan_config").click(function (ev) {

    Configuration_Fiche();

    return false;

  });

  $("#iw_btn_plan_list").click(function (ev) {


    $(location).attr('href', '/USR?action=events-list');

    return false;

  });

  $("#iw_btn_plan_rappel").click(function (ev) {
    $(location).attr('href', '/USR?action=planning&rappel=1');

    return false;
  });

  $("#iw_btn_plan_activer_alert").click(function (ev) {
    $.LoadingOverlay("show");

		$.ajax({
			method: 'POST',
			url: "/4DACTION/outilsManageRetroPlanning",
			data: {
				"action": "getService"
			},
			success: function(response){
        var reponseParse = JSON.parse(response);

        $.confirm({
          title: 'Gestion des alertes',
          content: '<div id="AlertContent"></div>',
          buttons: {
            activerLesAlertes: {
              text: 'Activer les alertes',
							btnClass: 'btn-green',
              action: function (event) {
                
                if ($("#listFMGroupe").val() != "") {
                  var service_t = $("#listFMGroupe").val();

                  $.ajax({
                    method: 'POST',
                    url: "/4DACTION/outilsManageRetroPlanning",
                    data: {
                      "action": "checkParamAlert",
                      "service": $("#listFMGroupe").val(),
                      "hebergeReferenceID": $("#pla_granted_heberges").val()
                    },
                    success: function(response){
                      var reponseParse = JSON.parse(response);

                      if (reponseParse.notificationError != null) {

                        $.alert({
                          title: '',
                          content: reponseParse.notificationError,
                          icon: 'fa fa-error',
                          animation: 'scale',
                          closeAnimation: 'scale',
                          columnClass: 'iw_alert',
                          buttons: {
                            okay: {
                              text: 'Ok',
                              btnClass: 'btn-blue'
                            }
                          }
                        });
                        
                      }else{

                        $.confirm({
                          title: 'Activation des alertes',
                          content: 'Souhaitez-vous vraiment activer les alertes pour le service ' + service_t + ' ?',
                          buttons: {
                            formSubmit: {
                              text: 'Oui',
                              btnClass: 'btn-blue',
                              action: function () {
                                ActivateAlert(false);
                              }
                            },
                            cancel: {
                              text: 'Non',
                              action: function () {
                  
                              }
                            }
                          }
                        });

                      }
                      
                    }
                  });

                }else{

                  $.alert({
                    title: '',
                    content: 'Veuillez sélectionner un service !',
                    icon: 'fa fa-warning',
                    animation: 'scale',
                    closeAnimation: 'scale',
                    columnClass: 'iw_alert',
                    buttons: {
                      okay: {
                        text: 'Ok',
                        btnClass: 'btn-blue'
                      }
                    }
                  });
                  
                }

                return false;
              }
            },
						formSubmit: {
							text: 'Enregistrer',
							btnClass: 'btn-blue',
							action: function () {

                if ($("#listFMGroupe").val() != "") {
                  var formData = [];
                  var service_t = $("#listFMGroupe").val();

                  $(".body").each(function(){
                    var $this = $(this);

                    if ($this.find("input").length > 0) {
                      var rappelAvantEcheance = {};

                      $this.find(".cell").eq(3).find("input").each(function(index){

                        switch (index) {
                          case 0:
                            rappelAvantEcheance["15j"] = $(this).is(':checked');

                            break;
                          case 1:
                            rappelAvantEcheance["7j"] = $(this).is(':checked');
                            
                            break;
                          case 2:
                            rappelAvantEcheance["5j"] = $(this).is(':checked');
                            
                            break;
                          case 3:
                            rappelAvantEcheance["2j"] = $(this).is(':checked');
                            
                            break;
                          case 4:
                            rappelAvantEcheance["1j"] = $(this).is(':checked');
                            
                            break;
                          default:
                            break;
                        }
                      });

                      formData.push({
                        "dateReference": $this.find(".cell").eq(0).find("input").val(),
                        "centreID": $this.find(".cell").eq(1).find("input").val(),
                        "delaiAlerte": $this.find(".cell").eq(2).find("input").val(),
                        "rappelAvantEcheance": rappelAvantEcheance,
                        "rappelApresEcheance": $this.find(".cell").eq(4).find("input").is(':checked')
                      });
                    }

                  });
                  
                  bootbox.confirm('Souhaitez-vous vraiment enregistrer les paramètres « Alerte » pour le service ' + service_t + ' ?', "Non", "Oui", function(result) {

                    if (result == true) {
                      $.LoadingOverlay("show");

                      $.ajax({
                        method: 'POST',
                        url: "/4DACTION/outilsManageRetroPlanning",
                        data: {
                          "action": "saveAlertParam",
                          "hebergeReferenceID": $("#pla_granted_heberges").val(),
                          "dataAlertParam": formData
                        },
                        success: function(response){

                          $.alert({
                            title: 'Paramètres « Alerte » sauvegardés',
                            content: 'Les paramètres « Alerte » pour le service ' + service_t + ' ont bien été sauvegardés.',
                            icon: 'fa fa-success',
                            animation: 'scale',
                            closeAnimation: 'scale',
                            columnClass: 'iw_alert',
                            buttons: {
                              okay: {
                                text: 'Ok',
                                btnClass: 'btn-blue'
                              }
                            }
                          });

                          $.LoadingOverlay("hide");
                        }
                      });

                    }

                  });

                }else{

                  $.alert({
                    title: '',
                    content: 'Veuillez sélectionner un service !',
                    icon: 'fa fa-warning',
                    animation: 'scale',
                    closeAnimation: 'scale',
                    columnClass: 'iw_alert',
                    buttons: {
                      okay: {
                        text: 'Ok',
                        btnClass: 'btn-blue'
                      }
                    }
                  });
                  
                }

                return false;
							}
						},
            cancel: {
              text: 'Fermer',
              action: function () {
  
              }
            }
          },
          onContentReady: function () {
            var sel = $('<select id="listFMGroupe" class="g-mb-20">').appendTo('#AlertContent');
            sel.append($("<option>").attr('value',"").text("Sélectionnez un service"));

            $(reponseParse.service).each(function() {
              sel.append($("<option>").attr('value',this).text(this));
            });
                
            // Un peu de mise en forme
            $("#listFMGroupe").css("cssText", "width: 250px!important;");
            $(".jconfirm-type-default").css("cssText", "max-width: 100%!important;");

            $("#listFMGroupe").change(function(){
              $.LoadingOverlay("show");

              $.ajax({
                method: 'POST',
                url: "/4DACTION/outilsManageRetroPlanning",
                data: {
                  "action": "getAlertByService",
                  "service": $("#listFMGroupe").val(),
                  "hebergeReferenceID": $("#pla_granted_heberges").val()
                },
                success: function(response){
                  reponseParse = JSON.parse(response);

                  $("#int-alert-table").remove();
                  $('#listFMGroupe').after('<div id="int-alert-table" class="fdp_resp_table wrap-table100 iw-width-100 iw-bordered" style="overflow-x: auto;"></div>');

                  if (reponseParse.rows.length > 0) {
                    i = !0, $("#int-alert-table .table").empty(), $("#int-alert-table .iw-header").empty();

                    var header_t = '<div class="row header"><div class="cell fdp-min-width-60px">Date de référence</div><div class="cell fdp-min-width-320px">Nom de l\'alerte</div><div class="cell fdp-min-width-60px">Délai alerte (jour)</div><div class="cell" style="min-width: 320px;"><div class=\"rowB g-mx-0\"><div class=\"col-12\">Rappels avant échéance</div><div class=\"col\">15j</div><div class=\"col\">7j</div><div class=\"col\">5j</div><div class=\"col\">2j</div><div class=\"col\">1j</div></div></div><div class="cell" style="min-width: 110px;">Rappel après échéance</div><div class="cell" style="min-width: 60px;">Terminer</div></div>';
                    var body_t = "";

                    $(reponseParse.rows).each(function(index) {
                      var alternate = (index % 2 != 0) ? " iw_alternate" : "";
                      body_t += '<div class="row body' + alternate + '"><div class="cell" id="colf'+ this.id + '">'+ this.lc_dateReference + '</div><div class="cell" id="colf'+ this.id + '">'+ this.lc_alerteNom + '</div><div class="cell" id="colf'+ this.id + '">'+ this.lc_alerteDelai + '</div><div class="cell" id="colf'+ this.id + '">'+ this.lc_alerteAvantEcheance + '</div><div class="cell" id="colf'+ this.id + '">'+ this.lc_alerteApresEcheance + '</div><div class="cell" id="colf'+ this.id + '">'+ this.lc_alerteStop + '</div></div>'
                    });

                    $('<div class="table">' + header_t + body_t + '</div>').appendTo('#int-alert-table');

                    $('input[id*="alerteStop"]').change(function(){
                      var $this = $(this);
                      var $dateOfDay_d = formatDate(new Date());

                      const [day, month, year] = $dateOfDay_d.split('/');
                      const $dateOfDayIsoFormat_d = [year, month, day].join('-');

                      bootbox.dialog('<div class="rowB"><div class="col-12"><div class="control-group"> <label class="control-label-group">A partir de quelle date</label> <div class="controls "> <input data-val="" data-column="5" type="date" id="closeAlertDate" name="closeAlertDate" value="' + $dateOfDayIsoFormat_d + '" class="fdp_span3 search span7 datepicker iw_tag_width_sextuplet iw_data_column_5" data-date-format="dd/mm/yyyy" placeholder="dd/mm/yyyy" autocomplete="off"> </div> </div></div></div>', [
                        {
                          "label" : "Valider",
                          "class" : "btn-primary",
                          "callback": function() {

                            if ($("#closeAlertDate").val() != "") {
                              $.LoadingOverlay("show");

                              $.ajax({
                                method: 'POST',
                                url: "/4DACTION/outilsManageRetroPlanning",
                                data: {
                                  "action": "closeAlert",
                                  "service": $("#listFMGroupe").val(),
                                  "hebergeReferenceID": $("#pla_granted_heberges").val(),
                                  "centreID": extractNumber($this.attr("id")),
                                  "intervenantID": $('#pla_granted_users option:selected').val(),
                                  "closeAlertDate": $("#closeAlertDate").val()
                                },
                                success: function(response){
                                  reponseParse = JSON.parse(response);
                              
                                  if (reponseParse.notificationError != null) {
  
                                    $.alert({
                                      title: '',
                                      content: reponseParse.notificationError,
                                      icon: 'fa fa-error',
                                      animation: 'scale',
                                      closeAnimation: 'scale',
                                      columnClass: 'iw_alert',
                                      buttons: {
                                        okay: {
                                          text: 'Ok',
                                          btnClass: 'btn-blue'
                                        }
                                      }
                                    });
                                    
                                    $this.attr("checked", false);
                                  }else{
                                    $this.attr("disabled", true);
                                  }

                                  $.LoadingOverlay("hide");
                                }
                              });

                            }else{

                              $.alert({
                                title: '',
                                content: "La date renseignée est vide",
                                icon: 'fa fa-error',
                                animation: 'scale',
                                closeAnimation: 'scale',
                                columnClass: 'iw_alert',
                                buttons: {
                                  okay: {
                                    text: 'Ok',
                                    btnClass: 'btn-blue'
                                  }
                                }
                              });

                              return false;
                            }

                          }
                        },
                        {
                          "label" : "Annuler",
                          "class" : "btn-red",
                          "callback": function() {
                            $this.attr("checked", false);
                          }
                        }
                      ]);
                    });
                  }

                  $.LoadingOverlay("hide");
                }
              });
              
            });

            $.LoadingOverlay("hide");
          }
        });

      }
    });

  });

  $("#iw_btn_plan_search").click(function (ev) {
    $(location).attr('href', '/USR?action=events-list&usager=' + $('#filtre_nom_heberge').val() + '&type=' + $('#filtre_type').val() + '&presence=' + $('#filtre_presence').val() + '&titre=' + $('#filtre_titre').val() + '&date_du=' + $('#filtre_date_du').val() + '&date_au=' + $('#filtre_date_au').val() + '&proprietaire=' + $('#pla_granted_users option:selected').val());

    return false;
  });

  $("#iw_btn_plan_print").click(function (ev) {


    Print_Planning();

    return false;

  });

  $(document).on('click', '#btn_email_participant', function () {

    $.confirm({
      title: 'Notification',
      content: 'Vous être entrain d\'envoyer l\'email de notification de cet événement à tous les participants, Voulez-vous continuer ?',
      icon: 'fa fa-warning',
      animation: 'scale',
      closeAnimation: 'zoom',
      columnClass: 'iw_alert',
      buttons: {
        confirm: {
          text: 'Oui',
          btnClass: 'btn-orange',
          action: function () {
            Notification_Send("email", "user");
          }
        },
        cancel: {
          text: 'Non',
          action: function () {

          }
        }
      }
    });

    return false;
  });

  $(document).on('click', '#btn_sms_participant', function () {

    $.confirm({
      title: 'Notificaion',
      content: 'Vous être entrain d\'envoyer l\'SMS de notification de cet événement à tous les participants, Voulez-vous continuer ?',
      icon: 'fa fa-warning',
      animation: 'scale',
      closeAnimation: 'zoom',
      columnClass: 'iw_alert',
      buttons: {
        confirm: {
          text: 'Oui',
          btnClass: 'btn-orange',
          action: function () {

            Notification_Send("sms", "user");

          }
        },
        cancel: {
          text: 'Non',
          action: function () {


          }
        }
      }
    });

    return false;
  });

  $(document).on('click', '#btn_email_usager', function () {

    $.confirm({
      title: 'Notification',
      content: 'Vous être entrain d\'envoyer l\'email de notification de cet événement à l\'usager concerné, Voulez-vous continuer ?',
      icon: 'fa fa-warning',
      animation: 'scale',
      closeAnimation: 'zoom',
      columnClass: 'iw_alert',
      buttons: {
        confirm: {
          text: 'Oui',
          btnClass: 'btn-orange',
          action: function () {

            Notification_Send("email", "heberge");

          }
        },
        cancel: {
          text: 'Non',
          action: function () {


          }
        }
      }
    });

    return false;
  });

  $(document).on('click', '#btn_sms_usager', function () {

    $.confirm({
      title: 'Notification',
      content: 'Vous être entrain d\'envoyer l\'SMS de notification de cet événement à l\'usager concerné, Voulez-vous continuer ?',
      icon: 'fa fa-warning',
      animation: 'scale',
      closeAnimation: 'zoom',
      columnClass: 'iw_alert',
      buttons: {
        confirm: {
          text: 'Oui',
          btnClass: 'btn-orange',
          action: function () {

            Notification_Send("sms", "heberge");

          }
        },
        cancel: {
          text: 'Non',
          action: function () {

          }
        }
      }
    });

    return false;
  });

  $(document).on('click', '#btn_fiche_hg_create', function () {

    if (($("#eve_hb_id").val() != '0') && ($("#eve_usager_nom").val() != '')) {
      global_fiche_event_popup.close();
      Save_Record(true);

      $('#iw_form_popup').html(var_global_event_popup);
      Show_Popup_Fiche_HG();
    } else {

      $.alert({
        title: 'Erreur',
        content: 'Vous devez sélectionner un usager',
        icon: 'fa fa-warning',
        animation: 'scale',
        closeAnimation: 'scale',
        columnClass: 'iw_alert',
        buttons: {
          okay: {
            text: 'Ok',
            btnClass: 'btn-blue'
          }
        }
      });

    }

    return false;
  });

  function Print_Planning() {


    html2canvas(document.getElementById('fdp-content')).then(function (canvas) {

      document.body.appendChild(canvas);

      // Get base64URL
      var base64URL = canvas.toDataURL('image/jpeg').replace('image/jpeg', 'image/octet-stream');


    });
  }

  function Event_Drag_Drop($id, $date_du, $heure_du, $date_au, $heure_au) {

    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });


    $.LoadingOverlay("show");

    var data_pla = {
      "id": $id,
      "eve_date_du": $date_du,
      "eve_heure_du": $heure_du,
      "eve_date_au": $date_au,
      "eve_heure_au": $heure_au
    }

    var data = {
      "zone": "usr",
      "action": "set_pla",
      "data": {
        "pla": data_pla
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    var save_status = '';

    $.getJSON("/USR?action=pla_drop_save", data_json, function (data) {


      $.each(data, function (key, value) {

        save_status = value;

      });

    }).done(function () {//success

    })
      .fail(function () { //error

      })
      .always(function () { //complete
        $.LoadingOverlay("hide");

      });

  }

  function Set_Preferences($type, $value) {

    var data_pla = {
      "pref_type": $type,
      "pref_value": $value
    }

    var data = {
      "zone": "usr",
      "action": "set_pla",
      "data": {
        "pla": data_pla
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    $.getJSON("/USR?action=set_preference", data_json, function (data) {


      $.each(data, function (key, value) {


      });

    }).done(function () {//success

    })
    .fail(function () { //error

    })
    .always(function () { //complete
      Get_Preference('planning_web_view', false);
    });

  }

  function Notification_Send($type_notification, $type_envoi) {
    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });

    $.LoadingOverlay("show");

    var data_pla = {
      "type_notification": $type_notification,
      "type_envoi": $type_envoi,
      "id_event": $('#id_selected').val()
    }

    var data = {
      "zone": "usr",
      "action": "pla_notification_send",
      "data": {
        "pla": data_pla
      }
    };

    var save_status = '';
    var data_json = 'json=' + JSON.stringify(data);

    $.getJSON("/USR?action=pla_notification_send", data_json, function (data) {

      $.each(data, function (key, value) {
        save_status = value;
      });

    }).done(function () {//success

    })
      .fail(function () { //error

      })
      .always(function () { //complete

        if (save_status != 'Failed') {

          if ($type_notification == "sms") {
            $msg = 'L\'SMS a été envoyé avec succès.';
          } else {
            $msg = 'L\'email a été envoyé avec succès.';
          }

          $.alert({
            title: 'Notification',
            content: $msg,
            icon: 'fa fa-check',
            animation: 'scale',
            closeAnimation: 'scale',
            columnClass: 'iw_alert',
            buttons: {
              okay: {
                text: 'Ok',
                btnClass: 'btn-blue'
              }
            }
          });

        } else {

          $.alert({
            title: 'Erreur',
            content: 'L\'envoi a échoué, Veuillez vérifier les paramètres SMTP et réessayer.',
            icon: 'fa fa-remove',
            animation: 'scale',
            closeAnimation: 'scale',
            columnClass: 'iw_alert',
            buttons: {
              okay: {
                text: 'Ok',
                btnClass: 'btn-blue'
              }
            }
          });
        }

        $.LoadingOverlay("hide");


      });

  }

  function Event_Resize($id, $heure_au) {

    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });


    $.LoadingOverlay("show");

    var data_pla = {
      "id": $id,
      "eve_heure_au": $heure_au
    }

    var data = {
      "zone": "usr",
      "action": "set_pla",
      "data": {
        "pla": data_pla
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    var save_status = '';

    $.getJSON("/USR?action=pla_resize_save", data_json, function (data) {


      $.each(data, function (key, value) {

        save_status = value;

      });

    }).done(function () {//success

    })
      .fail(function () { //error

      })
      .always(function () { //complete
        $.LoadingOverlay("hide");

      });

  }

  function Event_Remove($recurring) {

    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });


    $.LoadingOverlay("show");

    var data_pla = {
      "id": $("#id_selected").val(),
      "recurring": $recurring
    };

    var data = {
      "zone": "usr",
      "action": "pla_event_remove",
      "data": {
        "pla": data_pla
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    var operation_status = '';

    $.getJSON("/USR?action=pla_event_remove", data_json, function (data) {


      $.each(data, function (key, value) {

        operation_status = value;

      });

    }).done(function () {//success

    })
      .fail(function () { //error

      })
      .always(function () { //complete
        $.LoadingOverlay("hide");

        if (operation_status == '-1') {

          $.confirm({
            title: 'Suppression',
            content: 'Il éxiste des événements récurrents liés à cet évenements, voulez-vous les supprimer également ?',
            icon: 'fa fa-warning',
            animation: 'scale',
            closeAnimation: 'zoom',
            columnClass: 'iw_alert',
            buttons: {
              confirm: {
                text: 'Oui',
                btnClass: 'btn-orange',
                action: function () {

                  Event_Remove('true');

                }
              },
              cancel: {
                text: 'Non',
                action: function () {

                  Event_Remove('false');
                }
              }
            }
          });


        }

        Refresh_Events();

      });

  }

  function Save_Record_Configuration() {

    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });


    $.LoadingOverlay("show");

    var data_pla = {
      "type": "structure",
      "pref_type": "planning_web_configuration",
      "pref_sms_token": $("#pref_sms_token").val(),
      "pref_sms_sender": $("#pref_sms_sender").val(),
      "pref_sms_message": $("#pref_sms_message").val()
    }

    var data = {
      "zone": "usr",
      "action": "set_settings",
      "data": {
        "pla": data_pla
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    var save_status = '';

    $.getJSON("/USR?action=set_preference", data_json, function (data) {


      $.each(data, function (key, value) {

        save_status = value;

      });

    }).done(function () {//success

    })
      .fail(function () { //error

      })
      .always(function () { //complete
        $.LoadingOverlay("hide");

        if (save_status != 'Failed') {

        } else {

          $.alert({
            title: 'Erreur',
            content: 'L\'enregistrement a échoué',
            icon: 'fa fa-remove',
            animation: 'scale',
            closeAnimation: 'scale',
            columnClass: 'iw_alert',
            buttons: {
              okay: {
                text: 'Ok',
                btnClass: 'btn-blue'
              }
            }
          });
        }



      });


  }

  function Form_HG_LISTE() {

    var data_search = {
      "id_event": $('#id_selected').val()
    }

    var data = {
      "zone": "usr",
      "action": "get_hg_liste",
      "data": {
        "pla": data_search
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    var data_exist = false;

    $.getJSON("/USR?action=get_hg_liste", data_json, function (data) {


      $('#event_hg_liste .table').empty();

      if (data.length > 0) {

        var resp_table_data = '';
        var css_class_row = '';
        var counter = 0;

        resp_table_data += '<div class="row header">';
        resp_table_data += '<div class="cell">';
        resp_table_data += 'N° Fiche';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell" style="min-width: 100px;">';
        resp_table_data += 'Date';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell" style="min-width: 100px;">';
        resp_table_data += 'Prestation';
        resp_table_data += '</div>';
        resp_table_data += '</div>';

        $.each(data, function (key, value) {

          data_exist = true;

          resp_table_data += '<div class="row body ' + css_class_row + '">';
          resp_table_data += '<div class="cell" id="' + value.id + '&hb_id=' + value.hb_id + '">';
          resp_table_data += value.hg_fichenumero;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '&hb_id=' + value.hb_id + '">';
          resp_table_data += value.date;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '&hb_id=' + value.hb_id + '">';
          resp_table_data += value.prestation;
          resp_table_data += '</div>';
          resp_table_data += '</div>';

        });

        $("#event_hg_liste .table").append(resp_table_data);



      }


    }).done(function () {//success

    })
      .fail(function () { //error

      })
      .always(function () { //complete

        $("#event_hg_liste div.cell").click(function (ev) {

          if (ev.target.id != '') {
            // $(location).attr('href', '/INT?action=usager-fiche&id='+ev.target.id);  
            window.open('/INT?action=usager-fiche&id=' + ev.target.id, '_blank');
          }

        });

      });

  }

  function Save_Record_Privileges($pref_type) {

    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });


    $.LoadingOverlay("show");

    var data_pla = {
      "id": $("#pla_priv_usr_id").val(),
      "pref_type": $pref_type,
      "pla_priv_usr_ids": $("#pla_priv_usr_ids").val(),
      "mode": privileges_mode_choisie
    }

    var data = {
      "zone": "usr",
      "action": "set_privileges",
      "data": {
        "pla": data_pla
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    var save_status = '';

    $.getJSON("/USR?action=set_preference", data_json, function (data) {


      $.each(data, function (key, value) {

        save_status = value;

      });

    }).done(function () {//success

    })
    .fail(function () { //error

    })
    .always(function () { //complete
      $.LoadingOverlay("hide");

      if (save_status != 'Failed') {
        Refresh_Events();
      } else {

        $.alert({
          title: 'Erreur',
          content: 'L\'enregistrement a échoué',
          icon: 'fa fa-remove',
          animation: 'scale',
          closeAnimation: 'scale',
          columnClass: 'iw_alert',
          buttons: {
            okay: {
              text: 'Ok',
              btnClass: 'btn-blue'
            }
          }
        });
      }

    });

  }

  function Save_Record($create_fiche_hg) {
    $.LoadingOverlaySetup({
      background: "rgba(0, 0, 0, 0.5)",
      imageColor: "#fff"
    });

    $.LoadingOverlay("show");

    var checkBoxRappelSelected_c = [];

    $(".eve_rappel:checked").each(function(){
      checkBoxRappelSelected_c.push($(this).attr('name'));
    });

    var data_irl = {
      "id": $("#id_selected").val(),
      "eve_date_du": $("#eve_date_du").val(),
      "eve_heure_du": $("#eve_heure_du").val(),
      "eve_date_au": $("#eve_date_au").val(),
      "eve_heure_au": $("#eve_heure_au").val(),
      "eve_hb_id": $("#eve_hb_id").val(),
      "eve_titre": $("#eve_titre").val(),
      "eve_notes": $("#eve_notes").val(),
      "eve_type": $("#eve_type").val(),
      "eve_presence": $("#eve_presence").val(),
      "eve_rappel": checkBoxRappelSelected_c,
      "eve_recurrence": $("#eve_recurrence").val(),
      "eve_participants_ids": $("#eve_participants_ids").val(),
      "eve_user_id_selected": $('#pla_granted_users option:selected').val()
    }

    var data = {
      "zone": "gl",
      "action": "set_pla",
      "data": {
        "pla": data_irl
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    var save_status = '';
    var save_id_event = '';

    $.getJSON("/USR?action=pla_fiche_valider", data_json, function (data) {
      var tmp_compteur_loop_event = 0;

      $.each(data, function (key, value) {

        if (tmp_compteur_loop_event == 0) {
          save_status = value;
        } else {
          save_id_event = value;
        }

        tmp_compteur_loop_event = tmp_compteur_loop_event + 1;

      });

    }).done(function () {//success

    })
    .fail(function () { //error

    })
    .always(function () { //complete
      $.LoadingOverlay("hide");

      if (save_status != 'Failed') {
        Refresh_Events();

        if ($create_fiche_hg == true) {
          $('#id_selected').val(save_id_event);
          DATA_GET_EVENT(save_id_event, false, false, true);
        }

      } else {

        $.alert({
          title: 'Erreur',
          content: 'L\'enregistrement a échoué',
          icon: 'fa fa-remove',
          animation: 'scale',
          closeAnimation: 'scale',
          columnClass: 'iw_alert',
          buttons: {
            okay: {
              text: 'Ok',
              btnClass: 'btn-blue'
            }
          }
        });
      }

    });
  }

  function Refresh_Events() {
    calendar.addEventSource('/USR?action=planning-data&userid=' + $('#pla_granted_users option:selected').val() + '&hb_id=' + $('#pla_granted_heberges option:selected').val());
    var eventSource = calendar.getEventSources();

    eventSource[0].remove();
    eventSource[0].refetch();
  }

  function ActivateAlert(forcePassage){
    $.LoadingOverlay("show");

    $.ajax({
      method: 'POST',
      url: "/4DACTION/outilsManageRetroPlanning",
      data: {
        "action": "activateAlert",
        "service": $("#listFMGroupe").val(),
        "hebergeReferenceID": $("#pla_granted_heberges").val(),
        "intervenantID": $('#pla_granted_users option:selected').val()
      },
      success: function(response){
        var reponseParse = JSON.parse(response);

        if (reponseParse.notificationError != null) {
          bootbox.alert(reponseParse.notificationError);
        }else{

          $.alert({
            title: '',
            content: 'Les alertes de l\'usager ' + $('#pla_granted_users option:selected').text() + 'pour le service ' + $("#listFMGroupe").val() + ' ont bien été activés.',
            icon: 'fa fa-success',
            animation: 'scale',
            closeAnimation: 'scale',
            columnClass: 'iw_alert',
            buttons: {
              okay: {
                text: 'Ok',
                btnClass: 'btn-blue',
                action: function () {
                  $(".jconfirm-buttons").find("button").eq(2).click();
                  document.location.reload(true);
                }
              }
            }
          });

        }

        $.LoadingOverlay("hide");
      }
    });

  }

  $('#pla_granted_users').on('change', function () {
    Refresh_Events();
    User_PLA_Get_Autorisations();
  });

  $('#pla_granted_heberges').on('change', function () {
    Refresh_Events();

    if ($(this).val() == "Tous") {
      $("#iw_btn_plan_activer_alert").addClass("d-none");
    }else{
      $("#iw_btn_plan_activer_alert").removeClass("d-none");
    }
  });

  //========================= End =====================//

  // Petite fonction pour extraire les chiffres d'une chaine de caractère
  function extractNumber(string) {
    var matches = string.match(/(\d+)/);

    if (matches) {
      return matches[0];
    }
  };

  function padTo2Digits(num) {
    return num.toString().padStart(2, '0');
  }
  
  function formatDate(date) {
    return [
      padTo2Digits(date.getDate()),
      padTo2Digits(date.getMonth() + 1),
      date.getFullYear(),
    ].join('/');
  }

});

function eve_centre_hgmodalOnLoad($scopeAngular_o){
	visiteur.prestationModalAngularList = $scopeAngular_o;
}

function eve_centre_hgmodalOnShownModal(){
	var $itemListHTML_t = "";

	if ($("#eve_centre_hgmodalCategoryButttonList").length == 0) {
		var $inputSearchModalDiv_j = $("#eve_centre_hgmodal").find(".search").eq(0).closest(".form-group");

		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});
	
		$.LoadingOverlay("show");

		$.ajax({
			method: 'POST',
			url: "/4DACTION/outilsWebEnumerationAjax",
			data: {
				"enumerationLib": "Centre: Catégorie"
			},
			success: function(response){
				var reponseParse = JSON.parse(response);
				console.log(reponseParse);
				
				$itemListHTML_t = '\
				<h3 class="text-center">Filtre par catégorie</h3>\
				<div id="eve_centre_hgmodalCategoryButttonList" class="rowB g-mb-10">'

				if (reponseParse.enumerationItem != null) {
					
					reponseParse.enumerationItem.forEach(item => {
						$itemListHTML_t += 
						'<div class="col-4">\
							<button class="fdp_Button fdp_btn_top categoryModalList" style="width: 100%!important" onclick="return false;">' + item + '</button>\
						</div>'
					});

				}

				$itemListHTML_t += 
				'\
					<div class="col-4">\
						<button class="fdp_Button fdp_btn_top categoryModalList" style="width: 100%!important" onclick="return false;">Toutes</button>\
					</div>\
				</div>'

				$($itemListHTML_t).insertAfter($inputSearchModalDiv_j);	
		
				$(".categoryModalList").click(function(){
					var $search_t = $(this).text();

					$(".categoryModalList").removeClass("fdp-btn-green");
					$(this).addClass("fdp-btn-green");

					$.LoadingOverlay("show");
					
					$("#eve_centre_hgmodal").find(".item-label").each(function(){
						$(this).closest("tr").hide();
						
						if ($search_t == "Toutes") {
							$(this).closest("tr").show();
						}else{
							var $line_o = searchInArrayObject(visiteur.prestationModalAngularList.list, "id", $(this).find("input").val());
							console.log($line_o);
	
							if ($line_o != null) {
	
								if ($line_o.categorie == $search_t) {
									$(this).closest("tr").show();
								}
								
							}
	
						}

					});

					$.LoadingOverlay("hide");
				});
	
				$.LoadingOverlay("hide");
			}
		});
	}

	$(".categoryModalList").removeClass("fdp-btn-green");
}