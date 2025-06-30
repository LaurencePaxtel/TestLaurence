      $(function(){
        /*$("input, textarea, select, button").uniform();*/
		//$('.disabled').attr('disabled',true);


		
		$(document).bind('DOMSubtreeModified',function(){
		  $('.fg-button').addClass('btn');
		  $('span .ui-state-disabled').addClass('btn-info');
		  $('.disabled').attr('disabled',true);
		});
				
		$('.alert').alert();
		
		
		$("#CAPFilter").click(function(e){
			e.preventDefault();
			var that = $(this);
			$(this).attr('disabled',true);
			alert("test");
			
				
			var data = $('#filter_CAP').serialize();
			
			$.ajax({  
				type: 'GET',    
				url: 'http://'+document.location.host+'/CAP?action=liste&search=filter&'+data,
				dataType: 'json',
				error:function(data){
					that.removeAttr('disabled');
					$('.img-load').remove();
				},
				success:function(data){
					that.removeAttr('disabled');
				
				}
			});
		});
		
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
		
		/*$('.callModal_sup').click(function(){
			var supid = ($(this).attr('href')).split('sup')[1];
			$('#sup').data({'id':supid});
			$('#sup').modal();
		});
		
		$('.del_item').click(function(){
			var url = location.pathname+'?action=del&uid='+$('#sup').data().id;
			window.location.replace(url);
		});*/
		
		$('.btn_del').live('click',function(e){
			e.preventDefault();
			var w_action = ($(this).attr('class')).split(' ')[0];
			var uid = $(this).attr('href');
			var uidm = $(this).attr('rel');
			var index = $(this).parents('tr').index();
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
			var uid = $('form.'+w_action+' #UID').val();
			var uidm = $('form.'+w_action+' #UIDM').val();
			var action = $('form.'+w_action+' #action').val();
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
			
			var tr = '<tr>';
			$('table.'+w_action+' tr th').each(function(){
				var titre = $(this).text();
				
				if(titre == 'Actions') {
					clone = clone.replace(/uid_valeur/gi,uid);
					tr+='<td>'+clone+'</td>';
				}else {
					tr+='<td>'+$('#'+titre).val()+'</td>';
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
					//alert('Enregistrement creÃ© avec succÃ©s.');
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
		
		
		$('.btn-file').click(function(e){
			e.preventDefault();
			$(this).next().click();
		});
		
		$('input[type=file]').change(function(){
			$(this).prev().prev().attr('value',$(this).val());
			var namefile = $(this).val().split('_')[(($(this).val().split('_')).length)-1];
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
					//alert('DonnÃ©es Envoyer');
				 },
				  error: function(retour){
					//alert('Erreur !!');
				 } 
			 });
		
		
		
		});


    });
	  