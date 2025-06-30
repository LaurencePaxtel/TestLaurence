
	  
	// $('#DOS_Cloture').click(function(e){   	

			// Today = new Date;
			// Jour = Today.getDate();
			// Mois = (Today.getMonth())+1;
			// Annee = Today.getFullYear();
			// MessageDate = Jour + "/" + Mois + "/" + Annee;

			// DOS_Date_cloture.value =MessageDate;

		// if  ($(this).is(":checked")){ 
				// DOS_Date_cloture.value =MessageDate;
			// }else { 
				// DOS_Date_cloture.value ="dd/mm/yyyy";
			// }

	// });
			
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

		
		function ExcMTH (methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart) {
			
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
										
				if($('#'+methode_ob_depart).data().val !== $('#'+methode_ob_depart).val() || $('#'+methode_ob_depart).hasClass('go') || methode_event =='chargement') {
					
					$('#'+Vmethode_ob_depart).removeClass('go');
					$('#'+methode_ob_depart).data({'val':$('#'+methode_ob_depart).val()});
					var ob_affect = $('#'+methode_ob_affect);
					var ob_depart =  $('#'+methode_ob_depart).val();
					var ob_depart_uid = $('#'+methode_ob_depart).parents('.control-group').next().val();
					//var formData = $('#'+methode_ob_depart).parents('form').serialize()+'&methode='+methode_nom;

					//var formData = $('body').find('form').serialize()+'&methode='+methode_nom;
					
					var formData ='';
					var firstForm = false;
					var formModalLength = $('body').find('.modal-body form').length;
					
					$('body').find('form').each(function(){
						
						if(formModalLength == 0 && firstForm == false) {
							formData = $(this).serialize();
							firstForm = true;
							
						}else if($(this).parents('.modal-body').length >0) {
							formData = formData+'&'+$(this).serialize();
							
						}else{
							
							formDataTemp = $(this).serialize();
							posUID = formDataTemp.search('UID');
							formDataTemp = formDataTemp.substring(0,posUID-1);
							formData = formData+'&'+formDataTemp;
						}
					});
					
					formData = formData.substr(1)+'&methode='+methode_nom;
					
					$.ajax({
					type: 'POST', 
					url: '/ExcMTH',
					dataType: 'TEXT',
					data:formData,
					error:function(msg){
						console.log(msg);
					},
					success:function(data){
						obj = eval(data);
						console.log(obj);
						//obj = JSON.parse(data);
						Object.keys(obj).forEach(function(key) {
							$('#'+key).parent().html(obj[key]);
							if( $('#'+key).hasClass('invisible')) {
								 $('#'+key).parents('.control-group').addClass('invisible');
							}else{
								 $('#'+key).parents('.control-group').removeClass('invisible');
							}
						});
					}
				});
				}
			}

		}
		
		
		function SetExcMethode (Methodes) {
			Methodes.each(function(){
				
				// cas : checkbox
				if($(this).attr('class').split(' ')[0] == 'checkbox') {
					elem = $(this).children();
				}else{
					elem = $(this);
				}
				
				var idElem = elem.attr('id');
				
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
					    // $('#'+idElem).livequery(function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					  break;
					 // $('#'+idElem).livequery(function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					  // break;
					case 'click':
					 $('#'+idElem).click(function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					  break;
					case 'focusin':
					   $('#'+idElem).live('focusin',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					  break;
					case 'focusout':
					  $('#'+idElem).live('focusout',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					   break;
					case 'change':
					  $('#'+idElem).change(function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					   break;
					case 'keyup':
					  $('#'+idElem).live('keyup',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
					   break;  
					case 'blur':
					  $('#'+idElem).live('blur',function(){ExcMTH(methode_nom,methode_event,methode_refresh,methode_ob_affect,methode_ob_depart)});
				}
		
			});
		}
		
		$('[class*="methode"]').livequery(function(){
			var Methodes = $(this);
			SetExcMethode(Methodes);
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

		// width et height auto pour les modals
    	$('.modal').css({ 'margin-left': function () { return -($(this).width() / 2); }});
		
		$('.modal-backdrop').livequery('click',function(){
			$('.modal.hide').not('.in').find('.modal-body > div').html(init_html);
			$('.close').click();
		});
		
		
	
		// fix datepicker click out
		$('.datepicker .day').live('click',function(){
			$(this).parents('.datepicker').css('display','none');
		});
		
		
		// buttons close
		var annuler = 'non';
		$('.btn-close').live('click',function(){
			annuler = 'oui';
			$(this).parents('.modal:first').find('.close').click();
			$(this).parents('.modal:first').find('.modal-body > div').html(init_html);
		});
		
		
		  // form validationEngine
		$('form.well').validationEngine();		
		
		// table sorter
		//$('.table-ligne').tablesorter({ sortList: [[1,0]] });
		
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

		
		$(document).bind('DOMSubtreeModified',function(){
			$('.fg-button').addClass('btn');
			$('span .ui-state-disabled').addClass('btn-info');
			$('.table tr').disableSelection();	
		});
		
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
			Obj.wrap('<div class="span3 new" />').parents('fieldset').find('.new').wrapAll('<div class="row" />').each(function(i){
				if(i==0) {
					var ClassSpan = $(this).children().children().children().attr('class');
					var pos = ClassSpan.search('span');
					var NumClassSpan = parseInt(ClassSpan.substr((pos+4),1));
					$(this).removeClass('span3').addClass('span'+(NumClassSpan+1));
				}
				$(this).removeClass('new');});
		});
		
		// multiselect
		$('.multiselect').livequery(function(){
			$(this).multiSelect();
		});
		
		// multiselect avec la recherche
		$('.multiselectrecherche').livequery(function(){
			$(this).multiSelect({
				selectableHeader: '<input type="text" id="search" class="search span2" autocomplete="off" >'
			});
		});
		
			$('.ms-selectable .search').livequery(function(){
				$(this).on('keydown',function(){
					// var id = '#'+$(this).parents('.ms-container').attr('id');
					var id = '.ms-selectable .ms-list';
					$(this).quicksearch($('li', id )).on('keydown', function(e){
						if (e.keyCode == 40){
						  $(this).trigger('focusout');
						  $(id).focus();
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
		
		// sur validation d'un fiche
		$('.btn-valider').click(function(e){
			e.preventDefault();
			$('.disabled').attr('disabled',false);
			if($('.tab-content .tab-pane').length>1) {

				var firstTab = $('.tab-content #T1 > form fieldset input#uid');
				$('.tab-content .tab-pane:not("#T1") ').each(function(){
					if($(this).find('> form fieldset').length>0) {
						//firstTab.before($(this).find('form fieldset').children().clone().addClass('hide')); 
						
						$(this).find('form fieldset').each(function(){
							//forms+= $(this).children().clone().addClass('hide');
							firstTab.before($(this).children().clone().addClass('hide')); 
						});
					}
					
				});
				
				$('.tab-content .tab-pane #T1 form:not(":first") ').each(function(){
						firstTab.before($(this).children().clone().addClass('hide')); 
				});
			}else {
				var firstform = $('form:first fieldset input#uid');
				$('form:not(":first")').each(function(){
						firstform.before($(this).children().clone().addClass('hide')); 
				});
			}

			$('#valider').click();
		});
		

		$('.table-mere tr').bind('click dblclick', function(e) {
			var index = $(this).index();
			var waction = ($(this).parents('.table').attr('class')).split(' ')[0];
			if(index !=0) {
				var id = $(this).find('td:eq(0)').text();
				
				$('#btn-edit').attr('href','/'+waction+'?action=edit&uid='+id+uidmActionm);
				
				$('#btn-del').data({'index':index});
				$('#btn-del').attr('href',id);
				
				$('#btn-dup').attr('href','/'+waction+'?action=dup&uid='+id+uidmActionm);
				
				$('#btn-del').attr('disabled',false);
				$('#btn-edit').attr('disabled',false);
				$('#btn-dup').attr('disabled',false);
			}else{
				$('#btn-edit').attr('href','#');
				$('#btn-del').attr('href','#');
				$('#btn-dup').attr('href','#');
				$('#btn-edit').attr('disabled',true);
				$('#btn-del').attr('disabled',true);
				$('#btn-dup').attr('disabled',true);
			}
			
			if( e.type == 'dblclick') {
				if($('#btn-edit').length=1) {
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
		
		
		$('.table tr').disableSelection();
	 
		$('#btn-del').click(function(e){
			if($(this).attr('href') == '#') {
				e.preventDefault();
			}else{
				e.preventDefault();
				var w_action = ($(this).attr('class')).split(' ')[0];
				var uid = $(this).attr('href');
				var uidm = $(this).attr('rel');
				//var index = $(this).parents('tr').index();
				var index = $(this).data().index;
				$('#'+w_action+'_modal_del').css({'width':500,'margin':'-300px -250px'});
				$('#'+w_action+'_modal_del').data({'uid':uid,'uidm':uidm,'index':index,'w_action':w_action});
				$('#'+w_action+'_modal_del').modal();
			}
		});
		
		$('.btn_del').live('click',function(e){
			e.preventDefault();
			var w_action = ($(this).attr('class')).split(' ')[0];
			var uid = $(this).attr('href');
			var uidm = $(this).attr('rel');
			var index = $(this).parents('tr').index();
			//var index = $('#btn-del').data().index;
			$('#'+w_action+'_modal_del').css({'width':500,'margin':'-300px -250px'});
			$('#'+w_action+'_modal_del').data({'uid':uid,'uidm':uidm,'index':index,'w_action':w_action});
			$('#'+w_action+'_modal_del').modal();
		});
		
		$('.btn_edit').live('click',function(e){
			e.preventDefault();
			var w_action = ($(this).attr('class')).split(' ')[0];
			var uid = $(this).attr('href');
			var uidm = $(this).attr('rel');
			var index = $(this).parents('tr').index();
			
			$('#'+w_action+'_modal_edit').css({'width':680,'margin':'-300px -340px'});
			$('#'+w_action+'_modal_edit').data({'id':uid,'index':index});
			$('#'+w_action+'_modal_edit').modal();
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
		
		var table_ligne ='';
		$('.btn_add').live('click',function(e){
			e.preventDefault();
			table_ligne = $(this).parent().next();
			var w_action = ($(this).attr('class')).split(' ')[0];
			var uidm = $(this).attr('rel');
			var param =$(this).data().parameter;
			var actionm = location.pathname.substr(1);
			
			if(param!=""){
				param="&"+param
			}
			
			$('#'+w_action+'_modal_add .modal-body > div').html(init_html);
			$('#'+w_action+'_modal_add').css({ 'margin-left': function () { return -($(this).width() / 2); }});
			//$('#'+w_action+'_modal_add').css({'width':680,'margin':'-300px -340px'});
			
			$('#'+w_action+'_modal_add').data({'uidm':uidm});
			$('#'+w_action+'_modal_add').modal();
			
			var url = '/'+w_action+'?action=add&uidm='+uidm+'&mode=popup&actionm='+actionm+param;
			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'HTML',
				error:function(msg){
					console.log(msg);
				},
				success:function(data){
					$('#'+w_action+'_modal_add .modal-body > div').html(data);
					$('#'+w_action+'_modal_add').css({ 'margin-left': function () { return -($(this).width() / 2); }});
					//$('#modal_add form').attr('action',action);
				}
			});
		});
		
		
		
		$('.modal .close').bind('click');
		
		$('.table-ligne tr').live('click dblclick', function(e) {
		
			var index = $(this).index();
			var waction = ($(this).parents('.table-ligne').attr('class')).split(' ')[0];
			var that_btn_sup = $(this).parents('.table-ligne').prev().find('.btn_sup');
			var that_btn_modifier = $(this).parents('.table-ligne').prev().find('.btn-modifier-ligne');
			
			if(index !=0) {
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
				//btn-modifier-ligne
				that_btn_modifier.attr('href','#');				
				that_btn_modifier.attr('disabled',true);
				
				//btn-supprimer-ligne
				//$('.'+waction+'.btn_sup').attr('href','#');
				that_btn_sup.data({'index':'','uid':''});
				that_btn_sup.attr('disabled',true);
			}
			
			if( e.type == 'dblclick') {
				if(that_btn_modifier.length=1) {
					//$('#btn-edit').click();
					//window.location.href = $('.'+waction+'.btn-modifier-ligne').attr('href');
					that_btn_modifier.click();
				}
			}
		});
		
		$('.btn_sup').click(function(e){
			if($(this).data().uid == undefined || $(this).data().uid == '' ) {
				e.preventDefault();
			}else{
				e.preventDefault();
				table_ligne = $(this).parent().next();
				var w_action = ($(this).attr('class')).split(' ')[0];
				var uid = $(this).data().uid; //$(this).attr('href');
				var uidm = $(this).attr('rel');
				//var index = $(this).parents('tr').index();
				var index = $(this).data().index;
				$('#'+w_action+'_modal_del').css({'width':500,'margin':'-300px -250px'});
				$('#'+w_action+'_modal_del').data({'uid':uid,'uidm':uidm,'index':index,'w_action':w_action});
				$('#'+w_action+'_modal_del').modal();
			}
		});
		
		$('.btn-modifier-ligne').click(function(e){
			e.preventDefault();
			var w_action = ($(this).attr('class')).split(' ')[0];
			var uid = $(this).data().uid;
			var uidm = $(this).attr('rel');
			var index = $(this).data().index;
			var actionm = location.pathname.substr(1);
			table_ligne = $(this).parent().next();
			//var that_modal = $(this).parents('.modal');
			
			$('#'+w_action+'_modal_edit .modal-body > div').html(init_html);
			$('#'+w_action+'_modal_edit').css({ 'margin-left': function () { return -($(this).width() / 2); }});
			// $('#'+w_action+'_modal_edit').css({'width':680,'margin':'-300px -340px'});
			$('#'+w_action+'_modal_edit').data({'uid':uid,'index':index});
			$('#'+w_action+'_modal_edit').modal();
			$('#'+w_action+'_modal_edit').css({ 'margin-left': function () { return -($(this).width() / 2); }});
			var url = '/'+w_action+'?action=edit&uid='+uid+'&uidm='+uidm+'&mode=popup&actionm='+actionm;
			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'HTML',
				error:function(msg){
					console.log(msg);
				},
				success:function(data){
					$('#'+w_action+'_modal_edit .modal-body > div').html(data);
					$('#'+w_action+'_modal_edit').css({ 'margin-left': function () { return -($(this).width() / 2); }});
					//$('#modal_edit form').attr('action',action);
				}
			});
		});
		
		$('#RechercheM').click(function(){
			var valeur_Recherche = $(this).val();
			if(valeur_Recherche !=='') {
				window.location.href = 	location.origin+location.pathname+'?action=liste&rechercheM='+valeur_Recherche;
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
	
	$('.btn-valider-ligne').live('click',function(e){
		// stop l'effet de l'event click
		e.preventDefault();
		
		// remplire mes variables
		var w_action = ($(this).attr('class')).split(' ')[0];
		var that_modal = $(this).parents('.modal:first');
		var table_ligne = $(this).parents('.modal-ligne:first').find('.table-ligne');
		var uid = that_modal.find('form.'+w_action+' #uid').val(); 
		var uidm = that_modal.find('form.'+w_action+' #uidm').val();
		var action = that_modal.find('form.'+w_action+' #action').val(); 
		var clone = table_ligne.find(' tr:eq(1) td:first').html();
	
		if(action == 'edit'){
			var index = that_modal.data().index;
			var url = '/'+w_action+'?action='+action+'&uid='+uid+'&uidm='+uidm+'&mode=popup';
			table_ligne.find(' tr:eq('+index+')').remove();	
		} else {
			var url = '/'+w_action+'?action='+action+'&uidm='+uidm+'&mode=popup';
		}
			
		// extraction des paramteres pour les methodes de refresh
		var chaine_methode =  that_modal.find('form.'+w_action+' #valider').attr('class'); 
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
		
		// prepare le progress bar si le cas de w_action = DOC
		if(w_action == 'DOC') {
			var progress = '<div class="progress progress-striped active"><div class="bar barDownlaod"></div><div class="percent"></div></div>';
			that_modal.find('.modal-footer').html(progress);
			var bar = $('.barDownlaod');
			var percent = $('.percent');
			var doc = true;
		}

		// attacher le lien de post au formulaire
		that_modal.find('form').attr('action',url);
		
		// enelver touts les 'disabled' class avant de posté le formaulaire
		that_modal.find('.disabled').attr('disabled',false);
		
		// preparer la methode ajax d'envoie
		that_modal.find('form.'+w_action).ajaxForm({
			 beforeSend: function(xhr,o) {
					// c'est  si le cas du DOC
					if(doc) {
						var percentVal = '0%';
						bar.width(percentVal);
						percent.html(percentVal);
					}
					xhrf = xhr;
				},
				uploadProgress: function(event, position, total, percentComplete) {
					// c'est  si le cas du DOC
					if(doc) {
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
							tr+=that_modal.find('#'+titre).val()+'</td>';
						});
						tr+= '</tr>';
						table_ligne.find(' tr:last').after(tr);
						
						// si on a detecter une refresh d'un fiche alors on lance une refresh
						if (refresh == 'refresh_fiche'){
							window.location.href = 	window.location.href+'&refresh='+refresh+'&MethodeTr='+MethodeTr;
						}
							
						// fermer le modal		
						that_modal.find('.close').click();
						// enelever e progress bar du DOC s'il existe
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
					
				}
		});
		
		//click sur valider pour commencer l'envoie
		that_modal.find('form.'+w_action+' #valider').click();
	});
		
		
		/*$('.valider_ligne').live('click',function(e){
			var w_action = ($(this).attr('class')).split(' ')[0];
			e.preventDefault();
			var uid = $(this).parents('form.'+w_action).find('#uid').val(); //$('form.'+w_action+' #uid').val();
			var uidm = $(this).parents('form.'+w_action).find('#uidM').val(); //$('form.'+w_action+' #uidM').val();
			var action = $(this).parents('form.'+w_action).find('#action').val(); //$('form.'+w_action+' #action').val();
			var clone = $('table.'+w_action+' tr:eq(1) td:first').html();
			var index = $('#'+w_action+'_modal_edit').data().index;  
			
			if(action=='edit'){
				var url = '/'+w_action+'?action='+action+'&uid='+uid+'&uidm='+uidm+'&mode=popup';
				$('table.'+w_action+' tr:eq('+index+')').remove();	
				var modal = 'modal_edit';
			}else{
				var url = '/'+w_action+'?action='+action+'&uidm='+uidm+'&mode=popup';
				var modal = 'modal_add';
			}
			
			// w_action
			var tr = '<tr>';
			$('table.'+w_action+' tr th').each(function(){
				var titre = $(this).text();
				
				if(titre == 'Actions' || titre == 'Actions ' ) {
					clone = clone.replace(/uid_valeur/gi,uid);
					tr+='<td>'+clone+'</td>';
				}else {
					//tr+='<td>'+$('#'+titre).val()+'</td>';
					tr+='<td>'+$('#'+w_action+'_'+modal+' #'+titre).val()+'</td>';
				}
			});
			tr+= '</tr>';
			
			$('table.'+w_action+' tr:last').after(tr);
			

			$.ajax({
				type: 'POST',
				url: url,
				dataType: 'json',
				data:$('#'+w_action+'_'+modal+' form.'+w_action).serialize(),
				success: function(retour){
					//alert('Enregistrement creé avec succés.');
				},
				error: function(retour){
					//alert('Erreur !!');
				}
			});
			$(this).parents('.modal').find('.close').click(); 
			return false;
		});*/
		
		$('.sup_ligne').live('click',function(e){
			var w_action = ($(this).attr('class')).split(' ')[0];
			e.preventDefault();
			//var w_action = $('#modal_del').data().w_action;
			var uid = $('#'+w_action+'_modal_del').data().uid;
			var uidm = $('#'+w_action+'_modal_del').data().uidm;
			var index = $('#'+w_action+'_modal_del').data().index;
			
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
					}

				},
				error: function(retour){
					//alert('Erreur !!');
				}
			});
			$('#'+$(this).parents('.modal').attr('id')+' .close').click();
		});

		
		
		$('#show').bind('hidden', function () {
			$('#show .modal-body > div').html('<div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>');
		});
		
		
		$('.btn-file').live('click',function(e){
			e.preventDefault();
			$(this).next().click();
		});
		
		$('input[type=file]').change(function(){
			$(this).prev().prev().attr('value',$(this).val());
			var namefile = $(this).val().split('\\')[(($(this).val().split('\\')).length)-1];
			var classNameDOC = ($(this).attr('name')+'_name').toLowerCase();
			$('.'+classNameDOC).attr('value',namefile);
			$('.'+classNameDOC).val(namefile);
		});
		
				
		$('.table tr').live('click',function(){
			$(".table tr.info").toggleClass('info');
			$(this).toggleClass('info');
		});	
    });