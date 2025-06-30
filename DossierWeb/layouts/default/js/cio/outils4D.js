//////////////////////////////////////
// Fonction générique
//////////////////////////////////////

// Petite fonction pour nettoyer les nombres avant traitement.
function getNombre(idNombre) {
  var valInput = ($(idNombre).is("input")) ? $(idNombre).val() : $(idNombre).text();

  // Attention je remplace les espaces simple et espace insécable.
  return (valInput == '') ? 0 : parseFloat(valInput.replace(/ /g, '').replace(/ /g, '').replace(',', '.')).toFixed(2);
};

// Petite fonction pour inserer un nombre dans la page format français.
function setNombre(valNombre) {
  // 2 chiffres après  la virgule
  // remplacement du point par une virgule
  // ajout d'un espace après 3 chiffres
  return valNombre.toFixed(2).replace(".", ",").replace(/\B(?=(\d{3})+(?!\d))/g, " ");
};

// Petite fonction qui permet de remplacer un bout de chaine par une autre avec toutes les occurences de la première chaine
function replaceAll(str, find, replace) {
  return str.replace(new RegExp(find, 'g'), replace);
};

// Petite fonction pour retourner le nombre de ligne dans un tableau
$.fn.rowCount = function () {
  return $('tr', $(this).find('tbody')).length;
};

// Petite fonction pour retourner le nombre de colonne dans un tableau
$.fn.columnCount = function () {
  return $('th', $(this).find('tr')).length;
};

// Petite fonction jQuery pour retourner le type d'un élément (input, select, textarea)
$.fn.getType = function(){
  return this[0].tagName == "INPUT" ? this[0].type.toLowerCase() : this[0].tagName.toLowerCase();
};

// Petite fonction jQuery qui permet de forcer la sérialisation de tous les inputs [disabled inclus]
$.fn.serializeIncludeDisabled = function () {
  var disabled = this.find(":input:disabled").removeAttr("disabled");
  var serialized = this.serialize();

  disabled.attr("disabled", "disabled");
  return serialized;
};

// Petite fonction pour extraire les chiffres d'une chaine de caractère
function extractNumber(string) {
  var matches = string.match(/(\d+)/);

  if (matches) {
    return matches[0];
  }
};

// Petite fonction qui active ou désactive un bouton ou input
function switchEnabled(nameInput, activation) {

  if (activation == true) {
      $(nameInput).prop("disabled", true);
  } else {
      $(nameInput).prop("disabled", false);
  }

}

// Petite fonction qui active ou désactive un ou plusieurs bouton et/ou input
function switchEnabledMultipleElement(nameInputs, activation) {

  nameInputs.forEach(nameInput => {

    if (activation == true) {
      $(nameInput).prop("disabled", true);
    } else {
      $(nameInput).prop("disabled", false);
    }

  });

}

// Petite fonction qui exécute une requête ajax
function ajaxRequest(method, url, data, asynchronous) {

if (typeof asynchronous == 'undefined') {
  asynchronous = true;
}

return $.ajax({
    method: method,
    url: url,
    async: asynchronous, //blocks or not window close
    data: data,
    success: function (response) {
      console.log(response);
    },
    error : function(response, statut, error){
      console.log(response);
      console.log(statut);
      console.log(error);
    }
  });

}

// Petite fonction qui exécute une requête http de manière asynchro
function xmlRequest(method, url, data, asynchronous)
{
  var xmlHttp = new XMLHttpRequest();
  xmlHttp.onreadystatechange = function() { 
      if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
        return xmlHttp.responseText;
      }
  }
  xmlHttp.open(method, url, asynchronous); // true for asynchronous 
  xmlHttp.send(data);
}

// ----- Init de l'objet de récupération des datas 4D -----
var data4D = {};

data4D.debugConsole = function (message) {
  if (this.debugMode) {
      console.log(message);
  }
};

// Petite fonction qui permet d'ajouter ou supprimer une ligne dans un tableau
function arrangeTable(idTable, valuetoCheck, response){
  var contentHtml = "";

  var table = $('table' + idTable +' > tbody');
  var element = table.find('tr:has(td:contains("' + valuetoCheck + '"))');

  if ((element.length) && (element !== undefined)) {
    alert("L'élément sélectionné est déjà présent !");
    return false;
  }else{
    contentHtml = "<tr>";

    // Non compatible IE 11
    /*Object.entries(response).forEach(([propriete, valeur]) => {
        contentHtml += "<td>" + valeur + "</td>";
    });*/

    for(prop in response){
      contentHtml += "<td>" + response[prop] + "</td>";
    }

    contentHtml += "</tr>"
    $("table.table tbody").append(contentHtml);
    
    return true;
  }

}

// Petite fonction qui extrait la chaine "PK" d'une ligne de la liste quand il y a l'icone voir avec l'url détail
function extractPK(a) {
var positionDetail = a.indexOf("/detail/");
var a = a.substring(positionDetail + 8)

var positionHtml = a.indexOf(".html");
var entityPK = a.substring(0,positionHtml)

return entityPK;
};

// Petite fonction qui effectue des actions par rapport à (aux) élément(s) (dé)sélectionné(s) dans un tableau type dataTable
function manipTableauSelectedPK(tableauListe,action,element,urlDoubleClic){

switch (action) {
  case "ajouter":
    (function() {
      var positionEntitySelection = selectedPK.indexOf(element);

      if (positionEntitySelection == -1) {
        selectedPK.push(element);
      }
    })();

  break;
  case "supprimer":
    (function() {
      var positionEntitySelection = selectedPK.indexOf(element);

      if (positionEntitySelection != -1) {
        selectedPK.splice(positionEntitySelection,1);
      }
    })();   
  break;
  case "selectionner":
    (function() {
      // Juste avant de passer à la moulinette mon tableau je vais enlever la valeur -1 si elle a été mise juste avant
      manipTableauSelectedPK([],"supprimer",-1)

      tableauListe.forEach(function(item){       
        var entitySelection = JSON.stringify( item );
        
        if (item.hasOwnProperty('DT_RowId')) {
          var entityPK = item.DT_RowId;
        } else {
          var entityPK = extractPK(entitySelection);
        }
        
        manipTableauSelectedPK([],"ajouter",entityPK)
      });  
    })();

    break;
  case "toutSelectionner":
    (function() {
      // On réinitialise le tableau des PK sélectionnés
      selectedPK = [];

      manipTableauSelectedPK([],"ajouter",-1)  

      allSelectedPKTempo = tableauListe;
    })();

    break;
  case "deselectionner":
    (function() {
      // Juste avant de passer à la moulinette mon tableau je vais enlever la valeur -1 si elle a été mise juste avant
      manipTableauSelectedPK([],"supprimer",-1)

      if (allSelectedPKTempo.length > 0) {
        selectedPK = [];

        manipTableauSelectedPK(allSelectedPKTempo,"selectionner");

        // On réinitialise également le tableau des PK toutSelectionner temporaire
        allSelectedPKTempo = [];
      };

      tableauListe.forEach(function(item){       
        var entitySelection = JSON.stringify( item );
        
        if (item.hasOwnProperty('DT_RowId')) {
          var entityPK = item.DT_RowId;
        } else {
          var entityPK = extractPK(entitySelection);
        }

        manipTableauSelectedPK([],"supprimer",entityPK)
      });
    })();

    break;
  case "reset":
  case "toutDeselectionner":
    (function() {
      // On réinitialise le tableau des PK sélectionnés
      selectedPK = [];

      // On réinitialise également le tableau des PK toutSelectionner temporaire
      allSelectedPKTempo = [];
    })();

    break;
  case "doubleClic":
    (function() { 
      tableauListe.forEach(function(item){       
        var entitySelection = JSON.stringify( item );
        
        if (item.hasOwnProperty('DT_RowId')) {
          var entityPK = item.DT_RowId;
        } else {
          var entityPK = extractPK(entitySelection);
        }

        urlDoubleClic = urlDoubleClic.replace(/entityPK/g, entityPK);
        window.location = urlDoubleClic;
      });  
    })();

    break;
  default:
    break;
}

if ((action !="ajouter") && (action != "supprimer") && (action != "doubleClic") && (action != "reset")) {
  envoieTableauSelectedPK();
}
};

// Petite fonction qui permet d'effectuer un test si un objet a une valeur spécifique peu importe la propriété
function findValue(object, value) {
var retour = false

for (var property in object) {
    if (object.hasOwnProperty(property) && object[property] === value) {
        retour = true;
    }
}

return retour;
}

// Petite fonction pour savoir si un objet a une propriété spécifique
function verifyProperty(object, property) {
  return property in object;
}

// Petite fonction pour savoir si un tableau d'objet a pour une propriété particulière une valeur particulière
function searchInArrayObject(arrayObject, property, value, typeReturn, comparisonOperator){
  var $comparisonOperator = "==";

  switch (typeReturn) {
    case "boolean":
      var retour = false;

      break;
    case "arrayObject":
      var retour = [];

      break;
    default:
      var retour = null;

      break;
  }

  if (typeof comparisonOperator != 'undefined') {
    $comparisonOperator = comparisonOperator;
  }

  for (var i=0; i < arrayObject.length; i++) {

      if (arrayObject[i].hasOwnProperty(property) == true) {
        
        switch ($comparisonOperator) {
          case "==":

            if (String(arrayObject[i][property]) == String(value)) {
          
              switch (typeReturn) {
                case "boolean":
                  retour = true;
            
                  break;
                case "arrayObject":
                  retour.push(arrayObject[i]);
            
                  break;
                default:
                  retour = arrayObject[i];
                  retour.indice = i;
            
                  break;
              }
              
            }

            break;
          case "!=":

            if (String(arrayObject[i][property]) != String(value)) {
          
              switch (typeReturn) {
                case "boolean":
                  retour = true;
            
                  break;
                case "arrayObject":
                  retour.push(arrayObject[i]);
            
                  break;
                default:
                  retour = arrayObject[i];
                  retour.indice = i;
            
                  break;
              }
              
            }

            break;
          default:
            break;
        }

      }

  }

  return retour;
}

// Petite fonction qui vérifie que pour chaque date dans un formulaire est conforme au format JJ/MM/AAAA
function dateValidateInForm(idFormulaire){
  var validerFormulaire = true;

  // Je boucle sur tous mes inputs de type texte
  $("#" + idFormulaire +" input[type=text]").each(function() {

    // Je récupère le nom de l'attribut input
    var nameInput = $(this).attr("name");

    // Je regarde si ce nom contient Date
    if(nameInput.indexOf("Date") != -1){

      // Si c'est le cas, je regarde s'il est actuellement visible et non vide
      if (($(this).is(":visible") == true) && ($(this).val() != "")) {

        if (moment($(this).val(), 'DD/MM/YYYY',true).isValid() == false) {

          if (this.nextElementSibling != null) {
            var errorAlert = this.nextElementSibling.innerHTML;

            if (errorAlert.includes("Veuillez respecter le format requis") == false) {
              $( "<span class=\"g-color-primary\">Veuillez respecter le format requis</span>" ).insertAfter($(this)); 
            }
          }else{
            $( "<span class=\"g-color-primary\">Veuillez respecter le format requis</span>" ).insertAfter($(this));
          }

          validerFormulaire = false;
        }else{

          if (this.nextElementSibling != null) {
            var errorAlert = this.nextElementSibling.innerHTML;

            if (errorAlert.includes("Veuillez respecter le format requis") == true) {
              this.nextElementSibling.remove();
            }   
          }

        }

      }

    }
  });

  // Si tous les champs de type date sont au bon format
  if (validerFormulaire == true) {
    return true;
  }else{      
    return false;
  }
}

// Petite fonction qui ré-initialise tous les champs d'un formulaire
function resetFieldInForm(idFormulaire, inputIDException){
  console.log(inputIDException);

  $("form#" + idFormulaire +" :input").each(function() {

    if (typeof $(this).attr("name") != 'undefined') {

      switch ($(this).getType()) {
        case "radio":
        case "checkbox":
  
          if (typeof inputIDException != 'undefined') {

            if (inputIDException.indexOf($(this).attr("id")) == -1) {
              $(this).prop("checked",false);
            }
  
          }else{
            $(this).prop("checked",false);
          }
  
          break;
        case "hidden":
  
          break;
        default:
  
          if (typeof inputIDException != 'undefined') {
  
            if (inputIDException.indexOf($(this).attr("id")) == -1) {
              $(this).val("");
            }
  
          }else{
            $(this).val("");
          }
  
          break;
      }

    }

  })

}

// Petite fonction qui met en statut "readOnly" ou non tous les champs d'un formulaire
function readOnlyFieldInForm(idFormulaire, action){

  $("form#" + idFormulaire +" :input").each(function(index, value) {

    switch ($(this).getType()) {
      case "radio":
      case "checkbox":
      case "select":
      case "submit":
      case "button":

        if (action == true) {
            $(this).attr('disabled', true);
        }else{
            $(this).removeAttr('disabled');
        }

        break;
      case "hidden":

        break;
      default:

        if (action == true) {
            $('[name="' + value.name + '"]').prop('readonly', action);
        }else{
            $('[name="' + value.name + '"]').removeAttr('readonly');
        }

        break;
    }

  });

}

// Petite fonction qui passe un input à required et rajoute un "*"
function inputDoRequired(nameInput){

	// On regarde si l'input existe
	if ($("#" + nameInput).length > 0) {
  
	  // Si c'est le cas, je regarde s'il contient bien une valeur
	  if (($("#" + nameInput).getType() == "text") || ($("#" + nameInput).getType() == "textarea") || ($("#" + nameInput).getType() == "select")) {
      var contentHTML = $("label[for='" + nameInput + "']").html();
    
      if (contentHTML.indexOf("required") == -1) {
        $("label[for='" + nameInput + "']").html(contentHTML+"<span class=\"required\">&nbsp;*</span>");
        $("#" + nameInput).attr("required", true);
      };
	  };
  
	  if ($("#" + nameInput).getType() == "radio") {
      var contentHTML = $("span[for='" + nameInput + "']").html();
    
      if (contentHTML.indexOf("required") == -1) {
        $("span[for='" + nameInput + "']").html(contentHTML+"<span class=\"required\">&nbsp;*</span>");
        $("#" + nameInput).attr("required", true);
      };
	  };
  
	};
  
}

// Petite fonction qui supprime à un input le statut "required" et enlève "*"
function inputRemoveRequired(nameInput){

  // On regarde si l'input existe
  if ($("#" + nameInput).length > 0) {

    // Si c'est le cas, je regarde s'il contient bien une valeur
    if (($("#" + nameInput).getType() == "text") || ($("#" + nameInput).getType() == "textarea") || ($("#" + nameInput).getType() == "select")) {
      var contentHTML = $("label[for='" + nameInput + "']").html();

      if (contentHTML.indexOf("required") != -1) {
        $("label[for='" + nameInput + "'] > span").remove();
        $("#" + nameInput).attr("required", false);
      };
    };

    if ($("#" + nameInput).getType() == "radio") {
      var contentHTML = $("span[for='" + nameInput + "']").html();

      if (contentHTML.indexOf("required") != -1) {
        $("span[for='" + nameInput + "'] > span").remove();
        $("#" + nameInput).attr("required", false);
      };
    };

  };

}

// Petite fonction permet de rajouter ou supprimer un message à la volée après un champ <input />
function addRemoveMessageInputInForm(nameInput, instruction, message, forcePassage){
  var $addMessage_b = false;

	// Je vérifie si l'input est visible
	if (($("#" + nameInput).is(":visible") == true) || (forcePassage == true)) {
    var errorAlert = $("#" + nameInput).next().html();

		if (instruction == "ajouter") {

      if (errorAlert == undefined) {
        $addMessage_b = true;
      }else{

        if (errorAlert.includes(message) == false) {
          $addMessage_b = true;
        }

      }

			if ($addMessage_b == true) {
				$( "<span class=\"g-color-primary\">" + message + "</span>" ).insertAfter($("#" + nameInput)); 
			}

		}else{

      if (errorAlert != undefined) {
       
        if (errorAlert.includes(message) == true) {
          $("#" + nameInput).next().remove();
        }
        
      }

		}

	}
}

// Petite fonction qui permet d'afficher/masquer un ensemble input + label
function hideShowInput(nameInput, show){
  var input_c = [];

  if (typeof nameInput == "string") {
    input_c.push(nameInput);
  }else{
    input_c = nameInput;
  }
  
  for (var i = 0; i < input_c.length; i++) {

    if (show == true) {
      $("#" + input_c[i]).closest(".row").show();
    }else{
      $("#" + input_c[i]).closest(".row").hide();
    }

  }

}

// Petite fonction qui met un séparateur pour à chaque palier de millier, exemple 1000 -> 1 000
function formatNumber(number, separator) {
  return number.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1'+separator)
}

// Petite fonction qui met en forme un nombre au format €
function numberInFormatEuro(number){
  return new Intl.NumberFormat('fr-FR', {style: 'currency', currency: 'EUR'}).format(parseFloat(number));
}

// Petite fonction qui retourne pour un nombre donné, un nombre avec le nombre de décimale mis en paramètre
function numberMaxDecimal(number, decimal) {
  var numberArround = number.toFixed(decimal);
  return parseFloat(numberArround);
}

// Petite fonction pour ajouter un nombre de jours à une date
function addDays(date, jours) {
  var result = new Date(date);

  result.setDate(result.getDate() + jours);
  return result;
}

// Petite fonction pour ajouter un nombre de mois à une date au format YYYY-MM-JJ
function addMonths(date, mois) {
  var result = new Date(date);

  result.setMonth(result.getMonth() + mois);
  return result;
}

// Petite fonction qui retourne le nombre de mois entre deux dates au format JS
function monthDiff(d1, d2) {
  var months;

  months = (d2.getFullYear() - d1.getFullYear()) * 12;
  months -= d1.getMonth() + 1;
  months += d2.getMonth();
  return months <= 0 ? 0 : months;
}

// Petite fonction qui retourne le nombre de mois entre deux dates au format YYYY-MM-JJ
function monthDiffNew(d1, d2) {
  var debut = new Date(d1);
  var fin = new Date(d2);

  var differenceEnMois = (fin.getFullYear() - debut.getFullYear()) * 12 + (fin.getMonth() - debut.getMonth());
  return differenceEnMois;
}

// Petite fonction qui retourne le nombre de jours entre deux dates au format YYYY-MM-JJ
function dayDiffNew(d1, d2) {
  var debut = new Date(d1);
  var fin = new Date(d2);

  // Calcul de la différence en millisecondes
  var differenceEnMillisecondes = fin - debut;

  // Conversion des millisecondes en jours (1 jour = 24 heures * 60 minutes * 60 secondes * 1000 millisecondes)
  var differenceEnJours = differenceEnMillisecondes / (1000 * 60 * 60 * 24);
  return differenceEnJours;
}

// Fonction qui transforme une date du format YYYY-MM-JJ à JJ/MM/AAAA
function dateToJJMMYYYY(dateToTransform){
  var newDate = "";

  console.log("date au format YYYY-MM-JJ : " + dateToTransform);

  if (dateToTransform != "" && dateToTransform != undefined) {
    var thisDate = dateToTransform.split('-');
    newDate = [thisDate[2],thisDate[1],thisDate[0] ].join("/");
  }

  return newDate;
}

// fonction qui transforme une date du format JJ/MM/AAAA à YYYY-MM-JJ
function dateToYYYYMMJJ(dateToTransform){
  var newDate = "";

  console.log("date au format JJ/MM/AAAA : " + dateToTransform);

  if (dateToTransform != "") {
    var thisDate = dateToTransform.split('/');
    newDate = [thisDate[2],thisDate[1],thisDate[0] ].join("-"); 
  }

  return newDate;
}

// Fonction qui transforme une date du format JS à JJ/MM/AAAA
function dateJSToJJMMYYYY(date) {
  var day = date.getDate();
  var month = date.getMonth() + 1; // Les mois sont indexés à partir de 0, donc on ajoute 1
  var year = date.getFullYear();

  // Ajoute un zéro devant le jour et le mois si nécessaire
  if (day < 10) {
    day = '0' + day;
  }
  if (month < 10) {
    month = '0' + month;
  }

  // Retourne la date au format texte JJ/MM/AAAA
  return day + '/' + month + '/' + year;
}

// Fonction qui transforme une date du format JS à YYYY-MM-JJ
function dateJSToYYYYMMJJ(date) {
  var year = date.getFullYear();
  var month = date.getMonth() + 1; // Les mois sont indexés à partir de 0, donc on ajoute 1
  var day = date.getDate();

  // Ajoute un zéro devant le mois et le jour si nécessaire
  if (month < 10) {
    month = '0' + month;
  }
  
  if (day < 10) {
    day = '0' + day;
  }

  // Retourne la date au format texte AAAA-MM-JJ
  return year + '-' + month + '-' + day;
}

// Fonction qui transforme une date du format JS à HH:MM
function dateJSToHHMM(date) {
  var heures = date.getHours();
  var minutes = date.getMinutes();

  var heureFormattee = `${heures.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}`;
  return heureFormattee;
}

// Petite fonction qui permet de savoir si une date est supérieure à une autre au format YYYY-MM-JJ
function isGreaterDate(d1, d2) {
  var isGreater = new Date(d1) > new Date(d2);
  return isGreater;
}

// Petite fonction pour savoir si une date au format YYYY-MM-DD est bonne
function isDateValid(dateString) {
  var date = new Date(dateString);

  return !isNaN(date);
}

// Petite fonction pour extraire une date au format JJ/MM/AAAA d'une chaine de caractère
function extraireDate(chaine) {
  var pattern = /\b\d{2}\/\d{2}\/\d{4}\b/; // Expression régulière pour trouver le format de date JJ/MM/AAAA
  var matches = chaine.match(pattern);

  if (matches) {
    var date = matches[0];
    return date;
  } else {
    return null; // Retourne null si aucune date n'est trouvée dans la chaîne
  }
  
}

// Petite fonction qui clean un nombre, exemple '1 000,56' -> 1000.56 ne marche pas avec les nombre créer avec numberInFormatEuro, il faut utiliser la fonction parseLocaleNumber à la place
function cleanNumber(number) {
  return number.toString().replaceAll(/ /g, '').replaceAll(/ /g, '').replaceAll(',', '.');
}

// Petite fonction qui retourne la date au format long (JJ/MM/AAAA en paramètre)
function longFormatDate(date) {
  var dateElements = date.split("/");
  var jour = parseInt(dateElements[0], 10);
  var mois = parseInt(dateElements[1], 10);
  var annee = parseInt(dateElements[2], 10);

  var nomsMois = [
    "janvier", "février", "mars", "avril", "mai", "juin",
    "juillet", "août", "septembre", "octobre", "novembre", "décembre"
  ];

  var dateTransformee = jour + " " + nomsMois[mois - 1] + " " + annee;
  return dateTransformee;
}

/**
 * Parse a localized number to a float.
 * @param {string} stringNumber - the localized number
 * @param {string} locale - [optional] the locale that the number is represented in. Omit this parameter to use the current locale.
 */
function parseLocaleNumber(stringNumber, locale) {
  var thousandSeparator = Intl.NumberFormat(locale).format(11111).replace(/\p{Number}/gu, '');
  var decimalSeparator = Intl.NumberFormat(locale).format(1.1).replace(/\p{Number}/gu, '');

  return parseFloat(stringNumber
      .replace(new RegExp('\\' + thousandSeparator, 'g'), '')
      .replace(new RegExp('\\' + decimalSeparator), '.')
  );
}

// Petite fonction qui désactive le premier choix d'un select lors d'un changement
function disabledFirstChoiceInSelect(id){
  
  if ($('#' + id).find("option:eq(0)").val() == "") {
    $('#' + id).find("option:eq(0)").prop('disabled', true);     
  }

}

// Petite fonction pour faire le téléchargement d'un fichier
function downloadFile(uri, name) {
  var link = document.createElement("a");

  link.download = name;
  link.href = uri;

  document.body.appendChild(link);
  link.click();

  document.body.removeChild(link);
  delete link;
}

// Petite fonction pour imprimer le contenu d'un element
function printElement(idElement, title) {
  var divToPrint = document.getElementById(idElement);
  var htmlToPrint = '' +
    '<style type="text/css">' +
    'table th, table td {' +
    'border:1px solid #000;' +
    'padding;0.5em;' +
    '}' +
    '</style>';
  htmlToPrint += divToPrint.outerHTML;

  newWin = window.open("");
  newWin.document.write("<h3 align='center'>" + title + "</h3>");
  newWin.document.write(htmlToPrint);
  newWin.print();
  newWin.close();
}

// Petite fonction pour imprimer le contenu d'un element
// Voir exemple sur : http://jsfiddle.net/95ezN/3/
function printElementBasedToMooTools(element, title, append, delimiter) {
  var domClone = element.cloneNode(true);
  var $printSection = document.getElementById("printSection");

  if (!$printSection) {
    var $printSection = document.createElement("div");
    $printSection.id = "printSection";
    document.body.appendChild($printSection);
  }

  if (append !== true) {
    $printSection.innerHTML = "<h3 align='center'>" + title + "</h3>";
  }else if (append === true) {

    if (typeof(delimiter) === "string") {
      $printSection.innerHTML += delimiter;
    }else if (typeof(delimiter) === "object") {
      $printSection.appendChlid(delimiter);
    }

  }

  $printSection.appendChild(domClone);
}

function printTag(idElement) {
  var hashid = "#"+ idElement;
  var tagname =  $(hashid).prop("tagName").toLowerCase() ;
  var attributes = ""; 
  var attrs = document.getElementById(idElement).attributes;

  $.each(attrs,function(i,elem){
    attributes +=  " "+  elem.name+" ='"+elem.value+"' " ;
  })

  var divToPrint= $(hashid).html() ;
  var head = "<html><head>"+ $("head").html() + "</head>" ;
  var allcontent = head + "<body  onload='window.print()' >"+ "<" + tagname + attributes + ">" +  divToPrint + "</" + tagname + ">" +  "</body></html>"  ;
  var newWin = window.open('','Print-Window');

  newWin.document.open();
  newWin.document.write(allcontent);
  newWin.document.close();
  setTimeout(function(){newWin.close();},10);
}

// Petite fonction pour imprimer le contenu d'un modal
function printModal(idElement) {
  var elementModal = document.getElementById(idElement);
  var cloneModal = elementModal.cloneNode(true);

  // Récupérer tous les éléments de formulaire dans le contenuModal cloné
  var elementsFormulaire = cloneModal.querySelectorAll('input, textarea, select');

  // Parcourir les éléments de formulaire clonés et mettre à jour leur valeur
  for (var i = 0; i < elementsFormulaire.length; i++) {
    var element = elementsFormulaire[i];

    if (element.type !== 'hidden') {

      if (element.tagName === 'TEXTAREA') {
        element.textContent = element.value; // Utilisez textContent pour les éléments textarea
      } else if (element.tagName === 'INPUT' || element.tagName === 'SELECT') {
        element.setAttribute('value', element.value);
      }

      element.setAttribute('readonly', 'readonly');
      element.removeAttribute('id'); // Supprimez l'ID pour éviter les doublons dans le document imprimé
    }
  }

  var contenuModal = cloneModal.outerHTML;

  // Créer une nouvelle fenêtre pour l'impression
  var fenetreImprimer = window.open('', 'Print-Window');

  // Construire le contenu HTML à imprimer
  var htmlContent = '<html><head><title>Impression</title>';

  // Récupère tous les fichiers CSS utilisés dans la page
  var fichiersCSS = [];
  var balisesCSS = document.querySelectorAll('link[rel="stylesheet"]');

  for (var i = 0; i < balisesCSS.length; i++) {
    var href = balisesCSS[i].href;

    fichiersCSS.push(fetch(href).then(function(response) {
      return response.text();
    }));
  }

  Promise.all(fichiersCSS).then(function(cssArray) {
    // Ajouter les fichiers CSS au contenu HTML à imprimer
    cssArray.forEach(function(cssContent) {
      htmlContent += '<style>' + cssContent + '</style>';
    });

    htmlContent += '</head><body onload="window.print(); window.close();">' + contenuModal + '</body></html>';

    // Écrire le contenu HTML dans la fenêtre d'impression
    fenetreImprimer.document.open();
    fenetreImprimer.document.write(htmlContent);
    fenetreImprimer.document.close();
  });
}

// Petite fonction pour supprimer le contenu d'une ligne d'un tableau
function clearRowInTable(idElement, rowIndex, columnToKeep){

  return new Promise(function(resolve, reject) {
    $('#' + idElement + ' > tbody').find("tr:eq(" + rowIndex + ")").find("td").each(function(index){

      if (columnToKeep.indexOf(index) == -1) {
        $(this).text("");
      }
      
    });

    resolve(true);

    /*
      // Appel de la fonction de callback après la suppression
      if (window[idElement + "CallBackafterClear"] && typeof window[idElement + "CallBackafterClear"] === 'function') {
        resolve(window[idElement + "CallBackafterClear"](rowIndex));
      }else{
        reject(new Error("Fonction de callback non définie pour idElement : " + idElement));
      }
    */
  });

}

// Petite fonction pour trouver l'index de la première ligne où parmis les éléments de ses colonnes il y en a qui contient une class particulière
function findRowIndex(idElement, className) {
  var tableau = document.getElementById(idElement);
  var tbody = tableau.querySelector('tbody');
  var lignes = tbody.querySelectorAll('tr');

  for (var i = 0; i < lignes.length; i++) {
    var derniereColonne = lignes[i].cells[lignes[i].cells.length - 1];

    if (derniereColonne.querySelector('.' + className)) {
      return i;
    }
  }

  return -1; // Retourne -1 si aucune ligne ne correspond à la condition
}

// Petite fonction pour ajouter des lignes et des colonnes à un tableau <table> ainsi qu'éventuellement le contenu de chaque cellule
function addRowToTable(idElement, rowCount, columnCount, content) {
  var table = document.getElementById(idElement);
  var tbody = table.querySelector("tbody");

  if (!tbody) {
    tbody = document.createElement("tbody");
    table.appendChild(tbody);
  }


  // Ajouter les lignes
  for (var i = 0; i < rowCount; i++) {
    var row = tbody.insertRow(i);
    
    // Ajouter les colonnes pour chaque ligne
    for (var j = 0; j < columnCount; j++) {
      var cell = row.insertCell(j);
      var contenu = content && content[i] && content[i][j] ? content[i][j] : "";

      cell.textContent = contenu;
    }
  }
}

// Petite fonction qui supprime les lignes d'un tableau <table> à partir de la dernière ligne jusqu'à ce qu'il reste le nombre de ligne spécifié
function deleteRowToTable(idElement, lineCountToKeep) {
  var table = document.getElementById(idElement);
  var tbody = table.querySelector("tbody");

  if (!tbody) {
    return; // Aucun tbody trouvé, aucune ligne à supprimer
  }

  var line = tbody.getElementsByTagName("tr");
  var lineCountToDelete = Math.max(0, line.length - lineCountToKeep);

  for (var i = 0; i < lineCountToDelete; i++) {
    tbody.deleteRow(line.length - 1 - i);
  }

}

// Petite fonction qui permet de remplir le contenu de chaque cellule à partir d'un tableau
function setContentToTable(idElement, cellContent) {
  var table = document.getElementById(idElement);
  var tbody = table.querySelector("tbody");

  if (!tbody) {
    return; // Aucun tbody trouvé, aucune cellule à remplir
  }

  var line = tbody.getElementsByTagName("tr");

  for (var i = 0; i < line.length; i++) {
    var cell = line[i].getElementsByTagName("td");

    for (var j = 0; j < cell.length; j++) {
      var content = cellContent[i * cell.length + j];

      switch (true) {
        case content == null || content == "00/00/0000":
          cell[j].innerHTML = "";

          break;
        case content !== "":
          cell[j].innerHTML = content;

          break;
        default:
          break;
      }

    }
  }
}

// Petite fonction qui permet de remplir le contenu de chaque cellule à partir d'un tableau pour une ligne spécifique
function setContentToTableForSpecificRow(idElement, rowIndex, cellContent) {
  var table = document.getElementById(idElement);
  var tbody = table.querySelector("tbody");

  if (!tbody) {
    return; // Aucun tbody trouvé, aucune cellule à remplir
  }

  var line = tbody.getElementsByTagName("tr");

  if (rowIndex >= 0 && rowIndex < line.length) {
    var cell = line[rowIndex].getElementsByTagName("td");

    for (var j = 0; j < cell.length; j++) {
      var content = cellContent[j] || "";

      switch (true) {
        case content == null || content == "00/00/0000":
          cell[j].innerHTML = "";

          break;
        case content !== "":
          cell[j].innerHTML = content;

          break;
        default:
          break;
      }

    }
  }
}

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

// Petite fonction pour supprimer une class dans tous les éléments dans lesquels elle s'y trouve
function deleteClass(className) {
  var elements = document.getElementsByClassName(className);

  for (var i = 0; i < elements.length; i++) {
    elements[i].classList.remove(className);
  }
}

// Petite fonction qui vide de toutes les class et de son id
function deleteClassAndIDOnJqueryElement(jqueryElement) {

  return new Promise(function(resolve, reject) {
    jqueryElement.removeClass(); // Supprime toutes les classes
    jqueryElement.removeAttr('id'); // Supprime l'ID

    // Résoudre la Promesse
    resolve();
  });

}

// Petite fonction pour convertir tous les <br> en retour à la ligne
function convertBrToNewLine(text) {
  var regex = /<br\s*\/?>/gi;
  return text.replace(regex, "\n");
}

// Petite fonction qui transforme une heure de type HHMMSS à HHMM
function timeToHHMM(timeString) {
  var regex = /^(\d{2}:\d{2}):\d{2}$/;
  var match = timeString.match(regex);

  if (match && match.length === 2) {
    return match[1];
  } else {
    return null;
  }

}

// Petite fonction pour savoir si une chaine est bien un numéro de téléphone dans un indicatif de pays particulier
function estNumeroTelephone(numeroTelephone, pays) {
  console.log(numeroTelephone);
  console.log(pays);

  switch (true) {
    case (pays == "FR"):
      var regex = /^(0|\+33)[1-9]([-. ]?[0-9]{2}){4}$/; // Expression régulière pour vérifier le format d'un numéro de téléphone français
      break;
    default:
      break;
  }

  console.log(regex);
  return regex.test(numeroTelephone);
}

// Petite fonction pour savoir si une chaine de caractère est bien un nombre
function stringIsNumber(string){
  return /^\d+$/.test(string);
}

// Petite fonction pour mettre à jour le tableau de type DataTable des notes d'un hébergé
function updateDataTableNote(data_o){
  $('#tabToDeleteModalNote').remove();
	$('#tabInsertAfterModalNote').after( "<div id=\"tabToDeleteModalNote\" style=\"height: 400px; max-height: 400px\"> <table id=\"noteTable\" class=\"table table-bordered\" style=\"width:100%\"><thead> <tr> <th>N° note</th>  <th>Type de note</th> <th>Date</th> <th>Note</th> <th>Utilisateur</th></tr></thead></table></div>" );

	dataTable_o = data_o;

	var tableauModalNote = $('#noteTable').DataTable({
		"dom": '<"rowB"<"col-12"B><"col-xl-6 col-md-6 col-12"i><"col-xl-6 col-md-6 col-12 g-pt-10"f>>t<"rowB"<"col-xl-6 col-md-6 col-12"l><"col-xl-6 col-md-6 col-12"p>>',
		buttons: [
			{
				text: 'Tout afficher',
				className: 'fdp_Button fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right',
				attr:  {
				  id: 'toutAfficher'
				}
			},
		],
		"select": {
			style: 'single'
		},
		"language": {
			"sProcessing": "Traitement en cours...",
			"sSearch": "Rechercher dans le tableau&nbsp;:",
			"sLengthMenu": "Afficher _MENU_ &eacute;l&eacute;ments",
			"sInfo": "Affichage de l'&eacute;l&eacute;ment _START_ &agrave; _END_ sur _TOTAL_ &eacute;l&eacute;ments (accessible(s))",
			"sInfoEmpty": "Affichage de l'&eacute;l&eacute;ment 0 &agrave; 0 sur 0 &eacute;l&eacute;ment (accessible(s))",
			"sInfoFiltered": "(filtr&eacute; de _MAX_ &eacute;l&eacute;ments au total)",
			"sInfoPostFix": "",
			"sLoadingRecords": "Chargement en cours...",
			"sZeroRecords": "Aucun &eacute;l&eacute;ment &agrave; afficher",
			"sEmptyTable": "Aucune donn&eacute;e disponible dans le tableau",
			"oPaginate": {
				"sFirst": "Premier",
				"sPrevious": "Pr&eacute;c&eacute;dent",
				"sNext": "Suivant",
				"sLast": "Dernier"
			},
			"oAria": {
				"sSortAscending": ": activer pour trier la colonne par ordre croissant",
				"sSortDescending": ": activer pour trier la colonne par ordre d&eacute;croissant"
			},
			"select": {
				"rows": {
					_: "%d lignes séléctionnées",
					0: "Aucune ligne séléctionnée",
					1: "1 ligne séléctionnée"
				}
			},
			"buttons": {
				"copyTitle": 'Ajouté au presse-papiers',
				"copyKeys": 'Appuyez sur <i>ctrl</i> ou <i>\u2318</i> + <i>C</i> pour copier les données du tableau à votre presse-papiers. <br><br>Pour annuler, cliquez sur ce message ou appuyez sur Echap.',
				"copySuccess": {
				  _: '%d lignes copiées',
				  1: '1 ligne copiée'
				}
			}
		},
		"lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "Tout"]],
		"aaSorting": [],
		// Il s'agit ici des datas en chargement de la page.
		"ajax": {
			"url": "/4DACTION/outilsWebHebergeListeAjax",
			"data": function ( d ) {
				console.log(dataTable_o);
				return dataTable_o;
			},
			beforeSend: function(){

				// Ajout d'un message de loading en attendant que la requête ajax soit finie (S'EXECUTE A CHAQUE FOIS)
				$('#noteTable > tbody').html(
					'<tr class="odd">' +
					'<td valign="top" colspan="6" class="dataTables_empty"><i class="fa fa-spinner fa-spin fa-2x fa-fw"></i> Chargement en cours...</td>' +
					'</tr>'
				);
	
			}
		},
		"rowCallback": function( row, data ) {
			console.log(data);
			$(row).addClass("cursor");
			$(row).find("td:eq(0)").append('<input type="hidden" name="noteEditUUID" value="' + data[5] + '" /><input type="hidden" name="noteEditTime" value="' + data[6] + '" /> <input type="hidden" name="noteEditPrivilege" value="' + data[7] + '" />')
		}
	});

  $("#toutAfficher").click(function(){
    $("#typeNote").val("");
    $("#keyword").val("");
    $("#noteDu").val("");
    $("#noteAu").val("");

    dataTable_o = {
      "hebergeID": $('#record_id').val(),
      "action": "chargeNote",
      "typeNote": $("#typeNote").val(),
      "keyword": $("#keyword").val(),
      "dateDu": dateToJJMMYYYY($("#noteDu").val()),
      "dateAu": dateToJJMMYYYY($("#noteAu").val())
    }

    tableauModalNote.ajax.reload();
  });

  $("#typeNote, #keyword, #noteDu, #noteAu").change(function(){
    dataTable_o = {
      "hebergeID": $('#record_id').val(),
      "action": "chargeNote",
      "typeNote": $("#typeNote").val(),
      "keyword": $("#keyword").val(),
      "dateDu": dateToJJMMYYYY($("#noteDu").val()),
      "dateAu": dateToJJMMYYYY($("#noteAu").val())
    }

    tableauModalNote.ajax.reload();
  });
}

// Petite fonction pour ajuster la hauteur d'un élément sur saisie (input, textarea)
function adjustHeight(element_j, multipleElement_b) {
  console.log(element_j);

  if (multipleElement_b == true) {
   
    element_j.each(function(){
      // Réinitialiser la hauteur de l'élément
      $(this).get(0).style.height = 'auto';
  
      // Ajuster la hauteur en fonction de la hauteur du texte
      $(this).get(0).style.height = ($(this).get(0).scrollHeight + 2) + 'px'; // Ajoutez un léger décalage pour gérer les bordures, marges, etc.
    });

  }else{
    // Réinitialiser la hauteur de l'élément
    element_j.get(0).style.height = 'auto';

    // Ajuster la hauteur en fonction de la hauteur du texte
    element_j.get(0).style.height = (element_j.get(0).scrollHeight + 2) + 'px'; // Ajoutez un léger décalage pour gérer les bordures, marges, etc.
  }

}