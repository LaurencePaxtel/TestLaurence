$(document).ready(function(){
	var url_base= window.location.origin;
	var var_tableliste_content = $('#list_table_situation_usagers').html();

	$("#btn_search").click(function(){  
		Trigger_Search_Liste();
		
		return false;
	});  

	$("#btn_reset").click(function(){  
		document.getElementById('situation_financiere_usagers').reset();

		Trigger_Search_Liste();
		
		return false;
	});

   	/************ sidebar action ***********/

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//
	var sbajaxurl=url_base+'/INT?action=get_json_situation_usagers_list&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste(){
		var $table = $("#list_table_situation_usagers").tablesorter({
			theme: 'blue',
			widthFixed: true,
			sortLocaleCompare: false, 
			sortList: [  [0,0]  ],
			widgets: [ 'filter' ],
			widgetOptions : {
				filter_reset : '.fdp-btn-red',
				filter_saveFilters : false,
				filter_external : 'search'
			}
		})

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

						if (elem != "Total" && elem != ""){
							elem = elem.toLocaleString("fr",{maximumFractionDigits: 2})+" €";
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

		// Si changement dans un des filtres, on exécute la recherche
		$('.search').change(function(){
			if ($(this).attr("name") == "search_location_participation_hebergement") {
				var type = [];
	
				currentFilters = $.tablesorter.getFilters($table);
	
				$("input:checkbox").each(function() {
	
					if ($(this).is(':checked') == true) {
						type.push($(this).val());
					}
	
				});
	
				currentFilters[3] = type.join('|');

				console.log(currentFilters);
	
				$.tablesorter.setFilters($table, currentFilters);
			}

			// Modifié par Scanu Rémy le 03/09/2021, enfin trouvé le bug du tableau vide...
			//$("#list_table_situation_usagers").html('').html(var_tableliste_content);

			$('#list_table_situation_usagers').trigger('updateHeaders');
			$("#list_table_situation_usagers").trigger("update");

			// modify the search input data-column value (swap "0" or "all in this demo)
			$('.selectable').attr( 'data-column', $(this).val() );

			$('.checkbox-input').each(function(index){

				switch (index) {
					case 1:
						$(this).val("Hébergement");
		
						break;
					case 2:
						$(this).val("Participation");
		
						break;
					default:
						$(this).val("Location");
		
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

		// show current URL for the DEMO ONLY
		$('table').on('changingUrl', function(e, url){
			$('#url').html(url);

			$.LoadingOverlaySetup({
				background      : "rgba(0, 0, 0, 0.5)",
				imageColor      : "#fff"
			});
		});

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

	function Trigger_Search_Liste(){
		TS_Show_Loader = true;
		$("#list_table_situation_usagers").trigger("update"); 
		
		TS_Show_Loader = false;

		var sorting = [ [0,0] ];
		$("#list_table_situation_usagers").trigger("sorton",[sorting]);
	}

	Init_DataTable_Liste();

	$('body').on('click','#list_table_situation_usagers div', function(ev) {
		$('#id_selected').val('');
	});

	// Un peu de mise en forme
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
				$(this).val("Hébergement");

				break;
			case 2:
				$(this).val("Participation");

				break;
			default:
				$(this).val("Location");

				break;
		}

	});
	//=======================================================================================================================//
});  