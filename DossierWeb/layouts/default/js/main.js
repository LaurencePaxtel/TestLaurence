var vinit='';

function saisiListe(){
	var colsEdit = [];
	var j=0;
	

	$('.table_sliste tbody tr:first td').each(function(i){

		if($(this).attr('data-champ') != undefined ){
			colsEdit[j] = i;
			j++;
		}

	});

	$(".table_sliste th").data("sorter", false);
	$(".table_sliste").tablesorter({
	    //theme : 'blue',
	    widgets: ['editable'],
	    widgetOptions: {
			editable_columns       : colsEdit,  // point to the columns to make editable (zero-based index)
			editable_enterToAccept : true,     // press enter to accept content, or click outside if false
			editable_autoResort    : false,    // auto resort after the content has changed.
			editable_noEdit        : 'no-edit', // class name of cell that is not editable
			afterChange : function(obj){
				console.log(obj.html());
			}
	    }
 	}).children('tbody').on('editComplete', 'td', function(){
 		var go = true;
		var $this 	= $(this);
		//var td 		= $(this).parents('td');
		var type 	= $this .data().type;
		//var td      = $(this).parents('td');
		$allRows 	= $this.closest('table')[0].config.$tbodies.children('tr');
		/*var type 		= td.data().type;*/
		if(type == "predictive"){
			newContent 	= $this.find('span').text();
			var champ 	= $this.data().champer;
		}else{	
			newContent 	= $this.text();
			var champ 	= $this.data().champ;
		}


		cellIndex 	= this.cellIndex, // there shouldn't be any colspans in the tbody
		rowIndex 	= $allRows.index( $this.closest('tr') );

		if( $(this).parents('.block:first').length ){
			var uidm 		= $(this).parents('.block:first').data().uidm;
			var wactionm 	= $(this).parents('.block:first').data().wactionm;
		}else{
			var uidm 		= "";
			var wactionm 	= "";
		}

		//var data 	= $this.attr('data-params').split(':');
		var type 	= $this.data().typechamp;
		
		var value 	= newContent;
		var UID 	= $this.data().uidchamp;
		var waction = $this.parents('table').attr('data-waction');

		var url 	= '/'+waction+'?action=saisiliste&uid='+UID+'&uidm='+uidm+'&champ='+champ+'&mode=popup&actionm='+wactionm+'&value='+value;


		//test de la date
		//$(this).css('border','none');
		if(type == 'Date'){

			var reg = new RegExp("^[0-9]{2}[/]{1}[0-9]{2}[/]{1}[0-9]{4}$","g");
			if(!reg.test(newContent)){
				go = false;
				$this.css('border','1px solid red');
			}

		}

		if(newContent!=vinit && go){

			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'html',
				success: function(data){
					refrechCell(data,$this.closest('table')[0]);
				},
				error: function(msg){
				}
			})	 
		}

	});
 	$(".table_sliste").children('tbody').on('editFocus', 'td', function(){
		var $this 	= $(this);
		vinit 		= $this.text();
	});
}

function refrechCell(data,table){
	var champs = eval(data);

	for (var i = champs.length - 1; i >= 0; i--) {
		var indexchamp;

		var id = champs[i].uid;
		if($(table).find("thead > tr th a").length){
			indexchamp 	 = $(table).find("thead > tr th a:contains('"+champs[i].nom+"')").parents('th').index();
		}else{
			indexchamp 	 = $(table).find("thead > tr th div:contains('"+champs[i].nom+"')").parents('th').index();	
		}
		
		var line 		 = $("td[data-uidchamp="+id+"]").parents('tr');

		var cell 		 = line.find('td:eq('+indexchamp+')');

		if(cell.find('div').length){
			cell.find('div').text(champs[i].val);
		}else{
			cell.text(champs[i].val);
		}
		
	};

}

function readURL(input,img) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        
        reader.onload = function (e) {
            $('#'+img).attr('src', e.target.result);
        }
        
        reader.readAsDataURL(input.files[0]);
    }
}

function getWidthColumns(){
	var width_cols = '';
	$('.table-mere th').each(function(){
	
		width_cols = width_cols+$(this).width()+'|';
	})
	return width_cols;
}

function widthColumns(){
	var left_init = 0;
	var widthInit = 0;

	$('.table-mere th').not('.hide').each(function(){
		widthInit += $(this).width();
	})
	$('.table-mere').css('width',widthInit+'px');
	var val_selectFM = $('#list_profil').val();
	var pref = $('.table-mere').attr('data-prefr');
	/*$('.CRG.CRD').livequery(function(){
		left_init =  $(this).position().left;
	});*/
	if(val_selectFM != '' && pref != '' && pref !='#'){
		$(".table-mere").colResizable({ disable : true });
		$(".table-mere").colResizable({
			onResize : function(e){
				var that = '.table-mere';
				var left_final = $(e.toElement).parent().position().left;
				var left_dif = left_final - left_init;

				$('.table-mere').css('width',$(that) .width()+left_dif+'px');
				
				$(e.toElement).parent().nextAll('.CRG').each(function(i){
					//var left_final_x = parseInt($(this).position().left+left_dif);
					//$(this).css('left',left_final_x+'px');
					
					if(i == 0){
						var width_final = parseInt($(that).find('th:eq('+$(this).index()+')').width()+left_dif);
						$(that).find('th:eq('+$(this).index()+')').css('width',width_final+'px');

					}
					
				});


				widthColumns();

				var url = '/redimension_colonnes?widthCols='+getWidthColumns()+'&prefRecherche='+pref+'&formatliste='+$('#list_profil').val();
				//console.log(url);
				$.ajax({
					type: 'GET',
					url: url,  
					dataType: 'html',
					success: function(data){
					},
					error: function(msg){
					}
				})
			}
		});
	}
	
}

function getOrderTable(){
	var order = '' , titre = '';
	$('.table.table-mere th:not(.hide)').each(function(i){
		id = $(this).attr('data-refchamp');

		if (order === ''){
			order +=  id;
		}	
		else {
			order +=  '|'+id;
		}
	});

	return order;
}

function changeOrderTri(){
	$('.table-mere th div a').each(function(i){
		var index = i+1;
		var href  = $(this).attr('href');

		var part1 = href.split('&order=')[0];
		var part2 = href.split('&order=')[1];
		var part3 = part2.split('&')[1];

		$(this).attr('href',part1+'&order='+index+'&'+part3);
	})

}
			
function addCol() {
	var col   = this.data.text;
	var champ = this.data.alias;
	var index = $('.table.table-mere th.supcol').index() - 1;

	var url  = $('.table.table-mere').attr('data-waction')+'?action=liste&actionColonne=add&champ='+champ+'&prefRecherche='+$('.table.table-mere').attr('data-prefR')+'&orderListe='+getOrderTable()+'&titre='+col+'&formatliste='+$('#list_profil').val();

	$.ajax({
		type: 'GET',
		url: url,  
		dataType: 'html',
		success: function(data){
			// Ajout de l'html
			var objhtml = $(data);
			//$('.table-mere thead > tr th:eq('+index+')').after('<th data-refchamp="'+champ+'" data-champ="[Collaborateurs]USR_Prenom_Nom" class="span15 "><div><a href="USR?action=liste&amp;tous=non&amp;page=1&amp;order=2&amp;direction=asc">'+$(data).find('th:eq(1)').text()+'</a></div></th>')
			$('.table-mere thead > tr th:eq('+index+')').after($(data).find('th:eq(1)'));
			var champ2 = $(data).find('th:eq(1)').attr('data-refchamp')
			var tds = [];
			//var tds = $(data).find('tbody tr td').eq(1);
			$(data).find('tbody tr').each(function(i){
				tds[i] = $(this).find('td:eq(1)');
			})

			$('.table-mere tbody tr').each(function(i){
				$(this).find('td:eq('+index+')').after(tds[i]);
			})

			changeOrderTri();

			var option2 = { width: 170, items: 
				[
					{ text: "Insérer une colonne", alias: "1-1", type : "group" , width : 170 , icon: "images/add.png" , items : 
						[
							{ text: "colonne 02", alias: "30009" , icon: "images/espace.png", action: addCol },	
							{ text: "colonne 03", alias: "30010" , icon: "images/espace.png", action: addCol },	
							{ text: "colonne 04", alias: "30011" , icon: "images/espace.png", action: addCol },	
							{ text: "colonne 05", alias: "30012" , icon: "images/espace.png", action: addCol },	
							{ text: "colonne 06", alias: "30013" , icon: "images/espace.png", action: addCol }
						]
					},
					{ text: "Supprimer une colonne", alias: "1-1", type : "arrow" , width : 170 , icon: "images/delete.png" , action:deleteCol}
					
				]
			};

 
			
			var url  = $('.table.table-mere').attr('data-waction')+'?action=liste&actionColonne=dep&champ='+champ2+'&prefRecherche='+$('.table.table-mere').attr('data-prefR')+'&orderListe='+getOrderTable()+'&formatliste='+$('#list_profil').val();

			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'html',
				success: function(data){
					//Nouveau order
					//currentOrder = getOrderTable();
				},
				error: function(msg){
					console.log(msg);
				},
			})
			
			


			$(".table th").contextmenu(option_cm); 
			//refrecheContextMenu(option_cm);
			// Nouveau order
			currentOrder = getOrderTable();
			widthColumns(); 
		},
		error: function(msg){
			//console.log(msg);
		},
	});
}

function refrecheContextMenu(option){
	$('.b-m-mpanel').remove();
	$(".table th").contextmenu(option); 
}			
			
function deleteCol(col){
	var champ = $('.table.table-mere th.supcol').attr('data-refchamp');
	var url  = $('.table.table-mere').attr('data-waction')+'?action=liste&actionColonne=sup&champ='+champ+'&prefRecherche='+$('.table.table-mere').attr('data-prefR')+'&orderListe='+getOrderTable()+'&formatliste='+$('#list_profil').val();
		
	$.ajax({
		type: 'GET',
		url: url,  
		dataType: 'html',
		success: function(data){
			// Nouveau order
			var index = $('.table-mere tr th.supcol').index();
			$('.table-mere tr').each(function(){
				$(this).find('td:eq('+index+')').remove();
			});
			$('.table-mere tr th.supcol').remove();
			changeOrderTri();
			currentOrder = getOrderTable();
			widthColumns();
		},
		error: function(msg){
			//console.log(msg);
		},
	})
}

function changeFormatList(){

	$('#list_profil').change(function(){
		$('.btn_add_format').addClass('disabled');

		var val = $(this).val();
		var href = window.location.href;
			href = href.replace('#','');

		var hbl = href.split('&formatliste=');
		var bl = hbl.length;

		console.log(hbl[0],bl);

		if (bl==2){
			window.location = hbl[0]+'&formatliste='+val+'&tous=non';
		}
		else if (bl==1){
			window.location = href+'&formatliste='+val+'&tous=non';
		}else{

		}
	})
}

function addFormatList(){

 	$('#btnaddFormatList').click(function(e){
	
		e.preventDefault();
		var val = $('#format_name').val();
		var prfStrct = $('.table.table-mere').attr('data-prefr');
		var href = window.location.href;
		href = href.replace('#','');
		var dh = href.split('liste');
		var url = dh[0]+'liste&actionFormat=ajoutFormat&Nom_pref_recherche='+prfStrct+'&nameFormat='+val;
			if(prfStrct != ''  &&  prfStrct != '#'){
				$.ajax({
					type: 'GET',
					url: url,  
					dataType: 'html',
					success: function(data){
						var href = window.location.href;
						var hbl = href.split('&formatliste=');
						var bl = hbl.length;
						console.log(hbl[0],bl);
						if(bl==2){
							window.location = hbl[0]+'&formatliste='+data;
						}
						else if(bl==1){
							window.location = href+'&formatliste='+data;
						}
					},
					error: function(msg){
						
					},
				})

			}else{
				$('#addFormatList').modal('hide');
				alert('La préférence de recherche manquante !');
			}
		
	});

}

function disableBtnsFormatList(){
	var list 		= $('#list_profil');
	var btnDelete 	= $('#btnlfd');
	var btnRename 	= $('#btnlfdr');

	if (list.val() == ''){
		btnDelete.hide();
		btnRename.hide(); 
	}

	$('#new_format_name').val(list.find('option:selected').text());
}

function deleteFormatList(){

	$("#btnDeleteFormatList").click(function(e){
		e.preventDefault();

		var listform 	= $("#list_profil").val();
		var url 		= '/supprimer_format?listform='+listform;

		$.ajax({
			type: 'GET',
			url: url,  
		 	dataType: 'html',
			success: function(data){
				var href = window.location.href;
				var hbl = href.split('&formatliste=');
				var bl = hbl.length;
				console.log(hbl[0],bl);
				if(bl==2){
					window.location = hbl[0];
				}
				else if(bl==1){
					window.location = href;
				}
			},	
			error: function(msg){
				
			}
		});	
	});
}

function renameFormatList(){

	$("#btnRenameFormatList").click(function(e){
		e.preventDefault();

		var nfn 	 	= $("#new_format_name").val();
		var listform 	= $("#list_profil").val();
		var url 	 	= '/rename_format?nouveau_nom='+nfn+'&listform='+listform;

		console.log(url);

		$.ajax({
			type: 'GET',
			url: url,  
		 	dataType: 'html',
			success: function(data){
				var href = window.location.href;
				var hbl = href.split('&formatliste=');
				var bl = hbl.length;
				console.log(hbl[0],bl);
				if(bl==2){
					window.location = hbl[0]+'&formatliste='+listform;
				}
				else if(bl==1){
					window.location = href+'&formatliste='+listform;
				}
			},
			error: function(msg){
				
			}
		});
	})
}

function initBtnsFm(){
	var pref = $('table-mere').attr('data-prefr');

	if (pref == '' || pref == '#' ){
		$('.btn_add_format').addClass('disabled');
		$('.btn_add_format').attr('data-target','');
	}
}


 /*      fin       */
/******************/

$(function() {
navPadding();

respDisplay();
$(window).resize(function(){
	navPadding();
	respDisplay();
})
	

$('.link-slide').on('click',function(e){
	var leftSide = $('.content > .row > div > .span9');
	e.preventDefault();
	t = $(this);
	l = t.parents('.listeh');
	i = l.find('.inner-liste')
	w = t.width();

	if(t.hasClass('openav')){
		l.css('width','0px');
		t.removeClass('openav');
		t.addClass('closenav');
		i.css('padding-left','30px');
		leftSide.addClass('adpt');
	}else{
		l.attr('style','');
		i.attr('style','');
		t.removeClass('closenav');
		t.addClass('openav');
		leftSide.removeClass('adpt');
	}

	respDisplay();

})

$('#nomsociete').blur( function(event) {
    // your js code for blur event
    var namSoc = $(this).val();
   var url= $(".LinkSoc").attr('href');
   var listVarUrl = url.split("tknpax");
   url0=listVarUrl[1];
   console.log(url0);
   var listUrlAdd = url.split("URLPage");
   var urlAdd = listUrlAdd[1];
   console.log(urlAdd);
   if((url0.search('action=add')>0)&&(namSoc.length>0)){
     url0 = "http://www.societe.com/cgi-bin/mainsrch?champ="+ namSoc +"&imageField2.x=0&imageField2.y=0&tknpax"+ url0;
      console.log(url0);
    $(".LinkSoc").attr('href',url0).click();
    document.title = "add_"+namSoc;
  }else if(namSoc.length == 0){
	  url = "http://www.societe.com/?tknpax=test&URLPage"+ urlAdd;
      console.log(url);
    $(".LinkSoc").attr('href',url).click();
    document.title = "Répertoire Clients";
  }
  
  
  
   var urlPjaune= $(".LinkPjaune").attr('href');
   var listVarUrlPJaune = urlPjaune.split("tknpax");
   url0Pjaune=listVarUrlPJaune[1];
   console.log(url0Pjaune);
   var listUrlAddPJaune = urlPjaune.split("URLPage");
   var urlAddPjaune = listUrlAddPJaune[1];
   console.log(urlAddPjaune);
   if((url0Pjaune.search('action=add')>0)&&(namSoc.length>0)){
     url0Pjaune = "http://www.pagesjaunes.fr/trouverlesprofessionnels/rechercheClassique.do?portail=PJ/&ou=&quoiqui="+namSoc+"&tknpax"+ url0;
      console.log(url0Pjaune);
    $(".LinkPjaune").attr('href',url0Pjaune).click();
    document.title = "add_"+namSoc;
  }else if(namSoc.length == 0){
	  urlPjaune = "http://www.pagesjaunes.fr/?tknpax=test&URLPage"+ urlAddPjaune;
      console.log(urlPjaune);
    $(".LinkSoc").attr('href',urlPjaune).click();
    document.title = "Répertoire Clients";
  }
});

gestionCouleurs();
$('#lancer-detection').click(function(e){
	e.preventDefault();
		var url;
	$('#liste-links li').each(function(){
	
		url =$(this).data().link;
		that = $(this);
		
		$.ajax({
			type: 'GET',
			url: url,  
			dataType: 'HTML',
			async:false,
			complete: function(){
			
			},
			success: function(data){
				that.removeClass('hide');
				that.html(that.html());
				return false;
			},
			error: function(msg){
			
			},
		});
	
	
	});
});


filterSelectChamp();	

CKEDITOR.on('instanceReady', function(){   
   $('.ckeditorSave').each(function(){

		var id = $(this).attr('id');

		//eval("CKEDITOR.instances."+id+".on('key', function(){CKEDITOR.instances."+id+".updateElement();})")
		//eval("CKEDITOR.instances."+id+".on('key', function(){CKEDITOR.instances."+id+".updateElement();console.log($('#"+id+"').val())})");
		//eval("CKEDITOR.instances."+id+".on('blur', function(){CKEDITOR.instances."+id+".updateElement();console.log($('#"+id+"').val())})");

		CKEDITOR.instances[id].on('change', function(){
	   		console.log('change');
	   		CKEDITOR.instances[id].updateElement();
	    })
 
   })
});

var formatListe = $('#list_profil').val();

if(formatListe == ""){ //le saisie en liste ce fait seulement sur les liste par défault
	saisiListe();
}

$("#image").change(function(){
    readURL(this,'photo');
});

$('.btn_add_format.disabled').click(function(){
	return false;
});

$('#addFormatList p,#renameFormatList p,#deleteFormatList p').click(function(){ 
	return false;
});

$('#format_name').keypress(function (evt) {
	var charCode = evt.charCode || evt.keyCode;
	if (charCode  == 13) { 
		return false;
	}
});

/* --------  Chargement des formats des listes supression / ajout / modification  -----------*/

initBtnsFm();
disableBtnsFormatList();
deleteFormatList();
renameFormatList();
addFormatList();
changeFormatList();
widthColumns();


$('.search_In_Ligne').click(function(){
  	var url     = '/'+wactionm;
  	var wactionm  = $(this).parents('.block').data().wactionm;
  	var url  = '/'+wactionm+'?mode=popup';
 	var DataSend  = '';
 	DataSend = $(this).parents().find('form:first').serialize()+'&mode=_popup';

  	$.ajax({

	   	type: 'POST',
	  	url: url,
	   	dataType: 'text',
	  	data:DataSend,

   		error: function (xhr, ajaxOptions, thrownError) {
   			var msg;
    		switch(xhr.status) {
			    case 404:
			    	msg = 'Pas de réponse serveur.' 
			     	break;
			    case 500:
			     	msg = 'Erreur serveur interne.'
			     	break;
			    case 0:
			     	msg = 'Action interrompue par le serveur.'
			     	break;
			    default:
			     	noMsg = thrownError;
			     	break;
    		}
   
   	 		alert(xhr.status +' : '+msg);
   		},
   		success:function(data){
    		obj = eval(data);
    		traitement_objects(obj);
   		}  
  	});
});

/* --------   L'ordre des colonnes-----------*/

			  /**************************/
			 /*  L'ordre des colonnes  */
			/**************************/

			var currentOrder	= getOrderTable();
			var listPro 		= $('#list_profil').val();
			var prefr 			= $('table.table-mere').attr('data-prefr');
			
			if( listPro != "" &&  prefr != "" && prefr != "#" ){
			
				$('.table.table-mere').each(function(){

					$(this).dragtable({
						placeholder: 'dragtable-col-placeholder',
						items: 'thead th:not( .notdraggable ):not( :has( .dragtable-drag-handle ) ), .dragtable-drag-handle',
						appendTarget: $(this).parent(),
						scroll: true,
						after : function(){

							var champ = this.item;
							console.log(champ);
							/* Requête ajax */
							if(currentOrder !== getOrderTable()){
								// var url  = 'colonnes?action=dep&champ='+champ+'&prefRecherche='+$('.table.table-mere').attr('data-pref')+'&orderListe='+getOrderTable();
								
								var url  = $('.table.table-mere').attr('data-waction')+'?action=liste&actionColonne=dep&champ='+champ+'&prefRecherche='+$('.table.table-mere').attr('data-prefR')+'&orderListe='+getOrderTable()+'&formatliste='+$('#list_profil').val();

								$.ajax({
									type: 'GET',
									url: url,  
									dataType: 'html',
									success: function(data){
										//Nouveau order
										//currentOrder = getOrderTable();
										changeOrderTri();
									},
									error: function(msg){
										console.log(msg);
									},
								})

							}
							widthColumns();
						}
					});

				});	
			
			}
			  /*******************/
			 /* Menu contextuel */
			/*******************/

			$('.table.table-mere th').mousedown(function(event) {
				if(event.which === 3){
					$('.table.table-mere th.supcol').removeClass('supcol');
					$(this).addClass('supcol');
				} 
			})



			/*function addCol() {

				//var data  = ['colonne titre','val1','val2','val3'];
				var col   = this.data.text;
				var champ = this.data.alias;

				var url  = $('.table.table-mere').attr('data-waction')+'?action=liste&actionColonne=add&champ='+champ+'&prefRecherche='+$('.table.table-mere').attr('data-prefR')+'&orderListe='+getOrderTable()+'&titre='+col;

				$.ajax({
					type: 'GET',
					url: url,  
					dataType: 'html',
					success: function(data){
						// Ajout de l'html
						var objhtml = $(data);
						$('.table-mere thead > tr').append('<th data-refchamp="'+champ+'" data-champ="[Collaborateurs]USR_Prenom_Nom" class="span15 "><a href="USR?action=liste&amp;tous=non&amp;page=1&amp;order=2&amp;direction=asc">'+$(data).find('th:eq(1)').text()+'</a></th>')
						var tds = [];
						//var tds = $(data).find('tbody tr td').eq(1);
						$(data).find('tbody tr').each(function(i){
							tds[i] = $(this).find('td:eq(1)');
						})

						$('.table-mere tbody tr').each(function(i){
							$(this).append(tds[i]);
						})

						var option2 = { width: 170, items: 
							[
			        			{ text: "Insérer une colonne", alias: "1-1", type : "group" , width : 170 , icon: "images/add.png" , items : 
			        				[
			        					{ text: "colonne 02", alias: "30009" , icon: "images/espace.png", action: addCol },	
			        					{ text: "colonne 03", alias: "30010" , icon: "images/espace.png", action: addCol },	
			        					{ text: "colonne 04", alias: "30011" , icon: "images/espace.png", action: addCol },	
			        					{ text: "colonne 05", alias: "30012" , icon: "images/espace.png", action: addCol },	
			        					{ text: "colonne 06", alias: "30013" , icon: "images/espace.png", action: addCol }
			        				]
			        			},
			        			{ text: "Supprimer une colonne", alias: "1-1", type : "arrow" , width : 170 , icon: "images/delete.png" , action:deleteCol}
			        			
			    			]
						};

						refrecheContextMenu(option2);
						// Nouveau order
						currentOrder = getOrderTable();
					},
					error: function(msg){
						console.log(msg);
					},
				})
				
				//addHtmlCol(data,col);

            }*/

            /*function deleteCol(col){


            	var champ = $('.table.table-mere th.supcol').attr('data-refchamp');
				var url  = $('.table.table-mere').attr('data-waction')+'?action=liste&actionColonne=sup&champ='+champ+'&prefRecherche='+$('.table.table-mere').attr('data-prefR')+'&orderListe='+getOrderTable();
					
				$.ajax({
					type: 'GET',
					url: url,  
					dataType: 'html',
					success: function(data){
						// Nouveau order
						var index = $('.table-mere tr th.supcol').index();
						$('.table-mere tr').each(function(){
							$(this).find('td:eq('+index+')').remove();
						});
						$('.table-mere tr th.supcol').remove();
						
						currentOrder = getOrderTable();
					},
					error: function(msg){
						console.log(msg);
					},
				})
			}*/

			

			/* Helpers */

		/*	function getOrderTable(){
				var order = '' , titre = '';
				$('.table.table-mere th').each(function(i){
					if(i != 0){
						id = $(this).attr('data-refchamp')
						if(order === ''){
							order +=  id;
						}	
						else {
							order +=  '|'+id;
						}
					}
					

				});
				return order;
			}*/

			

/* -------- Calcule synthèse-----------*/

/* --------------New Window------------ */

		// $('#NewWindow').click(function(){
			// var html = $('#resultdiv').html();
			// //23 est la taille de base d'element (des vides )
			// if(html.length>23){
				// var url = '/Result_Synth?html='+html;
				// var w=window.open(url, '_blank');
			
			// }
			
		// });

		$('#NewWindow').click(function(){
			var html = $('#resultdiv').html();
			// 23 est la taille de base d'element (des vides )
			if(html.length>23){
				// var url = '/Result_Synth?html='+html;
				var url = '/Result_Synth';
				var w = window.open(url, '_blank');
				w.document.write(html);			
			}
			
		});
/*--------------------------------------------------*/

		$('.btncal,.btn_save_synth').click(function(){
						
			if(true) {
				var keepon =true
				var syntaxeHchamp="";
				var syntaxeVchamp="";
				var SelectedChoixchamp="";
				var SelectedChoixtxt="";
				var SelectedChoixtypeval="";
				var indece ="";
				var array=[];
				var Pdateanalyse;
				var Pheureanalyse;
				//syntaxe vertical
				$('.synth-vertic').each(function(){array.push($(this).data().tdchamp);});
				array.forEach(function(elem) {
					syntaxeVchamp= syntaxeVchamp + elem +';';
				});
									
				//syntaxe horizontal
				var array=[];
				
				$('.synth-horiz').each(function(){array.push($(this).data().tdchamp);});
				array.forEach(function(elem) {
					syntaxeHchamp= syntaxeHchamp + elem +';';
				});
				
				// Syntaxe Choix Cumuls
				var array=[];
				var arraytxt=[];
				var arraytypeval=[];
				$('.tdchampchoixV').each(function(){array.push($(this).data().tdchoixchampV);});
				$('.tdchampchoixV').each(function(){arraytxt.push($(this).text());});
				$('.drw').each(function(){arraytypeval.push($(this).text());});
				array.forEach(function(elem) {
					SelectedChoixchamp= SelectedChoixchamp + elem +';';
				});
				arraytxt.forEach(function(elem) {
					SelectedChoixtxt= SelectedChoixtxt + elem +';';
				});
				
				
				arraytypeval.forEach(function(elem) {
				
					SelectedChoixtypeval= SelectedChoixtypeval + elem +';';
				});
				
				/*  Périodicité d'analyse des heures   */
				Pheureanalyse=$('.Pheureanalyse option:selected').val();
				/* Périodicité d'analyse des dates  */
				Pdateanalyse=$('.Pdateanalyse option:selected').val();
				
				/*  Cumul global   */
				if($('#cmgl').is(':checked')){
					var cmgl='1';
				}else{
					var cmgl='0';
				}
				
				/*  Cumuls annuels   */
				if($('#cman').is(':checked')){
					var cman='1';
				}else{
					var cman='0';
				}
				
				/*  Cumuls semestriels   */
				if($('#cmsm').is(':checked')){
					var cmsm='1';
				}else{
					var cmsm='0';
				}
				
				/*  Cumuls trimestriels   */
				if($('#cmtr').is(':checked')){
					var cmtr='1';
				}else{
					var cmtr='0';
				}
				
				/*  Filtrer les valeurs nulles  */
				if($('#flvn').is(':checked')){
					var flvn='1';
				}else{
					var flvn='0';
				}
				
				/*  Filtrer les lignes vides  */
				if($('#fllv').is(':checked')){
					var fllv='1';
				}else{
					var fllv='0';
				}
				/*  Graph Superieur  */
				if($('#graphe_1').is(':checked')){
					var graphe_1='1';
				}else{
					var graphe_1='0';
				}
				/* Graphs details  */
				if($('#graph_N').is(':checked')){
					var graph_N='1';
				}else{
					var graph_N='0';
				}
				
				// Mémorisation Synthèse
				var ref_synthese='&ref_synthese='+$('#ref_synthese').val();
				var nom_synthese='&nom_synthese='+$('#nom_synthese').val();
				var groupe_synthese='&groupe_synthese='+$('#groupe_synthese').val();
				var Descro_synthese='&Descro_synthese='+$('#Descro_synthese').val();
				if($('#SYN_acces_rapide').is(':checked')){
					var SYN_acces_rapide='&SYN_acces_rapide=1';
				}else{
					var SYN_acces_rapide='&SYN_acces_rapide=0';
				}
				
				if($('#synth_optionSystem').is(':checked')){
					var natureSynth='&natureSynth=3';
				}else if($('#synth_optionEntreprise').is(':checked')){
					var natureSynth='&natureSynth=2';
				}else{
					var natureSynth='&natureSynth=1';
				}
				
				var saving_params=ref_synthese+nom_synthese+groupe_synthese+Descro_synthese+SYN_acces_rapide+natureSynth;
				
					if(SelectedChoixtypeval.length>0  && syntaxeVchamp.length>0){
						$.ajax({
							type: 'GET',
							//url: '/WebAGL_Synthese?'+'prefix='+window.location.pathname.substr(1)+'&table='+$('#recherche ul li:last b').text()+'&Pheureanalyse='+Pheureanalyse+'&Pdateanalyse='+Pdateanalyse+'&syntaxeHchamp='+syntaxeHchamp+'&syntaxeVchamp='+ syntaxeVchamp +'&SelectedChoixchamp='+SelectedChoixchamp+'&SelectedChoixtypeval='+SelectedChoixtypeval+'&SelectedChoixtxt='+SelectedChoixtxt+'&cmgl='+cmgl+'&cman='+cman +'&cmsm='+cmsm +'&cmtr='+cmtr +'&flvn='+flvn + '&fllv='+fllv+'&request=first',  
							url: '/WebAGL_Synthese?'+'prefix='+window.location.pathname.substr(1)+'&table='+$('#recherche ul').attr("rel")+'&Pheureanalyse='+Pheureanalyse+'&Pdateanalyse='+Pdateanalyse+'&syntaxeHchamp='+syntaxeHchamp+'&syntaxeVchamp='+ syntaxeVchamp +'&SelectedChoixchamp='+SelectedChoixchamp+'&SelectedChoixtypeval='+SelectedChoixtypeval+'&SelectedChoixtxt='+SelectedChoixtxt+'&cmgl='+cmgl+'&cman='+cman +'&cmsm='+cmsm +'&cmtr='+cmtr +'&flvn='+flvn + '&fllv='+fllv+'&graphe_1='+graphe_1+'&graph_N'+graph_N+saving_params,
							
							dataType: 'TEXT',
							success: function(retour){
								$('#resultdiv').html(retour);
								$('.synth_result').click();
								//$(this).removeAttr("disabled");
								$('.btncal').removeAttr("disabled");
								$('.btn_save_synth').removeAttr("disabled");
								
								$('.btncal').text('Calculer la synthèse');
								$('.btn_save_synth').text('Chargement et mémoirisation des synthèses');
							},
								error: function(retour){

							},

						});
					}else{	
						alert('Vous devez selectionner des critères de rupture et des cumuls pour réaliser une synthèse');
					}	
			
				
				
			}
			
			
	});	


/*-------------------------------------*/


		$('#RechercheM').change(function() {
				
			if ($('#RechercheM option:selected').data().nomrech !==undefined){
				$('#NomRecherche').val($('#RechercheM option:selected').data().nomrech);
				$('#uid-Rech').val($('#RechercheM option:selected').data().uid);
			
				if ($('#RechercheM option:selected').data().naturerech =='1'){
					$('#optionPersonnelle').attr('checked', true);
				}else if ($('#RechercheM option:selected').data().naturerech =='2'){
					$('#optionEntreprise').attr('checked', true);
				}else{
					$('#optionSystem').attr('checked', true);
				}
			
				if ($('#RechercheM option:selected').data().exclure =='1'){
					$('#Exlcure').attr('checked', true);
				}else{
					$('#Exlcure').attr('checked', false);
				}
								
				if ($('#RechercheM option:selected').data().filtre =='1'){
					$('#FiltreRech').attr('checked', true);
				}else{
					$('#FiltreRech').attr('checked', false);
				}
			
				if ($('#RechercheM option:selected').data().right =='oui'){
					$('.btn-memoriser').bind('click');
					$('.btn-memoriser').attr('diabled', false);
					
				}else{
					$('.btn-memoriser').unbind('click');
					$('.btn-memoriser').attr('diabled', true);
				}

				// Les lignes de la recherche
				var Html ='';
				var selectVal = ($(this).val()).replace(/;$/,"");
				key_vals = selectVal.split(';');
				var Operateur ;
				var Champ='' ;
				var Comparaison ;
				var val='' ;
				var type = '';
				var selectOperateur='<select class="span1"><option value="[et]">&</option><option  value="Ou">Ou</option><option  value="Sauf">Sauf</option></select>';
				var selectCompare='<select class="span2"><option value="Contient">Contient</option><option value="Ne contient pas">Ne contient pas</option><option value="Est égale à">Est égale à </option><option value="Est différent de">Est différent de</option><option value="Est vide">Est vide</option><option value="N\'est pas vide">N\'est pas vide</option><option value="Commence par">Commence par</option><option value="Est inférieur à">Est inférieur à </option><option value="Est inférieur ou égal à">Est inférieur ou égal à </option><option value="Est supérieur à">Est supérieur à </option><option value="Est supérieur ou égal à">Est supérieur ou égal à </option><option value="Est vrai">Est vrai</option><option value="Est faux">Est faux</option></select>';
				
				for(var index in key_vals) {
							key_val = key_vals[index].split(':');
							Operateur = key_val[0];
							Champ = key_val[1];
							Comparaison = key_val[2];
							val = key_val[3];
							type = key_val[4];
							selectOperateur=selectOperateur.replace('"'+Operateur+'"','"'+Operateur+'" selected');
							selectCompare=selectCompare.replace('"'+Comparaison+'"','"'+Comparaison+'" selected');
							if(index==0){
							Html+='<tr class=" ChDp champDrop"><td ></td><td rel="'+Champ+'" data-champ="'+Champ+'">'+Champ+'</td><td >'+selectCompare+'</td><td class="dblClickShowInput" data-type="'+type+'">'+val+'</td></tr>';
						}else{
							Html+='<tr class=" ChDp champDrop"><td >'+selectOperateur+'</td><td rel="'+Champ+'">'+Champ+'</td><td >'+selectCompare+'</td><td class="dblClickShowInput" data-type="'+type+'">'+val+'</td></tr>';
						}		
					}
				$('#tabelSearch > tbody').html(Html);
			}else{
				$('.btnNewSearch').click();
			}
    	});

		$('.btnSupRech').click(function(){
			var that = $(this);

			$.ajax({
				type: 'GET',
				url: '/RechercheAvnc?suppUID='+$(this).data().uid,
				dataType: 'json',
				success: function(retour){
					that.next().remove();
					that.remove();
					$('#totalRech').data().total = $('#totalRech').data().total -1;
					$('#totalRech').html('<a id="totalRech" href="#"><i class="icon-zoom-in"></i> Vos Recherches ('+$('#totalRech').data().total+')</a>');
				},
				error: function(retour){

				}
			});
		});
		
		$('.btn-Recherche,.btn-memoriser').click(function(){
			lancer_recherche =false;
			
				if ($('#DansSelection').is(':checked')){
					var DansSelection='1';
				}else{
					var DansSelection='0';
				}		
				
			if ($(this).hasClass('btn-memoriser')){
				var save='save='+$('#NomRecherche').val()+'&';
				
				if($('#Exlcure').is(':checked')){
					var Exclure='1';
				}else{
					var Exclure='0';
				}
				if($('#FiltreRech').is(':checked')){
					var FiltreRech='1';
				}else{
					var FiltreRech='0';
				}
							
				if($('#optionSystem').is(':checked')){
					var natureRech='3';
				}else if($('#optionEntreprise').is(':checked')){
					var natureRech='2';
				}else{
					var natureRech='1';
				}
			}else{
				var save='';
			}
			
			lancer_recherche = true;
			
			if (lancer_recherche == true) {

				var syntaxe="";
				var indece ="";
				$('.ChDp').each(function(i){
					var indece;
					// var champs = $(this).find('td:eq(1)').attr('rel');
					var champ = $(this).find('td:eq(1)').data().champ;
					var comparaison = $(this).find('td:eq(2) select').val();
					if($(this).find('td:eq(3)').find('a').length>0){
						var valeur = $(this).find('td:eq(3) a').text();
					}else{
						var valeur = $(this).find('td:eq(3)').text();
					}
					
					
					if(i !==0) {
						indece = $(this).find('td:eq(0) select').val();
						syntaxe = syntaxe+indece+':'+champ+':'+comparaison+':'+valeur+';';
					}else{
						syntaxe = 'start:'+champ+':'+comparaison+':'+valeur+';';
					}
				});
				
				var pref = $('#prefRecherche').val();
				var formatliste = $('#list_profil').val();
				
				$.ajax({
					type: 'GET',
					url: '/RechercheAvnc?'+save+'prefix='+$('.table.table-mere').attr('data-waction')+'&table='+$('#recherche ul').attr("rel")+'&syntaxe='+syntaxe+'&pref='+pref +'&Exclure='+Exclure+'&FiltreRech='+FiltreRech+'&DansSelection='+DansSelection+'&natureRech='+natureRech+'&UidRech='+$('#RechercheM option:selected').data().uidrech,  
					dataType: 'json',
					success: function(retour){
						window.location.href = window.location.pathname+'?action=liste&tous=non&formatliste='+formatliste;
					},
					error: function(retour){

					}
				});
			}
		});
		
		$('#recherche').css({'width':840,'margin':'-295px -400px'});
		Ecran = screen.height;

		if(Ecran<=600){
			$('#infos').css({'height':580,'width':840,'margin':'-295px -400px'});
		}
		
		if((Ecran>600)&&(Ecran<=800)){
			$('#infos').css({'height':740,'width':840,'margin':'-295px -400px'});
		}

		if(Ecran>800){
			$('#infos').css({'height':740,'width':840,'margin':'-295px -400px'});
		}

		
		$('.champDrag').not('ul[rel="EMail_modele"] .champDrag').draggable({
			revert: true,
			revertDuration: 1,
			helper:'clone'
		});
	
	
		$.fn.liveDroppable = function (opts) {
			this.mouseenter(function() {
			 	if (!$(this).data("init")) {
					$(this).data("init", true).droppable(opts);
			 	}
			});
			return $();
		};
		
		$( '.ChDp' ).liveDroppable({
			drop: function( event, ui ) {
				$(this).children().eq(1).text($(ui.draggable).data().champ);
				$(this).children().eq(1).data({'champ':$(ui.draggable).data().champ});
				//New Code Added
				$(this).children().eq(3).data({'type':$(ui.draggable).data().type});
				
				//if($(ui.draggable).data().champ=='Date'){
				if($(ui.draggable).data().champ.search('UID')>1){
					$(this).children().eq(3).addClass('active').html('Moi');
					}
				}
		});
		
		
		var enu = "<option value=\'Semaine précédente\'>Semaine précédente</option><option value=\'Semaine prochaine\'>Semaine prochaine</option><option value=\'Mois courant\'>Mois courant</option><option value=\'Mois précédent\'>Mois précédent</option><option value=\'Mois suivant\'>Mois suivant</option><option value=\'2 mois précédent\'>2 mois précédent</option><option value=\'3 mois précédents\'>3 mois précédents</option><option value=\'6 mois précédents\'>6 mois précédents</option><option value=\'9 mois précédents\'>9 mois précédents</option><option value=\'12 mois précédents\'>12 mois précédents</option><option value=\'Trimestre courant\'>Trimestre courant</option><option value=\'Trimestre précédent\'>Trimestre précédent</option><option value=\'Trimestre prochain\'>Trimestre prochain</option><option value=\'Semestre courant\'>Semestre courant</option><option value=\'Semestre précédent\'>Semestre précédent</option><option value=\'Année courante\'>Année courante</option><option value=\'Année précédente\'>Année précédente</option><option value=\'Année suivante\'>Année suivante</option><option value=\'Janvier précédent\'>Janvier précédent</option><option value=\'Février précédent\'>Février précédent</option><option value=\'Mars précédent\'>Mars précédent</option><option value=\'Avril précédent\'>Avril précédent</option><option value=\'Mai précédent\'>Mai précédent</option><option value=\'Juin précédent\'>Juin précédent</option><option value=\'juillet précédent\'>juillet précédent</option><option value=\'Aout précédent\'>Aout précédent</option><option value=\'Septembre précédent\'>Septembre précédent</option><option value=\'Octobre précédent\'>Octobre précédent</option><option value=\'Novembre précédent\'>Novembre précédent</option><option value=\'Décembre précédent\'>Décembre précédent</option><option value=\'1er Janvier\'>1er Janvier</option><option value=\'Lundi de Pâques\'>Lundi de Pâques</option><option value=\'1er Mai\'>1er Mai</option><option value=\'8 Mai\'>8 Mai</option><option value=\'Ascension\'>Ascension</option><option value=\'Lundi de Pentecôte\'>Lundi de Pentecôte</option><option value=\'14 juillet\'>14 juillet</option><option value=\'15 Août\'>15 Août</option><option value=\'Toussaint\'>Toussaint</option><option value=\'11 Novembre\'>11 Novembre</option><option value=\'Noël\'>Noël</option><option value=\'Du lundi au vendredi\'>Du lundi au vendredi</option><option value=\'Samedi\'>Samedi</option><option value=\'Dimanche\'>Dimanche</option><option value=\'Jours fériés\'>Jours fériés</option><option value=\'Jours fériés et ponts\'>Jours fériés et ponts</option>"

		var html_popover = "<div><p><label>Date : </label><input style=\'width: 193px;\' data-date-format=\'dd/mm/yyyy\' id=\'date-recherche\' class=\'datepicker\' id=\'\' type=\'text\' /></p><p><select style=\'width: 207px;\' id=\'date-select-recherche\'>"+enu+"></select></p><p style=\'width:100;overflow:hidden;\'><a href=\'#\' id=\'validerDate\' class=\'btn btn-info btn-small pull-left\'>Valider</a><a href=\'#\' id=\'close-popover\' class=\'btn btn-small pull-right\'>Annuler</a></p></div>"

			
		$('#recherche table').bind('DOMSubtreeModified',function(){
			$( '.ChDp' ).droppable({
				drop: function( event, ui ) {
					$(this).children().eq(1).text($(ui.draggable).data().champ);
					$(this).children().eq(1).data({'champ':$(ui.draggable).data().champ});
					//New Code Added
					$(this).children().eq(3).data({'type':$(ui.draggable).data().type});
					if($(ui.draggable).data().type=='Date'){
						$(this).children().eq(3).addClass('active').html('<a href="#" class="link-popover" data-placement="top" data-content="'+html_popover+'" title="" data-original-title="Choisissez une date ou une période.">00/00/00</a>');
					}
					/*$('.link-popover').click(function(){
						$('.link-popover').popover('show');	
					});*/
					
				     var isVisible = false;  
					$('.link-popover').popover({
				        html: true,
				        trigger: 'manual'
				    }).click( function(e) {
				        // if any other popovers are visible, hide them
				        var _this = $(this);
				        if(isVisible) {
				            $('.popup-marker').each(function() {
				           	 $(this).popover('hide');
				        	});
				        }

				        $(this).popover('show');

				        // handle clicking on the popover itself
				        $('.popover').off('click').click( function(e) {
				            e.stopPropagation(); // prevent event for bubbling up => will not get caught with document.onclick
				        });

				        $('#validerDate').click(function(){
				        	var select 		= $('#date-select-recherche').val(); 
				        	var input  		= $('#date-recherche').val();
				        	var input_date 	= input.split("/");
				        	

				        	if(input != ''){
				        		//input = input_date[1]+'/'+input_date[0]+'/'+input_date[2]
				        		_this.text(input);
				        	}else{
				        		_this.text(select);
				        	}
				        	//console.log(select,input);
				        	_this.popover('hide');
				        })

				        $('#close-popover').click(function(){
				        	_this.popover('hide');
				        })

				        isVisible = true;
				        e.stopPropagation();
				    });
				    $(document).click( function(e) {
				        $('.link-popover').each(function() {
				            $(this).popover('hide');
				        });
				        isVisible = false;
				    });
					if($(ui.draggable).data().champ.search('UID_Collaborateur')>1){
					 	$(this).children().eq(3).addClass('active').text('Moi');
					}
				  }
			});
		});
		
		
    	$('.btnNewSearch').click(function() {
       		$('#RechercheM option:first').attr('selected','selected');
			$('#optionPersonnelle').attr('checked', false);
			$('#Exlcure').attr('checked', false);
			$('#FiltreRech').attr('checked', false);
			$('#NomRecherche').val('');
			$('#tabelSearch > tbody').html('');
			$('#tabelSearch > tbody').html('<tr class=" ChDp champDrop"><td ></td><td></td><td ><select class="span2">	<option value="Contient">Contient</option><option value="Ne contient pas">Ne contient pas</option><option value="Est égale à">Est égale à </option><option value="Est différent de">Est différent de</option><option value="Est vide">Est vide</option><option value="N\'est pas vide">N\'est pas vide</option><option value="Commence par">Commence par</option><option value="Est inférieur à">Est inférieur à </option><option value="Est inférieur ou égal à">Est inférieur ou égal à </option><option value="Est supérieur à">Est supérieur à </option><option value="Est supérieur ou égal à">Est supérieur ou égal à </option><option value="Est vrai">Est vrai</option><option value="Est faux">Est faux</option></select></td><td  class="dblClickShowInput" data-type=""></td></tr>');
		});
    
    
    	$(".btnRemoveLineToSearchTable").click(function() {
		     var nmbrLineTable = $('#tabelSearch >  tbody  > tr').length;
     		
     		//for (var i =  nmbrLineTable ;i > 1; i--){
				$('#tabelSearch > tbody > tr:last').remove();
     			if (nmbrLineTable==1){
					$('#tabelSearch > tbody').html('');
					$('#tabelSearch > tbody').html('<tr class=" ChDp champDrop"><td ></td><td></td><td ><select class="span2">	<option value="Contient">Contient</option><option value="Ne contient pas">Ne contient pas</option><option value="Est égale à">Est égale à </option><option value="Est différent de">Est différent de</option><option value="Est vide">Est vide</option><option value="N\'est pas vide">N\'est pas vide</option><option value="Commence par">Commence par</option><option value="Est inférieur à">Est inférieur à </option><option value="Est inférieur ou égal à">Est inférieur ou égal à </option><option value="Est supérieur à">Est supérieur à </option><option value="Est supérieur ou égal à">Est supérieur ou égal à </option><option value="Est vrai">Est vrai</option><option value="Est faux">Est faux</option></select></td><td  class="dblClickShowInput"></td></tr>');
				}
     		//}
     		
       
    	});
    
     	$(".btnAddLineToSearchTable").click(function() {

		     var nmbrLineTable = $("#tabelSearch >  tbody  > tr").length + 1;

     		$('<tr class=" ChDp champDrop"><td ><select class="span1"><option value="[et]">&</option><option  value="Ou">Ou</option><option  value="Sauf">Sauf</option></select></td><td></td><td ><select class="span2"><option value="Contient">Contient</option><option value="Ne contient pas">Ne contient pas</option><option value="Est égale à">Est égale à </option><option value="Est différent de">Est différent de</option><option value="Est vide">Est vide</option><option value="N\'est pas vide">N\'est pas vide</option><option value="Commence par">Commence par</option><option value="Est inférieur à">Est inférieur à </option><option value="Est inférieur ou égal à">Est inférieur ou égal à </option><option value="Est supérieur à">Est supérieur à </option><option value="Est supérieur ou égal à">Est supérieur ou égal à </option><option value="Est vrai">Est vrai</option><option value="Est faux">Est faux</option></select></td><td  class="dblClickShowInput" data-type=""></td></tr>').appendTo('#tabelSearch > tbody');
     		
            
       
    	});
    	
    	$(".dblClickShowInput").click(function(event) {
			if(event.target.nodeName == 'TD'){
				//$(this).not('.active').addClass('active').html('<input type="text" class="span2 inputTemp" value="'+$(this).text()+'"/>');
				//$('#choixdate').html()
				if($(this).data().type=='Date'){
					$(this).not('.active').addClass('active').html('<a id="d" href="#" class="link-popover" data-toggle="popover" data-placement="top" data-content="'+html_popover+'" title="" data-original-title="Choisissez une date ou une période.">00/00/00</a>');
					 var isVisible = false;  
					$('.link-popover').popover({
				        html: true,
				        trigger: 'manual'
				    }).click( function(e) {
				        // if any other popovers are visible, hide them
				        var _this = $(this);
				        if(isVisible) {
				            $('.popup-marker').each(function() {
				           	 $(this).popover('hide');
				        	});
				        }

				        $(this).popover('show');

				        // handle clicking on the popover itself
				        $('.popover').off('click').click( function(e) {
				            e.stopPropagation(); // prevent event for bubbling up => will not get caught with document.onclick
				        });

				        $('#validerDate').click(function(){
				        	var select 		= $('#date-select-recherche').val(); 
				        	var input  		= $('#date-recherche').val();
				        	var input_date 	= input.split("/");
				        	

				        	if(input != ''){
				        		//input = input_date[1]+'/'+input_date[0]+'/'+input_date[2]
				        		_this.text(input);
				        	}else{
				        		_this.text(select);
				        	}
				        	//console.log(select,input);
				        	_this.popover('hide');
				        })

				        $('#close-popover').click(function(){
				        	_this.popover('hide');
				        })

				        isVisible = true;
				    });
 					$('#d').click();
 					$(document).click( function(event) {
 						if($(event.target).attr('id') != "d"){
 							$('.link-popover').each(function() {
					            $(this).popover('hide');
					        });
 						}  
				    });
					
					
					//$(this).children().eq(3).html('<a href="#" class="hide" data-toggle="popover" data-placement="top" data-content="'+$('#choixdate').html()+'" title="" data-original-title="Choisissez une date ou une période.">00/00/00</a>')
				}else{
					$(this).not('.active').addClass('active').html('<input type="text" class="span2 inputTemp" value="'+$(this).text()+'"/>');
				}

			}
			
    	});
		
		$(".inputTemp").blur(function(){
			$(this).parent().text($(this).val()).removeClass('active');
			$(this).remove();
		});
		
		paginationPhotos();
		searchPhotos();
		dragDdropeRows();
		gestionCouleurs();
		displayList();
		/*$(".inner-table").mCustomScrollbar({
			horizontalScroll:true,theme:"light",scrollInertia:20,
			advanced:{
				autoExpandHorizontalScroll:true
			}
		});*/

		//emailType();
 	
    });
	

function paginationPhotos(){

 	$('.PHO.block .pagination li:not(.active) a').click(function(e){

 		e.preventDefault();
 		$('.PHO.block .pagination li.active').removeClass('active');
 		$(this).parents('li').addClass('active');
 		var page	= $(this).attr('href');
 		var search = $(this).attr('data-search');
 		var url 	= '/PHO?action=rechercheimages&page='+page+'&search='+search;
 	
		$.ajax({
			type: 'GET',
			url: url,  
			dataType: 'html',
			success: function(data){
				//var html = $(data).html();
				$('#gallery').parent().html(data);
			},
			error: function(msg){
			}
		})

 	})

}

function searchPhotos(){

	$('#search_photos').click(function(e){

		e.preventDefault();
		var search = $('#input_search').val();
		
		var url 	= '/PHO?action=rechercheimages&search='+search;

		$.ajax({
			type: 'GET',
			url: url,  
			dataType: 'html',
			success: function(data){
				//var html = $(data).html();
				$('#gallery').parent().html(data);
			},
			error: function(msg){
			}
		})

	})

}

function gestionCouleurs(){
	$( ".colors tbody tr td" ).each(function(){
		var trColor = $(this).attr('data-lingecolor') 
		if( trColor != '')
		{
			$(this).parents('tr').find('td:not(.cl)').css('background-color',trColor);
		}

	});
}

function dragDdropeRows(){


	var p_avant,p_apres;

	$tabs = $(".glisse").parents('div.block');

	$( ".glisse tbody tr td" ).each(function(){
		if($(this).hasClass('no_glisse'))
		{
			$(this).removeClass('no_glisse');
			$(this).parents('tr').addClass('no_glisse');
		}
	})
		    
	//$('.glisse tbody').livequery(function(){
	$( ".glisse tbody" ).sortable({
       // connectWith: ".GVDL tbody",
        items:'tr:not(.no_glisse)',
        appendTo: $tabs,
        helper:"clone",
        zIndex: 999990,
        start: function(event,ui){ 
        	p_avant = ui.item.index();
        	$tabs.addClass("dragging");
        	
    	},
    	beforeStop : function(event,ui){
    		
    	},
        stop: function(event,ui){
        	p_apres = ui.item.index();

        	$tabs.removeClass("dragging");

        	if( p_avant != p_apres ){
            	var uids   = ui.item.find("td:nth-child(1)").text();
            	var uidd   = ui.item.prev().find("td:nth-child(1)").text();
            	var prf    = ui.item.parents('.block').attr('data-wactionm');
            	var url = prf+'?action=deplacement&uidd='+uidd+'&uids='+uids+'&mode=popup';
				
				$.ajax({
					type: 'GET',
					url: url,  
					dataType: 'html',
					success: function(data){
						obj = eval(data);
						traitement_objects(obj);
						gestionCouleurs();
						//$( ".glisse tbody" ).sortable('destroy');
						dragDdropeRows();
					},
					error: function(msg){
					}
				})	            		
        	}

        }
    });
   
	//});	    	
} 

function displayList(){

	$('#liste_champs .nom').click(function(){
		var ul = $(this).next('ul');
		if(ul.is(':visible')){
			ul.slideUp();
		}else{
			ul.slideDown();
		}

	})

}

// gestion des filtres 
var dynFilter = false;
function filterManage(){

	$('.btn_filter').on('click',function(){
		var table 		= $(this).parents('.block:first').find('table');
		if($(this).parents('.block:first').find('table').hasClass('ajax')){
			var bloc 	= $(this).parent().parent();
			var lchamps = bloc.find('.liste-champs');
			if(!table.find('.tablesorter-filter-row').is(':visible')){
				if(lchamps.is(':visible')){
					lchamps.hide();
				}else {
					lchamps.show();
				}
			}
		}
	});

	$('.liste-champs .btn_esc_lc').on('click',function(e){ // pour fermer la popup de filtre
		e.preventDefault();
		$(this).parents('.liste-champs').hide();
	});

	$('.liste-champs .btn_vld').on('click',function(e){  // pour valider les champs à filtrer
		e.preventDefault();
		$(this).parents('.liste-champs').hide();
		var list_champ 	= $(this).parent().parent();
		var table 		= $(this).parents('.block:first').find('table');
		var fl 			= table.find('.tablesorter-filter-row'); 
		var ln 			= $(this).find('li').length;
		var waction 	= $(this).parents('.block:first').data().waction;
		var actionm 	= $(this).parents('.block:first').data().wactionm;
		var uidm 	= $(this).parents('.block:first').data().uidm;
		var ul 			= list_champ.find('ul');
		var listCh="";

		ul.find('input').each(function(i){
			if($(this).is(':checked')){
				if(listCh==""){
					listCh = (i+1)
				}else{
					listCh += "|"+(i+1);
				}
			}
		})

		url = "/"+waction+"?action=liste&actionm="+actionm+"&UIDM="+uidm+"&ln="+ln+"&crfiltre=true&listCh="+listCh;

		if(listCh!=""){

			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'html',
				success: function(data){
					var dt = eval(data);
					dynFilter=true;
					for(var index_dt in dt) {
						table.find('.tablesorter-filter-row td:eq('+dt[index_dt].key+') select')
						.css('visibility','visible')
						.html(dt[index_dt].val);
					}		
				},
				error: function(msg){
				}
			})	

		}
		
	});

}

function positionListChamp(){

	$('.liste-champs').each(function(){
		var	boutton = $(this).parent().find('.control-group .btn_filter');

		if(boutton.length){
			var left = boutton.offset().left;
			var top = boutton.offset().top;

			$(this).css({
				'left' : (left-186)+'px',
				'top' : top+'px'
			})			
		}


	})
}

function initFilter(){
	$('.liste-champs').each(function(){
		$(this).find('input').each(function(){
			$(this).attr('checked',false);
		})

	})
}

function checkfilter(liste,fl){
	var dofilter = false;

	fl.find('input').each(function(){
		if($(this).val()!='')
			dofilter = true;
	})

	fl.find('select').each(function(){
		if($(this).val()!='')
			dofilter = true;
	})

	if(liste.find('input:checked')>0 && !dofilter){
		return true
	}else{
		return false
	}
}

function filterSelectChamp(){

	positionListChamp();
	filterManage();


	$('.nav-tabs li a').click(function(e){

		e.preventDefault();

		setTimeout(positionListChamp(),1000);
	})

}

function gestionCouleurs(){
	$( ".colors tbody tr td" ).each(function(){
		var trColor = $(this).attr('data-lingecolor') 
		if( trColor != '')
		{
			$(this).parents('tr').find('td:not(.cl)').css('background-color',trColor);
		}

	});
}

function dispatchClick(a_link){
   var a = a_link;
   var e = document.createEvent('MouseEvents');
   e.initEvent( 'click', true, true );
   a.dispatchEvent(e);
}

$("#action_resultat").change(function(){

	var val_periode = $(this).val();
	var d=new Date();
	var t=$("#Token").val().split('*');
	var t1=t[1].split(':');
	console.log(t[1]);
	console.log(t1[1]);
	var userUID=t1[1];

	if(val_periode=="Rendez-vous"){
		var host=location.host;
		var url='http://'+host+'/AGDA?usrs='+ userUID +'&type=Rendez-vous';
		 $('#agendaRedicrect').remove();
		 $("body").append('<a href ="'+url+'" class="hide" id="agendaRedicrect" target="_blank"></a>')
		 dispatchClick($('#agendaRedicrect')[0]);
	}
});

function navPadding(){

	var navbarH = $('.navbar').height();
	/*if( navbarH > 41 ){
		$('.page-header').css("padding-top",(10+(navbarH-41)));
	}else{
		$('.page-header').css("padding-top",10);
	}*/

}

function respDisplay(){

    var isiphone = false;
	var agent = navigator.userAgent.toLowerCase();
	if(agent.indexOf('iphone') != -1){
	   isiphone = true;
    }
    var agent = navigator.userAgent.toLowerCase();
	var cnt 	 = $('.content');
	var listeh   = $('.listeh');
	var leftSide = $('.content > .row > div > .span9');
	var cntWidth = cnt.width();
	var w = cntWidth - 20 - (listeh.width()) - 30 - 10;
	leftSide.width(w);
	
}