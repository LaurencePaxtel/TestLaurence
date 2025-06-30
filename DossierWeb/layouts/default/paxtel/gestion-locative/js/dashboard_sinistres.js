$(document).ready(function () {
	var url_base = window.location.origin;
	var TS_Show_Loader = true;
	var var_tableliste_content = $('#liste_table_sinistres').html();

	var mandatory_fields_ligne = $("#mandatory_ligne").val().split(';');

	var sin_post_action = $("#sin_post_action").val();
	var sin_get_action = $("#sin_get_action").val();

	var sbaction = getUrlParameter('sbaction');

	var var_sin_immeuble_nom = "";
	var var_sin_immeuble_id = "";
	var var_sin_bien_nom = "";
	var var_sin_bien_id = "";
	var var_sin_libelle = "";
	var var_sin_cout = "";
	var var_sin_date = "";
	var var_sin_assurance_nom = "";
	var var_sin_assurance_contrat_no = "";
	var var_sin_assurance_montant = "";
	var var_sin_assurance_pe = "";
	var var_sin_travaux_cloture = "";

	var var_ad_adresse1 = "";
	var var_ad_adresse2 = "";
	var var_ad_adresse3 = "";
	var var_ad_code_postal = "";
	var var_ad_ville = "";
	var var_sin_commentaire = "";

	var ids_selected = [];

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
		Nouvelle_Fiche_Sinistre(true);
		return false;
	});

	$("#btn_delete").click(function(ev){ 
		Delete_Selection();
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

	function Nouvelle_Fiche_Sinistre($is_new_record) {

		if ($is_new_record == true) {
			$('#titre_popup').html('Nouveau sinistre');
		} else {
			$('#titre_popup').html('Modification');
		}

		var var_popup = $('#iw_form_popup').html();
		$('#iw_form_popup').html('');

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
							Save_Record_Line_Sinistre();

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

				$("input[type='checkbox']").on('change', function () {
					$(this).val(this.checked ? "true" : "false");
				});

				$('#sin_date').datepicker({
					format: 'dd/mm/yyyy'
				});

				Init_Autocomplete_Immeubles('#field_immeuble_nom', '#field_immeuble_id', 'GB', 'get_autocomplete_immeubles');
				Init_Autocomplete_Logements('#field_bien_nom', '#field_bien_id', 'GB', 'get_autocomplete_logements', '#field_immeuble_id');

				if ($is_new_record == false) {
					$("#field_immeuble_nom").attr('value', var_sin_immeuble_nom);
					$("#field_bien_nom").attr('value', var_sin_bien_nom);
					$("#field_immeuble_id").attr('value', var_sin_immeuble_id);
					$("#field_bien_id").attr('value', var_sin_bien_id);

					$("#sin_libelle").attr('value', var_sin_libelle);
					$("#sin_cout").attr('value', iw_round(var_sin_cout));

					$("#sin_assurance_nom").attr('value', var_sin_assurance_nom);
					$("#sin_assurance_contrat_no").attr('value', var_sin_assurance_contrat_no);
					$("#sin_assurance_montant").attr('value', iw_round(var_sin_assurance_montant));

					var dateParts = var_sin_date.split('/');
					var dateObj = new Date(dateParts[2], dateParts[1] - 1, dateParts[0]);

					$('#sin_date').datepicker({
						dateFormat: 'yy-mm-dd'
					}).datepicker('setDate', dateObj);

					$("#sin_assurance_pe").attr('value', var_sin_assurance_pe);

					if (var_sin_assurance_pe == true) {
						$("#sin_assurance_pe").prop("checked", true);
					}

					$("#sin_travaux_cloture").attr('value', var_sin_travaux_cloture);

					if (var_sin_travaux_cloture == true) {
						$("#sin_travaux_cloture").prop("checked", true);
					}

					$("#ad_adresse1").attr('value', var_ad_adresse1);
					$("#ad_adresse2").attr('value', var_ad_adresse2);
					$("#ad_adresse3").attr('value', var_ad_adresse3);
					$("#ad_code_postal").attr('value', var_ad_code_postal);
					$("#ad_ville").attr('value', var_ad_ville);
					$( "#sin_commentaire").attr('value', var_sin_commentaire);
				}

			}
		});

	}

	/********************************************************************************************************************* */
	function Save_Record_Line_Sinistre() {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		var data_address = {
			"ad_adresse1": $("#ad_adresse1").val(),
			"ad_adresse2": $("#ad_adresse2").val(),
			"ad_adresse3": $("#ad_adresse3").val(),
			"ad_code_postal": $("#ad_code_postal").val(),
			"ad_ville": $("#ad_ville").val()
		}

		var data_ligne = {
			"sin_origine_id": $("#field_bien_id").val(),
			"id_piece": $("#field_bien_id").val(),
			"id_ligne": $("#id_selected").val(),
			"sin_date": $("#sin_date").val(),
			"sin_libelle": $("#sin_libelle").val(),
			"sin_cout": $("#sin_cout").val(),
			"sin_assurance_pe": $("#sin_assurance_pe").val(),
			"sin_assurance_nom": $("#sin_assurance_nom").val(),
			"sin_travaux_cloture": $("#sin_travaux_cloture").val(),
			"sin_assurance_montant": $("#sin_assurance_montant").val(),
			"sin_assurance_contrat_no": $("#sin_assurance_contrat_no").val(),
			"sin_commentaire": $("#sin_commentaire").val(),
			"adresse": {
				"data": data_address
			}
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

		$.getJSON("/GL?action=" + sin_post_action, data_json, function (data) {

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

	$('body').on('click', '#liste_table_sinistres div', function (ev) {
		$('#id_selected').val("");
	
		if (ev.target.id != 0){
			$('#id_selected').val(ev.target.id);

			// Lorsque le clic est sur le checkbox, on ajoute la valeur
			if (ev.target.id.indexOf('chx') != -1){
				var positionChx = ids_selected.indexOf(ev.target.value);

				if (positionChx == -1) {
					ids_selected.push(ev.target.value);
				}else{
					ids_selected.splice(positionChx, 1);
				}

				console.log(ids_selected);
			}else {
				Get_Record_Data(ev.target.id);
			}

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

		var_sin_immeuble_nom = "";
		var_sin_immeuble_id = "";
		var_sin_bien_nom = "";
		var_sin_bien_id = "";
		var_sin_libelle = "";
		var_sin_cout = "";
		var_sin_date = "";
		var_sin_assurance_nom = "";
		var_sin_assurance_contrat_no = "";
		var_sin_assurance_montant = "";
		var_sin_assurance_pe = "";
		var_sin_travaux_cloture = "";
		var_sin_commentaire = "";

		$.getJSON("/GL?action=get_sinistre", data_json, function (data) {

			$.each(data, function (key, value) {
				var_sin_immeuble_nom = value.lk_imeuble_nom;
				var_sin_immeuble_id = value.lk_imeuble_id;
				var_sin_bien_nom = value.lk_bien_nom;
				var_sin_bien_id = value.lk_bien_id;
				var_sin_libelle = value.sin_libelle;
				var_sin_cout = value.sin_cout;
				var_sin_date = value.sin_date;
				var_sin_assurance_nom = value.sin_assurance_nom;
				var_sin_assurance_contrat_no = value.sin_assurance_contrat_no;
				var_sin_assurance_montant = value.sin_assurance_montant;
				var_sin_assurance_pe = value.sin_assurance_pe;
				var_sin_travaux_cloture = value.sin_travaux_cloture;
				var_sin_commentaire = value.sin_commentaire;
			});


		}).done(function () {//success

		})
		.fail(function () { //error

		})
		.always(function () { //complete
			$.LoadingOverlay("hide");

			Get_Address($id);
		});

	}

	function Get_Address($id) {
		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		var data_address = {
			"id": $id
		};

		var data = {
			"zone": "gl",
			"action": "get_address",
			"data": {
				"address": data_address
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		var_ad_adresse1 = "";
		var_ad_adresse2 = "";
		var_ad_adresse3 = "";
		var_ad_code_postal = "";
		var_ad_ville = "";

		$.getJSON("/GL?action=get_address_sinistre", data_json, function (data) {

			$.each(data, function (key, value) {
				var_ad_adresse1 = value.ad_adresse1;
				var_ad_adresse2 = value.ad_adresse2;
				var_ad_adresse3 = value.ad_adresse3;
				var_ad_code_postal = value.ad_code_postal;
				var_ad_ville = value.ad_ville;
			});

		}).done(function () {//success
		})
		.fail(function () { //error
		})
		.always(function () { //complete
			$.LoadingOverlay("hide");
			Nouvelle_Fiche_Sinistre(false);
		});

	}

	function Delete_Selection(){

		$.confirm({
			title: 'Sinistre',
			content: 'Voulez-vous vraiment supprimer cette sélection de sinistres ?',
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
		
		var data_piece = {
		  "ids": ids_selected.join(';')
		}   

		var data = { 
			"zone":"gl", 
			"action":"set_location",
			"data": data_piece
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=sinistres_selection_delete",data_json, function(data){  
		
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
					Trigger_Search_Liste();
				}

			}

		});
	}

	/************ sidebar action ***********/

	if (sbaction == 'new') {
		Nouvelle_Fiche_Sinistre(true);
	}

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//

	var sbajaxurl = url_base + '/GL?action=sinistres_list_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste() {

		var $table = $("#liste_table_sinistres")
			.tablesorter({
				theme: 'blue',
				widthFixed: true,
				sortLocaleCompare: false,
				sortList: [[0, 1]],
				widgets: ['filter'],
				widgetOptions: {
					filter_reset: '.fdp-btn-red',
					filter_saveFilters: false,
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
						sorter: false,
						filter: false
					},
					3: {
						sorter: false,
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
										}
										else {
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
			//$("#liste_table_sinistres").html('').html(var_tableliste_content);

			$('#liste_table_sinistres').trigger('updateHeaders');
			$("#liste_table_sinistres").trigger("update");

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
			$('#liste_table_sinistres tr:last td').css('color', 'white').css('background-color', '#0d72b9');
			$.LoadingOverlay("hide");
		});

		$table.on('filterInit', function () {
		});
	}

	Init_DataTable_Liste();

	function Trigger_Search_Liste() {
		TS_Show_Loader = true;
		$("#liste_table_sinistres").trigger("update");
		
		var sorting = [[0, 0]];
		TS_Show_Loader = false;
		
		$("#liste_table_sinistres").trigger("sorton", [sorting]);

		var sorting = [[0, 1]];
		$("#liste_table_sinistres").trigger("sorton", [sorting]);
	}

});