$(document).ready(function(){
	var url_base= window.location.origin;
	var var_tableliste_content = $('#list_table_factures_').html();

	var required_fields = '';

	var records_selected = [];
	var records_selected_biens = [];
	var records_selected_locataires = [];

	var factureID_c = [];

	var selected_month = '';
	var search_selected_month = '';
	var factures_ids_selection = '';

	var mandatory_fac_auto_ligne = $("#mandatory_fac_auto_ligne").val().split(';');
	var param_separation_charges = $("#param_separation_charges").val();

	//=================================================================//
	// Default dates
	//=================================================================// 
	var first_load = sessionStorage.getItem('first_load');
	var date_du_current = '';
	var date_au_current = '';

	if (first_load == 'true'){ 
		var date_current_object = new Date();

		date_du_current = date_current_object.format("dd/mm/yyyy");
		date_au_current = date_current_object.format("dd/mm/yyyy");
	}else{
		date_du_current = sessionStorage.getItem('session_date_du');
		date_au_current = sessionStorage.getItem('session_date_au');
	}

	//================================================================================================//
	// Factures à régler
	//================================================================================================//
    var ids_factures_imputes_values = '';

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//
	var sbajaxurl=url_base + '/GL?action=factures_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	if (userPreferences.liste == undefined) {
		var sortList = [1,1];
	}else{
		var sortList = JSON.parse(userPreferences.liste.facture.sortList);
	}

	$('#search_date_du').datepicker('update', date_du_current);
	$('#search_date_au').datepicker('update', date_au_current);

    $('#search_date_du').data("data-val");
    $('#search_date_du').data('data-val', date_du_current);
    $('#search_date_au').data("data-val");
    $('#search_date_au').data('data-val', date_au_current);

	$('#search_mois').datepicker({
		"format": "mm-yyyy",
		'startView': 1,
		'maxViewMode': 1
	}).on('changeMonth', function(e) {
		var dp = $(e.currentTarget).data('datepicker');

		dp.date = e.date;
		dp.setValue();
		dp.hide();

		search_selected_month = $('#search_mois').val();

		$("#search_date_du").val('');
		$("#search_date_au").val('');

		Table_Liste_Refresh();
	});

	$('.control-group .fa-calendar').click(function(){
		$('#search_mois').datepicker('show');
	});

	//=================================================================//
	// Search : Filters
	//=================================================================//
	$('#btn_left').off('click');
	$('#btn_left').off('dblclick');

	$('#btn_next').off('click');
	$('#btn_next').off('dblclick');

	$("#btn_left").click(function(ev){ 

		if ($('#search_date_du').val() == ''){
			var date = new Date();

			$('#search_date_du').datepicker('update', date.format("dd/mm/yyyy"));
			$('#search_date_au').datepicker('update', date.format("dd/mm/yyyy"));
		}

		var from = $('#search_date_du').val().split("/");
		var date = new Date(from[2], from[1] - 1, from[0]);

		date.setDate(date.getDate() - 1);

		$('#search_date_du').datepicker('update', date.format("dd/mm/yyyy"));
		$('#search_date_au').datepicker('update', date.format("dd/mm/yyyy"));

		Table_Liste_Refresh();

	  	sessionStorage.setItem('session_date_du', $('#search_date_du').val());
	    sessionStorage.setItem('session_date_au', $('#search_date_au').val());

	    return false;

	});   

	$("#btn_next").click(function(ev){ 

		if ($('#search_date_au').val() == ''){
			var date = new Date();

			$('#search_date_du').datepicker('update', date.format("dd/mm/yyyy"));
			$('#search_date_au').datepicker('update', date.format("dd/mm/yyyy"));
		}

		var from = $('#search_date_du').val().split("/");
		var date = new Date(from[2], from[1] - 1, from[0]);

		date.setDate(date.getDate() + 1);

		$('#search_date_du').datepicker('update', date.format("dd/mm/yyyy"));
		$('#search_date_au').datepicker('update', date.format("dd/mm/yyyy"));

        Table_Liste_Refresh();

	  	sessionStorage.setItem('session_date_du', $('#search_date_du').val());
	    sessionStorage.setItem('session_date_au', $('#search_date_au').val());

	    return false;
	}); 

	$("#btn_delete").click(function(ev){ 
		Delete_Selection();	
		return false;
	});

	$("#btn_new").click(function(ev){ 
		Nouvelle_Fiche(ev);
		return false;
	});

	$('body').on('click','#list_table_factures_ div', function(ev) {
		$('#id_selected').val(ev.target.id);

		// Lorsque le clic n'est pas sur le checkbox, on va sur l'enregistrement
		if (ev.target.id.indexOf('chx') == -1){

			if(ev.target.id != 0){
				$(location).attr('href', '/GL?action=facture&id='+ev.target.id);   
			}

		}
	});

	$(document).on('change', '.iw_select', function() {	
	    var id_locataire = $('#chk_locataire_id'+this.id.substring(4)).val();
	    var id_centre = $('#chk_bien_id'+this.id.substring(4)).val();

	    if (this.checked) {

			if (records_selected_locataires.length == 0){
			  records_selected_locataires.push($('#chk_locataire_id'+this.id.substring(4)).val());
			}

			if (records_selected_locataires.indexOf(id_locataire) != -1){
				records_selected.push($('#id'+this.id.substring(4)).val());
			}else{
				$(this).prop('checked', false); 
			}
			 
			Checkboxes_Manage(id_centre,id_locataire,false);
	    }else{
		    var index = records_selected.indexOf($('#id' + this.id.substring(4)).val());
			
		    records_selected.splice(index, 1);

		    if (records_selected.length == 0){
				var index = records_selected_locataires.indexOf($('#chk_locataire_id'+this.id.substring(4)).val());

				records_selected_locataires.splice(index, 1);
				Checkboxes_Manage(id_centre,id_locataire,true);
		    }
	    }

		ids_factures_imputes_values = '';
		var counter  = 1;

		for (var i of records_selected) {
			
			if (counter == 1){
                ids_factures_imputes_values = ids_factures_imputes_values + i;
			}else{
				ids_factures_imputes_values = ids_factures_imputes_values + ';' + i;
			}
            
            counter = counter + 1;
		}

		$('#records_selected').val(ids_factures_imputes_values);
	});
	
  	$("#btn_reset").click(function(ev){ 
		$('#list_table_factures_').trigger('filterResetSaved');

		$("#search_destinataire_id").val('');
		$("#search_date_du").val('');
		$("#search_date_au").val('');
		$("#search_mois").val('');
		$("#search_locataire_nom").val('');
		$("#search_export").val('');

	   	$('#list_table_factures_').trigger('updateHeaders');
		$("#list_table_factures_").trigger("update"); 

		sessionStorage.setItem('first_load', 'true');
		
		Trigger_Sort_Liste();
	    return false;
  	});  

    $('#btn_fac_auto').on('click', function () {
        FAC_Auto_Popup();

        return false;
    });

    $('#btn_fac_regler').on('click', function () {

    	if ($('#records_selected').val() != ''){

			$.confirm({
				title: 'Règlement',
				content: 'Vous êtes entrain de faire le réglement des factures sélectionnées, Voulez-vous générer le règlement d\'une manière automatique ou manuelle ?',
				icon: 'fa fa-warning',
				animation: 'scale',
				closeAnimation: 'zoom',
				columnClass: 'iw_alert',
				buttons: {
					confirm: {
						text: 'Manuel',
						btnClass: 'btn-orange',
						action: function () {
							$(location).attr('href', '/GL?action=reglement&records_selected=' + $('#records_selected').val());
						}
					},
					cancel: {
						text: 'Automatique',
						btnClass: 'btn-green',
						action: function () {
							Reglement_Automatique($('#records_selected').val());
						}
					}
				}
			});

    	}else{

	        $.alert({
	            title: 'Alerte',
	            content: 'Veuillez sélectionner une ou plusieurs factures à règler',
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

        return false;
    });

    $('#btn_avoir').on('click', function () {

    	if ($('#records_selected').val() != ''){

			$.confirm({
				title: 'Alerte',
				content: 'Vous êtes entrain de générer l\'avoir pour la facture sélectionnée. Voulez-vous continuer?',
				icon: 'fa fa-warning',
				animation: 'scale',
				closeAnimation: 'zoom',
				columnClass: 'iw_alert',
				buttons: {
					confirm: {
						text: 'Oui',
						btnClass: 'btn-orange',
						action: function () {
							Avoir_Automatique($('#records_selected').val());
						}
					},
					cancel: {
						text: 'Non',
						action: function () {
							
						
						}
					}
				}
			});

    	}else{

	        $.alert({
	            title: 'Alerte',
	            content: 'Veuillez sélectionner une facture',
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

        return false;
    });

    $('#btn_email').on('click', function () {

    	if ($('#records_selected').val()!= ''){

			$.confirm({
				title: 'Alerte',
				content: 'Vous êtes entrain d\'envoyer les factures sélectionnée par e-mail. Voulez-vous continuer?',
				icon: 'fa fa-warning',
				animation: 'scale',
				closeAnimation: 'zoom',
				columnClass: 'iw_alert',
				buttons: {
					confirm: {
						text: 'Oui',
						btnClass: 'btn-orange',
						action: function () {
							Envoi_Mail($('#records_selected').val());
						}
					},
					cancel: {
						text: 'Non',
						action: function () {
							
						
						}
					}
				}
			});

    	}else{

	        $.alert({
	            title: 'Alerte',
	            content: 'Veuillez sélectionner une facture',
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

        return false;
	});

    $('#btn_fac_export').on('click', function () {

    	if (factureID_c.length > 0){

			$.confirm({
				title: 'Export des factures',
				content: 'Vous êtes entrain de faire l\'export des factures sélectionnées, est-ce bien cela ?',
				icon: 'fa fa-warning',
				animation: 'scale',
				closeAnimation: 'zoom',
				columnClass: 'iw_alert',
				buttons: {
					confirm: {
						text: 'Confirmer',
						btnClass: 'btn-green',
						action: function () {
							$.LoadingOverlaySetup({
								background      : "rgba(0, 0, 0, 0.5)",
								imageColor      : "#fff"
							});
					
							$.LoadingOverlay("show");

							$.ajax({
								type: "GET",
								url: "/4DACTION/outilsWebDownloadFile",
								data: {
									"action": "exportFacture",
									"records": JSON.stringify(factureID_c)
								},
								success: function (response) {
									var reponseParse = JSON.parse(response);

									if (reponseParse.notificationError != null) {

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
										
									}else{
										downloadFile(reponseParse.url, reponseParse.fileName);
									}
									
									$.LoadingOverlay("hide");
								}
							});

						}
					},
					cancel: {
						text: 'Annuler',
						btnClass: 'btn-red'
					}
				}
			});

    	}else{

	        $.alert({
	            title: 'Alerte',
	            content: 'Aucune facture dans votre sélection',
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

        return false;
    });

	function Checkboxes_Manage($id_centre, $id_locataire, $init){

		$('input[type=checkbox]').each(function () {

			if (($id_locataire == $('#chk_locataire_id' + this.id.substring(4)).val()) && ($id_centre = $('#chk_bien_id' + this.id.substring(4)).val())){

			}else{
				$(this).prop('disabled', true); 
			}

			if ($init){
			  $(this).prop('disabled', false); 	
			}        

		});
	} 

	function Delete_Selection(){

		$.confirm({
			title: 'Facturation',
			content: 'Voulez-vous vraiment supprimer cette sélection des factures ?',
			icon: 'fa fa-warning',
			animation: 'scale',
			closeAnimation: 'zoom',
			columnClass: 'iw_alert',
			buttons: {
				confirm: {
					text: 'Oui',
					btnClass: 'btn-orange',
					action: function () {
						Delete_Selection_Exec();
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

	function Delete_Selection_Exec(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");
		
		// Correction bug sélection (toutes les factures de la page étaient envoyés à la suppression au lieu d'uniquement celles que l'utilisateur sélectionnées) par Scanu Rémy - remy@connect-io.fr
		/*var data_piece = {
		  "ids": factures_ids_selection
		}*/
		var data_piece = {
			"ids": $('#records_selected').val()
		  }

		var data = { 
			"zone":"gl", 
			"action":"set_facture",
			"data": data_piece
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status= '';

		$.getJSON("/GL?action=factures_selection_delete",data_json, function(data){  
		 
			$.each(data, function(key, value){ 
				save_status = value;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
	  		$.LoadingOverlay("hide");

			if (save_status != 'Failed'){

				if (save_status != '-2'){ 	
					location.reload();
				}else{
					$.alert({
						title: 'Erreur',
						content: 'Impossible d\'effectuer la suppression car la sélection contient des factures définitives.',
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

			}else{

				$.alert({
					title: 'Erreur',
					content: 'Impossible d\'effectuer la suppression car la sélection contient des factures définitives.',
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
	
	function Table_Liste_Refresh(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		//$("#list_table_factures_").html('').html(var_tableliste_content);

        $('#list_table_factures_').trigger('updateHeaders');
		$("#list_table_factures_").trigger("update"); 
	}
	
    function Facturation_Automatique($mois,$separation){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var today = new Date(Date.now());
		var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
		var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();


		var data_pointage = { 
		  "date_client": date,
		  "heure_client": time,
		  "fac_auto_mois": $mois,
		  "separation_charges": $separation
		};

		var data = { 
			"zone":"GL", 
			"action":"facturation_automatique",
			"data": {
				"facturation": data_pointage
			}
		};

		var save_status= '';

		var data_json = 'json='+JSON.stringify(data);

		$.getJSON("/GL?action=facturation_automatique",data_json, function(data){
			
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			var $message = 'Opération effectué avec succès : '+save_status+' factures générées.';
			var $title = 'Succès';

			if(save_status==1){
				$message = 'Opération effectué avec succès : '+save_status+' facture générée.';
			}

			if(save_status==0){ 
				$message = 'Pas de factures à générer pour le mois choisi.';
				$title = 'Alerte';
			}

			$.alert({
				title: $title,
				content: $message ,
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

			Trigger_Sort_Liste();
		});
    }

    function Avoir_Automatique($ids_selected){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data_tmp = { 
			"ids_factures": $ids_selected
		};

		var data = { 
			"zone":"GL", 
			"action":"avoir_genere",
			"data": {
				"facturation": data_tmp
			}
		};

		var save_status= '';

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=avoir_automatique",data_json, function(data){  
			
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {//success

		})
		.fail(function() { //error

		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
			$('#records_selected').val("");
			
			var $message = 'Opération effectué avec succès : '+save_status+' avoirs générés.';
			var $title = 'Succès';

			if (save_status == 1){
				$message = 'Opération effectué avec succès : '+save_status+' avoir généré.';
			}

			if (save_status == 0){
				$message = 'Erreur.';
				$title = 'Alerte';
			}

			if (save_status==-1){
				$message = 'Facture vérrouillée, veuillez réessayer plus tard.';
				$title = 'Alerte';
			}

			$.alert({
				title: $title,
				content: $message ,
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

			Trigger_Search_Liste();
		});
    }

    function Envoi_Mail($ids_selected){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});
  
		$.LoadingOverlay("show");

		var data_tmp = { 
		  "ids_factures": $ids_selected
		};

		var data = { 
			"zone":"GL", 
			"action":"fac_envoi_mail",
			"data": {
			  "facturation": data_tmp
			}
		};

		var save_status= '';
		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=fac_envoi_mail",data_json, function(data){  
		 
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {
		})
		.fail(function() {
		})
		.always(function() {
		   $.LoadingOverlay("hide");

		   var $message = 'Opération effectué avec succès : '+save_status+' factures envoyées.';
		   var $title = 'Succès';

			if (save_status == 1){
			   $message = 'Opération effectué avec succès : '+save_status+' facture envoyée.';
			}

			if (save_status == 0){
				$message = 'Erreur.';
				$title = 'Alerte';
			}

			$.alert({
				title: $title,
				content: $message ,
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
		});  

    }

    function Reglement_Automatique($ids_factures){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

	
		$.LoadingOverlay("show");

		var data_reglement = { 
			"ids_factures": $ids_factures
		};

		var data = { 
			"zone":"GL", 
			"action":"reglement_automatique",
			"data": {
				"reglement": data_reglement
			}
		};

		var save_status= '';
		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=reglement_automatique",data_json, function(data){  
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			var $message = 'Opération effectué avec succès : '+save_status+' factures réglées.';
			var $title = 'Succès';

			if (save_status == 1){
				$message = 'Opération effectué avec succès : '+save_status+' facture réglée.';
			}

			if (save_status == -1){
				$message = 'Le mode de règlement Prélèvement ou Chèque ne sont pas supporté en mode automatique.';
				$title = 'Alerte';
			}

			if (save_status == 0){
				$message = 'Erreur.';
				$title = 'Alerte';
			}

			$.alert({
				title: $title,
				content: $message ,
				icon: 'fa fa-check',
				animation: 'scale',
				closeAnimation: 'scale',
				columnClass: 'iw_alert',
				buttons: {
					okay: {
						text: 'Ok',
						btnClass: 'btn-blue',
						action: function () {
							$("#btn_dashboard_reglements").click();
						}
					}
				}
			});
			
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
			"action":"get_facture",
			"data": {
				"location": data_module
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=get_facture",data_json, function(data){  

			$.each(data, function(key, value){ 
				$("#bien_en_location").attr('value', value.loc_bien_name);
				$("#loc_bien_id").attr('value', value.loc_bien_id);
				$("#usager").attr('value', value.loc_usager_name);
				$("#loc_hb_id").attr('value', value.loc_hb_id);
				$("#loc_montant_initial").attr('value', iw_round(value.loc_montant_initial));
				$("#loc_montant_revise").attr('value', iw_round(value.loc_montant_revise));
				$("#loc_garantie_montant").attr('value', iw_round(value.loc_garantie_montant));

				UTL_Date_Picker_Formatted(value.loc_date,'#loc_date');	
				UTL_Date_Picker_Formatted(value.loc_date_entree,'#loc_date_entree');	
				UTL_Date_Picker_Formatted(value.loc_date_sortie,'#loc_date_sortie');	

				Init_Autocomplete('#usager','#loc_hb_id','GB','get_autocomplete_usagers');
				Init_Autocomplete('#bien_en_location','#loc_bien_id','GB','get_autocomplete_centres');

				if (value.loc_garantie_encaisse == 'True'){
					$( "#loc_garantie_encaisse" ).prop( "checked", true );
				}

				$("input[type='checkbox']").on('change', function(){
					$(this).val(this.checked ? "true" : "false");
				})
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

		var data_location = {
			"id": $("#id_selected").val(),
			"loc_date": $("#loc_date").val(),
			"loc_hb_id": $("#loc_hb_id").val(),
			"loc_bien_id": $("#loc_bien_id").val(),
			"irc_irl": $("#irc_irl").val(),
			"loc_montant_initial": $("#loc_montant_initial").val(),
			"loc_montant_revise": $("#loc_montant_revise").val(),
			"loc_date_entree": $("#loc_date_entree").val(),
			"loc_date_sortie": $("#loc_date_sortie").val(),
			"loc_garantie_montant": $("#loc_garantie_montant").val(),
			"loc_garantie_encaisse": $("#loc_garantie_encaisse").val()		  
		}

		var data = { 
			"zone":"gl", 
			"action":"set_location",
			"data": {
				"location": data_location
			}
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status= '';

		$.getJSON("/GL?action=location_fiche_valider",data_json, function(data){  
			
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (save_status != 'Failed'){
				Recalculer_IRL();
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

	function Nouvelle_Fiche(){
	   $(location).attr('href', '/GL?action=facture');
	}

	function Display_Table_List(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});
 
		$.LoadingOverlay("show");

		var data_specific = {
			"search_date": $("#search_date").val(),
			"search_destinataire": $("#search_destinataire_id").val()
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_factures",
			"data": data_specific
		};
			
		var data_json = '&json=' + JSON.stringify(data_search);
			
		$.getJSON("/GL?action=factures_list_json",data_json, function(data){  
			
			$('#list_table .table').empty();

			var resp_table_data = '';

				resp_table_data += '<div class="row header">';
				resp_table_data += '<div class="cell" style="min-width:30px;text-align:left;">';
				resp_table_data += '';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell" style="min-width: 120px;">';
				resp_table_data += 'N° de pièce';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell iw_second_column" style="min-width: 100px;">';
				resp_table_data += 'Date';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell " style="min-width: 120px;">';
				resp_table_data += 'Bien';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell " style="min-width: 120px;">';
				resp_table_data += 'Locataire';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell" style="min-width: 120px;">';
				resp_table_data += 'Montant TTC';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell" style="min-width: 100px;">';
				resp_table_data += 'Solde dû';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell" style="min-width: 100px;">';
				resp_table_data += 'Échéance';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell" style="min-width: 100px;">';
				resp_table_data += 'Période';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell" style="min-width: 100px;">';
				resp_table_data += 'Type';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell" style="min-width: 100px;">';
				resp_table_data += 'Réglée';
				resp_table_data += '</div>';
				resp_table_data += '</div>'; 
			
			if (data.length > 0){
				var css_class_row = '';
				var counter = 0;
				var chx_disabled = '';

				$.each(data, function(key, value){  
					css_class_row= '';

					if (counter % 2 != 0){
						css_class_row += ' iw-alternate';
					}

					chx_disabled= ''; 

					if (value.fac_no_piece == ''){
						chx_disabled = 'disabled';
					}

					if (iw_round(value.fac_solde_du) == 0){
						chx_disabled = 'disabled';
					}

					resp_table_data += '<div class="row body '+css_class_row+'">';
					resp_table_data += '<div class="cell " id="'+ value.id +'" >';

					if ((value.fac_type != 'Avoir') && (value.fac_avoir_id == 0)){
						resp_table_data += '<input type="checkbox" id="chx_'+ value.id +'" name="chx_'+ value.id +'" '+chx_disabled+' class="iw_select" style="text-align:left;margin:0px 5px 0px 0px;">'
					}
					
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+ value.id +'">';
					resp_table_data += value.fac_no_piece;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell  " id="'+ value.id +'">';
					resp_table_data += Get_Date_Formatted(value.fac_date);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+ value.id +'">';
					resp_table_data += value.fac_bien_nom;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+ value.id +'">';
					resp_table_data += value.fac_locataire_nom;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+ value.id +'">';
					resp_table_data += iw_round(value.fac_montant_ttc);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+ value.id +'">';
					resp_table_data += iw_round(value.fac_solde_du);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+ value.id +'">';
					resp_table_data += Get_Date_Formatted(value.fac_date_echeance);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+ value.id +'">';
					resp_table_data += value.fac_periode;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+ value.id +'">';
					resp_table_data += value.fac_type;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="'+ value.id +'">';

					if ((value.fac_type!='Avoir') && (value.fac_avoir_id==0)){

						if ((value.fac_solde_du == 0) && (value.fac_type == 'Définitive')){
							resp_table_data += '<i class="fa fa-check-square-o fdp-icon-green"></i>';
						}else{
							resp_table_data += '<i class="fa fa-times fdp-icon-red"></i>';
						}  
					}

					resp_table_data += '</div>';
					resp_table_data += '</div>';

					$('<input>', {
						type: 'hidden',
						id: 'id'+value.id,
						name: 'id'+value.id,
						value: value.id
					}).appendTo('#list_table');

					$('<input>', {
						type: 'hidden',
						id: 'chk_bien_id'+value.id,
						name: 'chk_bien_id'+value.id,
						value: value.fac_bien_id
					}).appendTo('#list_table');

					$('<input>', {
						type: 'hidden',
						id: 'chk_locataire_id'+value.id,
						name: 'chk_locataire_id'+value.id,
						value: value.fac_locataire_id
					}).appendTo('#list_table');

					counter = counter + 1;
				});  

			}

			$("#list_table .table").append(resp_table_data); 
		}).done(function() {//success
		})
		.fail(function() { //error
			Display_Table_List();
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
	}

	function FAC_Auto_Popup(){
		$('#titre_popup').html('Facturation automatique');
		var var_popup = $('#iw_form_popup').html();

		$('#iw_form_popup').html('');

		$.confirm({
			title: '',
			content: '' +
			'<div>' +var_popup+     
			'</div>',
			buttons: {
				formSubmit: {
					text: 'Lancer',
					btnClass: 'btn-blue',
					action: function () {
						
						if (Check_Required_Fields(mandatory_fac_auto_ligne)){
							Mark_All_Required_Fields(mandatory_fac_auto_ligne);

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

							$.confirm({
								title: 'Facturation automatique',
								content: 'Vous êtes entrain de lancer la facturation automatique pour le mois choisi, Voulez-vous continuer ?',
								icon: 'fa fa-warning',
								animation: 'scale',
								closeAnimation: 'zoom',
								columnClass: 'iw_alert',
								buttons: {
									confirm: {
										text: 'Oui',
										btnClass: 'btn-orange',
										action: function () {
											Facturation_Automatique(selected_month,param_separation_charges);
										}
									},
									Non: {
										text: 'Non',
										action: function () {
										
										}
									}
								
								}
							});

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
					jc.$$formSubmit.trigger('click');
				});

				$('#fac_auto_mois').datepicker({
					"format": "mm-yyyy",
					'startView': 1,
					'maxViewMode': 1
				}).on('changeMonth', function(e) {
					var dp = $(e.currentTarget).data('datepicker');
					dp.date = e.date;
					dp.setValue();
					dp.hide();
					selected_month = $('#fac_auto_mois').val();
				});

				$('.control-group .fa-calendar').click(function(){
					$('#fac_auto_mois').datepicker('show');
				});
			}
		});
	}

	function Init_DataTable_Liste(){

		var $table = $("#list_table_factures_").tablesorter({
		    theme: 'blue',
			widthFixed: true,
			sortLocaleCompare: true, 
			sortList: [ sortList ],
			widgets: [ 'filter'],
			widgetOptions : {
				filter_reset : '.fdp-btn-red',
				filter_saveFilters : true,
				filter_external : 'search'
			},
			headers: { 
				0: { 
					sorter: false,
					filter: false 
				}
			} 
		})

		.tablesorterPager({
			container: $(".pager"),
			ajaxUrl : sbajaxurl,
		
			customAjaxUrl: function(table, url) {
				$(table).trigger('changingUrl', url);
				return url;
			},

			ajaxError: null,

			ajaxObject: {
				dataType: 'json'
			},

			ajaxProcessing: function(data){

				$.LoadingOverlaySetup({
					background      : "rgba(0, 0, 0, 0.5)",
					imageColor      : "#fff"
				});

				$.LoadingOverlay("show");
					
				if (data && data.hasOwnProperty('rows')) {
					var indx, r, row, c, d = data.rows,
					
					total = data.total_rows,
					
					headers = data.headers,
					headerXref = headers.join(',').replace(/\s+/g,'').split(','),
					
					rows = [],
					total_row = [],
					
					len = d.length;
					
					for ( r=0; r < len; r++ ) {
						row = []; 
						
						for ( c in d[r] ) {

							if (typeof(c) === "string") {
								indx = $.inArray( c, headerXref );

								var stripped = d[r][c].replace(/<\/?[^>]+(>|$)/g, "").replace(",",".");
								var float = parseFloat(stripped);

								if (indx >= 0) {
									row[indx] = d[r][c];

									if (/^\-?\d*\.?\d+$/.test(stripped) && !isNaN(float)) {
										total_row[indx] = ((total_row[indx]) ? total_row[indx] : 0) + float;
									}else {
										total_row[indx] = "";
									}
								}
								
								if (indx == 0){
									total_row[indx] = "Total";
								}
							}
							
						}

						rows.push(row); 
					}

					var total_row_parsed = total_row.map(function(elem) { 

						if (elem != "Total" && elem != ""){
							elem = "<span class='text-right d-block'>" + elem.toLocaleString("fr",{maximumFractionDigits: 2})+"&nbsp;€</span>";
						}

						return elem;
					});

					rows.push(total_row_parsed);
					factureID_c = data.factureID;

					return [ total, rows, headers ];
				}
			},

			processAjaxOnInit: true,
			output: '{startRow} to {endRow} ({totalRows})',
			updateArrows: true,
			page: 0,
			size: 100,
			savePages: true,
			storageKey: 'tablesorter-pager',
			pageReset: 0,
			fixedHeight: false,
			removeRows: false,
			countChildRows: false,
			cssNext        : '.fa-angle-right', 
			cssPrev        : '.fa-angle-left',  
			cssFirst       : '.fa-angle-double-left',
			cssLast        : '.fa-angle-double-right',  
			cssGoto        : '.gotoPage',
			cssPageDisplay : '.pagedisplay',
			cssPageSize    : '.pagesize', 
			cssDisabled    : 'disabled',
			cssErrorRow    : 'tablesorter-errorRow'
		});

		$.tablesorter.filter.bindSearch( $table, $('.search') );
		
		// Si changement dans un des filtres, on exécute la recherche
		$('.search').change(function(){
			if ($(this).attr("name") == "search_type_facture") {
				var type = [];
	
				currentFilters = $.tablesorter.getFilters($table);
	
				$("input:checkbox").each(function() {
	
					if ($(this).is(':checked') == true) {
						type.push($(this).val());
					}
	
				});

				console.log(currentFilters);
				console.log(type);
	
				currentFilters[5] = type.join('|');

				console.log(currentFilters);
	
				$.tablesorter.setFilters($table, currentFilters);
			}

			//$("#list_table_factures_").html('').html(var_tableliste_content);

			$('#list_table_factures_').trigger('updateHeaders');
			$("#list_table_factures_").trigger("update");

			// modify the search input data-column value (swap "0" or "all in this demo)
			$('.selectable').attr( 'data-column', $(this).val() );

			$('.checkbox-input').each(function(index){

				switch (index) {
					case 1:
						$(this).val("Avoir");
		
						break;
					default:
						$(this).val("Facture");
		
						break;
				}
		
			});
		});
		
		//assign the sortStart event
		$("table").bind("sortStart",function() {

			$.LoadingOverlaySetup({
				background      : "rgba(0, 0, 0, 0.5)",
				imageColor      : "#fff"
			});
			
			$.LoadingOverlay("show");
		}).bind("sortEnd",function() {
			$.LoadingOverlay("hide");
		}); 

		$('table').bind('filterStart', function(event, filters) {
		});

		$("table").bind('updateComplete', function(e, table) {
			$.LoadingOverlay("hide");
		});

		//************
		var $url = $('#url');

		$('table')
		.on('changingUrl', function(e, url){
			$url.html(url);

			$.LoadingOverlaySetup({
				background      : "rgba(0, 0, 0, 0.5)",
				imageColor      : "#fff"
			});
		})
		.on('pagerInitialized', function(){
			this.config.serverSideSorting = false;
			$('#origurl').html( this.config.pager.ajaxUrl.replace(/(\{.*?\})/g, '<span class="results">$1</span>'));

			var first_load = sessionStorage.getItem('first_load');

			if (first_load == 'true'){ 
				Trigger_Search_Liste();
			}

			sessionStorage.setItem('first_load', 'false');
		});

		$table.on('pagerComplete', function(){
			$.LoadingOverlay("hide");
			$('#list_table_factures_ tr:last td').css('color','white').css('background-color','#0d72b9');

			// les ids des factures (selection)
			factures_ids_selection = '';

			$('input[type=hidden]').each(function(){

				if (this.id.startsWith('id_selection_')){
					factures_ids_selection = factures_ids_selection + ';' + $(this).val();  				
				}

			});
		});

		$table.on('filterInit', function(){
		}); 
  	}
	
	function Trigger_Search_Liste(){
	  	sessionStorage.setItem('session_date_du', $('#search_date_du').val());
	    sessionStorage.setItem('session_date_au', $('#search_date_au').val());

        date_du_current = sessionStorage.getItem('session_date_du');
        date_au_current = sessionStorage.getItem('session_date_au');

		//$("#list_table_factures_").html('').html(var_tableliste_content);
        
		$('#list_table_factures_').trigger('updateHeaders');
		$("#list_table_factures_").trigger("update"); 

		var columns = [];

		columns[1] = date_du_current; 
		columns[2] = date_au_current; 

		$('#list_table_factures_').trigger('search', [ columns ]);
	}

	function Trigger_Sort_Liste(){
		$("#list_table_factures_").trigger("update"); 

		var sorting = [ sortList ]; 
		$("#list_table_factures_").trigger("sorton",[sorting]); 
	}

	function addStyleAttribute($element, styleAttribute) {
		$element.attr('style', $element.attr('style') + '; ' + styleAttribute);
	}

	Init_DataTable_Liste();
	Trigger_Sort_Liste();
	Init_Autocomplete('#search_destinataire','#search_destinataire_id','GB','get_autocomplete_centres');

	// Ajout conservation tri du tableau par Scanu Rémy - remy@connect-io.fr
	$("#list_table_factures_ th").click(function() {
		var $column = parseInt($(this).attr("data-column"));
		var $sort = $(this).attr("aria-sort");
		var $sortNumber = 0;

		if ($sort == "ascending") {
			$sortNumber = 1;
		}

		$.ajax({
			type: "GET",
			url: "/4DACTION/Web_Manage_User_Preferences",
			data: {
			   "intervenantID": intervenantID,
			   "action": "sauvegarder",
			   "propriete": "liste.facture.sortList",
			   "valeur": JSON.stringify([$column,$sortNumber])
			},
			success: function (response) {
			}
		});

	});  
	
	// On masque le bouton "+ Nouvelle facture"
	$("#btn_new").hide();

	// Un peu de mise en forme
	$(".checkbox_list-label").remove();
	$('.checkbox-input--services').css('cssText', 'margin: 0px 0px 0px 20px!important');

	$('.fdp-border').css('cssText', 'padding: 0.6rem 0.75rem 0.6rem 0.75rem!important; border-radius: 0px!important');
	$('.fdp-border > ul').css('cssText', 'margin: 0px!important');
	$('.fdp-border > ul > li').css('cssText', 'display: inline-block; line-height: 0px');
	$('.fdp-border > ul > li > label').css('cssText', 'margin: 0px!important; line-height: normal');
	$('.fdp-border > ul > li > label > input').css('cssText', 'position: initial!important; margin: 0px 0px 0px 20px!important');

	$('.checkbox-span').css('cssText', 'padding: 0px!important');

	$('.checkbox-input').each(function(index){

		switch (index) {
			case 1:
				$(this).val("Avoir");

				break;
			default:
				$(this).val("Facture");
				break;
		}

	});
});  