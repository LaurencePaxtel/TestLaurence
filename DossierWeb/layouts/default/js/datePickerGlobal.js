var popovers = $('a.popover-link');
var elemenSelectedForDate ;
var isVisibleDate = false;

$(document).ready(function() {

		$(".dblClickShowInput").live('click',function(event) {
    		
    		if(($(this).data().type == "date") && !isVisibleDate ){
    			addBigDatePicker(this);
    			isVisibleDate = true;
    		}else{
    			
    			var popovers = $('a.popover-link');
    			popovers.popover('destroy');
				
				$(elemenSelectedForDate).text($(elemenSelectedForDate).text());
				popovers.remove();
				isVisibleDate = false;
    		}
       	 		
    	});
    	
    	
    	 $('#selectDatePicker').live('change',function(){
			var popovers = $('a.popover-link');
    		popovers.popover('destroy');
			isVisibleDate = false;
			$(elemenSelectedForDate).text($(this).val());
			popovers.remove();
		});
		
		$(".cancelDate").live('click',function(e){
    	
    		var popovers = $('a.popover-link');
    		popovers.popover('destroy');
			isVisibleDate = false;
			$(elemenSelectedForDate).text($(elemenSelectedForDate).text());
			popovers.remove();
		});
		
		
		
		$(".validatDate").live('click',function(e){
    	
    		isVisibleDate = false;
    		var  impotDate = $("#inputDate").val();
    		if(impotDate.match (/^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/) ){
  				var popovers = $('a.popover-link');
    			popovers.popover('destroy');
				$(elemenSelectedForDate).text($("#inputDate").val());
				popovers.remove();
			}else{
				$(".alertDate").show();
			}
		});
		
		
		
		popovers.popover({ html: true,trigger: 'manual',});
    
});

function addBigDatePicker(elm) {
    		
    
    		
    		
    		
				var input = "<div class='modalbackdropDatePickerGlobal in' style='background-color:#000000; bottom:0; left:0; position:fixed; right: 0; top:0; opacity: 0;'></div>";
    			
    			if(($(window).height() - $(elm).offset().top) > 300){
    				input += "<a href=\"#\" id=\"test\" class=\"popover-link\" data-placement=\"bottom\" data-html=\"true\" data-date-format=\"dd-mm-yyyy\"";
    			}else if($(elm).offset().top > 300){
    				input += "<a href=\"#\" id=\"test\" class=\"popover-link\" data-placement=\"top\" data-html=\"true\" data-date-format=\"dd-mm-yyyy\"";
    			}else if($(elm).offset().top > 300){
    				input += "<a href=\"#\" id=\"test\" class=\"popover-link\" data-placement=\"right\" data-html=\"true\" data-date-format=\"dd-mm-yyyy\"";
    			}else {
    				input += "<a href=\"#\" id=\"test\" class=\"popover-link\" data-placement=\"left\" data-html=\"true\" data-date-format=\"dd-mm-yyyy\"";
    			}
    			input += "data-content=\"<form >"; 
    			input += "<div class='divChoseDate2'>";
    							input += "<div id='dp6' class='datepicker' data-date='12/02/2012' data-date-format='dd-mm-yyyy'>";
    							input += "</div>";
    						input += "</div><div class='divChoseDate1' >";
							input += "<div class='control-group'>";
							
							
						
    					input += "<div class='alertDate alert-error hide'>";
							input += "Merci de saisir une date valide";
					input += "</div>";
							
							
							
							
							 
								input += "<label class='control-label' for='inputDate'>Date</label>";    													
    								input += "<div class='controls'>";
    									input += "<div class='input-prepend'>";
    									if($(elm).text().match (/^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/) ){
   												input += "<input class='span2' id='inputDate' type='text' value='"+$(elm).text()+"'>";
   											}else{
   												input += "<input class='span2' id='inputDate' type='text' value='00/00/000'>";
   											}
   												
   												
										input += "</div>";
    								input += "</div>";
    							input += "</div>";
    							input += "<div class='control-group'>";
            						input += "<div class='controls'>";
              							input += "<select id='selectDatePicker'>";  
              								input += "<option>...</option>"; 
                							input += "<option>Hier</option>";  
                							input += "<option>Aujourd\'hui</option>";  
                							input += "<option>Demain</option>";  
                							input += "<option>Semaine courante</option>";  
                							input += "<option>Semaine précédente</option>";
                							input += "<option>Semaine prochaine</option>";  
                							input += "<option>Mois courant</option>";  
                							input += "<option>Mois précédent</option>";  
                							input += "<option>Mois suivant</option>";  
                							input += "<option>2 mois précédents</option>";
                							input += "<option>3 mois précédents</option>";
                							input += "<option>6 mois précédents</option>";
                							input += "<option>9 mois précédents</option>";
                							input += "<option>Trimestre courant</option>";
                							input += "<option>Trimestre précédent</option>";
                							input += "<option>Trimestre prochain</option>";
                							input += "<option>Semestre courant</option>";
                							input += "<option>Semestre précédent</option>";
                							input += "<option>Semestre prochain</option>";
                							input += "<option>Année courant</option>";
                							input += "<option>Année précédent</option>";
                							input += "<option>Année suivant</option>";
                							input += "<option>Janvier précédent</option>";
                							input += "<option>Février précédent</option>";
                							input += "<option>Mars précédent</option>";
                							input += "<option>Juin précédent</option>";
                							input += "<option>juillet précédent</option>";
                							input += "<option>Aout précédent</option>";
                							input += "<option>Septembre précédent</option>";
                							input += "<option>Octobre précédent</option>";
                							input += "<option>Novembre précédent</option>";
                							input += "<option>Décembre précédent</option>";
                							input += "<option>1er Janvier</option>";
                							input += "<option>Lundi de Pâques</option>";
                							input += "<option>1er Mai</option>";
                							input += "<option>8 Mai</option>";
                							input += "<option>Ascension</option>";
                							input += "<option>Lundi de Pentecôte</option>";
                							input += "<option>14 juillet</option>";
                							input += "<option>15 Août</option>";
                							input += "<option>Toussaint</option>";
                							input += "<option>11 Novembre</option>";
                							input += "<option>Noël</option>";
                							input += "<option>Du lundi au vendredi</option>";
                							input += "<option>Samedi</option>";
                							input += "<option>Dimanche</option>";
                							input += "<option>Jours fériés</option>";
                							input += "<option>Jours fériés et ponts</option>";
              							input += "</select>";  
            						input += "</div>";  
          						input += "</div>";  
    												
    												
    							input += "<div class='control-group'>";
	    							input += "<div class='row-fluid'>";
    									input += "<div class='controls span6'>";
											input += "<a class='btn btn-primary validatDate'  >Valider</a>";
										input += "</div>";
										input += "<div class='controls span6'>";
											input += "<a class='btn cancelDate' type='reset'>Annuler</a>";
										input += "</div>";
									input += "</div>";
								input += "</div>";
    						input += "</div>";

    					input += "</form>\"";
    					input += "data-title=\"Choisissez une date ou une période.\"";
						input += ">"+$(elm).text()+"</a>";
						
			isVisibleDate = true;			
			elemenSelectedForDate = 	elm;
    		$(elm).html(input);
    		var popovers = $('a.popover-link');
    		popovers.popover('show');
    		$('.datepicker').datepicker({
					
			});
    		$('.datepicker').on('changeDate', function(ev){
				var temp = new Date();
				temp = ev.date;
				var  monthVal =  temp.getMonth() + 1;
				 		$("#inputDate").val(temp.getDate() + "/" + monthVal + "/" + temp.getFullYear());
 			 		});
    		isVisible = true;
		
		
    		
		}
		
		