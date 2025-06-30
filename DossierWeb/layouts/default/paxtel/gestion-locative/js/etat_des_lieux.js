/*****************************************************************************/
/*ETAT DES LIEUX*/
/*****************************************************************************/
var useSaveDocument = false;
var forcePassage = false;
var copySignature = true;

$(document).ready(function () {
	var etl_post_action = $("#etl_post_action").val();
	var etl_get_action = $("#etl_get_action").val();

	var etl_signature_bailleur = null;
	var etl_signature_locataire = null;

	var mandatory_fields_ligne = $("#mandatory_ligne_etl").val().split(';');
	var signatureContentHtml_t = $(".js-signature").closest(".iw_div_content").html();

	$("#btn_etl_nv").click(function () {
		$("#etatSelection").removeClass("d-none");
	});

	$("#btn_etat_des_lieux").click(function (ev) {
		Popup_ETL_Print(ev);

		return false;
	});


	function Popup_Fiche_NV_ETL_Old(){
		$('#titre_popup_etl').html('ÉTAT DES LIEUX');
	
		var var_popup = $('#iw_form_popup_etl').html();
		$('#iw_form_popup_etl').html('');
	
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
							Save_Record_Piece_ETL();
	
							return false;
						}
	
					}
				},
				cancel: {
					text: 'Fermer',
					action: function () {
						$('#iw_form_popup_etl').html(var_popup);
					}
				},
			},
			onContentReady: function () {
				var jc = this;
				
				this.$content.find('form').on('submit', function (e) {
					e.preventDefault();
	
					jc.$$formSubmit.trigger('click'); // reference the button and click it
				});
	
				$('#etl_date').datepicker({
					format: 'dd/mm/yyyy'
				});
	
				//================================================================================//
	
				if ($('.js-signature').length) {
					$('.js-signature').jqSignature();
				}
	
				$('.js-signature').eq(0).on('jq.signature.changed', function() {
					$('#saveBtn').attr('disabled', false);
				});
	
				$('#etl_type').change(function() {
	
					if ($(this).val()=='Sortie'){
						Get_Record_Data_ETL_Piece($('#etl_entree_id').val(),'diversement');
					}
					
				});
	
			}
		});
	
	}

	function Popup_Fiche_NV_ETL(type) {
		$('#titre_popup_etl').html('ÉTAT DES LIEUX');

		var var_popup = $('#iw_form_popup_etl').html();
		$('#iw_form_popup_etl').html('');

		$.ajax({
			method: 'POST',
			url: "/4DACTION/outilsWProSendAjax",
			data: {
				"nomDocument": $("#etatList").val(),
				"locationID": $('#record_id').val(),
				"action": (type == "nouveau" ? "createNewVersion" : "loadSaveVersion")
			},
			success: function(response){
				var reponseParse = JSON.parse(response);
				copySignature = (type == "nouveau");

				$("#4DWriteIframe").attr("src", reponseParse["modelePath"]);

				$.confirm({
					title: '',
					content: '<div id="4DWriteContent"></div>',
					buttons: {
						formSubmit: {
							text: 'Enregistrer',
							btnClass: 'btn-blue',
							action: function () {
								manageEtatDesLieux(1);
								return false;
							}
						},
						cancel: {
							text: 'Fermer',
							action: function () {
								$('#iw_form_popup_etl').html(var_popup);

								$("#etatList").val("");
								$("#btn_etl_ouvrir").addClass("d-none");
								$("#btn_etl_creer").addClass("d-none");

								$("#4DWriteDiv").appendTo(".fdp_child");
								$('#4DWriteIframe').css('cssText', 'display: none !important');
							}
						},
						print: {
							text: 'Imprimer',
							btnClass: 'btn-blue',
							action: function(){
								$("#4DWriteIframe").get(0).contentWindow.print();
								return false;
							}
						}
					},
					onContentReady: function () {
						var jc = this;
						this.$content.find('form').on('submit', function (e) {
							e.preventDefault();
							jc.$$formSubmit.trigger('click'); // reference the button and click it
						});
		
						$('#etl_date').datepicker({
							format: 'dd/mm/yyyy'
						});
		
						//================================================================================//
		
						if ($('.js-signature').length) {
							$('.js-signature').jqSignature();
						}
		
						$('.js-signature').eq(0).on('jq.signature.changed', function () {
							$('#saveBtn').attr('disabled', false);
						});
		
						$('#etl_type').change(function () {
		
							if ($(this).val() == 'Sortie') {
								Get_Record_Data_ETL_Piece($('#etl_entree_id').val(), 'diversement');
							}
		
						});
						
						$("#4DWriteDiv").appendTo("#4DWriteContent");
						$('#4DWriteIframe').css('cssText', 'display: block !important; width: 21cm; margin: 0 auto;');
						//================================================================================//
					}
				});

			}
		});

	}

	function Popup_ETL_Print() {
		$('#titre_popup_etl_print').html('ÉTAT DES LIEUX');

		Get_Data_ETL_Piece_PRINT($('#record_id').val(), 'entrée');
		Get_Data_ETL_Piece_PRINT($('#record_id').val(), 'sortie');

		var var_popup = $('#iw_form_popup_etl_print').html();
		$('#iw_form_popup_etl_print').html('');

		$.confirm({
			title: '',
			content: '' +
				'<div>' + var_popup +
				'</div>',
			buttons: {
				formSubmit: {
					text: 'Imprimer',
					btnClass: 'btn-blue',
					action: function () {

						$.LoadingOverlaySetup({
							background: "rgba(0, 0, 0, 0.5)",
							imageColor: "#fff"
						});

						$.LoadingOverlay("show");

						$('#etl_print_content').printThis({
							debug: true,
							importCSS: true,
							importStyle: true,
							printDelay: 5000,
							removeScripts: true,
							afterPrint: function () {
								$.LoadingOverlay("hide");
							}

						});

						return false;
					}
				},
				cancel: {
					text: 'Fermer',
					action: function () {
						$('#iw_form_popup_etl_print').html(var_popup);
					}
				},
			},
			onContentReady: function () {
				var jc = this;
				this.$content.find('form').on('submit', function (e) {
					e.preventDefault();

					jc.$$formSubmit.trigger('click'); // reference the button and click it
				});

				$('#etl_date').datepicker({
					format: 'dd/mm/yyyy'
				});

				//================================================================================//
			}
		});

	}

	function Save_Record_Piece_ETL() {
		var piece_compteur = 1;

		Save_Record_Line_ETL(parseInt(piece_compteur));

		Save_ETL_Signature($("#id_selected_etl").val(), "bailleur");
		Save_ETL_Signature($("#id_selected_etl").val(), "locataire");

		Display_Table_ETL();
	}

	function Save_ETL_Signature($id_origin, $partie) {
		var dataUrl = null;

		if ($partie == "bailleur") {
			dataUrl = $('.js-signature').eq(0).jqSignature('getDataURL');
		} else {
			dataUrl = $('.js-signature').eq(1).jqSignature('getDataURL');
		}

		var file = dataURLtoFile(dataUrl, 'signature.png');
		var data = new FormData();
		var files = file;

		var continuer = true;

		if (continuer == true) {
			data.append($id_origin + '_' + $partie, files);

			// Make Ajax request with the contentType = false, and procesDate = false
			var ajaxRequest = $.ajax({
				type: "POST",
				url: "/GL?action=etl_save_signature",
				contentType: false,
				processData: false,
				data: data,

				error: function (xhr, status, error) {

				}
			});

			ajaxRequest.done(function (xhr, textStatus) {
				Display_Table_ETL();
			});

		} else {

			$.alert({
				title: 'Erreur',
				content: 'Aucun document n\'a été transféré',
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

	function dataURLToBlob(dataURL) {
		var BASE64_MARKER = ';base64,';

		if (dataURL.indexOf(BASE64_MARKER) == -1) {
			var parts = dataURL.split(',');
			var contentType = parts[0].split(':')[1];
			var raw = parts[1];

			return new Blob([raw], { type: contentType });
		}
		else {
			var parts = dataURL.split(BASE64_MARKER);
			var contentType = parts[0].split(':')[1];
			var raw = window.atob(parts[1]);
			var rawLength = raw.length;

			var uInt8Array = new Uint8Array(rawLength);

			for (var i = 0; i < rawLength; ++i) {
				uInt8Array[i] = raw.charCodeAt(i);
			}

			return new Blob([uInt8Array], { type: contentType });
		}
	}

	function dataURLtoFile(dataurl, filename) {
		var arr = dataurl.split(','), mime = arr[0].match(/:(.*?);/)[1],
			bstr = atob(arr[1]), n = bstr.length, u8arr = new Uint8Array(n);

		while (n--) {
			u8arr[n] = bstr.charCodeAt(n);
		}

		return new File([u8arr], filename, { type: mime });
	}

	function Save_Record_Line_ETL(piece_compteur) {
		var $piece_id = $("#id_piece_" + piece_compteur).val();

		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		var data_ligne = {
			"id_piece": $("#record_id_etl").val(),
			"etl_id_location": $("#record_id").val(),
			"id_ligne": $("#id_ligne_" + $piece_id).val(),
			"etl_id": $("#etl_id").val(),
			"ipl_id": $("#ipl_id_" + $piece_id).val(),
			"etl_date": $("#etl_date").val(),
			"etl_type": $("#etl_type").val(),
			"etl_electricite_no_compteur": $("#etl_electricite_no_compteur").val(),
			"etl_electricite_releve_hp": $("#etl_electricite_releve_hp").val(),
			"etl_electricite_releve_hc": $("#etl_electricite_releve_hc").val(),
			"etl_gaz_naturel_no_compteur": $("#etl_gaz_naturel_no_compteur").val(),
			"etl_gaz_naturel_releve": $("#etl_gaz_naturel_releve").val(),
			"etl_eau_froide_releve": $("#etl_eau_froide_releve").val(),
			"etl_eau_chaude_releve": $("#etl_eau_chaude_releve").val(),
			"etl_chauffage": $("#etl_chauffage_checked_value").val(),
			"etl_eau_chaude": $("#etl_eau_chaude_checked_value").val(),
			"etl_pv_cave_num": $("#etl_pv_cave_num").val(),
			"etl_pv_cave_etat": $("#etl_pv_cave_etat").val(),
			"etl_pv_cave_commentaires": $("#etl_pv_cave_commentaires").val(),
			"etl_pv_parking_num": $("#etl_pv_parking_num").val(),
			"etl_pv_parking_etat": $("#etl_pv_parking_etat").val(),
			"etl_pv_parking_commentaires": $("#etl_pv_parking_commentaires").val(),
			"etl_pv_jardin_num": $("#etl_pv_jardin_num").val(),
			"etl_pv_jardin_etat": $("#etl_pv_jardin_etat").val(),
			"etl_pv_jardin_commentaires": $("#etl_pv_jardin_commentaires").val(),
			"etl_pv_balcon_num": $("#etl_pv_balcon_num").val(),
			"etl_pv_balcon_etat": $("#etl_pv_balcon_etat").val(),
			"etl_pv_balcon_commentaires": $("#etl_pv_balcon_commentaires").val(),
			"etl_pv_terrasse_num": $("#etl_pv_terrasse_num").val(),
			"etl_pv_terrasse_etat": $("#etl_pv_terrasse_etat").val(),
			"etl_pv_terrasse_commentaires": $("#etl_pv_terrasse_commentaires").val(),
			"eli_pe_1": $("#pce" + $piece_id + "_1").val(),
			"eli_pe_2": $("#pce" + $piece_id + "_2").val(),
			"eli_pe_3": $("#pce" + $piece_id + "_3").val(),
			"eli_pe_4": $("#pce" + $piece_id + "_4").val(),
			"eli_pe_5": $("#pce" + $piece_id + "_5").val(),
			"eli_pe_6": $("#pce" + $piece_id + "_6").val(),
			"eli_pe_7": $("#pce" + $piece_id + "_7").val(),
			"eli_pe_8": $("#pce" + $piece_id + "_8").val(),
			"eli_pe_9": $("#pce" + $piece_id + "_9").val(),
			"eli_pe_10": $("#pce" + $piece_id + "_10").val(),
			"eli_pc_1": $("#pcc" + $piece_id + "_1").val(),
			"eli_pc_2": $("#pcc" + $piece_id + "_2").val(),
			"eli_pc_3": $("#pcc" + $piece_id + "_3").val(),
			"eli_pc_4": $("#pcc" + $piece_id + "_4").val(),
			"eli_pc_5": $("#pcc" + $piece_id + "_5").val(),
			"eli_pc_6": $("#pcc" + $piece_id + "_6").val(),
			"eli_pc_7": $("#pcc" + $piece_id + "_7").val(),
			"eli_pc_8": $("#pcc" + $piece_id + "_8").val(),
			"eli_pc_9": $("#pcc" + $piece_id + "_9").val(),
			"eli_pc_10": $("#pcc" + $piece_id + "_10").val(),
			"eli_commentaires": $("#eli_commentaires_p" + $piece_id).val()
		}

		var data = {
			"zone": "gl",
			"action": "set_bien_ligne",
			"data": {
				"ligne": data_ligne
			}
		};

		var data_json = '&json=' + JSON.stringify(data);
		var save_status = '';

		$.getJSON("/GL?action=" + etl_post_action, data_json, function (data) {

			$.each(data, function (key, value) {
				save_status = value;
			});

		}).done(function () {
			piece_compteur = parseInt(piece_compteur) + 1;
			var $piece_compteur_ref = parseInt($("#cpt_pieces").val()) + 1;

			if (parseInt(piece_compteur) < parseInt($piece_compteur_ref)) {
				Save_Record_Line_ETL(parseInt(piece_compteur));
			}else {

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

				Display_Table_ETL();
			}
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");

			if (save_status == 'Failed') {

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

	Display_Table_ETL();

	function Display_Table_ETL() {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");
		$('#list_table_etl .table').empty();

		var data_specific = {
			"id": $("#record_id").val()
		};

		var data_search = {
			"zone": "gl",
			"action": "get_etl",
			"data": data_specific
		};

		var data_json = '&json=' + JSON.stringify(data_search);

		$.getJSON("/GL?action=" + etl_get_action, data_json, function (data) {
			$('#list_table_etl .table').empty();

			var resp_table_data = '';

			resp_table_data += '<div class="row header">';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += 'Type';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell iw_second_column" style="min-width: 100px;">';
			resp_table_data += 'Date';
			resp_table_data += '</div>';
			resp_table_data += '</div>';

			if (data.length > 0) {
				var css_class_row = '';
				var counter = 0;

				$.each(data, function (key, value) {
					css_class_row = '';

					if (counter % 2 != 0) {
						css_class_row += ' iw-alternate';
					}

					resp_table_data += '<div class="row body ' + css_class_row + '">';
					resp_table_data += '<div class="cell  " id="' + value.id + '">';
					resp_table_data += value.etl_type;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data += getDateData(value.etl_date);
					resp_table_data += '</div>';
					resp_table_data += '</div>';

					if (value.etl_type == 'Entrée') {
						$('#etl_entree_id').attr('value', value.id);
					}

					counter = counter + 1;
				});

				if (counter >= 2) {
					$("#btn_etl_nv").prop("disabled", true);
				} else {
					$("#btn_etl_nv").prop("disabled", false);
				}

			}

			$("#list_table_etl .table").append(resp_table_data);
		}).done(function () {//success

		})
		.fail(function () { //error
			Display_Table_ETL();
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
		});
	}

	$("#list_table_etl div").click(function (ev) {
		var data_search = {
			"id": ev.target.id
		};

		if (ev.target.id != '') {
			$('#id_selected_etl').val(ev.target.id);

			Get_Record_Data_ETL_Piece(ev.target.id, '');

			var var_popup = $('#iw_form_popup_etl').html();
			$('#iw_form_popup_etl').html('');

			var btn_save_class = '';

			$.confirm({
				title: '',
				content: '' +
					'<div>' + var_popup +
					'</div>',
				buttons: {
					formSubmit: {
						text: 'Enregistrer',
						btnClass: 'btn-blue ' + btn_save_class,
						action: function () {

							if (Check_Required_Fields(mandatory_fields_ligne)) {
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
							} else {
								Save_Record_Piece_ETL();

								return false;
							}
						}
					},
					cancel: {
						text: 'Fermer',
						action: function () {

							$('#iw_form_popup_etl').html(var_popup);
							$('#id_selected').val('');


						}
					}
				},
				onContentReady: function () {
					var jc = this;

					this.$content.find('form').on('submit', function (e) {
						e.preventDefault();

						jc.$$formSubmit.trigger('click'); // reference the button and click it
					});

					//================================================================================//

					if ($('.js-signature').length) {
						$('.js-signature').jqSignature();

					}

					$('.js-signature').eq(0).on('jq.signature.changed', function () {
						$('#saveBtn').attr('disabled', false);
					});

					$("input:checkbox").click(function () {
						var checkboxgroup = "input:checkbox[id='" + $(this).attr("id") + "']";

						$(checkboxgroup).attr("checked", false);
						$(this).attr("checked", true);

						$(checkboxgroup).prop("checked", false);
						$(this).prop("checked", true);

						IW_checkboxManage(this);
					});

					//================================================================================//
				}

			});

		}

	});

	function clearCanvas() {
		var canvas = document.getElementsByTagName("canvas")[0];
		var context = canvas.getContext('2d');

		context.clearRect(0, 0, canvas.width, canvas.height);

		var w = canvas.width;
		canvas.width = 1;
		canvas.width = w;
	}

	function Get_Record_Data_ETL_Piece($id, $operation_type) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		var data_module = {
			"id": $id
		};

		var data = {
			"zone": "gl",
			"action": "get_etl_ligne",
			"data": {
				"ligne": data_module
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		$.getJSON("/GL?action=get_etl", data_json, function (data) {
			var value = data;

			if ($operation_type == '') {
				$("#etl_type").attr('value', value.etl_type);
				$("#etl_type option[value='" + value.etl_type + "']").attr("selected", "selected");
			}

			$('#etl_date').datepicker({
				format: 'dd/mm/yyyy'
			});

			if ($operation_type == '') {
				$('#etl_date').datepicker('update', getDateData(value.etl_date));
			}

			$('#etl_type').attr('disabled', 'disabled');

			$("#etl_electricite_releve_hp").attr('value', value.etl_electricite_releve_hp);
			$("#etl_electricite_releve_hc").attr('value', value.etl_electricite_releve_hc);
			$("#etl_gaz_naturel_releve").attr('value', value.etl_gaz_naturel_releve);

			$("#etl_eau_froide_releve").attr('value', value.etl_eau_froide_releve);
			$("#etl_eau_chaude_releve").attr('value', value.etl_eau_chaude_releve);

			if (value.etl_chauffage != '') {
				$("input[id=etl_chauffage][dataval=" + value.etl_chauffage.replace(' ', '') + "]").prop('checked', true);
				$("input[id=etl_chauffage][dataval=" + value.etl_chauffage.replace(' ', '') + "]").attr('checked', 'checked');
			}
			$("#etl_chauffage_checked_value").attr('value', value.etl_chauffage);

			if (value.etl_eau_chaude != '') {
				$("input[id=etl_eau_chaude][dataval=" + value.etl_eau_chaude.replace(' ', '') + "]").prop('checked', true);
				$("input[id=etl_eau_chaude][dataval=" + value.etl_eau_chaude.replace(' ', '') + "]").attr('checked', 'checked');
			}

			$("#etl_eau_chaude_checked_value").attr('value', value.etl_eau_chaude);

			$("#etl_pv_cave_num").attr('value', value.etl_pv_cave_num);
			$("#etl_pv_cave_etat").attr('value', value.etl_pv_cave_etat);
			$("#etl_pv_cave_commentaires").attr('value', value.etl_pv_cave_commentaires);
			$("#etl_pv_parking_num").attr('value', value.etl_pv_parking_num);
			$("#etl_pv_parking_etat").attr('value', value.etl_pv_parking_etat);
			$("#etl_pv_parking_commentaires").attr('value', value.etl_pv_parking_commentaires);
			$("#etl_pv_jardin_num").attr('value', value.etl_pv_jardin_num);
			$("#etl_pv_jardin_etat").attr('value', value.etl_pv_jardin_etat);
			$("#etl_pv_jardin_commentaires").attr('value', value.etl_pv_jardin_commentaires);
			$("#etl_pv_balcon_num").attr('value', value.etl_pv_balcon_num);
			$("#etl_pv_balcon_etat").attr('value', value.etl_pv_balcon_etat);
			$("#etl_pv_balcon_commentaires").attr('value', value.etl_pv_balcon_commentaires);
			$("#etl_pv_terrasse_num").attr('value', value.etl_pv_terrasse_num);
			$("#etl_pv_terrasse_etat").attr('value', value.etl_pv_terrasse_etat);
			$("#etl_pv_terrasse_commentaires").attr('value', value.etl_pv_terrasse_commentaires);

			etl_signature_bailleur = value.etl_signature_bailleur;
			etl_signature_locataire = value.etl_signature_locataire;

			if ($operation_type == '') {
				draw(0, value.etl_signature_bailleur);
				draw(1, value.etl_signature_locataire);
			}

		}).done(function () {//success

		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
		});

		Get_Record_Data_ETL_Lignes($id);
	}

	function draw($index, $txt_base64) {
		var ctx = document.getElementsByTagName("canvas")[$index].getContext('2d');
		var img1 = new Image();

		img1.onload = function () {
			ctx.drawImage(img1, 0, 0);
		}

		img1.src = 'data:image/png;base64,' + $txt_base64;
	}

	function Get_Record_Data_ETL_Lignes($etl_id) {
		var i;

		for (i = 1; i < parseInt($("#cpt_pieces").val()) + 1; i++) {
			Get_Record_Data_ETL_Ligne($etl_id, $("#id_piece_" + i).val());
		}
	}

	function Get_Record_Data_ETL_Ligne($etl_id, $ipl_id) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");
		$('#titre_popup_etl').html('ÉTAT DES LIEUX');

		var data_module = {
			"etl_id": $etl_id,
			"ipl_id": $ipl_id
		};

		var data = {
			"zone": "gl",
			"action": "get_etl_ligne",
			"data": {
				"ligne": data_module
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		$.getJSON("/GL?action=get_etl_ligne", data_json, function (data) {

			$.each(data, function (key, value) {
				$("#pce" + $ipl_id + "_1").attr('value', value.eli_pe_1);
				$("#pce" + $ipl_id + "_2").attr('value', value.eli_pe_2);
				$("#pce" + $ipl_id + "_3").attr('value', value.eli_pe_3);
				$("#pce" + $ipl_id + "_4").attr('value', value.eli_pe_4);
				$("#pce" + $ipl_id + "_5").attr('value', value.eli_pe_5);
				$("#pce" + $ipl_id + "_6").attr('value', value.eli_pe_6);
				$("#pce" + $ipl_id + "_7").attr('value', value.eli_pe_7);
				$("#pce" + $ipl_id + "_8").attr('value', value.eli_pe_8);
				$("#pce" + $ipl_id + "_9").attr('value', value.eli_pe_9);
				$("#pce" + $ipl_id + "_10").attr('value', value.eli_pe_10);

				$("#pcc" + $ipl_id + "_1").attr('value', value.eli_pc_1);
				$("#pcc" + $ipl_id + "_2").attr('value', value.eli_pc_2);
				$("#pcc" + $ipl_id + "_3").attr('value', value.eli_pc_3);
				$("#pcc" + $ipl_id + "_4").attr('value', value.eli_pc_4);
				$("#pcc" + $ipl_id + "_5").attr('value', value.eli_pc_5);
				$("#pcc" + $ipl_id + "_6").attr('value', value.eli_pc_6);
				$("#pcc" + $ipl_id + "_7").attr('value', value.eli_pc_7);
				$("#pcc" + $ipl_id + "_8").attr('value', value.eli_pc_8);
				$("#pcc" + $ipl_id + "_9").attr('value', value.eli_pc_9);
				$("#pcc" + $ipl_id + "_10").attr('value', value.eli_pc_10);

				$("#eli_commentaires_p" + $ipl_id).attr('value', value.eli_commentaires);
			});

		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
		});

	}

	makeblob = function (dataURL) {
		var BASE64_MARKER = ';base64,';

		if (dataURL.indexOf(BASE64_MARKER) == -1) {
			var parts = dataURL.split(',');
			var contentType = parts[0].split(':')[1];
			var raw = decodeURIComponent(parts[1]);

			return new Blob([raw], { type: contentType });
		}

		var parts = dataURL.split(BASE64_MARKER);
		var contentType = parts[0].split(':')[1];
		var raw = window.atob(parts[1]);
		var rawLength = raw.length;

		var uInt8Array = new Uint8Array(rawLength);

		for (var i = 0; i < rawLength; ++i) {
			uInt8Array[i] = raw.charCodeAt(i);
		}

		return new Blob([uInt8Array], { type: contentType });
	}

	//===============================================================================//
	// PRINT
	//===============================================================================//
	function Get_Data_ETL_Piece_PRINT($id, $etl_type) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		var $etl_type_prefix = '';

		if ($etl_type == 'entrée') {
			$etl_type_prefix = 'e';
		}else {
			$etl_type_prefix = 's';
		}

		$.LoadingOverlay("show");

		var data_module = {
			"id": $id,
			"etl_type": $etl_type
		};

		var data = {
			"zone": "gl",
			"action": "get_etl_ligne",
			"data": {
				"ligne": data_module
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		$.getJSON("/GL?action=get_etl", data_json, function (data) {
			var value = data;

			$('#print_' + $etl_type_prefix + '_etl_date').html(value.etl_date);
			$('#print_etl_bien_type').html(value.etl_bien_type);
			$('#print_etl_surface').html(value.etl_surface);
			$('#print_etl_pieces_principales').html(value.etl_pieces_principales);
			$('#print_etl_bien_adresse').html(value.etl_bien_adresse);
			$('#print_etl_bailleur_nom').html(value.etl_bailleur_nom);
			$('#print_etl_bailleur_adresse').html(value.etl_bailleur_adresse);
			$('#print_etl_electricite_no_compteur').html(value.etl_electricite_no_compteur);
			$('#print_etl_electricite_releve_hp').html(value.etl_electricite_releve_hp);
			$('#print_etl_electricite_releve_hc').html(value.etl_electricite_releve_hc);
			$('#print_etl_gaz_naturel_no_compteur').html(value.etl_gaz_naturel_no_compteur);
			$('#print_etl_gaz_naturel_releve').html(value.etl_gaz_naturel_releve);
			$('#print_etl_eau_froide_releve').html(value.etl_eau_froide_releve);
			$('#print_etl_eau_chaude_releve').html(value.etl_eau_chaude_releve);
			$('#print_etl_chauffage').html(value.etl_chauffage);
			$('#print_etl_eau_chaude').html(value.etl_eau_chaude);

			$("#print_etl_pv_cave_num").html(value.etl_pv_cave_num);
			$("#print_" + $etl_type_prefix + "_etl_pv_cave_etat").html(value.etl_pv_cave_etat);
			$("#print_" + $etl_type_prefix + "_etl_pv_cave_commentaires").html(value.etl_pv_cave_commentaires);
			$("#print_etl_pv_parking_num").html(value.etl_pv_parking_num);
			$("#print_" + $etl_type_prefix + "_etl_pv_parking_etat").html(value.etl_pv_parking_etat);
			$("#print_" + $etl_type_prefix + "_etl_pv_parking_commentaires").html(value.etl_pv_parking_commentaires);
			$("#print_etl_pv_jardin_num").html(value.etl_pv_jardin_num);
			$("#print_" + $etl_type_prefix + "_etl_pv_jardin_etat").html(value.etl_pv_jardin_etat);
			$("#print_" + $etl_type_prefix + "_etl_pv_jardin_commentaires").html(value.etl_pv_jardin_commentaires);
			$("#print_etl_pv_balcon_num").html(value.etl_pv_balcon_num);
			$("#print_" + $etl_type_prefix + "_etl_pv_balcon_etat").html(value.etl_pv_balcon_etat);
			$("#print_" + $etl_type_prefix + "_etl_pv_balcon_commentaires").html(value.etl_pv_balcon_commentaires);
			$("#print_etl_pv_terrasse_num").html(value.etl_pv_terrasse_num);
			$("#print_" + $etl_type_prefix + "_etl_pv_terrasse_etat").html(value.etl_pv_terrasse_etat);
			$("#print_" + $etl_type_prefix + "_etl_pv_terrasse_commentaires").html(value.etl_pv_terrasse_commentaires);

			$('#print_etl_pv_cave_separator').html(Get_Separator($("#print_e_etl_pv_cave_commentaires").val(), $("#print_s_etl_pv_cave_commentaires").val()));
			$('#print_etl_pv_parking_separator').html(Get_Separator($("#print_e_etl_pv_parking_commentaires").val(), $("#print_s_etl_pv_parking_commentaires").val()));
			$('#print_etl_pv_jardin_separator').html(Get_Separator($("#print_e_etl_pv_jardin_commentaires").val(), $("#print_s_etl_pv_jardin_commentaires").val()));
			$('#print_etl_pv_balcon_separator').html(Get_Separator($("#print_e_etl_pv_balcon_commentaires").val(), $("#print_s_etl_pv_balcon_commentaires").val()));
			$('#print_etl_pv_terrasse_separator').html(Get_Separator($("#print_e_etl_pv_terrasse_commentaires").val(), $("#print_s_etl_pv_terrasse_commentaires").val()));

			$("#print_" + $etl_type_prefix + "_signature_bailleur").attr('src', 'data:image/png;base64,' + value.etl_signature_bailleur);
			$("#print_" + $etl_type_prefix + "_signature_locataire").attr('src', 'data:image/png;base64,' + value.etl_signature_locataire);

			$("#print_" + $etl_type_prefix + "_date_signature").html(value.etl_date);


			$("#print_" + $etl_type_prefix + "_ville_signature").html(value.etl_ville_signature);
			$("#print_" + $etl_type_prefix + "_ville_signature").html(value.etl_ville_signature);
		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
		});

		Get_Record_Data_ETL_Lignes_PRINT($id, $etl_type);
	}

	function Get_Record_Data_ETL_Lignes_PRINT($etl_id, $etl_type) {
		var i;

		for (i = 1; i < parseInt($("#cpt_pieces").val()) + 1; i++) {
			Get_Record_Data_ETL_Ligne_PRINT($etl_id, $("#id_piece_" + i).val(), $etl_type);
		}

	}

	function Get_Record_Data_ETL_Ligne_PRINT($etl_id, $ipl_id, $etl_type) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");
		var $etl_type_prefix = '';

		if ($etl_type == 'entrée') {
			$etl_type_prefix = 'e';
		}else {
			$etl_type_prefix = 's';
		}

		var data_module = {
			"etl_id": $etl_id,
			"ipl_id": $ipl_id,
			"etl_type": $etl_type
		};

		var data = {
			"zone": "gl",
			"action": "get_etl_ligne",
			"data": {
				"ligne": data_module
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		$.getJSON("/GL?action=get_etl_ligne", data_json, function (data) {

			$.each(data, function (key, value) {
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_1").html(value.eli_pe_1);
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_2").html(value.eli_pe_2);
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_3").html(value.eli_pe_3);
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_4").html(value.eli_pe_4);
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_5").html(value.eli_pe_5);
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_6").html(value.eli_pe_6);
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_7").html(value.eli_pe_7);
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_8").html(value.eli_pe_8);
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_9").html(value.eli_pe_9);
				$("#print_" + $etl_type_prefix + "_pce" + $ipl_id + "_10").html(value.eli_pe_10);

				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_1").html(value.eli_pc_1);
				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_2").html(value.eli_pc_2);
				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_3").html(value.eli_pc_3);
				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_4").html(value.eli_pc_4);
				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_5").html(value.eli_pc_5);
				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_6").html(value.eli_pc_6);
				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_7").html(value.eli_pc_7);
				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_8").html(value.eli_pc_8);
				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_9").html(value.eli_pc_9);
				$("#print_" + $etl_type_prefix + "_pcc" + $ipl_id + "_10").html(value.eli_pc_10);

				$("#print_" + $etl_type_prefix + "_eli_commentaires_p" + $ipl_id).html(value.eli_commentaires);

				$("#print_separator_" + $ipl_id + "_1").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_1"), $("#print_s_pcc" + $ipl_id + "_1")));
				$("#print_separator_" + $ipl_id + "_2").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_2"), $("#print_s_pcc" + $ipl_id + "_1")));
				$("#print_separator_" + $ipl_id + "_3").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_3"), $("#print_s_pcc" + $ipl_id + "_1")));
				$("#print_separator_" + $ipl_id + "_4").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_4"), $("#print_s_pcc" + $ipl_id + "_1")));
				$("#print_separator_" + $ipl_id + "_5").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_5"), $("#print_s_pcc" + $ipl_id + "_1")));
				$("#print_separator_" + $ipl_id + "_6").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_6"), $("#print_s_pcc" + $ipl_id + "_1")));
				$("#print_separator_" + $ipl_id + "_7").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_7"), $("#print_s_pcc" + $ipl_id + "_1")));
				$("#print_separator_" + $ipl_id + "_8").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_8"), $("#print_s_pcc" + $ipl_id + "_1")));
				$("#print_separator_" + $ipl_id + "_9").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_9"), $("#print_s_pcc" + $ipl_id + "_1")));
				$("#print_separator_" + $ipl_id + "_10").html(Get_Separator($("#print_e_pcc" + $ipl_id + "_10"), $("#print_s_pcc" + $ipl_id + "_1")));
			});

		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
		});

	}
	//===============================================================================//

	function manageEtatDesLieux(entree){

		switch (entree) {
			case 1: // Sauvegarde

				$.ajax({
					method: 'POST',
					url: "/4DACTION/outilsWProWebManageAjax",
					data: {
						"entree": "1",
						"nomDocument": $("#etatList").val(),
						"locationID": $('#record_id').val(),
						"contentHtml": $("#4DWriteIframe").contents().find("html").html()
					},
					success: function(response){

						$.alert({
							title: 'Etat des lieux sauvegardé',
							content: 'L\'état des lieux : « ' + $("#etatList").val() + ' » a été sauvegardé avec succès.',
							icon: 'fa fa-success',
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

				break;
			default:
				break;
		}
	}

	// Un peu de mise en forme
	$("#etatList").css("cssText", "width: 250px!important;");

	$.ajax({
		method: 'POST',
		url: "/4DACTION/outilsWProWebManageAjax",
		data: {
			"entree": "2",
			"tag": "Etat des lieux"
		},
		success: function(response){
			var reponseParse = JSON.parse(response);

			reponseParse.document.forEach(document => {
				
				$('#etatList').append($('<option>', {
					value: document,
					text: document
				}));

			});
		}
	});

	$("#etatList").change(function(){
		$("#btn_etl_ouvrir").addClass("d-none");
		
		$.ajax({
			method: 'POST',
			url: "/4DACTION/outilsWProSendAjax",
			data: {
				"nomDocument": $("#etatList").val(),
				"locationID": $('#record_id').val(),
				"action": "checkIfSaveExist"
			},
			success: function(response){
				var reponseParse = JSON.parse(response);

				$("#btn_etl_creer").removeClass("d-none");

				if (reponseParse.exist == true) {
					$("#btn_etl_ouvrir").removeClass("d-none");
				}
			}
		});

	});

	$("#btn_etl_creer, #btn_etl_ouvrir").click(function(){

		if ($(this).attr("id") == "btn_etl_creer") {
			Popup_Fiche_NV_ETL("nouveau");
		}else{
			Popup_Fiche_NV_ETL("ouvrir");
		}

		return false;
	});

	$('#4DWriteIframe').on('load', function() {
		$('#4DWriteIframe').contents().find(".js-signature").empty();
		
		if (copySignature == true) {
			$('#4DWriteIframe').contents().find("#t13").after('<div class="rowB">' + signatureContentHtml_t + '</div>');
			$('#4DWriteIframe').contents().find("#t13").find("._td29 > p:eq(3)").after('<fieldset><div><input id="signatureSurEtatPapiper" type="checkbox"><label>Signature effectuée sur état papier</label></div></fieldset>');
			$('#4DWriteIframe').contents().find("#t14").find("._td29 > p:eq(3)").after('<fieldset><div><input id="signatureSurEtatPapiper" type="checkbox"><label>Signature effectuée sur état papier</label></div></fieldset>');
			$('#4DWriteIframe').contents().find("body").append('<div class="rowB">' + signatureContentHtml_t + '</div>');
	
			$('#4DWriteIframe').contents().find("#t2, #t9, #t3, #t5, #t6, #t7").find("tbody  > tr").each(function(index, tr){

				$(this).find("td").each(function(indexB){
	
					if (indexB == 0) {
						$(this).attr("contenteditable", "false");
					}
					
				});

			});

			$('#4DWriteIframe').contents().find("#t8 > tbody  > tr").each(function(index, tr){
	
				$(this).find("td").each(function(indexB){
	
					if (index == 0 || index == 1 || indexB == 0 || indexB == 1 || indexB == 5) {
						$(this).attr("contenteditable", "false");
					}

				});
	
			});
		}

		$('#4DWriteIframe').contents().find(".js-signature").jqSignature();
		$('#4DWriteIframe').contents().find('input[type="checkbox"]').click(function(){
			$(this).attr("checked", $(this).is(":checked"));
		});
	});
});