"use strict"

Date.prototype.getDaysInMonth =
  function(utc) {
    var m = utc ? this.getUTCMonth() : this.getMonth()+1;
	var y = utc ? this.getUTCYear() : this.getYear();
	var d = new Date(y, m, 0);
    return d.getDate();
  };
  
 Date.prototype.addDays = function(days)
 {
     var dat = new Date(this.valueOf())
     dat.setDate(dat.getDate() + parseInt(days));
     return dat;
 }
 
  Date.prototype.addMonths = function(Months)
 {
     var dat = new Date(this.valueOf())
     dat.setMonth(dat.getMonth() + parseInt(Months));
     return dat;
 }
 
  Date.prototype.delDays = function(days)
 {
     var dat = new Date(this.valueOf())
     dat.setDate(dat.getDate() + days);
     return dat;
 }
  /*----------------------------------------------------------------------------------*/
  
	var OneDayTime = 86400000;
  
  	function CalculDaysDiff(date1,date2) {
		var Diff = (new Date(date2).getTime()-new Date(date1).getTime())/OneDayTime;
		return Diff;
	}
	
  
  	function ConverTDateFr_to_En(date) {
		var Date =  new Date(date.split('/')[1]+'/'+date.split('/')[0]+'/'+date.split('/')[2]);
		return Date;
	}
	
  	function ConverTDateEn_to_Fr(date) {
		var x = new Date(date);
		var _Date = x.getDate()+'/'+x.getMonth()+'/'+x.getFullYear();
		return _Date;
	}
	
	function DateDiff (t1,t2) {

			var one_day=1000*60*60*24; 

			var x=t1.split("/");     
			var y=t2.split("/");

			var date1=new Date(x[2],(x[1]-1),x[0]);
	  
			var date2=new Date(y[2],(y[1]-1),y[0])
			var month1=x[1]-1;
			var month2=y[1]-1;
				   
			var _Diff=Math.ceil((date2.getTime()-date1.getTime())/(one_day)); 

			return _Diff;
	}
	
	function DateValid(dateInvalid){
		var dV = dateInvalid.split('/')[0];
		var mV = dateInvalid.split('/')[1];
		var yV = dateInvalid.split('/')[2];

		return mV+'/'+dV+'/'+yV;
	}
	
	function DateAddZero(date){
		var dZ = date.split('/')[0];
		var mZ = date.split('/')[1];
		var yZ= date.split('/')[2];
		
		// date francais
		return ('0'+dZ).slice(-2)+'/'+('0'+mZ).slice(-2)+'/'+yZ;
	}
	
	var dayNames =  ['Dimanche','Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi'];
	var monthNames =  ['Janvier', 'Février', 'Mars', 'Avril', 'mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
	// var monthNames =  ['','Janvier', 'Février', 'Mars', 'Avril', 'mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'];
	var monthNamesAbr =  ['','Jan','Fév','Mar','Avr','Mai','Jun','Jul','Aoû','Sep','Oct','Nov','Déc'];
	
	
   /*----------------------------------------------------------------------------------*/
   var conges,fetes;
   
	$(function(){

		var collab_dossier = {};
		
		function CalculDateEnd (DateStart,Scal) {
			var DateEnd;
			switch(Scal) {
				case 'Week':
				  DateEnd = new Date((new Date(DateStart)).setDate((new Date(DateStart)).getDate()+7));
				  break;
				case 'Month':
				  DateEnd = new Date((new Date(DateStart)).setMonth((new Date(DateStart)).getMonth()+1));
				  break;
				case 'Term':
				  DateEnd = new Date((new Date(DateStart)).setMonth((new Date(DateStart)).getMonth()+3));
				  break;
				case 'Year':
				  DateEnd = new Date((new Date(DateStart)).setFullYear((new Date(DateStart)).getFullYear()+1));
				  break;
				case '5Year':
				  DateEnd = new Date((new Date(DateStart)).setFullYear((new Date(DateStart)).getFullYear()+5));
				  break;
				default:
				  DateEnd = new Date((new Date(DateStart)).setMonth((new Date(DateStart)).getMonth()+1));
			}
			DateEnd = new Date((new Date(DateEnd)).setDate((DateEnd).getDate()-1));
			return {'DateEnd' : DateEnd};
		}
		
		function CalculDateScal (DateStart,Scal) {
			var DateEnd;
			switch(Scal) {
				case 'Week':
				  DateEnd = new Date((new Date(DateStart)).setDate((new Date(DateStart)).getDate()+7));
				  DateStart = new Date((new Date(DateStart)).setDate((new Date(DateStart)).getDate()-7));
				  break;
				case 'Month':
				  DateEnd = new Date((new Date(DateStart)).setMonth((new Date(DateStart)).getMonth()+1));
				  DateStart = new Date((new Date(DateStart)).setMonth((new Date(DateStart)).getMonth()-1));
				  break;
				case 'Term':
				  DateEnd = new Date((new Date(DateStart)).setMonth((new Date(DateStart)).getMonth()+3));
				  DateStart = new Date((new Date(DateStart)).setMonth((new Date(DateStart)).getMonth()-3));
				  break;
				case 'Year':
				  DateEnd = new Date((new Date(DateStart)).setFullYear((new Date(DateStart)).getFullYear()+1));
				  DateStart = new Date((new Date(DateStart)).setFullYear((new Date(DateStart)).getFullYear()-1));
				  break;
				case '5Year':
				  DateEnd = new Date((new Date(DateStart)).setFullYear((new Date(DateStart)).getFullYear()+5));
				  DateStart = new Date((new Date(DateStart)).setFullYear((new Date(DateStart)).getFullYear()-5));
				  break;
				default:
				  DateEnd = new Date((new Date(DateStart)).setMonth((new Date(DateStart)).getMonth()+1));
				  DateStart = new Date((new Date(DateStart)).setMonth((new Date(DateStart)).getMonth()-1));
			}
			
			return {'DateEnd' : DateEnd,'DateStart' : DateStart};
		}
		
		
		$.fn.planning = function(options) {
			
			function CalculNbCase(Scal,DurationCase,DateStart) {
				var NbCase;
				var DayWidth;
				//var widthCase;

				switch(Scal) {
					case 'var':
					  // NbCase = 7; // to do
					  break;
					case 'Week':
					  NbCase = 7;
					  DayWidth = CalTableLength/NbCase;
					  break;
					case 'Month':
					  NbCase = (new Date(DateStart)).getDaysInMonth();
					  DayWidth = CalTableLength/NbCase;
					  break;
					case 'Term':
					   NbCase = 3;
					   DayWidth = CalTableLength/90;
					  break;
					case 'Year':
					  NbCase = 12;
					  DayWidth = CalTableLength/365;
					  break;
					default:
					  NbCase = 30;
					  DayWidth = CalTableLength/NbCase;
				}
				//console.log('DayWidth : '+ DayWidth);
				//Calculer le width de la case
				var widthCase = Math.floor(CalTableLength/NbCase);
				DayWidth = Math.floor(DayWidth);
				
				return {'NbCase' : NbCase,'DayWidth' : DayWidth,'widthCase':widthCase};
			}
		
			function CalCreerHeader () {
				var html = '';
				if(Calmode == 'taches' ){
					html  +='<a data-scal="Term" class="previous prev-term btn" title="Previous Term" href="#"><i class="icon-arrow-left"></i></a>';
					html  +='<a data-scal="Month" class="previous prev-month btn" title="Previous month" href="#"><i class="icon-arrow-left"></i></a>';
					html 	+='<a data-scal="Week" class="previous prev-week btn" title="Previous week" href="#"><i class="icon-arrow-left"></i></a>';
					html 	+='<a data-scal="Year" class="previous prev-year btn" title="Previous year" href="#"><i class="icon-arrow-left"></i></a>';
					html	+='<a data-scal="Week" class="current week btn" href="#">Semain</a>';
					html	+='<a data-scal="Month" class="current month btn" href="#">Mois</a>';
					html	+='<a data-scal="Term" class="current term btn" href="#">Term</a>';
					html	+='<a data-scal="Year" class="current year btn" href="#">Année</a>';
					html	+='<a data-scal="Term" class="next next-term btn" title="Next term" href="#"><i class="icon-arrow-right"></i></a>';
					html	+='<a data-scal="Month" class="next next-month btn" title="Next month" href="#"><i class="icon-arrow-right"></i></a>';
					html	+='<a data-scal="Week" class="next next-week btn" title="Next week" href="#"><i class="icon-arrow-right"></i></a>';
					html	+='<a data-scal="Year" class="next next-year btn" title="Next year" href="#"><i class="icon-arrow-right"></i></a>';
					html	+='<div class="title">'+CalDateStart.toDateString()+' - '+CalDateEnd.toDateString()+'</div>';
					// html	+='<div class="planning-taches"><table id="planning-grille"><tr><th class="hide"></th>';	
				}
				html	+='<div class="planning-'+Calmode+'"><table id="planning-grille"><tr><th class="hide"></th>';	
				var CaseLength = Math.floor(CalTableLength/CalNbCase);
				
				for(var h=0;h<CalNbCase;h++){	
					var DateCase = CalDateStart;
					switch(CalScal) {
						case 'Var':
							// to do
							// CaseLength 		=  (Math.floor(CalTableLength/((CalDateEnd.getTime()-CalDateStart.getTime())/OneDayTime)))*DateCase.getDaysInMonth();     
							break;
						case 'Week':
							DateCase 			= DateCase.addDays(h);
							var NmCase 			= DateCase.getDate();
							var CaseLabel 		= dayNames[DateCase.getDay()]+' '+NmCase;
							break;
						case 'Month':
							DateCase 			= DateCase.addDays(h);
							var NmCase 			= DateCase.getDate();
							var CaseLabel 		= NmCase;
						  break;
						case 'Term':
							DateCase 			= DateCase.addMonths(h);
							var NmCase 			= DateCase.getMonth()+1;
							var CaseLabel 		= monthNames[DateCase.getMonth()];
							// var CaseLength 		=  (Math.floor(CalTableLength/90))*DateCase.getDaysInMonth();
							CaseLength 			=  (Math.floor(CalTableLength/((CalDateEnd.getTime()-CalDateStart.getTime())/OneDayTime)))*DateCase.getDaysInMonth();     
						  break;
						case 'Year':
							DateCase 				= DateCase.addMonths(h);
							var NmCase 			= DateCase.getMonth()+1;
							var CaseLabel		= monthNames[DateCase.getMonth()];
							CaseLength 			= (Math.floor(CalTableLength/365))*DateCase.getDaysInMonth();
							// CaseLength 		=  (Math.floor(CalTableLength/((CalDateEnd.getTime()-CalDateStart.getTime())/OneDayTime)))*DateCase.getDaysInMonth();     
						  break;
						case '5Year':
						  break;
						  default:
							DateCase = DateCase.addDays(h);
							var NmCase = DateCase.getDate();
							var CaseLabel = NmCase;
					}
					
					
					// Les week-ends ==> ( ça marche pas encore dans le mode "année")
					var monthDateStart = new Date(CalDateStart).getMonth() + 1;
					var monthDateEnd = new Date(CalDateEnd).getMonth() + 1;
					var currentMonth;

					(monthDateStart != monthDateEnd) ? currentMonth = monthDateEnd : currentMonth = monthDateStart;
					
					// console.log(currentMonth);
					// console.log('NmCase : '+NmCase);
					var currentYear 	  = new Date(CalDateStart).getFullYear(); // l'année actuelle
					var currentDate = new Date(currentMonth+'/'+(NmCase)+'/'+currentYear); // la date de chaque case
					var dayIndex = currentDate.getDay(); // compris entre 0 et 6
					var isWeekEnd = '';
					
					
					if(dayIndex%6 == 0 && (CalScal=='Week' || CalScal=='Month')){ // Pour trouvez les jours de week-ends 
						isWeekEnd = 'week-end'; // la classe à ajouter au cases qui representent un jour de week-end	
					}
					
					html+='<th style="width:'+CaseLength+'px;" class="'+CalDurationCase+NmCase+' '+isWeekEnd+'">'+CaseLabel+'</th>'
				}
				
				// CalTableLength
				html+='</tr>';				
				return html;
			}
			
			function CalCreerBody() {
				var html = '';
				//table body grid width collabs	
				var collabs_uids =[];
				for(var uid_collab in collabs) {
					
					if(uid_collab !== 'date') {
						var emptyCollab = false;
						var collabExist = false;
						
						for(var uid_tache in collabs[uid_collab]) {
							if(uid_tache !== undefined && uid_tache != null) {
								var name_collab =  $('.'+uid_collab+':first').text(); //uid_collab+' '+
								
								var TachDateStartTime  		= new Date(DateValid(collabs[uid_collab][uid_tache].start)).getTime();
								var TachDateEndTime 			= new Date(DateValid(collabs[uid_collab][uid_tache].end)).getTime();
								var CalDateStartTime 			= CalDateStart.getTime();
								var CalDateEndTime 			= CalDateEnd.getTime();

								
									if(!((TachDateStartTime>CalDateEndTime) || (TachDateEndTime<CalDateStartTime))){
										
										if(Calmode == 'collabs') {
											
											if($.inArray(uid_collab,collabs_uids) !== -1) {
												collabExist = true;
											}
											collabs_uids.push(uid_collab);
											//console.log(collabExist);
										}
											
										if(!collabExist){
								
											html+='<tr data-uidcollab="'+uid_collab+'" class="'+uid_collab+' '+uid_tache+'"><td class="hide collab">'+name_collab+'</td>';
										
											for(var h=0;h<CalNbCase;h++){											
												
												html+='<td class="Case'+h+'"></td>'
											}
											html+='</tr>';
											emptyCollab = true;
										}
									}
								
								

							}
						}
						
						// if(!emptyCollab){
							// var name_collab =  $('.'+uid_collab+':first').text(); //uid_collab+' '+
							// html+='<tr class="'+uid_collab+'"><td class="hide collab">'+name_collab+'</td>';
								// for(var ij=0;ij<CalNbCase;ij++){
									// html+='<td class="Case'+ij+'"></td>'
								// }
								// html+='</tr>';
						// }
					}
				}
				return html;
			}
			
			
		
		    // Create defaults, extending them with any options that were provided
			var settings = $.extend( {
			  'collabs'         : {},
			  'widthGrid' : 32,
			  'heightGrid' : 28,
		  	  'scallWidthTache' : 0,
			  'scallHeightTache' : 1,
			  'weekends' : [],
			  'CalDateStart' : new Date('01/01/2013'),
			  'CalScal' : 'Month',
			  'CalDurationCase' : 'Month',
			  'CalDragDuration' : 'Month',
			  //'CalDayWidth' : 40,
			  'CalTableLength' : 1200,
			  'TableWidth' : 1192,
			  'DatePlanning':false,
			  'Calmode':'taches'
			}, options);
			
			var collabs 		= settings.collabs;

			//if(settings.DatePlanning == true) {return settings.CalDateStart; return false;}
			if (collabs == null ){ return false;}
			
			var CalScal 				= settings.CalScal;
			var CalDateStart 			= settings.CalDateStart;
			var CalDateEnd 			= CalculDateEnd(CalDateStart,CalScal).DateEnd;
			var CalDurationCase  	= settings.CalDurationCase;
			var CalTableLength  	= settings.CalTableLength;
			//var CalDayWidth  		= CalculNbCase(CalScal,CalDurationCase,CalDateStart).DayWidth;
			var CalNbCase 			= CalculNbCase(CalScal,CalDurationCase,CalDateStart).NbCase;
			var CalwidthCase			= CalculNbCase(CalScal,CalDurationCase,CalDateStart).widthCase;
			
			var CalDaysDiff			= CalculDaysDiff(CalDateStart,CalDateEnd);
			var CalDayWidth  		= Math.floor(CalTableLength/CalDaysDiff);
			var Calmode  				= settings.Calmode;
			
			//var OneDayTime 		= 86400000;
			
			var weekends 			= settings.weekends;
			var widthG 				= settings.widthGrid;
			var heightG 				= settings.heightGrid;
			var scallW 				= settings.scallWidthTache;
			var scallH 				= settings.scallHeightTache;
			var TableW 				= settings.TableWidth;
			

			
			var dossier ;
			var collabHTML 	= [];
			var warp;
			var tachesHTML 	= '';
			var nbTaches 		= 0;
						
			var CurDay ;
			var CurMonth ;
			var CurYear;
			var CurDate = new Date();
			
			var CalDateStart = new Date(settings.CalDateStart);
			// var CalDayStart = CalDateStart.getDate();
			// var CalMonthStart = CalDateStart.getMonth()+1;
			// var CalYearStart = CalDateStart.getFullYear();

			
			var CalNbDays = new Date(CalDateStart.getFullYear(),CalDateStart.getMonth()+1).getDaysInMonth();  // Format  => Year,Month,Day or  Year/Month/Day 
			
			// var CalDateEnd_ = new Date(settings.CalDateStart); CalDateEnd_.setDate(CalNbDays);
			// var CalDayEnd = CalDateEnd_.getDate();
			// var CalMonthEnd = CalDateEnd_.getMonth()+1;
			// var CalYearEnd = CalDateEnd_.getFullYear();
			
			// var CurrMYStart = new Date(CalMonthStart+'/01/'+CalYearStart).getTime();
			// var CurrMYEnd = new Date(CalMonthStart+'/'+CalNbDays+'/'+CalYearStart).getTime();
			
		
			//Set Hours / Minutes / Seconds /  Milliseconds  to 0 of the Call Date

			//CalNbDays = new Date(CalDateStart.getFullYear(),CalDateStart.getMonth()+1).getDaysInMonth(); 
			//CalNbDays = new Date(2011,2).getDaysInMonth();  
			

			//today_format = CalMonthStart+'/'+CalYearStart;
			var dossier = $(this).attr('id').split('_')[1];
			var uid_dossier = $(this).attr('id');
			
			//loading
			//$(this).prev().children().last().css('display','inline');
			
			// stock data
			collab_dossier[uid_dossier] = collabs;
			collab_dossier[uid_dossier].date = CalDateStart;
			
			function DateStartEnd(widthTache,leftTache){
				var tache_start,tache_end;
				if(leftTache>0 & leftTache <= CalNbDays){
					
					tache_start = leftTache+'/'+CalMonthStart+'/'+CalYearStart;
					tache_start = DateAddZero(tache_start);
				}else{
					
					tache_start = 1+'/'+CalMonthStart+'/'+CalYearStart;
					tache_start = new Date (DateValid(tache_start));
					tache_start = tache_start.delDays(leftTache-1);
										
					tache_start = tache_start.getDate()+'/'+(tache_start.getMonth()+1)+'/'+tache_start.getFullYear();
					tache_start = DateAddZero(tache_start);
				}
					tache_end = new Date (DateValid(tache_start));
					tache_end = tache_end.addDays(widthTache-1);	
					tache_end = tache_end.getDate()+'/'+(tache_end.getMonth()+1)+'/'+tache_end.getFullYear();
					tache_end = DateAddZero(tache_end);
					
					return {start:tache_start ,end:tache_end};
			}
			
			function adapteLines(dossier){
				$('#pl_'+dossier+' tr').not(':first').each(function(){
					var class_name = $(this).attr('class').split(' ')[0];
					var class_length = $('#pl_'+dossier+' tr.'+class_name).length;
					if(class_length >1 & $(this).attr('class').split(' ')[1] == undefined ){
						$(this).remove();
					}
					if(class_length = 1 & $(this).attr('class').split(' ')[1] == undefined ){
						var name_collab =  $('.'+$(this).attr('class').split(' ')[0]+':first').text();
						$(this).find('.collab').text(name_collab);
					}
					
					if(class_length = 1 & $(this).attr('class').split(' ')[1] != undefined ){
						var name_collab = $('.'+$(this).attr('class').split(' ')[0]+':first').text();
						var uid_tache = $(this).attr('class').split(' ')[1];
						//var temps_calcule = $('#'+class_name+'-'+uid_tache).data().temps_calcule;
						var jours_prevus = $('#'+class_name+'-'+uid_tache).data().nb; //$('#'+class_name+'-'+uid_tache).data().jours_prevus;
						var jours_passe =1; //parseFloat($('#'+class_name+'-'+uid_tache).data().jours_passe);
						//var class_label = (jours_passe == 0) ? 'label-success': ''; 
						
						switch(true) {
							case jours_passe>jours_prevus:
							  var class_label = 'label-important';
							  break;
							case jours_passe==jours_prevus:
							  var class_label = 'label-info';
							  break;
							case jours_passe>0:
							  var class_label = 'label-success';
							  break;
							default:
							  var class_label = '';
						}

						$(this).find('.collab').html('<span class="label '+class_label+' label-collab">'+jours_passe+' / '+jours_prevus+'</span> '+name_collab);
						//console.log(temps_calcule);
						//console.log($('#'+class_name+'-'+uid_tache).data());
					}
				});
				$('#pl_'+dossier+'_'+Calmode+' tr').not(':first').each(function(i){
					$('#pl_'+dossier+'_'+Calmode+' #'+$(this).attr('class').replace(' ','-')).css('top',((i+1)*heightG)+scallH);
				});
			}
			
			// function adapteDeadlines(dossier) {
				// $('#pl_'+dossier+' tr td .deadline').remove();
				
				// $('#pl_'+dossier+' .taches .tache').each(function(){
					
					// if($(this).data().deadline != undefined) {
						// var Deadline = new Date(DateValid($(this).data().deadline));
						// var DayDeadline = Deadline.getDate();
						
						// Deadline.setHours(0);
						// Deadline.setMinutes(0);
						// Deadline.setSeconds(0);
						// Deadline = Deadline.setMilliseconds(0);
						
						// if(Deadline >= CurrMYStart & Deadline <= CurrMYEnd) {
							// var class_collab_tache = $(this).attr('id').replace('-t','.t');
							// $('#pl_'+dossier+' tr.'+class_collab_tache+' .day'+DayDeadline).append('<div class="deadline">___</div>');
						// }
					// }
				// });
			// }
			

			
			//table head
			//-------------------------------------------------------------------------------
			// var link_to_months='';
			// var left_month = 0;
			
			// for(var m=1;m<=12;m++) {
				// if(m>1) {
					// left_month+= 35;
				// }
				// var class_active = (CalMonthEnd==m) ? 'active':'';
				// link_to_months+='<a class="month btn '+class_active+'" href="#" style="left:'+left_month+'px">'+monthNamesAbr[m]+'</a>';
			// }
			warp='<div id="pl_'+dossier+'_'+Calmode+'" class="pl pl-'+Calmode+'">';
			
			warp+= CalCreerHeader();
			warp+= CalCreerBody();
			warp+='</table></div></div>';
			//-------------------------------------------------------------------------------
			
			
			
			$('#planning-wrapper').append(warp); 
			
			// add class hide if it's the first time to load the planning
			var class_hide = ($('#pl_'+dossier).next('.external_tache').hasClass('hide')) ? 'hide':'';
			$('#pl_'+dossier).addClass(class_hide);
						
			// set the title and the year of the calendar
			// $('#pl_'+dossier+' .title').text(monthNames[CalMonthStart]+' '+CalYearStart);
						
			// set width to the td ,th of the collabs
			$('#pl_'+dossier+' th:first').css('width',TableW-(widthG*CalNbDays));
			$('#pl_'+dossier+' td.collab').css('width',TableW-(widthG*CalNbDays)-5);
			
			
			//color CalDateStart
			// var CurrDay = new Date (CalDateStart).getDate();
			// var CalMonthYear = new Date (CalYearStart+'/'+CalMonthStart+'/01 00:00:00').getTime();
			// var CurrMonthYear = new Date();
			// CurrMonthYear.setDate(1);
			// CurrMonthYear.setHours(0);
			// CurrMonthYear.setMinutes(0);
			// CurrMonthYear.setSeconds(0);
			// CurrMonthYear.setMilliseconds(0);
			// CurrMonthYear = CurrMonthYear.getTime();
			
			// if(CalMonthYear == CurrMonthYear){
				// $('#pl_'+dossier+' .day'+CurrDay).addClass('CalDateStart');
			// }
			
			//color weekends 
			// if(weekends.length <1){
				// for(var p=1;p<=CalNbDays;p++){
					// var CellDate = new Date(DateValid(p+'/'+CalMonthStart+'/'+CalYearStart));
					// if(CellDate.getDay() ==6 | CellDate.getDay() ==0){
						// $('#pl_'+dossier+' .day'+p).addClass('weekend');
						////weekends.push(p);
					// }
				// }
			// }

			
			// creat tasks		
			tachesHTML='<div class="taches">';
											
			for(var uid_collab in collabs) {
				if(uid_collab != 'date') {
		
					for(var uid_tache in collabs[uid_collab]) {
						
						if(uid_tache != undefined ) {
							
							var TachDateDeadLineTime 	= new Date(DateValid(collabs[uid_collab][uid_tache].deadline)).getTime();
							var TachDateStartTime  		= new Date(DateValid(collabs[uid_collab][uid_tache].start)).getTime();
							var TachDateEndTime 			= new Date(DateValid(collabs[uid_collab][uid_tache].end)).getTime();
							var CalDateStartTime 			= CalDateStart.getTime();
							var CalDateEndTime 			= CalDateEnd.getTime();

							
							if(!((TachDateStartTime>CalDateEndTime) || (TachDateEndTime<CalDateStartTime))){
				
								var nb = DateDiff(collabs[uid_collab][uid_tache].start,collabs[uid_collab][uid_tache].end)+1;
								// var nb = (CalDateEnd.getTime()-CalDateStart.getTime())/OneDayTime)+1;
									
								switch(CalScal) {
									case 'Var':
										// var OneCaseTime = OneDayTime*((CalDateEnd.getTime()-CalDateStart.getTime())/OneDayTime);
										// var OneDayWidth = Math.floor(CalTableLength/((CalDateEnd.getTime()-CalDateStart.getTime())/OneDayTime));
										break;
									case 'Week':
										var OneCaseTime = OneDayTime;
										var OneDayWidth = CalwidthCase;
										break;
									case 'Month':
										var OneCaseTime = OneDayTime;
										var OneDayWidth = CalwidthCase;
									  break;
									case 'Term':
										var OneCaseTime = OneDayTime*(new Date(TachDateStartTime).getDaysInMonth());
										var OneDayWidth = Math.floor(CalTableLength/((CalDateEnd.getTime()-CalDateStart.getTime())/OneDayTime));
									  break;
									case 'Year':
										var OneCaseTime = OneDayTime*(new Date(TachDateStartTime).getDaysInMonth());
										var OneDayWidth = Math.floor(CalTableLength/365);
									  break;
									case '5Year':
										var OneCaseTime = 5*OneDayTime*(new Date(TachDateStartTime).getDaysInMonth());
										// to do var OneDayWidth = Math.floor()
										break;
									  default:
										var OneCaseTime = OneDayTime;
								}
						
								var diff_days 						= Math.floor((TachDateStartTime-CalDateStartTime)/OneDayTime)+1;
								var nb_case_left 				= Math.floor((TachDateStartTime-CalDateStartTime)/OneCaseTime)+1;
								var nb_case_width 			= Math.floor((TachDateEndTime-TachDateStartTime)/OneCaseTime);
								
								var diff_days_deadline		= Math.floor((TachDateDeadLineTime-TachDateStartTime)/OneDayTime);
								var nb_case_deadline_left	= Math.floor((TachDateDeadLineTime-TachDateStartTime)/OneCaseTime);
								
								var left = (diff_days*OneDayWidth)+nb_case_left;
								var width = (nb*CalDayWidth)+nb_case_width;
								
								var leftdeadline = (diff_days_deadline*OneDayWidth)+nb_case_deadline_left;
								
								var name_collab =$('#'+uid_dossier+' .'+uid_collab).text();

								if( Calmode == 'taches'){
									// temps
									var tempsHTML='';
									var tempsTotalHour = 0;
									for(var uid_temp in collabs[uid_collab][uid_tache].temps) {

										if(uid_temp  != undefined ) {
		
											var TempDateTime 				= new Date(DateValid(collabs[uid_collab][uid_tache].temps[uid_temp].date)).getTime();
											var TempNbHourTime 			= collabs[uid_collab][uid_tache].temps[uid_temp].nbh;
											
											var diff_days_temp					= Math.floor((TempDateTime-TachDateStartTime)/OneDayTime);
											var nb_case_temp_left	 		= Math.floor((TempDateTime-TachDateStartTime)/OneCaseTime);
											var lefttemp	 						= (diff_days_temp*OneDayWidth)+nb_case_temp_left;
											
											var tempIsOut='';
											if(TempDateTime-TachDateDeadLineTime>0) {
												tempIsOut = 'temp-out';
												//console.log(TempDateTime-TachDateDeadLineTime>0);
											}
											
											tempsHTML+='<div style="left:'+lefttemp+'px;width:'+CalDayWidth+'px;" class="temp '+tempIsOut+'" data-nbh="'+TempNbHourTime+'"></div>';
											tempsTotalHour = tempsTotalHour+parseInt(TempNbHourTime);
										}
									}
									var tempsTotalDays = tempsTotalHour/8;
								


									tachesHTML+='<a href="modif_todo?todo='+uid_tache.split('t_')[1]+'" data-uidcollab="'+uid_collab+'" target="_blank">';
									tachesHTML+='<div data-deadline="'+TachDateDeadLineTime+'" data-start="'+TachDateStartTime+'" data-end="'+TachDateEndTime+'" data-nb="'+nb+'" data-nbj="'+tempsTotalDays+'" data-nbh="'+tempsTotalHour+'"';
									tachesHTML+=' class="tache" id="'+uid_collab+'-'+uid_tache+'" style="left:'+left+'px;width:'+width+'px">';
									tachesHTML+='<span class="tache-title">[<span class="name-collab">'+name_collab+'</span>][<span class="temps-passe">'+tempsTotalDays+'</span>-<span class="temps-prevu">'+nb+'</span>] <span class="title-task">'+collabs[uid_collab][uid_tache].title+'</span></span>';
										
									// deadline
									tachesHTML+='<div style="left:'+leftdeadline+'px;width:'+CalDayWidth+'px;" class="deadline"></div>';	
									tachesHTML+=tempsHTML+'</div></a>';									
								}else{
									var topTR = ($('.planning-collabs table tr.'+uid_collab).index()*heightG)+scallH;
									tachesHTML+='<div class="tache collab-temp" data-id="'+uid_collab+'-'+uid_tache+'" id="'+uid_collab+'-'+uid_tache+'" style="top:'+topTR+'px;left:'+left+'px;width:'+width+'px"></div>';
								}
								
								
								
								
								
								
								// the deadline
								// var Deadline = new Date(DateValid(collabs[uid_collab][uid_tache].deadline));							
								// Deadline.setHours(0);
								// Deadline.setMinutes(0);
								// Deadline.setSeconds(0);
								// Deadline = Deadline.setMilliseconds(0);

								
								// creat times
								// var Tache_Times = [];
								// for(var uid_temp in collabs[uid_collab][uid_tache].temps) {

									// if(uid_temp  != undefined ) {
										
										// var time = new Date(DateValid(collab_dossier[uid_dossier][uid_collab][uid_tache].temps[uid_temp].date)).getTime();
										// Tache_Times.push(time);
									
										// var DateMY = new Date(DateValid(collabs[uid_collab][uid_tache].temps[uid_temp].date));
										// var DayTemp = DateMY.getDate();
										
										// DateMY.setHours(0);
										// DateMY.setMinutes(0);
										// DateMY.setSeconds(0);
										// DateMY = DateMY.setMilliseconds(0);
										
										// if(DateMY >= CurrMYStart & DateMY <= CurrMYEnd) {
											// var LigneTr = $('#pl_'+dossier+' tr.'+uid_tache+'.'+uid_collab);
											// if(!LigneTr.find('td.day'+DayTemp+' div').hasClass('temp')) {
											
												// LigneTr.find('td.day'+DayTemp).append('<div class="temp"></div>');

												// if(DateMY > Deadline & collabs[uid_collab][uid_tache].deadline != '00/00/00'){  
												
													// LigneTr.find('td.day'+DayTemp+' .temp').addClass('more');
												// }

											// }
										// }
									// }
								// }
								

							}
							// here ->
						}
					}
				}
			}
			
			tachesHTML+='</div>';
			//console.log(tachesHTML);	
			$('#pl_'+dossier+'_'+Calmode+' .planning-'+Calmode).append(tachesHTML);
			$('.planning-collabs table tr[class!=""]').each(function(){
				var $this 		= 	$(this);
				var topTR 		= 	($this.index()*27)+$this.index()+4;
				var uidCollab	=	$this.data('uidcollab');
				var tempsPasse	= 	0;
				var tempsPrevu	=	0;
				$('.planning-taches .taches a[data-uidcollab="'+uidCollab+'"]').each(function(){
					tempsPasse 	+=	Number($('.temps-passe',$(this)).text());
					tempsPrevu 	+=	Number($('.temps-prevu',$(this)).text());
				});
				
				//setTimeout(function(){
					//console.log(tempsPasse);
					$('#pl_'+dossier+'_'+Calmode+' .planning-collabs').append('<div data-uidcollab="'+uidCollab+'" class="collab-name" style="top:'+topTR+'px;"><span class="collaborateur">'+$(this).find('td.collab').text()+'</span> [ '+tempsPasse+' - '+tempsPrevu+' ]</div>')
				//},150);
				
			});
			//$('#planning-wrapper').append(tachesHTML);
			
			// attache the value of deadline to every tache		
			// for(var uid_collab in collabs) {
				// if(uid_collab != 'date') {	
					// for(var uid_tache in collabs[uid_collab]) {
						
						// if(uid_tache != undefined ) {
						
							// var id_tache = uid_collab+'-'+uid_tache;

							// if(collabs[uid_collab][uid_tache].deadline != '00/00/00' & $('#pl_'+dossier+' .taches #'+id_tache).length != 0) {
							
								// var Deadline = collabs[uid_collab][uid_tache].deadline;
								
								// $('#pl_'+dossier+' .taches #'+id_tache).data({'deadline':Deadline});
								////console.log(Deadline);
								////console.log($('#pl_'+dossier+' .taches #'+id_tache));

							// }
							
							// var temps_passe_heur = 0; //initialisation des heures
							// var temps_passe_min = 0; //initialisation des minutes
							// var jours_prevus = DateDiff(collabs[uid_collab][uid_tache].start,collabs[uid_collab][uid_tache].end)+1;
							
							// for(var uid_temp in collabs[uid_collab][uid_tache].temps) {

								// if(uid_temp  != undefined ) {
									////recupération des heures
									// temps_passe_heur+= parseInt(collabs[uid_collab][uid_tache].temps[uid_temp].nbh.split(":")[0],10);
									////recupération des minutes
									// temps_passe_min+= parseInt(collabs[uid_collab][uid_tache].temps[uid_temp].nbh.split(":")[1],10);
								// }
							// }
							
							// if((temps_passe_min/60)>=1){
								// temps_passe_heur+= temps_passe_min/60;
							// }
						
							// var jours_passe = parseFloat((temps_passe_heur/8).toFixed(1));
							// if(parseInt(jours_passe) == jours_passe) {jours_passe = parseInt(jours_passe);} 

							// $('#pl_'+dossier+' .taches #'+uid_collab+'-'+uid_tache).data({'jours_passe':jours_passe,'jours_prevus':jours_prevus});
						// }
					// }
				// }
			// }
			
			// creat the deadline
			////adapteDeadlines(dossier);
	
			// set width to the task holder
			// $('#pl_'+dossier+' .taches').css('width',(widthG*CalNbDays)+1);
			$('#pl_'+dossier+'_'+Calmode+' .taches').css('width',(CalwidthCase*CalNbCase)+(CalNbCase+1));

			// set left to the task holder
			// $('#pl_'+dossier+' .taches').css('left',(1193-(widthG*CalNbDays))+'px'); //1192+1
			$('#pl_'+dossier+'_'+Calmode+' .taches').css('left',0); //1192+1
			
			// place tasks		
			// for(var uid_collab in collabs) {
				// if(uid_collab != 'date') {	
					// for(var uid_tache in collabs[uid_collab]) {
						
						// if(uid_tache != undefined ) {
							// var TachDateStartTime  		= new Date(DateValid(collabs[uid_collab][uid_tache].start)).getTime();
							// var TachDateEndTime 			= new Date(DateValid(collabs[uid_collab][uid_tache].end)).getTime();
							// var CalDateStartTime 			= CalDateStart.getTime();
							// var CalDateEndTime 			= CalDateEnd.getTime();

							
							// if(!((TachDateStartTime>CalDateEndTime) || (TachDateEndTime<CalDateStartTime))){
							
								// var widthG = CalDayWidth;
								// if(tache_start.getTime() < CurrMY){
									// var left = (DateDiff('1/'+CalMonthStart+'/'+CalYearStart,collabs[uid_collab][uid_tache].start)*widthG)+DateDiff('1/'+CalMonthStart+'/'+CalYearStart,collabs[uid_collab][uid_tache].start);
								// }else{
									// var left = (DateDiff('1/'+CalMonthStart+'/'+CalYearStart,collabs[uid_collab][uid_tache].start)*widthG)+DateDiff('1/'+CalMonthStart+'/'+CalYearStart,collabs[uid_collab][uid_tache].start);
								// }
								
								
								
								// var OneDayTime = 86400000;
								
								// switch(CalScal) {
									// case 'Week':
										// var OneCaseTime = OneDayTime;
										// var OneDayWidth = CalwidthCase;
										// break;
									// case 'Month':
										// var OneCaseTime = OneDayTime;
										// var OneDayWidth = CalwidthCase;
									  // break;
									// case 'Term':
										// var OneCaseTime = OneDayTime*(new Date(TachDateStartTime).getDaysInMonth());
										// //to do var OneDayWidth = Math.floor()
									  // break;
									// case 'Year':
										// var OneCaseTime = OneDayTime*(new Date(TachDateStartTime).getDaysInMonth());
										// var OneDayWidth = Math.floor(CalTableLength/365);
									  // break;
									// case '5Year':
										// var OneCaseTime = 5*OneDayTime*(new Date(TachDateStartTime).getDaysInMonth());
										// //to do var OneDayWidth = Math.floor()
										// break;
									  // default:
										// var OneCaseTime = OneDayTime;
								// }
					
								// var diff_days = Math.floor((TachDateStartTime-CalDateStartTime)/OneDayTime)+1;
								// var nb_case = Math.floor((TachDateStartTime-CalDateStartTime)/OneCaseTime);
								
								
								// console.log('OneDayWidth '+OneDayWidth)
								// console.log('nb_case '+nb_case)
								// console.log('diff_days '+diff_days)
								// left = (diff_days*OneDayWidth)+nb_case;

								
								// $('#'+uid_collab+'-'+uid_tache).css({'left':left});
							// }
						// }
					// }
				// }
			// }

			adapteLines(dossier);
			
			// conges
			// for(var uid_conge in conges){

					// var startMonth = new Date(DateValid(conges[uid_conge].start)).setDate(1);
					// startMonth = new Date(startMonth).getTime();
					
					// var endMonth = new Date(DateValid(conges[uid_conge].end)).setDate(1);
					// endMonth =new Date(endMonth).getTime();
					// var CurrMY = new Date(CalMonthStart+'/01/'+CalYearStart).getTime();
										
					// if(startMonth == CurrMY | endMonth == CurrMY | (startMonth < CurrMY & endMonth > CurrMY)) {
						// if(startMonth < CurrMY) {
							// var day = 1;
							// CongeNbJr = (DateDiff('1/'+CalMonthStart+'/'+CalYearStart,conges[uid_conge].end))+1;
						// }else{
							// var day = conges[uid_conge].start.split('/')[0];
							// var CongeNbJr = (DateDiff(conges[uid_conge].start,conges[uid_conge].end))+1;
						// }
						
						// for(var i=0;i<CongeNbJr;i++){
								//$('#pl_'+dossier+' .'+conges[uid_conge].collab+' td.day'+(parseInt(day)+i)).addClass('conge');
								// $('#pl_'+dossier+' .'+conges[uid_conge].collab+' td.day'+(parseInt(day)+i)).each(function(){
									// if($(this).find('div').length>0) {
										// $(this).find('div').addClass('conge');
									// }else{
										// $(this).append('<div class="conge"></div>');
									// }
								// });	
						// }
					// }
			// }
			
			//fetes
			// for(var uid_fete in fetes){
					
					// var pays = fetes[uid_fete].pays;
					// var startMonth = new Date(DateValid(fetes[uid_fete].start)).setDate(1);
					// startMonth = new Date(startMonth).getTime();
					
					// var endMonth = new Date(DateValid(fetes[uid_fete].end)).setDate(1);
					// endMonth =new Date(endMonth).getTime();
					// var CurrMY = new Date(CalMonthStart+'/01/'+CalYearStart).getTime();
										
					// if(startMonth == CurrMY | endMonth == CurrMY | (startMonth < CurrMY & endMonth > CurrMY)) {
						// if(startMonth < CurrMY) {
							// var day = 1;
							// CongeNbJr = (DateDiff('1/'+CalMonthStart+'/'+CalYearStart,fetes[uid_fete].end))+1;
						// }else{
							// var day = fetes[uid_fete].start.split('/')[0];
							// CongeNbJr = (DateDiff(fetes[uid_fete].start,fetes[uid_fete].end))+1;
						// }
						// for(var i=0;i<CongeNbJr;i++){
								// $('#pl_'+dossier+' th.day'+(parseInt(day)+i)).addClass('fete-'+pays);
						// }
					// }
			// }
			
		
		
		// drag task
		var topCurr,topReel,topFloor,topCiel,top,lleftCurr,eft,wTache,collabReel,collabCurr,TacheReel,TacheCurr,parents,leftCurr,uid_tache,leftReel,leftFloor,leftCiel,left;
		widthG = CalDayWidth;
		$('.tache').draggable({
			grid: [CalDayWidth, 27] ,
			axis: "x",
			start: function(event, ui) {
				
			},
			create: function( event, ui ) {
				var _this = $(this);
				var _nbj = _this.data('nbj');
				if(_nbj != 0){
					_this.draggable({ disabled: true });
				}else{
					// Supprimer la tâche
					_this.hover(function(){
						_this.append('<span class="remove-task"><i class="icon-remove-circle"></i></span>');
					},function(){
						$('.remove-task').remove();
					});
				}
			},
			drag: function(event, ui) {

			},
			stop: function(event, ui) {
				var id_tache = $(this).attr('id').split('-t_')[1];
				var TacheNbDays			= $(this).width/CalDayWidth;	
				var TacheDateStartTime 	= CalDateStart.getTime()+($(this).position().left/CalDayWidth)*OneDayTime;			
				var TacheDateStart		= ConverTDateEn_to_Fr(TacheDateStartTime);
				//var url = 'http://' +document.location.host+ '/REST/set?token="'+token+'"&table="77"&UID="'+id_tache+'"&Field="1"&c30="'+nb_jours_prevu+'"&c29="'+start_tache+'"&c10="'+ids_collab+'"';
				var url = 'http://' +document.location.host+ '/REST/set?token="'+token+'"&table="77"&UID="'+id_tache+'"&Field="1"&c30="'+TacheNbDays+'"&c29="'+TacheDateStart+'"';
				
				// send ajax 
				$.ajax({
					type: "POST",
					url: url,  
					dataType: "json",
					error:function(msg){
						console.log(msg);
					},
					success:function(data){
						console.log(data);
						
					}
				});	
			}
		});		
			/*$('.tache').draggable({
				
				 start: function(event, ui) {
					topCurr = $(this).position().top;
					leftCurr = $(this).position().left;
					//topCurrS = $(this).position().top/32;
					wTache = -Math.ceil($(this).width()/widthG);
					collabCurr = $(this).attr('id').split('-t_')[0];
					uid_tache = 't_'+$(this).attr('id').split('-t_')[1];
					parents = $(this).parents('.pl');
					console.log('---');
				 },
				 
				 drag: function(event, ui) {

				 },
				 
				 stop: function(event, ui) {
					
					
					//nbTaches = $(this).parent().parent().find('a').length+1;
					nbTaches = parents.find('tr').length;  // nb lignes

					topReel =  ($(this).position().top-scallH)/heightG;
					topFloor =   Math.floor(topReel);
					topCiel =   Math.ceil(topReel);

					leftReel =  $(this).position().left/widthG;
					leftFloor =   Math.floor(leftReel);
					leftCiel =   Math.ceil(leftReel);

					left = ((leftReel<wTache+0.5) | (leftReel+0.5>CalNbDays) | (topReel<0.5) | (topReel+0.5>nbTaches)) ? leftCurr-scallH : ((leftReel+0.5)<leftCiel) ? leftFloor*widthG: leftCiel*widthG;

					top = ((topReel<0.5) | (topReel+0.5>nbTaches) | (leftReel<wTache+0.5) | (leftReel+0.5>CalNbDays)) ? topCurr-scallH : ((topReel+0.5)<topCiel) ? topFloor*heightG: topCiel*heightG;
					

					collabReel =  $(this).parents('.pl').find(' tr:eq('+((top/heightG))+')').attr('class').split(' ')[0];
					
					TacheReel =  $(this).parents('.pl').find(' tr:eq('+((top/heightG))+')').attr('class').split(' ')[1];
					TacheCurr =  't_'+$(this).attr('id').split('-t_')[1];
					
					var uid_dossier = 'd_'+$(this).parents('.pl').attr('id').split('_')[1];
									
							
					if(collabCurr == collabReel | collab_dossier[uid_dossier][collabCurr][TacheCurr].temps != undefined) {
						top =  topCurr-scallH;
					}else{
						if($('.'+collabReel).hasClass(TacheCurr) == true) {
							top =  topCurr-scallH;
						}else{
							var id = collabReel+'-'+'t_'+$(this).attr('id').split('-t_')[1];
							$(this).attr('id',id);
							//var Deadline = collab_dossier[uid_dossier][collabCurr][TacheCurr].deadline ;							
							//$('#'+id).data({'deadline':Deadline});

							// add line for the placed tache
							if($(this).parents('.pl').find('.'+collabReel).length>0){
								var trClone = parents.find(' tr:eq('+((top/heightG))+')').clone();
								parents.find('.'+collabReel+':last').after(trClone).next().removeClass().addClass(collabReel).addClass(uid_tache).find('.temp').remove();//.children().first(); //.text();
								
								if(parents.find('.'+collabCurr).length>1){
									parents.find('.'+collabCurr+'.'+uid_tache).remove();
								}else{
									parents.find('.'+collabCurr).attr('class',collabCurr);
								}
								var id_dossier = $(this).parents().find('.pl').attr('id').split('_')[1];
								adapteLines(id_dossier);
								top =  parents.find('.'+collabReel+':last').index()*heightG;
							}
						}
					}


					var CurrTache = $(this).attr('id');
					var ids_collab ='';
					var tachesL = $('tr.t_'+$(this).attr('id').split('-t_')[1]);
					var Tache_Times = [];
										
					$('tr.t_'+$(this).attr('id').split('-t_')[1]).each(function(h){

						ids_collab = ids_collab+' '+$(this).attr('class').split(' ')[0].split('_')[1];
												
						var OtherTache = $(this).attr('class').replace(' ','-');
						if(CurrTache == OtherTache) {
							var Wtop = top+scallH;
						}else{
							var Wtop = $(this).css('top');
						}
												
						$('#'+$(this).attr('class').replace(' ','-')).stop().animate({
							top: Wtop,
							left: left+scallW
						},600,'easeOutCirc',function(){
						
							var width_tache = Math.ceil(($(this).width()+scallW)/widthG);
							var left_tache = (($(this).position().left-scallW)/widthG)+1;
							var StartEnd = DateStartEnd(width_tache,left_tache);
								
							var uid_collab = $(this).attr('id').split('-t_')[0];
							var uid_tache = 't_'+$(this).attr('id').split('-t_')[1];
							var uid_dossier = 'd_'+$(this).parents('.pl').attr('id').split('_')[1];
							var _uid_dossier = uid_dossier.split('_')[1];
							
							if(collab_dossier[uid_dossier][uid_collab][uid_tache] == undefined){
								collab_dossier[uid_dossier][uid_collab][uid_tache] = {'title':collab_dossier[uid_dossier][collabCurr][TacheCurr].title ,'start':DateAddZero(StartEnd.start),'end':DateAddZero(StartEnd.end),'deadline':'00/00/00'};
								delete collab_dossier[uid_dossier][collabCurr][TacheCurr];
							}
							
							// collect the times to test for the deplaced task
							if(collab_dossier[uid_dossier][uid_collab][uid_tache].temps !=  undefined)	{
								for(var uid_time in collab_dossier[uid_dossier][uid_collab][uid_tache].temps) {
									var time = new Date(DateValid(collab_dossier[uid_dossier][uid_collab][uid_tache].temps[uid_time].date)).getTime();
									Tache_Times.push(time);
								}
							}
							
							if(h+1 == tachesL.length & (top !=  (topCurr-scallH) | left != (leftCurr-scallW))){
							
								Tache_Times.sort();
								var timeMin = Tache_Times[0];
								Tache_Times.reverse();
								var timeMax = Tache_Times[0];
								
								if((new Date(DateValid(StartEnd.start)).getTime()) > timeMin | (new Date(DateValid(StartEnd.end)).getTime()) < timeMax & timeMin != undefined) {
								
										var _uid_dossier = $(this).parents('.pl').attr('id').split('_')[1];
										$('#pl_'+_uid_dossier+' tr.'+uid_tache).each(function(){
											var id_collab = $(this).attr('class').split(' ')[0];
											//$('#pl_'+_uid_dossier+' #'+id_collab+'-'+uid_tache).css({'left':leftCurr});
											$('#pl_'+_uid_dossier+' #'+id_collab+'-'+uid_tache).animate({
												left: leftCurr
											},600,'easeOutCirc')
											// },600,'easeOutCirc',function(){adapteDeadlines(_uid_dossier) ;})
										});
										
								}else{
									// refresh the memory with the new information
									
									$('#pl_'+_uid_dossier+' tr.'+uid_tache).each(function(){
										var id_collab = $(this).attr('class').split(' ')[0];
										collab_dossier[uid_dossier][id_collab][uid_tache].start = DateAddZero(StartEnd.start);
										collab_dossier[uid_dossier][id_collab][uid_tache].end = DateAddZero(StartEnd.end);
									});
								
									
									// init the deadline if the task has been placed for other user
									//adapteDeadlines(_uid_dossier) ;
										
									
									var id_tache = $(this).attr('id').split('-t_')[1];
									var start_tache = StartEnd.start;
									var nb_jours_prevu = DateDiff(start_tache,StartEnd.end)+1;								
									var url = 'http://' +document.location.host+ '/REST/set?token="'+token+'"&table="77"&UID="'+id_tache+'"&Field="1"&c30="'+nb_jours_prevu+'"&c29="'+start_tache+'"&c10="'+ids_collab+'"';
									
									// send ajax 
									$.ajax({
										type: "POST",
										url: url,  
										dataType: "json",
										error:function(msg){
											console.log(msg);
										},
										success:function(data){
											console.log(data);
											
										}
									});	
								} 
							}
						}); 
					
					});
					
				 }
			});*/
				
			var widthTacheInit,leftTacheInit,collabInit;
			// resize tache
		
		$('.tache').resizable({ 
				handles: 'e, w' ,
				grid: [CalDayWidth, 27] ,
				start: function(event, ui) {
					widthTacheInit = $(this).width();
					leftTacheInit = $(this).position().left;
				},				
				stop: function(event, ui) {
					var uid_tache 					= $(this).data().uidtache;
					// var uid_collab 				= $(this).data().uidcollab;
					var TacheNbDays				= $(this).width/CalDayWidth;	
					var TacheDateStartTime 	= CalDateStart.getTime()+($(this).position().left/CalDayWidth)*OneDayTime;
					// var TacheDateEndTime 	=  TacheDateStart+(nb_jours_prevu*OneDayTime);
					
					var TacheDateStart			= ConverTDateEn_to_Fr(TacheDateStartTime);
					var leftTacheLast  	= 	$(this).position().left;
					var widthTacheLast 	= 	$(this).width();
					
					var url = 'http://' +document.location.host+ '/REST/set?token="'+token+'"&table="77"&UID="'+uid_tache+'"&Field="1"&c30="'+TacheNbDays+'"&c29="'+TacheDateStart+'"';
					
					var _nbj = $(this).data('nbj');
					
					if((leftTacheInit != leftTacheLast) && _nbj != 0){
						$(this).css({
							'left' : leftTacheInit,
							'width' : widthTacheInit
						});
					}else{
						//send ajax 
						$.ajax({
							type: "POST",
							url: url,  
							dataType: "json",
							error:function(msg){
								console.log(msg);
							},
							success:function(data){
								console.log(data);
							}
						});
					}
					
				}
				
		});
			// $('.tache').resizable({ 
				// handles: 'e, w' ,
				// grid: [widthG, 32] ,
				// start: function(event, ui) {
					// widthTacheInit = $(this).width();
					// leftTacheInit = $(this).position().left;
					// collabInit = $(this).attr('id').split('-t')[0];
				// },				
				// stop: function(event, ui) {
					// var width_tache = Math.ceil(($(this).width()+scallW)/widthG);
					// var left_tache = (($(this).position().left-scallW)/widthG)+1;
					// var StartEnd = DateStartEnd(width_tache,left_tache);
					// var id_tache = $(this).attr('id').split('-t_')[1];
					// var start_tache = StartEnd.start;
					// var nb_jours_prevu = DateDiff(start_tache,StartEnd.end)+1;
												
					// var widthTache =$(this).width();
					// var leftTache = $(this).position().left;
					
					// var CurrTache = $(this).attr('id');
					
					// var tachesL =$('tr.t_'+$(this).attr('id').split('-t_')[1]);
					// var Tache_Times = [];
					
					// $('tr.t_'+$(this).attr('id').split('-t_')[1]).each(function(h){
												
						// var uid_collab = $(this).attr('class').split(' ')[0];
						// var uid_tache = $(this).attr('class').split(' ')[1];
						// var uid_dossier = $(this).parents('.pl').attr('id').split('_')[1];
						// var d_uid_dossier = 'd_'+uid_dossier;
						
						// if(collab_dossier[d_uid_dossier][uid_collab][uid_tache].temps !=  undefined)	{

							// for(var uid_time in collab_dossier[d_uid_dossier][uid_collab][uid_tache].temps) {
								// time = new Date(DateValid(collab_dossier[d_uid_dossier][uid_collab][uid_tache].temps[uid_time].date)).getTime();
								// Tache_Times.push(time);
							// }
						// }
						
						//adaptation des temps des jours
						

						// if(h+1 == tachesL.length){
						
							// Tache_Times.sort();
							// var timeMin = Tache_Times[0];
							// Tache_Times.reverse();
							// var timeMax = Tache_Times[0];
							// var _uid_dossier = $(this).parents('.pl').attr('id').split('_')[1];
							
							
							// if((new Date(DateValid(StartEnd.start)).getTime()) > timeMin | (new Date(DateValid(StartEnd.end)).getTime()) < timeMax & timeMin != undefined) {
									
									// $('#pl_'+_uid_dossier+' tr.'+uid_tache).each(function(){
										// var id_collab = $(this).attr('class').split(' ')[0];
										// $('#pl_'+_uid_dossier+' #'+id_collab+'-'+uid_tache).css({'width':widthTacheInit,'left':leftTacheInit});
									// });
							// }else{
							
								// var name_collab = $('#pl_'+uid_dossier+' tr.'+uid_collab+'.'+uid_tache+' .collab').html().split('</span>')[1];
								// var jours_passe = parseFloat($('#pl_'+uid_dossier+' tr.'+uid_collab+'.'+uid_tache+' .collab .label').text().split(' - ')[0]);
								//var class_label = (jours_passe == 0) ? 'label-success': 'label-important'; 
								// switch(true) {
									// case jours_passe>nb_jours_prevu:
									  // var class_label = 'label-important';
									  // break;
									// case jours_passe==nb_jours_prevu:
									  // var class_label = 'label-info';
									  // break;
									// case jours_passe>0:
									  // var class_label = 'label-success';
									  // break;
									// default:
									  // var class_label = '';
								// }

								// $('#pl_'+_uid_dossier+' tr.'+uid_tache).each(function(){
									// var id_collab = $(this).attr('class').split(' ')[0];
									// collab_dossier[d_uid_dossier][id_collab][uid_tache].start = DateAddZero(StartEnd.start);
									// collab_dossier[d_uid_dossier][id_collab][uid_tache].end = DateAddZero(StartEnd.end);
									// $('#pl_'+_uid_dossier+' #'+id_collab+'-'+uid_tache).css({'width':widthTache,'left':leftTache});
									
									// $('#pl_'+uid_dossier+' .taches #'+id_collab+'-'+uid_tache).data({'jours_passe':jours_passe,'jours_prevus':nb_jours_prevu});
									// $('#pl_'+uid_dossier+' tr.'+id_collab+'.'+uid_tache+' .collab').html('<span class="label '+class_label+' label-collab">'+jours_passe+' / '+nb_jours_prevu+'</span> '+name_collab);
								// });

									// var url = 'http://' +document.location.host+ '/REST/set?token="'+token+'"&table="77"&UID="'+id_tache+'"&Field="1"&c30="'+nb_jours_prevu+'"&c29="'+start_tache+'"';
									
									// send ajax 
									// $.ajax({
										// type: "POST",
										// url: url,  
										// dataType: "json",
										// error:function(msg){
											// console.log(msg);
										// },
										// success:function(data){
											// console.log(data);
										// }
									// });
							// }
						// }
					// });	
				 // }
			// });
		
			var dropped = false;
			
			$('.ex_tache').draggable({
				 
				 stop: function() {
						if(!dropped){
							$(this).stop().animate({
									top: 0,
									left: 0
								},600,'easeOutCirc');
						}
				 }
			 
			 });
							
			$('.taches').droppable({
			
				drop: function(event, ui) {
					var top =0;
					var left = 0;
				
					if($(ui.draggable).hasClass('ex_tache')) {
						var out_id = $(ui.draggable).attr('id');
						var uid_dossier_out = $('#'+out_id).parents('.external_tache').prev().attr('id').split('_')[1];
							
						var uid_tache_out = 't_'+out_id.split('-t_')[1];
						var uid_collab_out = out_id.split('-t_')[0];
						var titleTache = $('#'+out_id).parent().attr('title');
						
						var leftReel = ($('#'+out_id).position().left-(TableW-(widthG*CalNbDays)))/widthG;
						var leftFloor =   Math.floor(leftReel);
						var leftCiel =   Math.ceil(leftReel);
						
						var uid_dossier = $(this).parents('.pl').attr('id').split('_')[1];
						var d_uid_dossier = 'd_'+uid_dossier;
						
						var  ids_collab = ' ';
						var start_tache, end_tache,CalDate_dossier,i,lengthTache_ex;

						if(uid_dossier == uid_dossier_out){
					
							dropped = true;
					
							// add line for the placed task
							var externalTache = $('#pl_'+uid_dossier+'_'+Calmode).parents('#planning-wrapper').prev('.external_tache');
							lengthTache_ex =  externalTache.find('.'+uid_tache_out).length;
							//lengthTache_ex = $('#pl_'+uid_dossier).parents('#planning-wrapper').length;
						
							//alert(lengthTache_ex);
							if(lengthTache_ex >0){
								
								externalTache.find('.'+uid_tache_out).each(function(i){
								
									var uid_collab = $(this).children().attr('id').split('-t_')[0];
									
									ids_collab = ids_collab+' '+uid_collab.split('_')[1];
									
									//creat new line for the task
									var trClone = $('#pl_'+uid_dossier+'_'+Calmode+' tr.'+uid_collab).clone();
									$('#pl_'+uid_dossier+'_'+Calmode+' tr.'+uid_collab+':last').after(trClone).next().removeClass().addClass(uid_collab).addClass(uid_tache_out).children().first(); //.text();
									
									// creat the new dragged task
									width = 'width:'+((widthG*5)-(scallW*2)-1)+'px';
									var newTache = '<a href="modif_todo?todo='+uid_tache_out.split('t_')[1]+'" target="_blank"><div class="tache" id="'+uid_collab+'-'+uid_tache_out+'" style="'+width+'">'+titleTache+'</div></a>';
									
									// place the new task in taches
									$('#pl_'+uid_dossier+'_'+Calmode+' .taches').append(newTache);
									// adapte the grid with the current task 
									adapteLines(uid_dossier);
									// animate the ex_tache and remove it
									$(this).effect('explode', {} , 500, function(){ 
										$(this).remove(); 
									}); // explode 
									

									// calculate the top and the left
									top =  $('#pl_'+uid_dossier+'_'+Calmode+' tr.'+uid_collab+':last').index()*heightG;
									left = ((leftReel+0.5)<leftCiel) ? leftFloor*widthG: leftCiel*widthG;
									
									// calculate the start date and the end that
									CalDate_dossier = new Date(collab_dossier[d_uid_dossier].date);
									var Day = (((left/widthG)+1) < 0) ? 1: left/widthG;
									var month = (CalDate_dossier.getMonth()+1);
									start_tache = ('0'+Day).slice(-2)+'/'+('0'+month).slice(-2)+'/'+(CalDate_dossier.getFullYear());
									end_tache =  new Date(parseInt(CalDate_dossier.getFullYear()),parseInt(CalDate_dossier.getMonth()),parseInt(Day));
									end_tache = end_tache.addDays(4);  // 5 jours
									end_tache =  end_tache.getDate()+'/'+(end_tache.getMonth()+1)+'/'+end_tache.getFullYear();
									//console.log(start_tache+' '+end_tache);
									
									// add the scall height and and correct the left 
									top = top+scallH;
									left = left+scallW-widthG;
									//console.log(left);
									
									// refresh the memory with the new information
									if(collab_dossier[d_uid_dossier][uid_collab] == null) {collab_dossier[d_uid_dossier][uid_collab] = {};} 								
									collab_dossier[d_uid_dossier][uid_collab][uid_tache_out] = {};
									collab_dossier[d_uid_dossier][uid_collab][uid_tache_out].title = titleTache;
									collab_dossier[d_uid_dossier][uid_collab][uid_tache_out].start = DateAddZero(start_tache);
									collab_dossier[d_uid_dossier][uid_collab][uid_tache_out].end = DateAddZero(end_tache);
									collab_dossier[d_uid_dossier][uid_collab][uid_tache_out].deadline = '00/00/00';
									
									$('#'+uid_collab+'-'+uid_tache_out).stop().animate({
											top: top,
											left: left
										},600,'easeOutCirc',function(){
											if((lengthTache_ex-1) == i){
												$('.pl').remove();
												$('#d_'+uid_dossier).planning({CalDateStart:CalDate_dossier,'collabs':collab_dossier[d_uid_dossier]});
												// applyScroll();
											}
										});
									});
									
									// get the necessary  information to refresh the database
									var id_tache = uid_tache_out.split('_')[1];
									//var ids_collab = uid_collab_out.split('_')[1];
									
									//var nb_jours_prevu =  DateDiff(start_tache,end_tache)+1;
									var nb_jours_prevu =  2;
									
									// creat the link to communicate with the server
									var url = 'http://' +document.location.host+ '/REST/set?token="'+token+'"&table="77"&UID="'+id_tache+'"&Field="1"&c30="'+nb_jours_prevu+'"&c29="'+start_tache+'"&c10="'+ids_collab+'"';
									
									// send ajax 
									$.ajax({
										type: "POST",
										url: url,  
										dataType: "json",
										error:function(msg){
											console.log(msg);
										},
										success:function(data){
											console.log(data);
										}
									});
								
							}
						}else{
						
							$('#'+out_id).stop().animate({
								top: top,
								left: left
								},600,'easeOutCirc',function(){
									if(top != 0 & left !=0){
									//$('#pl_'+uid_dossier).remove();
									//$('#d_'+uid_dossier).planning({CalDateStart:CalDate_dossier,'collabs':collabs});
									}
									
								}
							);
						}	
					}
					
				}
			
		});
		//$('#'+uid_dossier).prev().children().last().remove();
		
		
		
		$('.pl').attr('data-scal',CalScal);
		$('.pl').attr('data-startdate',CalDateStart);
		$('.pl').attr('data-startend',CalDateEnd);
		
		// $('.current.'+CalScal).addClass('btn-info');
		if(Calmode == 'taches'){
			$('#'+uid_dossier).planning({'CalDateStart':CalDateStart,'CalScal':CalScal,'collabs':collab_dossier[uid_dossier],'Calmode':'collabs'});
			applyScroll();
		}
		
		//Assigner une tâche à un collaborateur en Drag dans la liste des taches externes
		$('.collab-name').draggable({
			revert 		:	 true,
			appendTo	: 'body',
			helper 		: "clone"
		});
		
		$('.external_tache a').droppable({
			drop	:	function(event,ui){
				var $this				= 	$(this);
				var id 					= 	$('.ex_tache',$this).attr('id');
				var	taskCollabID		=	id.split('-')[0];
				var	taskID				=	id.split('-')[1];
				var foreignCollabUid	=   $(ui.draggable).data('uidcollab');
				var href 				= 	$this.attr('href');
				var taskTitle			=   $this.attr('title');
				var collabName			=   $(ui.draggable).find('.collaborateur').text();
				var	_class				=	foreignCollabUid;
				var newID				= 	foreignCollabUid+'-'+taskID;
				if(	(taskCollabID != foreignCollabUid) || ( (taskCollabID == '') || (taskCollabID == null) )	){
					if(!$('.external_tache').find('#'+foreignCollabUid+'-'+taskID).length){ 
						// Condition pour ne pas ajouter la meme tache plusieurs fois au meme collaborateur
						rebuildExternalTasks(href,newID,taskTitle,collabName,_class)
					}
					
				}
			}
		});
	};
	
	

	
	//Fonction pour ajouter la tache supprimée a $('.external_tache')
	function rebuildExternalTasks(href,id,taskTitle,collabName,_class){
		var tasksContainer  = 	$('.external_tache');
		var htmlTask		= 	'<a href="'+href+'" target="_blank" title="'+taskTitle+'" class="'+_class+'">'+
									'<div class="ex_tache" id="'+id+'">'+collabName+' : '+taskTitle+'</div>'+
								'</a>';
		tasksContainer.append(htmlTask);
		$('.ex_tache').draggable();
		
	}
	//Supprimer une tache	
	$('.remove-task').live('click',function(e){
		// $(document).on('click','.next',function(e){
			e.preventDefault();
			var $this 		= $(this);
			var $a	 	 	= $this.parents('a');
			var href		= $a.attr('href');
			var id			= $('.tache',$a).attr('id');
			var _class 		= id.split('-')[1];
			var collabName	= $('.name-collab',$a).text();		
			var taskTitle	= $('.title-task',$a).text();
			rebuildExternalTasks(href,id,taskTitle,collabName,_class);	
			$('.collab-temp[data-id="'+id+'"]').remove();
			$a.remove();

			//$('.pl').remove();
			//$('#d_'+id_dossier).planning({'CalDateStart':date_dossier,'CalScal':mode,'collabs':collab_dossier[d_id_dossier]});
	});
	
	$('.next').live('click',function(e){
	// $(document).on('click','.next',function(e){
			e.preventDefault();
			var id_dossier = $(this).parent().attr('id').split('_')[1];
			var d_id_dossier = 'd_'+id_dossier;
			var date_dossier = collab_dossier[d_id_dossier].date;

			var mode = $('.pl').data().scal;
			var Scal = $(this).data().scal;

			date_dossier = CalculDateScal(date_dossier,Scal).DateEnd;
			
			$('.pl').remove();
			$('#d_'+id_dossier).planning({'CalDateStart':date_dossier,'CalScal':mode,'collabs':collab_dossier[d_id_dossier]});
			// applyScroll();
	});
		
	$('.previous').live('click',function(e){
		// $(document).on('click','.previous',function(e){
			e.preventDefault();
			var id_dossier = $(this).parent().attr('id').split('_')[1];
			var d_id_dossier = 'd_'+id_dossier;
			var date_dossier = collab_dossier[d_id_dossier].date;

			var mode = $('.pl').data().scal;
			var Scal = $(this).data().scal;
			
			date_dossier = CalculDateScal(date_dossier,Scal).DateStart;
			
			$('.pl').remove();
			$('#d_'+id_dossier).planning({'CalDateStart':date_dossier,'CalScal':mode,'collabs':collab_dossier[d_id_dossier]});				
			
		});
		
	 $('.current').live('click',function(e){
	//$(document).on('click','.current',function(e){
			e.preventDefault();
			var id_dossier = $(this).parent().attr('id').split('_')[1];
			var d_id_dossier = 'd_'+id_dossier;
			var Scal = $(this).data().scal;
			
			var DateStart = new Date();
			
			switch(Scal) {
				case 'Week':
				  var DateStart = (new Date()).setDate(1);
				  break;
				case 'Month':
				  var DateStart = (new Date()).setDate(1);
				  break;
				case 'Term':
				case 'Year':
				  var DateStart = (new Date()).setMonth(0);
				  DateStart = (new Date(DateStart)).setDate(1);
				  break;						  
			}
			
		
			
			$('.pl').remove();
			$('#d_'+id_dossier).planning({'CalDateStart':DateStart,'CalScal':Scal,'collabs':collab_dossier[d_id_dossier]});
			
			
		});
		
	// $('.month').live('click',function(e){
			// e.preventDefault();
			// var id_dossier = $(this).parent().attr('id').split('_')[1];
			// var d_id_dossier = 'd_'+id_dossier;
			// var date_dossier = new Date();
			// date_dossier.setMonth(parseInt(monthNamesAbr.indexOf($(this).text()))-1);
			// date_dossier.setFullYear(parseInt(($(this).parent().children().first().text()).split(' ')[1]));
			// $('#pl_'+id_dossier).remove();
			// $('#d_'+id_dossier).planning({CalDateStart:date_dossier,'collabs':collab_dossier[d_id_dossier]});				
		// });		
	
	$('.hideDoc').live('click',function(e){
	//$(document).on('click','.hideDoc',function(e){
		e.preventDefault();
		//$(this).parents('.dossier').find('.pl,.external_tache').css('display','none');
		$(this).parents('.dossier').find('.pl,.external_tache').toggleClass('hide');
		$(this).removeClass('hideDoc').addClass('showDoc').text('Afficher');
	});
	
	$('.showDoc').live('click',function(e){
	//$(document).on('click','.showDoc',function(e){
		e.preventDefault();
		//$(this).parents('.dossier').find('.pl,.external_tache').css('display','block');
		$(this).parents('.dossier').find('.pl,.external_tache').toggleClass('hide')
		$(this).removeClass('showDoc').addClass('hideDoc').text('Masquer');
	});
	
	$('.showAll').live('click',function(e){
	// $(document).on('click','.showAll',function(e){
		e.preventDefault();
		$('.showDoc').click();
		$(this).removeClass('showAll').addClass('hideAll').text('Masquer Tout');
	});
	
	$('.hideAll').live('click',function(e){
	// $(document).on('click','.hideAll',function(e){
		e.preventDefault();
		$('.hideDoc').click();
		$(this).removeClass('hideAll').addClass('showAll').text('Afficher Tout');
	});
						
});