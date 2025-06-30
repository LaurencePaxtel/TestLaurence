$(document).ready(function () {
	var url_base = window.location.origin;
	var var_tableliste_content = $('#list_table').html();
	var required_fields = "";
	var TS_Show_Loader = true;

	var var_equ_type = "";
	var var_equ_nom = "";
	var var_equ_reference_fabricant = "";
	var var_equ_reference_structure = "";
	var var_equ_garantie = "";
	var var_equ_date_achat = "";
	var var_equ_prix_achat_ht = "";
	var var_equ_tva = "";
	var var_equ_prix_achat_ttc = "";
	var var_equ_stock_min = "";

	var intervention_ids_selected = [];

	// Rémy Scanu <07/02/2024> - Ajout du code pour réappliquer les filtres si l'utilisateur a cliqué sur le bouton "Valider" dans une fiche hébergement
	managePreviousDataFilter("supprimer", "interventions", "search_filtre_0", "change");

	$("#btn_new").click(function () {
		$(location).attr('href', '/GL?action=intervention');
		return false;
	});

	$("#btn_reset").click(function () {
		document.getElementById('interventions').reset();

		Trigger_Search_Liste();
		return false;
	});

	$("#btn_delete").click(function(ev){ 
		Delete_Selection();
		return false;
	});

	$("#list_table").click(function(ev){
		$('#id_selected').val("");

		if (ev.target.id != 0) {
			$('#id_selected').val(ev.target.id);

			// Lorsque le clic est sur le checkbox, on ajoute la valeur de l
			if (ev.target.id.indexOf('chx') != -1){
				var positionChx = intervention_ids_selected.indexOf(ev.target.value);

				if (positionChx == -1) {
					intervention_ids_selected.push(ev.target.value);
				}else{
					intervention_ids_selected.splice(positionChx,1);
				}

				console.log(intervention_ids_selected);
			}else{

				managePreviousDataFilter("sauvegarder", "interventions", "", '/GL?action=intervention&id=' + ev.target.id, 
				[
					"search_filtre_0",
					"search_filtre_1",
					"search_filtre_2",
					"search_filtre_3",
					"search_filtre_4",
					"search_filtre_5"
				]);
			}
		}

	});

	function Delete_Selection(){

		$.confirm({
			title: 'Facturation',
			content: 'Voulez-vous vraiment supprimer cette sélection d\'intervention ?',
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
		  "ids": intervention_ids_selected.join(';')
		}   

		var data = { 
			"zone":"gl", 
			"action":"remove_intervention",
			"data": data_piece
		};

		var data_json = '&json=' + JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=interventions_selection_delete", data_json, function(data){  
		
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

	function Get_Intervention_Data($id) {

		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		$('#titre_popup_intervention').html('Modification');

		var data_custom = {
			"id": $id
		};

		var data = {
			"zone": "gl",
			"action": "get_intervention",
			"data": {
				"data": data_custom
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		$.getJSON("/GL?action=get_intervention", data_json, function (data) {

			$.each(data, function (key, value) {

				$("#equ_nom").attr('value', value.equ_nom);

			});


		}).done(function () {
		})
		.fail(function () {
		})
		.always(function () {
			$.LoadingOverlay("hide");
		});

	}

	function Save_Record() {

		$.LoadingOverlaySetup({
			background: "rgba(0, 0, 0, 0.5)",
			imageColor: "#fff"
		});

		$.LoadingOverlay("show");

		var data_custom = {
			"id": $("#id_selected").val(),
			"equ_type": $('#equ_type option:selected').val(),
			"equ_nom": $("#equ_nom").val(),
			"equ_reference_fabricant": $("#equ_reference_fabricant").val(),
			"equ_reference_structure": $("#equ_reference_structure").val(),
			"equ_garantie": $('#equ_garantie option:selected').val(),
			"equ_date_achat": $("#equ_date_achat").val(),
			"equ_prix_achat_ht": $("#equ_prix_achat_ht").val(),
			"equ_tva": $('#equ_tva option:selected').val(),
			"equ_prix_achat_ttc": $("#equ_prix_achat_ttc").val(),
			"equ_stock_min": $("#equ_stock_min").val()
		};

		var data = {
			"zone": "gl",
			"action": "set_intervention",
			"data": {
				"data": data_custom
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		$.getJSON("/GL?action=set_intervention", data_json, function (data) {


		}).done(function () {
		})
		.fail(function () {
		})
		.always(function () {
			$.LoadingOverlay("hide");
			Trigger_Search_Liste();
		});

	}

	function FORM_POPUP($is_new_record) {

		if ($is_new_record == true) {
			$('#titre_popup_intervention').html('Nouvelle intervention');
		} else {
			$('#titre_popup_intervention').html('Modification de l\'intervention');
		}

		var var_popup = $('#iw_form_popup_intervention').html();
		$('#iw_form_popup_intervention').html('');

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

						$('#iw_form_popup_intervention').html(var_popup);


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

							Save_Record();

							$('#iw_form_popup_intervention').html(var_popup);

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
							content: 'Voulez-vous vraiment supprimer cet intervention ?',
							icon: 'fa fa-warning',
							animation: 'scale',
							closeAnimation: 'zoom',
							columnClass: 'iw_alert',
							buttons: {
								confirm: {
									text: 'Oui',
									btnClass: 'btn-orange',
									action: function () {
										$('#iw_form_popup_intervention').html(var_popup);
										Remove_Record();
									}
								},
								cancel: {
									text: 'Non',
									action: function () {

										$('#iw_form_popup_intervention').html(var_popup);

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

				$('#equ_date_achat').datepicker({
					format: 'dd/mm/yyyy'
				});

				if ($is_new_record == true) {
					var_equ_type = "";
					var_equ_nom = "";
					var_equ_reference_fabricant = "";
					var_equ_reference_structure = "";
					var_equ_garantie = "";
					var_equ_date_achat = "";
					var_equ_prix_achat_ht = "";
					var_equ_tva = "";
					var_equ_prix_achat_ttc = "";
					var_equ_stock_min = "";
					$('#id_selected').val("");
				}

				$("#equ_type > [value='" + var_equ_type + "']").attr("selected", "true");
				$("#equ_nom").attr('value', var_equ_nom);
				$("#equ_reference_fabricant").attr('value', var_equ_reference_fabricant);
				$("#equ_reference_structure").attr('value', var_equ_reference_structure);
				$("#equ_garantie > [value='" + var_equ_garantie + "']").attr("selected", "true");

				if (var_equ_date_achat == "") {
					$("#equ_date_achat").datepicker().datepicker("setDate", new Date());
				} else {
					UTL_Date_Picker_Formatted(var_equ_date_achat, '#equ_date_achat');
				}

				$("#equ_prix_achat_ht").attr('value', var_equ_prix_achat_ht);
				$("#equ_tva").attr('value', var_equ_tva);
				$("#equ_prix_achat_ttc").attr('value', var_equ_prix_achat_ttc);
				$("#equ_stock_min").attr('value', var_equ_stock_min);

				$("#equ_prix_achat_ttc").change(function () {
					GES_Calcul(1);
				});

				$("#equ_tva").change(function () {
					GES_Calcul(2);
				});

				$("#equ_prix_achat_ht").change(function () {
					GES_Calcul(2);
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
			"action": "gl_remove_intervention",
			"data": {
				"data": data_ligne
			}
		};

		var data_json = 'json=' + JSON.stringify(data);
		var operation_status = '';

		$.getJSON("/GL?action=gl_remove_intervention", data_json, function (data) {


			$.each(data, function (key, value) {

				operation_status = value;

			});

		}).done(function () {
		})
		.fail(function () {
		})
		.always(function () {
			$.LoadingOverlay("hide");

			if (operation_status == 'Failed') {

				$.confirm({
					title: 'Suppression',
					content: 'Impossible d\'effectuer la suppression car cet intervention est utilisé.',
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

			}else {
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

		$('#titre_popup_intervention').html('Modification');

		var data_module = {
			"id": $id
		};

		var data = {
			"zone": "gl",
			"action": "get_intervention",
			"data": {
				"data": data_module
			}
		};

		var data_json = '&json=' + JSON.stringify(data);

		var_equ_type = "";
		var_equ_nom = "";
		var_equ_reference_fabricant = "";
		var_equ_reference_structure = "";
		var_equ_garantie = "";
		var_equ_date_achat = "";
		var_equ_prix_achat_ht = "";
		var_equ_tva = "";
		var_equ_prix_achat_ttc = "";
		var_equ_stock_min = "";

		$.getJSON("/GL?action=get_intervention", data_json, function (data) {

			$.each(data, function (key, value) {
				var_equ_nom = value.equ_nom;
				var_equ_type = value.equ_type;
				var_equ_reference_fabricant = value.equ_reference_fabricant;
				var_equ_reference_structure = value.equ_reference_structure;
				var_equ_garantie = value.equ_garantie;
				var_equ_date_achat = UTL_Date_Format(value.equ_date_achat, 2);
				var_equ_prix_achat_ht = value.equ_prix_achat_ht;
				var_equ_tva = value.equ_tva;
				var_equ_prix_achat_ttc = value.equ_prix_achat_ttc;
				var_equ_stock_min = value.equ_stock_min;
			});

		}).done(function () {
		})
		.fail(function () {
		})
		.always(function () {
			$.LoadingOverlay("hide");
			FORM_POPUP(false);
		});

	}

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//

	var sbajaxurl = url_base + '/GL?action=interventions_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste() {

		var $table = $("#list_table")
		.tablesorter({
			theme: 'blue',
			widthFixed: true,
			sortLocaleCompare: false,
			sortList: [[2, 1]],
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
			//$("#list_table").html('').html(var_tableliste_content);

			$('#list_table').trigger('updateHeaders');
			$("#list_table").trigger("update");

			// modify the search input data-column value (swap "0" or "all in this demo)
			$('.selectable').attr('data-column', $(this).val());

			// update external search inputs
			$.tablesorter.filter.bindSearch($table, $('.search'), false);
		});

		// Assign the sortStart event
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
			this.config.serverSideSorting = false;
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

		TS_Show_Loader = false;

		var sorting = [ [1,1] ]; 
		$("#list_table").trigger("sorton",[sorting]);
	}

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
});