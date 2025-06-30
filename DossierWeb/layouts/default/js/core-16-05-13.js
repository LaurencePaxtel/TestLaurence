
			
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
	
	  	$('.disableme').live('click',function(){
			$(this).text($(this).data().loadingtext);
			$(this).attr('disabled',true);
		});
		
		$('.invisibleme').live('click',function(){
			$(this).addClass('invisible');
		});
		
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

	function refresh_objects (data) {
		obj = eval(data);
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
					// cas normal
					$('#'+key).replaceWith(obj[key]);
				}else{
					// si une checkbox
					$('#'+key).parent().replaceWith(obj[key]);
				}
			}else{
				// si un tableaux
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
		});
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
					var html = instance.getData();
					$(this).val(html);
				});
				
								
				if( valeurIni !== valeurCurr || $('#'+methode_ob_depart).hasClass('go') || methode_event =='chargement' || methode_ob_depart == 'valider' && !$('#'+methode_ob_depart).hasClass('wait')) {
					
					$('#'+Vmethode_ob_depart).removeClass('go');
					$('#'+methode_ob_depart).data({'val':$('#'+methode_ob_depart).val()});
					var ob_affect = $('#'+methode_ob_affect);
					var ob_depart =  $('#'+methode_ob_depart).val();
					var ob_depart_uid = $('#'+methode_ob_depart).parents('.control-group').next().val();
					//var formData = $('#'+methode_ob_depart).parents('form').serialize()+'&methode='+methode_nom;

					//var formData = $('body').find('form').serialize()+'&methode='+methode_nom;
					
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
					formData = formData+'&methode='+methode_nom;
					
					var tables_uids	='';
									
					$('.table').each(function(){
						if($(this).find('.table_checkbox').length !==0){
							table_prefex = $(this).attr('class').split(' ')[0];
							tables_uids+= '&'+table_prefex+'_uids=';
							$(this).find('.table_checkbox:checked').each(function(){
								var index = $(this).parents('tr').index()+1;
								tables_uids+=$(this).parents('table:first').find(' tr:eq('+index+') td:first').text()+' ';	
							});
						}
					});
					
					DataSend = formData+tables_uids;
					
					$.ajax({
					type: 'POST', 
					url: '/ExcMTH',
					dataType: 'TEXT',
					//async: false,
					data:DataSend,
					error:function(msg){
						console.log(msg);
					},
					success:function(data){
							// obj = eval(data);
						// console.log(obj);
						//obj = JSON.parse(data);
						
						// if(data.search('HTML') !==-1) {
							// window.open(data);
						// }else{
							refresh_objects(data);
							//----------------------------------------->
							//obj = eval(data);
							// Object.keys(obj).forEach(function(key) {
								 ////uid hidden ---> to do
							
								////before refresh 
								////remove ckeditor
								// if( obj[key].search('ckeditor') !== -1){
									// var instance = CKEDITOR.instances[key];
									// CKEDITOR.remove(instance);
									// $('#cke_'+key).remove();
								// }
								////remove multiselect
								// if(obj[key].search('multiselectrecherche') !==-1){
									// $('#ms-'+key).remove();
								// }
								
								////refresh l'object
								// if(key.search('block') ==-1){
									// if(obj[key].search('checkbox') ==-1){
										////cas normal
										// $('#'+key).replaceWith(obj[key]);
									// }else{
										////si une checkbox
										// $('#'+key).parent().replaceWith(obj[key]);
									// }
								// }else{
									////si un tableaux
									// $(key).replaceWith(obj[key]);
									////$('.tablesorter').trigger('update');
								// }

								////refresh le ckeditor
								// if( obj[key].search('ckeditor') !== -1 ){
									// CKEDITOR.replace(key);
								// }
								
								////affichier ou masquer les champs invisible
								// if( $('#'+key).hasClass('invisible')) {
									 // $('#'+key).parents('.control-group').addClass('invisible');
								// }else{
									 // $('#'+key).parents('.control-group').removeClass('invisible');
								// }
							// });
							//------------------------------------------>
						// }
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
			$(this).parents('.datepicker').css('display','none');
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
		
		
		  // form validationEngine
		$('form.well').validationEngine();		
		
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
		
		
		$('.tablesorter').tablesorter({dateFormat: 'uk' });
		// }).tablesorterPager({
			// container: $(".pager"),
			// cssGoto  : ".pagenum",
			// removeRows: false,
			// output: '{startRow} - {endRow} / {filteredRows} ({totalRows})'
		// });
		
		//.tablesorterPager({container: $("#pager")});
		
		// input filter
		$('.numericonly').autotab_magic().autotab_filter('numeric');
		$('.textonly').autotab_magic().autotab_filter('text');
		$('.alphaonly').autotab_magic().autotab_filter('alpha');
		$('.regexonly').autotab_magic().autotab_filter({ format: 'custom', pattern: '[^0-9\.]' });
		$('.alluppercase').autotab_magic().autotab_filter({ format: 'alphanumeric', uppercase: true });
		$('.alluppercase1').autotab_magic().autotab_filter({ format: 'text', uppercase: true });
	    $('.phone').autotab({ format: 'number' });
	  
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
		
		// desactiver le click sur entré dans un formulaire
		$('.block form').live('keydown',function(e){
			if(e.keyCode == 13) {
				e.preventDefault();
				$(this).parents('.modal:first').find('form input').blur();
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
				selectableHeader: '<input type="text" id="search" class="search span2"  autocomplete="off" >'
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
			$(this).datepicker().datepicker();
			true;
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
						
						formData = formData+firstForm+formDataTemp;
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
				$(this).click();
				
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
			
			if($('.tab-content .tab-pane').length>1) {
				var firstTab = $('.tab-content .tab-pane:first > form fieldset input#uid');
				$('.tab-content .tab-pane:not(":first") ').each(function(){

					if($(this).find('> form fieldset').length>0) {
						//firstTab.before($(this).find('form fieldset').children().clone().addClass('hide')); 
						
						$(this).find('form fieldset').each(function(){
							//forms+= $(this).children().clone().addClass('hide');
							firstTab.before($(this).children().clone().addClass('hide')); 
						});
					}
					
				});
				
				$('.tab-content .tab-pane .tab-pane:first form:not(":first") ').each(function(){
						firstTab.before($(this).children().clone().addClass('hide')); 
				});
			}else {
				var firstform = $('form:first fieldset input#uid');
				$('form:not(":first")').each(function(){
						firstform.before($(this).children().clone().addClass('hide')); 
				});
			}
			
			that_btn.parent().addClass('loading');
			$('#valider').click();
			
			if($('.formError').length !== 0){
				//that_btn.addClass('invisible');
				that_btn.parent().removeClass('loading');
			}
			
		});
		

		$('.table-mere tbody tr').bind('click dblclick', function(e) {
			var index = $(this).index();
			var waction = ($(this).parents('.table').attr('class')).split(' ')[0];
			
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
			
			if( e.type == 'dblclick') {
				if($('#btn-edit').length==1) {
					//$('#btn-edit').click();
					window.location.href = $('#btn-edit').attr('href');
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
			table_ligne = $(this).parent().next();
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
			var url = '/'+waction+'?action=edit&uid='+uid+'&uidm='+uidm+'&mode=popup&actionm='+wactionm+param;
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
		
			
		$('.table-ligne tr').live('click dblclick', function(e) {
			
			var index = $(this).index()+1;
			var waction = ($(this).parents('.table-ligne').attr('class')).split(' ')[0];
			var that_btn_sup = $(this).parents('.table-ligne').prev().find('.btn_sup');
			var that_btn_modifier = $(this).parents('.table-ligne').prev().find('.btn-modifier-ligne');
			that_btn_sup.attr('disabled',true);

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
	});
		
	$('.btn-valider-ligne').live('click',function(e){
		// stop l'effet de l'event click
		e.preventDefault();
		
		// masquer le button valider
		var that = $(this);
		that.parent().addClass('hide');
		
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
					var index = $(this).parents('tr').index()+1;
					tables_uids+=$(this).parents('table:first').find(' tr:eq('+index+') td:first').text()+' ';	
				});
			}
		});
		
		var param = $(this).data().parameter;
		//var wactionm = $(this).parents('.block:first').data().wactionm;
		
		if(action == 'edit') {
			var index = that_modal.data().index;
			var url = '/'+waction+'?action='+action+'&uid='+uid+'&uidm='+uidm+'&mode=popup';
		} else {
			var index = 0;
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
			var progress = '<div class="progress progress-striped active"><div class="bar barDownlaod"></div><div class="percent"></div></div>';
			that_modal.find('.modal-footer').html(progress);
			var bar = $('.barDownlaod');
			var percent = $('.percent');
			var file = true;
		}

		// attacher le lien de post au formulaire
		that_modal.find('form').attr('action',url);
		
		// enelver touts les 'disabled' class avant de posté le formaulaire
		that_modal.find('.disabled').attr('disabled',false);
		
		// preparer la methode ajax d'envoie
		that_modal.find('form.'+waction).ajaxForm({
			 beforeSend: function(xhr,o) {
					// c'est  si le cas d'une formulaire qui contient un champ de type file
					if(file) {
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
						if(refresh_data !== 'true') {
							that_modal.find('.modal-body > div').html(refresh_data); 
						}
												
						// affecation au tableaux
						var tr = '<tr>';
						table_ligne.find(' tr th').each(function(){
							var titre = $(this).text();
							titre = titre.toLowerCase();
							titre = titre.replace(/[ [-]/gi,'_');
							
							if(titre == 'uid' ){
								tr+='<td class="hide">';
							}else{
								tr+='<td>';
							}
							// tr+=that_modal.find('#'+titre).val()+'</td>';
							
							if(that_modal.find('input[type=checkbox]#'+titre).length) {
								tr+=that_modal.find('#'+titre).parent().html()+'</td>';
							}else{
								tr+=that_modal.find('#'+titre).val()+'</td>';
							}
						});
						tr+= '</tr>';
						
						if(index == 0){
							if(table_ligne.find('tbody tr').length >0) {
								table_ligne.find('tbody tr:last').after(tr); 
							}else{
								table_ligne.find('tbody').html(tr); 
							}
							
							//selection la ligne ajouté dans la table
							table_ligne.find(' tr:last').click();
						}else{
							table_ligne.find(' tr:eq('+(index)+')').replaceWith(tr);
							//selection la ligne ajouté dans la table
							table_ligne.find(' tr:eq('+(index)+')').click();
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
					annuler = 'non';
					
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
					case 0:
						msg = 'Action interrompue par le serveur.'
						break;
					default:
						noMsg = thrownError;
						break;
					}
				
					alert(xhr.status +' : '+msg);
				}
		});
		
		//click sur valider pour commencer l'envoie
		that_modal.find('form.'+waction+' #valider').click();
		// that_modal.find('form.'+waction+' #valider').submit().click(function(e){e.preventDefault();});
	});
	
	$('.btn-annuler-ligne').live('click',function(e){
		e.preventDefault();
		annuler = 'oui';
		//fermer le modal
		var that_modal = $(this).parents('.modal:first');
		that_modal.modal('hide');
		that_modal.find('.modal-body > div').html(init_html);
		annuler = 'non';
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
			
			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'json',
				success: function(retour){
					//$('table.'+w_action+' tr:eq('+index+')').remove();	
					if(table_ligne=="") {
						$('.table tr:eq('+index+')').hide(1500).queue(function(){$(this).remove();});
					}else{
						table_ligne.find(' tr:eq('+index+')').remove();
						// refresh tablesorter
						$('.tablesorter').trigger('update');
						ini_selection_table();
					}

				},
				error: function(retour){
					//alert('Erreur !!');
				}
			});
			// $('#'+$(this).parents('.modal').attr('id')+' .close').click();
			// fermer le modal		
			that_modal.modal('hide');
		});
		
	// lancer la supression d'un ligne
	$('.sup_ligne').live('click',function(e){
			
			e.preventDefault();
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
				dataType: 'json',
				success: function(retour){
					//$('table.'+w_action+' tr:eq('+index+')').remove();	
					if(table_ligne=="") {
						$('.table tr:eq('+index+')').hide(1500).queue(function(){$(this).remove();});
					}else{
						table_ligne.find(' tr:eq('+index+')').remove();
						// refresh tablesorter
						$('.tablesorter').trigger('update');
						ini_selection_table();
					}
					
					refresh_objects(retour);
				},
				error: function(retour){
					//alert('Erreur !!');
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
		
		// var url = '/'+pref+'?action='+action+'&uidm='+uidm+'&mode=popup&actionm='+actionm+forms_data;
		var url = '/'+pref+'?action='+action+'&mode=popup&actionm='+actionm+forms_data;

		$.ajax({
			type: 'GET',
			url: url,  
			dataType: 'HTML',
			success:function(data){
				that_modal.find(' .modal-body > div').html(data);
				that_modal.css({'margin-left': function () { return -($(this).width() / 2); }});
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
	
	$('.btn-annuler-modal').click(function(e){
		e.preventDefault();
		var that_modal 	= $(this).parents('.modal_externe:first');
		that_modal.find(' .modal-body > div').html(init_html);
		that_modal.modal('hide');
	});
	
	$('.btn-valider-modal').click(function(e){
		e.preventDefault();
				
		var that 				= $(this);
		var that_modal 	= $(this).parents('.modal_externe:first');
		var pref 				= that_modal.data().prefex;
		var methode 	  	= that_modal.data().methode;
		var action 	  		= that_modal.data().action;
		var actionm 	  	= that_modal.data().actionm;
		//var uidm 	  		= that_modal.data().uidm;
		
		var uids				='';
		var tables_uids	='';
		var forms_data	='';
		// var formData 		='';
		
		// masquer le button valider
		that.parent().addClass('hide');
		
		$('.table').each(function(){
			if($(this).find('.table_checkbox').length !==0){
				table_prefex = $(this).attr('class').split(' ')[0];
				tables_uids+= '&'+table_prefex+'_uids=';
				$(this).find('.table_checkbox:checked').each(function(){
					var index = $(this).parents('tr').index()+1;
					tables_uids+=$(this).parents('table:first').find(' tr:eq('+index+') td:first').text()+' ';	
				});
			}
		});
		
		$('.tags').each(function(){
			$(this).val($(this).next().val());
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
		
		// $('.table_checkbox:checked').each(function(){
			// var index = $(this).parents('tr').index()+1;
			// uids+=$(this).parents('table:first').find(' tr:eq('+index+') td:first').text()+' ';	
		// });
		
		// var formData = $(this).parents('.modal-deversement:first').find('form').serialize();
		
				
		// var url = '/'+pref+'?&mode=popup&uids='+uids+formData;
		var url = '/'+pref;
		
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
			
				alert(xhr.status +' : '+msg);
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
		that.parent().removeClass('hide');
		that_modal.find(' .modal-body > div').html(init_html);
		that_modal.modal('hide');
	});
	
	$('.update_checkbox').live('click',function(){
		var that 				= $(this);
		var index_td		= $(this).parents('td:first').index();
		var that_table		= $(this).parents('.table:first');
		var that_block		= $(this).parents('.block:first');
		var prefex			= that_table.attr('class').split(' ')[0];
		var champ 			= that_table.find('th:eq('+index_td+')').data().champ;

		var uid					= $(this).parents('tr:first').find('td:first').text();
		var uidm 				= that_block.data().uidm;
		var wactionm		= that_block.data().wactionm;
		var valeur			= $(this).is(':checked');
		
		valeur 					= (valeur) ? 'vrai':'faux'; 
		
		var Data 				= 'action=editcol&champ='+champ+'&value='+valeur+'&uid='+uid+'&uidm='+uidm+'&actionm='+wactionm;
		
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

	$('tr.onclickme').live('click',function(){
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
				refresh_objects(data);
			}		
		});
		
	});
	
	setInterval(function(){
		
		$( 'tr.ondragme' ).draggable({
			revert: true,
			//helper : "clone"
			 helper: function(event) {
				//$(this).data({'uid':$(this).children().first().text();
				var waction = $(this).parents('.block').data().waction;
				// return $('<div><table></table></div>').find('table').append($(this).clone());
				return $('<div class="drag-cart-item"><table></table></div>').find('table').append($(event.target).closest('tr').clone().addClass('info'));
				
				//var clone_html = $(event.target).closest('tr').clone();
				 //return $('<div class="drag-cart-item"><table></table></div>').find('table').append(clone_html);
			},

		});
		
	
	},1000)
	 
	 $.fn.liveDroppable = function (opts) {
		this.live("mouseenter", function() {
		 if (!$(this).data("init")) {
			$(this).data("init", true).droppable(opts);
		 }
		});
		return $();
		}; 
				
	$('.ondropme').liveDroppable({
			drop: function( event, ui ) {
			
				var uid 						= $('#uid').val();
				var waction					= $('#action').val();
				var methode				 =  $(this).parents('.block').data().methodedrop;
				var waction_drop 		 =  $(this).parents('.block').data().waction;
				var uid_drop				 =  $(this).children().first().text();
				var waction_drag		 = 'RGLAVR'
				var uid_drag 				 =  $(ui.draggable).children().first().text();
				var DataSend 				 = 'uid='+uid+'&action='+waction+'&methode='+methode+'&uid_'+waction_drop+'='+uid_drop+'&uid_'+waction_drag+'='+uid_drag;
				
				$.ajax({
					type: 'POST',
					url: '/ExcMTH',
					 dataType: 'TEXT',
					 data:DataSend,
					 error:function(msg){
					alert('Une erreur est survenue, veuillez réessayer.');
					 },
					 success:function(data){
						 refresh_objects(data);
					 }		
				 });
			}
	});

		
	
    });
		
		
	
	  