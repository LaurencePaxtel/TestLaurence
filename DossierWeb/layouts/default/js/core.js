function Check_Required_Fields($array) {
  var result = false;

  $.each($array, function (key, value) {
    $('#' + value).removeClass('fdp-invalid');

    if (($('#' + value).val() == '') || ($('#' + value).val() == '0')) {
      $('#' + value).addClass('fdp-invalid');

      result = true;
    }

  });

  return result;
}

function IW_bootstrapSwitch($id) {

  $("#" + $id).bootstrapSwitch({

    onSwitchChange: function (event, state) {
      var champ = document.getElementById($id);

      if (($('#' + $id).bootstrapSwitch('state')) == true) {
        champ.setAttribute("value", true);
      }else{
        champ.setAttribute("value", false);
      }

    }

  });

}

function IW_bootstrapSwitch_LK($id, $id_related) {

  $(document).ready(function(){

    if ($("#" + $id).is(":checked") == false) {
      
      if ($id_related != "") {
        $('#' + $id_related).prop('readonly', true);
        $('#' + $id_related).val('');
      }

    }
    
  });

  $("#" + $id).bootstrapSwitch({

    onSwitchChange: function (event, state) {
      var champ = document.getElementById($id);

      if (($('#' + $id).bootstrapSwitch('state')) == true) {
        champ.setAttribute("value", true);

        if ($id_related != "") {
          $('#' + $id_related).prop('readonly', false);
        }
        
      }else{
        champ.setAttribute("value", false);

        if ($id_related != "") {
          $('#' + $id_related).prop('readonly', true);
          $('#' + $id_related).val('');
        }

      }

    }

  });

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
function Select_Set_Selected_Val($field, $valeur) {
  $($field + '_hidden').attr('value', $valeur);
}

function Set_Input_Value($field, $value) {
  $($field).attr('value', iw_round($value));
  $($field).data("dataval");
  $($field).data('dataval', $value);
}

function Get_Input_DataValue($field) {
  var value_return = $($field).data("dataval");

  if (typeof value_return === "undefined") {
    value_return = $($field).val();
  }

  return value_return;
}

function Get_Separator($value1, $value2) {
  var $sep = '';

  if (($value1 != '') && ($value2 != '')) {
    $sep = ' / ';
  }

  return $sep;
}

function Mark_All_Required_Fields($array) {
  var result = false;

  $.each($array, function (key, value) {
    $('#' + value).removeClass('fdp-invalid-default');
    $('#' + value).removeClass('fdp-invalid').addClass('fdp-invalid');

    result = true;
  });

  return result;
}

function Mark_All_Required_Fields_Default($array) {
  var result = false;

  $.each($array, function (key, value) {
    $('#' + value).removeClass('fdp-invalid-default').addClass('fdp-invalid-default');

    result = true;
  });

  return result;
}

function Unmark_All_Required_Fields($array) {
  var result = false;

  $.each($array, function (key, value) {
    $('#' + value).removeClass('fdp-invalid');
    result = true;
  });

  return result;
}

function isDayTime() {
  var hours = new Date().getHours();
  var isDayTime = hours > 6 && hours < 20;

  return isDayTime;
}

function getDateNow() {
  var d = new Date();
  var strDate = d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear();

  return strDate;
}

function getDateNow_FC() {
  var d = new Date();
  var strDate = d.getFullYear() + "-" + IW_Two_Digits((d.getMonth() + 1)) + "-" + d.getDate();

  return strDate;
}

function IW_Two_Digits(myNumber) {
  myNumber = myNumber.toString();

  if (myNumber.length < 2) {
    return "0" + myNumber;
  }

  return myNumber;
}

function getDateData($date) {
  var $result = '';

  if ($date != null) {
    $result = $date.substring(8, 10) + "/" + $date.substring(5, 7) + "/" + $date.substring(0, 4);

    if ($result == '00/00/0000') {
      $result = '';
    }

  }

  return $result;
}

function Date_GetYear($date) {
  var iNum_String = $date.substring(0, 4);
  var iNum = parseInt(iNum_String);

  return iNum;
}

function Date_GetMonth($date) {
  var iNum_String = $date.substring(5, 7);
  var iNum = parseInt(iNum_String);

  return iNum;
}

function Date_GetDay($date) {
  var iNum_String = $date.substring(8, 10);
  var iNum = parseInt(iNum_String);

  return iNum;
}

function Get_Date_Formatted($date) {
  var $result = '';

  if (($date == '00-00-00') || ($date == '00/00/00')) {
    $result = '';
  }else{
    $result = $date.replace(/-/g, "/");
  }

  return $result;
}

function getExtension(filename) {
  return '.' + filename.split('.').pop().toLowerCase();
}

function UTL_Date_Picker_Formatted($date, $field, $readwrite_status = '') {
  var $result = Get_Date_Formatted($date);

  if (($readwrite_status == '') || ($readwrite_status == 'readwrite')) {

    $($field).datepicker({
      format: 'dd/mm/yyyy'
    });

    if ($result == '') {

      $($field).datepicker({
        dateFormat: "dd/mms/yyyy", changeMonth: true,
        changeYear: true, yearRange: '1900:2020'
      }).val('');

    }else{
      $($field).datepicker('update', $result);
    }

  }else{
    $($field).val($result);
  }

}

function UTL_Date_Format($date, $case) {
  $result = '';

  switch ($case) {
    case 1:
      $result = $date.substring(6, 10) + "-" + $date.substring(3, 5) + "-" + $date.substring(0, 2);
      break;
    case 2:
      $result = $date.substring(8, 10) + "/" + $date.substring(5, 7) + "/" + $date.substring(0, 4);
      break;
    case 3:
      $result = $date.substring(0, 4) + "-" + $date.substring(5, 7) + "-" + $date.substring(8, 10);
      break;
    default:
      break;
  }

  return $result;
}

function UTL_minTwoDigits(n) {
  return (n < 10 ? '0' : '') + n;
}

function UTL_Time_Picker_Formatted($date, $field, $readwrite_status = '') {
  var $result = Get_Date_Formatted($date);

  $result = $result.substring(6, 10) + "-" + $result.substring(3, 5) + "-" + $result.substring(0, 2);
  console.log($result);

  if (($readwrite_status == '') || ($readwrite_status == 'readwrite')) {
    $($field).datetimepicker('setStartDate', $result + ' 00:00:00');
    $($field).datetimepicker('setEndDate', $result + ' 23:59:59');
    $($field).datetimepicker('update');
  }

}

function iw_round(value) {

  if (value != null) {
    var value = parseFloat(value.toString().replace(",", "."));
    return parseFloat(Math.round(value * 100) / 100).toFixed(2);    
  }else{
    return 0.00;
  }

}

function Init_Autocomplete($id_field, $id_hidden, $module, $action) {

  $($id_field).autocomplete({
    source: function (request, response) {
      var str_request_term = request.term;
      str_request_term = $.trim(str_request_term);

      var tb_request_term = str_request_term.split(' ');

      if (tb_request_term.length == 2) {

        var data_specific = {
          "data_first": tb_request_term[0],
          "data_second": tb_request_term[1]
        };

      }else{

        var data_specific = {
          "data_first": str_request_term,
          "data_second": ''
        };

      }

      var data_search = {
        "zone": "globale",
        "action": "get_autocomplete",
        "data": data_specific
      };

      var data_json = '&json=' + JSON.stringify(data_search);

      $.ajax({
        type: "GET",
        url: "/" + $module + "?action=" + $action,
        dataType: "json",
        data: data_json,
        contentType: "application/json; charset=utf-8",
        success: function (data) {
          response($.map(data, function (item) {

            return {
              id: item.id,
              value: item.value
            }

          }));
        }
      });
    },
    minLength: 0,
    select: function (event, ui) {
      $($id_hidden).val(ui.item.id).trigger('change');
      $($id_field).val(ui.item.value);

      return false;
    }
  }).focus(function () {
    setTimeout("if ($('" + $id_field + "').val().length == 0) $('" + $id_field + "').autocomplete(\"search\", \"\"); ", 1);
  }).blur(function (event) {
    var autocomplete = $(this).data("autocomplete");

    if (autocomplete.selectedItem) {
      autocomplete._trigger("select", event, {
        item: autocomplete.selectedItem
      });

      Autocomplete_After();
    }

  });

}

function Init_Autocomplete_Usagers($id_field, $id_hidden, $module, $action) {

  $($id_field).autocomplete({
    source: function (request, response) {
      var str_request_term = request.term;
      str_request_term = $.trim(str_request_term);

      var tb_request_term = str_request_term.split(' ');

      if (tb_request_term.length == 2) {

        var data_specific = {
          "data_first": tb_request_term[0],
          "data_second": tb_request_term[1]
        };

      } else {

        var data_specific = {
          "data_first": str_request_term,
          "data_second": ''
        };

      }

      var data_search = {
        "zone": "globale",
        "action": "get_autocomplete",
        "data": data_specific
      };

      var data_json = '&json=' + JSON.stringify(data_search);

      $.ajax({
        type: "GET",
        url: "/" + $module + "?action=" + $action,
        dataType: "json",
        data: data_json,
        contentType: "application/json; charset=utf-8",
        success: function (data) {
          response($.map(data, function (item) {

            return {
              id: item.id,
              value: item.value,
              value_plus: item.value_plus
            }

          }));
        }
      });
    },
    minLength: 0,
    select: function (event, ui) {
      $($id_hidden).val(ui.item.id).trigger('change');
      $($id_field).val(ui.item.value);

      console.log('--' + ui.item.value_plus);
      $($id_field).removeClass('iw_bold');

      if (ui.item.value_plus != '') {
        $($id_field).addClass('iw_bold');
      }

      return false;
    }
  }).focus(function () {
    setTimeout("if ($('" + $id_field + "').val().length == 0) $('" + $id_field + "').autocomplete(\"search\", \"\"); ", 1);
  }).blur(function (event) {
    var autocomplete = $(this).data("autocomplete");

    if (autocomplete.selectedItem) {
      autocomplete._trigger("select", event, {
        item: autocomplete.selectedItem
      });

      Autocomplete_After();

    }

  }).data('autocomplete')._renderItem = function (ul, item) {

    if (item.value_plus != '') {
      return jQuery("<li></li>")
        .data("item.autocomplete", item)
        .append("<a><b>" + item.value + "</b></a>")
        .appendTo(ul);
    }else{
      return jQuery("<li></li>")
        .data("item.autocomplete", item)
        .append("<a>" + item.value + "</a>")
        .appendTo(ul);
    }
  };

}

Autocomplete_After = function () {
}

function parseDate(str) {
  var mdy = str.split('/')
  return new Date(mdy[1], mdy[2], mdy[3]);
}

function daydiff(first, second) {
  return (second - first) / (1000 * 60 * 60 * 24)
}

function Popup_Scroll_Manager() {
  var $html = $(document.documentElement);
  $html.css('overflow', 'hidden');
}

function IW_checkboxManage($this) {
  var $this_id = $($this).attr('id');
  document.getElementById($this_id + "_checked_value").value = "";

  var checkboxes = document.getElementsByTagName('input');

  for (var i = 0, n = checkboxes.length; i < n; i++) {

    if (checkboxes[i].checked) {

      if (checkboxes[i].id == $this_id) {
        document.getElementById($this_id + "_checked_value").value = checkboxes[i].value;
      }

    }

  }

}

function IW_Remove(EId) {
  var element = document.getElementById(EId);

  if (typeof (element) != 'undefined' && element != null) {
    return (EObj = document.getElementById(EId)) ? EObj.parentNode.removeChild(EObj) : false;
  }

}

function getUrlParameter(name) {
  name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');

  var regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
  var results = regex.exec(location.href);

  return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, '    '));
};

$(function () {

  $("#table1").tablesorter({
    theme: 'blue',
    widgets: ['zebra', 'reflow'],
    widgetOptions: {
      // class name added to make it responsive (class name within media query)
      reflow_className: 'ui-table-reflow',
      // header attribute containing modified header name
      reflow_headerAttrib: 'data-name',
      // data attribute added to each tbody cell
      // it contains the header cell text, visible upon reflow
      reflow_dataAttrib: 'data-title'
    }
  });

  // simple reflow widget + columnSelector & stickyHeaders widgets
  $("#table2").tablesorter({
    theme: 'blue',
    widgets: ['zebra', 'reflow', 'columnSelector', 'stickyHeaders'],
    widgetOptions: {
      // target the column selector markup
      columnSelector_container: $('#columnSelector'),
      // data attribute containing column name to use in the selector container
      // make it use the same as reflow_headerAttrib
      columnSelector_name: 'data-name',

      // header attribute containing modified header name
      reflow_headerAttrib: 'data-name'
    }
  });

  // reflow2 widget (table with multiple header rows)
  $("#table3").tablesorter({
    theme: 'blue',
    widgets: ['zebra', 'reflow2'],
    widgetOptions: {
      // class name added to make it responsive (class name within media query)
      reflow2_className: 'ui-table-reflow',
      // ignore header cell content with this class name
      reflow2_classIgnore: 'ui-table-reflow-ignore',
      // header attribute containing modified header name
      reflow2_headerAttrib: 'data-name',
      // class name applied to thead labels
      reflow2_labelClass: 'ui-table-cell-label',
      // class name applied to first row thead label
      reflow2_labelTop: 'ui-table-cell-label-top'
    }
  });

});

// Petite fonction pour charger des <option> dans un <select>
function chargeValueInSelect(idElement, url, data) {
	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	$.ajax({
		method: 'POST',
		url: url,
		data: data,
		success: function(response){
			var reponseParse = JSON.parse(response);
			console.log(reponseParse);

			incrementSelect(idElement, reponseParse.data);
			$.LoadingOverlay("hide");
		}
	});
}

// Petite fonction pour incrémenter un select
function incrementSelect(idElement, content) {
  var select = document.getElementById(idElement);

  // Réinitialiser l'élément <select>
  select.innerHTML = '';

  // Ajouter l'option initiale
  var initialOption = document.createElement('option');
  
  initialOption.value = '';
  initialOption.textContent = 'Sélection d\'un élément';
  select.appendChild(initialOption);

  content.forEach(function(option) {
    var optionElement = document.createElement('option');

    optionElement.value = option.value;
    optionElement.textContent = option.lib;
    select.appendChild(optionElement);
  });
}

function WritePopup(nomDocument, data_o) {
  var $data_o = {
    "action": "createNewVersion",
    "nomDocument": nomDocument
  };

  $data_o = Object.assign($data_o, data_o);
  console.log($data_o);
  
  $('#titre_popup_4DWritePopup').html('Édition du document ' + nomDocument);

  $.ajax({
    method: 'POST',
    url: "/4DACTION/outilsWProSendAjax",
    data: $data_o,
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
        $("#4DWriteIframe").attr("src", reponseParse["modelePath"]);

        $.confirm({
          title: '',
          content: '<div id="4DWriteContent"></div>',
          buttons: {
            cancel: {
              text: 'Fermer',
              action: function () {
                $("#4DWriteDiv").appendTo(".fdp_child");
                $('#4DWriteIframe').css('cssText', 'display: none !important');
              }
            },
            print: {
              text: 'Imprimer',
              btnClass: 'btn-blue',
              action: function(){
                $("#4DWriteIframe").get(0).contentWindow.print();
                return false;
              }
            }
          },
          onContentReady: function () {
            var jc = this;
            this.$content.find('form').on('submit', function (e) {
              e.preventDefault();
    
              jc.$$formSubmit.trigger('click'); // reference the button and click it
            });
            
            $("#4DWriteDiv").appendTo("#4DWriteContent");
            $('#4DWriteIframe').css('cssText', 'display: block !important; width: 21cm; margin: 0 auto;');
            //================================================================================//
          }
        });
        
      }

    }
  });

}