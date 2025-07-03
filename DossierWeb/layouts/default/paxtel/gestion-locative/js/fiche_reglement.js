$(document).ready(function(){  
	var mandatory_fields = $("#mandatory").val().split(';'); 

	Mark_All_Required_Fields_Default(mandatory_fields);

	Init_Autocomplete('#reg_bien_nom','#reg_bien_id','GB','get_autocomplete_centres');
	Init_Autocomplete_Locataires('#reg_locataire_nom','#reg_locataire_id','GB','get_autocomplete_loc_locataires','#reg_bien_id');

	// Modifié par Scanu Rémy - remy@connect-io.fr
	//$('#reg_date_piece').datepicker('update', "");

	$("#fdp_piece_print").click(function(ev){ 
		Print_Piece()
 
		return false;
	});  

	$("#fdp_piece_delete").click(function(ev){ 
		Delete_Piece();
			
		return false;
	});  

	function Delete_Piece(){

		$.confirm({
			title: 'Règlement',
			content: 'Voulez-vous vraiment supprimer ce règlement ?',
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
				"reglement": data_piece
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		var save_status='';

		$.getJSON("/GL?action=reglement_delete",data_json, function(data){  
			
			$.each(data, function(key, value){  
				save_status = value;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			switch (save_status) {
				case "Failed":
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

					break;
				case "RecordLocked":

					$.alert({
						title: 'Erreur',
						content: 'Impossible de supprimer le réglement, mais les factures qui lui sont associées ont bien leurs valeurs remises à l\'état où elles étaient avant qu\'on applique le réglement. Celui-ci est verouillé sur le serveur, veuillez contacter le support technique.',
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
					
					break;
				default:
					$(location).attr('href', '/GL?action=reglements');

					break;
			}

		});  

	}

	$("#fdp_piece_valider").click(function(ev){ 
		Save_Piece_Reglement();
		
		return false;
	});  

	$("#fdp_piece_quitter").click(function(ev){ 

	$(location).attr('href', '/GL?action=reglements');

	return false;

	});  

	if ($("#reg_nopiece").val()==''){
		Display_Table_List_Factures_NS();
	}else{
		Display_Table_List_Factures_Regles(); 
	}

	$('#reg_locataire_id').bind("change", function() {
		Display_Table_List_Factures_NS();
	});
				
	$("#list_table_factures_ns div").click(function(ev){ 
		$('#id_selected').val(ev.target.id);
	});  

	function Display_Table_List_Factures_NS(){
		$('#iw_titre_lignes_1').html('FACTURES NON SOLDÉES');

		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$('#list_table_factures_ns .table').empty();

		var data_specific = {
			"search_date": '',
			"search_bien_id": $("#reg_bien_id").val(),
			"search_locataire_id": $("#reg_locataire_id").val(),
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
			resp_table_data +='<div class="cell" style="min-width:30px;text-align:left;">';
			resp_table_data +='';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='N° de pièce';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell iw_second_column" style="min-width: 100px;">';
			resp_table_data +='Date';
			resp_table_data +='</div>';


			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Bien loué';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Locataire';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Propriétaire';
			resp_table_data +='</div>';

			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Montant TTC';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 100px;">';
			resp_table_data +='Solde due';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 100px;">';
			resp_table_data +='Total réglé';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 100px;">';
			resp_table_data +='Échéance';
			resp_table_data +='</div>';
			resp_table_data +='</div>'; 
		
			if(data.length>0){
		
			
			var css_class_row='';
			var counter = 0;
			var checked_status='';

			
			$.each(data, function(key, value){  


				css_class_row='';

				if(counter % 2 != 0){
						css_class_row+=' iw-alternate';
				}

				checked_status='';

				if($('#reg_origine_ids').val().indexOf(value.id) != -1){
					checked_status='checked';
				}



				resp_table_data +='<div class="row body '+css_class_row+'">';
				resp_table_data +='<div class="cell " id="'+value.id+'" >';
				resp_table_data +='<input type="checkbox" id="chx_'+value.id+'" name="chx_'+value.id+'" '+checked_status+' class="iw_select" style="text-align:left;margin:0px 5px 0px 0px;">'
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell " id="'+value.id+'">';
				resp_table_data += value.fac_no_piece;
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell  " id="'+value.id+'">';
				resp_table_data +=Get_Date_Formatted(value.fac_date);
				resp_table_data +='</div>';


				resp_table_data +='<div class="cell " id="'+value.id+'">';
				resp_table_data += value.fac_bien_nom;
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell " id="'+value.id+'">';
				resp_table_data += value.fac_locataire_nom;
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell " id="'+value.id+'">';
				resp_table_data += value.fac_proprietaire_nom;
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

				if ($('#id'+value.id).length) {
					$('#id'+value.id).remove();
				} 

				$('<input>', {
					type: 'hidden',
					id: 'id'+value.id,
					name: 'id'+value.id,
					value: value.id
				}).appendTo('#list_table_factures_ns');

				if ($('#factue_piece_'+value.id).length) {
					$('#factue_piece_'+value.id).remove();
				} 

				$('<input>', {
					type: 'hidden',
					id: 'factue_piece_'+value.id,
					name: 'factue_piece_'+value.id,
					value: value.fac_no_piece
				}).appendTo('#list_table_factures_ns');

				if ($('#factue_montant_'+value.id).length) {
					$('#factue_montant_'+value.id).remove();
				}

				$('<input>', {
					type: 'hidden',
					id: 'factue_montant_'+value.id,
					name: 'factue_montant_'+value.id,
					value: (parseFloat(value.fac_solde_du.replace(",", ".")) + parseFloat(value.fac_montant_ttc.replace(",", "."))).toString().replace(".", ",")
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

	function Display_Table_List_Factures_Regles(){
		$('#iw_titre_lignes_1').html('FACTURES RÉGLÉES');

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
			"search_type": 'reglées',
			"search_reglement_id": $("#record_id").val()
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
				resp_table_data +='Date';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 120px;">';
				resp_table_data +='Bien loué';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 120px;">';
				resp_table_data +='Locataire';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 120px;">';
				resp_table_data +='Propriétaire';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 120px;">';
				resp_table_data +='Montant TTC';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 100px;">';
				resp_table_data +='Reste à payer';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 100px;">';
				resp_table_data +='Total réglé';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 100px;">';
				resp_table_data +='Échéance';
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
					resp_table_data += value.fac_no_piece;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell  " id="'+value.id+'">';
					resp_table_data +=Get_Date_Formatted(value.fac_date);
					resp_table_data +='</div>';

					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data += value.fac_bien_nom;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data += value.fac_locataire_nom;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data += value.fac_proprietaire_nom;
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

					if ($('#id'+value.id).length) {
						$('#id'+value.id).remove();
					} 

					$('<input>', {
						type: 'hidden',
						id: 'id'+value.id,
						name: 'id'+value.id,
						value: value.id
					}).appendTo('#list_table_factures_ns');

					if ($('#factue_piece_'+value.id).length) {
						$('#factue_piece_'+value.id).remove();
					} 

					$('<input>', {
						type: 'hidden',
						id: 'factue_piece_'+value.id,
						name: 'factue_piece_'+value.id,
						value: value.fac_no_piece
					}).appendTo('#list_table_factures_ns');

					if ($('#factue_montant_'+value.id).length) {
						$('#factue_montant_'+value.id).remove();
					} 

					$('<input>', {
						type: 'hidden',
						id: 'factue_montant_'+value.id,
						name: 'factue_montant_'+value.id,
						value: value.fac_solde_du
					}).appendTo('#list_table_factures_ns');

					counter = counter + 1;
				});  

			}

			$("#list_table_factures_ns .table").append(resp_table_data); 
		}).done(function() {//success

		})
		.fail(function() { //error
			Display_Table_List_Factures_Regles();
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

	function Save_Piece_Reglement(){

		if (Check_Required_Fields(mandatory_fields)){
			Mark_All_Required_Fields(mandatory_fields);

			var msg_text='';

			if (($("#ids_factures_putes").val()=='')&&($("#reg_bien_id").val()!='0')&&($("#reg_locataire_id").val()!="0") && ($("#reg_montant").val()!="0")){
				msg_text='Veuillez sélectionner la facture à régler';
			}else{
				msg_text='Vous devez remplir tous les champs obligatoires!';
			}

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
				"reg_destinataire_id": $("#reg_destinataire_id").val(),
				"reg_destinataire_nom": $("#reg_destinataire_nom").val(),
				"reg_type_destinataire": $("#reg_type_destinataire").val(),
				"reg_no_reglement": $("#reg_no_reglement").val(),
				"reg_date_piece": $("#reg_date_piece").val(),
				"reg_mode_reglement": $("#reg_mode_reglement").val(),
				"reg_montant": $("#reg_montant").val(),
				"reg_origine_id": $("#id_selected").val(),
				"reg_date_echeance": $("#reg_date_echeance").val(),
				"reg_notes": $("#reg_notes").val(),
				"reg_bqe_nom": $("#reg_bqe_nom").val(),
				"reg_no_piece": $("#reg_no_piece").val(),
				"reg_origine_ids": $("#ids_factures_putes").val(),
				"reg_bien_id": $("#reg_bien_id").val(),
				"reg_bien_nom": $("#reg_bien_nom").val(),
				"reg_locataire_nom": $("#reg_locataire_nom").val(),
				"reg_locataire_id": $("#reg_locataire_id").val()   
			}

			var data = { 
				"zone":"gl", 
				"action":"set_reglement",
				"data": {
					"reglement": data_piece
				}
			};

			var data_json = '&json='+JSON.stringify(data);
			var save_status='';

			$.getJSON("/GL?action=reglement_valider",data_json, function(data){  
				

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

					$(location).attr('href', '/GL?action=reglement&id='+$("#record_id").val());
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

	/*Impression*/
	function Print_Piece(){
		printInvoice($("#record_id").val());
	}
	
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
					<td style="padding: 10px;">'+lines[i]["FACL_Libelle"]+'</td>\
					<td style="padding: 0px 10px;text-align:right;">'+lines[i]["FACL_Montant_TTC"]+'</td>\
				</tr>\
			';
		}
		return res;
	}

	function printInvoice(invoice_id){
		
		$.ajax({
			method: "POST",
			url: '/4DACTION/REST_reglement_detail',
			data: {"regl_id": invoice_id}
		}).done(function(res) {
			var invoice = res["reglement"];
			var html = "";
			
			html = '\
				<div id="reglement" style="padding: 150px 25px 25px 25px;width:100%;box-sizing: border-box;position: relative; font-size: 14px;float: left;font-family: sans-serif;">\
					<img src="/'+invoice["variables"]["strc_logo"]+'" style="position: absolute;top: 20px;left: 20px; heigth: 150px;">\
					<div style="width: 55%;float: left;">\
						<b style="font-size: 1.3em;">'+invoice["variables"]["txt_strc_nom"]+'</b><br/>\
						'+invoice["variables"]["txt_strc_nom_suite"]+'<br/>\
						'+invoice["variables"]["txt_strc_adresse"]+'<br/>\
						Tel : '+invoice["variables"]["txt_strc_telephone"]+'<br/>\
						Email : '+invoice["variables"]["txt_strc_email"]+'\
					</div>\
					<div style="width: 40%;float: right;text-align: left;">\
						<span style="font-size: 1.3em; 100%;">Locataire</span><br/>\
						<b style="font-size: 1.3em;">'+invoice["variables"]["txt_locataire_nom"]+'</b>\
					</div>\
					<div style="width: 100%;float: left;font-size: 1.3em;text-align:center;font-weight:bold; margin-top: 20px; margin-bottom: 50px;">Reçu de règlement<br/></div>\
					<div style="width: 100%;float: center;">\
						<table style="width: 100%;border: solid 1px black;border-collapse: collapse;font-size: 14px;">\
							<tbody>\
								<tr>\
									<td style="padding: 10px;width: 100%;">\
										Reçu la somme de : '+invoice["variables"]["txt_reg_montant"]+'<br/><br/>\
										le : '+invoice["variables"]["txt_reg_date"]+'<br/><br/><br/><br/>\
										pour loyer et accessoires des locaux sis à :<br/>\
										'+invoice["variables"]["txt_centre_adresse1"]+'<br/>\
										'+invoice["variables"]["txt_centre_adresse2"]+'<br/>\
										'+invoice["variables"]["txt_centre_adresse3"]+'<br/>\
										'+invoice["variables"]["txt_centre_cp_ville"]+'<br/><br/>\
										Fait à '+invoice["variables"]["strc_ville"]+' le '+invoice["variables"]["txt_date_jour"]+'<br/><br/>\
										<b><u>Signature du bailleur</u></b><br/><br/><br/><br/><br/><br/><br/><br/>\
									</td>\
								</tr>\
							</tbody>\
						</table>\
					</div>\
				</div>\
				<div style="box-sizing: border-box;padding: 0px 25px;width: 100%;float: left;text-align: center;position: absolute; bottom: 0px; left: 0;font-size: 12px;font-family: sans-serif;">\
					<hr>\
					'+invoice["variables"]["txt_titre_ligne_8"]+'<br/>\
					'+invoice["variables"]["txt_titre_ligne_9"]+'<br/>\
					'+invoice["variables"]["txt_titre_ligne_10"]+'\
				</div>\
			';

			printDiv(html, invoice["variables"]["txt_piece_titre"] + " " + invoice["variables"]["txt_locataire_nom"]);
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
	/*end impression*/
	
	// Calcul d montant imputé
	var montant_impute = 0;

	var ids_factures_imputes = [];
	var ids_factures_imputes_values = '';

	$(document).on('change', '.iw_select', function() {		
		montant_impute = 0;

		if (this.checked) {
			montant_impute = montant_impute + parseFloat($('#factue_montant_'+this.id.substring(4)).val().replace(",", "."));
			
			ids_factures_imputes.push($('#id'+this.id.substring(4)).val());
		}else{
			montant_impute = montant_impute - parseFloat($('#factue_montant_'+this.id.substring(4)).val().replace(",", "."));
		
			var index = ids_factures_imputes.indexOf($('#id'+this.id.substring(4)).val());
			ids_factures_imputes.splice(index, 1);
		}

		$('#reg_montant').val(iw_round(montant_impute).toString().replace(".", ","));
		
		ids_factures_imputes_values = '';
		var counter  = 1;

		for(var i of ids_factures_imputes) {
			
			if (counter==1){
				ids_factures_imputes_values = ids_factures_imputes_values + i;
			}else{
				ids_factures_imputes_values = ids_factures_imputes_values + ';' + i;
			}
			
			counter = counter+1;
		}

		$('#ids_factures_putes').val(ids_factures_imputes_values);
	});

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
				Display_Table_List_Factures_NS();
				$('#reg_destinataire_id').val(ui.item.id);
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

});