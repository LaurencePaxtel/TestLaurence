$(document).ready(function(){  
	var var_tableliste_content = $('#list_table_documents').html();
	var url_base= window.location.origin;

	var required_fields = '';
	var selected_month='';

	//=================================================================//
	// Default dates
	//=================================================================// 

	var first_load = sessionStorage.getItem('first_load');
	var date_du_current ='';
	var date_au_current ='';

	if (first_load=='true'){ 
		var date_current_object = new Date();

		date_du_current=date_current_object.format("dd/mm/yyyy");
		date_au_current=date_current_object.format("dd/mm/yyyy");
	}else{
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

	$("#btn_left").click(function(ev){ 
		if ($('#search_date_du').val()==''){
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

	$("#btn_next").click(function(ev){ 

		if ($('#search_date_au').val()==''){

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

	function Table_Liste_Refresh(){
		$.LoadingOverlay("show");

		//$("#list_table_documents").html('').html(var_tableliste_content);

		$('#list_table_documents').trigger('updateHeaders');
		$("#list_table_documents").trigger("update"); 
	}

	$("#btn_new").click(function(ev){ 
		Nouvelle_Fiche(ev);
		
		return false;
	});  

	$("#list_table div").click(function(ev){ 
		var data_search = {
			"id": ev.target.id
		};

		$('#id_selected').val(ev.target.id);

		if (ev.target.id.indexOf('chx') != -1){
		}else{

			if(ev.target.id!=0){
				$(location).attr('href', '/GL?action=facture&id='+ev.target.id);   
			}

		}
	});  

	$('body').on('click','#list_table_documents div', function(ev) {
		var data_search = {
			"id": ev.target.id
		};

		$('#id_selected').val(ev.target.id);

		if (ev.target.id.indexOf('chx') != -1){
		}else{

			if(ev.target.id!=0){
				$(location).attr('href', '/GL?action=facture&id='+ev.target.id);   
			}

		}
			
	});

	$("#btn_reset").click(function(ev){ 
		$('#list_table_documents').trigger('filterResetSaved');

		$("#search_destinataire_id").val('')
		$("#search_date_du").val('')
		$("#search_date_au").val('')

		$('#list_table_documents').trigger('updateHeaders');
		$("#list_table_documents").trigger("update"); 

		sessionStorage.setItem('first_load', 'true');

		return false;
	});  

	function Get_Record_Data($id){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$('#titre_popup').html('Modification');

		var data_module = { 
			"id": $id
		};

		var data = { 
			"zone":"gl", 
			"action":"get_facture",
			"data": {
				"location": data_module
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=get_facture",data_json, function(data){  

			$.each(data, function(key, value){ 

				$("#bien_en_location").attr('value', value.loc_bien_name);
				$("#loc_bien_id").attr('value', value.loc_bien_id);
				$("#usager").attr('value', value.loc_usager_name);
				$("#loc_hb_id").attr('value', value.loc_hb_id);
				$("#loc_montant_initial").attr('value', iw_round(value.loc_montant_initial));
				$("#loc_montant_revise").attr('value', iw_round(value.loc_montant_revise));
				$("#loc_garantie_montant").attr('value', iw_round(value.loc_garantie_montant));

				UTL_Date_Picker_Formatted(value.loc_date,'#loc_date');	
				UTL_Date_Picker_Formatted(value.loc_date_entree,'#loc_date_entree');	
				UTL_Date_Picker_Formatted(value.loc_date_sortie,'#loc_date_sortie');	

				Init_Autocomplete('#usager','#loc_hb_id','GB','get_autocomplete_usagers');
				Init_Autocomplete('#bien_en_location','#loc_bien_id','GB','get_autocomplete_centres');

				if(value.loc_garantie_encaisse=='True'){
					$( "#loc_garantie_encaisse" ).prop( "checked", true );
				}


				$("input[type='checkbox']").on('change', function(){
					$(this).val(this.checked ? "true" : "false");
				})

			});  
			
		}).done(function() {//success

		})
		.fail(function() { //error

		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});  

	}

	function Save_Record(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
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
			"zone":"gl", 
			"action":"set_location",
			"data": {
				"location": data_location
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		var save_status='';

		$.getJSON("/GL?action=location_fiche_valider",data_json, function(data){  
			

			$.each(data, function(key, value){  
			
				save_status = value;
			
			});

		}).done(function() {//success

		})
		.fail(function() { //error

		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (save_status!='Failed'){
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

			}else{

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

	function Nouvelle_Fiche(){
		$(location).attr('href', '/GL?action=document');
	}

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//
	var sbajaxurl=url_base+'/GL?action=documents_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste(){
		
		var $table =$("#list_table_documents")
		.tablesorter({
		theme: 'blue',
			widthFixed: true,
			sortLocaleCompare: true, 
			sortList: [ [1,1] ],
			widgets: [ 'filter'],
			widgetOptions : {
			filter_reset : '.fdp-btn-red',
			filter_saveFilters : true,
			filter_external : 'search'

			},
					headers: { 
				0: { 
					sorter: false,filter: false 
					},
				1: { 
					sorter: true,filter: false 
					},
				2: { 
					sorter: true,filter: false 
					},
				3: { 
					sorter:true,filter: false 
					},
				4:{
					sorter: true,filter: false 
					},
				5:{
					sorter: true,filter: false 
					},
				6:{
						sorter:true,filter: false 
					},
				7:{
						sorter:true,filter: false 
					},
				8:{
						sorter:true,filter: false 
					},
				9:{
						sorter:true,filter: false 
					},
				10:{
						sorter:false,filter: false 
					}
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
			savePages: true,
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
			sessionStorage.setItem('session_date_du', $('#search_date_du').val());
			sessionStorage.setItem('session_date_au', $('#search_date_au').val());

			//$("#list_table_documents").html('').html(var_tableliste_content);
			$('#list_table_documents').trigger('updateHeaders');
			$("#list_table_documents").trigger("update"); 

			// modify the search input data-column value (swap "0" or "all in this demo)
			$('.selectable').attr( 'data-column', $(this).val() );

			// update external search inputs
			$.tablesorter.filter.bindSearch( $table, $('.search'), false );
		});
		
		//assign the sortStart event
		$("table").bind("sortStart",function() {
			$.LoadingOverlay("show");
		}).bind("sortEnd",function() {
			$.LoadingOverlay("hide");
		}); 

		$('table').bind('filterStart', function(event, filters) {
			
		});

		$("table").bind('updateComplete', function(e, table) {
			$.LoadingOverlay("hide");
		});

		//************
		var $url = $('#url');

		$('table')
		// show current URL for the DEMO ONLY
		.on('changingUrl', function(e, url){
			$url.html(url);

			$.LoadingOverlaySetup({
				background      : "rgba(0, 0, 0, 0.5)",
				imageColor      : "#fff"
			});
		})

		.on('pagerInitialized', function(){
			// allow THIS demo to sort the content; this variable is automatically set to true when ajax
			// is used as there isn't any way to sort the server side data from the client side.
			this.config.serverSideSorting = false;

			// show original highlighted URL
			$('#origurl').html( this.config.pager.ajaxUrl.replace(/(\{.*?\})/g, '<span class="results">$1</span>') );

			var first_load = sessionStorage.getItem('first_load');

			if (first_load=='true'){ 
				Trigger_Search_Liste();
			}

			sessionStorage.setItem('first_load', 'false');
		});

		$table.on('pagerComplete', function(){
			$.LoadingOverlay("hide");
		});

		$table.on('filterInit', function(){
			
		});
	}

	Init_DataTable_Liste();

	function Trigger_Search_Liste(){
		sessionStorage.setItem('session_date_du', $('#search_date_du').val());
		sessionStorage.setItem('session_date_au', $('#search_date_au').val());

		date_du_current = sessionStorage.getItem('session_date_du');
		date_au_current = sessionStorage.getItem('session_date_au');

		console.log(date_du_current+' : '+date_au_current);

		//$("#list_table_documents").html('').html(var_tableliste_content);
		$('#list_table_documents').trigger('updateHeaders');
		$("#list_table_documents").trigger("update"); 

		var columns = [];
		columns[1] = date_du_current; 
		columns[2] = date_au_current;

		$('#list_table_documents').trigger('search', [ columns ]);   
	}
});