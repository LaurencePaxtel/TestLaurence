		 
 $(document).ready(function(){  
 
 
     Display_Table_List();

     var required_fields = $("#mandatory").val().split(';');


      $("#btn_new").click(function(ev){ 

		   Nouvelle_Fiche(ev);
		   	
		    return false; 
 
      });  


        $("#list_table div").click(function(ev){ 

          if(ev.target.id!=''){


        	 
			var data_search = {
				"id": ev.target.id
			};

			$('#id_selected').val(ev.target.id);

		    Get_IRL_Data(ev.target.id);

	        var var_popup = $('#iw_form_popup').html();
	        $('#iw_form_popup').html('');


	        $.confirm({
	            title: '',
	            content: '' +
	            '<div>' +var_popup+     
	            '</div>',
	            buttons: {
	                formSubmit: {
	                    text: 'Enregistrer',
	                    btnClass: 'btn-blue',
	                    action: function () {



						    if(Check_Required_Fields(required_fields)){

						        Mark_All_Required_Fields(required_fields);


						        $.alert({
						            title: 'Champs obligatoires!',
						            content: 'Vous devez remplir tous les champs obligatoires!',
						            icon: 'fa fa-warning',
						            animation: 'scale',
						            closeAnimation: 'scale',
						            columnClass: 'iw_alert',
						            buttons: {
						                okay: {
						                    text: 'Ok',
						                    btnClass: 'btn-blue'
						                }
						            }
						        });

						        return false;
						 
						 
						    }else{

	                          Save_Record();

	                         $('#iw_form_popup').html(var_popup);
	                          $('#id_selected').val('');

	                        return true;

	                      }
	                    }
	                },
	                  cancel: {
	                    text: 'Fermer',
	                    action: function () {

	                    	 $('#iw_form_popup').html(var_popup);
	                    	  $('#id_selected').val('');
	          
	                       
	                    }
	                 },
	            },
	            onContentReady: function () {
	                // bind to events
	                var jc = this;
	                this.$content.find('form').on('submit', function (e) {
	                    // if the user submits the form by pressing enter in the field.
	                    e.preventDefault();
	                    jc.$$formSubmit.trigger('click'); // reference the button and click it


	                });


	            }
	        });


         }


	        

        });  






  $("#btn_search").click(function(){  


	    Display_Table_List();
	   	
	    return false;

  });  


  $("#btn_reset").click(function(){  


	    document.getElementById('irl').reset();

	    Display_Table_List();
	   	
	    return false;

  });  



    function Get_IRL_Data($id){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

  
        $.LoadingOverlay("show");

        $('#titre_popup').html('Modification');


		    var data_irl = { 
              "id": $id
			};

			var data = { 
			    "zone":"gl", 
			    "action":"get_irl",
			    "data": {
			      "irl": data_irl
			    }
			};

			var data_json = '&json='+JSON.stringify(data);

			$.getJSON("/GL?action=get_irl",data_json, function(data){  

				$.each(data, function(key, value){ 

					$("#irc_annee").attr('value', value.irc_annee);
					$("#irc_trimestre > [value=" + value.irc_trimestre + "]").attr("selected", "true");
					$("#irc_irl").attr('value', iw_round(value.irc_irl));
					$("#irc_variation_annuelle").attr('value', iw_round(value.irc_variation_annuelle));

					$('#irc_date_publication').datepicker({
					format: 'dd/mm/yyyy'
					});

					$('#irc_date_publication').datepicker('update', getDateData(value.irc_date_publication));

				});  
			 

			}).done(function() {//success

			})
			.fail(function() { //error

			})
			.always(function() { //complete
               
               $.LoadingOverlay("hide");


			});  

    }





    function Save_Record(){


        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

  
        $.LoadingOverlay("show");

            var data_irl = {
              "id": $("#id_selected").val(),
			  "irc_annee": $("#irc_annee").val(),
			  "irc_trimestre": $("#irc_trimestre").val(),
			  "irc_irl": $("#irc_irl").val(),
			  "irc_variation_annuelle": $("#irc_variation_annuelle").val(),
			  "irc_date_publication": $("#irc_date_publication").val()			  
            }

			var data = { 
			    "zone":"gl", 
			    "action":"set_irl",
			    "data": {
			      "irl": data_irl
			    }
			};

			var data_json = '&json='+JSON.stringify(data);

			var save_status='';

			$.getJSON("/GL?action=irl_fiche_valider",data_json, function(data){  
			 

			 $.each(data, function(key, value){  
              
                 save_status = value;
               
			 });

			}).done(function() {//success

			})
			.fail(function() { //error

			})
			.always(function() { //complete
               $.LoadingOverlay("hide");

               if(save_status!='Failed'){

	               Display_Table_List();
	               
	        
		            $.alert({
		                title: 'Succès',
		                content: 'Enregistrement effectué avec succès.',
		                icon: 'fa fa-check',
		                animation: 'scale',
		                closeAnimation: 'scale',
		                columnClass: 'iw_alert',
		                buttons: {
		                    okay: {
		                        text: 'Ok',
		                        btnClass: 'btn-blue'
		                    }
		                }
		            });

               }else{

		            $.alert({
		                title: 'Erreur',
		                content: 'La clé Année/Trimestre éxiste déja',
		                icon: 'fa fa-remove',
		                animation: 'scale',
		                closeAnimation: 'scale',
		                columnClass: 'iw_alert',
		                buttons: {
		                    okay: {
		                        text: 'Ok',
		                        btnClass: 'btn-blue'
		                    }
		                }
		            });
               }

            

			});  

		

    }


function Nouvelle_Fiche(){

	        $('#titre_popup').html('Nouvelle fiche');

	        var var_popup = $('#iw_form_popup').html();
	        $('#iw_form_popup').html('');

	       
	        $.confirm({
	            title: '',
	            content: '' +
	            '<div>' +var_popup+     
	            '</div>',
	            buttons: {
	                formSubmit: {
	                    text: 'Enregistrer',
	                    btnClass: 'btn-blue',
	                    action: function () {


						    if(Check_Required_Fields(required_fields)){

						        Mark_All_Required_Fields(required_fields);


						        $.alert({
						            title: 'Champs obligatoires!',
						            content: 'Vous devez remplir tous les champs obligatoires!',
						            icon: 'fa fa-warning',
						            animation: 'scale',
						            closeAnimation: 'scale',
						            columnClass: 'iw_alert',
						            buttons: {
						                okay: {
						                    text: 'Ok',
						                    btnClass: 'btn-blue'
						                }
						            }
						        });

						        return false;
						 
						 
						    }else{

						        Save_Record();

						         $('#iw_form_popup').html(var_popup);

						        return true;

						    }


	                    }
	                },
	                  cancel: {
	                    text: 'Fermer',
	                    action: function () {

	                    	 $('#iw_form_popup').html(var_popup);
	          
	                       
	                    }
	                 },
	            },
	            onContentReady: function () {
	                // bind to events
	                var jc = this;
	                this.$content.find('form').on('submit', function (e) {
	                    // if the user submits the form by pressing enter in the field.
	                    e.preventDefault();
	                    jc.$$formSubmit.trigger('click'); // reference the button and click it


	                });


					$("#irc_annee").datetimepicker( {
					    format: "yyyy",
					    startView: 'decade',
					    minView: 'decade',
					    viewSelect: 'decade',
					    autoclose: true,
					});

					 $('#irc_date_publication').datepicker({
					    format: 'dd/mm/yyyy'
					 });
					



	            }
	        });


}

function Display_Table_List(){


			$.LoadingOverlaySetup({
			    background      : "rgba(0, 0, 0, 0.5)",
			    imageColor      : "#fff"
			});
 
	  
			$.LoadingOverlay("show");


			$('#int-usager .table').empty();
			$('#int-usager-result .table').empty();


			var data_specific = {
				"search_annee": $("#search_annee").val(),
				"search_trimestre": $("#search_trimestre").val(),
				"search_irl": '' //$("#search_irl").val()
			};

			var data_search = { 
				"zone":"gl", 
				"action":"get_irl",
				"data": data_specific
		    };
			
			var data_json = '&json='+JSON.stringify(data_search);
			

           $.getJSON("/GL?action=irl_list_json",data_json, function(data){  
		        
		        $('#list_table .table').empty();

		        var resp_table_data='';

					resp_table_data +='<div class="row header">';
					resp_table_data +='<div class="cell ">';
					resp_table_data +='Année';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell iw_second_column" style="min-width: 100px;">';
					resp_table_data +='Trimestre de référence';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='IRL';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Variation annuelle';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Date de publication';
					resp_table_data +='</div>';
					resp_table_data +='</div>'; 
		        
				if(data.length>0){
				
				

			
				
				var css_class_row='';
				var counter = 0;
				var annee_previous ='';
				var css_annee_alternate='';
				var css_annee_separator='';
			

				
                $.each(data, function(key, value){  


                    css_class_row='';

					if(counter % 2 != 0){
						 css_class_row+=' iw-alternate';
					}

					css_annee_alternate='iw-alternate';
					css_annee_separator='';

					if(annee_previous!=value.irc_annee){
                       /*if(css_annee_alternate==''){
                       	css_annee_alternate='iw-alternate';
                       }else{
                        css_annee_alternate='';
                       }*/

                       if(counter>0){
                       	css_annee_separator="iw_row_separator";
                       }

                       
					}

					resp_table_data +='<div class="row body '+css_annee_separator+'">';
					resp_table_data +='<div class="cell '+css_annee_alternate+'" id="'+value.id+'">';
					if(annee_previous!=value.irc_annee){
                       resp_table_data +=value.irc_annee;
					}
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell '+css_class_row+' iw_second_column" id="'+value.id+'">';
					resp_table_data +=value.irc_trimestre;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell '+css_class_row+'" id="'+value.id+'">';
					if(value.irc_irl!=0){
                       resp_table_data +=iw_round(value.irc_irl);
					}else{
                       resp_table_data +='/';
					}
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell '+css_class_row+'" id="'+value.id+'">';
					if(value.irc_variation_annuelle!=0){
						if(value.irc_variation_annuelle>0){
	                        resp_table_data +='+ '+iw_round(value.irc_variation_annuelle)+' %';
						}else{
							resp_table_data +=' '+iw_round(value.irc_variation_annuelle)+' %';
						}
					}else{
                       resp_table_data +='/';
					}
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell '+css_class_row+'" id="'+value.id+'">';
					resp_table_data +=getDateData(value.irc_date_publication);
					resp_table_data +='</div>';
					resp_table_data +='</div>';

					$('<input>', {
					    type: 'hidden',
					    id: 'id'+value.id,
					    name: 'id'+value.id,
					    value: value.id
					}).appendTo('#list_table');

                     annee_previous = value.irc_annee;

                     counter = counter + 1;
                });  

             
				

				

				 }

				 $("#list_table .table").append(resp_table_data); 

           }).done(function() {//success
   
			  })
			  .fail(function() { //error
			    
			  })
			  .always(function() { //complete
			    $.LoadingOverlay("hide");
			  });   
		   



}




	$("#search_annee").datetimepicker( {
		format: "yyyy",
		startView: 'decade',
		minView: 'decade',
		viewSelect: 'decade',
		autoclose: true,
	});

	 $('#irc_date_publication').datepicker({
	    format: 'dd/mm/yyyy'
	 });

 });  
