$(document).ready(function(){  
	Get_Location_Data($("#record_id").val());
	
	Display_Table_Lignes();
	Display_Table_Colocataires();
	Display_Table_APL();

	var $optionValue = "";

	var mandatory_fields = $("#mandatory").val().split(';');
	var mandatory_fields_ligne = "";
	var mandatory_ligne_colocataire = $("#mandatory_ligne_colocataire").val().split(';');
	
	var form_back_view = getUrlParameter('form_back_view');

	if ($('#form_back_view').val() == ''){
		$('#form_back_view').val(form_back_view);
	}

	Mark_All_Required_Fields_Default(mandatory_fields);
	Mark_All_Required_Fields_Default(mandatory_fields_ligne);

	Init_Autocomplete_Usagers('#usager','#loc_hb_id','GB','get_autocomplete_locataires');
	Init_Autocomplete_Biens('#bien_en_location','#loc_bien_id','GB','get_autocomplete_centres');

    $("#list_table_colocataires div").click(function(ev) {

        if (ev.target.id != '') {
            $('#id_selected').val(ev.target.id);
			Get_Record_Data_Generique(ev.target.id,"colocataire");

            var var_popup = $('#iw_form_popup_child_colocataire').html();
            var btn_save_class = '';

			Nouvelle_Fiche_Colocataire(false);
        }
    });

	/******Piece****/
	$("#btn_new").click(function(ev){ 
		Nouvelle_Fiche(ev);
		
		return false;
	}); 

	$("#btn_new_colocataire").click(function(ev){ 
		Nouvelle_Fiche_Colocataire(true);
		
		return false;
	});   

	$("#fdp_piece_valider").click(function(ev){ 
		Save_Piece("");
		return false;
	});  

	$("#fdp_piece_quitter").click(function(ev){

		switch (true) {
			case ($("#form_back_view").val() != ''):
				$(location).attr('href', '/GL?action=' + $("#form_back_view").val());
				break;
			default:
				$(location).attr('href', '/GL?action=bien&id=' + $("#loc_bien_id").val());	
				break;
		}
		
		return false;
	});

	$("#loc_duree_mois").change(function() {
		var years = parseInt($('#loc_duree_mois').val());

		if (years) {
			var loc_date_entree = $('#loc_date_entree').val();

			var date_parts = loc_date_entree.split("/")
			var loc_date_sortie = new Date(date_parts[2], date_parts[1] - 1, date_parts[0])

			if (Object.prototype.toString.call(loc_date_sortie) === "[object Date]") {
		
				if (isNaN(loc_date_sortie.getTime())) { 

				$.alert({
					title: 'Champs obligatoires!',
					content: 'Veuillez saisir la date d\'entrée',
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

				} else {
					loc_date_sortie.setFullYear(loc_date_sortie.getFullYear() + years);
					$("#loc_date_sortie").datepicker("setDate", loc_date_sortie);
				}

			}

		}
		
	});

	$("#loc_statut option").each(function(){
		$optionValue += '<option value="' + $(this).val()+ '">' + $(this).val() + '</option>'
	});

	// Un peu de mise en forme
	$("#loc_statut").closest(".control-group").html('<label class="control-label-group">Statut</label><div id="div_statut" class="control"><select id="loc_statut" class="span7 search iw_tag_width_third" name="loc_statut" data-column="">' + $optionValue + '</select><img id="btn_suppr_statut" src="layouts/default/images/delete-modele.png" width="35" /><button id="btn_sauv_statut" class="fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne"><i class="fa fa-save"></i>Sauvegarder</button><button id="btn_nouveau_statut" class="fdp_Button fdp_btn_top fdp-btn-green iw_margin_left_5px fdp_btn_piece_ligne"><i class="fa fa-plus"></i>Ajouter un statut</button></div>');

	$('#div_statut').css('cssText', 'display: flex !important; align-items: center !important');
	$('#loc_statut').css('cssText', 'width: 115px !important');

	$('#btn_sauv_statut').css('cssText', 'width: 110px !important');
	$('#btn_nouveau_statut').css('cssText', 'width: 135px !important');

	$('<div class="iw_width_full"><div class="iw_titre_liste iw_width_half">LES APL</div></div>').insertBefore( $("#loc_apl").closest(".fdp_row_start") );

	$("#loc_referent").attr("disabled", !$("#loc_apl").is(":checked"));
	$("#loc_coordinateur").attr("disabled", !$("#loc_apl").is(":checked"));

	$("#aplYearList").css("cssText", "width: 200px!important;");
	$("#btn_refresh_apl").css("cssText", "width: 365px!important;");

	$("#loc_apl").click(function(){
		$("#loc_referent").attr("disabled", !$(this).is(":checked"));
		$("#loc_coordinateur").attr("disabled", !$(this).is(":checked"));

		if ($(this).is(":checked") == false) {
			$("#loc_referent").val("");
			$("#loc_coordinateur").val("");
		}
	});

	$("#btn_suppr_statut").mouseover(function() {
		$('#btn_suppr_statut').css('cssText', 'cursor: pointer');
	});

	$("#btn_nouveau_statut").click(function(event){
		event.preventDefault();

		$("#loc_statut").val("");

		$nomStatut = prompt("Nom du statut svp ?");

		if ($nomStatut != "" && $("#loc_statut option[value='"+$nomStatut+"']").length == 0) {
			$('#loc_statut').append('<option value="' +$nomStatut+ '">' +$nomStatut+ '</option>');
			$('#loc_statut').val($nomStatut);
		}else{

			if ($("#loc_statut option[value='"+$nomStatut+"']").length != 0) {
				alert("Ajout impossible, un statut existe déjà avec ce nom");
			}

		}

	});

	$("#btn_sauv_statut").click(function(event){
		event.preventDefault();

		var $nomStatut = $("#loc_statut").val();

		if ($nomStatut == "") {
			alert("Modification impossible, merci de sélectionner un statut")
		}else{
			var $sauvStatut = confirm("Voulez-vous vraiment sauvegarder le statut qui porte le nom "+$nomStatut+" ?")
			
			if ($sauvStatut == true) {

				$.ajax({
					type: "GET",
					url: "/4DACTION/Web_Manage_User_Preferences",
					data: {
						"intervenantID": intervenantID,
						"action": "sauvegarder",
						"propriete": "location.statut",
						"type": "collection",
						"valeur": $("#loc_statut").val()
					},
					success: function (response) {
						alert("Le statut a bien été sauvegardé !");
					}
				});

			}
		}

	});

	$("#btn_suppr_statut").click(function(event){
		event.preventDefault();

		var $nomStatut = $("#loc_statut").val();

		if ($nomStatut == "") {
			alert("Suppression impossible, merci de sélectionner un statut")
		}else{
			var $supprStatut = confirm("Voulez-vous vraiment supprimer le statut qui porte le nom " + $nomStatut + " ?")
			
			if ($supprStatut == true) {

				$.ajax({
					type: "GET",
					url: "/4DACTION/Web_Manage_User_Preferences",
					data: {
						"intervenantID": intervenantID,
						"action": "supprimer",
						"propriete": "location.statut",
						"type": "collection",
						"valeur": $("#loc_statut").val()
					},
					success: function (response) {
						alert("Le statut a bien été supprimé !")

						$("#loc_statut option:selected").remove();
						$("#loc_statut").val("");
					}
				});
				
			}
		}

	});

	$("#btn_save_apl").click(function(){

		if ($("#aplYearList").val() == "") {

			$.alert({
				title: 'Sélection de l\'année obligatoire !',
				content: 'Vous devez sélectionner une année avant de pouvoir sauvegarder !',
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

			return;
		}

		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		var $data_c = [];
		var $result_c = [];

		for (let index = 1; index <= 12; index++) {

			$data_c.push({
				"year": $("#aplYearList").val(),
				"month": index,
				"pending": 0,
				"receive": 0,
				"date": ""
			});

		}

		$("#tableAPL > tbody").find("td").each(function(){
			var $rowIndex_i = $('#tableAPL tr').index($(this).closest('tr'));
			var $cellIndex_i = $(this).closest("tr").find("td").index($(this));

			if ($(this).hasClass("numericEdit") == true || $(this).hasClass("dateEdit") == true) {
				$result_c = searchInArrayObject($data_c, "month", $cellIndex_i, "arrayObject");

				if ($result_c.length > 0) {

					switch ($rowIndex_i) {
						case 1:
							$data_c[$result_c[0].month - 1].pending = $(this).text();				
							break;
						case 2:
							$data_c[$result_c[0].month - 1].receive = $(this).text();	
							break;
						case 3:

							if ($(this).text() != "") {
								$data_c[$result_c[0].month - 1].date = dateToJJMMYYYY($(this).text());
							}
							
							break;
						default:
							break;
					}
					
				}

			}

		});

		$.ajax({
			method: 'POST',
			url: "/4DACTION/outilsWebLocationAPLAjax",
			data: {
				"annee": $("#aplYearList").val(),
				"locationID": $('#record_id').val(),
				"data": JSON.stringify($data_c),
				"action": "saveAPL"
			},
			success: function(response){
				$.LoadingOverlay("hide");

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
			}
		});

	});

	$("#btn_refresh_apl").click(function(){

		if ($("#aplYearList").val() == "") {

			$.alert({
				title: 'Sélection de l\'année obligatoire !',
				content: 'Vous devez sélectionner une année avant de pouvoir sauvegarder !',
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

			return;
		}

		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		$.ajax({
			method: 'POST',
			url: "/4DACTION/outilsWebLocationAPLAjax",
			data: {
				"locationID": $('#record_id').val(),
				"action": "refreshAPL"
			},
			success: function(response){
				var reponseParse = JSON.parse(response);
				console.log(reponseParse);

				$.LoadingOverlay("hide");
				
				if (reponseParse.notificationWarning != null) {

					$.alert({
						title: 'Alerte',
						content: reponseParse.notificationWarning,
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
					
					return;
				}

				$.alert({
					title: 'Succès',
					content: 'La réactualisation des APL a bien été effectué avec succès.',
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

	});

	$("#aplYearList").change(function(){
		var $this = $(this);

		if ($("#loc_apl").is(":checked") == false) {

			$.alert({
				title: 'Attention !',
				content: 'Cette location n\'est pas en gestion des APL, merci de cocher la boite à cocher ci-dessus pour pouvoir utiliser cette fonctionnalité !',
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

			$("#aplYearList").val("");
			return;
		}

		$("#btn_save_apl").removeClass("fdp-btn-grey");
		$("#btn_save_apl").addClass("fdp-btn-green");

		$("#btn_refresh_apl").removeClass("fdp-btn-grey");
		$("#btn_refresh_apl").addClass("fdp-btn-green");

		disabledFirstChoiceInSelect("aplYearList");

		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		$.ajax({
			method: 'POST',
			url: "/4DACTION/outilsWebLocationAPLAjax",
			data: {
				"annee": $this.val(),
				"locationID": $('#record_id').val(),
				"action": "chargeAPL"
			},
			success: function(response){
				var reponseParse = JSON.parse(response);
				console.log(reponseParse);

				reponseParse.data.forEach(element => {
					$('#tableAPL').find("tr:eq(1)").find('td:eq(' + element.month + ')').text(element.pending);
					$('#tableAPL').find("tr:eq(2)").find('td:eq(' + element.month + ')').text(element.receive);

					if (element.date != "0000-00-00") {
						$('#tableAPL').find("tr:eq(3)").find('td:eq(' + element.month + ')').text(dateToJJMMYYYY(element.date));
					}
					
					$('#tableAPL').find("tr:eq(4)").find('td:eq(' + element.month + ')').text(numberMaxDecimal(element.pay, 2));
				});

				$("#tableAPL > tbody").find("td").each(function(){
					var $rowIndex_i = $('#tableAPL tr').index($(this).closest('tr'));
					var $cellIndex_i = $(this).closest("tr").find("td").index($(this));

					if ($cellIndex_i > 0) {

						switch ($rowIndex_i) {
							case 1:
							case 2:
								$(this).addClass("numericEdit");
								break;
							case 3:
								$(this).addClass("dateEdit");
								break;
							default:
								break;
						}

					}
				});

				$.LoadingOverlay("hide");
			}
		});

	});

	function Init_Autocomplete_Biens($id_field, $id_hidden, $module,$action){

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
				
				var data_json = '&json=' +JSON.stringify(data_search);

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

				return false;
			}

		}).focus(function () {

			setTimeout(
				"if ($('"+$id_field+"').val().length == 0) $('"+$id_field+"').autocomplete(\"search\", \"\"); "
			,1);
			
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

	function Save_Piece(){

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
			Save_Piece_Location();
		}

	}

	function Display_Table_Lignes(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$('#int-usager .table').empty();
		$('#int-usager-result .table').empty();

		var data_specific = {
			"id": $("#record_id").val()
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_location_documents",
			"data": data_specific
		};
		
		var data_json = '&json=' +JSON.stringify(data_search);

		$.getJSON("/GL?action=documents_list_json",data_json, function(data){  
			$('#list_table .table').empty();

			var resp_table_data='';

				resp_table_data += '<div class="row header">';
				resp_table_data += '<div class="cell" style="min-width: 120px;">';
				resp_table_data += 'Titre du document';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell iw_second_column" style="min-width: 100px;">';
				resp_table_data += 'Type';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell iw_second_column" style="min-width: 100px;">';
				resp_table_data += 'Créé Le';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell iw_second_column" style="min-width: 100px;">';
				resp_table_data += 'Format';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell iw_second_column" style="min-width: 100px;">';
				resp_table_data += 'Version';
				resp_table_data += '</div>';
				resp_table_data += '</div>';

			if (data.length > 0){
				var css_class_row='';
				var counter = 0;

				$.each(data, function(key, value){  
					css_class_row='';

					if (counter % 2 != 0){
						css_class_row+= ' iw-alternate';
					}

					resp_table_data += '<div class="row body ' +css_class_row + '">';
					resp_table_data += '<div class="cell  " id="' + value.id + '">';
					resp_table_data +=value.doc_titre;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data +=value.doc_document_type;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data +=getDateData(value.doc_date);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data +=value.doc_extension;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data +=value.doc_version;
					resp_table_data += '</div>';
					resp_table_data += '</div>';

					$('<input>', {
						type: 'hidden',
						id: 'id' +value.id,
						name: 'id' +value.id,
						value: value.id
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

	function Display_Table_Colocataires(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$('#list_table_colocataires .table').empty();
		var data_specific = {
			"id": $("#record_id").val()
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_location_colocataires",
			"data": data_specific
		};
		
		var data_json = '&json=' +JSON.stringify(data_search);
		
		$.getJSON("/GL?action=colocataires_list_json",data_json, function(data){  
			$('#list_table_colocataires .table').empty();

			var resp_table_data='';

				resp_table_data += '<div class="row header">';
				resp_table_data += '<div class="cell" style="min-width: 120px;">';
				resp_table_data += 'Nom';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell iw_second_column" style="min-width: 100px;">';
				resp_table_data += 'Prénom';
				resp_table_data += '</div>';
				resp_table_data += '</div>'; 
			
			if (data.length>0){
				var css_class_row='';
				var counter = 0;

				$.each(data, function(key, value){  
					css_class_row='';

					if (counter % 2 != 0){
						css_class_row+= ' iw-alternate';
					}

					resp_table_data += '<div class="row body ' + css_class_row + '">';
					resp_table_data += '<div class="cell" id="' + value.id + '">';
					resp_table_data += value.loc_nom;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell" id="' + value.id + '">';
					resp_table_data += value.loc_prenom;
					resp_table_data += '</div>';
					resp_table_data += '</div>';

					$('<input>', {
						type: 'hidden',
						id: 'id' +value.id,
						name: 'id' +value.id,
						value: value.id
					}).appendTo('#list_table_colocataires');

					counter = counter + 1;
				});
			}

			$("#list_table_colocataires .table").append(resp_table_data); 
		}).done(function() {//success

		})
		.fail(function() { //error
			$.LoadingOverlay("hide");
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
	}

	function Display_Table_APL(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data_search = { 
			"zone":"gl", 
			"action":"get_location_apl",
			"data": {
				"id": $("#record_id").val()
			}
		};
		
		var data_json = '&json=' +JSON.stringify(data_search);
		
		$.getJSON("/GL?action=apl_list_json",data_json, function(data){  
			$('#list_table_apl .table').empty();

			var $currentYear_i = new Date().getFullYear();
			var $year_c = data.map(function(a) {return a.year;});
			var $classRow_t = "";

			var resp_table_data='<thead>';
			resp_table_data += '<tr class="row header">';

			for (let index = 1; index <= 12; index++) {

				if (index == 12) {
					break;
				}

				if (index == 1) {
					resp_table_data += '<td class="cell" style="min-width: 240px;">';
					resp_table_data += '</td>';

					const month = new Date($currentYear_i, 12).toLocaleString('fr', { month: 'long' });
	
					resp_table_data += '<td class="cell" style="min-width: 120px;">';
					resp_table_data += month;
					resp_table_data += '</td>';
				}

				const month = new Date($currentYear_i, index).toLocaleString('fr', { month: 'long' });

				resp_table_data += '<td class="cell" style="min-width: 120px;">';
				resp_table_data += month;
				resp_table_data += '</td>';
			}

			resp_table_data += '</tr>';
			resp_table_data += '</thead>';

			// Permet de n'extraire que les valeurs uniques d'un tableau
			$year_c = $year_c.filter((value, index, array) => array.indexOf(value) === index);
			$year_c.forEach(element => {

				$('#aplYearList').append($('<option>', {
					value: element,
					text: element
				}));

			});

			// Ajout de l'année suivante pour la facturation
			if ($("#aplYearList option[value='" + ($currentYear_i+1).toString() + "']").length == 0) {

				$('#aplYearList').prepend($('<option>', {
					value: ($currentYear_i+1).toString(),
					text: ($currentYear_i+1).toString()
				}));

			}

			// Ajouté par Rémy Scanu - 24/01/2024
			// Ajout de l'année précédente également si non présente pour les locations qui ont commencé en décembre de l'année précédente par exemple
			if ($("#aplYearList option[value='" + ($currentYear_i-1).toString() + "']").length == 0) {
			
				$('#aplYearList').append($('<option>', {
					value: ($currentYear_i-1).toString(),
					text: ($currentYear_i-1).toString()
				}));

			}

			if ($("#aplYearList option[value='" + $currentYear_i.toString() + "']").length == 0) {
			
				$('#aplYearList').append($('<option>', {
					value: $currentYear_i.toString(),
					text: $currentYear_i.toString()
				}));

			}

			$('#aplYearList').prepend($('<option>', {
				value: "",
				text: "Sélectionnez une année"
			}));			

			resp_table_data += "<tbody>"

			for (let index = 1; index < 5; index++) {

				if (index % 2 == 0){
					$classRow_t = ' iw-alternate';
				}else{
					$classRow_t = '';
				}

				resp_table_data += '<tr class="row body' + $classRow_t + '">';
				resp_table_data += '<td class="cell">';

				switch (index) {
					case 1:
						resp_table_data += 'Montant en attente';
						break;
					case 2:
						resp_table_data += 'Montant reçu';
						break;
					case 3:
						resp_table_data += 'Date de réception';
						break;
					case 4:
						resp_table_data += 'Total montant des APL en retard';
						break;
					default:
						break;
				}

				resp_table_data += '</td>';

				for (let indexB = 0; indexB <= 12; indexB++) {
					resp_table_data += '<td class="cell">';
					resp_table_data += '</td>';
				}

				resp_table_data += '</tr>';
			}

			resp_table_data += "</tbody>"

			$("#list_table_apl .table").append(resp_table_data);

			var advancedEditor = new SimpleTableCellEditor("tableAPL");

			advancedEditor.SetEditableClass("numericEdit", { validation: $.isNumeric, formatter: (val) => { return parseFloat(val); } });
			advancedEditor.SetEditableClass("dateEdit", {
				internals: {
					renderEditor: (elem, oldVal) => {
						$(elem).html('<input type="date" value="' + dateToYYYYMMJJ(oldVal) + '" style="width:100%; max-width:none">');
					}
				}, formatter: (val) => { return dateToJJMMYYYY(val); }
			});

			$('#tableAPL').on("cell:onEditExited", function (event) {

				if ($(event.element).hasClass("numericEdit")) {

					if ($(event.element).closest("tr").index() == 0) { // C'est la ligne "Montant en attente" qui est modifiée
						var $aplPending_t = event.newValue;
						var $aplReceive_t = $('#tableAPL').find("tr:eq(2)").find('td:eq(' + event.element.cellIndex + ')').text();
					}else{ // C'est la ligne "Montant reçu" qui est modifiée
						var $aplPending_t = $('#tableAPL').find("tr:eq(1)").find('td:eq(' + event.element.cellIndex + ')').text();
						var $aplReceive_t = event.newValue;
					}

					if (isNaN(parseFloat($aplPending_t)) == true) {
						$aplPending_t = "0";
					}

					if (isNaN(parseFloat($aplReceive_t)) == true) {
						$aplReceive_t = "0";
					}

					var $aplRetard_r = parseFloat($aplReceive_t) - parseFloat($aplPending_t);
					
					$('#tableAPL').find("tr:eq(4)").find('td:eq(' + event.element.cellIndex + ')').text(numberMaxDecimal($aplRetard_r, 2));
				}

			});

			if ($("#loc_apl").is(":checked") == true) {
				$('#aplYearList option[value="' + $currentYear_i.toString() + '"]').attr("selected", "selected");
				$('#aplYearList').change();				
			}

		}).done(function() {
		})
		.fail(function() {
			$.LoadingOverlay("hide");
		})
		.always(function() {
			$.LoadingOverlay("hide");
		});
	}

	function Nouvelle_Fiche(){
		$('#titre_popup').html('Nouveau');

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
							$('#iw_form_popup').html(var_popup);
							return true;
						}

					}
				},
				telecharger: {
					text: 'Télécharger',
					btnClass: 'btn-grey',
					isDisabled: true,
					action: function () {
						$('#iw_form_popup').html(var_popup);
						$("#id_selected").val('');
					}
				},
				supprimer: {
					text: 'Supprimer',
					btnClass: 'btn-grey',
					isDisabled: true,
					action: function () {
						$('#iw_form_popup').html(var_popup);
						$("#id_selected").val('');
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
					e.preventDefault();
					jc.$$formSubmit.trigger('click'); // reference the button and click it
				});
			}
		});
	}

	function Nouvelle_Fiche_Colocataire($init){

		if ($init == true) {
			$('#titre_popup_colocataire').html('NOUVEAU COLOCATAIRE');	
		}else {
			$('#titre_popup_colocataire').html('MODIFICATION');
		}

		var var_popup = $('#iw_form_popup_colocataire').html();
		$('#iw_form_popup_colocataire').html('');

		$.confirm({
			title: '',
			content: '' +
			'<div>' +var_popup+     
			'</div>',
			buttons: {
				Supprimer: {
					text: 'Supprimer',
					btnClass: 'btn-red iw_btn_delete',
					keys: ['del'],
					isHidden: $init,
					isDisabled: false,
					action: function() {

						$.confirm({
							title: 'Suppression',
							content: 'Voulez-vous vraiment supprimer ce colocataire ?',
							icon: 'fa fa-warning',
							animation: 'scale',
							closeAnimation: 'zoom',
							columnClass: 'iw_alert',
							buttons: {
								confirm: {
									text: 'Oui',
									btnClass: 'btn-orange',
									action: function() {
										$('#iw_form_popup_colocataire').html(var_popup);

										Remove_Colocataire();
									}
								},
								cancel: {
									text: 'Non',
									action: function() {
										$('#iw_form_popup_colocataire').html(var_popup);
									}
								}
							}
						});

					}
				},
				formSubmit: {
					text: 'Enregistrer',
					btnClass: 'btn-blue',
					isHidden: !$init,
					action: function () {

						if (Check_Required_Fields(mandatory_ligne_colocataire)){
							Mark_All_Required_Fields(mandatory_ligne_colocataire);

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
							Save_Record_Line_Colocataire();
							$('#iw_form_popup_colocataire').html(var_popup);

							return true;
						}

					}
				},
				cancel: {
				text: 'Fermer',
				action: function () {

						$('#iw_form_popup_colocataire').html(var_popup);
		
					
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

				Init_Autocomplete('#loc_colocataire','#loc_colocataire_id','GB','get_autocomplete_colocataires');
			}
		});
	}

	function Save_Record_Line_Colocataire(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data_ligne = {
			"id_piece": $("#record_id").val(),
			"id_origin_lk": $("#loc_colocataire_id").val()
		}

		var data = { 
			"zone":"gl", 
			"action":"set_colocataire",
			"data": {
				"lk": data_ligne
			}
		};

		var data_json = '&json=' +JSON.stringify(data);
		var save_status=''; 

		$.getJSON("/GL?action=gl_coloc_location_valider",data_json, function(data){  
			

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
				Display_Table_Colocataires();
				
				/*  $.alert({
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
				});*/
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

    function Remove_Colocataire() {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

		var data_ligne = {
            "id": $('#record_id').val(),
			"id_origin_lk": $("#id_selected").val()
		}

        var data = {
            "zone": "gl",
            "data": {
                "data": data_ligne
            }
        };

        var data_json = 'json=' + JSON.stringify(data);

        var operation_status = '';

        $.getJSON("/GL?action=gl_remove_colocataire", data_json, function(data) {

		}).done(function() { //success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			Display_Table_Colocataires();
		});
    }

	function Get_Location_Data($id){

		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$('#titre_popup').html('Modification');

			var data_location = { 
				"id": $id
			};

			var data = { 
				"zone":"gl", 
				"action":"get_location",
				"data": {
					"location": data_location
				}
			};

			var data_json = '&json=' +JSON.stringify(data);

			$.getJSON("/GL?action=get_location",data_json, function(data){  

				$.each(data, function(key, value){ 
					$("#bien_en_location").attr('value', value.loc_bien_name);
					$("#loc_bien_id").attr('value', value.loc_bien_id);
					$("#usager").attr('value', value.loc_usager_name);
					$("#loc_hb_id").attr('value', value.loc_hb_id);
					$("#loc_montant_initial").attr('value', iw_round(value.loc_montant_initial));
					$("#loc_montant_revise").attr('value', iw_round(value.loc_montant_revise));
					$("#loc_garantie_montant").attr('value', iw_round(value.loc_garantie_montant));	
					$("#loc_duree_mois").attr('value', value.loc_duree_mois);
					$("#loc_statut").attr('value', value.loc_statut);
					$("#loc_referent").attr('value', value.loc_referent);
					$("#loc_coordinateur").attr('value', value.loc_coordinateur);

					UTL_Date_Picker_Formatted(value.loc_date,'#loc_date');	
					UTL_Date_Picker_Formatted(value.loc_date_entree,'#loc_date_entree');	
					UTL_Date_Picker_Formatted(value.loc_date_sortie,'#loc_date_sortie');	

					Init_Autocomplete_Usagers('#usager','#loc_hb_id','GB','get_autocomplete_locataires');
					//Init_Autocomplete('#bien_en_location','#loc_bien_id','GB','get_autocomplete_centres');

					if (value.loc_garantie_encaisse=='True'){
						$( "#loc_garantie_encaisse" ).prop( "checked", true );
					}

					$("input[type='checkbox']").on('change', function(){
						$(this).val(this.checked ? "true" : "false");
					})

					$('#loc_date_sortie').change(function(){

					});
				});

			}).done(function() {//success

			})
			.fail(function() { //error
				$.LoadingOverlay("hide");
			})
			.always(function() { //complete
				
				$.LoadingOverlay("hide");


			});  

	}

	function Save_Piece_Location(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var data_location = {
			"id": $("#record_id").val(),
			"loc_date": $("#loc_date").val(),
			"loc_hb_id": $("#loc_hb_id").val(),
			"loc_bien_id": $("#loc_bien_id").val(),
			"irc_irl": $("#irc_irl").val(),
			"loc_montant_initial": $("#loc_montant_initial").val(),
			"loc_montant_revise": $("#loc_montant_revise").val(),
			"loc_date_entree": $("#loc_date_entree").val(),
			"loc_date_sortie": $("#loc_date_sortie").val(),
			"loc_duree_mois": $("#loc_duree_mois").val(),
			"loc_garantie_montant": $("#loc_garantie_montant").val(),
			"loc_garantie_encaisse": $("#loc_garantie_encaisse").val(),
			"loc_statut": $("#loc_statut").val(),
			"loc_bien_nom": $("#bien_en_location").val(),	// pour garder l'historique	 
			"loc_titre": $("#usager").val()+ ' / ' +$("#bien_en_location").val()+ ' / ' +$("#loc_date").val(),	// pour garder l'historique	 ,
			"loc_apl": $("#loc_apl").is(":checked"),
			"loc_referent": $("#loc_referent").val(),
			"loc_coordinateur": $("#loc_coordinateur").val()
		}

		var data = { 
			"zone":"gl", 
			"action":"set_location",
			"data": {
				"location": data_location
			}
		};

		var data_json = '&json=' +JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=location_fiche_valider",data_json, function(data){  
			console.log(data);

			$.each(data, function(key, value){  
				save_status = value;
			});

			if (data.notificationError != null) {
    
				$.alert({
				  title: '',
				  content: data.notificationError,
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
				
			}

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function(response) { //complete

			switch (true) {
				case save_status == '':
					$("#bien_en_location").attr('disabled', 'disabled');

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
									btnClass: 'btn-blue',
									action: function () {
                                        window.location.href = 'GL?action=locations&getPreviousList=vrai';
									}
								}
							}
					});

					break;
				case save_status == 'overlap':

					$.alert({
						title: 'Erreur',
						content: 'Le bien est déja loué pendant la période choisie',
						icon: 'fa fa-remove',
						animation: 'scale',
						closeAnimation: 'scale',
						columnClass: 'iw_alert',
						buttons: {
							okay: {
								text: 'Ok',
								btnClass: 'btn-blue',
								action: function () {
								}
							}
						}
					});	

					break;
				case save_status == "Failed":

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

					break;
				default:
					break;
			}

			$.LoadingOverlay("hide");
		});
	}

    function Get_Record_Data_Generique($id,$table) {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

        $('#titre_popup_' +$table).html('Modification');

        var data_module = {
            "id": $id
        };

        var data = {
            "zone": "gl",
            "data": {
                "ligne": data_module
            }
        };

        var data_json = '&json=' + JSON.stringify(data);

        $.getJSON("/GL?action=get_"+$table, data_json, function(data) {
			endLoadData(data);
        }).done(function() { //success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            $.LoadingOverlay("hide");
        });
    }

	function endLoadData(data){

		$.each(data, function(key, value) {
			$("#loc_colocataire").attr("disabled", true);
			$("#loc_colocataire").val(value.hb_cle);
		});

	}
});