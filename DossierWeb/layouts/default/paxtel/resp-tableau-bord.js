var firstPassage_b = true;

$(document).ready(function () {
	var filtre_choisie = "";
	loadFiltres();

	$("#fdp-usager-clear").click(function () {
		document.getElementById("profile").reset();

		$("#centres_list").val('');
		$("#centres_list_id").val('');
		
		$("#criteres").val('');
		$("#criteres_json").val('');

		// Demande de réinitialisation des valeurs de popup géré par angular
		firstPassage_b = false;
	});

	function Search() {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		$('#int-usager .table').empty();
		$('#int-usager-result .table').empty();

		var autres_criteres = $.parseJSON($("#criteres_json").val());

		var data_search = {
			"zone": "heberge",
			"action": "get_hebergement_veille",
			"data": {
				"date_debut": $("#date_du").val(),
				"date_fin": $("#date_au").val(),
				"date_debut_premier_contact": $("#date_du_premier_contact").val(),
				"date_fin_premier_contact": $("#date_au_premier_contact").val(),
				"nom": $("#nom").val(),
				"phone": $("#telephone_numero").val(),
				"lien_famcle": $("#lien_famille").val(),
				"centre_referenceid": $("#centres_list_id").val(),
				"filtre": filtre_choisie,
				"autres_criteres": autres_criteres,
				"ficheUnique": ($('#filtre_fiche_unique').is(":checked") == true) ? "true" : "false"
			}
		};

		var data_json = '&json=' + JSON.stringify(data_search);

		$.getJSON("/INT?action=int_tableau_bord_json", data_json, function (data) {

			if (data.error_code < 0) {
				$('#int-usager-table .table').empty();

				$.alert({
					title: 'Alerte',
					content: data.message,
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

			} else {
				$('#int-usager-table .table').empty();
				
				if (data['hebergement_veille'].length > 0) {
					var resp_table_data = '';
					var css_class_row = '';
					var css_custom = '';

					var counter = 0;

					resp_table_data += '<div class="row iw_header_title_global">';

					resp_table_data += '<div class="cell" style="width: 200px;font-size: 12px !important;">';
					resp_table_data += 'Liste des situations :';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell fdp-min-width-130px" style="font-size: 12px !important;">';
					resp_table_data += data['hebergement_veille'].length;
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell">';
					resp_table_data += '';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell fdp-min-width-130px" style="font-size: 12px !important;">';
					resp_table_data += data['nbPersonne'];
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell">';
					resp_table_data += '';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell fdp-min-width-130px" style="font-size: 12px !important;">';
					resp_table_data += data['nbMenage'];
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell">';
					resp_table_data += '';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell">';
					resp_table_data += '';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell">';
					resp_table_data += '';
					resp_table_data += '</div>';

					resp_table_data += '</div>';

					resp_table_data += '<div class="row header">';

					resp_table_data += '<div class="cell " style="min-width: 60px;">';
					resp_table_data += 'Date';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell" style="min-width: 100px;">';
					resp_table_data += 'Clé';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell " style="min-width: 60px;">';
					resp_table_data += 'Clé lien fam.';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell" style="min-width: 120px;">';
					resp_table_data += 'Lieu';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell" style="min-width: 120px;">';
					resp_table_data += 'Etat civil';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell" style="min-width: 130px;">';
					resp_table_data += 'N° de téléphone';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell" style="min-width: 120px;">';
					resp_table_data += 'Prestation';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell" style="min-width: 120px;">';
					resp_table_data += 'Sortie';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell" style="min-width: 80px;">';
					resp_table_data += 'R';
					resp_table_data += '</div>';

					resp_table_data += '<div class="cell iw-txt-center" style="min-width: 60px;">';
					resp_table_data += 'C';
					resp_table_data += '</div>';
					
					resp_table_data += '</div>';
		
					$.each(data['hebergement_veille'], function (key, value) {
						css_class_row = '';
						css_custom = '';

						if (counter % 2 != 0) {
							css_class_row = ' iw-alternate';
						}

						if (value.isFamChief == true) {
							css_custom += 'font-weight: 600!important';
						}

						if (css_custom != "") {
							css_custom = ' style="' + css_custom + '"'
						}

						resp_table_data += '<div class="row body' + css_class_row + '" ' + css_custom + '>';

						resp_table_data += '<div class="cell" id="colf' + value.hg_fichenumero + '">';
						resp_table_data += (value.edit == true ? '<a href="/INT?action=usager-fiche&id=' + value.ID + '&hb_id=' + value.refId + '">' : "<span class='not-access'>");
						resp_table_data += value.hg_date.substring(0, 10);
						resp_table_data += (value.edit == true ? '</a>' : "</span>");
						resp_table_data += '</div>';

						resp_table_data += '<div class="cell" id="colf' + value.hg_fichenumero + '">';
						resp_table_data += (value.edit == true ? '<a href="/INT?action=usager-fiche&id=' + value.ID + '&hb_id=' + value.refId + '">' : "<span class='not-access'>");
						resp_table_data += value.hb_cle;
						resp_table_data += (value.edit == true ? '</a>' : "</span>");
						resp_table_data += '</div>';

						resp_table_data += '<div class="cell" id="colf' + value.hg_fichenumero + '">';
						resp_table_data += (value.edit == true ? '<a href="/INT?action=usager-fiche&id=' + value.ID + '&hb_id=' + value.refId + '">' : "<span class='not-access'>");
						resp_table_data += value.hg_famcle;
						resp_table_data += (value.edit == true ? '</a>' : "</span>");
						resp_table_data += '</div>';

						resp_table_data += '<div class="cell" id="colf' + value.hg_fichenumero + '">';
						resp_table_data += (value.edit == true ? '<a href="/INT?action=usager-fiche&id=' + value.ID + '&hb_id=' + value.refId + '">' : "<span class='not-access'>");
						resp_table_data += value.hg_lien;
						resp_table_data += (value.edit == true ? '</a>' : "</span>");
						resp_table_data += '</div>';

						resp_table_data += '<div class="cell" id="colf' + value.hg_fichenumero + '">';
						resp_table_data += (value.edit == true ? '<a href="/INT?action=usager-fiche&id=' + value.ID + '&hb_id=' + value.refId + '">' : "<span class='not-access'>");
						resp_table_data += value.hg_etatcivil;
						resp_table_data += (value.edit == true ? '</a>' : "</span>");
						resp_table_data += '</div>';

						resp_table_data += '<div class="cell" id="colf' + value.hg_fichenumero + '">';
						resp_table_data += (value.edit == true ? '<a href="/INT?action=usager-fiche&id=' + value.ID + '&hb_id=' + value.refId + '">' : "<span class='not-access'>");
						resp_table_data += value.hb_telephone;
						resp_table_data += (value.edit == true ? '</a>' : "</span>");
						resp_table_data += '</div>';

						resp_table_data += '<div class="cell" id="colf' + value.hg_fichenumero + '">';
						resp_table_data += (value.edit == true ? '<a href="/INT?action=usager-fiche&id=' + value.ID + '&hb_id=' + value.refId + '">' : "<span class='not-access'>");
						resp_table_data += value.prestation;
						resp_table_data += (value.edit == true ? '</a>' : "</span>");
						resp_table_data += '</div>';

						resp_table_data += '<div class="cell" id="colf' + value.hg_fichenumero + '">';
						resp_table_data += (value.edit == true ? '<a href="/INT?action=usager-fiche&id=' + value.ID + '&hb_id=' + value.refId + '">' : "<span class='not-access'>");
						resp_table_data += value.autresolution;
						resp_table_data += (value.edit == true ? '</a>' : "</span>");
						resp_table_data += '</div>';

						resp_table_data += '<div class="cell" id="colf' + value.hg_fichenumero + '">';
						resp_table_data += (value.edit == true ? '<a href="/INT?action=usager-fiche&id=' + value.ID + '&hb_id=' + value.refId + '">' : "<span class='not-access'>");
						resp_table_data += value.rapport_reste;
						resp_table_data += (value.edit == true ? '</a>' : "</span>");
						resp_table_data += '</div>';

						resp_table_data += '<div class="cell iw-txt-center" id="colf' + value.hg_fichenumero + '">';

						if (value.hg_cloturee == true) {
							resp_table_data += '<i class="fa fa-check-square-o fdp-icon-green"></i>';
						} else {
							resp_table_data += '<i class="fa fa-times fdp-icon-red"></i>';
						}

						resp_table_data += '</div>';

						resp_table_data += '</div>';
						counter = counter + 1;
					});

					$("#int-usager-table .table").append(resp_table_data);

					$(".not-access").on('click', function () {

						$.alert({
							title: 'Erreur',
							content: 'Vous ne disposez pas des privilèges d\'accès à cette fonction',
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
				
					});
				}

			}

		}).done(function () {//success

		})
		.fail(function () { //error

		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
			$("#int-usager-table .table").show();
		});

		return false;
	}

	$('#int-usager-table .table').empty();

	$("#fdp-usager-search").click(function () {
		Search();
	});

	$('input[type=checkbox], input[type=radio]').change(function(e) {
		setFiltres(e);
		Search();
	});

	function setFiltres(e) {
		var filtre_jour = document.getElementById("filtre_jour");
		var filtre_nuit = document.getElementById("filtre_nuit");
		var filtre_jour_nuit = document.getElementById("filtre_jour_nuit");

		if (e.target.id == 'filtre_jour') {
			filtre_choisie = 'jour';
		} else if (e.target.id == 'filtre_nuit') {
			filtre_choisie = 'nuit';
		} else {
			filtre_choisie = 'jour_nuit';
		}
	}

	function loadFiltres() {
		var filtre_jour = document.getElementById("filtre_jour");
		var filtre_nuit = document.getElementById("filtre_nuit");
		var filtre_jour_nuit = document.getElementById("filtre_jour_nuit");

		filtre_jour_nuit.checked = true;
		filtre_nuit.checked = false;
		filtre_jour.checked = false;
		filtre_choisie = 'jour_nuit';
	}

	$("#fdp-usager-search").click();
});

function centres_listmodalOnLoad($scopeAngular_o){
	visiteur.prestationModalAngularList = $scopeAngular_o;
}

function centres_listmodalOnShownModal(){
	var $itemListHTML_t = "";

	if ($("#centres_listmodalCategoryButttonList").length == 0) {
		var $inputSearchModalDiv_j = $("#centres_listmodal").find(".search").eq(0).closest(".form-group");

		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});
	
		$.LoadingOverlay("show");

		$.ajax({
			method: 'POST',
			url: "/4DACTION/outilsWebEnumerationAjax",
			data: {
				"enumerationLib": "Centre: Catégorie"
			},
			success: function(response){
				var reponseParse = JSON.parse(response);
				console.log(reponseParse);
				
				$itemListHTML_t = '\
				<h3 class="text-center">Filtre par catégorie</h3>\
				<div id="centres_listmodalCategoryButttonList" class="rowB g-mb-10">'

				if (reponseParse.enumerationItem != null) {
					
					reponseParse.enumerationItem.forEach(item => {
						$itemListHTML_t += 
						'<div class="col-4">\
							<button class="fdp_Button fdp_btn_top categoryModalList" style="width: 100%!important" onclick="return false;">' + item + '</button>\
						</div>'
					});

				}

				$itemListHTML_t += 
				'\
					<div class="col-4">\
						<button class="fdp_Button fdp_btn_top categoryModalList" style="width: 100%!important" onclick="return false;">Toutes</button>\
					</div>\
				</div>'

				$($itemListHTML_t).insertAfter($inputSearchModalDiv_j);	
		
				$(".categoryModalList").click(function(){
					var $search_t = $(this).text();

					$(".categoryModalList").removeClass("fdp-btn-green");
					$(this).addClass("fdp-btn-green");

					$.LoadingOverlay("show");
					
					$("#centres_listmodal").find(".item-label").each(function(){
						$(this).closest("tr").hide();
						
						if ($search_t == "Toutes") {
							$(this).closest("tr").show();
						}else{
							var $line_o = searchInArrayObject(visiteur.prestationModalAngularList.list, "id", $(this).find("input").val());
							console.log($line_o);
	
							if ($line_o != null) {
	
								if ($line_o.categorie == $search_t) {
									$(this).closest("tr").show();
								}
								
							}
	
						}

					});

					$.LoadingOverlay("hide");
				});
	
				$.LoadingOverlay("hide");
			}
		});
	}

	$(".categoryModalList").removeClass("fdp-btn-green");
}