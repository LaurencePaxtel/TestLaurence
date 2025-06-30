/**
* Dynamically add/remove table row using jquery
*
* @author Risul Islam risul321@gmail.com
* @modifié Scanu Rémy remy@connect-io.fr
**/

var firstCLicInTable = {};

/*Add row event*/
$(document).on('click', '.rowfy-addrow', function(){
  let $this = $(this);
  let rowfyTable = $(this).closest('table');
  let lastRow = $('tbody tr:last', rowfyTable).clone();

  $('input', lastRow).val('');
  $('tbody', rowfyTable).append(lastRow);

  // Modifié par : Scanu Rémy (24/05/2023)
  var $index_el = 0;
  var $traite_b = verifyProperty(firstCLicInTable, rowfyTable.attr("id"));

  if ($traite_b == false) {
    $index_el = findRowIndex(rowfyTable.attr("id"), "btn-success");
    firstCLicInTable[rowfyTable.attr("id")] = $index_el;
  }else{
    $index_el = firstCLicInTable[rowfyTable.attr("id")];
  }

  $this.trigger({
    type: "afterClick",
    action: rowfyTable.attr("id") + "_add",
    rowIndex: $this.closest("tr").index() + 1
  });

  if ($this.closest("tr").index() > $index_el) {
    $this.removeClass('rowfy-addrow btn-success').addClass('rowfy-deleterow btn-danger').text('-'); 
  }else{
    $this.closest("td").html("");
  }
});

/*Delete row event*/
$(document).on('click', '.rowfy-deleterow', function(){
  let $this = $(this);
  let rowfyTable = $(this).closest('table');

  $this.closest('tr').remove();
  $this.trigger({
    type: "afterClick",
    action: rowfyTable.attr("id") + "_remove",
    rowIndex: $this.closest("tr").index() - 1
  });
});

/*Initialize all rowfy tables*/
$('.rowfy').each(function(){

  $('tbody', this).find('tr').each(function(){

    $(this).append('<td class="g-width-40 g-px-5 g-py-5"><button type="button" class="g-width-20 btn btn-sm '
      + ($(this).is(":last-child") ?
        'rowfy-addrow d-none-print btn-success">+' :
        'rowfy-deleterow d-none-print btn-danger">-') 
      +'</button></td>'
    );

  });

});

// Modifié par : Scanu Rémy (24/05/2023)
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

function verifyProperty(object, property) {
  return property in object;
}