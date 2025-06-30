var date = new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		var datedate = "";
		//fonction de recupération
		function get(choix) {
			var url = location.search;
			url = url.substr(1);
			key_vals = url.split('&');
			for(var index in key_vals) {
				key_val = key_vals[index].split('=');
				var key = key_val[0];
				var val = key_val[1];
				if(choix == key) {
					return val;
				}
			}
			return "";
		};
		
$(function() {
		
	
		
			// multiselect
			$('.multiselect').multiSelect();
			
			// multiselect avec la recherche
			$('.multiselectrecherche').multiSelect({
				selectableHeader: '<input type="text" id="search" class="search span2"  style="margin-bottom: 0px;" autocomplete="off" >'
			});

			$('.ms-selectable .search').on('keydown',function(){
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
				
				var mode =get('mode');	
				var view;
				if(mode =='jour'){
					view ='agendaDay';
				}else if(mode=='semaine'){
					view ='agendaWeek';
				}else{
					view ='month';
				};
			
			
			var months    = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
			var months_fr = ['Jan','Fev','Mar','Avr','Mai','Jui','Jul','Auo','Sep','Oct','Nov','Dec'];	
			var ladate = get('date');
			var ladate_day,ladate_month,ladate_year;
			if(ladate!==""){
				ladate_day = parseInt(ladate.split("/")[0]);
				if(months.indexOf(ladate.split("/")[1]) !==-1){
					ladate_month = parseInt(months.indexOf(ladate.split("/")[1]));
				}else {
					ladate_month = parseInt(months_fr.indexOf(ladate.split("/")[1]));
				}
				
				ladate_year = parseInt(ladate.split("/")[2]);
			
			}
			
			
			$('#calendar').fullCalendar({
					month:    ladate_month ,
					year:     ladate_year,
					date:      ladate_day,
				dayClick: function(datedate, allDay, jsEvent, view) {
					var val_date = $('#dateselect').text(datedate);
				},
												
				// locale
				isRTL: false,
				firstDay: 1,
				monthNames: ['Janvier','Février','Mars','Avril','Mai','Juin','Juillet','Août','Septembre','Octobre','Novembre','Décembre'],
				monthNamesShort: ['Jan','Fev','Mar','Avr','Mai','Jui','Jul','Auo','Sep','Oct','Nov','Dec'],
				dayNames: ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'],
				dayNamesShort: ['Dim','Lun','Mar','Mer','Jeu','Ven','Sam'],
				
				buttonText: {
					today:    'Ajourd\'hui' ,
					month:    'Mois' ,
					week:     'Semaine',
					day:      'Jour'
				},
				header: {
					left: 'prev,next today',
					center: 'title',
					right: 'month,agendaWeek,agendaDay'
					//right: 'month,basicWeek,basicDay' //new
				},
				defaultView: view,
				editable: true,
				disableResizing:true,
				allDaySlot:false,
				events: [<!--4dhtml SCRIPTHISTO-->],
				timeFormat: 'HH:mm',
				eventRender: function(event, element) {
					element.qtip({
						content: {    
										title: { text: event.title },
										text: "<b>Société : </b>"+event.societe+"<br/><b>Durée : </b>"+event.dureeheure+"<br/><b>Heure de Début : </b>"+event.begin
									},
						show :{solo:true},
						hide: { when: 'inactive', delay: 1000 }, 
						style: { 
							name : 'blue',
							border: {
							width: 1,
							radius: 3}
						 },
					});		
				},
				eventDrop: function(event) {
					$.post('/AGDAAJAX',{'id' : event.id,'dateStart' :String(event.start),'dateEnd' :String(event.end)},'json');					
				},
				eventResize: function(event) {
					$.post('/AGDAAJAX',{'id' : event.id,'dateStart' :String(event.start),'dateEnd' :String(event.end)},'json');
				}
			});	
			
			

		$('#btn-valider').live('click',function(){
			var url = '/AGDA?usrs='+$('#collaborateurs').val();
			var urltype = $('#type_action option:selected').val();
			var voirttconges = $('#voirtousconges').attr('checked') ? 1 : 0;
			
			if	(voirttconges==1){
				var valcheck ="vrai"
			}else{
				var valcheck ="faux"
			}
			
			window.location =url.replace(new RegExp(",","g"),"|")+"&type="+urltype+"&voirttconges="+valcheck;
			$('#type_action :selected').val();
		});
			
		// double click dans mode de vue jour
		$('.fc-view-agendaDay .fc-agenda-slots td.fc-widget-content').live('dblclick', function(){
				if ($(this).parent().hasClass('fc-minor')) {
					
					var heure = $(this).parent().prev().text();
					var espaceh =heure.trim();
					var heuref= espaceh+':30:00';
				}else{
					heure = $(this).prev().text();
					espaceh = heure.trim();
					heuref= espaceh+':00:00';
				}
				
				var nbr = heuref.length;
					if(nbr<=9){
						heuref = '0'+heuref;
					}else{
						heuref =heuref;
					}
					
				var datee = $('.fc-header-title');
				var datef = $('h2' , datee).text();
				
				var datef = datef.substr(datef.indexOf(',') + 2);
				var jour = datef.substring(4,6);
				
				var jrs = jour.replace(",","");
				
				var len = jrs.length;
					if(len==1){
						jourf = '0'+jrs;
					}else{
						jourf =jrs;
					}
				var mois = datef.substring(0,3)
				var annee = datef.substr(datef.lastIndexOf(',') + 2);
				var madate=jourf+'/'+mois+'/'+annee;
				var usrs =get('usrs');
				var type =get('type');
				var url ='/HAC?action=add&refer=AGDA&date='+madate+'&heure='+heuref+'&mode=jour&usrs='+usrs.toString()+'&type='+type.toString();
				window.location = url;
		});
		
		// double click dans mode de semaine fc-view-agendaWeek
		$('.fc-view-agendaWeek .fc-agenda-slots td.fc-widget-content').live('dblclick',function(){
			
			// on récupère la date séléctionnée
			var datesel =$('#dateselect').text();
			
			// on decoupe la date compléte
			var jour = datesel.substr(8,2);
			var mois  = datesel.substr(4,3);
			var annee = datesel.substr(11,4);
			var madate = jour + '/'+mois+'/'+annee;
			var heure = datesel.substr(16,8);
			
			//on construit la requete et on redirige vers la prise de rendez-vous
			var usrs =get('usrs');
			var type =get('type');
			var url ='/HAC?action=add&refer=AGDA&date='+madate+'&heure='+heure+'&mode=semaine&usrs='+usrs.toString()+'&type='+type.toString();
			window.location = url;

		});
		
		// double click dans mode de mois fc-other-month //fc-view-month
		$('.fc-view-month td.fc-widget-content').live('dblclick',function(){
			// on récupère la date séléctionnée
			var datedusel =$('#dateselect').text();
			// on decoupe la date compléte
			var today = new Date();
			var heure = today.getHours();
			var min = today.getMinutes();
			var heure_complete = heure+":"+min+":00"
			var jour = datedusel.substr(8,2);
			var mois  = datedusel.substr(4,3);
			var annee = datedusel.substr(11,4);
			var madate = jour+'/'+mois+'/'+annee;
			//on construit la requete et on redirige vers la prise de rendez-vous
			var usrs =get('usrs');
			var type =get('type');
			var url ='/HAC?action=add&refer=AGDA&date='+madate+'&heure='+heure_complete+'&mode=mois&usrs='+usrs.toString()+'&type='+type.toString();
			window.location = url;
		});	
		
		$('#calendar').data().mode = get('mode');
		$('#calendar').data().type = get('type');
		$('#calendar').data().usrs = get('usrs');
		
		
		$('.fc-button-month').live('click',function(){
			$('#calendar').data().mode = 'mois';
		});
		
		$('.fc-button-agendaWeek').live('click',function(){
				$('#calendar').data().mode = 'semaine';
		});
		
		$('.fc-button-agendaDay').live('click',function(){
				$('#calendar').data().mode = 'jour';
		});
		
		$('.linktache').live('click',function(e){
			e.preventDefault();
			if($('#calendar').data().mode == undefined ) {
					$('#calendar').data().mode = 'mois';
			}
			
			var dateCalendar = $('#calendar').data().fullCalendar.formatDate($('#calendar').data().fullCalendar.getDate(),'dd/MMM/yyyy');
			window.location.href = $(this).attr('href')+'&mode='+$('#calendar').data().mode+'&type='+$('#calendar').data().type+'&usrs='+$('#calendar').data().usrs+'&date='+dateCalendar;
		});
		
});