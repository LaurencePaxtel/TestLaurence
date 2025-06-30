var buttonPrintInvoiceID_t = "";

$(document).ready(function(){  
	Display_Table_Lignes();

	var mandatory_fields = $("#mandatory").val().split(';');
	var mandatory_fields_ligne = $("#mandatory_ligne").val().split(';');

	Mark_All_Required_Fields_Default(mandatory_fields);
	Mark_All_Required_Fields_Default(mandatory_fields_ligne);

	if (visiteur.newInvoice != null || visiteur.entity["FAC_Type_Piece"] == "autre") {
		$("#fac_type").val("Provisoire");
		$("#fac_type").attr('readonly', 'readonly');

		disabledFirstChoiceInSelect("fac_type");
		$('#fac_type').find("option:eq(2)").prop('disabled', true);   
		
	}else{
		Init_Autocomplete_Biens('#fac_bien_nom','#fac_bien_id','GB','get_autocomplete_centres');
	}
	
	Init_Autocomplete_Locataires('#fac_locataire_nom','#fac_locataire_id','GB','get_autocomplete_heberge');

	$("#btn_new").click(function(ev){ 
		Nouvelle_Fiche(ev,'');
		return false;
	});  
 
	$("#btn_new_autre").click(function(ev){ 
		Nouvelle_Fiche(ev,'autre');
		return false;
	});  
 
	$("#fdp_piece_valider").click(function(ev){ 
		Save_Piece("");
		return false;
	});  

	$("#fdp_piece_print, #fdp_piece_print_avis, #fdp_piece_print_quittance").click(function(ev){ 
		buttonPrintInvoiceID_t = $(this).attr("id");

		if ($('#fac_type_facture').val() == 'Définitive'){
			Print_Piece();
		}else{
			Save_Piece("print");
		}

		return false;
	});
 
	$("#fdp_piece_delete").click(function(ev){ 

		if ($('#fac_type_facture').val()!='Définitive'){
			Delete_Piece();
		}
			
		return false;
	});  
 
	$("#fdp_piece_quitter").click(function(ev){ 
		$(location).attr('href', '/GL?action=factures');
		return false;
	});
 
	$("#list_table div").click(function(ev){ 
		$('#id_selected').val(ev.target.id);

		var $type_popup = $('#facl_type_'+ev.target.id).val(); 

		var var_popup = '';
		var var_popup_second='';
		var btn_save_class = '';

		if ($type_popup == ''){
			var_popup = $('#iw_form_popup').html();
			var_popup_second = $('#iw_form_popupautre').html();
		}else{
			var_popup = $('#iw_form_popupautre').html();
			var_popup_second = $('#iw_form_popup').html();	
		}

		$('#iw_form_popup').html('');
		$('#iw_form_popupautre').html('');

		if ($('#statut_cloture').val()=="True"){
			btn_save_class = 'iw_display_none';
		}

		$.confirm({
			title: '',
			content: '' +
			'<div>' + var_popup +     
			'</div>',
			buttons: {
				Supprimer: {
					text: 'Supprimer',
					btnClass: 'btn-red iw_btn_delete',
					keys: ['del'],
					isHidden: false,
					isDisabled: false,
					action: function() {

						$.confirm({
							title: 'Suppression',
							content: 'Voulez-vous vraiment supprimer cette ligne ?',
							icon: 'fa fa-warning',
							animation: 'scale',
							closeAnimation: 'zoom',
							columnClass: 'iw_alert',
							buttons: {
								confirm: {
									text: 'Oui',
									btnClass: 'btn-orange',
									action: function() {
										$('#iw_form_popup').html(var_popup);
										Remove_Facture_Ligne();
									}
								},
								cancel: {
									text: 'Non',
									action: function() {
										$('#iw_form_popup').html(var_popup);
									}
								}
							}
						});
					}
				},
				formSubmit: {
					text: 'Enregistrer',
					btnClass: 'btn-blue ' + btn_save_class,
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
							Save_Record_Line($type_popup);

							if ($type_popup==''){
								$('#iw_form_popup').html(var_popup);
								$('#iw_form_popupautre').html(var_popup_second);
							}else{
								$('#iw_form_popupautre').html(var_popup);
								$('#iw_form_popup').html(var_popup_second);
							}

							$('#id_selected').val('');
							return true;
						}
					}
				},
				cancel: {
					text: 'Fermer',
					action: function () {

						if ($type_popup == ''){
							$('#iw_form_popup').html(var_popup);
							$('#iw_form_popupautre').html(var_popup_second);
						}else{
							$('#iw_form_popupautre').html(var_popup);
							$('#iw_form_popup').html(var_popup_second);
						}

						$('#id_selected').val('');
					}
				},
			},
			onContentReady: function () {
				var jc = this;
				this.$content.find('form').on('submit', function (e) {
					e.preventDefault();
					jc.$$formSubmit.trigger('click');
				});

				$('.iw_number').on('change', function() {
					Set_Input_Value($(this),$(this).val());
				});
 
				Get_Record_Data(ev.target.id);
			}
		});
 
	});

	function Remove_Facture_Ligne() {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

        var data_ligne = {
            "id": $('#id_selected').val()
        };

        var data = {
            "zone": "gl",
            "action": "gl_remove_facture_ligne",
            "data": {
                "data": data_ligne
            }
        };

        var data_json = 'json=' + JSON.stringify(data);
        var operation_status = '';

        $.getJSON("/GL?action=gl_remove_facture_ligne", data_json, function(data) {

			$.each(data, function(key, value) {
				operation_status = value;
			});

		}).done(function() { //success

		})
		.fail(function() { //error

		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (operation_status == 'Failed') {

				$.confirm({
					title: 'Suppression',
					content: 'Impossible d\'effectuer la suppression.',
					icon: 'fa fa-warning',
					animation: 'scale',
					closeAnimation: 'zoom',
					columnClass: 'iw_alert',
					buttons: {
						cancel: {
							text: 'Ok',
							action: function() {

							}
						}
					}
				});

			}else {
				GES_Calcul_Pied();
				Display_Table_Lignes();
			}
		});
    }

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
			    "action":"get_facture_ligne",
			    "data": {
			      "ligne": data_module
			    }
			};

			var data_json = '&json='+JSON.stringify(data);

			$.getJSON("/GL?action=get_facture_ligne",data_json, function(data){  

				$.each(data, function(key, value){ 

					$("#facl_titre").attr('value', value.facl_titre);
					$("#facl_libelle").attr('value', value.facl_libelle);
					$("#facl_quantite").attr('value', value.facl_quantite);
					$("#facl_type").attr('value', value.facl_type);
					$("#current_type_ligne").attr('value', value.facl_type);

					Set_Input_Value("#facl_prix_unit_net",value.facl_prix_unit_net);
					Set_Input_Value("#facl_prix_unit_ht",value.facl_prix_unit_ht);
					Set_Input_Value("#facl_remise_taux",value.facl_remise_taux);
					Set_Input_Value("#facl_remise_montant",value.facl_remise_montant);
					Set_Input_Value("#facl_montant_ht",value.facl_montant_ht);
					Set_Input_Value("#facl_montant_ttc",value.facl_montant_ttc);
					Set_Input_Value("#facl_taux_tva",value.facl_taux_tva);
					Set_Input_Value("#facl_montant_tva",value.facl_montant_tva);
					Set_Input_Value("#facl_acompte",value.facl_acompte);

		            UTL_Date_Picker_Formatted(getDateData(value.facl_date_du),'#facl_date_du');
		            UTL_Date_Picker_Formatted(getDateData(value.facl_date_au),'#facl_date_au');
		
					$("input[type='checkbox']").on('change', function(){
				       $(this).val(this.checked ? "true" : "false");
				    });

					$("#facl_quantite").change( function() {
					   GES_Calcul_Ligne();
					});

					$("#facl_prix_unit_ht").change( function() {
					   GES_Calcul_Ligne();
					});

					$("#facl_remise_taux").change( function() {
					   GES_Calcul_Ligne();
					});
				});  
			 

			}).done(function() {//success

			})
			.fail(function() { //error

			})
			.always(function() { //complete
               $.LoadingOverlay("hide");
			});  

    }

    function Save_Piece($type){

    	if ($type == ""){

	   	    if (Check_Required_Fields(mandatory_fields)){
		        Mark_All_Required_Fields(mandatory_fields);

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


		    }else{
	          Save_Piece_Facture($type);
		    }

    	}else{
    	  Save_Piece_Facture($type);
    	}

    }

	function Delete_Piece(){

            $.confirm({
                title: 'Facturation',
                content: 'Voulez-vous vraiment supprimer cette facture ?',
                icon: 'fa fa-warning',
                animation: 'scale',
                closeAnimation: 'zoom',
                columnClass: 'iw_alert',
                buttons: {
                    confirm: {
                        text: 'Oui',
                        btnClass: 'btn-orange',
                        action: function () {
                        	 
                        	   Delete_Piece_Exec();

                        }
                    },
                    cancel: {
                        text: 'Non',
                        action: function () {

              
                 
                        
                        }
                   }
                }
            });
    }

	function Delete_Piece_Exec(){

		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});


		$.LoadingOverlay("show");

		
		var data_piece = {
			"id": $("#record_id").val()
		}   

		var data = { 
			"zone":"gl", 
			"action":"set_facture",
			"data": {
				"facture": data_piece
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		var save_status='';

		$.getJSON("/GL?action=facture_delete",data_json, function(data){  
			

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
			

				$(location).attr('href', '/GL?action=factures');   	
				
			
				
			}else{

				$.alert({
					title: 'Erreur',
					content: 'Impossible de supprimer une facture définitive',
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

    function Save_Piece_Facture($type){
	    var $fac_statut = $("#fac_statut").val();
		var $continue = false;
		var $fac_type= "";

	    if ($("#fac_statut").val() == 'temp'){
	      $fac_statut = 'Provisoire';
	    }

	    if ($type != 'temp'){
			   $fac_type= "Provisoire";
		
				if ($('#privilege_facturation').val() == 'True') {

					$.confirm({
						title: 'Facturation',
						content: 'Voulez-vous rendre la facture définitive ?',
						icon: 'fa fa-warning',
						animation: 'scale',
						closeAnimation: 'zoom',
						columnClass: 'iw_alert',
						buttons: {
							confirm: {
								text: 'Oui',
								btnClass: 'btn-orange',
								action: function () {
									$continue = true;
									$fac_type= "Définitive";

									$("#fac_type").val($fac_type);
									Save_Piece_Facture_Last($fac_type,$fac_statut,$type);
								}
							},
							cancel: {
								text: 'Non',
								action: function () {
									Save_Piece_Facture_Last($fac_type, $fac_statut, $type);
								}
							}
						}
					});
							
				}else{
					Save_Piece_Facture_Last($fac_type,$fac_statut,$type);
				}

	    }else{
	    	Save_Piece_Facture_Last($fac_type, $fac_statut, $type);
	    }

    }

    function Save_Piece_Facture_Last($fac_type, $fac_statut, $fac_print){
		var $fac_type_destinataire = "";
		var $fac_destinataire_table_origine = 0;

		switch (true) {
			case ($("#fac_destinataire_id option:selected").text().includes("propriétaire") == true):
				$fac_type_destinataire = "Propriétaire";
				$fac_destinataire_table_origine = 83;

				break;
			case ($("#fac_destinataire_id option:selected").text().includes("locataire") == true):
				$fac_type_destinataire = "Locataire";
				$fac_destinataire_table_origine = 4;

				break;
			default:
				break;
		}

		$.LoadingOverlay("show");

		var data_piece = {
			"id": $("#record_id").val(),
			"fac_type_destinataire": $fac_type_destinataire,
			"fac_destinataire_id": $("#fac_destinataire_id").val(),
			"fac_destinataire_table_origine": $fac_destinataire_table_origine,
			"fac_date_piece": $("#fac_date_piece").val(),
			"fac_type": $fac_type,
			"fac_adresse_facturation": $("#fac_adresse_facturation").val(),
			"fac_mode_reglement": $("#fac_mode_reglement").val(),
			"fac_date_echeance": $("#fac_date_echeance").val(),
			"fac_no_piece": $("#fac_no_piece").val(),
			"fac_taux_remise": $("#fac_taux_remise").val(),
			"fac_notes": $("#fac_notes").val(),
			"fac_statut": $fac_statut,
			"fac_montant_remise": $("#fac_montant_remise").val(),
			"fac_acompte": $("#fac_acompte").val(),
			"fac_montant_ht": $("#fac_montant_ht").val(),
			"fac_montant_ttc": $("#fac_montant_ttc").val(), 
			"fac_bien_id": $("#fac_bien_id").val(),	
			"fac_bien_nom": $("#fac_bien_nom").val(), 
			"fac_solde_anterieur": $("#fac_solde_anterieur").val()
		}

		if ($("#fac_categorie").length > 0) {
			data_piece["fac_categorie"] = $("#fac_categorie").val();
		}

		if ($("#fac_locataire_nom").length > 0) {
			data_piece["fac_locataire_nom"] = $("#fac_locataire_nom").val();
			data_piece["fac_locataire_id"] = $("#fac_locataire_id").val();
		}
		
		var data = { 
			"zone":"gl", 
			"action":"set_facture",
			"data": {
				"facture": data_piece
			}
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=facture_valider",data_json, function(data){  
			
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (($fac_type == "Définitive") || ($fac_type == "Provisoire")){

				if (save_status != 'Failed'){

					if ((save_status=="-2") || (save_status=="-3")){
						var $message="";

						if (save_status="-2"){
							$message='Veuillez renseigner l\'adresse du locataire dans sa fiche';
						}else{
							$message='Veuillez renseigner l\'adresse du propriétaire dans sa fiche';
						}

						$.alert({
							title: 'Alerte',
							content: $message,
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
						Display_Table_Lignes();
						GES_Calcul_Pied();
		
						if ($fac_print != 'print'){
							$(location).attr('href', '/GL?action=facture&id='+$("#record_id").val()); 
					
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
							Print_Piece();
						}

					}

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

			}

		});  

    }

    function Save_Record_Line($type_ligne){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

		var data_ligne = {
			"id_piece": $("#record_id").val(),
			"id_ligne": $("#id_selected").val(),
			"facl_titre": $("#facl_titre").val(),
			"facl_libelle": $("#facl_libelle").val(),
			"facl_quantite": $("#facl_quantite").val(),
			"facl_prix_unit_net": Get_Input_DataValue("#facl_prix_unit_net"),
			"facl_prix_unit_ht": Get_Input_DataValue("#facl_prix_unit_ht"),
			"facl_remise_taux": $("#facl_remise_taux").val(),
			"facl_remise_montant": Get_Input_DataValue("#facl_remise_montant"),
			"facl_montant_ht": Get_Input_DataValue("#facl_montant_ht"),
			"facl_montant_ttc": Get_Input_DataValue("#facl_montant_ttc"),
			"facl_service_id": $("#facl_service_id").val(),
			"facl_acompte": $("#facl_acompte").val(),
			"facl_date_du": $("#facl_date_du").val(),
			"facl_date_au": $("#facl_date_au").val(),
			"facl_type": $type_ligne,
			"facl_statut": 'temp'	  
		}

		var data = { 
			"zone":"gl", 
			"action":"set_facture_ligne",
			"data": {
				"ligne": data_ligne
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		var save_status='';

		$.getJSON("/GL?action=facture_ligne_valider",data_json, function(data){  
			
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
				GES_Calcul_Pied();
				Display_Table_Lignes();
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

	function Display_Table_Lignes(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data_specific = {
			"id": $("#record_id").val()
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_facture_lignes",
			"data": data_specific
		};
		
		var data_json = '&json='+JSON.stringify(data_search);
			
		$.getJSON("/GL?action=facture_lignes_list_json",data_json, function(data){  
			$('#list_table .table').empty();

			var resp_table_data='';

			resp_table_data +='<div class="row header">';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Description';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell iw_second_column" style="min-width: 100px;">';
			resp_table_data +='Quantité';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell " style="min-width: 120px;">';
			resp_table_data +='Prix Unitaire';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Taux remise';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Prix Unitaire Net';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Montant remise';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Montant HT';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Montant TTC';
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
					resp_table_data += value.facl_titre;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell  " id="'+value.id+'">';
					resp_table_data += value.facl_quantite;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+value.id+'">';
					resp_table_data += iw_round(value.facl_prix_unit_ht);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+value.id+'">';
					resp_table_data += iw_round(value.facl_remise_taux);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+value.id+'">';
					resp_table_data += iw_round(value.facl_prix_unit_net);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+value.id+'">';
					resp_table_data += iw_round(value.facl_remise_montant);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+value.id+'">';
					resp_table_data += iw_round(value.facl_montant_ht);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+value.id+'">';
					resp_table_data += iw_round(value.facl_montant_ttc);
					resp_table_data += '</div>';
					resp_table_data += '</div>';

					$('<input>', {
						type: 'hidden',
						id: 'id' + value.id,
						name: 'id' + value.id,
						value: value.id
					}).appendTo('#list_table');

					$('<input>', {
						type: 'hidden',
						id: 'facl_type_' + value.id,
						name: 'facl_type_' + value.id,
						value: value.facl_type
					}).appendTo('#list_table');

					counter = counter + 1;
				});  

			}

			$("#list_table .table").append(resp_table_data);
		}).done(function() {//success
		})
		.fail(function() { //error
			Display_Table_Lignes();
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
	}

	function Print_Piece(){
		printInvoice($("#record_id").val());
	}

	function Nouvelle_Fiche(ev, $type_popup){
		$('#titre_popup').html('Nouvelle ligne');

		var var_popup =''; 
		var var_popup_second='';

		$('#current_type_ligne').val($type_popup);

		if ($type_popup == ''){

			var_popup = $('#iw_form_popup').html();
			$('#iw_form_popup').html('');

			var var_popup_second = $('#iw_form_popupautre').html();
			$('#iw_form_popupautre').html('');

		}else{

			var_popup = $('#iw_form_popupautre').html();
			$('#iw_form_popupautre').html('');

			var var_popup_second = $('#iw_form_popup').html();
			$('#iw_form_popup').html('');	        	
		}

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

							Save_Record_Line($type_popup);

							// $('#iw_form_popup'+$type_popup).html(var_popup);

							if($type_popup==''){
									$('#iw_form_popup').html(var_popup);
									$('#iw_form_popupautre').html(var_popup_second);
							}else{
									$('#iw_form_popupautre').html(var_popup);
									$('#iw_form_popup').html(var_popup_second);
							}

							return true;

						}


					}
				},
					cancel: {
					text: 'Fermer',
					action: function () {

							if($type_popup==''){
									$('#iw_form_popup').html(var_popup);
									$('#iw_form_popupautre').html(var_popup_second);
							}else{
									$('#iw_form_popupautre').html(var_popup);
									$('#iw_form_popup').html(var_popup_second);
							}

						

			
						
					}
					},
			},
			onContentReady: function () {
				var jc = this;
				this.$content.find('form').on('submit', function (e) {
					e.preventDefault();
					jc.$$formSubmit.trigger('click');
				});

				$("input[type='checkbox']").on('change', function(){
					$(this).val(this.checked ? "true" : "false");
				});

				$("#facl_quantite").change( function() {
					GES_Calcul_Ligne();
				});

				$("#facl_prix_unit_ht").change( function() {
					GES_Calcul_Ligne();
				});

				$("#facl_remise_taux").change( function() {
					GES_Calcul_Ligne();
				});

				if ($type_popup==''){

					$('#facl_date_du').datepicker({
						format: 'dd/mm/yyyy'
					});

					$('#facl_date_au').datepicker({
						format: 'dd/mm/yyyy'
					}).datepicker('disable');;

					$('#facl_date_au').datepicker( "option", "disabled", true );

					if (visiteur.newInvoice == null && visiteur.entity["FAC_Type_Piece"] != "autre") {
						Init_Autocomplete_Locations('#facl_titre', '#facl_service_id', 'GB', 'get_autocomplete_usr_locations', '#fac_bien_id', '#fac_locataire_id');
					}
					
				}

				$('#facl_type').val($type_popup);
			}
		});
	}

	function Init_Autocomplete_Biens($id_field, $id_hidden, $module, $action){

		$($id_field).autocomplete({

			source: function (request, response) {
				var tb_request_term = request.term.split(' ');

				if (tb_request_term.length==2){

					var data_specific = {
						"data_first": tb_request_term[0],
						"data_second": tb_request_term[1]
					};

				}else{
					var data_specific = {
					"data_first": request.term,
					"data_second": ''
					};
				}

				var data_search = { 
					"zone": "globale", 
					"action": "get_autocomplete",
					"data": data_specific
				};
		
				var data_json = '&json='+JSON.stringify(data_search);

				$.ajax({
					type: "GET",
					url: "/"+$module+"?action="+$action,
					dataType: "json",
					data: data_json,
					contentType: "application/json; charset=utf-8",
					success: function (data) {

						response($.map(data, function (item) {

							return {
								id: item.id,
								value: item.value
							}

						}));

					}
				});
			},
			minLength: 0,
			select: function (event, ui) {
				$($id_hidden).val(ui.item.id);
				$($id_field).val(ui.item.value);
				
				$($id_field).attr('disabled', 'disabled');    

				return false;
			}
		}).focus(function () {
			setTimeout( "if ($('"+$id_field+"').val().length == 0) $('"+$id_field+"').autocomplete(\"search\", \"\"); ",1);
		}).live("blur", function(event) {
			var autocomplete = $(this).data("autocomplete");

			if (autocomplete.selectedItem) {

				autocomplete._trigger("select", event, {
					item: autocomplete.selectedItem
				});

			}else {
				$(this).val('');
			}

		});

	}

	function Init_Autocomplete_Locations($id_field, $id_hidden, $module, $action, $id_bien, $id_locataire){

		$($id_field).autocomplete({
		
			source: function (request, response) {
				var tb_request_term = request.term.split(' ');

				var data_specific = {
					"data_first": tb_request_term[0],
					"data_second": tb_request_term[1],
					"id_bien": $($id_bien).val(),
					"id_locataire": $($id_locataire).val()
				};

				var data_search = { 
					"zone": "globale", 
					"action": "get_autocomplete",
					"data": data_specific
				};
			
				var data_json = '&json=' + JSON.stringify(data_search);

				$.ajax({
					type: "GET",
					url: "/" + $module + "?action=" + $action,
					dataType: "json",
					data: data_json,
					contentType: "application/json; charset=utf-8",
					success: function (data) {

						response($.map(data, function (item) {

							return {
								id: item.id,
								value: item.value,
								quantite: item.quantite,
								prix_unitaire: item.prix_unitaire,
								garantie_encaisse: item.garantie_encaisse,
								garantie_montant: item.garantie_montant,
								loc_date_du: item.loc_date_du,
								loc_date_au: item.loc_date_au
							}

						}));

					}
				});
			},
			minLength: 0,
			select: function (event, ui) {
				$($id_hidden).val(ui.item.id);
				$($id_field).val(ui.item.value);

				Set_Input_Value("#facl_quantite", ui.item.quantite);   
				Set_Input_Value("#facl_prix_unit_ht", ui.item.prix_unitaire);    
				Set_Input_Value("#facl_prix_unit_net", ui.item.prix_unitaire); 

				if (ui.item.garantie_encaisse == 'True'){
					Set_Input_Value("#facl_acompte", ui.item.garantie_montant); 
				}else{
					Set_Input_Value("#facl_acompte", '0.00'); 
				}

				UTL_Date_Picker_Formatted(ui.item.loc_date_du, '#facl_date_du');
				UTL_Date_Picker_Formatted(ui.item.loc_date_au, '#facl_date_au');

				GES_Calcul_Ligne();
				return false;
			}

		}).focus(function () {
			setTimeout( "if ($('"+$id_field+"').val().length == 0) $('"+$id_field+"').autocomplete(\"search\", \"\"); ",1);
		}).live("blur", function(event) {
			var autocomplete = $(this).data("autocomplete");

			if (autocomplete === undefined || autocomplete === null) {
			}else{

				if (autocomplete.selectedItem) {

					autocomplete._trigger("select", event, {
						item: autocomplete.selectedItem
					});

				}else {
					$(this).val('');
				}
				
			}
		});

	}

	function Init_Autocomplete_Charges($id_field,$id_hidden,$module,$action,$id_bien,$id_locataire){

	$($id_field).autocomplete({
	  
		source: function (request, response) {

		 var tb_request_term = request.term.split(' ');

		var data_specific = {
		  "data_first": tb_request_term[0],
		  "data_second": tb_request_term[1],
		  "id_bien": $($id_bien).val(),
		  "id_locataire": $($id_locataire).val()
		};

		var data_search = { 
		  "zone": "globale", 
		  "action": "get_autocomplete",
		  "data": data_specific
		  };
	  
	   var data_json = '&json='+JSON.stringify(data_search);

			$.ajax({
				type: "GET",
				url: "/"+$module+"?action="+$action,
				dataType: "json",
				data: data_json,
				contentType: "application/json; charset=utf-8",
				success: function (data) {
					response($.map(data, function (item) {

						return {
							id: item.id,
							value: item.value,
							quantite: item.quantite,
							prix_unitaire: item.prix_unitaire
						}

					}));
				}
			});
		},
		 minLength: 0,
		select: function (event, ui) {
			$($id_hidden).val(ui.item.id);
			$($id_field).val(ui.item.value);  
			Set_Input_Value("#facl_quantite",ui.item.quantite);   
			Set_Input_Value("#facl_prix_unit_ht",ui.item.prix_unitaire);    
			Set_Input_Value("#facl_prix_unit_net",ui.item.prix_unitaire); 
			GES_Calcul_Ligne();
			return false;
		}
	}).focus(function () {

		setTimeout( "if ($('"+$id_field+"').val().length == 0) $('"+$id_field+"').autocomplete(\"search\", \"\"); ",1);

	}).live("blur", function(event) {

		var autocomplete = $(this).data("autocomplete");

		if (autocomplete.selectedItem) {
			autocomplete._trigger("select", event, {
				item: autocomplete.selectedItem
			});

		} else {
			$(this).val('');
		}

	});


	}

	function Init_Autocomplete_Locataires($id_field,$id_hidden,$module,$action,$id_bien){

		$($id_field).autocomplete({
		
			source: function (request, response) {
				var tb_request_term = request.term.split(' ');

				var data_specific = {
					"data_first": tb_request_term[0],
					"data_second": tb_request_term[1],
					"id_bien": $($id_bien).val()
				};

				var data_search = { 
					"zone": "globale", 
					"action": "get_autocomplete",
					"data": data_specific
				};
			
				var data_json = '&json='+JSON.stringify(data_search);

				$.ajax({
					type: "GET",
					url: "/"+$module+"?action="+$action,
					dataType: "json",
					data: data_json,
					contentType: "application/json; charset=utf-8",
					success: function (data) {

						response($.map(data, function (item) {

							return {
								id: item.id,
								value: item.value,
								quantite: item.quantite,
								prix_unitaire: item.prix_unitaire,
								garantie_encaisse: item.garantie_encaisse,
								garantie_montant: item.garantie_montant
							}

						}));

					}
				});
			},
			minLength: 0,
			select: function (event, ui) {
				$($id_hidden).val(ui.item.id);
				$($id_field).val(ui.item.value);

				/*
					$('#fac_locataire_nom').prop("disabled", true); 

					Get_Address_Facturation($("#fac_bien_id").val(),ui.item.id);
					Get_Facture_Lignes($("#record_id").val(),$("#fac_bien_id").val(),ui.item.id);
				*/

				if (visiteur.newInvoice != null || visiteur.entity["FAC_Type_Piece"] == "autre") {
					
					$.ajax({
						type: "GET",
						url: "/4DACTION/outilsWebManageFactureAjax",
						data: {
							"id": $("#record_id").val(),
							"hebergeID": $("#fac_locataire_id").val(),
							"action": "getCentre"
						},
						success: function (response) {
							var reponseParse = JSON.parse(response);

							$("#fac_bien_nom").val("");
							$("#fac_bien_id").val("");

							if (reponseParse.notificationError != null) {

								/*
									$.alert({
									title: '',
									content: reponseParse.notificationError,
									icon: 'fa fa-error',
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
								*/
								
							}else{
								$("#fac_bien_nom").val(reponseParse.fac_bien_nom);
								$("#fac_bien_id").val(reponseParse.fac_bien_id);
							}
							
						}

					});

				}
				
				Save_Piece("temp");
				return false;
			}

		}).focus(function () {
			setTimeout( "if ($('"+$id_field+"').val().length == 0) $('"+$id_field+"').autocomplete(\"search\", \"\"); ",1);
		}).live("blur", function(event) {
			var autocomplete = $(this).data("autocomplete");

			if (autocomplete.selectedItem) {

				autocomplete._trigger("select", event, {
					item: autocomplete.selectedItem
				});

			}else {
				$(this).val('');
			}

		});

	}

	function GES_Calcul_Ligne(){
		var nbr_arrondi = 2;

		var lig_quantite = $("#facl_quantite").val();
		var lig_prix_unit_ht = Get_Input_DataValue("#facl_prix_unit_ht");
		var lig_taux_remise = $("#facl_remise_taux").val();
		var lig_prix_unitaire_net =(lig_prix_unit_ht-(lig_prix_unit_ht*(lig_taux_remise/100)));

		var lig_montant_ht = (lig_quantite * lig_prix_unitaire_net);
		var lig_taux_tva = 0; // Pas de tva pour les locations
		var lig_montant_tva = 0; // Pas de tva pour les locations
		var lig_prix_unitaire_ttc = (lig_prix_unitaire_net*((100+lig_taux_tva)/100));
		var lig_montant_ttc = (lig_montant_ht+lig_montant_tva);
		var lig_montant_remise = ((lig_prix_unit_ht-lig_prix_unitaire_net)*lig_quantite);

		Set_Input_Value("#facl_remise_montant",lig_montant_remise);
		Set_Input_Value("#facl_prix_unit_net",lig_prix_unitaire_net);
		Set_Input_Value("#facl_montant_ht",lig_montant_ht);
		Set_Input_Value("#facl_taux_tva",lig_taux_tva);
		Set_Input_Value("#facl_montant_tva",lig_montant_tva);
		Set_Input_Value("#facl_montant_ttc",lig_montant_ttc);
	}

	function GES_Calcul_Pied(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data_specific = {
			"id_piece": $("#record_id").val()
		}

		var data = { 
			"zone":"gl", 
			"action":"get_piece_pied",
			"data": {
				"facture": data_specific
			}
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=facture_calcul_pied",data_json, function(data){  
			
			$.each(data, function(key, value){  
				save_status = '';

				$("#fac_taux_remise").attr('value', value.fac_taux_remise);
				$("#fac_montant_remise").attr('value', value.fac_montant_remise);
				$("#fac_acompte").attr('value', value.fac_acompte);
				$("#fac_montant_ht").attr('value', value.fac_montant_ht);
				$("#fac_montant_ttc").attr('value', value.fac_montant_ttc);
				$("#fac_taux_remise").attr('value', value.fac_taux_remise);
				$("#fac_acompte").attr('value', value.fac_acompte);
				$("#fac_net_a_payer").attr('value', value.fac_net_a_payer);
			});

		}).done(function() {//success
		})
		.fail(function() { //error
			GES_Calcul_Pied();
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (save_status!='Failed'){
			}else{

				$.alert({
					title: 'Erreur',
					content: 'Erreur calcul pied',
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

	function Get_Facture_Lignes($id_piece,$id_bien,$id_locataire){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data = { 
		  "id_piece": $id_piece,
		  "id_bien": $id_bien,
		  "id_locataire": $id_locataire
		};

		var data = { 
			"zone":"gl", 
			"action":"facture",
			"data": {
			  "facture": data
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=genere_fac_lignes",data_json, function(data){  
		}).done(function() {//success
		   Display_Table_Lignes();
		   GES_Calcul_Pied();
		})
		.fail(function() { //error
			Get_Facture_Lignes();
		})
		.always(function() { //complete
		   $.LoadingOverlay("hide");

		   Display_Table_Lignes();
		   GES_Calcul_Pied();
		});

	}

	function Get_Address_Facturation($id_bien,$id_locataire){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data_address = { 
			"id_bien": $id_bien,
			"id_locataire": $id_locataire
		};

		var data = { 
			"zone":"gl", 
			"action":"get_adresse",
			"data": {
				"address": data_address
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=get_adresse_facturation",data_json, function(data){  

			$.each(data, function(key, value){ 
				var adresse_facturation = value.ad_adresse1+' '+value.ad_adresse2+' '+value.ad_adresse3+' '+value.ad_code_postal+' '+value.ad_ville;
				$("#fac_adresse_facturation").attr('value', adresse_facturation);
			});  
			
		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});  

	}

	function printFiche($selector) {
		var contents = $("#"+$selector).html();
		var frame1 = $('<iframe />');

		frame1[0].name = "frame1";
		frame1.css({ "position": "absolute", "top": "-1000000px" });

		$("body").append(frame1);
		var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
		frameDoc.document.open();

		//Create a new HTML document.
		frameDoc.document.write('<html moznomarginboxes mozdisallowselectionprint>');
		frameDoc.document.write('<link href="layouts/default/plugins/iw-print/print.css" rel="stylesheet" type="text/css" media="print"  />');
		frameDoc.document.write('</head><body>');

		//Append the external CSS file.
	   

		//Append the DIV contents.
		frameDoc.document.write(contents);
		frameDoc.document.write('</body></html>');
		frameDoc.document.close();

		setTimeout(function () {
			window.frames["frame1"].focus();
			window.frames["frame1"].print();

			frame1.remove();
		}, 500);
	}

	/*============================================================================================================================================*/

	var delay = ( function() {
	var timer = 0;
	return function(callback, ms) {
		clearTimeout (timer);
		timer = setTimeout(callback, ms);
	};
	})();

	margins = {
		top: 70,
		bottom: 40,
		left: 30,
		width: 995
	};

	generate = function(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		margins = {
			top: 200,
			bottom: 10,
			left: 10,
			width: 995
		};

		var element = document.getElementById('iw_print_content');

		console.log(element);

		var pdf = new jsPDF('p', 'pt', 'a4');
		pdf.setFontSize(10);
		pdf.fromHTML(element, 
			margins.left, // x coord
			margins.top,
			{},
			function(dispose) {
				headerFooterFormatting(pdf, pdf.internal.getNumberOfPages());
			}, 
			margins
		);

		setTimeout(function(){
			pdf.save('test.pdf');
			$.LoadingOverlay("hide");
		},2000);
	};
	
	function headerFooterFormatting(doc, totalPages){
		
		for(var i = totalPages; i >= 1; i--){
			doc.setPage(i);                            
			//header
			header(doc);
			
			footer(doc, i, totalPages);
			doc.page++;
		}
		
	};

	function header(doc){
		margins = {
			top: 10,
			bottom: 40,
			left: 10,
			width: 595
		};

		var header = document.getElementById('iw_print_header');

		doc.fromHTML(
			header, 
			margins.left, // x coord
			margins.top,{ // y coord
				width: margins.width// max width of content on PDF
			},
			function(dispose) {}, 
			margins
		);
	};

	// You could either use a function similar to this or pre convert an image with for example http://dopiaza.org/tools/datauri
	// http://stackoverflow.com/questions/6150289/how-to-convert-image-into-base64-string-using-javascript
	function imgToBase64(url, callback, imgVariable) {

		if (!window.FileReader) {
			callback(null);
			
			return;
		}
		
		var xhr = new XMLHttpRequest();
		xhr.responseType = 'blob';
		
		xhr.onload = function() {
			var reader = new FileReader();
			
			reader.onloadend = function() {
				imgVariable = reader.result.replace('text/xml', 'image/jpeg');
				callback(imgVariable);
			};
			reader.readAsDataURL(xhr.response);
		};
		xhr.open('GET', url);
		xhr.send();
	};

	function footer(doc, pageNumber, totalPages){
		var str = "Page " + pageNumber + " of " + totalPages

		doc.setFontSize(10);
		doc.text(str, margins.left, doc.internal.pageSize.height - 20);
	};
	/*============================================================================================================================================*/

	/*Impression*/
	function printChargeLines(lines){
		res = '';
		
		for (var i = 0; i < lines.length; i++) {
			res += '\
				<tr>\
					<td style="border-right: solid 1px black;padding: 10px;">'+lines[i]["FACL_Libelle"]+'</td>\
					<td style="border-right: solid 1px black;padding: 10px;">'+lines[i]["FACL_Quantite"]+'</td>\
					<td style="border-right: solid 1px black;padding: 10px;">'+lines[i]["FACL_Prix_Unit_TTC"]+'</td>\
					<td style="padding: 0px 10px;">'+lines[i]["FACL_Montant_TTC"]+'</td>\
				</tr>\
			';
		}
		return res;
	}

	function printLines(lines){
		res = '';
		
		for (var i = 0; i < lines.length; i++) {
			res += '\
				<tr>\
					<td style="padding: 10px;">'+lines[i]["FACL_Titre"]+'</td>\
					<td style="padding: 0px 10px;text-align:right;">'+lines[i]["FACL_Montant_TTC"]+'</td>\
				</tr>\
			';
		}
		return res;
	}

	function printReg(regs){
		res = '';
		
		for (var i = 0; i < regs.length; i++) {
			res += '\
				<tr>\
					<td style="padding: 10px;">'+regs[i]["REG_No_Piece"]+'</td>\
					<td style="padding: 10px;">'+regs[i]["REG_Mode_Reglement"]+'</td>\
					<td style="padding: 0px 10px;text-align:right;">'+regs[i]["REG_Montant"]+'€</td>\
				</tr>\
			';
		}

		return res;
	}

	function printInvoice(invoice_id){
		
		$.ajax({
			method: "POST",
			url: '/4DACTION/REST_facture_detail',
			data: {
				"fact_id": invoice_id,
				"provenance": buttonPrintInvoiceID_t
			}
		}).done(function(res) {
			
			if (res.useWriteProModel != null) {

				if (res.modele.length > 0) {
					var $option_t = "";

					res.modele.forEach(element => {
						$option_t += '<option value="' + element + '">' + element + '</option>'
					});

					bootbox.dialog('<div class="rowB"><div class="col-12"><div class="control-group"> <label class="control-label-group">Choix du modèle ?</label> <div class="controls "> <select id="choixModeleWritePro" name="choixModeleWritePro" class="fdp_span3">' + $option_t + '</select></div> </div></div></div>', [
						{
							"label" : "Valider",
							"class" : "btn-primary",
							"callback": function() {
				
								switch (true) {
									case ($("#choixModeleWritePro").val() != "") :
										WritePopup($("#choixModeleWritePro").val(), {"factureID": $("#record_id").val()});
										break;
									default:
				
										$.alert({
											title: '',
											content: "Aucun modèle sélectionné, veuillez recommencer votre sélection",
											icon: 'fa fa-error',
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
										break;
								};
				
							}
						},
						{
							"label" : "Annuler",
							"class" : "btn-danger",
							"callback": function() {
							}
						}
					]);

				}else{
					WritePopup("Quittance loyer", {"factureID": $("#record_id").val()});
				}
				
			}else{
				var invoice = res["facture"];
				var html = "";
				
				if (invoice["FAC_Type_Piece"] == "charge"){
					html = '\
						<div id="facture" style="padding: 150px 25px 25px 25px;width:100%;box-sizing: border-box;position: relative; font-size: 14px; line-height: 30px;float: left;font-family: sans-serif;">\
							<img src="/'+invoice["variables"]["strc_logo"]+'" style="position: absolute;top: 20px;left: 20px; width: 250px;">\
							<div style="position: absolute;top: 25px;right: 25px;">\
								<b style="font-size: 1.4em; color: #A9A9A9;">'+invoice["variables"]["txt_piece_titre"]+'</b>\
								<div style="font-size: 1.4em;">'+invoice["variables"]["txt_titre_ligne_1"]+'</div>\
							</div>\
							<div style="width: 55%;float: left;">\
								<b style="font-size: 1.3em;">'+invoice["variables"]["txt_strc_nom"]+'</b><br/>\
								'+invoice["variables"]["txt_strc_nom_suite"]+'<br/>\
								'+invoice["variables"]["txt_strc_adresse"]+'\
							</div>\
							<div style="width: 45%;float: left;">\
								<b style="font-size: 1.3em;">'+invoice["variables"]["txt_locataire_nom"]+'</b><br/>\
								'+invoice["adresse"]["AD_Adresse1"] + ((invoice["adresse"]["AD_Adresse2"] != "") ? "<br/>" : "") + '\
								'+invoice["adresse"]["AD_Adresse2"] + ((invoice["adresse"]["AD_Adresse3"] != "") ? "<br/>" : "") + '\
								'+invoice["adresse"]["AD_Adresse3"] + ((invoice["adresse"]["AD_Code_postal"] != "") ? "<br/>" : "") + '\
								'+invoice["adresse"]["AD_Code_postal"]+' '+invoice["adresse"]["AD_Ville"]+'\
							</div>\
							<div style="width: 100%;float: left;height: 40px;"></div>\
							<div style="width: 100%;float: left;font-weight: bold;">\
								BIEN LOUÉ : '+invoice["FAC_Bien_Nom"]+'\
							</div>\
							<div style="width: 100%;float: left;height: 10px;"></div>\
							<div style="width: 100%;float: left;font-weight: bold;">\
								PAIEMENT DE LA CONSOMMATION D\'ENERGIES ET EAU \
							</div>\
							<div style="width: 100%;float: left;">\
								<table style="width: 100%;border: solid 1px black;border-collapse: collapse;font-size: 14px;">\
									<thead>\
										<tr style="font-weight: bold;text-align: center;">\
											<th style="border-bottom: solid 1px black;padding: 10px; text-align: left;width: 60%;">Désignation</th>\
											<th style="border-bottom: solid 1px black;padding: 10px;">Quantité</th>\
											<th style="border-bottom: solid 1px black;padding: 10px;">P.U TTC</th>\
											<th style="border-bottom: solid 1px black;padding: 10px;">Montant</th>\
										</tr>\
									</thead>\
									<tbody>'+printChargeLines(invoice["lignes"])+'</tbody>\
								</table>\
							</div>\
							<div style="width: 60%;float: left;">\
								'+invoice["FAC_Notes"].replace(/(?:\r\n|\r|\n)/g, '<br>')+'\
							</div>\
							<div style="width: 40%;float: right;font-size: 1.2em;margin-top: 10px;">\
								<div style="width: 50%;float: left;">\
									Total TTC<br/>Solde dû<br/><b>Net à payer</b>\
								</div>\
								<div style="width: 50%;float: right;text-align: right;">\
									'+invoice["FAC_Montant_TTC"]+'€<br/>'+invoice["FAC_Solde_Du"]+'€<br/><b>'+invoice["FAC_Net_A_Payer"]+'€</b>\
								</div>\
							</div>\
						</div>\
						<div style="box-sizing: border-box;padding: 0px 25px;width: 100%;float: left;text-align: center;position: absolute; bottom: 0px; left: 0;font-size: 12px;font-family: sans-serif;">\
							<hr>\
							'+invoice["variables"]["txt_titre_ligne_8"]+'<br/>\
							'+invoice["variables"]["txt_titre_ligne_9"]+'<br/>\
							'+invoice["variables"]["txt_titre_ligne_10"]+'\
						</div>\
					';
				}else{
					html = '\
						<div id="facture" style="padding: 150px 25px 25px 25px;width:100%;box-sizing: border-box;position: relative; font-size: 14px; line-height: 30px;float: left;font-family: sans-serif;">\
							<img src="/'+invoice["variables"]["strc_logo"]+'" style="position: absolute;top: 20px;left: 20px; heigth: 150px;">\
							<div style="position: absolute;top: 25px;right: 25px;">\
								<b style="font-size: 1.4em; color: #A9A9A9;">'+invoice["variables"]["txt_piece_titre"]+'</b>\
								<div style="font-size: 1.4em;">'+invoice["variables"]["txt_titre_ligne_1"]+'</div>\
							</div>\
							<div style="width: 65%;float: left;">\
								<b style="font-size: 1.3em;">'+invoice["variables"]["txt_strc_nom"]+'</b><br/>\
								'+invoice["variables"]["txt_strc_nom_suite"]+'<br/>\
								'+invoice["variables"]["txt_strc_adresse"]+'<br/>\
								'+invoice["variables"]["txt_strc_cp_ville"]+'\
							</div>\
							<div style="width: 35%;float: left;text-align: left;">\
								<b style="font-size: 1.3em;">'+invoice["variables"]["txt_locataire_nom"]+'</b><br/>\
								'+invoice["adresse"]["AD_Adresse1"] + ((invoice["adresse"]["AD_Adresse2"] != "") ? "<br/>" : "") + '\
								'+invoice["adresse"]["AD_Adresse2"] + ((invoice["adresse"]["AD_Adresse3"] != "") ? "<br/>" : "") + '\
								'+invoice["adresse"]["AD_Adresse3"] + ((invoice["adresse"]["AD_Code_postal"] != "") ? "<br/>" : "") + '\
								'+invoice["adresse"]["AD_Code_postal"]+' '+invoice["adresse"]["AD_Ville"]+'\
							</div>\
							<div style="width: 100%;float: left;margin: 40px 0px 20px 0px;font-size: 1.3em;text-align:center;font-weight:bold;">PAIEMENT DE L\'HEBERGEMENT</div>\
							<div style="width: 100%;float: left;font-weight: bold;">\
								'+invoice["variables"]["periode"]+'\
							</div>\
							<div style="width: 100%;float: left;">\
								<table style="width: 100%;border: solid 1px black;border-collapse: collapse;font-size: 14px;">\
									<thead>\
										<tr style="text-align: center;">\
											<th colspan="2" style="font-weight: normal;border-bottom: solid 1px black;padding: 10px; text-align: left;">\
												<b>BIEN LOUÉ :</b> '+invoice["FAC_Bien_Nom"]+'\
											</th>\
										</tr>\
									</thead>\
									<tbody>\
										<tr>\
											<td style="padding: 10px;width: 40%;">'+invoice["variables"]["txt_reference"]+'<br/><br/>'+invoice["variables"]["txt_echeance_num"]+'</td>\
											<td style="padding: 10px;width: 60%;">\
												<table style="width: 100%;border-collapse: collapse;font-size: 1em;">\
													<thead>\
														<th style="padding: 10px;text-align: left;">Libellé</th>\
														<th style="padding: 10px;text-align: right;">Montant</th>\
													</thead>\
													<tbody>\
														'+printLines(invoice["lignes"])+'\
														<tr>\
															<td colspan="2" style="padding: 10px;border-top: solid 1px black;text-align: right;font-weight: bold;">\
																<div style="width: 100%;">\
																	<div style="width: 50%;float: left;">\
																		Total TTC<br/>Solde antérieur<br/>Net à payer\
																	</div>\
																	<div style="width: 50%;float: right;text-align: right;">\
																		'+invoice["FAC_Montant_TTC"]+'€<br/>'+invoice["FAC_Solde_Du_Facture_Precedente"]+'€<br/>'+invoice["FAC_Net_A_Payer"]+'€\
																	</div>\
																</div>\
															</td>\
														</tr>\
													</tbody>\
												</table>\
											</td>\
										</tr>\
									</tbody>\
								</table>\
							</div>\
							<div style="width: 100%;float: left;line-height: 20px;padding-top: 10px;">\
								'+invoice["FAC_Notes"].replace(/(?:\r\n|\r|\n)/g, '<br>')+'\
							</div>\
							<div style="width: 100%;float: left;font-weight: bold;">\
								Règlements de la facture\
							</div>\
							<div style="width: 100%;float: left;">\
								<table style="width: 100%;border: solid 1px black;border-collapse: collapse;font-size: 14px;">\
									<tbody>\
										<tr>\
											<td style="padding: 10px;width: 100%;">\
												<table style="width: 100%;border-collapse: collapse;font-size: 1em;">\
													<thead>\
														<th style="padding: 10px;text-align: left;">N° règlement</th>\
														<th style="padding: 10px;text-align: left;">Mode de règlement</th>\
														<th style="padding: 10px;text-align: right;">Montant</th>\
													</thead>\
													<tbody>\
														'+printReg(invoice["reglement"])+'\
													</tbody>\
												</table>\
											</td>\
										</tr>\
									</tbody>\
								</table>\
							</div>\
						</div>\
						<div style="box-sizing: border-box;width: 100%;float: left;position: absolute; bottom: 240px; left: 0;padding: 0;font-family: sans-serif;">\
							<img src="/layouts/default/images/cut.png" style="transform: rotate(68deg);width: 25px;position: absolute;left: 30px; top: -3px;">\
							<hr style="border: 1px dotted black;width: 100%;">\
						</div>\
						<div style="box-sizing: border-box;width: 100%;float: left;position: absolute; bottom: 80px; left: 0;padding: 0px 25px;font-family: sans-serif;">\
							<table style="width: 100%;border: solid 1px black;border-collapse: collapse;font-size: 14px;">\
								<thead>\
									<tr style="text-align: center;">\
										<th colspan="2" style="border-bottom: solid 1px black;padding: 10px; text-align: center;">\
											<b>PAPILLON A JOINDRE A VOTRE REGLEMENT</b>\
										</th>\
									</tr>\
								</thead>\
								<tbody>\
									<tr>\
										<td style="padding: 10px;">'
											+'Locataire : '+invoice["variables"]["txt_locataire_nom"]+
										'</td>\
										<td style="padding: 10px;">'
											+invoice["variables"]["periode"]+
										'</td>\
									</tr>\
									<tr>\
										<td style="padding: 10px;">'
											+invoice["variables"]["txt_reference"]+
										'</td>\
										<td style="padding: 10px;">'
											+invoice["variables"]["txt_echeance_paye"]+
										'</td>\
									</tr>\
									<tr>\
										<td style="padding: 10px;" colspan="2">'
											+'Bien loué : '+invoice["FAC_Bien_Nom"]+
										'</td>\
									</tr>\
								</tbody>\
							</table>\
						</div>\
						<div style="box-sizing: border-box;padding: 0px 25px;width: 100%;float: left;text-align: center;position: absolute; bottom: 0px; left: 0;font-size: 12px;font-family: sans-serif;">\
							<hr>\
							'+invoice["variables"]["txt_titre_ligne_8"]+'<br/>\
							'+invoice["variables"]["txt_titre_ligne_9"]+'<br/>\
							'+invoice["variables"]["txt_titre_ligne_10"]+'\
						</div>\
					';
				}
	
				printDiv(html, invoice["variables"]["txt_piece_titre"] + " " + invoice["variables"]["txt_locataire_nom"]);
			}

		});

	}

	function printDiv(text, name) {
		var contents = text;
		var prevTitle = document.title;
		
		document.title = name;
		
		var frame1 = $('<iframe />');
		
		frame1[0].name = "frame1";
		frame1.css({ "position": "absolute", "top": "-1000000px" });
		$("body").append(frame1);
		
		var frameDoc = frame1[0].contentWindow ? frame1[0].contentWindow : frame1[0].contentDocument.document ? frame1[0].contentDocument.document : frame1[0].contentDocument;
		
		frameDoc.document.open();
		//Create a new HTML document.
		frameDoc.document.write('<html moznomarginboxes mozdisallowselectionprint style="padding: 0; margin: 0;"><head>');
		frameDoc.document.write('<style type="text/css" media="print">@page {size: auto;margin: 0;}</style>');
		frameDoc.document.write('<title'+name+'</title>');
		frameDoc.document.write('</head><body style="padding: 0; margin: 0;">');

		//Append the external CSS file.
	   
		//Append the DIV contents.
		frameDoc.document.write(contents);
		frameDoc.document.write('</body></html>');
		frameDoc.document.close();
		
		setTimeout(function () {
			window.frames["frame1"].focus();

			// On supprime l'url du fichier imprimé
			var curURL = window.location.href;
			history.replaceState(history.state, '', '/');

			window.frames["frame1"].print();

			history.replaceState(history.state, '', curURL);
			frame1.remove();
		}, 500);

	}
	// /*end impression*/
});

$(document).ready(function(){
	$("#fac_modele").closest(".iw_div_half").after('<div class="control-group iw_div_half"><div id="btn_modele_zone"><label for="" class="fdp_width100 search "></label><img id="btn_suppr_modele" src="layouts/default/images/delete-modele.png" width="40" /><button id="btn_sauv_modele" class="fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne"><i class="fa fa-save"></i>Sauvegarder</button><button id="btn_nouveau_modele" class="fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne"><i class="fa fa-plus"></i>Ajouter un modèle</button></div></div>');

	$('#btn_sauv_modele').css('cssText', 'width: 110px !important');
	$('#btn_nouveau_modele').css('cssText', 'width: 135px !important');
	$('#fdp_piece_print_avis').css('cssText', 'width: 200px !important');

	$("#btn_suppr_modele").mouseover(function() {
		$('#btn_suppr_modele').css('cssText', 'cursor: pointer');
	});
	
	// Modifié par Scanu Rémy (22/03/2023) - Je ne vois pas l'intêret d'avoir cela
	//$("#fac_modele").after('<div id="zone_personnalisation_modele"></div>');

	$("#fac_modele").change(function(event){
		var $this = $(this);

		if ($this.val() == "") {
			$("#fac_notes").val("");
		}else{
	
			$.ajax({
				type: "GET",
				url: "/4DACTION/Web_Manage_Modele_Observation",
				data: {
					"intervenantID": $("#intervenantid").val(),
					"nomModele": $this.val(),
					"action": "obtenirContenu"
				},
				success: function (response) {
					var reponseParse = JSON.parse(response);

					if (reponseParse.etat == false) {
						alert(reponseParse.messageErreur);
					}else{
						$("#fac_notes").val(reponseParse.modeleContenue);
						disabledFirstChoiceInSelect("fac_modele");
					}
		
				}
			});
	
		}
	
	});

	$("#btn_nouveau_modele").click(function(event){
		event.preventDefault();
		$("#fac_modele").val("");

		$nomModele = prompt("Nom du modèle svp ?");

		if ($nomModele != "" && $("#fac_modele option[value='"+$nomModele+"']").length == 0) {
			$("#fac_notes").text("");

			$('#fac_modele').append('<option value="'+$nomModele+'">'+$nomModele+'</option>');
			$('#fac_modele').val($nomModele);

			disabledFirstChoiceInSelect("fac_modele");
		}else{

			if ($("#fac_modele option[value='"+$nomModele+"']").length != 0) {
				alert("Ajout impossible, un modèle existe déjà avec ce nom");
			}

		}

	});

	$("#btn_sauv_modele").click(function(event){
		event.preventDefault();

		var $nomModele = $("#fac_modele").val();

		if ($nomModele == "") {
			alert("Modification impossible, merci de sélectionner un modèle")
		}else{
			var $sauvModele = confirm("Voulez-vous vraiment sauvegarder le modèle qui porte le nom "+$nomModele+" ?")
			
			if ($sauvModele == true) {
				var contenuModele = $("#fac_notes").val();   
				var nbLigne = contenuModele.split(/\r|\r\n|\n/);

				if (nbLigne.length <= 5) {

					$.ajax({
						type: "GET",
						url: "/4DACTION/Web_Manage_Modele_Observation",
						data: {
							"intervenantID": $("#intervenantid").val(),
							"nomModele": $nomModele,
							"contenuModele": $("#fac_notes").val(),
							"action": "sauvegarder"
						},
						success: function (response) {
							var reponseParse = JSON.parse(response);
	
							if (reponseParse.etat == false) {
								alert(reponseParse.messageErreur);
							}else{
								alert("Le modèle d'observation a bien été sauvegardé !");
							}
							
						}
					});

				}else{
					alert("Sauvegarde du modèle impossible, 5 lignes max autorisées !")
				}
				
			}
		}

	});

	$("#btn_suppr_modele").click(function(event){
		event.preventDefault();

		var $nomModele = $("#fac_modele").val();

		if ($nomModele == "") {
			alert("Suppression impossible, merci de sélectionner un modèle")
		}else{
			var $supprModele = confirm("Voulez-vous vraiment supprimer le modèle qui porte le nom " + $nomModele + " ?")
			
			if ($supprModele == true) {

				$.ajax({
					type: "GET",
					url: "/4DACTION/Web_Manage_Modele_Observation",
					data: {
						"intervenantID": $("#intervenantid").val(),
						"nomModele": $nomModele,
						"action": "supprimer"
					},
					success: function (response) {
						var reponseParse = JSON.parse(response);

						if (reponseParse.etat == false) {
							alert(reponseParse.messageErreur);
						}else{
							alert("Le modèle d'observation a bien été supprimé !")

							$("#fac_modele option:selected").remove();
							$("#fac_modele").val("");
						}
						
					}
				});
				
			}
		}

	});
});