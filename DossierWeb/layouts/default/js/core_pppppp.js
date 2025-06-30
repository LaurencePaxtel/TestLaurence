
			
  		function get(choix) {
			var url = location.search;
			key_vals = url.split('&');
			for(var index in key_vals) {
				key_val = key_vals[index].split('=');
				var key = key_val[0];
				var val = key_val[1];
				if(choix == key) {
					return val;
				}
			}
			return false;
		}  		
 
	  $(function(){
	  
		ckeDropLink();
	  
	  	if($('#couleur').length>0){
			$('#couleur').minicolors();
		}
	
	  	$('.disableme').live('click',function(){
			$(this).text($(this).data().loadingtext);
			$(this).attr('disabled',true);
		});
		
		$('.invisibleme').live('click',function(){
			$(this).addClass('invisible');
		});
		
		$('.firstuppercase').live('change',function(){
				var chaine=$(this).val();
			$(this).val(chaine.substr(0,1).toUpperCase()+ chaine.substr(1,chaine.length).toLowerCase()); 
		});
		
		

		$('th.hideCol').livequery(function(){
			var index = $(this).index();
			$(this).addClass('hide');
			$(this).parents('table:first').find('tbody tr td').each(function(){
				if($(this).index() == index ){$(this).addClass('hide')}
			});
		});
		
		$('.btn_speed_add').live('click',function(){
			var table = $(this).parents('.block:first').find('table');
			var nbtd = $(table).find('tbody tr:first td').length;
			var uid = $(table).find('thead tr:first th.tb_uid').data().uidreserve;
			// var trClone = $(table).find('tbody tr:last').clone();
			// $(table).find('tbody').append(trClone);
			var tds='';
			for(var i=0;i<nbtd-1 ;i++){
				tds +='<td><div class="change0" contenteditable="true"></div></td>'; 
			}
			
			//var btns = '<a href="#" class="btn btn-small btn_valid_speed_add"><i class="icon-ok"></i></a>';
			var tds = '<tr><td class="hide">'+uid+'</td>'+tds+'</tr>';
			$(table).find('tbody').prepend(tds);
			$(this).addClass('hide');
			$('.btn_valid_speed_add').removeClass('hide');
		});
		
		$('.btn_valid_speed_add').live('click',function(){
			
			var that = $(this);
			var table = $(this).parents('.block:first').find('table');
			var uid = $(table).find('thead tr:first th.tb_uid').data().uidreserve;
			var nbtd = $(table).find('tbody tr:first td').length;
			var waction = $(this).parents('.block:first').data().waction;
			//var param =$(this).data().parameter;
			var uidm = $(this).parents('.block:first').data().uidm;
			var wactionm = $(this).parents('.block:first').data().wactionm;
			var data = '';
			for(var i=0;i<nbtd-1 ;i++){
				data+='&'+$(table).find('thead tr:first th:eq('+i+')').data().champcrs+'='+$(table).find('tbody tr:first td:eq('+i+')').text();
			}
			
			var url = '/'+waction;
			
			$.ajax({
				type: 'POST',
				url: url, 
				dataType: 'text',
				data:'action=add&option=addrapid&uid='+uid+'&uidm='+uidm+'&mode=popup&actionm='+wactionm+data,
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
					that.addClass('hide');
					that.parents('.block:first').find('.btn_speed_add').removeClass('hide');
				}		
			});
			
		});
		
		$('.group-header').livequery(function(){
			var block = $(this).parents('.block:first');
			if(block.find('.table_checkbox').length>0) {
				$(this).find('td').append('<input class="table_checkbox table_checkbox_groupe inline" type="checkbox" name="table_checkbox" checked="checked">');
			}
			
		});
		
		$('.table_checkbox_groupe').live('click',function(){
			var that = $(this);
			var tr = $(this).parents('.group-header:first');
			tr.nextUntil('.group-header').each(function(){
			
				if(that.is(':checked')){
					$(this).find('.table_checkbox').attr('checked',true);
				}else{
					$(this).find('.table_checkbox').attr('checked',false);
				}
					$(this).removeClass('group-hidden');				
			});
			tr.removeClass('collapsed');
		});
		

		/*$('th.hideCol').addClass('hide');
		$('th.hideCol').parents('table:first').find('tbody tr td').each(function(){
            if($(this).index() == 9){$(this).addClass('hide')}
        });*/
	
	/*var champ_4d,flag;
	$( '.champDrag' ).draggable({ 
		start: function() {
	  	    champ_4d = $(this).attr('data-champ');
	  	    champ_4d = '{' + champ_4d.split(']')[1] +'}';
		}
		,stop: function() {
			CKEDITOR.instances['corps'].on('saveSnapshot', function(e) {
				if(champ_4d != '') {
					var data = CKEDITOR.instances.corps.getData();
					data = '<div>'+data+'</div>';
					var obj = $(data);
					obj.text(obj.text()+' '+champ_4d);
					CKEDITOR.instances.corps.setData(obj.html());
				}
			});
		}
	});
	*/
		var init_html = '<div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>';
		
		var Vmethode_nom,Vmethode_event,Vmethode_refresh,Vmethode_ob_affect,Vmethode_ob_depart;
		
		var uid = get('uid');

		if((uid !== false) && (uid !==undefined)){
			var uidmActionm = '&uidm='+uid+'&actionm='+(location.pathname).substr('1');
		}else{
			var uidmActionm =""
		}

		function Extract_Methode (chaine) {

			var class_array = chaine.split(' ');
			var methode_text = class_array[class_array.length-1]; 
			methode_text = methode_text.replace('methode[','');
			methode_text = methode_text.replace(']','');
			var methode_nom = methode_text.split(';')[0];
			var methode_event = methode_text.split(';')[1];
			var methode_refresh = methode_text.split(';')[2];
			
			return {'methode_nom' : methode_nom, 'methode_event' : methode_event, 'methode_refresh':methode_refresh};
		}


		function ExcMTH (methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart,object_depart) {
			
			if(methode_ob_affect == '' & methode_refresh !== 'refresh_object') {
				$('form #uid').before('<input type="hidden" id="obj_retour" name="obj_retour" value="'+methode_ob_affect+'"><input type="hidden" id="MethodeTr" name="MethodeTr" value="'+methode_nom+'"><input type="hidden" id="refresh" name="refresh" value="'+methode_refresh+'">')
				$('.btn-valider').click();
			}else{
				
				if($('#'+methode_ob_depart).attr('id') == 'valider' & !$('#'+methode_ob_depart).hasClass('wait') & !$('#'+methode_ob_depart).hasClass('go')) {
					Vmethode_nom = methode_nom;
					Vmethode_event = methode_event;
					Vmethode_refresh = methode_refresh;
					Vmethode_ob_affect= methode_ob_affect
					Vmethode_ob_depart = methode_ob_depart;
					$('#'+methode_ob_depart).addClass('wait');
				}
				
				var valeurIni = '';
				var valeurCurr = '';
				valeurIni = $('#'+methode_ob_depart).data().val;
				valeurCurr =  $('#'+methode_ob_depart).val();
				
				if(valeurIni !== undefined && valeurIni !== null) {
					valeurIni = (valeurIni.toString()).toLowerCase();
				}
				
				if(valeurCurr !== undefined && valeurCurr !== null) {
					valeurCurr = (valeurCurr.toString()).toLowerCase();
				}
				
				if($('#'+methode_ob_depart).attr('type') == 'button'){
					valeurIni = 'button';
				}
				
				$('.ckeditor').each(function(){
					var instance = CKEDITOR.instances[$(this).attr('id')];
					if(instance !== undefined){
						var html = instance.getData();
						$(this).val(html);
					}
					
				});
				
								
				if( valeurIni !== valeurCurr || $('#'+methode_ob_depart).hasClass('go') || methode_event =='chargement' || methode_ob_depart == 'valider' && !$('#'+methode_ob_depart).hasClass('wait')) {
					
					$('#'+Vmethode_ob_depart).removeClass('go');
					$('#'+methode_ob_depart).data({'val':$('#'+methode_ob_depart).val()});
					var ob_affect = $('#'+methode_ob_affect);
					var ob_depart =  $('#'+methode_ob_depart).val();
					var ob_depart_uid = $('#'+methode_ob_depart).parents('.control-group').next().val();
					//var formData = $('#'+methode_ob_depart).parents('form').serialize()+'&methode='+methode_nom;

					//var formData = $('body').find('form').serialize()+'&methode='+methode_nom;
					

					/*
					var formData ='';
					var firstForm = '';
					var formModalLength = $('body').find('.modal-body form').length;
					var skip =false;
					$('.disabled').attr('disabled',false);
					
					$('body').find('form').each(function(){
						//modal deversement trouvé
						var ob_depart_class = $('#'+methode_ob_depart).parents('.modal:first').attr('class');
						var modal_class = $(this).parents('.modal:first').attr('class');
						if( modal_class !== undefined && ob_depart_class !== undefined){
							if(modal_class.search(' in') ==-1 && ob_depart_class.search('modal-deversement') !==-1) {
								skip = true;
							}
						}
						
						if(skip == false){
							if(formModalLength == 0 && firstForm == '') {
								formData = $(this).serialize();
								//firstForm = true;
								
							}else if($(this).parents('.modal-body').length >0) {
								formData = formData+firstForm+$(this).serialize();
								//firstForm = true;
							}else{
								
								formDataTemp = $(this).serialize();
								posUID = formDataTemp.search('UID');
								if(posUID !==-1) {
									formDataTemp = formDataTemp.substring(0,posUID-1);
								}						
								
								formData = formData+firstForm+formDataTemp;
							}
							firstForm = '&';
						}
						skip = false;
					});
					$('.disabled').attr('disabled',true);
					// formData = formData.substr(1)+'&methode='+methode_nom;
					
					*/
					
					var formData ='';
					var firstForm = '';
					var formModalLength = $('body').find('.modal-body form').length;
					var skip =false;
					$('.disabled').attr('disabled',false);
					$('body').find('form').each(function(){
						//modal deversement trouvé
						var ob_depart_class = $('#'+methode_ob_depart).parents('.modal:first').attr('class');
						var modal_class = $(this).parents('.modal:first').attr('class');
						if( modal_class !== undefined && ob_depart_class !== undefined){
							if(modal_class.search(' in') ==-1 && ob_depart_class.search('modal-deversement') !==-1) {
								skip = true;
							}
						}
						
						var formDataTabs ='';
						var formDatas ='';
						var formDataTab1 ='';
						var formData1 ='';
						
						 if(skip == false){
					
							if(formModalLength == 0 && firstForm == '') {
								formData = $(this).serialize();
								//firstForm = true;
								
							}else if($(this).parents('.modal-body').length >0) {
								formData = formData+firstForm+$(this).serialize();
								//firstForm = true;
							}else{
								
								formDataTemp = $(this).serialize();
								posUID = formDataTemp.search('UID=');
								if(posUID !==-1) {
									formDataTemp = formDataTemp.substring(0,posUID-1);
								}						
								
								formData = formData+firstForm+formDataTemp;
							}
							firstForm = '&';
						}
						skip = false;
					});
					$('.disabled').attr('disabled',true);
					// formData = formData.substr(1)+'&methode='+methode_nom;
					formData = formData+'&methode='+methode_nom;
					
					var tables_uids	='';
									
					$('.table').each(function(){
						if($(this).find('.table_checkbox').length !==0){
							table_prefex = $(this).attr('class').split(' ')[0];
							tables_uids+= '&'+table_prefex+'_uids=';
							$(this).find('.table_checkbox:checked').each(function(){
								var index = $(this).parents('tr').index();
								tables_uids+=$(this).parents('table:first').find('tbody tr:eq('+index+') td:first').text()+' ';	
							});
						}
					});
					
					$('#'+methode_ob_depart).next('.refresh-load').removeClass('hide');
					DataSend = formData+tables_uids;
					
					$.ajax({
					type: 'POST', 
					url: '/ExcMTH',
					dataType: 'TEXT',
					//async: false,
					data:DataSend,
					error:function(msg){
						console.log(msg);
						$('#'+methode_ob_depart).next('.refresh-load').toggleClass('hide');
					},
					success:function(data){
						obj = eval(data);
						obj.methode_nom 			= methode_nom;
						obj.methode_event 			= methode_event;
						obj.methode_refresh 		= methode_refresh;
						obj.methode_ob_affect	= methode_ob_affect
						obj.methode_ob_depart 	= methode_ob_depart;
						traitement_objects(obj);
						//$('#'+methode_ob_depart).next('.refresh-load').toggleClass('hide');
						$('#'+methode_ob_depart).next('.refresh-load').addClass('hide');
					}
				});
				}
			}

		}
		
		//$('.liteeditor').wysihtml5();
		
		function SetExcMethode (Methodes) {
			Methodes.each(function(){
				
				// cas : checkbox
				if($(this).attr('class').split(' ')[0] == 'checkbox') {
					elem = $(this).children();
				}else{
					elem = $(this);
				}
				
				var formElem = elem.parents('form:first').attr('id');
				var idElem = elem.attr('id');
				var Elem = $(this);
				// extraction des parametres
				chaine = $(this).attr('class');
				var class_array = chaine.split(' ');
				var methode_text = class_array[class_array.length-1]; 
				methode_text = methode_text.replace('methode[','');
				methode_text = methode_text.replace(']','');
				var methode_nom = methode_text.split(';')[0];
				var methode_event = methode_text.split(';')[1];
				var methode_refresh = methode_text.split(';')[2];
				var methode_ob_affect = methode_text.split(';')[3];
				var methode_ob_depart = $(this).attr('id');

				// cas du retour
				if(methode_ob_affect == undefined) {
					var methode_ob_affect = '';
				}
				
				// traitement des evenements
				switch(methode_event) {
					case 'chargement':
					 ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart);
					  break;
					case 'click':
					 $('#'+formElem+' #'+idElem).live('click',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					 // Elem.live('click','submit',function(e){e.preventDefault();ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					 // Elem.live('click',function(e){e.preventDefault();ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					  break;
					case 'focusin':
					   // $('#'+idElem).live('focusin',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					    $('#'+formElem+' #'+idElem).live('focusin',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					  break;
					case 'focusout':
					  // $('#'+idElem).live('focusout',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					   $('#'+formElem+' #'+idElem).live('focusout',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					   break;
					case 'change':
					  // $('#'+idElem).live('change',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					  $('#'+formElem+' #'+idElem).live('change',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					   break;
					case 'keyup':
					  // $('#'+idElem).live('keyup',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					  $('#'+formElem+' #'+idElem).live('keyup',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					   break;  
					case 'blur':
					   // $('#'+idElem).live('blur',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					   $('#'+formElem+' #'+idElem).live('blur',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
				}
		
			});
		}
		
		$('ul.typeahead').live('mousedown', function(e) {
			e.preventDefault();
		});
		
		$('.ckeditor').livequery(function(){
				$(this).removeClass('ckeditor');
				$(this).addClass('ckeditorSave');
				var id = $(this).attr('id');
				var instance = CKEDITOR.instances[id];
				if (instance !== undefined){
					instance.destroy(true);
					
				} 
			CKEDITOR.replace(id);
		});	
		
		$('input:checkbox').live('click',function(){
			if($(this).is(':checked') == true) {
				//$(this).data({'val':'faux'});
				$(this).attr('value','vrai');
			}else{
				//$(this).data({'val':'vrai'});
				$(this).attr('value','faux');
			}
		});
		
		$('[class*="methode"]').livequery(function(){
			var Methodes = $(this);
			SetExcMethode(Methodes);
		});
		

		// width et height auto pour les modals
    	$('.modal.in').css({ 'margin-top':function () { return -($(this).height() / 2); }, 'margin-left': function () { return -($(this).width() / 2); }});

		// $('.modal-backdrop').livequery('click',function(){
				// $('.modal.hide').not('#recherche').not('.modal-deversement').find('.modal-body > div').html(init_html);		
			// $('.close').click();
		// });
		
	
		// fix datepicker click out
		$('.datepicker .day').live('click',function(){
			$(this).datepicker().datepicker();
			true;
		});
		
		// $('.typeahead').live('focusout',function(){
			// if( $(this).parent().next().hasClass('uid') && $(this).val() !== ''){
				// $(this).parent().next().val('');
			// }
		// });
		
	
		
		// $('select').each(function(i, e){
			// if (!($(e).data('convert') == 'no')) {
				// $(e).hide().wrap('<div class="btn-group" id="select-group-' + i + '" />');
				// var select = $('#select-group-' + i);
				// var current = ($(e).val()) ? $(e).val(): '&nbsp;';
				// select.html('<input type="hidden" value="' + $(e).val() + '" name="' + $(e).attr('name') + '" id="' + $(e).attr('id') + '" class="' + $(e).attr('class') + '" /><a class="btn span2" >' + current + '</a><a class="btn dropdown-toggle" data-toggle="dropdown" ><span class="caret"></span></a><ul class="dropdown-menu"></ul>');
				// $(e).find('option').each(function(o,q) {
					// select.find('.dropdown-menu').append('<li><a href="javascript:;" data-value="' + $(q).attr('value') + '">' + $(q).text() + '</a></li>');
					// if ($(q).attr('selected')) select.find('.dropdown-menu li:eq(' + o + ')').click();
				// });
				// select.find('.dropdown-menu a').click(function() {
					// select.find('input[type=hidden]').val($(this).data('value')).change();
					// select.find('.btn:eq(0)').text($(this).text());
				// });
			// }
		// });
		
		

		/*
		// table sorter
		$.extend($.tablesorter.themes.bootstrap, {
			// these classes are added to the table. To see other table classes available,
			// look here: http://twitter.github.com/bootstrap/base-css.html#tables
			table      : 'table table-bordered',
			header     : 'bootstrap-header', // give the header a gradient background
			footerRow  : '',
			footerCells: '',
			icons      : '', // add "icon-white" to make them white; this icon class is added to the <i> in the header
			sortNone   : 'bootstrap-icon-unsorted',
			sortAsc    : 'icon-chevron-up',
			sortDesc   : 'icon-chevron-down',
			active     : '', // applied when column is sorted
			hover      : '', // use custom css here - bootstrap class may not override it
			filterRow  : '', // filter row class
			even       : '', // odd row zebra striping
			odd        : ''  // even row zebra striping
		});
		*/
		//$('.tablesorter').livequery(function(){
			//$('.tablesorter').tablesorter({dateFormat: 'uk' });
		//});
		
		// $('.tablesorter').livequery(function(){
			// $('.tablesorter').tablesorter({
				// dateFormat: 'uk' //,
				// filter_functions : { 0 : true}
			// });
		// });
	function synchroCaseToHTML(waction){
		 var arrayCase = $('table.'+waction).data().case.split(' ');
		 $('table.'+waction+' tr td .table_checkbox').attr('checked',false);
			for(var caseIndex in arrayCase) {
				var Case =  arrayCase[caseIndex];
				if($('table.'+waction+' tr td:contains("'+Case+'")').length>0){
					$('table.'+waction+' tr td:contains("'+Case+'")').parents('tr:first').find('td .table_checkbox').attr('checked',true);
				}
			}
	}
	
	// call the tablesorter plugin
	
	$('.tablesorter.ajax').livequery(function(){
		var tabEdit = eval($(this).attr('data-edit'));
		var t=$(this);
		
		$(this).tablesorter({
			dateFormat: 'uk' , 
			
			// initialize zebra striping and filter widgets
			widgets: ['filter'],
			//widgets: ['group'],
			//sortList: [[1,0]],
			// headers: { 5: { sorter: false, filter: false } },
			// edition 
			// widgets: ['editable'],
			// widgetOptions: {
			  // editable_columns       : [0,1,5],  // point to the columns to make editable (zero-based index)
			  // editable_enterToAccept : true,     // press enter to accept content, or click outside if false
			  // editable_autoResort    : false,    // auto resort after the content has changed.
			  // editable_noEdit        : 'no-edit' // class name of cell that is no editable
			// },
			widgetOptions : {
				group_collapsible : true, // make the group header clickable and collapse the rows below it.,
				// css class applied to the table row containing the filters & the inputs within that row
				filter_cssFilter   : 'tablesorter-filter',

				// If there are child rows in the table (rows with class name from "cssChildRow" option)
				// and this option is true and a match is found anywhere in the child row, then it will make that row
				// visible; default is false
				filter_childRows   : false,

				// if true, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
				// below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
				

				// Set this option to false to make the searches case sensitive
				filter_ignoreCase  : true,

				// jQuery selector string of an element used to reset the filters
				filter_reset : '.reset',

				// Delay in milliseconds before the filter widget starts searching; This option prevents searching for
				// every character while typing and should make searching large tables faster.
				filter_searchDelay : 300,

				// Set this option to true to use the filter to find text from the start of the column
				// So typing in "a" will find "albert" but not "frank", both have a's; default is false
				filter_startsWith  : false,

				// if false, filters are collapsed initially, but can be revealed by hovering over the grey bar immediately
				// below the header row. Additionally, tabbing through the document will open the filter row when an input gets focus
				filter_hideFilters : false,
				filter_serversideFiltering : true,
				// editable
				//
				editable_columns       : tabEdit,  // point to the columns to make editable (zero-based index)
				editable_enterToAccept : true,     // press enter to accept content, or click outside if false
				editable_autoResort    : true,    // auto resort after the content has changed.
				editable_noEdit        : 'no-edit', // class name of cell that is not editable
				afterChange : function(obj){
					console.log(obj.html());
				}
			}

		}).tablesorterPager({
			size:20,
			container: $(this).prevAll('#pager'),
			ajaxUrl : '',
			customAjaxUrl: function(table, url) {
				var wactionm = $(table).parents('.block').data().wactionm;
				var waction = $(table).parents('.block').data().waction;
				var uidm =  $(table).parents('.block').data().uidm;

				
				var valfilter = "";
				var selectInner = $(table).find('.tablesorter-filter-row');
				selectInner.find('select').each(function(i){
					if($(this).val() !=""){
						if(valfilter==""){
							valfilter += (i+1) +";"+ $(this).val();
						}else{
							valfilter += "|" +(i+1) +";"+$(this).val();
						}
					}
				})

				if(valfilter!=""){
					url = '/'+waction+'?action=liste&actionm='+wactionm+'&uidm='+uidm+'&pager=oui&page=1&size={size}&{sortList:col}&dynfiltre=true&valfilter='+ encodeURIComponent(valfilter);
				}else{
					url = '/'+waction+'?action=liste&actionm='+wactionm+'&uidm='+uidm+'&pager=oui&page={page+1}&size={size}&{sortList:col}&dynfiltre=true&valfilter='+ encodeURIComponent(valfilter);
				}
				
				//ajaxUrl: '/myAjaxUrl?page={page}&size={size}&sortList={sortList:scol}&filter={filterList:fcol}',

				//url = '/'+waction+'?action=liste&actionm='+wactionm+'&uidm='+uidm+'&pager=oui&page={page+1}&size={size}&{sortList:col}&filter={filterList:fcol}';
				
				$(table).trigger('changingUrl', url);

				return url;
			},
			ajaxObject: {
				dataType: 'html'
			},
			ajaxProcessing: function(data){
				obj = eval(data);
				total = obj.total;
				html = $(obj.html).find('tbody').children();
				return [ total, $(html) ];
			}

		}).bind('pagerChange pagerComplete pagerInitialized pageMoved',function(){
			if($(this).hasClass('table_sliste')){
				 $('.ajax.table_sliste').data('tablesorter').widgets = ['editable'];
				$('.ajax.table_sliste').trigger('applyWidgets', true);	
				//t.trigger('applyWidgetId', ['editable']);
			}
			var waction = $(this).parents('.block').data().waction;
			synchroCaseToHTML(waction);
			
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
			if (waction == undefined){
				waction 	= $(this).parents('.block:first').data().waction;
			}

			var url = '/'+waction+'?action=saisiliste&uid='+UID+'&uidm='+uidm+'&champ='+champ+'&mode=popup&actionm='+wactionm+'&value='+value;


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
						//refrechCell(data,$this.closest('table')[0]);
						var obj = eval(data)
						traitement_objects(obj,$this.closest('table')[0]);
					},
					error: function(msg){
					}
				})	 
			}

		}).find('thead tr th:eq(2)').click();
	});
	
	
	// call the tablesorter plugin
	$('.tablesorter.noajax').livequery(function(){
		var tabEdit = eval($(this).attr('data-edit'));
		$(this).tablesorter({
		
			dateFormat: 'uk' ,
			widgets: ['filter','editable','saveSort'],
			//widgets: ['group'],
			//sortList: [[1,0]],

			widgetOptions : {
				group_collapsible : true, // make the group header clickable and collapse the rows below it.,
				filter_cssFilter   : 'tablesorter-filter',
				filter_childRows   : false,
				filter_hideFilters : false,
				filter_ignoreCase  : true,
				filter_reset : '.reset',
				filter_searchDelay : 300,
				filter_startsWith  : false,
				filter_hideFilters : false,

				// editable // l'édition des td
				editable_columns       : tabEdit,  // point to the columns to make editable (zero-based index)
				editable_enterToAccept : true,     // press enter to accept content, or click outside if false
				editable_autoResort    : true,    // auto resort after the content has changed.
				editable_noEdit        : 'no-edit', // class name of cell that is not editable
				afterChange : function(obj){
					console.log(obj.html());
				}

			}


		// le refresh de  l'editecol
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
			if (waction == undefined){
				waction 	= $(this).parents('.block:first').data().waction;
			}

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
						//refrechCell(data,$this.closest('table')[0]);
						var obj = eval(data)
						traitement_objects(obj,$this.closest('table')[0]);
					},
					error: function(msg){
					}
				})	 
			}


		}).tablesorterPager({size:20,container: $(this).prevAll('#pager')}).find('thead tr th:eq(2)').click();
	});
	
	
	
	
	// .tablesorterPager({container: $(this).prevAll('#pager')}).find('thead tr th:eq(2)').click();

		// }).tablesorterPager({
			// container: $(".pager"),
			// cssGoto  : ".pagenum",
			// removeRows: false,
			// output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
		// });
		
		//.tablesorterPager({container: $("#pager")});
		
		
		// form validationEngine
		// $('form.well').validationEngine();
		$('form.well').livequery(function(){
			$(this).validationEngine();
		});
		
		
		 // masque de saisie
		$('.mask-datefr').livequery(function(){
			var that = $(this);
			that.mask('99/99/9999',{
				completed:function(){}
			});
		}); 
		
		$('.mask-datefr').live('blur',function(){
			var that = $(this);
			if(that.val() !== '__/__/____') {
				var dateEn = new Date((that.val()).split('/')[1]+'/'+(that.val()).split('/')[0]+'/'+(that.val()).split('/')[2]);					
				if(dateEn == 'Invalid Date') {
					alert("Date invalide!");
					that.val('');
				}
			}
		});
		
		$('.mask-phone').livequery(function(){
			$(this).mask('(999) 999-9999');
		}); 
		
		$('.mask-iphone').livequery(function(){
			$(this).mask('+33 999 999 999');
		}); 
		
		$('.mask-pct').livequery(function(){
			$(this).mask('99%');
		}); 
		
		$('.mask-iban').livequery(function(){
		   $(this).mask('****      |      ****      |      ****      |      ****      |      ****      |      ****      |      ***');
		  }); 
		  
		  $('.mask-bic').livequery(function(){
		   $(this).mask('***********');
		  }); 
		  
		  $('.mask-code-banque').livequery(function(){
		   $(this).mask('*****');
		  }); 
		  
		  $('.mask-code-guichet').livequery(function(){
		   $(this).mask('*****');
		  }); 
		  
		  $('.mask-num-compte').livequery(function(){
		   $(this).mask('***********');
		  }); 
		  
		  $('.mask-cle-rib').livequery(function(){
		   $(this).mask('**');
		  });
				 
		// input filter
		$('.numericonly').livequery(function(){
			$(this).autotab_magic().autotab_filter('numeric');
		});
		// input filter
		$('.float').livequery(function(){
			$(this).autotab_magic().autotab_filter('float');
		});
		// $('.numericonly').autotab_magic().autotab_filter('numeric');
		$('.textonly').livequery(function(){
			$(this).autotab_magic().autotab_filter('text');
		});
		// $('.textonly').autotab_magic().autotab_filter('text');
		$('.alphaonly').livequery(function(){
			$(this).autotab_magic().autotab_filter('alpha');
		});
		// $('.alphaonly').autotab_magic().autotab_filter('alpha');
		$('.regexonly').livequery(function(){
			$(this).autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\.]' });
		});
		// $('.regexonly').autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\.]' });
		$('.alluppercase').livequery(function(){
			$(this).autotab_magic().autotab_filter({ format: 'alphanumeric', uppercase: true, nospace:false });
		});
		// $('.alluppercase').autotab_magic().autotab_filter({ format: 'alphanumeric', uppercase: true });
		$('.alluppercase1').livequery(function(){
			$(this).autotab_magic().autotab_filter({ format: 'text', uppercase: true,nospace:false });
		});
		// $('.alluppercase1').autotab_magic().autotab_filter({ format: 'text', uppercase: true });
		$('.phone').livequery(function(){
			$(this).autotab({ format: 'number' });
		});
	    // $('.phone').autotab({ format: 'number' });
	  
		 $.fn.disableSelection = function() {
				return this
						 .attr('unselectable', 'on')
						 .css('user-select', 'none')
						 .on('selectstart', false);
			};

		$('.table-mere tr').disableSelection();
		
		$('.table-ligne tr').livequery(function(){
			$(this).disableSelection();	
		});
		
		$(document).bind('DOMSubtreeModified',function(){
			$('.fg-button').addClass('btn');
			$('span .ui-state-disabled').addClass('btn-info');
			$('.modal.in').css({ 'margin-top':function () { return -($(this).height() / 2); }, 'margin-left': function () { return -($(this).width() / 2); }});
		});
		
		//desactiver le click sur entré dans un formulaire
		$('.block form').live('keydown',function(e){
			if(e.keyCode == 13) {
				if($(e.srcElement).prop('tagName') !=='TEXTAREA') {
					e.preventDefault();
				}
				//$(this).parents('.modal:first').find('form input').blur();
				//$(this).parents('.modal:first').find('.btn-valider-ligne').click();
			}
		});
		

		
		
		$('.typeahead').keyup(function(e){
			if(e.keyCode == 8) {
				e.preventDefault();
				if($(this).parent().next().hasClass('uid')){
					$(this).parent().next().val('');
				}
			}
		});
		
		$('.editable').editable();
		
		 
		//inline inputs
		$('.uid').livequery(function(){
			if(!$(this).hasClass('cloned')) {
				var uidClone = $(this).clone().addClass('cloned');
				$(this).prev().find('.controls').after(uidClone);
				$(this).remove();
			}
		});

		// col2
		$('.col2').livequery(function(){
			$(this).removeClass('col2');
			var Obj = $(this).parents('.control-group').wrap('<div class="span3 new" />').parent().prev();
			
			if (Obj.hasClass('uid')) {
				Obj = Obj.prev();
			}
			
			Obj.wrap('<div class="span3 new" />').parents('fieldset').find('.new').wrapAll('<div class="row double-col" />').each(function(i){
				if(i==0) {
					var ClassSpan = $(this).children().children().children().attr('class');
					var pos = ClassSpan.search('span');
					var NumClassSpan = parseInt(ClassSpan.substr((pos+4),1));
					$(this).removeClass('span3').addClass('span'+(NumClassSpan+1));
				}else{	
					var ClassSpan2 = $(this).children().children().children().attr('class');
					var pos2 = ClassSpan2.search('span');
					var NumClassSpan = parseInt(ClassSpan2.substr((pos+4),1));
					$(this).removeClass('span3').addClass('span'+(NumClassSpan+1));
				}
				$(this).removeClass('new');
			});
		});
		
		// multiselect
		$('.multiselect').livequery(function(){
			$(this).multiSelect();
		});
		
		// multiselect avec la recherche
		$('.multiselectrecherche').livequery(function(){
			$(this).multiSelect({
				selectableHeader: '<input type="text" id="search" class="search span-multiselect"  autocomplete="off" >'
			});
		});
		
		$('.ms-selectable .search').livequery(function(){
			$(this).on('keydown',function(){
				var id = $(this).parents('.ms-container').attr('id');
				var liste ='#'+id+' .ms-selectable .ms-list';
				$(this).quicksearch($('li', liste )).on('keydown', function(e){
					if (e.keyCode == 40){
					  $(this).trigger('focusout');
					  $(liste).focus();
					  return false;
					}
				  }
				);
			});
		});
		
				
		$('.alert').alert();
		
		$('.datepicker').live('focus', function() {
			/*$(this).datepicker().datepicker();
			true;*/
			var pickerOpts = {
            	dateFormat:"dd/mm/yy"
        	}; 
			$(this).datepicker(pickerOpts);
		});
		
		$('.timepicker').livequery('focus',function(){
			$(this).timepicker({minuteStep: 5,defaultTime:'00:00;00', showSeconds: false, showMeridian: false});
		});
				
		$('#btn-edit').attr('disabled',true);
		$('#btn-del').attr('disabled',true);
		$('#btn-dup').attr('disabled',true);
		
		$('select').change(function(){
			if($(this).attr('multiple') !== 'multiple') {
				var indexSelect = $(this).find('option:selected').index();
				$(this).find('option').attr('selected',false); 
				$(this).find('option:eq('+indexSelect+')').attr('selected',true);
			}
		});
		
		// sur Impression d'un fiche
		$('a.btn-print,#btn-print').click(function(e){

			var formData ='';
			var firstForm = '';
			var formModalLength = $('body').find('.modal-body form').length;
			var skip  = false;
			$('.disabled').attr('disabled',false);
			
			$('body').find('form').each(function(){
				var methode_ob_depart = 'btn-print';
				//modal deversement trouvé
				var ob_depart_class = $('#'+methode_ob_depart).parents('.modal:first').attr('class');
				var modal_class = $(this).parents('.modal:first').attr('class');
				if( modal_class !== undefined && ob_depart_class !== undefined){
					if(modal_class.search(' in') ==-1 && ob_depart_class.search('modal-deversement') !==-1) {
						skip = true;
					}
				}
				
				if(skip == false) {
					if(formModalLength == 0 && firstForm == '') {
						formData = $(this).serialize();
						//firstForm = true;
						
					}else if($(this).parents('.modal-body').length >0) {
						formData = formData+firstForm+$(this).serialize();
						//firstForm = true;
					}else{
						
						formDataTemp = $(this).serialize();
						posUID = formDataTemp.search('UID');
						if(posUID !==-1) {
							formDataTemp = formDataTemp.substring(0,posUID-1);
						}						
						
						formData = formDataTemp+'&'+formData+firstForm;
					}
					firstForm = '&';
				}
				skip = false;
			});
			$('.disabled').attr('disabled',true);
			

			posUID = formData.search('&UID');
			if(posUID !==-1) {
				formData = formData.substring(0,posUID-1);
			}	
			
			
			if(!$(this).hasClass('go')) {	
				// e.preventDefault();
				$(this).attr('data-URL',$(this).attr('href'));
				$(this).attr('href',$(this).attr('data-URL')+'&'+formData);
				$(this).addClass('go');
				if(!$(this).hasClass('dropdown-toggle')) {
					$(this).click();
				}
			}else{
				$(this).attr('href',$(this).attr('data-URL')+'&'+formData);
			}

		});
		

		
		// sur validation d'un fiche
		$('.btn-valider').click(function(e){
			e.preventDefault();
			that_btn = $(this);
			$('.disabled').attr('disabled',false);
			$('.tags').each(function(){
				$(this).val($(this).next().val());
			});
			
			$('textarea').each(function(idx) {
				$(this).text($(this).val());
			});
			
			$('select option:not(":selected")').each(function(){
				if( $(this).parent().attr('multiple') == 'multiple') {
					$(this).attr('selected', false);
				}	
			});
			
			$('select option:selected').each(function(){
				$(this).attr('selected', true);
			});
			
			
			
			
			// check required fields
			var no_require = true;
			if($('.tab-content .tab-pane').length>1) {
			
				$('.tab-content .tab-pane').each(function(){

					if($(this).find('> form').length>0 && no_require == true) {						
						$(this).find('form').each(function(){
							id_tab = $(this).parents('.tab-pane').attr('id');
							$('[href*="#'+id_tab+'"]').click();
							if(!$(this).validationEngine('validate')) {
								no_require = false;
							}
							// $(this).parents('.tab-pane').removeClass('active');
						});
					}
				});
				
			}else{
				$('form').each(function(){
					if(!$(this).validationEngine('validate')) {
						no_require = false;
					}
				});
			}
			
			if(no_require) {
				if($('.tab-content .tab-pane').length>1) {
					var that_form = $('.tab-content .tab-pane:first > form');
					var firstTab = $('.tab-content .tab-pane:first > form fieldset input#uid');
					$('.tab-content .tab-pane:not(":first") ').each(function(){

						if($(this).find('> form fieldset').length>0) {
							//firstTab.before($(this).find('form fieldset').children().clone().addClass('hide')); 
							
							$(this).find('form fieldset').each(function(){
								//forms+= $(this).children().clone().addClass('hide');
								firstTab.before($(this).children().clone().addClass('hide').addClass('tempform')); 
							});
						}
						
					});
					
					$('.tab-content .tab-pane:first form:not(":first") ').each(function(){
							firstTab.before($(this).children().clone().addClass('hide').addClass('tempform')); 
					});
				}else {
					var that_form = $('form:first');
					var firstform = $('form:first fieldset input#uid');
					$('form:not(":first")').each(function(){
							firstform.before($(this).children().clone().addClass('hide').addClass('tempform')); 
					});
				}
			
			
				
			that_btn.parent().addClass('loading');
			//$('#valider').click();
			
			//----------------------------------------------------------------------------------------------------------------------------------------//
			
			
			// preparer la methode ajax d'envoie
			that_form.ajaxForm({
				 beforeSend: function(xhr,o) {

					},
					uploadProgress: function(event, position, total, percentComplete) {

					},
					complete: function(retour) {
							e.preventDefault();
							data = eval(retour.responseText);
							traitement_objects(data);
							if($('.tempform').length>0){
								$('.tempform').remove();
							}
							that_btn.parent().removeClass('loading');
					},
					error: function (xhr, ajaxOptions, thrownError) {
						if($('.tempform').length>0){
							$('.tempform').remove();
						}
						var msg;
						switch(xhr.status) {
						case 404:
							msg = 'Pas de réponse serveur.' 
							break;
						case 500:
							msg = 'Erreur serveur interne.'
							break;
						case 12002:
							msg = 'Server timeout.'
							break;
						case 12029:
						case 12030:
						case 12031:
							msg = 'dropped connections (either web server or DB server)	.'
							break;
						default:
							msg = thrownError;
							break;
						}
						if(msg !== 'abort') {
							alert(xhr.status +' : '+msg);
						}
					}
			});
				
			$('#valider').click();
			
		}
			//------------------------------------------------------------------------------------------------------------------------------------//
				
			/*if($('.formError').length !== 0){
				//that_btn.addClass('invisible');
				that_btn.parent().removeClass('loading');
				if($('.tempform').length>0){
						$('.tempform').remove();
				}
			}*/
			
		});
		
		

		$('.table-mere tbody tr.dbclick').bind('click dblclick doubletap', function(e) {
			var tr = $(e.target).parents('tr');
			var index = tr.index();
			var waction = (tr.parents('.table').attr('class')).split(' ')[0];
			
			var page = get('page');
			if(page!=='') {
				var page = '&page='+page;
			}else{
				var page = '&page=1';
			}
			
			var order = get('order');
			if(order!=='') {
				var order = '&order='+order;
			}else{
				var order = '';
			}
			
			var direction = get('direction');
			if(direction!=='') {
				var direction = '&direction='+direction;
			}else{
				var page = '';
			}
			
			
			//if(index !=0) {
				var id = $(this).find('td:eq(0)').text();
				
				$('#btn-edit').attr('href','/'+waction+'?action=edit&uid='+id+uidmActionm+page+order+direction);
				
				$('#btn-del').data({'index':index});
				$('#btn-del').attr('href',id);
				
				$('#btn-dup').attr('href','/'+waction+'?action=dup&uid='+id+uidmActionm+page+order+direction);
				
				$('#btn-del').attr('disabled',false);
				$('#btn-edit').attr('disabled',false);
				$('#btn-dup').attr('disabled',false);
			/*}else{
				$('#btn-edit').attr('href','#');
				$('#btn-del').attr('href','#');
				$('#btn-dup').attr('href','#');
				$('#btn-edit').attr('disabled',true);
				$('#btn-del').attr('disabled',true);
				$('#btn-dup').attr('disabled',true);
			}*/
			
			if( e.type == 'dblclick' || e.type == 'doubletap') {
				if($('#btn-edit').length==1) {
					//$('#btn-edit').click();
					window.location.href = $('#btn-edit').attr('href');
					// formelement=$("form").serializeArray();
						// var link=$('#btn-edit').attr('href');
						// $.each(formelement,function(i,field){
							// if( field.name !=='action') {
								// link=link+"&"+field.name +"="+field.value;
							// }
						// })
						// $('#btn-edit').attr('href',link);
						// window.location.href = $('#btn-edit').attr('href');
				}
			}
		});

		$('#btn-edit').click(function(e){
			if($(this).attr('href') == '#') {
				e.preventDefault();
			}else {
				console.log($(this).attr('href'));
			}
		});
		
		
		// $('.table tr').disableSelection();
	 
		$('#btn-del').click(function(e){
			if($(this).attr('href') == '#') {
				e.preventDefault();
			}else{
				e.preventDefault();
				var waction = ($(this).attr('class')).split(' ')[0];
				var wactionm = waction;
				
				var uid = $(this).attr('href');
				var uidm = $(this).attr('rel');
				//var index = $(this).parents('tr').index();
				var index = $(this).data().index;
				$('#'+wactionm+'_'+waction+'_modal_del').css({'width':500,'margin':'-300px -250px'});
				$('#'+wactionm+'_'+waction+'_modal_del').data({'uid':uid,'uidm':uidm,'index':index,'w_action':waction});
				$('#'+wactionm+'_'+waction+'_modal_del').modal();
			}
		});
		
		$('#btn-del2').click(function(e){
			if($(this).attr('href') == '#') {
				e.preventDefault();
			}else{
				e.preventDefault();
				var waction = ($(this).attr('class')).split(' ')[0];
				var wactionm = waction;
				
				var uid = $(this).attr('href');
				var uidm = $(this).attr('rel');
				var index = $(this).parents('tr').index();
				var index = $(this).data().index;
				$('#'+wactionm+'_'+waction+'_modal_del .sup_enrg').addClass('modefiche');
				$('#'+wactionm+'_'+waction+'_modal_del .sup_enrg').data({'url':$(this).attr('href')});
				$('#'+wactionm+'_'+waction+'_modal_del').css({'width':500,'margin':'-300px -250px'});
				$('#'+wactionm+'_'+waction+'_modal_del').data({'uid':uid,'uidm':uidm,'index':index,'w_action':waction});
				$('#'+wactionm+'_'+waction+'_modal_del').modal();
			}
		});
		
		$('.btn_del').live('click',function(e){
			e.preventDefault();
			var w_action = ($(this).attr('class')).split(' ')[0];
			var uid = $(this).attr('href');
			var uidm = $(this).attr('rel');
			var index = $(this).parents('tr').index();
			//var index = $('#btn-del').data().index;
			
			$('#'+wactionm+'_'+w_action+'_modal_del').css({'width':500,'margin':'-300px -250px'});
			$('#'+wactionm+'_'+w_action+'_modal_del').data({'uid':uid,'uidm':uidm,'index':index,'w_action':w_action});
			$('#'+wactionm+'_'+w_action+'_modal_del').modal();
		});
		
		
		$('.modal').livequery(function(){
			$(this).modal({backdrop: 'static', keyboard: false, show: false});
		});
		
		$('.btn_edit').live('click',function(e){
			e.preventDefault();
			var w_action = ($(this).attr('class')).split(' ')[0];
			var uid = $(this).attr('href');
			var uidm = $(this).attr('rel');
			var index = $(this).parents('tr').index();
			
			$('#'+w_action+'_modal_edit').css({'width':680,'margin':'-300px -340px'});
			$('#'+w_action+'_modal_edit').data({'id':uid,'index':index});
			$('#'+w_action+'_modal_edit').modal('show');
			var url = '/'+w_action+'?action=edit&uid='+uid+'&uidm='+uidm+'&mode=popup';
			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'HTML',
				error:function(msg){
					console.log(msg);
				},
				success:function(data){
					$('#'+w_action+'_modal_edit .modal-body > div').html(data);
					//$('#modal_edit form').attr('action',action);
				}
			});
		});
		
		function ini_selection_table () {
			$('.block .table-ligne tr').removeClass('info');
			
			$('.block .btn_sup').attr('disabled',true);
			$('.block .btn_sup').data({'index':'','uid':''});
			
			$('.block .btn-modifier-ligne').attr('href','#');
			$('.block .btn-modifier-ligne').attr('disabled',true);
			
		}
		
		$('.modal .close').bind('click');

		// button ajouter table ligne 
		var table_ligne ='';
		$('.btn_add').live('click',function(e){
			e.preventDefault();
			table_ligne = $(this).parent().next();
			//var w_action = ($(this).attr('class')).split(' ')[0];
			var waction = $(this).parents('.block:first').data().waction;
			var param =$(this).data().parameter;
			var uidm = $(this).parents('.block:first').data().uidm;
			var wactionm = $(this).parents('.block:first').data().wactionm;
			
			/*if($(this).parents('.block:first').hasClass('sousblock')) {
				var actionm = $(this).parents('.block:eq(1)').data().wactionm;
			}else{
				var actionm = $(this).parents('.block').data().wactionm;
			}*/
			
			if(param!=""){
				param="&"+param
			}
			
			var that_modal = $(this).parents('.block:first').find('#'+wactionm+'_'+waction+'_modal_add');
			
			that_modal.find(' .modal-body > div').html(init_html);
			that_modal.css({ 'margin-left': function () { return -($(this).width() / 2); }});
			that_modal.data({'uidm':uidm});
			that_modal.modal('show');		
			
			// $('#'+wactionm+'_'+waction+'_modal_add .modal-body > div').html(init_html);
			// $('#'+wactionm+'_'+waction+'_modal_add').css({ 'margin-left': function () { return -($(this).width() / 2); }});		
			// $('#'+wactionm+'_'+waction+'_modal_add').data({'uidm':uidm});
			// $('#'+wactionm+'_'+waction+'_modal_add').modal('show');
			
			var url = '/'+waction+'?action=add&uidm='+uidm+'&mode=popup&actionm='+wactionm+param;
			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'HTML',
				error:function(msg){
					console.log(msg);
				},
				success:function(data){
					that_modal.find(' .modal-body > div').html(data);
					that_modal.css({'margin-left': function () { return -($(this).width() / 2); }});
					// $('#'+wactionm+'_'+waction+'_modal_add .modal-body > div').html(data);
					// $('#'+wactionm+'_'+waction+'_modal_add').css({ 'margin-left': function () { return -($(this).width() / 2); }});
					//$('#modal_add form').attr('action',action);
				},
				error: function (xhr, ajaxOptions, thrownError) {
					var msg,noMsg=false;
					switch(xhr.status) {
					case 404:
						msg = 'Pas de réponse serveur.' 
						break;
					case 500:
						msg = 'Erreur serveur interne.'
						break;
					default:
						noMsg = true;
						break;
					}
					if(noMsg !== true) {
						alert(xhr.status +' : '+msg);
					}
					
				}
			});
		});
				
		// button supprimer table ligne
		$('.btn_sup').live('click',function(e){
			if($(this).data().uid == undefined || $(this).data().uid == '' ) {
				e.preventDefault();
			}else{
				e.preventDefault();
				table_ligne = $(this).parent().next();
				//var w_action = ($(this).attr('class')).split(' ')[0];
				var uid = $(this).data().uid; //$(this).attr('href');
				//var uidm = $(this).attr('rel');
				
				var waction = $(this).parents('.block').data().waction;
				var param =$(this).data().parameter;
				var uidm = $(this).parents('.block:first').data().uidm;
				var wactionm = $(this).parents('.block:first').data().wactionm;
					
				var index = $(this).data().index;
				$('#'+wactionm+'_'+waction+'_modal_del').css({'width':500,'margin':'-300px -250px'});
				$('#'+wactionm+'_'+waction+'_modal_del').data({'uid':uid,'uidm':uidm,'index':index,'wactionm':wactionm,'w_action':waction});
				$('#'+wactionm+'_'+waction+'_modal_del').modal();
			}
		});
		
		// button modifier table ligne
		$('.btn-modifier-ligne').live('click',function(e){
			e.preventDefault();
			//var w_action = ($(this).attr('class')).split(' ')[0];
			var uid = $(this).data().uid;
			//var uidm = $(this).attr('rel');
			//var uidm = $(this).parents('.block:first').data().uidm;
			var index = $(this).data().index;
			//var actionm = location.pathname.substr(1);
			table_ligne = $(this).parents('.block:first').find('table'); //.next();
			//var that_modal = $(this).parents('.modal');
			
			var waction = $(this).parents('.block').data().waction;
			var uidm = $(this).parents('.block:first').data().uidm;
			var wactionm = $(this).parents('.block:first').data().wactionm;

			var param =$(this).data().parameter;
			
			if(param!=""){
				param="&"+param
			}
			
			var that_modal = $(this).parents('.block:first').find('#'+wactionm+'_'+waction+'_modal_edit');
			that_modal.find(' .modal-body > div').html(init_html);
			that_modal.css({ 'margin-left': function () { return -($(this).width() / 2); }});

			that_modal.data({'uid':uid,'index':index});
			that_modal.modal('show');
			that_modal.css({ 'margin-left': function () { return -($(this).width() / 2); }});
			
			
			// $('#'+wactionm+'_'+waction+'_modal_edit .modal-body > div').html(init_html);
			// $('#'+wactionm+'_'+waction+'_modal_edit').css({ 'margin-left': function () { return -($(this).width() / 2); }});

			// $('#'+wactionm+'_'+waction+'_modal_edit').data({'uid':uid,'index':index});
			// $('#'+wactionm+'_'+waction+'_modal_edit').modal('show');
			// $('#'+wactionm+'_'+waction+'_modal_edit').css({ 'margin-left': function () { return -($(this).width() / 2); }});
			var clickdroit ='';
			if($(this).hasClass('clickdroit')) {
				clickdroit = '&clickdroit=vrai';
			}
			
			var url = '/'+waction+'?action=edit&uid='+uid+'&uidm='+uidm+'&mode=popup&actionm='+wactionm+param+clickdroit;
			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'HTML',
				error:function(msg){
					alert(msg);
				},
				success:function(data){
					that_modal.find(' .modal-body > div').html(data);
					that_modal.css({'margin-left': function () { return -($(this).width() / 2); }});
					// $('#'+wactionm+'_'+waction+'_modal_edit .modal-body > div').html(data);
					// $('#'+wactionm+'_'+waction+'_modal_edit').css({ 'margin-left': function () { return -($(this).width() / 2); }});
					//$('#modal_edit form').attr('action',action);
				}
			});
		});
		
			
		$('.table-ligne tr.dbclick').live('click dblclick', function(e) {
			
			var index = $(this).index();
			var waction = ($(this).parents('.table-ligne').attr('class')).split(' ')[0];
			// var that_btn_sup = $(this).parents('.table-ligne').prev().find('.btn_sup');
			var that_btn_sup = $(this).parents('.block:first').find('.btn_sup');
			// var that_btn_modifier = $(this).parents('.table-ligne').prev().find('.btn-modifier-ligne');
			var that_btn_modifier = $(this).parents('.block:first').find('.btn-modifier-ligne');
			that_btn_sup.attr('disabled',true);
			//that_btn_sup.toggleClass('btn-danger');

			if($(this).children().not('th').length !== 0) {
				var uid = $(this).find('td:eq(0)').text();
				
				//btn-modifier-ligne
				//$('.'+waction+'.btn-modifier-ligne').attr('href','/'+waction+'?action=edit&uid='+id+uidmActionm);
				
				that_btn_modifier.data({'index':index,'uid':uid});
				that_btn_modifier.attr('disabled',false);
				
				//btn-supprimer-ligne
				$('.btn_sup').data({'index':index,'uid':''});
				$('.btn_sup').attr('disabled',true);
				
				that_btn_sup.data({'index':index,'uid':uid});
				that_btn_sup.attr('disabled',false);
				// that_btn_sup.toggleClass('btn-danger');
				
								
			}else{
				/*
				//btn-modifier-ligne
				that_btn_modifier.attr('href','#');				
				that_btn_modifier.attr('disabled',true);
				
				//btn-supprimer-ligne
				//$('.'+waction+'.btn_sup').attr('href','#');
				that_btn_sup.data({'index':'','uid':''});
				that_btn_sup.attr('disabled',true);
				*/
				ini_selection_table();
			}
			
			if( e.type == 'dblclick') {
				if(that_btn_modifier.length ==1&& $(this).children().not('th').length !== 0) {
					//$('#btn-edit').click();
					//window.location.href = $('.'+waction+'.btn-modifier-ligne').attr('href');
					that_btn_modifier.click();
				}
			}
		});
		

	

	var annuler = 'non';
	// buttons close
	$('.btn-close').live('click',function(){
		annuler = 'oui';

		//init btn table
		ini_selection_table();
		//$(this).parents('.modal:first').find('.close').click();
		$(this).parents('.modal:first').modal('hide');
		
		if($(this).parents('.modal:first').attr('id') !=='recherche' && $(this).parents('.modal:first').attr('class').search('modal-deversement') ==-1) {
			$(this).parents('.modal:first').find('.modal-body > div').html(init_html);
		}
		annuler = 'non';
		$('.formErrorContent').click();
	});
		
		/*
	function confirm_message (data,that) {
	
		var message = data.confirme;
		var waction = data.waction;
		
		var confirmSerial = serialTohtml('confirm=oui');
		that_modal.find('form.'+waction).after(confirmSerial);
			
		if(confirm(message)) {
			that.click();
		}
	}*/
	
	$('.btn-valider-ligne').live('click',function(e){
		// stop l'effet de l'event click
		e.preventDefault();
		
		// masquer le button valider
		var that = $(this);
		// that.parent().addClass('hide');
		
		// if(that.data().focusOut == undefined){
			// that.keypress();
			// return false;
		// }

		// remplire mes variables
		//var w_action = ($(this).attr('class')).split(' ')[0];
		var waction = $(this).parents('.block:first').data().waction;
		var that_modal = $(this).parents('.modal:first');
		var table_ligne = $(this).parents('.block:first').find('> .table-ligne');
		var uid = that_modal.find('form.'+waction+' #uid').val(); 
		var uidm = that_modal.find('form.'+waction+' #uidm').val();
		var action = that_modal.find('form.'+waction+' #action').val(); 
		var clone = table_ligne.find(' tr:eq(1) td:first').html();
		var tables_uids ='';
		
		$('.table').each(function(){
			if($(this).find('.table_checkbox').length !==0){
				table_prefex = $(this).attr('class').split(' ')[0];
				tables_uids+= '&'+table_prefex+'_uids=';
				$(this).find('.table_checkbox:checked').each(function(){
					var index = $(this).parents('tr').index();
					tables_uids+=$(this).parents('table:first').find('tbody tr:eq('+index+') td:first').text()+' ';	
				});
			}
		});
		
		var param = $(this).data().parameter;
		//var wactionm = $(this).parents('.block:first').data().wactionm;
		
		if(action == 'edit') {
			var index = that_modal.data().index;
			var url = '/'+waction+'?action='+action+'&uid='+uid+'&uidm='+uidm+'&mode=popup';
		} else {
			var index = 9999;
			var url = '/'+waction+'?action='+action+'&uidm='+uidm+'&mode=popup';
		}
		
		// extraction des paramteres pour les methodes de refresh
		var chaine_methode =  that_modal.find('form.'+waction+' #valider').attr('class'); 
		var obj_methode = Extract_Methode(chaine_methode); // return {'methode_nom' : methode_nom, 'methode_event' : methode_event, 'methode_refresh':methode_refresh};
		var refresh = obj_methode.methode_refresh	
		var MethodeTr = obj_methode.methode_nom
		
		// envoie les parameteres si la refresh du soufiche est detecter
		var sousfiche ='';
		if (refresh=='refresh_sousfiche') {
			sousfiche = 'refresh='+refresh+'&MethodeTr='+MethodeTr;
			html_sousfiche = serialTohtml(sousfiche);
			that_modal.find('form #uid').after(html_sousfiche);
		}
		
		if(tables_uids !=='') {
			html_tables_uids = serialTohtml(tables_uids);
			that_modal.find('form #uid').after(html_tables_uids);
		}
		
		// prepare le progress bar si le cas d'une formulaire qui contient un champ de type file
		if($('.'+waction+' form input[type=file]').length !== 0) {
			var progress = '<div class="hide progress progress-striped active"><div class="bar barDownlaod"></div><div class="percent"></div></div>';
			that_modal.find('.modal-footer').html(progress);
			var bar = $('.barDownlaod');
			var percent = $('.percent');
			var file = true;
		}
		
		// attacher le lien de post au formulaire
		that_modal.find('form').attr('action',url);
		
		// enelver touts les 'disabled' class avant de posté le formaulaire
		that_modal.find('.disabled').attr('disabled',false);
		
		if($('.thumbnail #select_img').length>0) {
			var uids_img = '&uids_img=';
			$('.thumbnail #select_img:checked').each(function(){
				uids_img+=$(this).data().uid+' ';
			});
		
			html_img_uids = serialTohtml(uids_img);
			that_modal.find('form #uid').after(html_img_uids);
		}
		
		
		if(that_modal.find('.modal-body .tab-content .tab-pane').length>1) {
			var firstTab = that_modal.find('.modal-body .tab-content .tab-pane:first > form fieldset input#uid');
			that_modal.find('.modal-body .tab-content .tab-pane:not(":first") ').each(function(){

				if($(this).find('> form fieldset').length>0) {
					//firstTab.before($(this).find('form fieldset').children().clone().addClass('hide')); 
					
					$(this).find('form fieldset').each(function(){
						//forms+= $(this).children().clone().addClass('hide');
						firstTab.before($(this).children().clone().addClass('hide')); 
					});
				}
				
			});
			
			that_modal.find('.modal-body .tab-content .tab-pane .tab-pane:first form:not(":first") ').each(function(){
					firstTab.before($(this).children().clone().addClass('hide')); 
			});
		}else {
			var firstform = that_modal.find('form:first fieldset input#uid');
			that_modal.find('form:not(":first")').each(function(){
					firstform.before($(this).children().clone().addClass('hide')); 
			});
		}
		
		// preparer la methode ajax d'envoie
		that_modal.find('form.'+waction).ajaxForm({
			 beforeSend: function(xhr,o) {
					// masquer le button valider
					that.parent().addClass('hide');
					
					// c'est  si le cas d'une formulaire qui contient un champ de type file
					if(file) {
						that_modal.find('.modal-footer .progress').removeClass('hide');
						var percentVal = '0%';
						bar.width(percentVal);
						percent.html(percentVal);
					}
					xhrf = xhr;
				},
				uploadProgress: function(event, position, total, percentComplete) {
					// c'est  si le cas d'une formulaire qui contient un champ de type file
					if(file) {
						var percentVal = percentComplete + '%';
						bar.width(percentVal);
						percent.html(percentVal);
					}
					
					// s'il y a une click sur le button annuler
					if(annuler == 'oui' ){
						// effacer le progress bar de loading document
						that_modal.find('.modal-footer').html('');
						// remplacer la formulaire par le progress bar
						that_modal.find('.modal-body > div').html(init_html);
						//reaficher le button valider
						that_modal.find('.modal-header .btns').removeClass('hide');
						// annuler l'envoie
						xhrf.abort();
						return false;
					}
				},
				complete: function(retour) {
					
					//si tous ca se passe bien , on post le formulaire
					if(annuler == 'non' ){
						refresh_data = retour.responseText;
						
						
						if(refresh_data.search('message:') !== -1) {
							that.parent().removeClass('hide');
							
							data = eval(refresh_data);
							var message = data.message;

							alert(message);
							
						}else if(refresh_data.search('confirme:') !== -1) {
							that.parent().removeClass('hide');
							
							data = eval(refresh_data);
							//data['waction'] = waction;
							//confirm_message(data,that);
							
							var message = data.confirme;
							//var waction = data.waction;
							
							
								
							if(confirm(message)) {
								var confirmSerial = serialTohtml('confirm=oui');
								that_modal.find('form.'+waction+'  #uid').after(confirmSerial);
								that.click();
							}
							
						}else{
							
							if(refresh_data !== 'true') {
								that_modal.find('.modal-body > div').html(refresh_data); 
							}
													
							// affecation au tableaux
							var tr = '<tr>';
							table_ligne.find(' tr th').each(function(){
								var titre = $(this).text();
								titre = titre.toLowerCase();
								titre = titre.replace(/[#%+*\/&' [-]/gi,'_');
								titre = titre.replace(/(\{|\})/gi,''); // translate
								type = $(this).data().type;
								
								if(titre == 'uid' ){
									tr+='<td class="hide">';
								}else{
									tr+='<td class="'+type+'">';
								}
								// tr+=that_modal.find('#'+titre).val()+'</td>';
								
								// if(that_modal.find('input[type=checkbox]#'+titre).length) {
									// tr+=that_modal.find('#'+titre).parent().html()+'</td>';
								// }else{
									// tr+=that_modal.find('#'+titre).val()+'</td>';
								// }
								
								if(that_modal.find('input[type=checkbox]#'+titre).length) {
									tr+=that_modal.find('#'+titre).attr('disabled','disabled').parent().html()+'</td>';
								}else{
									// tr+=that_modal.find('#'+titre).val()+'</td>';
									
									if(!that_modal.find('#'+titre).hasClass('select_label')) {
										tr+=that_modal.find('#'+titre).val()+'</td>';
									}else{
										tr+=that_modal.find('#'+titre+' option:selected').text()
									}
								}
							});
							tr+= '</tr>';
							
							if(index == 9999){
								if(table_ligne.find('tbody tr').length >0) {
									table_ligne.find('tbody tr:last').after(tr); 
								}else{
								    // si table vide
									table_ligne.find('tbody').html(tr); 
								}
								
								//selection la ligne ajouté dans la table
								table_ligne.find(' tr:last').click();
							}else{
								table_ligne.find('tbody tr:eq('+(index)+')').replaceWith(tr);
								//selection la ligne ajouté dans la table
								table_ligne.find('tbody tr:eq('+(index)+')').click();
							}
							
							// si on a detecter une refresh d'un fiche alors on lance une refresh
							if (refresh == 'refresh_fiche'){
								window.location.href = 	window.location.href+'&refresh='+refresh+'&MethodeTr='+MethodeTr;
							}
							

							// Afficher le button valider
							that.parent().removeClass('hide');
							that.removeData('focusOut');
							
							// refresh tablesorter
							$('.tablesorter').trigger('update');
							
							// fermer le modal		
							// that_modal.find('.close').click();
							that_modal.modal('hide');
							// enelever le progress bar s'il existe
							that_modal.find('.modal-footer').html('');
							// afficher le button valider
							that_modal.find('.modal-header .btns').removeClass('hide');
							// lancer la methode refresh sur valider
							if(Vmethode_nom !=='' & Vmethode_nom !== undefined) {
								$('#'+Vmethode_ob_depart).removeClass('wait');
								$('#'+Vmethode_ob_depart).addClass('go');
								ExcMTH (Vmethode_nom,Vmethode_event,Vmethode_refresh,Vmethode_ob_affect,Vmethode_ob_depart);
								// initialiser les vars du methode refersh apres l'execution
								Vmethode_nom ='';
								Vmethode_event = '';
								Vmethode_refresh= '';
								Vmethode_ob_affect= '';
								Vmethode_ob_depart= '';
							}
							// remplacer la formulaire par le progress bar
							that_modal.find('.modal-body > div').html(init_html);
							return false;
						}
					}
					annuler = 'non';
					$('.formErrorContent').click();
				},
				error: function (xhr, ajaxOptions, thrownError) {
					var msg;
					switch(xhr.status) {
					case 404:
						msg = 'Pas de réponse serveur.' 
						break;
					case 500:
						msg = 'Erreur serveur interne.'
						break;
					case 12002:
						msg = 'Server timeout.'
						break;
					case 12029:
					case 12030:
					case 12031:
						msg = 'dropped connections (either web server or DB server)	.'
						break;
					// case 0:
						// Illegal cross origin request
						// Firewall block or filtering
						// The request itself was cancelled in code
						// An installed browser extension is mucking things up
						// msg = 'Action interrompue par le serveur.'
						// break;
					default:
						msg = thrownError;
						break;
					}
					if(msg !== 'abort') {
						alert(xhr.status +' : '+msg);
					}
				}
		});
		
		//click sur valider pour commencer l'envoie
		that_modal.find('form.'+waction+' #valider').click();
		annuler = 'non';
		// that_modal.find('form.'+waction+' #valider').submit().click(function(e){e.preventDefault();});
	});
	
	$('.btn-annuler-ligne').live('click',function(e){
		e.preventDefault();
		annuler = 'oui';
		//fermer le modal
		var that_modal = $(this).parents('.modal:first');
		that_modal.modal('hide');
		that_modal.find('.modal-body > div').html(init_html);
		// annuler = 'non';
	});
	
	// $('.btn-annuler-ligne').live('click',function(e){
		// annuler = 'oui';
		// var waction = $(this).parents('.block:first').data().waction;
		// var uid = $(this).parents('.block:first').find('form.'+waction+' #uid').val();
		// var param = $(this).data().parameter;
		// var that_modal = $(this).parents('.modal:first');
		// if($(this).parents('.modal:first').find('.table').length !== 0) {		
			// var url = '/'+waction+'?action=annuler&uid='+uid;
			// $.ajax({
				// type: 'GET',
				// url: url,  
				// dataType: 'HTML',
				// error: function (xhr, ajaxOptions, thrownError) {
					// var msg;
					// switch(xhr.status) {
					// case 404:
						// msg = 'Pas de réponse serveur.' 
						// break;
					// case 500:
						// msg = 'Erreur serveur interne.'
						// break;
					// case 0:
						// msg = 'Action interrompue par le serveur.'
						// break;
					// default:
						// noMsg = thrownError;
						// break;
					// }
					// annuler = 'non';
					// alert(xhr.status +' : '+msg);
				// },
				// success:function(data){
					//fermer le modal		
					// that_modal.modal('hide');
					// that_modal.find('.modal-body > div').html(init_html);
					// annuler = 'non';
				// }
			// });
		// }else{	
			//fermer le modal		
			// that_modal.modal('hide');
			// that_modal.find('.modal-body > div').html(init_html);
			// annuler = 'non';
		// }
	// });
		
	// lancer la supression d'un enregistrement 
	$('.sup_enrg').live('click',function(e){
			
			var modefiche = false;
			if($(this).hasClass('modefiche')) {
				modefiche = true;
				urlredirtect = $(this).data().url;
			}
			
			var w_action = ($(this).attr('class')).split(' ')[0];
			e.preventDefault();
			//var w_action = $('#modal_del').data().w_action;
			var uid = $('#'+w_action+'_'+w_action+'_modal_del').data().uid;
			var uidm = $('#'+w_action+'_'+w_action+'_modal_del').data().uidm;
			var index = $('#'+w_action+'_'+w_action+'_modal_del').data().index;
			var that_modal = $(this).parents('.modal:first');
			
			if(uidm=="") {
				var url = '/'+w_action+'?action=del&uid='+uid;
			}else{
				var url = '/'+w_action+'?action=del&uid='+uid+'&uidm='+uidm+'&mode=popup';
			}
			
			if(modefiche) {
				window.location.href = urlredirtect;
			}else{
				$.ajax({
					type: 'GET',
					url: url,  
					dataType: 'json',
					success: function(retour){
					
						// if(modefiche) {
							// window.location.href = urlredirtect;
						// }else{
							//$('table.'+w_action+' tr:eq('+index+')').remove();	
							if(table_ligne=="") {
								$('.table tbody tr:eq('+(index-1)+')').hide(1500).queue(function(){$(this).remove();});
							}else{
								table_ligne.find('tbody  tr:eq('+(index-1)+')').remove();
								// refresh tablesorter
								$('.tablesorter').trigger('update');
								ini_selection_table();
							}
						// }

					},
					error: function(retour){
						//alert('Erreur !!');
							if(table_ligne=="") {
								$('.table tr:eq('+(index+2)+')').hide(1500).queue(function(){$(this).remove();});
							}else{
								table_ligne.find(' tr:eq('+(index+2)+')').remove();
								// refresh tablesorter
								$('.tablesorter').trigger('update');
								ini_selection_table();
							}
					}
				});
			}
			// $('#'+$(this).parents('.modal').attr('id')+' .close').click();
			// fermer le modal		
			that_modal.modal('hide');
		});
		
	// lancer la supression d'un ligne
	$('.sup_ligne').live('click',function(e){
			
			e.preventDefault();
			//var table = $(this).parents('#pager').next('table');
			var table = $(this).parents('.block').find('table')
			var waction = $(this).parents('.block').data().waction;
			var wactionm = $(this).parents('.block').data().wactionm;
			$('#'+wactionm+'_'+waction+'_modal_del').data().uid;
			var uid = $('#'+wactionm+'_'+waction+'_modal_del').data().uid;
			var uidm = $('#'+wactionm+'_'+waction+'_modal_del').data().uidm;
			var index = $('#'+wactionm+'_'+waction+'_modal_del').data().index;
			var that_modal = $(this).parents('.modal:first');
			
			if(uidm=='') {
				var url = '/'+waction+'?action=del&uid='+uid+'&actionm='+wactionm;
			}else{
				var url = '/'+waction+'?action=del&uid='+uid+'&uidm='+uidm+'&mode=popup&actionm='+wactionm;
			}
			
			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'text',
				success: function(retour){
					//$('table.'+w_action+' tr:eq('+index+')').remove();	
					if(table_ligne=="") {
						table.find('tbody tr:eq('+index+')').remove(); //hide(1500).queue(function(){$(this).remove();});
					}else{
						table.find('tbody tr:eq('+index+')').hide(1500).queue(function(){$(this).remove();});
						// refresh tablesorter
						$('.tablesorter').trigger('update');
						ini_selection_table();
					}
					all_obj 		= eval(retour);
					traitement_objects(all_obj);

				}
				,error: function(retour){
					console.log('pas de reponse !');
				}
			});
			// $('#'+$(this).parents('.modal').attr('id')+' .close').click();
			// fermer le modal		
			that_modal.modal('hide');
		});
	
		
	$('#show').bind('hidden', function () {
		$('#show .modal-body > div').html('<div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>');
	});
		
	
	// button parcourir sur click
	$('.btn-file').live('click',function(e){
		e.preventDefault();
		$(this).next().click();
	});
	
	// button parcourir sur change
	$('input[type=file]').live('change',function(){
		$(this).prev().prev().attr('value',$(this).val());
		var namefile = $(this).val().split('\\')[(($(this).val().split('\\')).length)-1];
		var classNameDOC = ($(this).attr('name')+'_name').toLowerCase();
		$('.'+classNameDOC).attr('value',namefile);
		$('.'+classNameDOC).val(namefile);
		// $('.'+$(this).attr('name')+'_name').attr('value',namefile);
		// $('.'+$(this).attr('name')+'_name').val(namefile);
		//$(this).parents('.control-group').next('.filename').attr('value',namefile);
	});
	
	// la selection dans un liste general
	$('.table tr').live('click',function(){
		$('.table tr.info').toggleClass('info');
		$(this).toggleClass('info');
	});
	
	
	$('.btn_modal_externe').click(function(e){
		e.preventDefault();
		$('.disabled').attr('disabled',false);
		var pref = $(this).data().prefex;
		var methode = $(this).data().methode;
		var action = $(this).data().action;

		//var uidm = $(this).data().uidm;
		var actionm = $(this).data().actionm;
		var uid_unique = $(this).data().temp;
		
		if(pref !=='') {
			id_modal = 'modal_'+pref+'_'+uid_unique
		}else{
			id_modal = 'modal_'+methode+'_'+uid_unique
		}
		
		var parameters =  $(this).data().params;
		
		var that_modal = $('#'+id_modal);
		var forms_data = ''
		
		that_modal.find(' .modal-body > div').html(init_html);
		that_modal.css({ 'margin-left': function () { return -($(this).width() / 2); }});
		that_modal.modal('show');
		
		$('.content .row form').not('.filter').not('.form-search').each(function(){
			form_data	=	$(this).serialize();
			// if(i ==1) {		
			posUID = form_data.search('UID=');
			if(posUID !==-1) {
				posaction = form_data.search('action=');
				UIDM = 
				form_data = form_data.substring(0,posaction-1);
			}		
			// }
			forms_data+='&'+form_data;
		});
		
		$('.disabled').attr('disabled',true);
		// var url = '/'+pref+'?action='+action+'&uidm='+uidm+'&mode=popup&actionm='+actionm+forms_data;
		var url = '/'+pref+'?action='+action+'&mode=popup&actionm='+actionm+forms_data+'&'+parameters; // 05-12-2013 reg for

		$.ajax({
			type: 'GET',
			url: url,  
			dataType: 'HTML',
			success:function(data){
				that_modal.find(' .modal-body > div').html(data);
				that_modal.css({'margin-left': function () { return -($(this).width() / 2); }});
				
					for(var editor in CKEDITOR.instances) {
							if($('#'+editor).length) {
								// *CKEDITOR.instances[editor].destroy();
								 var instance = CKEDITOR.instances[editor];
								 if (instance) instance.destroy(true);
							}
							
							//eval('CKEDITOR.instances.'+id+'.destroy()');
						}
					$('.modal-body .ckeditor').each(function(){
						var id = $(this).attr('id')
					    CKEDITOR.replace(id);
					});
			},
			error: function (xhr, ajaxOptions, thrownError) {
				var msg,noMsg=false;
				switch(xhr.status) {
				case 404:
					msg = 'Pas de réponse serveur.' 
					break;
				case 500:
					msg = 'Erreur serveur interne.'
					break;
				default:
					noMsg = true;
					break;
				}
				if(noMsg !== true) {
					alert(xhr.status +' : '+msg);
				}
				
			}
		});
	});
	
	$('.btn-annuler-modal').live('click',function(e){
		e.preventDefault();
		var that_modal 	= $(this).parents('.modal_externe:first');
		that_modal.find(' .modal-body > div').html(init_html);
		that_modal.modal('hide');
	});
	
	
	$('.btn_refr').live('click',function(){
		var uidm 			= $(this).parents('.block').data().uidm;
		var wactionm 	= $(this).parents('.block').data().wactionm;
		var waction 	= $(this).parents('.block').data().waction;
		var url 				= '/'+waction+'?action=liste_refresh&uidm='+uidm+'&actionm='+wactionm;
		
		$.ajax({
			type: 'GET',
			url: url,
			dataType: 'text',
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
	
	$('.btn-valider-modal').live('click',function(e){
		e.preventDefault();
		$('.disabled').attr('disabled',false);		
		var that 			= $(this);
		var that_cancel 	= $(this).parents('.modal:first').find('.btn-annuler-modal');
		var that_modal 	= $(this).parents('.modal_externe:first');
		var pref 			= that_modal.data().prefex;
		var methode 	  	= that_modal.data().methode;
		var action 	  		= that_modal.data().action;
		var actionm 	  	= that_modal.data().actionm;
		//var uidm 	  		= that_modal.data().uidm;
		
		var uids				=	'';
		var tables_uids	=	'';
		var forms_data	=	'';
		// var formData 		='';
		
		// masquer le button valider
		that.parent().addClass('hide');
		that_cancel.parent().addClass('hide');
		
		$('.table').each(function(){
			if($(this).find('.table_checkbox').length !==0){
				table_prefex = $(this).attr('class').split(' ')[0];
				tables_uids+= '&'+table_prefex+'_uids=';
				$(this).find('.table_checkbox:checked').each(function(){
					var index = $(this).parents('tr').index();
					tables_uids+=$(this).parents('table:first').find('tbody tr:eq('+index+') td:first').text()+' ';	
				});
			}
		});
		
		/*
		$('.tags').each(function(){
			$(this).val($(this).next().val());
		});*/
		
		$('.tags').each(function(){
		   if($(this).next().val() == '') {
			$(this).next().val($(this).val());
		   }else{
			$(this).val($(this).next().val());
		   }
		  });
			
		//modal_form_data = '&'+$(this).parents('.modal_externe:first').find('form').serialize();
		
		$('.content .row form').not('.filter').not('.form-search').each(function(){
			form_data	=	$(this).serialize();
			// if(i ==1) {		
			posUID = form_data.search('UID=');
			if(posUID !==-1) {
				posaction = form_data.search('action=');
				// UIDM = 
				form_data = form_data.substring(0,posaction-1);
			}		
			// }
			forms_data+='&'+form_data;
		});
		
		$('.disabled').attr('disabled',true);
		// $('.table_checkbox:checked').each(function(){
			// var index = $(this).parents('tr').index()+1;
			// uids+=$(this).parents('table:first').find(' tr:eq('+index+') td:first').text()+' ';	
		// });
		
		// var formData = $(this).parents('.modal-deversement:first').find('form').serialize();
		
				
		// var url = '/'+pref+'?&mode=popup&uids='+uids+formData;
		var url = '/'+pref;
		that_modal.find(' .modal-body > div').html(init_html);
		$.ajax({
			type: 'POST',
			url: url, //'/deversement?action=deverser&uidm='+uidm+'&uids='+uids+'&mode=popup&'+formData+syntaxe,
			dataType: 'text',
			data:'mode=popup'+tables_uids+forms_data+'&action='+action,
			// data:'mode=popup&uids='+uids+formData,
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
				that.parent().removeClass('hide');
				that_cancel.parent().removeClass('hide');
				that_modal.modal('hide');
				alert(xhr.status +' : '+msg);
			},
			success:function(data){
				that.parent().removeClass('hide');
				that_cancel.parent().removeClass('hide');
				that_modal.modal('hide');
				if(data == 'refresh_page') {
					window.location.href = window.location.href;
				}else{
					obj = eval(data);
					traitement_objects(obj);
					/*obj = eval(data);
					Object.keys(obj).forEach(function(key) {
						$('#'+key).replaceWith(obj[key]);
					});*/
				}
			}		
		});
		
		// fermer le modal		
		// that_modal.find('.close').click();
		// that.parent().removeClass('hide');
		// that_modal.find(' .modal-body > div').html(init_html);
		// that_modal.modal('hide');
	});
	
	/*
	$('.table_checkbox_all').live('click',function(){
		that_table = $(this).parents('table:first');
		//that_case = that_table.data().case;
		that_caseorigine = that_table.data().caseorigine;
		
		if($(this).is(':checked')){
			that_table.find('.table_checkbox').attr('checked',true);
			that_table.data().case = that_caseorigine;
		}else{
			that_table.find('.table_checkbox').attr('checked',false);
			that_table.data().case = '';
		}
	});*/
	
	$('.table_checkbox_all').live('click',function(){
	
		var index = $(this).parents('th:first').index();
		that_table = $(this).parents('table:first');
		var table_checkbox_groupe = false;
		if($('.table_checkbox_groupe').length>0){
			table_checkbox_groupe = true;
		}
		// $(this).attr('disabled',true);
		// that_table.find('tbody tr td:eq('+index+') .table_checkbox').attr('disabled',true);
		if($(this).is(':checked')){
			var isChecked = true;
			if(table_checkbox_groupe) {
				that_table.find('.table_checkbox_groupe').attr('checked',true);
			}
		}else{
			var isChecked = false;
			if(table_checkbox_groupe) {
				that_table.find('.table_checkbox_groupe').attr('checked',false);
			}
		}
		if($(this).is(':checked')){
			that_table.find('tbody tr').each(function(){
				var checkbox = $(this).find('td:eq('+index+') .table_checkbox');
				checkbox.attr('checked',true); // to do
				if(checkbox.hasClass('update_checkbox')){
					checkbox.click().attr('checked',true);
				}
			});
		}else{
			that_table.find('tbody tr').each(function(){
				var checkbox = $(this).find('td:eq('+index+') .table_checkbox');
				checkbox.attr('checked',false);  // to do
				if(checkbox.hasClass('update_checkbox')){
					checkbox.click().attr('checked',false);
				}
			});
		}
		if(isChecked){
			$(this).attr('checked',true);
		}else{
			$(this).attr('checked',false);
		}
		// that_table.find('tbody tr td:eq('+index+') .table_checkbox').attr('disabled',false);
		// $(this).attr('disabled',false);
	});

	$('.table_checkbox').live('click',function(){
		that_table = $(this).parents('table:first');
		that_uid = $(this).parents('tr:first').find('td:first').text();
		if($(this).is(':checked')){
			that_table.data().case = that_table.data().case+' '+that_uid;
		}else{
			that_table.data().case = that_table.data().case.replace(that_uid,'');
		}
		
		that_table.data().case = $.trim(that_table.data().case);
		$(this).parents('table:first').find('.table_checkbox_all').attr('checked',false);
	});
	
	$('.table_checkbox').livequery(function(){
		if($(this).is(':checked')){
			$(this).prevAll('.title').text('oui');
		}else{
			$(this).prevAll('.title').text('non');
		}
	});
	
	function GetChampsAndValuesForms(){
		$('.disabled').attr('disabled',false);
		var form_data='';
		$('form.collectable').not('.filter').each(function(){
			form_data	=	$(this).serialize();
		
			posUID = form_data.search('UID=');
			if(posUID !==-1) {
				posaction = form_data.search('action=');
				if(posaction !==-1) {
					form_data = form_data.substring(0,posaction-1);
				}	
			}		
			form_data+='&'+form_data;
		});
		$('.disabled').attr('disabled',true);
		return form_data;
	}
	
	function GetChampsAndValuesTb (prefex,index_tr,champnum) {
		var values='';
		$('table.'+prefex+' thead th').each(function(){
				if(champnum) {
					var champ 	= 'TB_'+$(this).data().champcrs;
				}else{
					var champ 	= $(this).data().champ;
				}
				
				var index_td 	= $(this).index();
				var valeur 	= $('table.'+prefex+' tbody tr:eq('+index_tr+') td:eq('+index_td+')').text();
				
				values+='&'+champ+'='+valeur;
		});
		return values;
	}
	
	$('.update_checkbox').live('click',function() {
		  var that     			= $(this);
		  var index_td  	= $(this).parents('td:first').index();
		  var index_tr  		= $(this).parents('tr:first').index();
		  var that_table  	= $(this).parents('.table:first');
		  var prefex   		= that_table.attr('class').split(' ')[0];
		  var champ   		= that_table.find('th:eq('+index_td+')').data().champ;

		  var uid     = $(this).parents('tr:first').find('td:first').text();
		  if($(this).parents('.block:first').length>0){
		   var that_block  = $(this).parents('.block:first');
		   var wactionm  = that_block.data().wactionm;
		   var uidm     = that_block.data().uidm;
		  }else{
		   var wactionm="";
		   var uidm =""
		  }
		 var valeur			= $(this).is(':checked');
		
		valeur 					= (valeur) ? 'vrai':'faux'; 
		
		var data_tb = GetChampsAndValuesTb(prefex,index_tr,true);
		var data_forms = GetChampsAndValuesForms();
		var uids_tb = '&'+prefex+'_uids='+$('table.'+prefex).data().case;
		var Data 				= 'action=editcol&champ='+champ+'&value='+valeur+'&uid='+uid+'&uidm='+uidm+'&actionm='+wactionm+uids_tb+data_tb+data_forms;
		
		$.ajax({
			type: 'POST',
			url: '/'+prefex,
			dataType: 'text',
			data : Data,
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
	
	// button afficher deversement
	$('.deversement').click(function(e){
		e.preventDefault();
		var pref = $(this).data().pref;
		$(this).addClass(pref);
		var w_action = location.pathname.substr('1');
		var modal_id = w_action+'_Web_Deversement_'+pref;
		// var modal_id = $(this).data().methode
		$('#'+modal_id).css({'width':820,'margin':'-300px -400px'});
		$('#'+modal_id).modal();
	});
	
	
	// button deverser
	$('.btn-deverser').click(function(e){
		e.preventDefault();
		var pref 			= $(this).attr('class').split(' ')[0];
		// var methode 	= $(this).parents('.modal').attr('id');
	
		// that_modal 	= $('#'+methode);
		var that_modal 	= $(this).parents('.modal-deversement:first');
		var methode = $('.deversement.'+pref).data().methode;
			
		var uids='';
		var uidm = $('#uid').val();
		// var ecraser = $('#ecraser').attr('checked') ? 'oui' : 'non';
		$('.deverser:checked').each(function(){
			var index = $(this).parents('tr').index()+1;
			uids+=$(this).parents('table:first').find(' tr:eq('+index+') td:first').text()+' ';	
		});
		
		var formData = $(this).parents('.modal-deversement:first').find('form').serialize();
		var objBtn = $('.deversement.'+pref).data();
		var syntaxe = '';
		Object.keys(objBtn).forEach(function(key){
			syntaxe+= '&'+key+'='+objBtn[key];
		}); 
		
		
		$.ajax({
			type: 'GET',
			url: '/deversement?action=deverser&uidm='+uidm+'&uids='+uids+'&mode=popup&'+formData+syntaxe,
			// url: '/deversement?action=deverser&uidm='+uidm+'&uids='+uids+'&methode='+methode+'&ecraser='+ecraser+'&mode=popup&',
			dataType: 'text',
			error:function(msg){
				alert('Une erreur est survenue, veuillez réessayer.');
			},
			success:function(data){
				if(data == 'refresh_page') {
					window.location.href = window.location.href;
				}else{
					obj = eval(data);
					Object.keys(obj).forEach(function(key) {
						$('#'+key).replaceWith(obj[key]);
					});
				}
			}		
		});
		
		// fermer le modal		
		// that_modal.find('.close').click();
		that_modal.modal('hide');
	});
	
	$('.deverser-all').click(function(){
		var th_total = $(this).parents('tr:first').find('th').length;
		$(this).parents('table:first').find('tr td input.deverser').click(); //each(function(){
	});
	
	$('.couleurVert').each(function(){
		$(this).parents('tr:first').addClass('trVert');
	});
	
	
	$('.couleurRouge').each(function(){
		$(this).parents('tr:first').addClass('trRouge');
	});

	// window.onbeforeunload = function(e) {
		// alert('attention !!');
		// if($('.btn-annuler').length>0) {
			// var link = $('.btn-annuler').attr('href');
		// }
	// };
	
	// $(window).on('beforeunload', function() {
		// var x =logout();
		// return x;
	// });
	
	/*
		window_beforeUnload = function(e) {
			var message = 'a message2';
			

				e = e || e.event;

				if (e) {
					e.returnValue = message;
				}

				return message;


		};*/

		// window_unload = function(e) {


		// };
		


	/*	if (window.addEventListener) {
			window.addEventListener('beforeunload', window_beforeUnload, false);
		} else if (window.attachEvent) {
			window.attachEvent('onbeforeunload', window_beforeUnload);
		} else {
			throw "Cannot attach event handler";
		}*/

		// if (window.addEventListener) {
			// window.addEventListener('unload', window_beforeUnload, false);
		// } else if (window.attachEvent) {
			// window.attachEvent('onunload', window_beforeUnload);
		// } else {
			// throw "Cannot attach event handler";
		// }

	/**
		 * This javascript file checks for the brower/browser tab action.
		 * It is based on the file menstioned by Daniel Melo.
		 * Reference: http://stackoverflow.com/questions/1921941/close-kill-the-session-when-the-browser-or-tab-is-closed
		 */
		var validNavigation = false;
		var gounload = false;
		function wireUpEvents() {
		  /**
		   * For a list of events that triggers onbeforeunload on IE
		   * check http://msdn.microsoft.com/en-us/library/ms536907(VS.85).aspx
		   *
		   * onbeforeunload for IE and chrome
		   * check http://stackoverflow.com/questions/1802930/setting-onbeforeunload-on-body-element-in-chrome-and-ie-using-jquery
		   */
		  var dont_confirm_leave = 0; //set dont_confirm_leave to 1 when you want the user to be able to leave withou confirmation
		  // var leave_message = 'Attention ! toutes modification apportées sur la fiche seront perdues.'
		   var leave_message = 'Veuillez valider ou annuler la fiche avant de quitter.'
		  function beforegoodbye(e) {
			if (!validNavigation) {
			  if (dont_confirm_leave!==1) {
				if(!e) e = window.event;
				//e.cancelBubble is supported by IE - this will kill the bubbling process.
				e.cancelBubble = true;
				e.returnValue = leave_message;
				//e.stopPropagation works in Firefox.
				if (e.stopPropagation) {
				  e.stopPropagation();
				  e.preventDefault();
				}
				//return works for Chrome and Safari
				return leave_message;
			  }
			}
		  }
		  
		  
		  window.onbeforeunload	=	beforegoodbye;

		  // Attach the event keypress to exclude the F5 refresh
		  $(document).bind('keypress', function(e) {
			if (e.keyCode == 116){
			  validNavigation = true;
			}
		  });
		 
		  // Attach the event click for all links in the page
		  $('a').bind('click', function() {
			validNavigation = true;
		  });
		 
		  // Attach the event submit for all forms in the page
		  $('form').bind('submit', function() {
			validNavigation = true;
		  });
		 
		  // Attach the event click for all inputs in the page
		  $('input[type=submit]').bind('click', function() {
			validNavigation = true;
		  });
		 
		}
		 
		// Wire up the events as soon as the DOM tree is ready
		$(document).ready(function() {	
			if($('.btn-annuler').length>0) {				
				wireUpEvents();
			}
		});
		
		
	 // $('.table-mere').tablesorter({
		// scrollHeight: 300,
		// widgets: ['zebra','scroller']
	// });	

	
	$('.tablesorter-filter-row').livequery(function(){
		$(this).toggleClass('hide');
	});
		
	$('.btn_filter').live('click',function(e){
		e.preventDefault();
		// $(this).button('toggle');
		
		if($(this).parents('.block').find('table .group-header').length>0 ) {
			// hide group
			// $('.btn_group').button('toggle');
			$(this).parents('.block:first').find('table').trigger('sorton',[[1,0]]);
			$(this).parents('.block:first').find('table').trigger('destroy');
			$('.gp-sorter-false').removeClass('sorter-false');
			$(this).parents('.block:first').find('table').tablesorter({sortList: [[1,0]],widgets: ['filter']});
		}
		
		if($(this).parents('.block:first').find('.tablesorter-filter-row.hide').length == 0) {
			$(this).parents('.block:first').find('.tablesorter-filter').val('').change();
		}
		
		$(this).parents('.block:first').find('.tablesorter-filter-row').toggleClass('hide');
	});
	
	$('.btn_group').live('click',function(e){
		e.preventDefault();
		// $(this).button('toggle');
		// if(!$(this).parents('.block').find('.tablesorter-filter-row').hasClass('hide')) {
			// $('.btn_filter').button('toggle');
		// }
		if($(this).parents('.block:first').find('table .group-header').length>0 ) {
			// hide
			$(this).parents('.block:first').find('table').trigger('sorton',[[1,0]]);
			$(this).parents('.block:first').find('table').trigger('destroy');
			$('.gp-sorter-false').removeClass('sorter-false');
			$(this).parents('.block:first').find('table').tablesorter({sortList: [[1,0]],widgets: ['filter']});
		}else{
			// show 
			$(this).parents('.block:first').find('table').trigger('destroy');
			$('.gp-sorter-false').addClass('sorter-false');
			$(this).parents('.block:first').find('table').tablesorter({sortList: [[1,0]],widgets: ['group']});
			
		}

	});
		
		
	$('tr.onclickme').live('click',function(e){
		if (e.button==0){
		var methode = $(this).parents('.block').data().methodeclick;
		var waction = $(this).parents('.block').data().waction;
		var uid = $(this).children().first().text();
		var uidm = $('#uid').val();
		var DataSend = 'methode='+methode+'&uid_'+waction+'='+uid+'&uid='+uidm;
		
		$.ajax({
			type: 'POST',
			url: '/ExcMTH',
			dataType: 'TEXT',
			data:DataSend,
			error:function(msg){
				alert('Une erreur est survenue, veuillez réessayer.');
			},
			success:function(data){
				obj = eval(data);
				traitement_objects(obj);
				/*
			
				var type  = obj.type;
				var valeur  = obj.valeur;
				switch(type) {
					case 'refresh':
						refresh_objects(valeur);
					  break;
					case 'redirect':
						window.location.href = valeur;
					   break;  
					case 'autre':
					   
				}*/
				// refresh_objects(data);
			}		
		});
		}
	});
	
	// setInterval(function(){
		
		// $( 'tr.ondragme' ).draggable({
			// revert: true,
			//helper : "clone"
			 // helper: function(event) {
			//	$(this).data({'uid':$(this).children().first().text();
				// var waction = $(this).parents('.block').data().waction;
			//	return $('<div><table></table></div>').find('table').append($(this).clone());
				// return $('<div class="drag-cart-item"><table></table></div>').find('table').append($(event.target).closest('tr').clone().addClass('info'));
				
				//var clone_html = $(event.target).closest('tr').clone();
				// return $('<div class="drag-cart-item"><table></table></div>').find('table').append(clone_html);
			// },

		// });
		
	
	// },1000)
		$( 'tr.ondragme' ).livequery(function(){
			$(this).draggable({
				revert: true,
				 helper: function(event) {
					var waction = $(this).parents('.block').data().waction;
					return $('<div class="drag-cart-item"><table></table></div>').find('table').append($(event.target).closest('tr').clone().addClass('info'));
				},
			});
		});
		
		$('li.ondragme' ).livequery(function(){
			$(this).draggable({
				revert: true,
				helper: "clone",
			});
		});
		
	
		
		$( 'tr.onkeypressme' ).livequery(function(){
		
			$(this).keypress(function(){
					var uid 						= $('#uid').val();
					var waction				= $('#action').val();
					var methode				 =  $(this).parents('.block').data().methodedrop;
					var waction_drop 		 =  $(this).parents('.block').data().waction;
					var uid_drop				 =  $(this).children().first().text();
					var waction_drag		 = $(ui.draggable).parents('.block').data().waction;
					var uid_drag 				 =  $(ui.draggable).children().first().text();
					var DataSend 			 = 'uid='+uid+'&action='+waction+'&methode='+methode+'&uid_'+waction_drop+'='+uid_drop+'&uid_'+waction_drag+'='+uid_drag;
					
					$.ajax({
						type: 'POST',
						url: '/ExcMTH',
						 dataType: 'TEXT',
						 data:DataSend,
						 error:function(msg){
						alert('Une erreur est survenue, veuillez réessayer.');
						 },
						 success:function(data){
							 
							obj = eval(data);
							traitement_objects(obj);

						 }		
					 });
				
			});
		});
	
	
	 
		// $.fn.liveDroppable = function (opts) {
			// this.live("mouseenter", function() {
			 // if (!$(this).data("init")) {
				// $(this).data("init", true).droppable(opts);
			 // }
			// });
			// return $();
		// }; 
		
		$('.ondropme').livequery(function(){
			$(this).droppable({
				drop: function( event, ui ) {

					var uid       = $('#uid').val();
					var waction    = $('#action').val();
					var methode     =  $(this).parents('.block').data().methodedrop;
					var waction_drop    =  $(this).parents('.block').data().waction;
					var uid_drop     =  $(this).children().first().text();
					var waction_drag   = $(ui.draggable).parents('.block').data().waction;
					//var uid_drag      =  $(ui.draggable).children().first().text();
					var params     = '&';

					if($(ui.draggable).data().uid !== undefined) {
						var uid_drag     =  $(ui.draggable).data().uid;
						var datas     = $(ui.draggable).data();

						Object.keys(datas).forEach(function(key) {
							var valeur = datas[key];
							if(typeof(valeur) !== 'object' && key !== 'uid') {
								params+=key+"="+valeur;
							}
						});

					}else{
						var uid_drag      =  $(ui.draggable).children().first().text();
					}

					var DataSend     = 'uid='+uid+'&action='+waction+'&methode='+methode+'&uid_'+waction_drop+'='+uid_drop+'&uid_'+waction_drag+'='+uid_drag+params;

					$(this).parents('table').find('tr').removeClass('info');
					$(this).addClass('info');

					$.ajax({
						type: 'POST',
						url: '/ExcMTH',
						dataType: 'TEXT',
						data:DataSend,
						error:function(msg){
							alert('Une erreur est survenue, veuillez réessayer.');
						},
						success:function(data){

							obj = eval(data);
							traitement_objects(obj);

						}  
					});
				}
			});
		});
		
		$('.rights_Table').live('change',function(){

				var tableName=$(this).parents('tr').find('td:eq(2)').text();
				var acces=$(this).val();
				var pref=$(this).parents('div:eq(2)').attr('data-waction');
				var UIDM=$(this).parents('div:eq(2)').attr('data-uidm');
				var loading=$(this).parents('div:eq(1)').children().next();
				
				loading.removeClass('hide');
				
				var url = '/'+pref+'?action=editRight&UIDM='+UIDM+'&tableName='+tableName+'&acces='+acces;//&mode=popup&actionm='+actionm+forms_data;

					$.ajax({
							type: 'GET',
							url: url,  
							dataType: 'HTML',
							success:function(data){
								
								loading.addClass('hide');
								obj = eval(data);
								traitement_objects(obj);
							},
							error: function (xhr, ajaxOptions, thrownError) {
								var msg,noMsg=false;
								switch(xhr.status) {
								case 404:
									msg = 'Pas de réponse serveur.' 
									break;
								case 500:
									msg = 'Erreur serveur interne.'
									break;
								default:
									noMsg = true;
									break;
								}
								if(noMsg !== true) {
									alert(xhr.status +' : '+msg);
								}
								
							}
						
						});
	


});
		
		// $('.onglet').live('click',function(){
			// var action = $(this).parents('li:first').data().id;
		// });
		
		 // $('.context-menu-one').on('click', function(e){
			// console.log('clicked', this);
		 // });
	
		// Gestion du clic droit
			/*$('.table td').bind("contextmenu",function(e){
				e.preventDefault(); 
				var prefix	=	$(this).parents('[data-waction]').data('waction');
				console.log(prefix);
				GestionClicDroit(prefix);  
			}); */
			/*$('.table td').live('mousedown',function(e){ 
				var $this = $(this); 
				if( e.button == 2) { 
					var prefix	=	$this.parents('[data-waction]').data('waction');					
					GestionClicDroit(prefix);
					return false;
				} 
				return true;
			}); */
	
		// Fin :: Gestion du clic droit
		
		/*-------------- Gestion du clic Droit -------------------*/	
		/*
		function GestionClicDroit(prefix){ 
			$.contextMenu( 'destroy'); 
			if(Menu[prefix] != undefined && Menu[prefix] != null){
				ligneClicSimiulation();
				getContextMenu(function(key, options) {
					var $this	 	=	$(this);
					var $tr		 	=	$this.parents('tr');
					var action 		= options.items[key].id;
					var masque 	= options.items[key].masque;
					var uid			= $tr.children().first().text();
					$this.click();
					
					switch(action){
						case 'add':
							$('[data-waction="'+prefix+'"] .btn_add').click();
						break;
						case 'edit':
							$('[data-waction="'+prefix+'"] .btn-modifier-ligne').click();
						break;
						case 'del':											
							$('[data-waction="'+prefix+'"] .btn_sup').click();
						break;
						default:
							var url = '/'+prefix+'?action='+action+'&uid='+uid;
							$.ajax({
								type: 'GET',
								url: url,  
								dataType: 'HTML',
								error:function(msg){

								},
								success:function(response){
									if(response) {
										object = eval(response);
										traitement_objects(object);
									}
								}
							});
						break;						
					}
				},Menu[prefix]);
			}
		}
		
		function ligneClicSimiulation(){
			$('.table td').bind("contextmenu",function(e){
				var prefix	=	$(this).parents('[data-waction]').data('waction');
				var uid 		=	$(this).parents('tr:first').children().first().text();
				traitmentMenu(Menu[prefix],uid);
				$(this).click();
			});
		}
		
		function getContextMenu(fn,actionsList){
			$.contextMenu({
				selector: '.table td', 
				callback: fn,
				items : actionsList
			});
		}	
		
		function dispatchClick(a_link){
			var a = a_link;
			var e = document.createEvent('MouseEvents');
			e.initEvent( 'click', true, true );
			a.dispatchEvent(e);
		}
		*/
		/*-------------- Fin :: Gestion du clic Droit -------------------*/	  
		
	// $('.table-ligne').on('refreshFromCol', function(event, data) {
		// obj = eval(data);
		// traitement_objects(obj);						
	// });
	
		$(document).click(function(e){
			if($('.context-menu-list').is(':visible')){
				$('.context-menu-list').hide().remove();
			}
		});
		/*calculeMontantReg();
		setRef();
		setReg();
		sendParamDataRegFour();*/
		
		
		// $('.workflow').ready(function(){
			// $('input,select,textarea').not('.workflow textarea').attr('disabled','disabled');
		// });
		
		if($('.block_workflow').length>0) {
			$('input,select,textarea').not('.block_workflow textarea').attr('disabled','disabled');
		}
    });
	
	
	function serialTohtml(chaine) {
		var keys_vals = chaine.split('&');
		var html ='';
		for(index in keys_vals) {
			key = (keys_vals[index]).split('=')[0];
			val = (keys_vals[index]).split('=')[1];
			html+= '<input type="hidden" name="'+key+'" value="'+val+'" >';
		}
		return html;
	}
		
	function traitement_objects (object,tb) {
		
			tb_obj = object.reponse;
			for(var index_obj in tb_obj) {

				obj = tb_obj[index_obj];
				var type  = obj.type;
				var valeur  = obj.valeur;
				switch(type) {
					case 'refresh_lh':
						refresh_lh(obj);
					 break;
					case 'refresh':
						refresh_objects(valeur);
						if($('table.glisse').length){
							dragDdropeRows();
						}
						if($('table.colors').length){
							gestionCouleurs();
						}
						positionListChamp();
					  break;
					case 'redirect':
					case 'refresh_page':
						// window.location.href = valeur;
						if(valeur !== '') {
							$('#live').attr('href',valeur);
							dispatchMouseEvent($('#live'), 'click', true, true);
							$('#live').click();
						}
					   break; 
					case 'redirect_tab':
						$('#live_tab').attr('href',valeur);
						dispatchMouseEvent($('#live_tab'), 'click', true, true);
						$('#live_tab').click();
					   break; 
					case 'alerte':
						alert(valeur);
					   break; 
					case 'confirme':
						if(confirm(valeur)) {
							if(obj.url =='/ExcMTH') {
								ExcMTH (object.methode_nom ,object.methode_event ,object.methode_refresh,object.methode_ob_affect,object.methode_ob_depart);
							}else{
								var url = obj.url+'&confirm=oui';
								$.ajax({
									type: 'GET',
									url: url,  
									dataType: 'text',
									error:function(msg){
										// ro do gestion d'erreur
									},
									success:function(data){
										obj = eval(data);
										traitement_objects(obj);
									}
								});
							}
						}
						break;
					case 'modal_alerte':
						  $('body').append(valeur);
						  $('#myModal').modal('show');
						  $('#myModal').css({ 'margin-left': function () { return -($(this).width() / 2); }});
						  $('#myModal').css({ 'margin-top': function () { return -(($(this).height() / 2)+($('.modal-content').height()/2)); }});
						  break;
					case 'confirme':
						if(confirm(valeur)) {
							var type_confirm = obj.type_confirm;
							switch(type_confirm) {
								case 'parent':
									var add_to_link = 'confirm=oui';
									html_add_to_link = serialTohtml(add_to_link);
									$('.content form:first #uid').after(html_add_to_link);
									$('.btn-valider').click();
									break;
							}
						}
					   break;  					   
					case 'bool':
					   break;
					case 'refresh_cell' :
				   		refrechCell(valeur,tb);   
				}
			}	
	}
	
	// DOM 2 Events
	function dispatchMouseEvent (target, var_event) {
		var e = document.createEvent('MouseEvents');
		e.initEvent( var_event, true, true );
		target[0].dispatchEvent(e);
	}
	
	
	
	// dispatchMouseEvent(element, 'mouseover', true, true);
	// dispatchMouseEvent(element, 'mousedown', true, true);
	// dispatchMouseEvent(element, 'click', true, true);
	// dispatchMouseEvent(element, 'mouseup', true, true);
	
	function refresh_lh (obj) {
		//Object.keys(obj).forEach(function(key) {
			$('.listeh .lh_refresh').html(obj.valeur);
		//});
	}
	
	function refresh_objects (obj) {
			// obj = eval(data);
			Object.keys(obj).forEach(function(key) {
				//  uid hidden ---> to do
			
				// before refresh 
				// remove ckeditor
				if( obj[key].search('ckeditor') !== -1){
					var instance = CKEDITOR.instances[key];
					CKEDITOR.remove(instance);
					$('#cke_'+key).remove();
				}
				// remove multiselect
				if(obj[key].search('multiselectrecherche') !==-1){
					$('#ms-'+key).remove();
				}
				
				// refresh l'object
				if(key.search('block') ==-1){
					if(obj[key].search('checkbox') ==-1){
						
						//$('#'+key).replaceWith(obj[key]);
						
						// cas uid hidden
						if(obj[key].search('type="hidden') ==-1){
							$('#'+key).replaceWith(obj[key]);
						}else{
							// cas normal
							$('#'+key).val($(obj[key]).val());
						}
					}else{
						// si une checkbox
						$('#'+key).parent().replaceWith(obj[key]);
						
					}
				}else{
					// si un tableaux
					
					// $(key).replaceWith('<div class="refreshcol">test</div>');
					// $(key).addClass('.refreshcol');
					$(key).replaceWith(obj[key]);
					//$('.tablesorter').trigger('update');
				}

				// refresh le ckeditor
				if( obj[key].search('ckeditor') !== -1 ){
					CKEDITOR.replace(key);
				}
				
				// affichier ou masquer les champs invisible
				if( $('#'+key).hasClass('invisible')) {
					 $('#'+key).parents('.control-group').addClass('invisible');
				}else{
					 $('#'+key).parents('.control-group').removeClass('invisible');
				}
				
				if( $('#'+key).hasClass('groupe_invisible')) {
					 $('#'+key).parents('.groupe').addClass('invisible');
				}else{
					 $('#'+key).parents('.groupe').removeClass('invisible');
					 $('#'+key).removeClass('groupe_invisible');
				}
			});
	}
	
	function traitmentMenu(arrayObj,uid,wa) {
	
			Object.keys(arrayObj).forEach(function(key) {
				var id = arrayObj[key].id;
				//var action = arrayObj[key].name;
				var masque = $('.context-menu-list li[data-id='+id+'] span').html();
				 if(masque.search('{uid}') !==-1) {
					masque = masque.replace('{uid}',uid);
					$('.context-menu-list li[data-id='+id+'] span').html(masque);
				 }
				 if(masque.search('{action}') !==-1) {
					masque = masque.replace('{action}',id);
					$('.context-menu-list li[data-id='+id+'] span').html(masque);
				 }
				 
				 var nb_th = masque.split('{TH').length;
				 
				 for(var i=1;i<=nb_th;i++) { 
					 if(masque.search('{TH_') !==-1) {
						var pos_Start = masque.search('{TH_');
						var pos_End 	= masque.search('}');
						var titre 		= masque.substring(pos_Start+4,pos_End);
						var index		= 0;
						$('table.'+wa+' th').each(function(){
							if($(this).text() == titre || $(this).text() == titre+' '){
								index = $(this).index();
							}
						});
						
						var _tr = $('table.'+wa+' tr.info');
						
						if(_tr.hasClass('group-header')){
							var valeur 		= $('table.'+wa+' tr.info').next().find('td:eq('+index+')').text();
						}else{
							var valeur 		= $('table.'+wa+' tr.info td:eq('+index+')').text();
						}
						
						masque 		= masque.replace('{TH_'+titre+'}',valeur);
						$('.context-menu-list li[data-id='+id+'] span').html(masque);
					 }
				 }
			});
	}
	
	// le click droit sur les lignes 
	function clickDroitLigne(menu,wa){

		var x,y;
		//not('.collapse')
		$('table.'+wa+' tbody tr:not(.collapse,head)').live("contextmenu",function(e){ 
		
			$(this).click();
			var xtd = $(this).offset().left;
            var ytd = $(this).offset().top;

            var xc = e.pageX;
            var yc = e.pageY;

			var uid = $(this).children().first().text();
			
            // la construction de menu
            var html = '<ul class="context-menu-list context-menu-root" >';
            for (var i = 0; i < menu.length; i++) {
            	html = html + '<li class="context-menu-item" data-id="'+menu[i].id+'"><span>'+menu[i].name+'</span></li>'
            };
            html = html + '</ul>';

            $('.context-menu-list').remove();
            $('body').append(html);
			
			traitmentMenu(menu,uid,wa);
            
            $('.context-menu-list').show();
            $('.context-menu-list').css('top',yc-10);
            $('.context-menu-list').css('left',xc);
			
			clickDroitActions($(this),wa);
            return false;

		})

	}
	
	// Les actions de base du click droit
	function clickDroitActions(_target,wa){
		$('.context-menu-item').click(function(){
			var action = $(this).attr('data-id');
			var uid			= _target.children().first().text();
			var prefixclickdroit = _target.parents('table').attr('data-prefixclickdroit');
			switch(action){
				case 'add' :
					_target.parents('table').prev().find('.btn_add').click();
					break;
				case 'edit':
					_target.parents('table').prev().find('.btn-modifier-ligne').click();
					break;
				case 'del':
					_target.parents('table').prev().find('.btn_sup').click();
					break;
				/* spécifique au réglement */
				case 'RGLL':
					var four;
					if(! _target.hasClass('group-header') ){
						four  	= _target.find('td:eq(1)').text();
					}else{
						four 	= _target.next().find('td:eq(1)').text();
					}
					if(!_target.hasClass('group-header')){
						var are 	= _target.find('td:eq(4)').text();
						are 		= are.replace('-','');
						/*var montant = $('#montant').val();
						montant 	= montant.replace(',','.');*/

						_target.find('.editableReg').text(are);
						
						are 		= are.replace(',','.')
						calculeMontantReg();
						_target.find('.editableRef').click();
						incrementRefCheque(refc,flagc,four);
					}
					break;
				case 'RGLT':
					var four;
					if(! _target.hasClass('group-header') ){
						four  	= _target.find('td:eq(1)').text();
					}else{
						four 	= _target.next().find('td:eq(1)').text();
					}
					$(".ECRA.table td:contains('"+four+"')").each(function(){
						var tr = $(this).parent();
						var are 	= tr.find('td:eq(4)').text();
						are 		= are.replace('-','');
						/*var montant = $('#montant').val();
						montant 	= montant.replace(',','.');*/

						tr.find('.editableReg').text(are);
						are 		= are.replace(',','.')
						calculeMontantReg();
					});
					incrementRefCheque(refc,flagc,four);
					break;
				/* fin de spécifique */
				default:
					if(action.search('<a') ==-1 ){
						var url = '/'+prefixclickdroit+'?action='+action+'&uid='+uid;
						$.ajax({
							type: 'GET',
							url: url,  
							dataType: 'HTML',
							error:function(msg){

							},
							success:function(response){
								if(response) {
									object = eval(response);
									traitement_objects(object);
								}
							}
						});
					}
				break;	
			}
		})
	}

	//var sauv,txt,flag;





  
	
	function ckeDropLink(){

		var sauv = ''

	  	$(document).mousedown(function(event){
	  		if($(event.target).hasClass('champDrag') ){
	  			sauv = $(event.target).text();
	  			sauv = sauv.replace(' ','');
	  			txt = $(event.target).attr('data-champ');
	  			txt = '{' + txt.split(']')[1] +'}';
	  			flag = true;
	  		}
	  		
	  	})

	  	//for(var editor in CKEDITOR.instances) {
	  		setTimeout(function(){

	  			if( CKEDITOR.instances['corps'] != undefined ){
	  				
	  				CKEDITOR.instances['corps'].on('saveSnapshot', function(e) {
					    //if (e.editor.checkDirty()) {
					    if(sauv != '') {
					    	var data = CKEDITOR.instances.corps.getData();
							data = '<div>'+data+'</div>';
							var obj = $(data)
						    var wrap = obj.find("a:contains('"+sauv+"')").replaceWith('<b>'+txt+'</b>');
						    console.log(obj.find("a:contains('"+sauv+"')").length);
						    if(flag){
						    	CKEDITOR.instances.corps.setData(obj.html());
						    	flag = false;
						    }
					    }	
					    //}
					});

	  			}
					
	  		},800)
		  	
		//}
		
/*
		$(document).mousedown(function(event){
	  		//if($(event.target).attr('class') == 'champDrag'){
	  		if($(event.target).hasClass('champDrag') ){
	  			sauv = $(event.target).text();
	  			sauv = sauv.replace(' ','');
	  			txt = $(event.target).attr('data-champ');
	  			txt = '{' + txt.split(']')[1] +'}';
	  			flag = true;
	  		}
	  		
	  	})

	  	//for(var editor in CKEDITOR.instances) {
	  		setTimeout(function(){
	  			console.log(sauv,txt,flag);
	  			if( CKEDITOR.instances['corps'] != undefined ){
	  				
	  				CKEDITOR.instances['corps'].on('saveSnapshot', function(e) {
					    //if (e.editor.checkDirty()) {
					        var data = CKEDITOR.instances.corps.getData();
							data = '<div>'+data+'</div>';
							var obj = $(data)
						    var wrap = obj.find("a:contains('"+sauv+"')").replaceWith('<b>'+txt+'</b>');
						    console.log(obj.find("a:contains('"+sauv+"')").length);
						    if(flag){
						    	CKEDITOR.instances.corps.setData(obj.html());
						    	flag = false;
						    }
					    	
					    //}
					});

	  			}
					
	  		},800)*/

	}
	
	/*Ajouté par Smail LKOUATLI le 25/03/2014*/
	$('.expand_all').live('click',function(){
		$(this).children("li").slideToggle("fast");
	});
	
	/*Ajouté par Smail LKOUATLI le 25/03/2014*/
	 $(function(){

 		if($('.scrollme').length){
 			$('.scrollme').mCustomScrollbar({mouseWheel : true});
 		}
	});
	
	/*function calculeMontantReg(){
		var montant = 0;
		$('.ECRA.table tbody tr').not('.group-header').each(function(){
			var reg = $(this).find('.editableReg').text().replace(',','.');
			reg = parseFloat(reg);
			montant = montant + parseFloat(reg);

		})
		$('#montant').val(montant.toFixed(2).toString().replace('.',','));
	}

	function setRef(){

		$('#mode_reglement').livequery(function(){
			$('#mode_reglement').change(function(){
				
				val = $(this).val();
				console.log(val);
				if(val == 'Virement'){
					$('.table.ECRA thead tr th:last').hide();
					$('.table.ECRA tbody tr').not('.group-header').each(function(){
						$(this).find('td:last').hide();
					})
				}else{
  					$('.table.ECRA thead tr th:last').show();
					$('.table.ECRA tbody tr').not('.group-header').each(function(){
						$(this).find('td:last').show();
					})
				}
			})
		});
		
		$('.editableRef').livequery(function(){
			$(this).editable(
				{
					type: 'text',	
					//url : '/post',	
					validate: function(value) {
			           $(this).text(value);
			           var tr = $(this).parents('tr');
			           var four 	= tr.find('td:eq(1)').text();
			           $(".ECRA.table td:contains('"+four+"')").each(function(){
							var tr = $(this).parent();

							tr.find('.editableRef').text(value);
			       		})
			           return false;
			        }
				}
			);
		})
	}

	function setReg(){
		$('.editableReg').livequery(function(){
			$(this).editable(
				{
					type: 'text',	
					//url : '/post',	
					validate: function(value) {
						var tr = $(this).parents('tr');
						//var are = parseFloat(tr.find('td:eq(4)').text().replace('-','').replace(',','.'));
						var are = tr.find('td:eq(4)').text();
						are = are.replace('-','');
						are = are.replace(',','.');
						are = parseFloat(are);
						
						var val;
						if( value > are ){
							val = are;
						}else{
							val = value;
						}

						$(this).text(val);
						
					}				
				}
			);
		});
	}

	var regf_date,regf_mode_reg,regf_echeance,regf_banque,regf_mantant,regf_mode_reglement;
	var dataRegFour = '';

	function getParamDataRegFour(){
		var i = 0;
		$('.ECRA.table-ligne tbody tr').not('.group-header').each(function(){
			var uid,reg,ref_cheque;
			
			uid 		= $(this).find('td:eq(0)').text();
			reg 		= $(this).find('td:eq(5) a').text();
			ref_cheque 	= $(this).find('td:eq(6) a').text();

			if( reg != '0'){
				if(i == 0 ){
					dataRegFour = dataRegFour + uid + "|" + reg + "|" + ref_cheque ;
				}else{
					dataRegFour = dataRegFour + ":" + uid + "|" + reg + "|" + ref_cheque ;
				}
				i++;
				
			}
		});
		regf_date 			= $('#date').val();
		regf_mode_reglement = $('#mode_reglement').val();
		regf_echeance 		= $('#echeance').val();
		regf_montant 		= $('#montant').val();
		regf_banque 		= $('#banque').val();
	}

	function sendParamDataRegFour(){
		
		$('.reg-validation').click(function(e){

			e.preventDefault();
			getParamDataRegFour();
			var data = 'action=REGLER&date='+regf_date+'&mode_reglement='+regf_mode_reglement+'&echeance='+regf_echeance+'&montant='+regf_montant+'&banque='+regf_banque+'&data='+dataRegFour;
			$.ajax({
				type: 'POST', 
				url: '/RGLF',
				dataType: 'TEXT',
				//async: false,
				data:data,
				error:function(msg){
					console.log(msg);
				},
				success:function(data){
					console.log('ok');
				}
			});
			
		})
	}*/

	