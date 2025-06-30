		 
 $(document).ready(function(){  

    var mandatory_fields = $("#mandatory").val().split(';');

    Mark_All_Required_Fields_Default(mandatory_fields);

    $('#rlc_date').datepicker('update', "");

    $('#reg_destinataire_nom').prop("disabled", true);

	$('#reg_type_destinataire').on('change', function() {

		$('#reg_destinataire_nom').prop("disabled", false);

		$('#reg_destinataire_nom').val('');
		$('#reg_destinataire_id').val('');

		switch($(this).find(":selected").val()){
			case 'centre': Init_Autocomplete('#reg_destinataire_nom','#reg_destinataire_id','GB','get_autocomplete_centres');break;
			case 'proprietaire': Init_Autocomplete('#reg_destinataire_nom','#reg_destinataire_id','GB','get_autocomplete_proprietaires');break;
			case 'locataire':Init_Autocomplete('#reg_destinataire_nom','#reg_destinataire_id','GB','get_autocomplete_locataires');break;
			default:$('#reg_destinataire_nom').prop("disabled", true); break;
		}
	    


	});

	






  $("#fdp_piece_valider").click(function(ev){ 

	   Save_Piece();
	   	
	    return false;

  });  



$("#fdp_piece_quitter").click(function(ev){ 

   $(location).attr('href', '/GL?action=relances');
   	
    return false;

});  

Display_Table_List_Factures_NS();

$('#reg_destinataire_id').bind("change", function() {
      // alert($(this).val()); 

       Display_Table_List_Factures_NS();
       // Get_Destinataire_Data();

        //$('#iw_factures_non_soldees').removeClass('iw_display_none');
        //$('#iw_factures_non_soldees').removeClass('iw_display_none').addClass('iw_display_none');
 });


	         
        $("#list_table_factures_ns div").click(function(ev){ 

        	 $('#id_selected').val(ev.target.id);
	         $('#reg_facture_piece_no').val($('#factue_piece_'+ev.target.id).val());
	       

        });  

function Display_Table_List_Factures_NS(){

			$.LoadingOverlaySetup({
			    background      : "rgba(0, 0, 0, 0.5)",
			    imageColor      : "#fff"
			});
 	
			$.LoadingOverlay("show");

			$('#list_table_factures_ns .table').empty();

			var data_specific = {
				"search_date": '',
				"search_type_destinataire": $("#reg_type_destinataire").val(),
				"search_destinataire": $("#reg_destinataire_id").val(),
				"search_type": 'non soldée'
			};

			var data_search = { 
				"zone":"gl", 
				"action":"get_factures",
				"data": data_specific
		    };
			
			var data_json = '&json='+JSON.stringify(data_search);
			

           $.getJSON("/GL?action=factures_list_json",data_json, function(data){  
		        
		        $('#list_table_factures_ns .table').empty();

		        var resp_table_data='';

					resp_table_data +='<div class="row header">';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='N° de pièce';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell iw_second_column" style="min-width: 100px;">';
					resp_table_data +='Date de la facture';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Montant HT';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Montant TTC';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Reste à payer';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Total réglé';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Date d\'échéance';
					resp_table_data +='</div>';
					resp_table_data +='</div>'; 
		        
				if(data.length>0){
			
				
				var css_class_row='';
				var counter = 0;

				
                $.each(data, function(key, value){  


                    css_class_row='';

					if(counter % 2 != 0){
						 css_class_row+=' iw-alternate';
					}

					resp_table_data +='<div class="row body '+css_class_row+'">';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data += value.fac_no_piece;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell  " id="'+value.id+'">';
					resp_table_data +=Get_Date_Formatted(value.fac_date);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
	                resp_table_data +=iw_round(value.fac_montant_ht);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
		            resp_table_data +=iw_round(value.fac_montant_ttc);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data += iw_round(value.fac_solde_du);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data += iw_round(value.fac_solde_regle);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data += Get_Date_Formatted(value.fac_date_echeance);
					resp_table_data +='</div>';
					resp_table_data +='</div>';

					$('<input>', {
					    type: 'hidden',
					    id: 'id'+value.id,
					    name: 'id'+value.id,
					    value: value.id
					}).appendTo('#list_table_factures_ns');

					$('<input>', {
					    type: 'hidden',
					    id: 'factue_piece_'+value.id,
					    name: 'factue_piece_'+value.id,
					    value: value.fac_no_piece
					}).appendTo('#list_table_factures_ns');

                     counter = counter + 1;
                });  

             
		
				

				 }

				 $("#list_table_factures_ns .table").append(resp_table_data); 

           }).done(function() {//success
   
			  })
			  .fail(function() { //error
			     Display_Table_List_Factures_NS();
			  })
			  .always(function() { //complete
			    $.LoadingOverlay("hide");
			  });   
		   
     }



     function Get_Destinataire_Data(){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

  
        $.LoadingOverlay("show");

		    var data_module = { 
              "id": $('#reg_destinataire_id').val(),
              "type_destinataire": $('#reg_type_destinataire').val()
			};

			var data = { 
			    "zone":"gl", 
			    "action":"get_destinataire",
			    "data": {
			      "ligne": data_module
			    }
			};

			var data_json = '&json='+JSON.stringify(data);



			$.getJSON("/GL?action=get_destinataire_data",data_json, function(data){  

				$.each(data, function(key, value){ 

					$("#reg_banque_domiciliation").attr('value', value.des_banque);

					
					$('#reg_date_piece').datepicker({
					format: 'dd/mm/yyyy'
					});

					$('#reg_date_piece').datepicker('update', '');

				});  
			 

			}).done(function() {//success

			})
			.fail(function() { //error

			})
			.always(function() { //complete
               
               $.LoadingOverlay("hide");


			});  

    }

    function Save_Piece(){


   	    if(Check_Required_Fields(mandatory_fields)){

	        Mark_All_Required_Fields(mandatory_fields);

	        var msg_text='';

            msg_text='Vous devez remplir tous les champs obligatoires!';

	        $.alert({
	            title: 'Champs obligatoires!',
	            content: msg_text,
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


	    }else{

         $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

  
        $.LoadingOverlay("show");

            var data_piece = {
              "id": $("#record_id").val(),
              "rlc_date": $("#rlc_date").val(),
              "rlc_texte_haut": $("#rlc_texte_haut").val(),
              "rlc_texte_bas": $("#rlc_texte_bas").val(),
              "rlc_libelle": $("#rlc_libelle").val()
            }

			var data = { 
			    "zone":"gl", 
			    "action":"set_record",
			    "data": {
			      "relance": data_piece
			    }
			};

			var data_json = '&json='+JSON.stringify(data);

			var save_status='';

			$.getJSON("/GL?action=relance_valider",data_json, function(data){  
			 

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

		           // $(location).attr('href', '/GL?action=relance&id='+$("#record_id").val());

               }else{

		            $.alert({
		                title: 'Erreur',
		                content: 'Erreur',
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

    }




 });  
