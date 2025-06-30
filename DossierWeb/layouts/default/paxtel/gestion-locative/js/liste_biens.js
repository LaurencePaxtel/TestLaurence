$(document).ready(function(){   
	var url_base= window.location.origin;

    Init_Autocomplete('#search_proprietaire','#search_proprietaire_id','GB','get_autocomplete_proprietaires');

	$("#list_table div").click(function(ev){
		var data_search = {
			"id": ev.target.id
		};

		$('#id_selected').val(ev.target.id);

		$(location).attr('href', '/GL?action=bien&id='+ev.target.id);  
	});  

	$("#btn_search").click(function(){
		Trigger_Search_Liste();
		return false;
	});  

	$("#btn_reset").click(function(){  
		document.getElementById('biens').reset();

		$('#search_bien_id').val('');
		$('#search_proprietaire_id').val('');

		$('.checkbox-input').each(function(index){

			switch (index) {
				case 1:
					$(this).val("Inactif");
	
					break;
				case 2:
					$(this).val("Tous");
	
					break;
				default:
					$(this).val("Actif");
	
					break;
			}

		});

		$('input:checkbox[value="' + 'Tous' + '"]').attr('checked', false);
		$('input:checkbox[value="' + 'Actif' + '"]').attr('checked', true);
		$('input:checkbox[value="' + 'Inactif' + '"]').attr('checked', false);

		currentFilters = $.tablesorter.getFilters($("#list_table_biens"));
		console.log(currentFilters);

		currentFilters[2] = ["Actif"].join('|');
		console.log(currentFilters);

		$.tablesorter.setFilters($("#list_table_biens"), currentFilters);
		
		Trigger_Search_Liste();
		return false;
	});
 
	//==========================================================================================================//
	// Liste
	//==========================================================================================================//
	var sbajaxurl=url_base+'/GL?action=biens_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste(){
		var $table = $("#list_table_biens");

		$table.tablesorter({
		theme: 'blue',
			widthFixed: true,
			sortLocaleCompare: false, 
			sortList: [  [0,0]  ],
			widgets: [ 'filter'],
			widgetOptions : {
			filter_reset : '.fdp-btn-red',
			filter_saveFilters : true,
			filter_external : 'search'
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
					sorter:true,
					filter: false 
				},
				4:{
					sorter: false,
					filter: false 
				},
				5:{
					sorter: false,
					filter: false 
				},
				6:{
					sorter: false,
					filter: false 
				}
			} 
		});

		// Modifié par Scanu Rémy le 31/03/2022, on applique par défaut un filtre de bien actif
		$.tablesorter.setFilters( $table, [ '', '', 'Actif|Vrai', '', '', '', '' ], true );

		$table.tablesorterPager({
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
				$.LoadingOverlay("show");
					
				if (data && data.hasOwnProperty('rows')) {
					var indx, r, row, c, d = data.rows,
					
					total = data.total_rows,

					headers = data.headers,
					headerXref = headers.join(',').replace(/\s+/g,'').split(','),
					
					rows = [],	
					len = d.length;

					for ( r=0; r < len; r++ ) {
						row = []; 

						for ( c in d[r] ) {

							if (typeof(c) === "string") {
								indx = $.inArray( c, headerXref );
					
								if (indx >= 0) {
									row[indx] = d[r][c];
								}
							}

						}

						rows.push(row);
					}

					return [ total, rows, headers ];
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

		$.tablesorter.filter.bindSearch( $table, $('.search') );

		// Allow changing an input from one column (any column) to another
		$('.search').change(function(){

			if ($(this).attr("name") == "search_bien_statut") {
				var type = [];
	
				currentFilters = $.tablesorter.getFilters($table);
	
				$("input:checkbox").each(function() {
	
					if ($(this).is(':checked') == true) {
						type.push($(this).val());
					}
	
				});

				console.log(currentFilters);
				console.log(type);
	
				currentFilters[2] = type.join('|');
				console.log(currentFilters);
	
				$.tablesorter.setFilters($table, currentFilters);
			}

			// Modifié par Scanu Rémy le 03/09/2021, enfin trouvé le bug du tableau vide...
			//$("#list_table_biens").html('').html(var_tableliste_content);

			$('#list_table_biens').trigger('updateHeaders');
			$("#list_table_biens").trigger("update"); 

			// modify the search input data-column value (swap "0" or "all in this demo)
			$('.selectable').attr( 'data-column', $(this).val() );

			$('.checkbox-input').each(function(index){

				switch (index) {
					case 1:
						$(this).val("Inactif");
		
						break;
					case 2:
						$(this).val("Tous");
		
						break;
					default:
						$(this).val("Actif");
		
						break;
				}

			});
		});
		
		//assign the sortStart event
		$("table").bind("sortStart",function() {
			$.LoadingOverlay("show");
		}).bind("sortEnd",function() {
			$.LoadingOverlay("hide");
		});

		$("table").bind('updateComplete', function(e, table) {
			$.LoadingOverlay("hide");
		});

		//************
		var $url = $('#url');

		// show current URL for the DEMO ONLY
		$('table').on('changingUrl', function(e, url){
			$url.html(url);

			$.LoadingOverlaySetup({
				background      : "rgba(0, 0, 0, 0.5)",
				imageColor      : "#fff"
			});
		})

		$('table').on('pagerInitialized', function(){
			// allow THIS demo to sort the content; this variable is automatically set to true when ajax
			// is used as there isn't any way to sort the server side data from the client side.
			this.config.serverSideSorting = false;

			// show original highlighted URL
			$('#origurl').html( this.config.pager.ajaxUrl.replace(/(\{.*?\})/g, '<span class="results">$1</span>') );
		});

		$table.on('pagerComplete', function(){
			$.LoadingOverlay("hide");
		});
	}

	Init_DataTable_Liste();

	function Trigger_Search_Liste(){
		TS_Show_Loader = true;
		$("#list_table_biens").trigger("update");

		TS_Show_Loader = false;

		var sorting = [ [1,1] ]; 
		$("#list_table_biens").trigger("sorton",[sorting]); 
	}
		
	$('body').on('click','#list_table_biens div', function(ev) {
		$('#id_selected').val("");

		if (ev.target.id.indexOf('chx') == -1 && ev.target.id != 0){
			$('#id_selected').val(ev.target.id);
			$(location).attr('href', '/GL?action=bien&id='+ev.target.id);  	  				
		}

	});

	//Un peu de mise en forme
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
				$(this).val("Inactif");

				break;
			case 2:
				$(this).val("Tous");

				break;
			default:
				$(this).val("Actif");

				break;
		}

	});

	$(".checkbox-input").on('change', function () {

		if ($(this).is(":checked") == true) {
			
			switch ($(this).val()) {
				case "Tous":
					$('input:checkbox[value="' + 'Actif' + '"]').attr('checked', false);
					$('input:checkbox[value="' + 'Inactif' + '"]').attr('checked', false);

					break;
				case "Actif":
					$('input:checkbox[value="' + 'Tous' + '"]').attr('checked', false);
					$('input:checkbox[value="' + 'Inactif' + '"]').attr('checked', false);

					break;
				default:
					$('input:checkbox[value="' + 'Tous' + '"]').attr('checked', false);
					$('input:checkbox[value="' + 'Actif' + '"]').attr('checked', false);

					break;
			}
			
		}

	});

	setTimeout(() => {
		Trigger_Search_Liste();
	}, 500);
});