$(document).ready(function(){   
    //==================================================//
	var url_base= window.location.origin;
	var var_tableliste_content = $('#list_table_locataires').html();
	var required_fields = $("#mandatory").val().split(';');
	
	var str_requirted_locataire='hb_type_locataire;';
	var required_type_locataire = str_requirted_locataire.split(';');

	Mark_All_Required_Fields(required_type_locataire);

	var sbaction = getUrlParameter('sbaction');
	var TS_Show_Loader = true;

	//==================================================//
	$('#int-usager-table .table').empty();

	$("#fdp-usager-search").click(function(){  
		Trigger_Search_Liste("usager","");

		return false;
	});  

	$("#fdp-locataires-search").click(function(){  
	   Trigger_Search_Liste("locataire","");

	    return false;
	});  

 	$('body').on('click','#list_table_locataires div', function(ev) {

		if (ev.target.id!=0){

        	 if (ev.target.id!=''){
				var data_search = {
					"cle": ev.target.id
				};
		
				$('#cle').val($('#clev'+ev.target.id).val());

				$('#hb_referenceid').val($('#refid'+ev.target.id).val());

				$('#titre_popup').html('Modification');

				Popup_Scroll_Manager();
				

				Get_Heberge_Data($('#hb_referenceid').val());
				Get_Address($('#hb_referenceid').val());
				Get_Bank_Data($('#hb_referenceid').val());

				LOC_Display_Table_List("locataire");

				var var_popup = $('#iw_form_usager').html();
				$('#iw_form_usager').html('');

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

								if (Check_Required_Fields(required_fields)){
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
									Save_Usager_Fiche();

									$('#iw_form_usager').html(var_popup);
									return true;
								}
							}
						},
							cancel: {
							text: 'Fermer',
							action: function () {
								$('#iw_form_usager').html(var_popup);
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

						$("#list_table_locations div").click(function(ev){
							var $id_location = ev.target.id;

							if ($id_location!=''){ 
								$(location).attr('href', '/GL?action=location&id='+$id_location+'&retour=usager-list');
							}

						});
					}
				});

        	} 
		}

	});

	$('#fdp_locataire_add').on('click', function () {         
		Nouvelle_Fiche();
	});

	$("#btn_reset").click(function(){  
		document.getElementById('locataires').reset();

		Trigger_Search_Liste("locataire","default");
		return false;
	});

    function Get_Heberge_Data($id){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

  
        $.LoadingOverlay("show");


		    var data_heberge = { 
              "hg_hb_id": $id
			};

			var data = { 
			    "zone":"heberge", 
			    "action":"get_heberge",
			    "data": {
			      "heberge": data_heberge
			    }
			};

			var data_json = 'json='+JSON.stringify(data);

			$.getJSON("/INT?action=get_heberge",data_json, function(data){  



				  $.each(data, function(key, value){ 


					$("#hb_nom").attr('value', value.hb_nom);
					$("#hb_prenom").attr('value', value.hb_prenom);
					$("#hb_email").attr('value', value.hb_email);
					$("#hb_telephone").attr('value', value.hb_telephone);
					$("#hb_fac_dette_initiale").attr('value', value.hb_fac_dette_initiale);
					$("#hb_compte_comptable").attr('value', value.hb_compte_comptable);
				
					$('.datepicker').datepicker({
					format: 'dd/mm/yyyy'
					});

					$('#hb_datenele').datepicker('update', getDateData(value.hb_datenele));

					$("#hb_type_locataire > [value=" + value.hb_type_locataire + "]").attr("selected", "true");

					$("#hb_fac_destation > [value=" + value.hb_fac_destation + "]").attr("selected", "true");
					

				   });  
			 

			}).done(function() {//success

			})
			.fail(function() { //error
              // Get_Heberge_Data($id);
			})
			.always(function() { //complete
               
               $.LoadingOverlay("hide");

			});  

    }

    function Save_Usager_Fiche(){

		if (Check_Required_Fields(required_fields)){
			Mark_All_Required_Fields(required_fields);
	
			$.alert({
				title: 'Champs obligatoires!',
				content: 'Vous devez remplir tous les champs obligatoires!sss',
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

            var data_bank = {
				"bqe_domiciliation": $("#bqe_domiciliation").val(),
				"bqe_nom_bancaire": $("#bqe_nom_bancaire").val(),
				"bqe_iban": $("#bqe_iban").val(),
				"bqe_bic": $("#bqe_bic").val(),
				"bqe_adresse_1": $("#bqe_adresse_1").val(),
				"bqe_adresse_2": $("#bqe_adresse_2").val(),
				"bqe_adresse_3": $("#bqe_adresse_3").val(),
				"bqe_code_postal": $("#bqe_code_postal").val(),
				"bqe_ville": $("#bqe_ville").val() 	
            }

            var data_address = {
				"ad_adresse1": $("#ad_adresse1").val(),
				"ad_adresse2": $("#ad_adresse2").val(),
				"ad_adresse3": $("#ad_adresse3").val(),
				"ad_code_postal": $("#ad_code_postal").val(),
				"ad_ville": $("#ad_ville").val(),
				"ad_type_adresse": 'Facturation'	
            }

		    var data_heberge = { 
				"hg_hb_id": $("#hb_referenceid").val(),  
				"hb_nom": $("#hb_nom").val(), 
				"hb_prenom": $("#hb_prenom").val(), 
				"hb_email": $("#hb_email").val(), 
				"hb_telephone": $("#hb_telephone").val(), 
				"hb_datenele": $("#hb_datenele").val(),
				"hb_type_locataire": $("#hb_type_locataire").val(),
				"hb_locataire": $("#hb_locataire").val(),
				"hb_fac_destation": $("#hb_fac_destation").val(),
				"hb_fac_dette_initiale": $("#hb_fac_dette_initiale").val(),
				"hb_compte_comptable": $("#hb_compte_comptable").val(),
				"adresse": {
					"data": data_address
				},
				"coordonnees_bancaires": {
					"data": data_bank
				}
			};
			console.log(data_heberge)
			var data = { 
			    "zone":"heberge", 
			    "action":"set_heberge",
			    "data": {
			      	"heberge": data_heberge
			    }
			};

			var data_json = '&json='+JSON.stringify(data);
            var save_status='';

			$.getJSON("/GL?action=usager_fiche_valider",data_json, function(data){

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
					Trigger_Search_Liste("locataire","");
		
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
						content: 'Enregistrement échoué',
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

	function Get_JSON_Usagers(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		Unmark_All_Required_Fields(required_fields);

		$('#int-usager .table').empty();
		$('#int-usager-result .table').empty();

		var data_search = {
			"nom": $("#nom").val(),
			"prenom": $("#prenom").val(),
			"date_naissance": $("#date_naissance").val(),
			"lien_famille": $("#lien_famille").val(),
			"telephone": $("#telephone").val()
		};

		var data_json = null;
					
		$.getJSON("/GL?action=usager_list_json",data_search, function(data){  
			data_json = JSON.stringify(data);

			$('#example').DataTable( {
				data: data,
				destroy: true,
				"columns": [
					{ "data": "hb_cle" },
					{ "data": "hb_referenceid" },
					{ "data": "hb_referenceid" },
					{ "data": "hb_referenceid" },
					{ "data": "hb_referenceid" },
					{ "data": "hb_referenceid" }
				],
				"columnDefs": [ {
					"targets": 0,
					"data": "download_link",
					"render": function ( data, type, row, meta ) {
						return '<a href="'+data+'">Download</a>';
					}
				} ]
			} );

		}).done(function() {//success

		})
		.fail(function() { //error
			
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
			
		return data_json;
	}

	function Rechercher_Usager__(){
		var daata_json= Get_JSON_Usagers();
	}

	function Rechercher_Usager($usager_type,$display_type){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});


		$.LoadingOverlay("show");

		Unmark_All_Required_Fields(required_fields);

		$('#int-usager .table').empty();
		$('#int-usager-result .table').empty();

		var data_search = {
			"nom": $("#nom").val(),
			"prenom": $("#prenom").val(),
			"date_naissance": $("#date_naissance").val(),
			"lien_famille": $("#lien_famille").val(),
			"telephone": $("#telephone").val(),
			"usager_type": $usager_type,
			"display_type": $display_type
		};


		var data = { 
			"zone":"GL", 
			"action":"get_usagers",
			"data": {
			"usagers": data_search
			}
		};

		var data_json = '&json='+JSON.stringify(data);
				

				

		$.getJSON("/GL?action=locataires_list_json",data_json, function(data){  
				
			$('#int-usager-table .table').empty();

			if (data.length>0){
				var resp_table_data='';
				var css_class_row='';
				var counter = 0;
			
				resp_table_data +='<div class="row header">';
				resp_table_data +='<div class="cell fdp-min-width-210px">';
				resp_table_data +='Clé';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 100px;">';
				resp_table_data +='Nom';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 120px;">';
				resp_table_data +='Prénom';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 120px;">';
				resp_table_data +='Date de naissance';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 120px;">';
				resp_table_data +='Type locataire';
				resp_table_data +='</div>';
				resp_table_data +='<div class="cell" style="min-width: 120px;">';
				resp_table_data +='Location en cours';
				resp_table_data +='</div>';
				resp_table_data +='</div>'; 
				
				$.each(data, function(key, value){  
					css_class_row='';

					if (value.count_fiches>0){
						css_class_row='fdp-blue-bold';
					}

					if (counter % 2 != 0){
						css_class_row+=' iw-alternate';
					}

					resp_table_data +='<div class="row body '+css_class_row+'">';
					resp_table_data +='<div class="cell" id="colf'+value.hb_referenceid+'">';

					resp_table_data +=value.hb_cle;

					resp_table_data +='</div>';
					resp_table_data +='<div class="cell iw_uppercase" id="colf'+value.hb_referenceid+'">';
					resp_table_data +=value.hb_nom;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell iw_uppercase" id="colf'+value.hb_referenceid+'">';
					resp_table_data +=value.hb_prenom;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" id="colf'+value.hb_referenceid+'">';
					resp_table_data +=getDateData(value.hb_datenele);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" id="colf'+value.hb_referenceid+'">';
					resp_table_data +=value.hb_type_locataire;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" id="colf'+value.hb_referenceid+'">';

					if (value.locations_encours==true){
						resp_table_data +='<i class="fa fa-check-square-o fdp-icon-green"></i>';
					}else{
						resp_table_data +='<i class="fa fa-times fdp-icon-red"></i>';
					}

					resp_table_data +='</div>';
					resp_table_data +='</div>';

					$('<input>', {
						type: 'hidden',
						id: 'clev'+value.hb_referenceid,
						name: 'clev'+value.hb_referenceid,
						value: value.hb_cle
					}).appendTo('#int-usager-table');


					$('<input>', {
						type: 'hidden',
						id: 'id'+value.id,
						name: 'id'+value.id,
						value: value.id
					}).appendTo('#int-usager-table');


					$('<input>', {
						type: 'hidden',
						id: 'refid'+value.hb_referenceid,
						name: 'refid'+value.hb_referenceid,
						value: value.hb_referenceid
					}).appendTo('#int-usager-table');

					counter = counter + 1;
				});  

				$("#int-usager-table .table").append(resp_table_data); 
				$("table").show();
			}

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			$("#int-usager .table").show();
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

		$.getJSON("/GL?action=get_address_usager",data_json, function(data){  

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

	function Add_New_Usager($locataire){

		if (Check_Required_Fields(required_fields)){
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
	
		}else{
			$.LoadingOverlaySetup({
				background      : "rgba(0, 0, 0, 0.5)",
				imageColor      : "#fff"
			});

			$.LoadingOverlay("show");

			var jour_nuit="N";

			if (isDayTime()){
				jour_nuit="J";
			}

			var data_hebergement_cle = { 
				"hb_datenele": $("#date_naissance").val(),
				"hb_nom": $("#nom").val(),
				"hb_prenom": $("#prenom").val(),
				"date_client": getDateNow(),
				"jour_nuit": jour_nuit,
				"ref_structure": $("#ref_structure").val(),
				"hb_locataire": $locataire
			};

			var data = { 
				"zone":"heberge", 
				"action":"set_heberge",
				"data": {
					"heberge": data_hebergement_cle
				}
			};

			var data_json = '&json='+JSON.stringify(data);
			var save_status='';

			$.getJSON("/INT?action=usager_fiche_add",data_json, function(data){  
			
				$.each(data, function(key, value){  
					save_status = value;
				});

			}).done(function() {//success
			})
			.fail(function() { //error
			})
			.always(function() { //complete
				$.LoadingOverlay("hide");

				Mark_All_Required_Fields(required_fields);

				Rechercher_Usager("locataire","default");

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

				}else{

					$.alert({
						title: 'Erreur',
						content: 'Enregistrement échoué',
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

	function Nouvelle_Fiche(){
		$('#titre_popup').html('Nouvelle fiche');

		var var_popup = $('#iw_form_usager').html();
		$('#iw_form_usager').html('');

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


							Save_Usager_Fiche();
						
							$('#iw_form_usager').html(var_popup);

							return true;
						}
					}
				},
				cancel: {
					text: 'Fermer',
					action: function () {

						$('#iw_form_usager').html(var_popup);
		
					
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

	function LOC_Display_Table_List($type_display){
		$.LoadingOverlaySetup({
		    background      : "rgba(0, 0, 0, 0.5)",
		    imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$('#list_table_locations .table').empty();

		var data_specific = {
			"search_bien_location": "",
			"search_usager": $('#hb_referenceid').val(),
			"search_date": "",
			"type_display": $type_display
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_locations",
			"data": data_specific
	    };
		
		var data_json = '&json='+JSON.stringify(data_search);
		
		$.getJSON("/GL?action=locations_list_json",data_json, function(data){  
			$('#list_table_locations .table').empty();

			var resp_table_data='';

			resp_table_data +='<div class="row header">';
			resp_table_data +='<div class="cell " style="min-width: 120px;">';
			resp_table_data +='Date du bail';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Bien en location';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Montant du loyer';
			resp_table_data +='</div>';

			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Date d\'entrée';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Date de sortie';
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
					resp_table_data += Get_Date_Formatted(value.loc_date);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data +=value.loc_bien_name;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data +=iw_round(value.loc_montant_initial);
					resp_table_data +='</div>';

					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data += Get_Date_Formatted(value.loc_date_entree);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data += Get_Date_Formatted(value.loc_date_sortie);
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
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
	}

	function Get_Bank_Data($id){
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
			"action":"get_bank",
			"data": {
				"coordonnees_bancaires": data_address
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=locataire_get_info_bancaires",data_json, function(data){  

			$.each(data, function(key, value){ 
				$("#bqe_domiciliation").attr('value', value.bqe_domiciliation);
				$("#bqe_nom_bancaire").attr('value', value.bqe_nom_bancaire);

				$("#bqe_iban").attr('value', value.bqe_iban);
				$("#bqe_bic").attr('value', value.bqe_bic);

				$("#bqe_adresse_1").attr('value', value.bqe_adresse_1);
				$("#bqe_adresse_2").attr('value', value.bqe_adresse_2);
				$("#bqe_adresse_3").attr('value', value.bqe_adresse_3);

				$("#bqe_code_postal").attr('value', value.bqe_code_postal);
				$("#bqe_ville").attr('value', value.bqe_ville);

			});  
			
		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
	}

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//
	var sbajaxurl=url_base+'/GL?action=locataires_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste(){
		var $table =$("#list_table_locataires")
		.tablesorter({
		theme: 'blue',
			widthFixed: true,
			sortLocaleCompare: true, 
			sortList: [ [1, 1] ],
			widgets: [ 'filter'],
			widgetOptions : {
			filter_reset : '.fdp-btn-red',
			filter_external : 'search'

			},
			headers: { 
				0: { 
					sorter: true,
					filter: false 
				},
				1: { 
					sorter: true,
					filter: true 
				},
				2: { 
					sorter: true,
					filter: false 
				},
				3: { 
					sorter:true,
					filter: false 
				},
				4:{
					sorter: true,
					filter: false 
				},
				5:{
					sorter: true,
					filter: true 
				},
				6:{
					sorter:true,
					filter: true 
				},
				7:{
					sorter:true,
					filter: true 
				},
				8:{
					sorter:true,
					filter: true 
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

			if(TS_Show_Loader==true){
				$.LoadingOverlay("show");
			}		      	 
				
			if (data && data.hasOwnProperty('rows')) {
				var indx, r, row, c, d = data.rows,
				
				total = data.total_rows,
				
				headers = data.headers,
				
				headerXref = headers.join(',').replace(/\s+/g,'').split(','),
				
				rows = [],
				
				len = d.length;
				
				
				for ( r=0; r < len; r++ ) {
				row = []; 
				
				for ( c in d[r] ) {
					if (typeof(c) === "string") {
					
					indx = $.inArray( c, headerXref );
					
					if (indx >= 0) {
						row[indx] = d[r][c];
					}
					}
				}
				rows.push(row); 
				}
				
				return [ total, rows, headers ];
			}
			},

			processAjaxOnInit: true,
			output: '{startRow} to {endRow} ({totalRows})',
			updateArrows: true,
			page: 0,
			size: 20,
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

		// Allow changing an input from one column (any column) to another
		$('.search').change(function(){
			//$("#list_table_locataires").html('').html(var_tableliste_content);

			$('#list_table_locataires').trigger('updateHeaders');
			$("#list_table_locataires").trigger("update"); 

			// modify the search input data-column value (swap "0" or "all in this demo)
			$('.selectable').attr( 'data-column', $(this).val() );

			// update external search inputs
			$.tablesorter.filter.bindSearch( $table, $('.search'), false );
		});
		
		//assign the sortStart event
		$("table").bind("sortStart",function() {

			if (TS_Show_Loader==true){
				$.LoadingOverlay("show");
			}
			
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

		// show current URL for the DEMO ONLY
		.on('changingUrl', function(e, url){
			$url.html(url);

			$.LoadingOverlaySetup({
				background      : "rgba(0, 0, 0, 0.5)",
				imageColor      : "#fff"
			});
		})

		.on('pagerInitialized', function(){
			// allow THIS demo to sort the content; this variable is automatically set to true when ajax
			// is used as there isn't any way to sort the server side data from the client side.
			this.config.serverSideSorting = false;

			// show original highlighted URL
			$('#origurl').html( this.config.pager.ajaxUrl.replace(/(\{.*?\})/g, '<span class="results">$1</span>') );

			$.LoadingOverlay("hide");
		});

		$table.on('pagerComplete', function(){
			$.LoadingOverlay("hide");
		});

		$table.on('filterInit', function(){	
		});	
	}

	function Trigger_Search_Liste($type, $display_type){
		//$("#list_table_locataires").html('').html(var_tableliste_content);
        
		$('#list_table_locataires').trigger('updateHeaders');
		$("#list_table_locataires").trigger("update"); 
	
		var columns = [];

		columns[5] = $type;
		columns[8] = $display_type;

		console.log('=====-----> '+$display_type);

		$('#display_type').val($display_type);
		
		$('#list_table_locataires').trigger('search', [ columns ]);   

		/****/
		TS_Show_Loader = true;
		$("#list_table_locataires").trigger("update"); 

		var sorting = [[0,0]];
		TS_Show_Loader = false;

		$("#list_table_locataires").trigger("sorton",[sorting]); 

		var sorting = [ [1,1]]; 
		$("#list_table_locataires").trigger("sorton",[sorting]); 
	}

   	Init_DataTable_Liste();

	/************ sidebar action ***********/
	if (sbaction=='new'){
		Nouvelle_Fiche();
	}

});