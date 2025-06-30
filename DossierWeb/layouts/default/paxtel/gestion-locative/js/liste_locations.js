$(document).ready(function(){
	var url_base= window.location.origin;
	var var_tableliste_content = $('#list_table_locations').html();

	var locations_ids_selected = [];

	var url_action = getUrlParameter('action');
	var TS_Show_Loader = true;
	var initLoading = false;

	Recalculer_IRL();

	// Rémy Scanu <07/02/2024> - Ajout du code pour réappliquer les filtres si l'utilisateur a cliqué sur le bouton "Valider" dans une fiche hébergement
	managePreviousDataFilter("supprimer", "locations", "btn_search");
	
	if (url_action == 'bien'){
		Display_Table_List();
	}

	if ($("#mandatory_fac_auto_ligne").length > 0) {
		var mandatory_fac_auto_ligne = $("#mandatory_fac_auto_ligne").val().split(';');	
	}

    $('#btn_fac_auto').on('click', function () {
        FAC_Auto_Popup();
        return false;
    });

	$("#btn_new").click(function(ev){ 
		Nouvelle_Fiche(ev);
		return false;
	});

	$("#btn_delete").click(function(ev){ 
		Delete_Selection();
		return false;
	});

	$("#btn_search").click(function(){  
		Trigger_Search_Liste();
		return false;
	});  

	$("#btn_recalculer").click(function(){  
		Recalculer_IRL(true);
		Trigger_Search_Liste();
		
		return false;
	});  

	$("#btn_reset").click(function(){  
		document.getElementById('locations').reset();

		$("#search_bien_id").val('');
		$("#search_usager_id").val('');

		$('#search_date').val('');
		$('#search_bien_location').val('');
		$('#search_usager').val('');

		Trigger_Search_Liste();
		return false;
	});

	function Delete_Selection(){

		$.confirm({
			title: 'Facturation',
			content: 'Voulez-vous vraiment supprimer cette sélection de locations ?',
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
		  "ids": locations_ids_selected.join(';')
		}   

		var data = { 
			"zone":"gl", 
			"action":"set_location",
			"data": data_piece
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=locations_selection_delete",data_json, function(data){  
		
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

	function Recalculer_IRL($show_alert=false){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");
		$('#titre_popup').html('Modification');

		var data = { 
			"zone":"gl", 
			"action":"irl_recalculer",
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=irl_recalculer",data_json, function(data){  
		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if ($show_alert==true){

				$.alert({
					title: 'Succès',
					content: 'Le calcul de du montant revisé a été effectué avec succès.',
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

	}

	function Nouvelle_Fiche(){
		$(location).attr('href', '/GL?action=location&retour='+url_action); 
	}

	function Display_Table_List(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$('#int-usager .table').empty();
		$('#int-usager-result .table').empty();

		var data_specific = {
			"search_bien_location": $("#search_bien_id").val(),
			"search_usager": $("#search_usager_id").val(),
			"search_date": $("#search_date").val()
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_locations",
			"data": data_specific
		};
		
		var data_json = '&json='+JSON.stringify(data_search);
		
		$.getJSON("/GL?action=locations_list_json",data_json, function(data){  
			$('#list_table .table').empty();

			var resp_table_data='';

			resp_table_data +='<div class="row header">';
			resp_table_data +='<div class="cell " style="min-width: 120px;">';
			resp_table_data +='Date du bail';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell iw_second_column" style="min-width: 100px;">';
			resp_table_data +='Usager';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Bien en location';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Montant du loyer';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Montant revisé';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Date d\'entrée dans les lieux';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Date de sortie des lieux';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='APL';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Charges';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Statut';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Commentaires';
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
					resp_table_data +='<div class="cell  " id="'+value.id+'">';
					resp_table_data +=value.loc_usager_name;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data +=value.loc_bien_name;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data +=iw_round(value.loc_montant_initial);
					resp_table_data +='</div>';
					console.log(value.loc_montant_revise); // Ajoute ceci avant d'insérer dans `resp_table_data`
					resp_table_data +='<div class="cell " id="'+value.id+'">';
					resp_table_data +=iw_round(value.loc_montant_revise);
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
					}).appendTo('#list_table');

					counter = counter + 1;
				});

			}

			$("#list_table .table").append(resp_table_data);

		}).done(function() {//success
		})
		.fail(function() { //error
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
	}

	function FAC_Auto_Popup(){
		$('#titre_popup').html('Facturation automatique');

		var var_popup = $('#iw_form_popup').html();
		$('#iw_form_popup').html('');

		$.confirm({
			title: '',
			content: '' +
			'<div>' +var_popup+     
			'</div>',
			buttons: {
				formSubmit: {
					text: 'Lancer',
					btnClass: 'btn-blue',
					action: function () {

						if (Check_Required_Fields(mandatory_fac_auto_ligne)){
							Mark_All_Required_Fields(mandatory_fac_auto_ligne);

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

							$.confirm({
								title: 'Facturation automatique',
								content: 'Vous êtes entrain de lancer la facturation automatique pour le mois choisi, Voulez-vous continuer ?',
								icon: 'fa fa-warning',
								animation: 'scale',
								closeAnimation: 'zoom',
								columnClass: 'iw_alert',
								buttons: {
									confirm: {
										text: 'Oui',
										btnClass: 'btn-orange',
										action: function () {
											Facturation_Automatique(selected_month, param_separation_charges);
										}
									},
									Non: {
										text: 'Non',
										action: function () {
										}
									}
								
								}
							});

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

				$('#fac_auto_mois').datepicker({
					"format": "mm-yyyy",
					'startView': 1,
					'maxViewMode': 1
				}).on('changeMonth', function(e) {
					var dp = $(e.currentTarget).data('datepicker');

					dp.date = e.date;
					dp.setValue();
					dp.hide();
					selected_month = $('#fac_auto_mois').val();
				});

				$('.control-group .fa-calendar').click(function(){
					$('#fac_auto_mois').datepicker('show');
				});
			}
		});
	}

    function Facturation_Automatique($mois, $separation){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		var today = new Date(Date.now());
		var date = today.getDate()+'/'+(today.getMonth()+1)+'/'+today.getFullYear();
		var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();

		var data_pointage = { 
		  "date_client": date,
		  "heure_client": time,
		  "fac_auto_mois": $mois,
		  "separation_charges": $separation,
		  "locationSelected": JSON.stringify(locations_ids_selected)
		};

		var data = { 
			"zone":"GL", 
			"action":"facturation_automatique",
			"data": {
				"facturation": data_pointage
			}
		};

		var save_status='';
		var data_json = 'json='+JSON.stringify(data);

		$.getJSON("/GL?action=facturation_automatique", data_json, function(data){

			$.each(data, function(key, value){  
				save_status = value;				
			});

		}).done(function() {
		})
		.fail(function() {
		})
		.always(function(response) {
			var $title = "";
			var $message = "";
			var $notificationError = "";

			console.log(response);
			
			if (response.Status >= 1){
				$title = 'Alerte';
				$message = 'Opération effectué avec succès : ' + response.Status + ' facture(s) générée(s).';
			}

			if (response.Status == 0){ 
				$message = 'Pas de factures à générer pour le mois choisi.';
				$title = 'Alerte';
			}

			$.alert({
				title: $title,
				content: $message ,
				icon: 'fa fa-check',
				animation: 'scale',
				closeAnimation: 'scale',
				columnClass: 'iw_alert',
				buttons: {
					okay: {
						text: 'Ok',
						btnClass: 'btn-blue',
						action: function () {
							
							response.location.forEach(element => {
								
								if (element.notificationError != null) {

									if ($notificationError == "") {
										$notificationError = "<ul id='notificationError'>";
									}

									$notificationError += "<li>Locataire : " + element.locataire + " (bien - " + element.bien + ")<br/>" + element.notificationError + "</li>";
								}

							});

							if ($notificationError != "") {
								$notificationError += "</ul>";

								$.alert({
									title: '',
									content: $notificationError,
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
						}
					}
				}
			});

			$.LoadingOverlay("hide");
		});
    }

	function Init_DataTable_Liste(){

		$("table").bind("tablesorter-initialized",function(e, table) {
			$('input:checkbox[value="' + 'Location en cours' + '"]').attr('checked', true);
			console.log('HEHE')
		});

		var $table =$("#list_table_locations")
			.tablesorter({
				theme: 'blue',
				widthFixed: true,
				sortLocaleCompare: false, 
				sortList: [  [2,1]  ],
				widgets: [ 'filter','editable' ],
				widgetOptions : {
					editable_columns : [10],
					editable_enterToAccept : false, // press enter to accept content, or click outside if false
					editable_autoAccept : true, // accepts any changes made to the table cell automatically (v2.17.6)
					editable_autoResort : false, // auto resort after the content has changed.
					editable_validate : null, // return a valid string: function(text, original, columnIndex) { return text; }
					editable_focused : function(txt, columnIndex, $element) {
						$element.addClass('focused');
					},
					editable_blur : function(txt, columnIndex, $element) {
						$element.removeClass('focused');
					},
					editable_selectAll : function(txt, columnIndex, $element) {
						return /^b/i.test(txt) && columnIndex === 0;
					},
					editable_wrapContent : '<div>', // wrap all editable cell content... makes this widget work in IE, and with autocomplete
					editable_trimContent : true, // trim content ( removes outer tabs & carriage returns )
					editable_noEdit : 'no-edit', // class name of cell that is not editable
					editable_editComplete : 'editComplete', // event fired after the table content has been edited
					filter_reset : '.fdp-btn-red',
					filter_saveFilters : false,
					filter_external : 'search'
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
					if (TS_Show_Loader==true){
						$.LoadingOverlay("show");
					}

					// Ajout du select biens par Scanu Rémy - remy@connect-io.fr
					if (data.hasOwnProperty('bienNom') && initLoading == false) {
						$('#search_locations').html("");
						
						data.bienNom.forEach(element => {

							$('#search_locations').append($('<option>', {
								value: element,
								text: element
							}));

						});

						$('#search_locations').multiSelect({
							selectableHeader: "<input type='text' class='span7' autocomplete='off' placeholder=\"Nom d'une location\">",
							selectionHeader: "<input type='text' class='span7' autocomplete='off' placeholder=\"Nom d'une location\">",
							afterInit: function(ms){
								var that = this,
									$selectableSearch = that.$selectableUl.prev(),
									$selectionSearch = that.$selectionUl.prev(),
									selectableSearchString = '#'+that.$container.attr('id')+' .ms-elem-selectable:not(.ms-selected)',
									selectionSearchString = '#'+that.$container.attr('id')+' .ms-elem-selection.ms-selected';
							
								that.qs1 = $selectableSearch.quicksearch(selectableSearchString)
								.on('keydown', function(e){

									if (e.which === 40){
										that.$selectableUl.focus();
										return false;
									}
									
								});
							
								that.qs2 = $selectionSearch.quicksearch(selectionSearchString)
								.on('keydown', function(e){

									if (e.which == 40){
										that.$selectionUl.focus();
										return false;
									}

								});
							},
							afterSelect: function(){
								this.qs1.cache();
								this.qs2.cache();
							},
							afterDeselect: function(){
								this.qs1.cache();
								this.qs2.cache();
							}
						});

						initLoading = true;
					}
						
					if (data && data.hasOwnProperty('rows')) {
						var indx, r, row, c, d = data.rows,
						
						total = data.total_rows,

						headers = data.headers,
						headerXref = headers.join(',').replace(/\s+/g,'').split(','),
						
						rows = [],	
						total_row=[],

						len = d.length;

						for ( r=0; r < len; r++ ) {
							row = []; 

							for ( c in d[r] ) {

								if (typeof(c) === "string") {
									indx = $.inArray( c, headerXref );

									var stripped = d[r][c].replace(/<\/?[^>]+(>|$)/g, "").replace(",",".");
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
									
									if (indx == 0){
										total_row[indx] = "Total";
									}
								}

							}

							rows.push(row);
						}

						var total_row_parsed = total_row.map(function(elem) {
							
							if (elem != "Total" && elem != "") {
								elem = elem.toLocaleString("fr", {maximumFractionDigits: 2} )+" €";
							}

							return elem;
						});

						rows.push(total_row_parsed);

						return [ total, rows, headers ];
					}
				},

				processAjaxOnInit: true,
				output: '{startRow} to {endRow} ({totalRows})',
				updateArrows: true,
				page: 0,
				size: 100,
				savePages: false,
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

		$table // config event variable new in v2.17.6
		.children('tbody').on('editComplete', 'td', function(event, config) {
			var $this = $(this),
			newContent = $this.text(),
			cellIndex = this.cellIndex, // there shouldn't be any colspans in the tbody
			rowIndex = $this.closest('tr').attr('id'); // data-row-index stored in row id
	
			// Do whatever you want here to indicate
			// that the content was updated
			$this.addClass( 'editable_updated' ); // green background + white text
			setTimeout(function() {
			$this.removeClass( 'editable_updated' );
			}, 500);

			$.post (url_base+'/GL?action=locations_list_ts_json', {
				"row"     : rowIndex,
				"cell"    : cellIndex,
				"content" : newContent,
				"id"      : $this.find("div").attr("id")
			});
			
		})

		$.tablesorter.filter.bindSearch( $table, $('.search') );

		// Si changement dans un des filtres, on exécute la recherche
		$('.search').change(function(){
			var currentFilters = $.tablesorter.getFilters($table);

			if ($(this).attr("name") == "search_location_statut") {
				var type = [];
	
				$("input:checkbox").each(function() {
	
					if ($(this).is(':checked') == true) {
						type.push($(this).val());
					}
	
				});
	
				currentFilters[3] = type.join('|');
			}

			if ($(this).attr("name") == "search_locations") {
				var type = [];

				$(".ms-selection ul").find(".ms-selected").each(function(){
					var $this = $(this);
					type.push($this.text());

					$('#search_locations[value="' + $this.text() + '"]').attr('selected','selected');
				});

				currentFilters[4] = type.join('|');
			}

			console.log(currentFilters);
			$.tablesorter.setFilters($table, currentFilters);

			// Modifié par Scanu Rémy le 03/09/2021, enfin trouvé le bug du tableau vide...
			//$("#list_table_locations").html('').html(var_tableliste_content);

			$('#list_table_locations').trigger('updateHeaders');
			$("#list_table_locations").trigger("update");

			// modify the search input data-column value (swap "0" or "all in this demo)
			$('.selectable').attr( 'data-column', $(this).val() );

			$('.checkbox-input').each(function(index){

				switch (index) {
					case 1:
						$(this).val("Toutes les locations");
						break;
					default:
						$(this).val("Location en cours");
						break;
				}
		
			});
		});

		// assign the sortStart event
		$("table").bind("sortStart",function() {

			if (TS_Show_Loader==true){
				$.LoadingOverlay("show");
			}

		}).bind("sortEnd",function() {
			$.LoadingOverlay("hide");
		}); 

		$("table").bind('updateComplete', function(e, table) {
			$.LoadingOverlay("hide");
		});

		//************
		var $url = $('#url');

		$('table')
		.on('changingUrl', function(e, url){
			$url.html(url);

			$.LoadingOverlaySetup({
				background      : "rgba(0, 0, 0, 0.5)",
				imageColor      : "#fff"
			});

		})

		.on('pagerInitialized', function(){
			this.config.serverSideSorting = false;
			$('#origurl').html( this.config.pager.ajaxUrl.replace(/(\{.*?\})/g, '<span class="results">$1</span>') );
		});

		$table.on('pagerComplete', function(){
			$('#list_table_locations tr:last td').css('color','white').css('background-color','#0d72b9');

			// Modifié par : Scanu Rémy <remy@connect-io.fr> - On masque l'input de saisie dans les biens sélectionnés par l'utilisateur
			$(".ms-selection").find("input").eq(0).hide();

			$.LoadingOverlay("hide");
		});
	}

	function Trigger_Search_Liste(){
		$('.checkbox-input').each(function(index){

			switch (index) {
				case 1:
					$(this).val("Toutes les locations");
					break;
				default:
					$(this).val("Location en cours");
					break;
			}
	
		});
		
		TS_Show_Loader = true;
		$("#list_table_locations").trigger("update"); 

		TS_Show_Loader = false;

		var sorting = [ [1,1] ]; 
		$("#list_table_locations").trigger("sorton",[sorting]);
	}

	Init_Autocomplete('#search_usager','#search_usager_id','GB','get_autocomplete_locataires');
	// Modifié par : Scanu Rémy - <remy@connect-io.fr> (14/02/2024)
	//Init_Autocomplete('#search_bien_location','#search_bien_id','GB','get_autocomplete_centres');

	$("#search_annee").datetimepicker( {
		format: "yyyy",
		startView: 'decade',
		minView: 'decade',
		viewSelect: 'decade',
		autoclose: true,
	});

	$('#irc_date_publication').datepicker({
		format: 'dd/mm/yyyy'
	});

	$('#recherche').removeAttr( 'style' );

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//
	if (url_action == 'locations'){
		var sbajaxurl=url_base+'/GL?action=locations_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';
		Init_DataTable_Liste();
	}

	$("#list_table_locations").click(function(ev){
		$('#id_selected').val("");

		if (ev.target.id != 0){
			$('#id_selected').val(ev.target.id);

			// Lorsque le clic est sur le checkbox, on ajoute la valeur
			if (ev.target.id.indexOf('chx') != -1){
				var positionChx = locations_ids_selected.indexOf(ev.target.value);

				if (positionChx == -1) {
					locations_ids_selected.push(ev.target.value);
				}else{
					locations_ids_selected.splice(positionChx, 1);
				}

				console.log(locations_ids_selected);
			}else if (ev.target.id.indexOf('commentaire') != -1){ // Lorsque le clic est sur la zone commentaire
				
			}else {
				managePreviousDataFilter("sauvegarder", "locations", "", '/GL?action=location&id=' + ev.target.id + '&form_back_view=' + url_action, 
				[
					"search_date",
					"search_usager",
					"search_usager_id",
					"search_location_statut",
					"search_bien_id"
				]);
			}

		}

	});

	// Un peu de mise en forme
	$("#btn_fac_export").remove();
	$(".checkbox_list-label").remove();
	$('.checkbox-input--services').css('cssText', 'margin: 0px 0px 0px 20px!important');

	$('.fdp-border').css('cssText', 'padding: 0.6rem 0.75rem 0.6rem 0.75rem!important; border-radius: 0px!important');
	$('.fdp-border > ul').css('cssText', 'margin: 0px!important');
	$('.fdp-border > ul > li').css('cssText', 'display: inline-block; line-height: 0px');
	$('.fdp-border > ul > li > label').css('cssText', 'margin: 0px!important; line-height: normal');
	$('.fdp-border > ul > li > label > input').css('cssText', 'position: initial!important; margin: 0px 0px 0px 20px!important');

	$('.checkbox-span').css('cssText', 'padding: 0px!important');

	// Mise en dur de la valeur des types car la value indiqué est toujours "Location" je ne sais pas pourquoi...
	$('.checkbox-input').each(function(index){

		switch (index) {
			case 1:
				$(this).val("Toutes les locations");
				break;
			default:
				$(this).val("Location en cours");
				break;
		}

	});

	$(".checkbox-input").on('change', function () {
		
		if ($(this).is(":checked") == true) {

			if ($(this).val() == "Location en cours") {
				$('input:checkbox[value="' + 'Toutes les locations' + '"]').attr('checked', false);
			}else{
				$('input:checkbox[value="' + 'Location en cours' + '"]').attr('checked', false);
			}
			
		}

	});
//=======================================================================================================================//
});