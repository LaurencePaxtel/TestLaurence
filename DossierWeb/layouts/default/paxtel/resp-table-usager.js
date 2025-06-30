var filtre_choisie = "";
var required_fields = $("#mandatory").val().split(';');

var firstPassage_b = false;

var dataTable_o = {};

var lineInfo_c = [];
var firstPassageDetail_c = [];

$(document).ready(function(){
	loadFiltres();
	 
	$('#table_name').val('Documents usagers');
	$('#module_name').val('Usagers');

	var var_nav_module = $('#nav_module').val();

	switch (true) {
		case (visiteur.resetPassword != null): // Rémy Scanu <01/12/2023> - Ajout du code pour réinitialiser un mot de passe
			$("#modalReinitialiserMotDePasse").modal('show');
			break;
		case (visiteur.login != null): // Rémy Scanu <25/07/2024> - Ajout du code pour ouvrir 2° onglet transmission
			window.open('/INT?action=transmission', '_blank');
			break;
		default:
			break;
	}

	// Rémy Scanu <07/02/2024> - Ajout du code pour réappliquer les filtres si l'utilisateur a cliqué sur le bouton "Valider" dans une fiche hébergement
	managePreviousDataFilter("supprimer", "locataires", "fdp-usager-search");

	// Rémy Scanu <07/02/2024> - Ajout du code pour initialiser un objet qui contient tous les firstPassage pour chaque modal angular
	$("#mp_groupe_hg, #mp_centre_hg").each(function(){
		$this = $(this);

		firstPassageDetail_c.push({
			"modalID" : $this.attr("id") + "modal",
			"firstPassage" : false
		});
	});

    $.fn.serializeFormJSON = function () {
        var o = {};
        var a = this.serializeArray();

        $.each(a, function () {

            if (o[this.name]) {

                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }

                o[this.name].push(this.value || '');
            }else {
                o[this.name] = this.value || '';
            }
        });

        return o;
    };

	$("#fdp-usager-search").click(function(){  
		Search_Usager();
		return false;
	});  

	$("#nom").focusout(function () {
		Search_Usager();	
	});

	$("#prenom").focusout(function () {
		Search_Usager();	
	});

	$("#int-usager-table div").click(function(ev){ 

		if (ev.target.id.substring(4) != ''){
			$("#doc_origine_id").val(ev.target.id.substring(4));
			$("#record_id").val(ev.target.id.substring(4));

			var var_selected_cle = $("#clev" + ev.target.id.substring(4)).val()

			$('#nav_module').val(var_nav_module +" " + var_selected_cle+" / ");
			$.LoadingOverlay("show");

			var data_search = {
				"cle": ev.target.id.substring(4),
				"filtre": filtre_choisie
			};
	
			$('#cle').val($('#clev' + ev.target.id.substring(4)).val());
			$('#hb_referenceid').val($('#refid'+ev.target.id.substring(4)).val());

			$.getJSON("/INT?action=usager_list_json_rt",data_search, function(data){  
				$('#int-usager-result .table').empty();

				var resp_table_data='';
				var counter = 0;

				resp_table_data += '<div class="row iw_header_title_global">';
				resp_table_data += '<div class="cell" style="min-width:30px; text-align:left;">'
				resp_table_data += '';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell fdp-min-width-130px" style="font-size: 12px !important;">';
				resp_table_data += 'Liste des situations : ';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell fdp-min-width-110px" style="font-size: 12px !important;">';
				resp_table_data += data.length
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell fdp-min-width-130px" style="font-size: 12px !important;">';
				resp_table_data += '(Limité à 400 lignes)';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell">';
				resp_table_data += '';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell fdp-min-width-60px">';
				resp_table_data += '';
				resp_table_data += '</div>';
				resp_table_data += '</div>'; 

				resp_table_data += '<div class="row header">';
				resp_table_data += '<div class="cell" style="min-width:30px; text-align:left;">'
				resp_table_data += '';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell fdp-min-width-60px">';
				resp_table_data += 'Date';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell fdp-min-width-60px">';
				resp_table_data += 'Plateforme';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell fdp-min-width-130px">';
				resp_table_data += 'Action';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell">';
				resp_table_data += 'Sortie';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell">';
				resp_table_data += 'Réservation';
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell fdp-min-width-60px">';
				resp_table_data += 'Approuvée';
				resp_table_data += '</div>';
				resp_table_data += '</div>'; 

				$.each(data, function(key, value){  
					css_class_row='';

					if (counter % 2 != 0){
						css_class_row='iw-alternate'; 
					}

					resp_table_data += '<div class="row body '+css_class_row+'">';
					resp_table_data += '<div class="cell" id="'+ value.id +'" >';

					if (value.checkbox == true) {
						resp_table_data += '<input type="checkbox" id="chx_'+ value.id +'" name="chx_'+ value.id +'" class="iw_select" style="text-align:left;margin:0px 5px 0px 0px;">'	
					}
					
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell">';
					resp_table_data += (value.edit == true ? '<a class="goToRecord" href="/INT?action=usager-fiche&id=' + value.id + '&hb_id=' + value.hg_hb_id + '">' : "<span class='not-access'>");
					resp_table_data += dateToJJMMYYYY(value.date.substring(0,10));
					resp_table_data += (value.edit == true ? '</a>' : "</span>");
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell">';
					resp_table_data += (value.edit == true ? '<a class="goToRecord" href="/INT?action=usager-fiche&id=' + value.id + '&hb_id=' + value.hg_hb_id + '">' : "<span class='not-access'>");
					resp_table_data += value.plateforme
					resp_table_data += (value.edit == true ? '</a>' : "</span>");
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell">';
					resp_table_data += (value.edit == true ? '<a class="goToRecord" href="/INT?action=usager-fiche&id=' + value.id + '&hb_id=' + value.hg_hb_id + '">' : "<span class='not-access'>");
					resp_table_data += value.prestation;
					resp_table_data += (value.edit == true ? '</a>' : "</span>");
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell">';
					resp_table_data += (value.edit == true ? '<a class="goToRecord" href="/INT?action=usager-fiche&id=' + value.id + '&hb_id=' + value.hg_hb_id + '">' : "<span class='not-access'>");
					resp_table_data += value.autresolution;
					resp_table_data += (value.edit == true ? '</a>' : "</span>");
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell">';
					resp_table_data += (value.edit == true ? '<a class="goToRecord" href="/INT?action=usager-fiche&id=' + value.id + '&hb_id=' + value.hg_hb_id + '">' : "<span class='not-access'>");
					resp_table_data += value.reservation;
					resp_table_data += (value.edit == true ? '</a>' : "</span>");
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell">';
					resp_table_data += (value.edit == true ? '<a class="goToRecord" href="/INT?action=usager-fiche&id=' + value.id + '&hb_id=' + value.hg_hb_id + '">' : "<span class='not-access'>");

					if ((value.c=='True') || (value.c=='Vrai')){
						resp_table_data += '<i class="fa fa-check-square-o fdp-icon-green"></i>';
					}else{
						resp_table_data += '<i class="fa fa-times fdp-icon-red"></i>';
					}

					resp_table_data += (value.edit == true ? '</a>' : "</span>");
					resp_table_data += '</div>';
					resp_table_data += '</div>';

					counter = counter + 1;
				});  

				$("#int-usager-result .table").append(resp_table_data);

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

				$(".goToRecord").click(function(event){
					event.preventDefault();
					var $rowSelected_j = $(".row-selected");

					$.LoadingOverlay("show");
					managePreviousDataFilter("sauvegarder", "locataires", "", $(this).attr("href"), 
					[
						"nom",
						"prenom",
						"date_naissance",
						"lien_famille",
						"telephone",
						{
							"name": "filtre",
							"value": filtre_choisie
						},
						{
							"name": "rowSelected",
							"value": $("#int-usager-table").find(".row").index($rowSelected_j)
						}
					]);
					
				});
				
			}).done(function() {//success
			})
			.fail(function() { //error
			})
			.always(function() { //complete
				$("#int-usager-result .table").show();
				$("#usager-btns").show();

				Get_Heberge_Data();

				setTimeout(() => {
					$.LoadingOverlay("hide");

					// Rémy Scanu <07/02/2024> - Ajout du code pour sélectionner un hébergé en particulier
					if (rowSelect_el > 0) {
						$("#int-usager-table").find(".row").eq(rowSelect_el).find("div").eq(0).click();
						rowSelect_el = 0;
					}

				}, 1000);

			});
		}

	});

    $('#fdp_usager_pointage').on('click', function () {

		$.confirm({
			title: 'Pointage',
			content: 'Voulez-vous vraiment effectuer le pointage de cet usager ?',
			icon: 'fa fa-warning',
			animation: 'scale',
			closeAnimation: 'zoom',
			columnClass: 'iw_alert',
			buttons: {
				confirm: {
					text: 'Oui',
					btnClass: 'btn-orange',
					action: function () {
						Execute_Usager_Pointage();
					}
				},
				cancel: {
					text: 'Non',
					action: function () {

					
					}
				}
			}
		});

        return false;
    });

	/***************************************************************************************** */
	/* Multi-pointage*/
	/***************************************************************************************** */
	$('#fdp_usager_multi_pointage').on('click', function () {

		if (($("#record_id").val() != '0') && ($("#record_id").val() != '')){
			Show_Popup_Fiche_HG();
		}else{
	
			$.alert({
				title: 'Erreur',
				content: 'Vous devez sélectionner un usager',
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
	
		}		

        return false;
	});

	// Sur clic du bouton "Valider" du modal Prestation
	$("#mp_centre_hgmodal").find(".modal-footer > button").eq(2).click(function(){
		$("#quantitePrestationToDelete").empty();

		$("#mp_centre_hgmodal").find("input[type='text']").val("");
		$("#mp_centre_hgmodal").find("input[type='text']").change();

		if ($("#mp_centre_hgmodal").find("input:checked").length > 0) {
			$("#quantitePrestationToDelete").prepend("<div class=\"rowB\"><div class=\"col-6\"><h6>Nom Prestation</h6></div><div class=\"col-3\"><h6>Modifier la quantité</h6></div><div class=\"col-3\"><h6>Modifier le montant</h6></div></div><div class=\"rowB\"><div class=\"col-12\"><ul></ul></div></div>")
		}

		$("#mp_centre_hgmodal").find("input:checked").each(function(){
			var $lib_t = $(this).closest("label").text();
			var $quantite_t = "1";
			var $montant_t = "0";

			var $line_o = searchInArrayObject(lineInfo_c, "id", $(this).val());

			if ($line_o != null) {
				$quantite_t = $line_o.quantite
				$montant_t = $line_o.montant
			}else{

				lineInfo_c.push(
					{
						"id" : $(this).val(),
						"quantite" : "1",
						"montant" : "0"
					}
				)
			}

			$("#quantitePrestationToDelete ul").append($("<li class=\"liQuantite g-mb-20 rowB\">").html("<div class=\"col-6\">" + $lib_t + "<input class=\"inputPrestationID\" type=\"hidden\" value=\"" + $(this).val() + "\" /></div><div class=\"col-3\"><input type=\"number\" class=\"d-inline-block quantiteInputNB text-right\" value=\"" + $quantite_t + "\" /></div><div class=\"col-3\"><input type=\"number\" class=\"d-inline-block montantInputNB text-right\" value=\"" + $montant_t + "\" /></div>"));
		});

		// Sur changement d'un input quantité
		$(".quantiteInputNB").change(function(){
			var $id_t = $(this).closest("li").find(".inputPrestationID").val();
			var $line_o = searchInArrayObject(lineInfo_c,"id",$id_t);

			if ($line_o != null) {
				$line_o.quantite = $(this).val();
			}

		});

		// Sur changement d'un input montant
		$(".montantInputNB").change(function(){
			var $id_t = $(this).closest("li").find(".inputPrestationID").val();
			var $line_o = searchInArrayObject(lineInfo_c, "id", $id_t);

			if ($line_o != null) {
				$line_o.montant = $(this).val();
			}

		});

		$('.liQuantite').css({"list-style-type": "decimal"});
		$('#quantitePrestationToDelete').css({"text-align": "left", "max-height": "400px", "overflow-x": "hidden", "overflow-y": "scroll"});
	});
	
	// Sur clic du bouton "Valider" du modal Multi-pointage
	$('#btn_popup_save').click(function(){

        $.confirm({
            title: 'Notification',
            content: 'Êtes-vous sûr de vouloir créer ces fiches pour ' + $('#cle').val() + ' ? ',
            icon: 'fa fa-warning',
            animation: 'scale',
            closeAnimation: 'zoom',
            columnClass: 'iw_alert',
            buttons: {
                confirm: {
                    text: 'Oui',
                    btnClass: 'btn-orange',
                    action: function () {
                        HG_Creation_Fiches();
                    }
                },
                cancel: {
					text: 'Non',
					action: function () {
						
					}
               	}
            }
        });

  	});

	// Sur clic du bouton "Annuler" du modal Multi-pointage
	$('#btn_popup_close').click(function(){
		$('#iw_form_popup_hg').hide();
	});

    $('#fdp_usager_multi_pointage_').on('click', function () {

		$.confirm({
			title: 'Pointage',
			content: 'Voulez-vous vraiment effectuer le pointage des fiches de usagers sélectionnés ?',
			icon: 'fa fa-warning',
			animation: 'scale',
			closeAnimation: 'zoom',
			columnClass: 'iw_alert',
			buttons: {
				confirm: {
					text: 'Oui',
					btnClass: 'btn-orange',
					action: function () {
						Execute_Usager_Pointage_Multiple();
					}
				},
				cancel: {
					text: 'Non',
					action: function () {
					}
				}
			}
		});

        return false;
    });

    $('#fdp_usager_notes').on('click', function () {
		var clone = $('#iw_notes').find(".portlet").clone()

		$('#iw_notes').html("");

        $.confirm({
            title: 'Gestion des coordonnées',
            columnClass: 'iw_popup_form',
            content: '<div id=\"insertContent\"></div>',
            buttons: {
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'iw_btn_right',
                    action: function () {
                        Save_Notes();

						$('#insertContent').html("");
						$('#iw_notes').html(clone);

                        return true;
                    }
                },
				cancel: {
					text: 'Fermer',
                    btnClass: 'iw_btn_right',
					action: function () {
						$('#insertContent').html("");
						$('#iw_notes').html(clone);
					}
				}
            },
            onContentReady: function () {
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click');
                });

				$('#insertContent').html(clone);

				$('#modifDemandeur').on('click', function () {

					if ($(this).is(':checked')) {
						switchEnabledMultipleElement(["#nomHB", "#prenomHB", "#dateNaissanceHB"], false);
					}else{
						switchEnabledMultipleElement(["#nomHB", "#prenomHB", "#dateNaissanceHB"], true);
					}

				});
            }
        });

        return false;
    });

    $('#fdp_usager_sp').on('click', function () {
        var var_notes = $('#iw_notes_sp').html();

        $('#iw_notes_sp').html('');

        $.confirm({
            title: '',
            content: '' +
            '<div>' + var_notes +     
            '</div>',
            buttons: {
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'btn-blue',
                    action: function () {
                        Save_Notes_SP();

                        var_notes = $('#iw_notes_sp_child').html();

                        $("#iw_notes_sp").prepend("<div id='iw_notes_sp_child'></div>");
                        $('#iw_notes_sp_child').html(var_notes);

                        return true;
                    }
                },
                  cancel: {
                    text: 'Fermer',
                    action: function () {
                        var_notes = $('#iw_notes_sp_child').html();

                        $("#iw_notes_sp").prepend("<div id='iw_notes_sp_child'></div>");
                        $('#iw_notes_sp_child').html(var_notes);
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

				$('.datepicker').datepicker({
					format: 'dd/mm/yyyy',
					locale: 'fr'
				});

				$("input[type='checkbox']").on('change', function(){
			       $(this).val(this.checked ? "true" : "false");
			    })

				$("#iw_notes_sp_child .search").change(function() { 
					var id = $(this).attr('id');

					document.getElementById(id).setAttribute("value", $(this).val());
				}); 

				$("#iw_notes_sp_child .iw_checkbox_wt").change(function() { 
					var id = $(this).attr('id');

					if (document.getElementById(id).checked){
						document.getElementById(id).setAttribute("checked", "true");
					}else{
						document.getElementById(id).setAttribute("checked", "false");
					}
				});

				$(".inputOriginal").removeClass("inputOriginal");
				$(".cloneInputEditable").remove();


				// Un peu de mise en forme
				$("#iw_notes_sp_child .search").each(function(){

					if ($(this).hasClass("datepicker") == false) {
						$(this).css('cssText', 'display: none;');

						$(this).addClass("inputOriginal");
						$(this).after('<textarea class="cloneInputEditable span7 search fdp_placeholder iw_width100p" contenteditable="true">' + $(this).val() + '</textarea>');
					}

				});

				var hiddenInput = document.getElementsByClassName('inputOriginal');
				var visibleInput = document.getElementsByClassName('cloneInputEditable');

				$(visibleInput).change(function(){
					$this = $(this);

					$this.closest(".cell").find("input").eq(0).val($this.val());
					adjustHeight($this, false);
				})
				
				adjustHeight($(visibleInput), true);
            }
        });

        return false;
    });

	$('#fdp-usager-add').on('click', function () {
		Add_New_Usager(false);          
	});

	$('#fdp_usager_add').on('click', function () {
		Nouvelle_Fiche();
	});

	$('#fdp_usager_add_presta').on('click', function () {
		Nouvelle_Fiche_Prestation();
	});

	// Ajouté par Scanu Rémy : (16/05/2023)
	$('#fdp-usager-inconnu').on('click', function () {
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$.ajax({
			type: "GET",
			url: "/4DACTION/outilsWebGenerateInconnu",
			data: {},
			success: function (response) {
				var reponseParse = JSON.parse(response);
				console.log(reponseParse);

				if (reponseParse.etat == true) {
					$("#nom").val(reponseParse.inconnu["nom"]);
					$("#prenom").val(reponseParse.inconnu["prenom"]);
					//$("#date_naissance").val(reponseParse.inconnu["dateNaissance"]);
					$("#date_naissance").datepicker('setDate', new Date(dateToYYYYMMJJ(reponseParse.inconnu["dateNaissance"])));
				}

				$.LoadingOverlay("hide");
			}
		});
	});

    $(document).on('change', '#locataires_content input[type="checkbox"]', function(e){
		setFiltres(e);
		Search_Usager();
    });

	// Ajouté par Scanu Rémy : (16/05/2023)
	$('#fdp_usager_situationBudgetaire').on('click', function () {

		if ($(".row-selected").length > 0){
			 // $("#modalSituationBudgetaire").modal('show');
			window.open('/INT?action=situation-budgetaire&hebergeId=' + $('#record_id').val(), '_blank').focus();
		}else{

			$.alert({
				title: 'Erreur',
				content: 'Vous devez sélectionner un usager',
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
	
		}		

        return false;
	});

    // A la fin du chargement complet du modal
    $('#modalSituationBudgetaire').on('shown', function (e) {
		$(".modal").css("margin-left", "");

		if (window.innerWidth > 991) {
			$(".modal").css({"margin-left": "-505px"});
		}
		
		$("#modalSituationBudgetaire").find(".modal-title").text("Situation budgetaire de " + $(".row-selected").find(".cle").text());

		// Obtention de la hauteur de l'écran
		var screenHeight = window.innerHeight;

		// Calcul de la hauteur à affecter à la div
		var divHeight = screenHeight - (0.08 * screenHeight) - 200;

		// Sélection de la div par son ID et affectation de la hauteur calculée
		var divElement = document.getElementById("modalBodySituationBudgetaire");

		divElement.style["overflow-y"] = "auto";
		divElement.style.height = divHeight + "px";
		divElement.style.setProperty("max-height", divHeight + "px", "important");

		displayData();
	});

	// Ajouté par Scanu Rémy : (01/06/2023)
	$('#fdp_usager_imprimerDocument').on('click', function () {

		if ($(".row-selected").length > 0){
			$("#modalImprimerDocument").modal('show');
		}else{

			$.alert({
				title: 'Erreur',
				content: 'Vous devez sélectionner un usager',
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
	
		}		

        return false;
	});

    // A la fin du chargement complet du modal
    $('#modalImprimerDocument').on('shown', function (e) {
		$(".modal").css("margin-left", "");

		if (window.innerWidth > 991) {
			$(".modal").css({"margin-left": "-505px"});
		}
		
		$("#modalImprimerDocument").find(".modal-title").text("Imprimer un document pour " + $(".row-selected").find(".cle").text());

		$("#4DWriteIframe").attr("src", "");
		$('#4DWriteIframe').css('cssText', '');
		chargeValueInSelect("listeDocument", "/4DACTION/outilsWebHebergeDocumentAjax", {"hebergeID": $('#record_id').val(),"action": "chargeDocument"});
	});

	// A la fin du chargement complet du modal
	$('#modalReinitialiserMotDePasse').on('shown', function (e) {
		$(".modal").css("margin-left", "");

		if (window.innerWidth > 991) {
			$(".modal").css({"margin-left": "-505px"});
		}

		if (visiteur.cgu != null) {
			$('#CGUIframe').css('cssText', 'display: block !important; width: 21cm; margin: 0 auto;');
			$('#CGUCheckbox').append('<div class="rowB g-mb-10"><div class="col-1"><input id="acceptCGU" name="acceptCGU" type="checkbox" class="g-width-100x" required /></div> <div class="col-11"> J\'accepte les conditions CGU</div></div>');
		}

		resetFieldInForm("formulaireReinitialiserMotDePasse");
	});

	// Ajouté par Scanu Rémy : (22/06/2023)
	$('#fdp_usager_nouvellesNotes').on('click', function () {

		if ($(".row-selected").length > 0){
			$("#modalNouvelleNote").modal('show');
		}else{

			$.alert({
				title: 'Erreur',
				content: 'Vous devez sélectionner un usager',
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
	
		}		

        return false;
	});

    // A la fin du chargement complet du modal
    $('#modalNouvelleNote').on('shown', function (e) {
		$(".modal").css("margin-left", "");

		if (window.innerWidth > 991) {
			$(".modal").css({"margin-left": "-505px"});
		}

		$("#modalNouvelleNote").find(".modal-title").text("Note de " + $(".row-selected").find(".cle").text());
		chargeValueInSelect("typeNote", "/4DACTION/outilsWebHebergeListeAjax", {"hebergeID": $('#record_id').val(),"action": "chargeTypeNote"});
		updateDataTableNote({
			"hebergeID": $('#record_id').val(),
			"action": "chargeNote",
			"typeNote": $("#typeNote").val(),
			"keyword": $("#keyword").val(),
			"dateDu": dateToJJMMYYYY($("#noteDu").val()),
			"dateAu": dateToJJMMYYYY($("#noteAu").val())
		});
	});

	// Ajouté par Scanu Rémy : (10/04/2024)
	$('#fdp_usager_hebergement_delete').on('click', function () {

		if ($(".row-selected").length > 0){

			if ($("#int-usager-result").find("input[type='checkbox']:checked").length > 0) {
				var $dateDebut_t = "";
				var $dateFin_t = "";

				var $id_c = [];

				$("#int-usager-result").find("input[type='checkbox']:checked").each(function(){
					var $this = $(this);
					var $dateFiche_t = dateToYYYYMMJJ($this.closest(".row").find(".cell").eq(1).text());

					$id_c.push(extractNumber($this.attr("id")));

					switch (true) {
						case $dateDebut_t == "":
							$dateDebut_t = $dateFiche_t;

							break;
						case isGreaterDate($dateFiche_t, $dateDebut_t) == false:
							$dateDebut_t = $dateFiche_t;

							break;
						default:
							break;
					}

					switch (true) {
						case $dateFin_t == "":
							$dateFin_t = $dateFiche_t;

							break;
						case isGreaterDate($dateFiche_t, $dateFin_t) == true:
							$dateFin_t = $dateFiche_t;
							
							break;
						default:
							break;
					}
					
				});

				$.confirm({
					title: 'Pointage',
					content: 'Êtes-vous sûr de supprimer ' + $("#int-usager-result").find("input[type='checkbox']:checked").length.toString() + ' fiche(s) de ' + $(".row-selected").find(".cle").text() + ' sur cette plage de dates : Du ' + dateToJJMMYYYY($dateDebut_t) + ' au ' + dateToJJMMYYYY($dateFin_t) + '?',
					icon: 'fa fa-warning',
					animation: 'scale',
					closeAnimation: 'zoom',
					columnClass: 'iw_alert',
					buttons: {
						confirm: {
							text: 'Oui',
							btnClass: 'btn-orange',
							action: function () {
								$.LoadingOverlay("show");

								$.ajax({
									method: 'POST',
									url: "/4DACTION/outilsWebHebergeListeAjax",
									data: {
										"action": "deleteHebergement",
										"hebergeID": $('#record_id').val(),
										"hebergementIDS" : JSON.stringify($id_c)
										},
									success: function(response){
										var reponseParse = JSON.parse(response);
										console.log(reponseParse);
							
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

											$.alert({
												title: 'Succès',
												content: 'Suppression effectuée avec succès !',
												icon: 'fa fa-check',
												animation: 'scale',
												closeAnimation: 'scale',
												columnClass: 'iw_alert',
												buttons: {
													okay: {
														text: 'Ok',
														btnClass: 'btn-blue',
														action: function () {
															var $nbFiche_t = ($(".row-selected").find(".cell").eq(2).text() - $("#int-usager-result").find("input[type='checkbox']:checked").length).toString();

															$(".row-selected").find(".cell").eq(2).text($nbFiche_t);
															$(".row-selected").find(".cle").click();
														}
													}
												}
											});

										}
							
										$.LoadingOverlay("hide");
									}
								});

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
					title: 'Erreur',
					content: 'Vous devez sélectionner une ou plusieurs fiches',
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

			}

		}else{

			$.alert({
				title: 'Erreur',
				content: 'Vous devez sélectionner un usager',
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
	
		}		

        return false;
	});

});

function displayData() {
	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	/*$('#tableRecapBudgetaire > tbody').empty();
	ajouterLignesColonnes("tableRecapBudgetaire", 2, 5, ["Salaire", "0", "Loyer", "0", "", "APL", "0", "Nouvelle charge", "0", ""]);*/
	deleteRowToTable("tableRecapBudgetaire", 2);
	setContentToTable("tableRecapBudgetaire", ["Salaire", "0", "Loyer", "0", "", "APL", "0", "Nouvelle charge", "0", "<button type=\"button\" class=\"g-width-20 btn btn-sm rowfy-addrow d-none-print btn-success\">+</button>"]);

	deleteClassAndIDOnJqueryElement($('#tableRecapBudgetaire > tbody').find("tr:eq(1)").find('td:eq(0)')).then(function() {
		$('#tableRecapBudgetaire > tbody').find("tr:eq(1)").find('td:eq(0)').addClass("cell");
		$('#tableRecapBudgetaire > tbody').find("tr:eq(1)").find('td:eq(0)').removeAttr("data-type");
		$('#tableRecapBudgetaire > tbody').find("tr:eq(1)").find('td:eq(0)').text("APL");
	});
		
	deleteClassAndIDOnJqueryElement($('#tableRecapBudgetaire > tbody').find("tr:eq(1)").find('td:eq(1)')).then(function() {
		$('#tableRecapBudgetaire > tbody').find("tr:eq(1)").find('td:eq(1)').attr("id", "aplCell");
		$('#tableRecapBudgetaire > tbody').find("tr:eq(1)").find('td:eq(1)').addClass("cell numericEdit");
		$('#tableRecapBudgetaire > tbody').find("tr:eq(1)").find('td:eq(1)').attr("data-type", "aplValue");
		$('#tableRecapBudgetaire > tbody').find("tr:eq(1)").find('td:eq(1)').text("0");
	});

	// On vide le contenu de la 5°colonne de la première ligne généré par le plugin rowfy
	$('#tableRecapBudgetaire > tbody').find("tr:eq(0)").find('td:eq(4)').html("");

	deleteRowToTable("tableDette", 1);
	setContentToTable("tableDette", ["Nouvelle dette", "0", null, null, null, null, null, null, null, null, "<button type=\"button\" class=\"g-width-20 btn btn-sm rowfy-addrow d-none-print btn-success\">+</button>"]);

	$("#derniereSituationBudgetaire").val(dateJSToYYYYMMJJ(new Date()));
	$("#nombrePersonneMenage").val("1");
	$("#modeFacturation").val("");
	$("#commentaire").val("");
	
	$.ajax({
		method: 'POST',
		url: "/4DACTION/outilsWebHebergeSitBjtAjax",
		data: {
			"id": $('#record_id').val(),
			"hebergeID": $('#record_id').val(),
			"action": "chargeBudget"
		},
		success: function(response){
			var reponseParse = JSON.parse(response);
			reponseParse.data = JSON.parse(reponseParse.data);

			console.log(reponseParse);

			if (reponseParse.data != null) {

				if (reponseParse.data.budget.salaire != null) {
					$("#salaireCell").text(reponseParse.data.budget.salaire.toString().replaceAll(",", "."));
				}

				if (reponseParse.data.budget.loyer != null) {
					$("#loyerCell").text(reponseParse.data.budget.loyer.toString().replaceAll(",", "."));
				}
				
				if (reponseParse.data.budget.apl != null) {
					$("#aplCell").text(reponseParse.data.budget.apl.toString().replaceAll(",", "."));
				}
				
				if (reponseParse.data.dateSitBudget != null) {
					$("#derniereSituationBudgetaire").val(reponseParse.data.dateSitBudget);
				}

				if(responseParse.data.modeFacturation != null){
					$("#modeFacturation").val(reponseParse.data.modeFacturation);
				}

				if (reponseParse.data.nbPersonneMenage != null) {
					$("#nombrePersonneMenage").val(reponseParse.data.nbPersonneMenage);
				}

				if (reponseParse.data.commentaire != null) {
					$("#commentaire").val(reponseParse.data.commentaire);
				}
		
				// Génération des lignes "charges" avec le plugin rowfy (on commence à 1 car on enlève la première ligne Loyer)
				reponseParse.data.budget.charge.forEach(function (charge, i) {

					if (i > 0 && i < reponseParse.data.budget.charge.length) {
						$("#tableRecapBudgetaire").find(".rowfy-addrow").click();
					}
					
					$('#tableRecapBudgetaire > tbody').find('tr:eq(' + (1 + i).toString() + ')').find('td:eq(2)').text(charge.lib);
					$('#tableRecapBudgetaire > tbody').find('tr:eq(' + (1 + i).toString() + ')').find('td:eq(3)').text(charge.value.toString().replaceAll(",", "."));

				});
		
				// Génération des lignes ressource avec le plugin rowfy (on commence à 2 car on enlève les 2° premières lignes Salaire et APL)
				reponseParse.data.budget.ressource.forEach(function (ressource, i) {
					$('#tableRecapBudgetaire > tbody').find('tr:eq(' + (2 + i).toString() + ')').find('td:eq(0)').text(ressource.lib);
					$('#tableRecapBudgetaire > tbody').find('tr:eq(' + (2 + i).toString() + ')').find('td:eq(1)').text(ressource.value.toString().replaceAll(",", "."));
				});
				
				// Génération des lignes "dette" avec le plugin rowfy
				reponseParse.data.dette.detail.forEach(function (dette, i) {
		
					if (i > 0 && i < reponseParse.data.dette.detail.length) {
						$("#tableDette").find(".rowfy-addrow").click();
					}
					
					setTimeout(() => {
						setContentToTableForSpecificRow("tableDette", i, [dette.lib, dette.montant.toString().replaceAll(",", "."), dette.planApurement, dette.duree, dateToJJMMYYYY(dette.dateDebut), dateToJJMMYYYY(dette.dateFin), dette.montantMensuel.toString().replaceAll(",", "."), dette.arretAvantTerme, dateToJJMMYYYY(dette.dateDerniereMensualite), dette.montantRestant.toString().replaceAll(",", "."), ""]);
	
						var $planApurement_t = $('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(2)').text();
		
						if ($planApurement_t == "Non" || $planApurement_t == "") {
							clearRowInTable("tableDette", i, [0, 1, 2, 10])
							.then(function() {
								// Callback appelée avec succès
								console.log("Callback appelée avec succès !");
							})
							.catch(function(error) {
								// Erreur lors de l'appel de la callback
								console.error("Erreur lors de l'appel de la callback :", error);
							});
		
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(3)').removeClass('numericEdit');
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(4)').removeClass('dateEdit');
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(7)').removeClass('selectEdit');
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(8)').removeClass('dateEdit');
						}else{
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(3)').addClass('numericEdit');
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(4)').addClass('dateEdit');
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(7)').addClass('selectEdit');
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(8)').addClass('dateEdit');
						}
		
						var $arretPaiementAvantTerme_t = $('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(7)').text();
		
						if ($arretPaiementAvantTerme_t == "Non" || $arretPaiementAvantTerme_t == "") {
							clearRowInTable("tableDette", i, [0, 1, 2, 3, 4, 5, 6, 7, 10])
							.then(function() {
								// Callback appelée avec succès
								console.log("Callback appelée avec succès !");
							})
							.catch(function(error) {
								// Erreur lors de l'appel de la callback
								console.error("Erreur lors de l'appel de la callback :", error);
							});
		
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(8)').removeClass('dateEdit');
						}else{
							$('#tableDette > tbody').find('tr:eq(' + (i).toString() + ')').find('td:eq(8)').addClass('dateEdit');
						}
					}, 0);
					
				});
			}
			
			setTimeout(() => {
				refreshDataRecapBudget($("#salaireCell").attr("id"), $("#salaireCell").text(), $("#salaireCell"));
				refreshDataDette($('#tableDette > tbody').find('tr:eq(0)').find('td:eq(1)'), $('#tableDette > tbody').find('tr:eq(0)').find('td:eq(1)').text());

				refreshColorLineDette();
			}, 1000);

			$.LoadingOverlay("hide");
		}
	});

}

function loadFiltres(){
	var filtre_jour= document.getElementById("filtre_jour");
	var filtre_nuit= document.getElementById("filtre_nuit");
	var filtre_jour_nuit = document.getElementById("filtre_jour_nuit");

	filtre_jour_nuit.checked = true;
	filtre_nuit.checked = false;
	filtre_jour.checked = false;
	filtre_choisie='jour_nuit';
}

// Fonction exécuter après avoir cliquer sur le bouton "Valider" du modal Multi-pointage
function HG_Creation_Fiches(){
	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	var data_pla = {
		"hb_id": $('#record_id').val(),
		"ids_centres": $('#mp_centre_hg_id').val(),
		"groupe": $('#mp_groupe_hg').val(),
		"dateCreation": $("#date_creation_fiche").val()
	}

	if ($("#quantitePrestationToDelete").find("ul").length > 0) {
		data_pla.ids_centresDetail = [];

		$("#quantitePrestationToDelete").find("li").each(function(){

			data_pla.ids_centresDetail.push({
				"idItem" : $(this).find("input[type='hidden']").val(),
				"quantite" : $(this).find("input[type='number']").eq(0).val(),
				"montant" : $(this).find("input[type='number']").eq(1).val()
			});

		});

	}

	var data = { 
		"zone":"usr", 
		"action":"set_pla",
		"data": {
		"pla": data_pla
		}
	};

	var data_json = 'json='+JSON.stringify(data);

	var $status = '';
	var $msg = '';

	$.getJSON("/USR?action=hg_multi_pointage",data_json, function(data){  
		var compteur = 0;
	
		$.each(data, function(key, value){  
			
			if (compteur == 0){
				$status = value;
			}else{
				$msg = value;
			}

			compteur = compteur +1;
		});

	}).done(function() {//success
	})
	.fail(function() { //error
	})
	.always(function() { //complete

		if ($status=='success'){
			$.alert({
				title: 'Succès',
				content: $msg,
				icon: 'fa fa-check',
				animation: 'scale',
				closeAnimation: 'scale',
				columnClass: 'iw_alert',
				buttons: {
					okay: {
						text: 'Ok',
						btnClass: 'btn-blue',
						action: function(){
							$('#iw_form_popup_hg').hide();
							
						}
					}
				}
			});

			var div_selectedusager='colf' + $('#record_id').val();

			$("#"+div_selectedusager).click();
		}else{

			if ($msg == "") {
				$msg = "Votre saisie ne peut pas être enregistrée. Il semblerait que vous soyez déconnecté du serveur. Voulez-vous bien vous déconnecter et recommencer l'opération svp ?"
			}

			$.alert({
				title: "Échec",
				content: $msg,
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

		}

		$.LoadingOverlay("hide");
	});  

}

// Fonction exécuter après avoir cliquer sur le bouton "Multi-pointage" au dessus de la liste
function Show_Popup_Fiche_HG(){
	// On ré-initialise la collection
	lineInfo_c = [];

	// Demande de réinitialisation des valeurs de popup géré par angular
	firstPassage_b = false;

	firstPassageDetail_c.forEach(element => {
		element.firstPassage = false;
	});

	$('#titre_popup_hg').html("Création des fiches pour l'usager " + $('#cle').val());
	$('#iw_form_popup_hg').show();

	// Modifié par : Scanu Rémy (16/12/2022)
	resetFieldInForm("mp_ligne_hg","date_creation_fiche");
	$("#date_creation_fiche").val($("#date_creation_fiche").attr("data-val"));

	$("#mp_groupe_hg").addClass("fdp-invalid");

	$("#quantitePrestationToDelete").remove();
	$("#mp_ligne_hg").append("<div id=\"quantitePrestationToDelete\"></div>");
}

/********************************************************************************************************* */
function Execute_Usager_Pointage(){
	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	var today = new Date(Date.now());
	var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
	var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

	var data_pointage = { 
		"hb_referenceid": $("#hb_referenceid").val(), 
		"cle": $("#cle").val(),
		"date_client": date,
		"heure_client": time
	};

	var data = { 
		"zone":"heberge", 
		"action":"set_pointage_cle",
		"data": {
			"pointage": data_pointage
		}
	};

	var data_json = '&json='+JSON.stringify(data);

	$.getJSON("/INT?action=usager_pointage",data_json, function(data){  
	}).done(function() {//success
	})
	.fail(function() { //error
	})
	.always(function() { //complete
		$.LoadingOverlay("hide");

		$.alert({
			title: 'Succès',
			content: 'Pointage effectué avec succès.',
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

function Execute_Usager_Pointage_Multiple(){
	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	var today = new Date(Date.now());
	var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
	var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

	var data_pointage = { 
		"hegerges_ids": $("#hegerges_ids").val(), 
		"date_client": date,
		"heure_client": time
	};

	var data = { 
		"zone":"heberge", 
		"action":"set_pointage_cle",
		"data": {
			"pointage": data_pointage
		}
	};

	var data_json = '&json='+JSON.stringify(data);

	$.getJSON("/INT?action=usager_pointage_multiple",data_json, function(data){  
	}).done(function() {//success
	})
	.fail(function() { //error
	})
	.always(function() { //complete
		$.LoadingOverlay("hide");
		Search_Usager();

		$.alert({
			title: 'Succès',
			content: 'Pointage effectué avec succès.',
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

function Save_Notes(){
	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	var data_heberge = { 
		"hg_hb_id": $("#hb_referenceid").val(),  
		"adresse1": $("#adresse1").val(), 
		"adresse2": $("#adresse2").val(), 
		"adresse3": $("#adresse3").val(), 
		"codePostal": $("#codePostal").val(), 
		"ville": $("#ville").val(),
		"nom": $("#nomHB").val(),
		"prenom": $("#prenomHB").val(),
		"dateNaissance": dateToJJMMYYYY($("#dateNaissanceHB").val()),
		"lieuNaissance": $("#lieuNaissanceHB").val(),
		"nationalite": $("#nationaliteHB").val(),
		"numCNI": $("#numCNIHB").val(),
		"numPassport": $("#numPassportHB").val(),
		"email": $("#emailHB").val(), 
		"telephone": $("#telephoneHB").val()
	};

	var data = { 
		"zone":"heberge", 
		"action":"set_heberge",
		"data": {
			"heberge": data_heberge
		}
	};

	var data_json = '&json=' + JSON.stringify(data);

	$.getJSON("/INT?action=usager_coordonnees_valider",data_json, function(data){
		console.log(data);
		save_status = data.status;

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
	.always(function() { //complete
		$.LoadingOverlay("hide");
		Get_Heberge_Data();

		$("#fdp-usager-search").click();
	});  

}

function Save_Notes_SP(){
	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	var data_heberge = { 
		"hg_hb_id": $("#hb_referenceid").val(), 
		"hb_cas1": $("#hb_cas1").val(), 
		"hb_cas2": $("#hb_cas2").val(), 
		"hb_cas3": $("#hb_cas3").val(), 
		"hb_cas4": $("#hb_cas4").val(), 
		"hb_cas5": $("#hb_cas5").val(), 
		"hb_cas6": $("#hb_cas6").val(), 
		"hb_cas7": $("#hb_cas7").val(),
		"hb_cas8": $("#hb_cas8").val(),
		"hb_cas9": $("#hb_cas9").val(),
		"hb_cas10": $("#hb_cas10").val(),
		"hb_casdt1": $("#hb_casdt1").val(),
		"hb_casdt2": $("#hb_casdt2").val(),
		"hb_casdt3": $("#hb_casdt3").val(),
		"hb_casdt4": $("#hb_casdt4").val(),
		"hb_casdt5": $("#hb_casdt5").val(),
		"hb_casdt6": $("#hb_casdt6").val(),
		"hb_casdt7": $("#hb_casdt7").val(),
		"hb_casdt8": $("#hb_casdt8").val(),
		"hb_casdt9": $("#hb_casdt9").val(),
		"hb_casdt10": $("#hb_casdt10").val(),
		"hb_caslib1": $("#hb_caslib1").val(),
		"hb_caslib2": $("#hb_caslib2").val(),
		"hb_caslib3": $("#hb_caslib3").val(),
		"hb_caslib4": $("#hb_caslib4").val(),
		"hb_caslib5": $("#hb_caslib5").val(),
		"hb_caslib6": $("#hb_caslib6").val(),
		"hb_caslib7": $("#hb_caslib7").val(),
		"hb_caslib8": $("#hb_caslib8").val(),
		"hb_caslib9": $("#hb_caslib9").val(),
		"hb_caslib10": $("#hb_caslib10").val()
	};

	var data = { 
		"zone":"heberge", 
		"action":"set_heberge",
		"data": {
			"heberge": data_heberge
		}
	};

	var data_json = '&json='+JSON.stringify(data);

	$.getJSON("/INT?action=usager_sp_valider",data_json, function(data){  
	}).done(function() {//success
	})
	.fail(function() { //error
	})
	.always(function() { //complete				 
		$.LoadingOverlay("hide");
		Get_Heberge_Data();

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
	});
}

function Search_Usager(){
	$('#int-usager-table .table').empty();

	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	Unmark_All_Required_Fields(required_fields);

	$('#int-usager .table').empty();
	$('#int-usager-result .table').empty();

	$('#hb_referenceid').val('');
	$('#cle').val('');

	$("#usager-btns").hide();

	var data_search = {
		"nom": $("#nom").val(),
		"prenom": $("#prenom").val(),
		"date_naissance": $("#date_naissance").val(),
		"lien_famille": $("#lien_famille").val(),
		"telephone": $("#telephone").val(),
		"filtre": filtre_choisie
	};

	var compteur_fiches_heberges = 0;
	var id_div_premier_usager='';
	  
	$.getJSON("/INT?action=usager_list_json&saction=get_heberges",data_search, function(data){

		if (data.length>0) {
			$('#int-usager-table .table').empty();

			var resp_table_data=''; 
			var css_class_row='';
			var counter = 0;
	
			resp_table_data += '<div class="row iw_header_title_global">';
			resp_table_data += '<div class="cell fdp-min-width-210px" style="font-size: 12px !important;">';
			resp_table_data += 'Liste des demandeurs : ';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell" style="min-width: 100px;" style="font-size: 12px !important;">';
			resp_table_data += data.length;
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += '';
			resp_table_data += '</div>';
			resp_table_data += '</div>'; 
		
			resp_table_data += '<div class="row header">';
			resp_table_data += '<div class="cell fdp-min-width-210px">';
			resp_table_data += 'Clé';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell" style="min-width: 100px;">';
			resp_table_data += 'Lien de famille';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += 'Nombre de fiches';
			resp_table_data += '</div>';
			resp_table_data += '</div>'; 
		
			$.each(data, function(key, value){  
				compteur_fiches_heberges = compteur_fiches_heberges + 1;

				if (compteur_fiches_heberges == 1){
					id_div_premier_usager = 'colf' + value.hb_referenceid;
				}

				css_class_row = '';
				css_custom = '';

				if (value.count_fiches > 0){
					css_class_row = 'fdp-blue-bold';
				}

				if (counter % 2 != 0){
					css_class_row += ' iw-alternate';
				}

				if (value.noteSP == true) {
					css_custom = 'color: red!important;';
				}

				if (value.isFamChief == true) {
					css_custom += 'font-weight: 600!important';
				}

				if (css_custom != "") {
					css_custom = ' style="' + css_custom + '"'
				}

				if (compteur_fiches_heberges > 1){
					$("#hegerges_ids").val($("#hegerges_ids").val() + ";");
				}

				$("#hegerges_ids").val($("#hegerges_ids").val() + value.id);

				resp_table_data += '<div class="row body ' + css_class_row + '">';
				resp_table_data += '<div class="cell cle" id="colf' + value.hb_referenceid + '"' + css_custom + '>';

				resp_table_data += value.hb_cle;

				resp_table_data += '</div>';
				resp_table_data += '<div class="cell" id="colf' + value.hb_referenceid + '"' + css_custom + '>';
				resp_table_data += value.clefamille;
				resp_table_data += '</div>';
				resp_table_data += '<div class="cell" id="colf' + value.hb_referenceid + '"' + css_custom + '>';
				resp_table_data += value.count_fiches;
				resp_table_data += '</div>';
				resp_table_data += '</div>';

				$('<input>', {
					type: 'hidden',
					id: 'clev'+value.hb_referenceid,
					name: 'clev'+value.hb_referenceid,
					value: value.hb_cle
				}).appendTo('#int-usager-table .table');

				$('<input>', {
					type: 'hidden',
					id: 'refid'+value.hb_referenceid,
					name: 'refid'+value.hb_referenceid,
					value: value.hb_referenceid
				}).appendTo('#int-usager-table .table');

				counter = counter + 1;
			});  

			$("#int-usager-table .table").append(resp_table_data); 
			$("table").show();

			$("#" + id_div_premier_usager).click();
			
			$(".cle").click(function(){
				// Ajout visuel de la ligne sélectionnée par Rémy Scanu le 20/12/2022
				$(".row-selected").removeClass("row-selected");
				$(this).closest(".row").addClass("row-selected");

				if ($(this).closest(".row").hasClass("fdp-blue-bold") == true) {
					$(this).closest(".row").removeClass("fdp-blue-bold");
				}

			});
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

function setFiltres(e){
	var filtre_jour= document.getElementById("filtre_jour");
	var filtre_nuit= document.getElementById("filtre_nuit");
	var filtre_jour_nuit = document.getElementById("filtre_jour_nuit");

	if (e.target.id=='filtre_jour'){
		filtre_nuit.checked = false;
		filtre_jour_nuit.checked = false;
		filtre_choisie='jour';
	}else if (e.target.id=='filtre_nuit'){
		filtre_jour_nuit.checked = false;
		filtre_jour.checked = false;
		filtre_choisie='nuit';
	}else if (filtre_jour_nuit.checked){
		filtre_nuit.checked = false;
		filtre_jour.checked = false;
		filtre_choisie='jour_nuit';
	}
}

function Nouvelle_Fiche(){
	var $rowSelected_j = $(".row-selected");

	managePreviousDataFilter("sauvegarder", "locataires", "", '/INT?action=usager-fiche&id=-1&hb_id=' + $('#hb_referenceid').val() + '&type=hebergement', 
	[
		"nom",
		"prenom",
		"date_naissance",
		"lien_famille",
		"telephone",
		{
			"name": "filtre",
			"value": filtre_choisie
		},
		{
			"name": "rowSelected",
			"value": $("#int-usager-table").find(".row").index($rowSelected_j)
		}
	]);
}

function Nouvelle_Fiche_Prestation(){
	var $rowSelected_j = $(".row-selected");
	
	managePreviousDataFilter("sauvegarder", "locataires", "", '/INT?action=usager-fiche&id=-1&hb_id='  + $('#hb_referenceid').val() + '&type=prestation', 
	[
		"nom",
		"prenom",
		"date_naissance",
		"lien_famille",
		"telephone",
		{
			"name": "filtre",
			"value": filtre_choisie
		},
		{
			"name": "rowSelected",
			"value": $("#int-usager-table").find(".row").index($rowSelected_j)
		}
	]);
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
			"hb_telephone": $("#telephone").val(),
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

		var $status = '';
		var $msg = '';

		$.getJSON("/INT?action=usager_fiche_add",data_json, function(data){  
			var compteur = 0;
	
			$.each(data, function(key, value){  
				console.log($status);

				if (compteur == 0){
					$status = value;
				}else{
					$msg = value;
				}
	
				compteur = compteur +1;
			});

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete

			if ($status == 'Success'){
				Mark_All_Required_Fields(required_fields);
				Search_Usager();
	
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
					title: "Échec",
					content: $msg,
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
	
			}

			$.LoadingOverlay("hide");
		});   

	}     

}

function Get_Heberge_Data(){
	var data_heberge = { 
		"hg_hb_id": $("#hb_referenceid").val()
	};

	var data = { 
		"zone":"heberge", 
		"action":"get_heberge",
		"data": {
			"heberge": data_heberge
		}
	};

	var data_json = '&json='+JSON.stringify(data);

	$.getJSON("/INT?action=get_heberge",data_json, function(data){  

		$.each(data, function(key, value){
			console.log(value);

			// Coordonnées
			$("#adresse1").val(value.adresse1);
			$("#adresse2").val(value.adresse2);
			$("#adresse3").val(value.adresse3);
			$("#codePostal").val(value.codePostal);
			$("#ville").val(value.ville);

			$("#nomHB").val(value.hb_nom);
			$("#prenomHB").val(value.hb_prenom);
			$("#dateNaissanceHB").val(dateToYYYYMMJJ(value.hb_datenele));
			
			$("#emailHB").val(value.hb_email);
			$("#telephoneHB").val(value.hb_telephone);

			// Pièces
			$("#lieuNaissanceHB").val(value.hb_pieceneou);
			$("#nationaliteHB").val(value.hb_piecenationalite);
			$("#numCNIHB").val(value.hb_piececni);
			$("#numPassportHB").val(value.hb_piecepasseport);

			switchEnabledMultipleElement(["#nomHB", "#prenomHB", "#dateNaissanceHB"], true);
			$("#modifDemandeur").prop( "checked", false);

			// Notes
			$("#note_1").text(value.notes);
			$("#note_2").text(value.hb_notes2); 
			$("#note_3").text(value.hb_notes3); 
			$("#note_4").text(value.hb_notes4); 
			$("#note_5").text(value.hb_notestrans); 
			$("#note_6").text(value.hb_maraude);
			$("#note_7").text(value.hb_maraude2);
			$("#note_8").text(value.hb_note_ffv);

			//SP
			$('#hb_cas1').attr('checked', value.hb_cas1);
			$('#hb_cas2').attr('checked', value.hb_cas2);
			$('#hb_cas3').attr('checked', value.hb_cas3);
			$('#hb_cas4').attr('checked', value.hb_cas4);
			$('#hb_cas5').attr('checked', value.hb_cas5);
			$('#hb_cas6').attr('checked', value.hb_cas6);
			$('#hb_cas7').attr('checked', value.hb_cas7);
			$('#hb_cas8').attr('checked', value.hb_cas8);
			$('#hb_cas9').attr('checked', value.hb_cas9);
			$('#hb_cas10').attr('checked', value.hb_cas10);

			$("#hb_casdt1").attr('value', getDateData(value.hb_casdt1));
			$("#hb_casdt2").attr('value', getDateData(value.hb_casdt2));
			$("#hb_casdt3").attr('value', getDateData(value.hb_casdt3));
			$("#hb_casdt4").attr('value', getDateData(value.hb_casdt4));
			$("#hb_casdt5").attr('value', getDateData(value.hb_casdt5));
			$("#hb_casdt6").attr('value', getDateData(value.hb_casdt6));
			$("#hb_casdt7").attr('value', getDateData(value.hb_casdt7));
			$("#hb_casdt8").attr('value', getDateData(value.hb_casdt8));
			$("#hb_casdt9").attr('value', getDateData(value.hb_casdt9));
			$("#hb_casdt10").attr('value', getDateData(value.hb_casdt10));

			$('#hb_caslib1').attr('value', value.hb_caslib1);
			$("#hb_caslib2").attr('value', value.hb_caslib2);
			$("#hb_caslib3").attr('value', value.hb_caslib3);
			$("#hb_caslib4").attr('value', value.hb_caslib4);
			$("#hb_caslib5").attr('value', value.hb_caslib5);
			$("#hb_caslib6").attr('value', value.hb_caslib6);
			$("#hb_caslib7").attr('value', value.hb_caslib7);
			$("#hb_caslib8").attr('value', value.hb_caslib8);
			$("#hb_caslib9").attr('value', value.hb_caslib9);
			$("#hb_caslib10").attr('value', value.hb_caslib10);
		});

	}).done(function() {//success
	})
	.fail(function() { //error
	})
	.always(function() { //complete
	});
}

function padTo2Digits(num) {
	return num.toString().padStart(2, '0');
}
  
function formatDate(date) {
	return [
		padTo2Digits(date.getDate()),
		padTo2Digits(date.getMonth() + 1),
		date.getFullYear(),
	].join('/');
}

function mp_centre_hgmodalOnLoad($scopeAngular_o){
	visiteur.prestationModalAngularList = $scopeAngular_o;
}

function mp_centre_hgmodalOnShownModal(){
	var $itemListHTML_t = "";

	if ($("#mp_centre_hgmodalCategoryButttonList").length == 0) {
		var $inputSearchModalDiv_j = $("#mp_centre_hgmodal").find(".search").eq(0).closest(".form-group");

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
				<div id="mp_centre_hgmodalCategoryButttonList" class="rowB g-mb-10">'

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
					var $plateformeSelect_t = $("#mp_groupe_hg").val().substring(0, 2);

					$(".categoryModalList").removeClass("fdp-btn-green");
					$(this).addClass("fdp-btn-green");

					$.LoadingOverlay("show");
					
					$("#mp_centre_hgmodal").find(".item-label").each(function(){
						$(this).closest("tr").hide();
						
						if ($search_t == "Toutes") {
							$(this).closest("tr").show();
						}else{
							var $line_o = searchInArrayObject(visiteur.prestationModalAngularList.list, "id", $(this).find("input").val());
							console.log($line_o);
	
							if ($line_o != null) {
	
								if ($line_o.categorie == $search_t) {
									$(this).closest("tr").show();

									if (stringIsNumber($plateformeSelect_t) && extractNumber($(this).text()) != $plateformeSelect_t && $("#mp_groupe_hg").val() != "") { // Si le service a bien les deux premiers caractères sous forme de chifre et que la prestation sur laquelle je suis en train de boucler correspond bien à la plateforme du service sélectionné
										$(this).closest("tr").hide();
									}

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
	mp_centre_hgmodalFilterByPlatform();
}

function mp_centre_hgmodalFilterByPlatform(){
	var $plateformeSelect_t = $("#mp_groupe_hg").val().substring(0, 2);

	$("#mp_centre_hgmodal").find(".item-label").each(function(){

		if ($(this).closest("tr").is(":visible")) { // Si la prestation est visible, donc qu'il est bien dans la catégorie que l'utilisateur a sélectionné mp_centre_hgmodalOnShownModal()

			if (stringIsNumber($plateformeSelect_t) == true && extractNumber($(this).text()) != $plateformeSelect_t && $("#mp_groupe_hg").val() != "") { // Si le service a bien les deux premiers caractères sous forme de chifre et que la prestation sur laquelle je suis en train de boucler correspond bien à la plateforme du service sélectionné
				$(this).closest("tr").hide();
			}
			
		}

	});

}