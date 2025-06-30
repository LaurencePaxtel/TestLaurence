$(document).ready(function () {
	var url_base = window.location.origin;
	var TS_Show_Loader = true;
	var var_tableliste_content = $('#liste_table_charges').html();

	var mandatory_fields_ligne = $("#mandatory_ligne_charge").val().split(';');

	var cha_post_action = $("#cha_post_action").val();
	var cha_get_action = $("#cha_get_action").val();

	var cha_selected_month = '';

	var sbaction = getUrlParameter('sbaction');

	var var_cha_immeuble_nom = "";
	var var_cha_immeuble_id = "";

	var var_cha_bien_nom = "";
	var var_cha_bien_id = "";

	var var_cha_libelle = "";
	var var_cha_montant = "";

	var var_cha_periode = "";
	var var_cha_periode_fin = "";

	Init_Autocomplete_Immeubles('#search_filtre_0', '#search_filtre_0_id', 'GB', 'get_autocomplete_immeubles');
	Init_Autocomplete_Logements('#search_filtre_1', '#search_filtre_1_id', 'GB', 'get_autocomplete_logements', '#search_filtre_0_id');

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

				if ($id_field == '#search_filtre_0') {
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
				if ($id_field == '#search_filtre_1') {
					Trigger_Search_Liste();
				}

				return false;
			}
		}).focus(function () {
			setTimeout("if ($('" + $id_field + "').val().length == 0) $('" + $id_field + "').autocomplete(\"search\", \"\"); ", 1);
		}).live("blur", function (event) {
		});
	}

	$("#btn_new").click(function () {
		Nouvelle_Fiche_Charge(true);

		return false;
	});

	$('body').on('click', '#btn_reset', function (ev) {
		$('#search_filtre_0').val('');
		$('#search_filtre_0_id').val('');
		$('#search_filtre_1').val('');
		$('#search_filtre_1_id').val('');

		document.getElementById('sinistres').reset();

		Trigger_Search_Liste();

		return false;
	});

	function Nouvelle_Fiche_Charge($is_new_record) {
		
		if ($is_new_record == true) {
			$('#titre_popup_charge').html('Nouvelle charge');
		} else {
			$('#titre_popup_charge').html('Modification');
		}

		var var_popup = $('#iw_form_popup_charge').html();
		$('#iw_form_popup_charge').html('');

		$.confirm({
			title: '',
			content: '' +
				'<div>' + var_popup +
				'</div>',
			buttons: {
				formSubmit: {
					text: 'Enregistrer',
					btnClass: 'btn-blue',
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
							Save_Record_Line_Charge();

							$('#iw_form_popup_charge').html(var_popup);

							return true;
						}
					}
				},
				cancel: {
					text: 'Fermer',
					action: function () {
						$('#iw_form_popup_charge').html(var_popup);
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

				$("input[type='checkbox']").on('change', function () {
					$(this).val(this.checked ? "true" : "false");
				});

				$('#sin_date').datepicker({
					format: 'dd/mm/yyyy'
				});

				Init_Autocomplete_Immeubles('#field_immeuble_nom', '#field_immeuble_id', 'GB', 'get_autocomplete_immeubles');
				Init_Autocomplete_Logements('#field_bien_nom', '#field_bien_id', 'GB', 'get_autocomplete_logements', '#field_immeuble_id');

                $('#cha_periode').datepicker({
                    "format": "mm-yyyy",
                    'startView': 1,
                    'maxViewMode': 1
                }).on('changeMonth', function(e) {
                    var dp = $(e.currentTarget).data('datepicker');

                    dp.date = e.date;
                    dp.setValue();
                    dp.hide();

                    cha_selected_month = $('#cha_periode').val();
                });

                $("#cha_periode").parent().find(".fa-calendar").click(function() {
                    $('#cha_periode').datepicker('show');
                });
                
                // Ajout d'une période de fin par Scanu Rémy - remy@connect-io.fr
                $('#cha_periode_fin').datepicker({
                    "format": "mm-yyyy",
                    'startView': 1,
                    'maxViewMode': 1
                }).on('changeMonth', function(e) {
                    var dp = $(e.currentTarget).data('datepicker');

                    dp.date = e.date;
                    dp.setValue();
                    dp.hide();
                    
                    cha_fin_selected_month = $('#cha_periode_fin').val();
                });

                $("#cha_periode_fin").parent().find(".fa-calendar").click(function() {
                    $('#cha_periode_fin').datepicker('show');
                });

				if ($is_new_record == false) {
					$("#field_immeuble_nom").attr('value', var_cha_immeuble_nom);
					$("#field_bien_nom").attr('value', var_cha_bien_nom);
					$("#field_immeuble_id").attr('value', var_cha_immeuble_id);
					$("#field_bien_id").attr('value', var_cha_bien_id);

					$("#cha_libelle").attr('value', var_cha_libelle);
					$("#cha_montant").attr('value', iw_round(var_cha_montant));

					$("#cha_periode").attr('value', var_cha_periode);
					$("#cha_periode_fin").attr('value', var_cha_periode_fin);
				}
			}
		});
	}

	/********************************************************************************************************************* */
	function Save_Record_Line_Charge() {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		var charge_montant = $("#cha_montant").val().replace(/,/g, '.');

		var data_ligne = {
			"cha_origine_id": $("#field_bien_id").val(),
			"id_piece": $("#field_bien_id").val(),
			"id_ligne": $("#id_selected").val(),
			"cha_date": $("#cha_date").val(),
			"cha_periode": cha_selected_month,
			"cha_libelle": $('#cha_libelle option:selected').val(),
			"cha_montant": charge_montant
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

		$.getJSON("/GL?action=" + cha_post_action, data_json, function (data) {

            $.each(data, function (key, value) {
                save_status = value;
            });

        }).done(function () { //success

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

	$('body').on('click', '#liste_table_charges div', function (ev) {

		if (ev.target.id != '') {
			$('#id_selected').val(ev.target.id);
			Get_Record_Data(ev.target.id);
		}

	});

	function Get_Record_Data($id) {
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
			"action": "get_bien_ligne",
			"data": {
				"ligne": data_module
			}
		};

		var data_json = 'json=' + JSON.stringify(data);

		var_cha_immeuble_nom = "";
		var_cha_immeuble_id = "";
		var_cha_bien_nom = "";
		var_cha_bien_id = "";
		var_cha_libelle = "";
		var_cha_montant = "";
		var_cha_periode = "";

		$.getJSON("/GL?action=get_charge", data_json, function (data) {

            $.each(data, function (key, value) {
                var_cha_immeuble_nom = value.lk_imeuble_nom;
                var_cha_immeuble_id = value.lk_imeuble_id;

                var_cha_bien_nom = value.lk_bien_nom;
                var_cha_bien_id = value.lk_bien_id;

                var_cha_libelle = value.cha_libelle;
                var_cha_montant = value.cha_montant;

                var_cha_periode = value.cha_periode;
				var_cha_periode_fin = value.cha_periode_fin;

                $("#cha_periode").val(var_cha_periode);
            });

        }).done(function () { //success
        })
        .fail(function () { //error
        })
        .always(function () { //complete
            $.LoadingOverlay("hide");
            Nouvelle_Fiche_Charge(false);
        });
	}

	/************ sidebar action ***********/

	if (sbaction == 'new') {
		Nouvelle_Fiche_Charge(true);
	}

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//

	var sbajaxurl = url_base + '/GL?action=charges_list_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste() {

		var $table = $("#liste_table_charges")
			.tablesorter({
				theme: 'blue',
				widthFixed: true,
				sortLocaleCompare: false,
				sortList: [
					[2, 1]
				],
				widgets: ['filter'],
				widgetOptions: {
					filter_reset: '.fdp-btn-red',
					filter_saveFilters: false,
					filter_external: 'search'
				},
				headers: {
					0: {
						sorter: false,
						filter: false
					},
					1: {
						sorter: false,
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
                        total_row = [],

                        len = d.length;
						console.log(data.rows);

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
								elem = elem.toLocaleString("fr", {
									maximumFractionDigits: 2
								}) + " €";
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
			//$("#liste_table_charges").html('').html(var_tableliste_content);
			$('#liste_table_charges').trigger('updateHeaders');
			$("#liste_table_charges").trigger("update");

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
			$('#liste_table_charges tr:last td').css('color', 'white').css('background-color', '#0d72b9');
			$.LoadingOverlay("hide");
		});

	}

	Init_DataTable_Liste();

	function Trigger_Search_Liste() {
		TS_Show_Loader = true;

		$("#liste_table_charges").trigger("update");
		var sorting = [
			[2, 0]
		];
		TS_Show_Loader = false;

		$("#liste_table_charges").trigger("sorton", [sorting]);
		var sorting = [
			[2, 1]
		];

		$("#liste_table_charges").trigger("sorton", [sorting]);
	}
});