$(document).ready(function(){  
	var mandatory_fields = $("#mandatory").val().split(';');
	var mandatory_fields_ligne = $("#mandatory_ligne").val().split(';');
	var mandatory_fields_immeuble = $("#mandatory_fields_immeuble").val().split(';');

	Mark_All_Required_Fields_Default(mandatory_fields);
	Mark_All_Required_Fields_Default(mandatory_fields_ligne);

	$.fn.bootstrapSwitch.defaults.onText = 'Oui';
    $.fn.bootstrapSwitch.defaults.offText = 'Non';

    IW_bootstrapSwitch("lc_climatisation");
    IW_bootstrapSwitch("lc_chaudiere");
    IW_bootstrapSwitch("lc_chauffeeau");
	IW_bootstrapSwitch("lc_cave");
	IW_bootstrapSwitch("lc_balcon");
	IW_bootstrapSwitch("lc_terrasse");
	
	DATA_Get_Immeubles();

	$("#fdp_piece_quitter").click(function(ev){ 

		if ($("#form_back_view").val()!=''){
			$(location).attr('href', '/GL?action='+$("#form_back_view").val());
		}else{
			$(location).attr('href', '/GL?action=biens');	
		}	 

		return false;
	});  

	$("#btn_add_lc_immeuble_id").click(function(ev){ 
		Popup_Form_Immeuble(true);
		   
		return false;
	});
	
	$("#btn_updt_lc_immeuble_id").click(function(ev){ 
		DATA_GET_Immeuble($('#lc_immeuble_id option:selected').val() );
		   
		return false;
    });

	$("#fdp_piece_valider").click(function(ev){ 
		Save_Piece();
		
		return false;
   	});  
	
	function Save_Piece(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data_piece = {
			"id": $("#record_id").val(),
			"lc_immeuble_id": $('#lc_immeuble_id option:selected').val(),
			"lc_nom": $("#lc_gl_nom_suite").val(),
			"lc_actif": $("#lc_actif").is(":checked"),
			"lc_gl_type_gestion": $('#lc_gl_type_gestion option:selected').val(),
			"lc_chauffagetype": $('#lc_chauffagetype option:selected').val(),
                       "lc_chauffageenergie": $('#lc_chauffageenergie option:selected').val(),
                       "lc_climatisation": $('#lc_climatisation').val(),
                       "lc_gl_nombre_places": $('#lc_gl_nombre_places').val(),
                       "lc_eauchaudetype": $('#lc_eauchaudetype option:selected').val(),
			"lc_eauchaudeenergie": $('#lc_eauchaudeenergie option:selected').val(),
			"lc_radiateurnb": $('#lc_radiateurnb').val(),
			"lc_parking": $('#lc_parking').val(),
			"lc_chaudiere": $('#lc_chaudiere').val(),
			"lc_chauffeeau": $('#lc_chauffeeau').val(),
			"lc_cave": $('#lc_cave').val(),
			"lc_balcon": $('#lc_balcon').val(),
			"lc_terrasse": $('#lc_terrasse').val(),
			"lc_conventionne": $('#lc_conventionne').val(),
			"lc_observations": $('#lc_observations').val(),
		}

		var data = { 
			"zone":"gl", 
			"action":"set_bien",
			"data": {
			  "bien": data_piece
			}
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=set_bien",data_json, function(data){  
		 
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {//success

		})
		.fail(function() { //error
			   
		})
		.always(function() { //complete
		   $.LoadingOverlay("hide");

		   if (save_status!='Failed'){ 
				$(location).attr('href', '/GL?action=biens');	
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

	/*****************************************************************************/
	/*LOCATIONS*/
	/*****************************************************************************/
	LOC_Recalculer_IRL();
	LOC_Display_Table_List("encours");

	$("#btn_new_loc").click(function(ev){ 
	   LOC_Nouvelle_Fiche(ev);
	   
	   return false;
	});  

	$("#btn_dashboard_sinistres").click(function(ev){ 
	   $(location).attr('href', '/GL?action=sinistres'); 
	   
	   return false;
	});  

	$("#btn_search_loc").click(function(){  
	   	LOC_Display_Table_List("all");
	   	
	    return false;
	});  

	$("#btn_display_all_loc").click(function(){  
        UTL_Date_Picker_Formatted('',"#search_date");

        $("#search_bien_location").val('');
        $("#search_usager").val('');
		$("#search_bien_id").val('');
		$("#search_usager_id").val('');

	    LOC_Display_Table_List("all");
	   	
	    return false;
	});  

	$("#btn_recalculer_irl_loc").click(function(){  
	    LOC_Recalculer_IRL(true);
	    LOC_Display_Table_List("encours");
	   	
	    return false;
	});  

    $("#list_table_locations div").click(function(ev){ 

		if (ev.target.id!=''){
			$('#id_selected').val(ev.target.id);

			$(location).attr('href', '/GL?action=location&id='+ev.target.id+'&var=llk'); 
		}
        
    });  

    $("#btn_reset_loc").click(function(){  
        UTL_Date_Picker_Formatted('',"#search_date");

        $("#search_bien_location").val('');
        $("#search_usager").val('');
		$("#search_bien_id").val('');
		$("#search_usager_id").val('');

	    LOC_Display_Table_List("encours");
	   	
	    return false;
  	});  

	function LOC_Nouvelle_Fiche(){
	    $(location).attr('href', '/GL?action=location&bien_id='+$("#record_id").val()+'&retour=bien'); 
	}

	function LOC_Recalculer_IRL($show_alert=false){

	    $.LoadingOverlaySetup({
	        background      : "rgba(0, 0, 0, 0.5)",
	        imageColor      : "#fff"
	    });


	    $.LoadingOverlay("show");

	    $('#titre_popup').html('Modification');

			var data = { 
			    "zone":"gl", 
			    "action":"irl_recalculer",
			};

			var data_json = '&json='+JSON.stringify(data);

			$.getJSON("/GL?action=irl_recalculer",data_json, function(data){  

				$.each(data, function(key, value){ 

				});  
			 

			}).done(function() {//success

			})
			.fail(function() { //error

			})
			.always(function() { //complete
	           
	           $.LoadingOverlay("hide");

	             if($show_alert==true){

		            $.alert({
		                title: 'Succès',
		                content: 'Le calcul de du montant revisé a été effectué avec succès.',
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

	             }


			});  

	}

	function LOC_Display_Table_List($type_display){
		$.LoadingOverlaySetup({
		    background      : "rgba(0, 0, 0, 0.5)",
		    imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$('#list_table_locations .table').empty();

		var data_specific = {
			"search_bien_location": $("#record_id").val(),
			"search_usager": $("#search_usager_id").val(),
			"search_date": $("#search_date").val(),
			"type_display": $type_display
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_locations",
			"data": data_specific
	    };
		
		var data_json = 'json='+JSON.stringify(data_search);
	
		$.getJSON("/GL?action=locations_list_json",data_json, function(data){  
				
				$('#list_table_locations .table').empty();

				var resp_table_data='';

					resp_table_data +='<div class="row header">';
					resp_table_data +='<div class="cell " style="min-width: 120px;">';
					resp_table_data +='Date du bail';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell iw_second_column" style="min-width: 100px;">';
					resp_table_data +='Usager';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Bien en location';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Montant du loyer';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Montant revisé';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Date d\'entrée';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Date de sortie';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" style="min-width: 120px;text-align:center;">';
					resp_table_data +='Encours';
					resp_table_data +='</div>';
					resp_table_data +='</div>'; 
				
				if (data.length>0){
					var css_class_row='';
					var counter = 0;

					$.each(data, function(key, value){  


						css_class_row='';

						if(counter % 2 != 0){
							css_class_row+=' iw-alternate';
						}

						resp_table_data +='<div class="row body '+css_class_row+'">';
						resp_table_data +='<div class="cell " id="'+value.id+'">';
						resp_table_data += Get_Date_Formatted(value.loc_date);
						resp_table_data +='</div>';
						resp_table_data +='<div class="cell  " id="'+value.id+'">';
						resp_table_data +=value.loc_usager_name;
						resp_table_data +='</div>';
						resp_table_data +='<div class="cell " id="'+value.id+'">';
						resp_table_data +=value.loc_bien_name;
						resp_table_data +='</div>';
						resp_table_data +='<div class="cell " id="'+value.id+'">';
						resp_table_data +=iw_round(value.loc_montant_initial);
						resp_table_data +='</div>';
						resp_table_data +='<div class="cell " id="'+value.id+'">';
						resp_table_data +=iw_round(value.loc_montant_revise);
						resp_table_data +='</div>';
						resp_table_data +='<div class="cell " id="'+value.id+'">';
						resp_table_data += Get_Date_Formatted(value.loc_date_entree);
						resp_table_data +='</div>';
						resp_table_data +='<div class="cell " id="'+value.id+'">';
						resp_table_data += Get_Date_Formatted(value.loc_date_sortie);
						resp_table_data +='</div>';
						resp_table_data +='<div class="cell " id="'+value.id+'" style="text-align:center;">';
						if(value.loc_status=="encours"){
							resp_table_data +='<i class="fa fa-check-square-o fdp-icon-green"></i>';
						}else{
							resp_table_data +='<i class="fa fa-times fdp-icon-red"></i>';
						}
						resp_table_data +='</div>';
						resp_table_data +='</div>';

						$('<input>', {
							type: 'hidden',
							id: 'id'+value.id,
							name: 'id'+value.id,
							value: value.id
						}).appendTo('#list_table_locations');


						counter = counter + 1;
					});  

				}

				$("#list_table_locations .table").append(resp_table_data); 

		}).done(function() {//success

		})
		.fail(function() { //error
			LOC_Display_Table_List($type_display);
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});   
	   

	}

    Init_Autocomplete('#search_usager','#search_usager_id','GB','get_autocomplete_locataires');

	$('#irc_date_publication').datepicker({
		format: 'dd/mm/yyyy'
	});

	$('#recherche').removeAttr( 'style' );

	/*****************************************************************************/
	/*SINISTRES*/
	/*****************************************************************************/
	var sin_post_action = $("#sin_post_action").val();
	var sin_get_action = $("#sin_get_action").val();

	Display_Table_Sinistres();

	$("#btn_new_sinistre").click(function(ev){ 

		Nouvelle_Fiche_Sinistre(ev);
			
			return false;

	});  

	function Display_Table_Sinistres(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

	
		$.LoadingOverlay("show");


		$('#list_table_sinistres .table').empty();


		var data_specific = {
			"id": $("#record_id").val()
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_bien_lignes",
			"data": data_specific
		};
		
		var data_json = '&json='+JSON.stringify(data_search);
		

		$.getJSON("/GL?action="+sin_get_action,data_json, function(data){  
			$('#list_table_sinistres .table').empty();

			var resp_table_data='';

			resp_table_data +='<div class="row header">';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Date du sinistre';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell iw_second_column" style="min-width: 100px;">';
			resp_table_data +='Libellé';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell " style="min-width: 120px;">';
			resp_table_data +='Coût';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Prise en charge d\'assurance';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Numéro du contrat';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Montant de remboursement';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;" style="text-align:center;">';
			resp_table_data +='Travaux clôturés';
			resp_table_data +='</div>';
			resp_table_data +='</div>'; 
			
			if (data.length>0){
				var css_class_row='';
				var counter = 0;

				$.each(data, function(key, value){  
					css_class_row='';

					if (counter % 2 != 0){
							css_class_row+=' iw-alternate';
					}

					resp_table_data +='<div class="row body '+css_class_row+'">';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data += getDateData(value.sin_date);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell  " id="'+value.id+'">';
					resp_table_data +=value.sin_libelle;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data +=iw_round(value.sin_cout);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';

					if ((value.sin_assurance_pe==true)||(value.sin_assurance_pe=='Vrai')){
						resp_table_data +='<i class="fa fa-check-square-o fdp-icon-green"></i>';
					}else{
						resp_table_data +='<i class="fa fa-times fdp-icon-red"></i>';
					}

					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data +=value.sin_assurance_contrat_no;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data +=iw_round(value.sin_assurance_montant);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'" style="text-align:center;">';

					if ((value.sin_travaux_cloture==true)||(value.sin_travaux_cloture=='Vrai')){
						resp_table_data +='<i class="fa fa-check-square-o fdp-icon-green"></i>';
					}else{
						resp_table_data +='<i class="fa fa-times fdp-icon-red"></i>';
					}

					resp_table_data +='</div>';
					resp_table_data +='</div>';

					$('<input>', {
						type: 'hidden',
						id: 'id'+value.id,
						name: 'id'+value.id,
						value: value.id
					}).appendTo('#list_table_sinistres');

					counter = counter + 1;
				});  

			}

			$("#list_table_sinistres .table").append(resp_table_data); 
		}).done(function() {//success
		})
		.fail(function() { //error
			Display_Table_Sinistres();
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
	}

	function Nouvelle_Fiche_Sinistre(){
		$('#titre_popup').html('Nouveau sinistre');

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


						if(Check_Required_Fields(mandatory_fields_ligne)){

							Mark_All_Required_Fields(mandatory_fields_ligne);


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
							Save_Record_Line_Sinistre();
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
				var jc = this;

				this.$content.find('form').on('submit', function (e) {
					e.preventDefault();

					jc.$$formSubmit.trigger('click'); // reference the button and click it
				});

				$("input[type='checkbox']").on('change', function(){
					$(this).val(this.checked ? "true" : "false");
				});

				$('#sin_date').datepicker({
					format: 'dd/mm/yyyy'
				});

			}
		});

 
	}

	function Popup_Form_Immeuble($is_new_record){

		if ($is_new_record==true){
			$('#titre_popup_immeuble').html('Nouvelle immeuble');
		}else{
			$('#titre_popup_immeuble').html('Modification de l\'immeuble');
		}

		var var_popup = $('#iw_form_popup_immeuble').html();
		$('#iw_form_popup_immeuble').html('');
	
		$.confirm({
			title: '',
			columnClass: 'iw_popup_form iw_popup_form_small',
			content: '' +
			'<div>' +var_popup+     
			'</div>',
			buttons: {
				cancel: {
				text: 'Fermer',
				btnClass: 'iw_btn_close',
				action: function () {
					$('#iw_form_popup_immeuble').html(var_popup);
				}
			},
			formSubmit: {
				text: 'Enregistrer',
				btnClass: 'btn-blue iw_btn_save',
				action: function () {

					if (Check_Required_Fields(mandatory_fields_immeuble)){
						Mark_All_Required_Fields(mandatory_fields_immeuble);

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
						Save_Record_Immeuble($is_new_record);
						$('#iw_form_popup_immeuble').html(var_popup);

						return true;
					}

				}
			},
			Supprimer: {
				text: 'Supprimer',
				btnClass: 'btn-red iw_btn_delete', 
				keys: ['del'],
				isHidden: false,
				isDisabled: false,
				action: function(heyThereButton){

					$.confirm({
						title: 'Suppression',
						content: 'Voulez-vous vraiment supprimer cet immeuble ?',
						icon: 'fa fa-warning',
						animation: 'scale',
						closeAnimation: 'zoom',
						columnClass: 'iw_alert',
						buttons: {
							confirm: {
								text: 'Oui',
								btnClass: 'btn-orange',
								action: function () {
									$('#iw_form_popup_immeuble').html(var_popup);
									Remove_Immeuble();
								}
							},
							cancel: {
								text: 'Non',
								action: function () {
									$('#iw_form_popup_immeuble').html(var_popup);
								}
							}
						}
					});

				}
			}
			},
			onContentReady: function () {
				var jc = this;

				this.$content.find('form').on('submit', function (e) {
					e.preventDefault();

					jc.$$formSubmit.trigger('click'); // reference the button and click it
				});

				if ($is_new_record==true){
					$('#imm_nom').val('');
				}

			}
		});

	}

	function Save_Record_Immeuble($is_new_record){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		if ($is_new_record==true){

			var data_ligne = {
				"id": "0",
				"imm_nom": $("#imm_nom").val()
			}

		}else{

			var data_ligne = {
				"id": $('#lc_immeuble_id option:selected').val(),
				"imm_nom": $("#imm_nom").val()
			}
			
		}

		var data = { 
			"zone":"gl", 
			"action":"set_immeuble",
			"data": {
				"ligne": data_ligne
			}
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=set_immeuble",data_json, function(data){  
		
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (save_status!='Failed'){
				DATA_Get_Immeubles();
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

	function Remove_Immeuble(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data_ligne = { 
			"id": $('#lc_immeuble_id option:selected').val()
		};

		var data = { 
			"zone":"gl", 
			"action":"gl_remove_immeuble",
			"data": {
			"ligne": data_ligne
			}
		};

		var data_json = 'json='+JSON.stringify(data);
		var operation_status='';

		$.getJSON("/GL?action=gl_remove_immeuble",data_json, function(data){  

			$.each(data, function(key, value){  
				operation_status = value;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (operation_status=='Failed'){

				$.confirm({
					title: 'Suppression',
					content: 'Impossible d\'effectuer la suppression car il éxiste des biens appartenant à cet immeuble.',
					icon: 'fa fa-warning',
					animation: 'scale',
					closeAnimation: 'zoom',
					columnClass: 'iw_alert',
					buttons: {
						cancel: {
							text: 'Ok',
							action: function () {
							}
						}
					}
				});

			}else{
				DATA_Get_Immeubles();
			}

		});  

	}

	function DATA_Get_Immeubles(){
		$('#lc_immeuble_id').empty();

		var data_specific = {
			"id_selected":  $('#record_id').val()
		};
		
		var data_search = { 
			"zone":"gl", 
			"action":"get_immeubles",
			"data": data_specific
		};
	
		var data_json = 'json='+JSON.stringify(data_search);

		$.getJSON("/GL?action=get_immeubles",data_json, function(data){  
			$('#lc_immeuble_id').append('<option value="">Choix de l\'immeuble</option>');

			if (data.length>0){

				$.each(data, function(key, value){  

					if (UTL_Select_OptionExists(value.id,'lc_immeuble_id') == false){   
						$('#lc_immeuble_id').append('<option value="' + value.id + '" '+value.status+'>' + value.value + '</option>');
					}

				});  			
						
			}

		}).done(function() {//success
		})
		.fail(function() { //error 
		})
		.always(function() { //complete
		});
	}

	function DATA_GET_Immeuble($id){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

			var data_imm = { 
				"id": $id
			};

			var data = { 
				"zone":"gl", 
				"action":"data_imm",
				"data": {
				"ligne": data_imm
				}
			};

			var data_json = '&json='+JSON.stringify(data);

			$.getJSON("/GL?action=get_immeuble",data_json, function(data){  

				$.each(data, function(key, value){ 
					$("#imm_nom").attr('value', value.imm_nom);
				});  
			
			}).done(function() {//success
			})
			.fail(function() { //error
			})
			.always(function() { //complete
				$.LoadingOverlay("hide");
				Popup_Form_Immeuble(false);
			});  

	}

    function Save_Record_Line_Sinistre(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

		var data_address = {
			"ad_adresse1": $("#ad_adresse1").val(),
			"ad_adresse2": $("#ad_adresse2").val(),
			"ad_adresse3": $("#ad_adresse3").val(),
			"ad_code_postal": $("#ad_code_postal").val(),
			"ad_ville": $("#ad_ville").val() 	
		}

		var data_ligne = {
			"id_piece": $("#record_id").val(),
			"id_ligne": $("#id_selected").val(),
			"sin_date": $("#sin_date").val(),
			"sin_libelle": $("#sin_libelle").val(),
			"sin_cout": $("#sin_cout").val(),
			"sin_assurance_pe": $("#sin_assurance_pe").val(),
			"sin_assurance_nom": $("#sin_assurance_nom").val(),
			"sin_travaux_cloture": $("#sin_travaux_cloture").val(),
			"sin_assurance_montant": $("#sin_assurance_montant").val(),
			"sin_assurance_contrat_no": $("#sin_assurance_contrat_no").val(),
			"adresse": {
				"data": data_address
			} 
		}

		var data = { 
			"zone":"gl", 
			"action":"set_bien_ligne",
			"data": {
				"ligne": data_ligne
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		var save_status='';

		$.getJSON("/GL?action="+sin_post_action,data_json, function(data){  
			
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (save_status!='Failed'){
				Display_Table_Sinistres();
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

	$("#list_table_sinistres div").click(function(ev){ 

		if (ev.target.id!=''){
			var data_search = {
				"id": ev.target.id
			};

			if (ev.target.id!=''){ 
				$('#id_selected').val(ev.target.id);

				Get_Record_Data(ev.target.id);
				Get_Address(ev.target.id);

				var var_popup = $('#iw_form_popup').html();
				$('#iw_form_popup').html('');

				var btn_save_class = '';

				$.confirm({
					title: '',
					content: '' +
					'<div>' +var_popup+     
					'</div>',
					buttons: {
						formSubmit: {
							text: 'Enregistrer',
							btnClass: 'btn-blue '+btn_save_class,
							action: function () {

								if (Check_Required_Fields(mandatory_fields_ligne)){
									Mark_All_Required_Fields(mandatory_fields_ligne);

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
									Save_Record_Line_Sinistre();

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
		
		}
	});  

    function Get_Record_Data($id){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        $('#titre_popup').html('Modification');

		var data_module = { 
			"id": $id
		};

		var data = { 
			"zone":"gl", 
			"action":"get_bien_ligne",
			"data": {
				"ligne": data_module
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=get_sinistre",data_json, function(data){  

			$.each(data, function(key, value){ 
				$("#sin_libelle").attr('value', value.sin_libelle);
				$("#sin_cout").attr('value', iw_round(value.sin_cout));
				$("#sin_assurance_nom").attr('value', value.sin_assurance_nom);
				$("#sin_assurance_contrat_no").attr('value', value.sin_assurance_contrat_no);
				$("#sin_assurance_montant").attr('value', iw_round(value.sin_assurance_montant));

				UTL_Date_Picker_Formatted(getDateData(value.sin_date),'#sin_date');

				$("#sin_assurance_pe").attr('value', value.sin_assurance_pe);

				if (value.sin_assurance_pe==true){
					$( "#sin_assurance_pe" ).prop( "checked", true );
				}

				$("#sin_travaux_cloture").attr('value', value.sin_travaux_cloture);

				if (value.sin_travaux_cloture==true){
					$( "#sin_travaux_cloture" ).prop( "checked", true );
				}

				$("input[type='checkbox']").on('change', function(){
					$(this).val(this.checked ? "true" : "false");
				});
			});  
			
		}).done(function() {//success

		})
		.fail(function() { //error
			Get_Record_Data($id);
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
    }

    function Get_Address($id){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

		var data_address = { 
			"id": $id
		};

		var data = { 
			"zone":"gl", 
			"action":"get_address",
			"data": {
				"address": data_address
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=get_address_sinistre",data_json, function(data){  

			$.each(data, function(key, value){ 
				$("#ad_adresse1").attr('value', value.ad_adresse1);
				$("#ad_adresse2").attr('value', value.ad_adresse2);
				$("#ad_adresse3").attr('value', value.ad_adresse3);
				$("#ad_code_postal").attr('value', value.ad_code_postal);
				$("#ad_ville").attr('value', value.ad_ville);
			});  
			
		}).done(function() {//success

		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
    }

	$("#btn_display_all_loc").click();

    visiteur.proprietaires.forEach(element => {

        $('#lc_gl_proprietaire_nom').append($('<option>', {
            value: element.ID,
            text: element.PRO_Nom + " " + element.PRO_Prenom
        }));

    });

    $('#lc_gl_proprietaire_nom').change(function(){
        var $this = $(this);

        $.ajax({
            method: "POST",
            url: "/GL",
            data: {
                action: "changeProprietaire",
                id: $this.val(),
                bienID: $("#record_id").val()
            },
        }).done(function(response) {

        });

    });

	// Un peu de mise en forme
	$("#lc_immeuble_id").css("cssText", "width: calc(100% - 90px)!important;");

	$('#lc_gl_type_gestion').append($('<option>', {
		value: "Location",
		text: 'Location'
	}));
	$('#lc_gl_type_gestion').append($('<option>', {
		value: "Sous location",
		text: 'Sous location'
	}));
	$('#lc_gl_type_gestion').append($('<option>', {
		value: "Hébergement",
		text: 'Hébergement'
	}));

        $('#lc_gl_type_gestion').val(visiteur.entity.LC_GL_Type_Gestion);

        if (visiteur.entity.LC_Actif == true) {
                $('#lc_actif').prop('checked', true);
        }

        if (visiteur.entity.LC_GL_Nombre_Places !== undefined) {
                $('#lc_gl_nombre_places').val(visiteur.entity.LC_GL_Nombre_Places);
        }

	$("#kitList").css("cssText", "width: 150px!important;");

	$('#kitList').append($('<option>', {
		value: "Kit mobilier",
		text: 'Kit mobilier'
	}));
	$('#kitList').append($('<option>', {
		value: "Kit vaisselle",
		text: 'Kit vaisselle'
	}));
	$('#kitList').append($('<option>', {
		value: "Kit linge",
		text: 'Kit linge'
	}));
	$('#kitList').append($('<option>', {
		value: "Kit entretien",
		text: 'Kit entretien'
	}));
	$('#kitList').append($('<option>', {
		value: "Kit hygiène bébé",
		text: 'Kit hygiène bébé'
	}));
	$('#kitList').append($('<option>', {
		value: "Kit électroménager",
		text: 'Kit électroménager'
	}));

	$("#btn_valid_kit").click(function(){

        if ($("#kitList").val() == "") {
			alert("Veuillez sélectionner un kit");

			return false
		}

        $.ajax({
            method: "POST",
            url: "/GL",
            data: {
                action: "ajoutKit",
                kit: $("#kitList").val(),
                bienID: $("#record_id").val()
            },
        }).done(function(response) {
			document.location.reload();
        });
	});
});