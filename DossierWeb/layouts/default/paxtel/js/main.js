$(document).ready(function () {

  /******************************************************************************************************************************/
  /*                               PLANNING WEB : RAPPEL DES EVENEMENTS A VENIR                                                 */
  /******************************************************************************************************************************/
  var display_rappel = getUrlParameter('rappel');
  var global_pla_rappel_popup = '';

  //PLA_Rappel('', '_instant');

  function PLA_Rappel($show_msg, $instant) {

    if (global_pla_rappel_popup != '') {
      global_pla_rappel_popup.close();
    }

    var main_table_data = '';

    main_table_data = '<div id="pla_rappel_parent">'
    main_table_data = main_table_data + '<div id="pla_rappel" class="iw_table_notification fdp_resp_table  iw-alternance-only ">'
    main_table_data = main_table_data + '<div class="table iw_data_table table table-striped table-advance">'
    main_table_data = main_table_data + '</div>'
    main_table_data = main_table_data + '</div>'
    main_table_data = main_table_data + '</div>'

    $("#pla_rappel_parent").remove();

    $("#fdp-content .container .content").append(main_table_data);

    var data_search = '';

    var data = {
      "zone": "USR",
      "action": "get_pla_rappel",
      "data": {
        "usagers": data_search
      }
    };

    var data_json = 'json=' + JSON.stringify(data);

    var data_exist = false;

    $.getJSON("/USR?action=get_pla_rappel" + $instant, data_json, function (data) {
      $('#pla_rappel .table').empty();

      if (data.length > 0) {
        var resp_table_data = '';
        var css_class_row = '';
        var counter = 0;

        resp_table_data += '<div class="row header">';
        resp_table_data += '<div class="cell">';
        resp_table_data += 'Nom de l\'évenement';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell">';
        resp_table_data += 'Usager';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell">';
        resp_table_data += 'Type';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell" style="min-width: 100px;">';
        resp_table_data += 'Présence';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell" style="min-width: 100px;">';
        resp_table_data += 'Date du';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell" style="min-width: 100px;">';
        resp_table_data += 'Heure du';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell" style="min-width: 100px;">';
        resp_table_data += 'Date au';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell" style="min-width: 100px;">';
        resp_table_data += 'Heure au';
        resp_table_data += '</div>';
        resp_table_data += '<div class="cell" style="min-width: 100px;">';
        resp_table_data += 'Temps restant';
        resp_table_data += '</div>';
        resp_table_data += '</div>';

        $.each(data, function (key, value) {
          data_exist = true;

          resp_table_data += '<div class="row body ' + css_class_row + '">';
          resp_table_data += '<div class="cell" id="' + value.id + '">';
          resp_table_data += value.eve_titre;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '">';
          resp_table_data += value.eve_hb_nomprenom;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '">';
          resp_table_data += value.eve_type;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '">';
          resp_table_data += value.eve_presence;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '">';
          resp_table_data += value.eve_date_du;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '">';
          resp_table_data += value.eve_heure_du;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '">';
          resp_table_data += value.eve_date_au;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '">';
          resp_table_data += value.eve_heure_au;
          resp_table_data += '</div>';
          resp_table_data += '<div class="cell" id="' + value.id + '">';
          resp_table_data += '<span class="label label-sm label-red">';
          resp_table_data += value.eve_temps_restant;
          resp_table_data += '</span>';
          resp_table_data += '</div>';
          resp_table_data += '</div>';
        });

        $("#pla_rappel .table").append(resp_table_data);
      }

    }).done(function () {//success
    })
    .fail(function () { //error
    })
    .always(function () { //complete

      if (data_exist == true) {
        Show_Rappel_Popup();
      }else {

        if ($show_msg == 'true') {

          $.alert({
            title: 'Information',
            content: 'Pas de rappel concernant les événements à venir.',
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
      }
    });

  }

  function Show_Rappel_Popup() {
    var var_popup = $('#pla_rappel_parent').html();
    $('#pla_rappel_parent').html('');

    global_pla_rappel_popup = $.confirm({
      title: 'Planning : Rappel des événements à venir',
      content: '' +
        '<div>' + var_popup +
        '</div>',
      buttons: {
        cancel: {
          text: 'Fermer',
          action: function () {
            $('#pla_rappel_parent').html(var_popup);
          }
        },
      },
      onContentReady: function () {
        var jc = this;
        this.$content.find('form').on('submit', function (e) {
          e.preventDefault();
          jc.$$formSubmit.trigger('click'); // reference the button and click it
        });

        $("#pla_rappel div.cell").click(function (ev) {

          if (ev.target.id != '') {
            $(location).attr('href', '/USR?action=planning&atype=eventbyid&id_event=' + ev.target.id);
          }

        });

        // Un peu de mise en forme
        $(".jconfirm-type-default").css("cssText", "max-width: 100%!important;");
      }
    });

  }

  if (display_rappel == '1') {
    var newURL = location.href.split("&")[0];

    PLA_Rappel('true', '');
    window.history.pushState('object', document.title, newURL);
  }

  /*window.setInterval(function () {
    PLA_Rappel('', '_instant');
  }, 60 * 1000);*/

  clearInterval();

  /******************************************************************************************************************************/
  /* Disable form submission via Enter key 
  /****************************************/

  jQuery('input').keypress(function (event) {
    var enterOkClass = jQuery(this).attr('class');

    if (event.which == 13 && enterOkClass != 'enterSubmit') {
      event.preventDefault();
      return false;
    }
  });

});  