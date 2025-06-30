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
	  
	$('#DOS_Cloture').click(function(e){   	

			Today = new Date;
			Jour = Today.getDate();
			Mois = (Today.getMonth())+1;
			Annee = Today.getFullYear();
			MessageDate = Jour + "/" + Mois + "/" + Annee;

			//DOS_Date_cloture.value =MessageDate;

		if  ($(this).is(":checked")){ 
				DOS_Date_cloture.value =MessageDate;
			}else { 
				DOS_Date_cloture.value ="dd/mm/yyyy";
			}

	});
			
			
 
	  $(function(){
	  
		 // Methode[CHARGEMENT|CLICK|FOCUSIN|FOCUSOUT:0_mouss_test(this;SOC_Escompte;30):vrai]
	  
		var Methodes=$('[class*="Methode"]');
		/*if(Methodes.length>0) {
		
			function ExcMTH () {
				$.ajax({
					type: 'GET',
					url: '/ExcMTH?methode=&retour=&params',  
					dataType: 'HTML',
					error:function(msg){
						console.log(msg);
					},
					success:function(data){
						$('#'+w_action+'_modal_edit .modal-body').html(data);
						//$('#modal_edit form').attr('action',action);
					}
				});
			}
			
			
			
			Methodes.each(function(){
				var Class = $(this).attr('class');
				var class_array = Class.split(' ');
				var methode_text = class_array[class_array.length]; // TO DO
				methode_text.replace('Methode[','');
				methode_text.replace(']','');
				var methode_events = methode_text.split(':')[0];
				var methode_appel = methode_text.split(':')[1];
				var methode_retour = methode_text.split(':')[2];
				var methode_event_array = methode_events.split('|')[0];
				
				for(var i=1;i<methode_event_array.length;i++) {
				
					switch(methode_event_array[i]) {
						case 'CHARGEMENT':
						  $(this).load(function(){ExcMTH(methode_nom;methode_params;methode_retour)});
						  break;
						case 'CLICK'
						  $(this).click(ExcMTH);
						  break;
						case 'FOCUSIN':
						   $(this).focusin(ExcMTH);
						  break;
						case 'FOCUSOUT':
						  $(this).focusout(ExcMTH);
					}
				}
				
			});
		}*/
		
		
		// inline inputs
		$('.col2').each(function(){
			$(this).parents('.control-group').wrap('<div class="span3 new" />').parent().prev().wrap('<div class="span3 new" />').parents('fieldset').find('.new').wrapAll('<div class="row" />').each(function(i){
				if(i==0) {
					var ClassSpan = $(this).children().children().children().attr('class');
					var pos = ClassSpan.search('span');
					var NumClassSpan = parseInt(ClassSpan.substr((pos+4),1));
					$(this).removeClass('span3').addClass('span'+(NumClassSpan+1));
				}

				$(this).removeClass('new');});
		});
		
		
		// buttons close
		$('.btn-close').live('click',function(){
			$(this).parents('.modal').find('.close').click();
		});
		
		  // form validationEngine
		$('form.well').validationEngine();		

		
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
		
		if($('.ckeditor').length>0) {
			CKEDITOR.replace('ckeditor');
		}
		
		
		$('.disabled').attr('disabled',true);

		$('.datepicker .day').click(function(){
			consol.log("test");
			$('body').click();
		});
		
		$(document).bind('DOMSubtreeModified',function(){
		  $('.fg-button').addClass('btn');
		  $('span .ui-state-disabled').addClass('btn-info');
		  $('.disabled').attr('disabled',true);
		});
				
		$('.alert').alert();
		
		//$('.datepicker').datepicker();
		
		$('.datepicker').live('focus', function() {
			$(this).datepicker().datepicker();
			true;
		});
		
		//$('.timepicker').timepicker({minuteStep: 5,defaultTime:'00:00', showSeconds: false, showMeridian: false});
		$('.timepicker').live('focus', function() {
			$(this).timepicker({minuteStep: 5,defaultTime:'00:00;00', showSeconds: false, showMeridian: false});
		});
		
		$('.multiSelect').multiSelect();
				
		$('.multiSelectRecherche').multiSelect({
		 selectableHeader: '<input type="text" id="search" class="search span2"  autocomplete="off" >'
		});

		$('.search').on('keydown',function(){
			var id = '#'+$(this).parents('.ms-container').attr('id');
			$(this).quicksearch($('li', id )).on('keydown', function(e){
				if (e.keyCode == 40){
				  $(this).trigger('focusout');
				  $(id).focus();
				  return false;
				}
			  }
			);
		});
				
		/*$('.callModal_sup').click(function(){
			var supid = ($(this).attr('href')).split('sup')[1];
			$('#sup').data({'id':supid});
			$('#sup').modal();
		});
		
		$('.del_item').click(function(){
			var url = location.pathname+'?action=del&uid='+$('#sup').data().id;
			window.location.replace(url);
		});*/
		
		$('#btn-edit').attr('disabled',true);
		$('#btn-del').attr('disabled',true);
		$('#btn-dup').attr('disabled',true);
		
		$('#btn-valider').click(function(e){
			e.preventDefault();
			$('#ValiderPrimary').click();
		});
		
		/*$('*:not(.content)').click(function(){
			console.log('test');
		});*/

		var uid = get('uid');
		
		
		if((uid !== false) && (uid !==undefined)){
			var uidmActionm = '&uidm='+uid+'&actionm='+(location.pathname).substr('1');
		}
		else
		{
		var uidmActionm =""
		}
		
		
		$('.table tr').bind('click dblclick', function(e) {
		//$('.table tr').click(function(e){
		console.log(e.type);
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
		
		/*$('.table tr').dblclick(function() {
			if($('#btn-edit').length=1) {
				$('#btn-edit').click();
			}
		});*/
	 
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
					$('#'+w_action+'_modal_edit .modal-body').html(data);
					//$('#modal_edit form').attr('action',action);
				}
			});
		});
		
		$('.btn_add').live('click',function(e){
			e.preventDefault();
			var w_action = ($(this).attr('class')).split(' ')[0];
			var uidm = $(this).attr('rel');

			$('#'+w_action+'_modal_add').css({'width':680,'margin':'-300px -340px'});
			$('#'+w_action+'_modal_add').data({'id':uidm});
			$('#'+w_action+'_modal_add').modal();
			var url = '/'+w_action+'?action=add&uidm='+uidm+'&mode=popup';
			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'HTML',
				error:function(msg){
					console.log(msg);
				},
				success:function(data){
					$('#'+w_action+'_modal_add .modal-body').html(data);
					//$('#modal_add form').attr('action',action);
				}
			});
		});
		
		
		
		$('.modal .close').bind('click');
		
		$('.valider_ligne').live('click',function(e){
			var w_action = ($(this).attr('class')).split(' ')[0];
			e.preventDefault();
			var uid = $(this).parents('form.'+w_action).find('#UID').val(); //$('form.'+w_action+' #UID').val();
			var uidm = $(this).parents('form.'+w_action).find('#UIDM').val(); //$('form.'+w_action+' #UIDM').val();
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
			
			 w_action
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
			$('#'+$(this).parents('.modal').attr('id')+' .close').click();
			return false;
		});
		
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
					$('table.'+w_action+' tr:eq('+index+')').remove();	
				},
				error: function(retour){
					//alert('Erreur !!');
				}
			});
			$('#'+$(this).parents('.modal').attr('id')+' .close').click();
		});
		
	/*var warning = true;
	window.onbeforeunload = function() { 
	  if (warning) {
		return "You have made changes on this page that you have not yet confirmed. If you navigate away from this page you will lose your unsaved changes";
	  }
	  return false;
	  }*/


	/*	$('.callModal_show').click(function(){
			var showid = ($(this).attr('href')).split('show')[1];
			$('#show').css({'width':680,'margin':'-300px -340px'});
			$('#show').data({'id':showid});
			$('#show').modal();
			var url = location.pathname+'?action=edit&uid='+$('#show').data().id;
			$.ajax({
				type: 'GET',
				url: url,  
				dataType: 'HTML',
				error:function(msg){
					console.log(msg);
				},
				success:function(data){
					$('#show .modal-body').html(data);
					var action = location.pathname+'?action=edit&uid='+$('#show').data().id;
					$('#show form').attr('action',action);
				}
			});
		});*/
		
		$('#show').bind('hidden', function () {
			$('#show .modal-body').html('<div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>');
		});
		
		
		
	/*	$("#prenomUser").typeahead({
			source: function (typeahead, term) {
				return $.get('/USRAG?action=auto&c=paysUser', { term: term }, function (data) {
					return typeahead.process(data);
				}, 'json');
			}
		});*/
		
		
		$('.btn-file').live('click',function(e){
			e.preventDefault();
			$(this).next().click();
		});
		
		$('input[type=file]').live('change',function(){
			$(this).prev().prev().attr('value',$(this).val());
			var namefile = $(this).val().split('\\')[(($(this).val().split('\\')).length)-1];
			$('.'+$(this).attr('name')+'_name').attr('value',namefile);
			$('.'+$(this).attr('name')+'_name').val(namefile);
			//$(this).parents('.control-group').next('.filename').attr('value',namefile);
		});
		
		
		$("#SocietesInterlocuteur").typeahead({
			 property: 'label', 
			 source:function (typeahead, term){ 
				return $.get('/INT?action=auto&c=SocietesInterlocuteur', { term: term }, function (data) { 
					return typeahead.process(data); 
					//return data; 
				}, 'json');
				return results;
			}
		});
		
				/*var results = $.ajax('/INT?action=auto&c=SocietesInterlocuteur', { 'term': term }, function (data) { 
					//return typeahead.process(data); 
					return data; 
				}, 'json');*/
				
				/*var results = $.get('/INT?action=auto&c=SocietesInterlocuteur', { 'term': term }, function (data) { 
					//return typeahead.process(data); 
					return data; 
				}, 'json');
				return results;*/
		
		/*$("#SocietesInterlocuteur").typeahead({
			 property: "label", 
			 source:[{'label':'champion decize','id':'11111111111111111'},{'label':'paxtel','id':'22222222222222'},{'label':'intermarche decize','id':'3333333333333333'},{'label':'leclerc decize'},{'label':'maison de la presse - decize'},{'label':'mlp decize mr motmaenfar afshin'}]
		});*/
		
		
	/* 	
	    $("#navigation").load(function (){       
   
	   
			
	    });  */
		
		$(".table tr").click(function(){
			$(".table tr.info").toggleClass('info');
			$(this).toggleClass('info');
		});
		
		$('.btn_capture').click(function (){
		      var contents = $("#navigation");
	
     	     $.ajax({
				type: 'POST',
				url: '/CAPTURE',
				dataType:'HTML',
				data: 'contenu='+contents,
				success: function(retour){
					//alert('Données Envoyer');
				 },
				  error: function(retour){
					//alert('Erreur !!');
				 } 
			 });
		
			/* $('#tache').tooltip(options); */
		
		});
		
		


    });
	  