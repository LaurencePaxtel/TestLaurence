$(document).ready(function () {
	var var_tableliste_content = $('#list_table_reglements_').html();
	var url_base = window.location.origin;
	var required_fields = '';

	//=================================================================//
	// Default dates
	//=================================================================// 
	var first_load = sessionStorage.getItem('first_load');
	var date_du_current = '';
	var date_au_current = '';

	if (first_load == 'true') {
		var date_current_object = new Date();
		date_du_current = date_current_object.format("dd/mm/yyyy");
		date_au_current = date_current_object.format("dd/mm/yyyy");
	} else {
		date_du_current = sessionStorage.getItem('session_date_du');
		date_au_current = sessionStorage.getItem('session_date_au');
	}

	$('#search_date_du').datepicker('update', date_du_current);
	$('#search_date_au').datepicker('update', date_au_current);

	$('#search_date_du').data("data-val");
	$('#search_date_du').data('data-val', date_du_current);
	$('#search_date_au').data("data-val");
	$('#search_date_au').data('data-val', date_au_current);

	//=================================================================//
	// Search : Filters
	//=================================================================//
	$('#btn_left').off('click');
	$('#btn_left').off('dblclick');

	$('#btn_next').off('click');
	$('#btn_next').off('dblclick');

	$("#btn_left").click(function (ev) {

		if ($('#search_date_du').val() == '') {
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

	$("#btn_next").click(function (ev) {

		if ($('#search_date_au').val() == '') {
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

	function Table_Liste_Refresh() {
		$('#list_table_reglements_').trigger('updateHeaders');
		$("#list_table_reglements_").trigger("update");
	}

	$("#list_table_reglements div").click(function (ev) {
		var data_search = {
			"id": ev.target.id
		};

		$('#id_selected').val(ev.target.id);
		$(location).attr('href', '/GL?action=reglement&id=' + ev.target.id);
	});

	$("#btn_new").click(function (ev) {
		Nouvelle_Fiche(ev);
		return false;
	});

	$("#btn_reset").click(function (ev) {
		$('#list_table_reglements_').trigger('filterResetSaved');

		$("#search_destinataire_id").val('')
		$("#search_date_du").val('')
		$("#search_date_au").val('')

		$('#list_table_reglements_').trigger('updateHeaders');
		$("#list_table_reglements_").trigger("update");

		sessionStorage.setItem('first_load', 'true');
		return false;
	});

	function Get_Record_Data($id) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");
		$('#titre_popup').html('Modification');

		var data_module = {
			"id": $id
		};

		var data = {
			"zone": "gl",
			"action": "get_facture",
			"data": {
				"location": data_module
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		$.getJSON("/GL?action=get_facture", data_json, function (data) {

			$.each(data, function (key, value) {
				$("#bien_en_location").attr('value', value.loc_bien_name);
				$("#loc_bien_id").attr('value', value.loc_bien_id);
				$("#usager").attr('value', value.loc_usager_name);
				$("#loc_hb_id").attr('value', value.loc_hb_id);
				$("#loc_montant_initial").attr('value', iw_round(value.loc_montant_initial));
				$("#loc_montant_revise").attr('value', iw_round(value.loc_montant_revise));
				$("#loc_garantie_montant").attr('value', iw_round(value.loc_garantie_montant));

				UTL_Date_Picker_Formatted(value.loc_date, '#loc_date');
				UTL_Date_Picker_Formatted(value.loc_date_entree, '#loc_date_entree');
				UTL_Date_Picker_Formatted(value.loc_date_sortie, '#loc_date_sortie');

				Init_Autocomplete('#usager', '#loc_hb_id', 'GB', 'get_autocomplete_usagers');
				Init_Autocomplete('#bien_en_location', '#loc_bien_id', 'GB', 'get_autocomplete_centres');

				if (value.loc_garantie_encaisse == 'True') {
					$("#loc_garantie_encaisse").prop("checked", true);
				}

				$("input[type='checkbox']").on('change', function () {
					$(this).val(this.checked ? "true" : "false");
				});
			});


		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
		});

	}

	function Save_Record() {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
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
			"zone": "gl",
			"action": "set_location",
			"data": {
				"location": data_location
			}
		};

		var data_json = '&json=' + JSON.stringify(data);
		var save_status = '';

		$.getJSON("/GL?action=location_fiche_valider", data_json, function (data) {

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

	function Nouvelle_Fiche() {
		$(location).attr('href', '/GL?action=reglement');
	}

	function Display_Table_List() {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");
		$('#list_table_reglements .table').empty();

		var data_specific = {
			"search_date_du": $("#search_date_du").val(),
			"search_date_au": $("#search_date_au").val(),
			"search_destinataire": $("#search_destinataire_id").val()
		};

		var data_search = {
			"zone": "gl",
			"action": "get_reglements",
			"data": data_specific
		};

		var data_json = '&json=' + JSON.stringify(data_search);

		$.getJSON("/GL?action=reglements_list_json", data_json, function (data) {

			$('#list_table_reglements .table').empty();

			var resp_table_data = '';

			resp_table_data += '<div class="row header">';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += 'N° de pièce';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell iw_second_column" style="min-width: 100px;">';
			resp_table_data += 'Date du règlement';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell " style="min-width: 120px;">';
			resp_table_data += 'Bien';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell " style="min-width: 120px;">';
			resp_table_data += 'Locataire';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += 'Montant';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += 'Mode du règlement';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += 'Date d\'échéance';
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
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data += value.reg_no_piece;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell  " id="' + value.id + '">';
					resp_table_data += Get_Date_Formatted(value.reg_date);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data += value.reg_bien_nom;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data += value.reg_locataire_nom;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data += iw_round(value.reg_montant);
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data += value.reg_mode_reglement;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell " id="' + value.id + '">';
					resp_table_data += Get_Date_Formatted(value.reg_date_echeance);
					resp_table_data += '</div>';
					resp_table_data += '</div>';

					$('<input>', {
						type: 'hidden',
						id: 'id' + value.id,
						name: 'id' + value.id,
						value: value.id
					}).appendTo('#list_table_reglements');


					counter = counter + 1;
				});

			}

			$("#list_table_reglements .table").append(resp_table_data);

		}).done(function () {//success

		})
		.fail(function () { //error
			Display_Table_List();
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
		});

	}

	Init_Autocomplete('#search_destinataire', '#search_destinataire_id', 'GB', 'get_autocomplete_centres');

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//
	$('body').on('click', '#list_table_reglements_ div', function (ev) {

		if (ev.target.id != '') {
			var data_search = {
				"id": ev.target.id
			};

			$('#id_selected').val(ev.target.id);
			$(location).attr('href', '/GL?action=reglement&id=' + ev.target.id);
		}

	});

	var sbajaxurl = url_base + '/GL?action=reglements_list_spec_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste() {

		var $table = $("#list_table_reglements_")
		.tablesorter({
			theme: 'blue',
			widthFixed: true,
			sortLocaleCompare: true,
			sortList: [[5, 1]],
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
				$.LoadingOverlay("show");

				if (data && data.hasOwnProperty('rows')) {
					var indx, r, row, c, d = data.rows,

					total = data.total_rows,
					headers = data.headers,
					headerXref = headers.join(',').replace(/\s+/g, '').split(','),
					rows = [],
					total_row = [],
					len = d.length;

					for (r = 0; r < len; r++) {
						row = [];

						for (c in d[r]) {

							if (typeof (c) === "string") {
								indx = $.inArray(c, headerXref);

								var stripped = d[r][c].replace(/<\/?[^>]+(>|$)/g, "").replace(",", ".");
								var float = parseFloat(stripped);
								
								if (indx >= 0) {
									row[indx] = d[r][c];
								
									if (/^\-?\d*\.?\d+$/.test(stripped) && !isNaN(float)) {
										total_row[indx] = ((total_row[indx]) ? total_row[indx] : 0) + float;
									} else {
										total_row[indx] = "";
									}

								}

								if (indx == 0) {
									total_row[indx] = "Total";
								}
							}
						}

						rows.push(row);
					}
					var total_row_parsed = total_row.map(function (elem) {
						if (elem != "Total" && elem != "") {
							elem = elem.toLocaleString("fr", { maximumFractionDigits: 2 }) + " €";
						}
						return elem;
					});
					rows.push(total_row_parsed);
					return [total, rows, headers];
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

		$("table").bind("sortStart", function () {
			$.LoadingOverlay("show");
		}).bind("sortEnd", function () {
			$.LoadingOverlay("hide");
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

			var first_load = sessionStorage.getItem('first_load');

			if (first_load == 'true') {
				$('#list_table_reglements_').trigger('updateHeaders');
				$("#list_table_reglements_").trigger("update");

				var columns = [];
				columns[1] = date_du_current;
				columns[2] = date_au_current;

				$('#list_table_reglements_').trigger('search', [columns]);
			}

			sessionStorage.setItem('first_load', 'false');
		});

		$table.on('pagerComplete', function () {
			$('#list_table_reglements_ tr:last td').css('color', 'white').css('background-color', '#0d72b9');
			$.LoadingOverlay("hide");
		});

	}

	Init_DataTable_Liste();
});  