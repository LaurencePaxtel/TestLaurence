$(document).ready(function () {
	var url_base = window.location.origin;

	var var_tableliste_content = $('#list_table').html();
	var required_fields = $("#mandatory_equipement").val().split(';');
	var sbaction = getUrlParameter('sbaction');

	var TS_Show_Loader = true;

	var var_equ_type = "";
	var var_equ_nom = "";
	var var_lk_equ_id = "";
	var var_lk_equ_piece_nom = "";
	var var_lk_equ_piece_id = "";
	var var_lk_equ_imeuble_nom = "";
	var var_lk_equ_bien_nom = "";
	var var_lk_equ_date_installation = "";
	var var_lk_immeuble_id = "";
	var var_lk_bien_id = "";
	var var_lk_equ_quantite = "";

	Init_Autocomplete_Immeubles('#search_filtre_4', '#search_filtre_4_id', 'GB', 'get_autocomplete_immeubles');
	Init_Autocomplete_Logements('#search_filtre_5', '#search_filtre_5_id', 'GB', 'get_autocomplete_logements', '#search_filtre_4_id');

	function Init_Autocomplete_Immeubles($id_field, $id_hidden, $module, $action) {

		$($id_field).autocomplete({
			source: function (request, response) {
				var tb_request_term = request.term.split(' ');

				if (tb_request_term.length == 2) {

					var data_specific = {
						"data_first": tb_request_term[0],
						"data_second": tb_request_term[1]
					};

				} else {

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

				if ($id_field != '#search_filtre_4') {
					//$($id_field).attr('disabled', 'disabled');   
				} else {
					Trigger_Search_Liste();
				}

				return false;
			}
		}).focus(function () {
			setTimeout("if ($('" + $id_field + "').val().length == 0) $('" + $id_field + "').autocomplete(\"search\", \"\"); ", 1);
		}).live("blur", function (event) {
		});

	}

	function Init_Autocomplete_Logements($id_field, $id_hidden, $module, $action, $id_origin) {

		$($id_field).autocomplete({
			source: function (request, response) {
				var tb_request_term = request.term.split(' ');

				var data_specific = {
					"data_first": tb_request_term[0],
					"data_second": tb_request_term[1],
					"id": $($id_origin).val()
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

				DATA_Fill_Pieces();

				if ($id_field == '#search_filtre_5') {
					Trigger_Search_Liste();
				}

				return false;
			}
		}).focus(function () {
			setTimeout("if ($('" + $id_field + "').val().length == 0) $('" + $id_field + "').autocomplete(\"search\", \"\"); ", 1);
		}).live("blur", function (event) {
		});

	}

	$("#btn_search").click(function () {
		return false;
	});

	$("#btn_new").click(function () {
		FORM_POPUP(true);
		return false;
	});

	$("#btn_reset").click(function () {
		document.getElementById('equipements').reset();

		$('#search_filtre_4').val('');
		$('#search_filtre_5').val('');

		Trigger_Search_Liste();

		return false;
	});

	function Get_Equipement_Data($id) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		$('#titre_popup_equipement').html('Modification');

		var data_custom = {
			"id": $id
		};

		var data = {
			"zone": "gl",
			"action": "get_equipement",
			"data": {
				"data": data_custom
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		$.getJSON("/GL?action=get_equipement", data_json, function (data) {

			$.each(data, function (key, value) {
				$("#equ_nom").attr('value', value.equ_nom);
			});

		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
		});

	}

	function Save_Record($is_new_record) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		var data_ligne = {
			"id": $("#id_selected").val(),
			"bienID":$("#record_id").val(),
			"ple_piece_id": $('#ple_piece_id option:selected').val(),
			"ple_equ_id": $('#ple_equ_id option:selected').val(),
			"ple_quantite": $("#ple_quantite").val(),
			"ple_date_installation": $("#ple_date_installation").val()
		}

		if (typeof($is_new_record) != undefined) {
			
			if (($is_new_record == true) && ($('#equipementid').length > 0)) {
				//data_ligne.bienID = $("#record_id").val()
				data_ligne.equipementID = $('#equipementid').val();

				data_ligne["ple_equ_type"] = $('#equ_type').val();
				data_ligne["ple_equ_id"] = $('#equ_id').val();

				data_ligne.quantite = $('#quantite').val();
				data_ligne["dateInstallation"] = $('#dateinstallation').val();
			}
		}

		var data = {
			"zone": "gl",
			"action": "set_bien_piece",
			"data": {
				"data": data_ligne
			}
		};

		var data_json = '&json=' + JSON.stringify(data);
		var save_status = '';

		$.getJSON("/GL?action=set_pieces_lk_equ", data_json, function (data) {
			console.log(data);

			$.each(data, function (key, value) {
				save_status = value;
			});

		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");

			if (save_status != 'Failed') {
				Trigger_Search_Liste();
			} else {

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

	function FORM_POPUP($is_new_record) {

		if ($is_new_record == true) {
			$('#titre_popup_equipement').html('Nouveau équipement');
			$('#iw_form_popup_child_equipement .caption i').toggleClass("fa-pencil fa-file");
		} else {
			$('#titre_popup_equipement').html('Modification de l\'équipement');
			$('#iw_form_popup_child_equipement .caption i').toggleClass("fa-file fa-pencil");
		}

		var var_popup = $('#iw_form_popup_equipement').html();
		$('#iw_form_popup_equipement').html('');

		$.confirm({
			title: '',
			columnClass: 'iw_popup_form',
			content: '' +
				'<div>' + var_popup +
				'</div>',
			buttons: {
				cancel: {
					text: 'Fermer',
					btnClass: 'iw_btn_close',
					action: function () {
						$('#iw_form_popup_equipement').html(var_popup);
					}
				},
				formSubmit: {
					text: 'Enregistrer',
					btnClass: 'btn-blue iw_btn_save',
					action: function () {

						if (Check_Required_Fields(required_fields)) {
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
						} else {
							Save_Record($is_new_record);

							$('#iw_form_popup_equipement').html(var_popup);
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
					action: function (heyThereButton) {
						$.confirm({
							title: 'Suppression',
							content: 'Voulez-vous vraiment supprimer cet équipement ?',
							icon: 'fa fa-warning',
							animation: 'scale',
							closeAnimation: 'zoom',
							columnClass: 'iw_alert',
							buttons: {
								confirm: {
									text: 'Oui',
									btnClass: 'btn-orange',
									action: function () {
										$('#iw_form_popup_equipement').html(var_popup);
										Remove_Record();
									}
								},
								cancel: {
									text: 'Non',
									action: function () {

										$('#iw_form_popup_equipement').html(var_popup);

									}
								}
							}
						});

					}
				}
			},
			onContentReady: function () {
				// bind to events
				var jc = this;
				this.$content.find('form').on('submit', function (e) {
					// if the user submits the form by pressing enter in the field.
					e.preventDefault();
					jc.$$formSubmit.trigger('click'); // reference the button and click it

				});

				$('#field_bien_id').val(var_lk_bien_id);

				DATA_Fill_Pieces();

				Init_Autocomplete_Immeubles('#field_immeuble_nom', '#field_immeuble_id', 'GB', 'get_autocomplete_immeubles');
				Init_Autocomplete_Logements('#field_bien_nom', '#field_bien_id', 'GB', 'get_autocomplete_logements', '#field_immeuble_id');

				if ($('#ple_date_installation').length != 0) {
					$('#ple_date_installation').datepicker({
						format: 'dd/mm/yyyy'
					});	
				}else{
					$('#dateinstallation').datepicker({
						format: 'dd/mm/yyyy'
					});	
				}

				if ($is_new_record == true) {
					var_equ_type = "";
					var_equ_nom = "";
					var_lk_equ_id = "";
					var_lk_equ_piece_nom = "";
					var_lk_equ_piece_id = "";
					var_lk_equ_imeuble_nom = "";
					var_lk_equ_bien_nom = "";
					var_lk_equ_date_installation = "";
					var_lk_immeuble_id = "";
					var_lk_bien_id = "";
					var_lk_equ_quantite = "";

					$('#id_selected').val("");
				}

				$("#equ_type > [value='" + var_equ_type + "']").attr("selected", "true");

				if ($("#ple_equ_id").length != 0) {
					$("#ple_equ_id > [value='" + var_lk_equ_id + "']").attr("selected", "true");
					$("#ple_piece_id > [value='" + var_lk_equ_piece_id + "']").attr("selected", "true");

					$("#ple_quantite").attr('value', var_lk_equ_quantite);

					if (var_lk_equ_date_installation == "") {
						$("#ple_date_installation").datepicker().datepicker("setDate", new Date());
					} else {
						UTL_Date_Picker_Formatted(var_lk_equ_date_installation, '#ple_date_installation');
					}
				}else{
					$("#equ_id > [value='" + var_lk_equ_id + "']").attr("selected", "true");
					$("#quantite").attr('value', var_lk_equ_quantite);

					if (var_lk_equ_date_installation == "") {
						$("#dateinstallation").datepicker().datepicker("setDate", new Date());
					} else {
						$("#dateinstallation").attr('value', var_lk_equ_date_installation);
					}

					$("#equipementid").val("");

					$('#equ_id').change(function(){
						var $equipement_o = searchInArrayObject(visiteur.equipement, "EQU_Nom", $(this).val())

						if ($equipement_o != null) {
							$("#equipementid").val($equipement_o["ID"]);
						}
					})
				}

				$("#field_immeuble_nom").attr('value', var_lk_equ_imeuble_nom);
				$("#field_bien_nom").attr('value', var_lk_equ_bien_nom);

				$("#field_immeuble_id").attr('value', var_lk_immeuble_id);
				$("#field_bien_id").attr('value', var_lk_bien_id);

				$("#equ_type").change(function () {
					DATA_Fill_EQU_Noms();
				});

			}
		});
	}

	function Remove_Record() {
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
			"action": "gl_remove_equipement",
			"data": {
				"data": data_ligne
			}
		};

		var data_json = 'json=' + JSON.stringify(data);
		var operation_status = '';

		$.getJSON("/GL?action=gl_remove_equipement", data_json, function (data) {

			$.each(data, function (key, value) {
				operation_status = value;
			});

		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");

			if (operation_status == 'Failed') {

				$.confirm({
					title: 'Suppression',
					content: 'Impossible d\'effectuer la suppression car cet équipement est utilisé.',
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


			} else {
				Trigger_Search_Liste();
			}

		});

	}

	function Get_Record_Data($id) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		$('#titre_popup_equipement').html('Modification');

		var data_module = {
			"id": $id
		};

		var data = {
			"zone": "gl",
			"action": "get_equipement",
			"data": {
				"data": data_module
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		var_equ_type = "";
		var_equ_nom = "";
		var_lk_equ_id = "";
		var_lk_equ_piece_nom = "";
		var_lk_equ_piece_id = "";
		var_lk_equ_imeuble_nom = "";
		var_lk_equ_bien_nom = "";
		var_lk_equ_date_installation = "";
		var_lk_immeuble_id = "";
		var_lk_bien_id = "";
		var_lk_equ_quantite = "";

		$.getJSON("/GL?action=get_equipement_lk_piece", data_json, function (data) {
			console.log(data);

			$.each(data, function (key, value) {
				var_equ_nom = value.equ_nom;

				if (value.ple_equ_id != null) {
					var_lk_equ_id = value.ple_equ_id;

					var_lk_equ_piece_nom = value.lk_equ_piece_nom;
					var_lk_equ_piece_id = value.ple_piece_id;

					var_lk_equ_date_installation = value.ple_date_installation;

					var_lk_bien_id = value.lk_equ_bien_id;
					var_lk_equ_bien_nom = value.lk_equ_bien_nom;

					var_lk_equ_quantite = value.ple_quantite;
				}else{
					var_lk_equ_id = value.equ_nom;
					var_lk_equ_date_installation = value.dateinstallation;

					var_lk_bien_id = value.bienid;
					var_lk_equ_bien_nom = value.biennom;

					var_lk_equ_quantite = value.quantite;
				}
				
				var_equ_type = value.equ_type;

				var_lk_immeuble_id = value.lk_equ_imeuble_id;
				var_lk_equ_imeuble_nom = value.lk_equ_imeuble_nom;
			});

		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
			FORM_POPUP(false);
		});

	}
	//==========================================================================================================//
	// Liste
	//==========================================================================================================//

	var sbajaxurl = url_base + '/GL?action=equipements_b_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste() {

		var $table = $("#list_table")
			.tablesorter({
				theme: 'blue',
				widthFixed: true,
				sortLocaleCompare: false,
				sortList: [[0, 1]],
				widgets: ['filter'],
				widgetOptions: {
					filter_reset: '.fdp-btn-red',
					filter_saveFilters: true,
					filter_external: 'search'
				},
				headers: {
					0: {
						sorter: true,
						filter: false
					},
					1: {
						sorter: true,
						filter: false
					},
					2: {
						sorter: true,
						filter: false
					},
					3: {
						sorter: true,
						filter: false
					},
					4: {
						sorter: true,
						filter: false
					},
					5: {
						sorter: true,
						filter: false
					},
					6: {
						sorter: true,
						filter: false
					},
					7: {
						sorter: true,
						filter: false
					},
					8: {
						sorter: true,
						filter: false
					},
					9: {
						sorter: true,
						filter: false
					},
					10: {
						sorter: true,
						filter: false
					}
				}
			})

			.tablesorterPager({
				container: $(".pager"),
				ajaxUrl: sbajaxurl,

				customAjaxUrl: function (table, url) {
					$(table).trigger('changingUrl', url);
					return url;
				},

				ajaxError: null,

				ajaxObject: {
					dataType: 'json'
				},

				ajaxProcessing: function (data) {

					if (TS_Show_Loader == true) {
						$.LoadingOverlay("show");
					}

					if (data && data.hasOwnProperty('rows')) {
						var indx, r, row, c, d = data.rows,
							total = data.total_rows,
							headers = data.headers,
							headerXref = headers.join(',').replace(/\s+/g, '').split(','),
							rows = [],
							len = d.length;

						for (r = 0; r < len; r++) {
							row = [];

							for (c in d[r]) {

								if (typeof (c) === "string") {
									indx = $.inArray(c, headerXref);

									if (indx >= 0) {
										row[indx] = d[r][c];
									}
								}
							}
							rows.push(row);
						}

						return [total, rows, headers];
					}
				},

				processAjaxOnInit: true,
				output: '{startRow} to {endRow} ({totalRows})',
				updateArrows: true,
				page: 0,
				size: 20,
				savePages: false,
				storageKey: 'tablesorter-pager',
				pageReset: 0,
				fixedHeight: false,
				removeRows: false,
				countChildRows: false,
				cssNext: '.fa-angle-right',
				cssPrev: '.fa-angle-left',
				cssFirst: '.fa-angle-double-left',
				cssLast: '.fa-angle-double-right',
				cssGoto: '.gotoPage',
				cssPageDisplay: '.pagedisplay',
				cssPageSize: '.pagesize',
				cssDisabled: 'disabled',
				cssErrorRow: 'tablesorter-errorRow'

			});

		$.tablesorter.filter.bindSearch($table, $('.search'));

		// Allow changing an input from one column (any column) to another
		$('.search').change(function () {
			$('#list_table').trigger('updateHeaders');
			$("#list_table").trigger("update");

			// modify the search input data-column value (swap "0" or "all in this demo)
			$('.selectable').attr('data-column', $(this).val());

			// update external search inputs
			$.tablesorter.filter.bindSearch($table, $('.search'), false);
		});

		//assign the sortStart event
		$("table").bind("sortStart", function () {

			if (TS_Show_Loader == true) {
				$.LoadingOverlay("show");
			}

		}).bind("sortEnd", function () {
			$.LoadingOverlay("hide");
		});

		$('table').bind('filterStart', function (event, filters) {
		});

		$("table").bind('updateComplete', function (e, table) {
			$.LoadingOverlay("hide");
		});

		//************
		var $url = $('#url');
		$('table')

		// show current URL for the DEMO ONLY
		.on('changingUrl', function (e, url) {
			$url.html(url);

			$.LoadingOverlaySetup({
				background: "rgba(0, 0, 0, 0.5)",
				imageColor: "#fff"
			});

		})

		.on('pagerInitialized', function () {
			// allow THIS demo to sort the content; this variable is automatically set to true when ajax
			// is used as there isn't any way to sort the server side data from the client side.
			this.config.serverSideSorting = false;
			// show original highlighted URL
			$('#origurl').html(this.config.pager.ajaxUrl.replace(/(\{.*?\})/g, '<span class="results">$1</span>'));

		});

		$table.on('pagerComplete', function () {
			$.LoadingOverlay("hide");
		});

		$table.on('filterInit', function () {
		});
	}

	Init_DataTable_Liste();

	function Trigger_Search_Liste() {
		TS_Show_Loader = true;
		$("#list_table").trigger("update");

		var sorting = [[0, 0]];
		TS_Show_Loader = false;

		$("#list_table").trigger("sorton", [sorting]);
		var sorting = [[0, 1]];

		$("#list_table").trigger("sorton", [sorting]);
	}

	$('body').on('click', '#list_table div', function (ev) {
		$('#id_selected').val("");

		if (ev.target.id.indexOf('chx') == -1) {

			if (ev.target.id != 0) {
				$('#id_selected').val(ev.target.id);
				Get_Record_Data(ev.target.id);
			}

		}

	});

	//======================================================================//
	// Methodes de Gestion
	//======================================================================//

	function GES_Calcul($type) {
		var var_result = 0;
		var lig_prix_achat_ht = $("#equ_prix_achat_ht").val();
		var lig_tva = $('#equ_tva option:selected').val();
		var lig_prix_achat_ttc = $("#equ_prix_achat_ttc").val();

		switch ($type) {
			case 1:
				var_result = lig_prix_achat_ttc / (1 + (lig_tva / 100))
				Set_Input_Value("#equ_prix_achat_ht", var_result);
				break;
			case 2:
				var_result = lig_prix_achat_ht * (1 + (lig_tva / 100))
				Set_Input_Value("#equ_prix_achat_ttc", var_result);
				break;
			default:
				break;
		}

	}

	/************ sidebar action ***********/

	if (sbaction == 'new') {
		FORM_POPUP(true);
	}

	/***************************************************************************************************/

	function DATA_Fill_Pieces() {
		$('#ple_piece_id').empty();

		var data_specific = {
			"id": $('#field_bien_id').val()
		};

		var data_search = {
			"zone": "gl",
			"action": "get_piece_equipements",
			"data": data_specific
		};

		var data_json = 'json=' + JSON.stringify(data_search);

		$.getJSON("/GL?action=gl_bien_pieces_list_json", data_json, function (data) {

			if (data.length > 0) {

				$.each(data, function (key, value) {

					if (UTL_Select_OptionExists(value.id, 'ple_piece_id') == false) {
						$('#ple_piece_id').append('<option value="' + value.id + '" >' + value.pie_nom + '</option>');
					}

				});

			}

		}).done(function () {//success
		})
		.fail(function () { //error 
		})
		.always(function () { //complete
			$("#ple_piece_id > [value='" + var_lk_equ_piece_id + "']").attr("selected", "true");
		});

	}

	function DATA_Fill_EQU_Noms() {
		$('#ple_equ_id').empty();

		var data_specific = {
			"type": $('#equ_type option:selected').val()
		};

		var data_search = {
			"zone": "gl",
			"action": "get_piece_equipements",
			"data": data_specific
		};

		var data_json = 'json=' + JSON.stringify(data_search);

		$.getJSON("/GL?action=gl_equ_noms_list_json", data_json, function (data) {

			if (data.length > 0) {

				$.each(data, function (key, value) {

					if (UTL_Select_OptionExists(value.id, 'ple_equ_id') == false) {
						$('#ple_equ_id').append('<option value="' + value.id + '" >' + value.equ_nom + '</option>');
					}

				});

			}

		}).done(function () {//success
		})
		.fail(function () { //error 
		})
		.always(function () { //complete
		});

	}
});