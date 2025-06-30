$(document).ready(function(){  
	var url_base= window.location.origin;
	var var_tableliste_content = $('#list_table_proprietaires').html();

	var required_fields = $("#mandatory").val().split(';');
	var sbaction = getUrlParameter('sbaction');
	

	$("#btn_new").click(function(ev){ 
		Nouvelle_Fiche();
		
		return false;
	});  

	$("#btn_search").click(function(){  
		Trigger_Search_Liste();
		
		return false;
	});  


	$("#btn_reset").click(function(){  
		document.getElementById('proprietaires').reset();

		Trigger_Search_Liste();
		
		return false;
	});  

    function Get_Proprietaire_Data($id){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        $('#titre_popup').html('Modification');

		var data_proprietaire = { 
			"id": $id
		};

		var data = { 
			"zone":"gl", 
			"action":"get_proprietaire",
			"data": {
				"proprietaire": data_proprietaire
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=get_proprietaire",data_json, function(data){  

			$.each(data, function(key, value){ 

				$("#pro_nom").attr('value', value.pro_nom);
				$("#pro_prenom").attr('value', value.pro_prenom);
				$("#pro_telephone").attr('value', value.pro_telephone);
				$("#pro_email").attr('value', value.pro_email);

			});  
			

		}).done(function() {//success

		})
		.fail(function() { //error

		})
		.always(function() { //complete
			
			$.LoadingOverlay("hide");


		});  

    }

    function Get_Address($id){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

		var data_address = { 
			"id": $id
		};

		var data = { 
			"zone":"gl", 
			"action":"get_address",
			"data": {
				"address": data_address
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=get_address",data_json, function(data){  

			$.each(data, function(key, value){ 

				$("#ad_adresse1").attr('value', value.ad_adresse1);
				$("#ad_adresse2").attr('value', value.ad_adresse2);
				$("#ad_adresse3").attr('value', value.ad_adresse3);
				$("#ad_code_postal").attr('value', value.ad_code_postal);
				$("#ad_ville").attr('value', value.ad_ville);

			});  
			

		}).done(function() {//success

		})
		.fail(function() { //error
		
		})
		.always(function() { //complete
			
			$.LoadingOverlay("hide");

		});  

    }

   	function Get_Bank_Data($id){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

		var data_address = { 
			"id": $id
		};

		var data = { 
			"zone":"gl", 
			"action":"get_bank",
			"data": {
				"coordonnees_bancaires": data_address
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		$.getJSON("/GL?action=pro_get_info_bancaires",data_json, function(data){  

			$.each(data, function(key, value){ 
				$("#bqe_domiciliation").attr('value', value.bqe_domiciliation);
				$("#bqe_nom_bancaire").attr('value', value.bqe_nom_bancaire);
				$("#bqe_iban").attr('value', value.bqe_iban);
				$("#bqe_bic").attr('value', value.bqe_bic);
				$("#bqe_adresse_1").attr('value', value.bqe_adresse_1);
				$("#bqe_adresse_2").attr('value', value.bqe_adresse_2);
				$("#bqe_adresse_3").attr('value', value.bqe_adresse_3);
				$("#bqe_code_postal").attr('value', value.bqe_code_postal);
				$("#bqe_ville").attr('value', value.bqe_ville);
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

		var data_bank = {
			"bqe_domiciliation": $("#bqe_domiciliation").val(),
			"bqe_nom_bancaire": $("#bqe_nom_bancaire").val(),
			"bqe_iban": $("#bqe_iban").val(),
			"bqe_bic": $("#bqe_bic").val(),
			"bqe_adresse_1": $("#bqe_adresse_1").val(),
			"bqe_adresse_2": $("#bqe_adresse_2").val(),
			"bqe_adresse_3": $("#bqe_adresse_3").val(),
			"bqe_code_postal": $("#bqe_code_postal").val(),
			"bqe_ville": $("#bqe_ville").val() 	
		}

		var data_address = {
			"ad_adresse1": $("#ad_adresse1").val(),
			"ad_adresse2": $("#ad_adresse2").val(),
			"ad_adresse3": $("#ad_adresse3").val(),
			"ad_code_postal": $("#ad_code_postal").val(),
			"ad_ville": $("#ad_ville").val() 	
		}

		var data_proprietaire = { 
			"id": $("#id_selected").val(),  
			"pro_nom": $("#pro_nom").val(), 
			"pro_prenom": $("#pro_prenom").val(), 
			"pro_telephone": $("#pro_telephone").val(),
			"pro_email": $("#pro_email").val(),
			"adresse": {
				"data": data_address
			},
			"coordonnees_bancaires": {
				"data": data_bank
			}
		};

		var data = { 
			"zone":"gl", 
			"action":"set_proprietaire",
			"data": {
				"proprietaire": data_proprietaire
			}
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=pro_fiche_valider",data_json, function(data){  

			$.each(data, function(key, value){  
				save_status = value; 
			});

		}).done(function() {//success

		})
		.fail(function() { //error

		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			Trigger_Search_Liste();
			
			if(save_status!='Failed'){

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
					content: 'Enregistrement échoué',
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
		$('#titre_popup').html('Nouvelle fiche');

		var var_popup = $('#iw_form_popup').html();

		$('#iw_form_popup').html('');
	
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

						Save_Record();

						$('#iw_form_popup').html(var_popup);

						return true;
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
				// bind to events
				var jc = this;
				this.$content.find('form').on('submit', function (e) {
					// if the user submits the form by pressing enter in the field.
					e.preventDefault();
					jc.$$formSubmit.trigger('click'); // reference the button and click it
				});
			}
		});
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
			"search_nom": $("#search_nom").val(),
			"search_prenom": $("#search_prenom").val(),
			"search_telephone": $("#search_telephone").val(),
			"search_email": $("#search_email").val()
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_proprietaires",
			"data": data_specific
		};
		
		var data_json = '&json='+JSON.stringify(data_search);
		
		$.getJSON("/GL?action=proprietaires_list_json",data_json, function(data){  
			$('#list_table .table').empty();

			var resp_table_data='';

			resp_table_data +='<div class="row header">';
			resp_table_data +='<div class="cell fdp-min-width-210px">';
			resp_table_data +='ID';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 100px;">';
			resp_table_data +='Nom';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Prénom';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Téléphone';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 120px;">';
			resp_table_data +='Email';
			resp_table_data +='</div>';
			resp_table_data +='</div>'; 
			
			if(data.length>0) {
				var css_class_row='';
				var counter = 0;

				$.each(data, function(key, value){  
					css_class_row='';

					if(counter % 2 != 0){
						css_class_row+=' iw-alternate';
					}

					resp_table_data +='<div class="row body '+css_class_row+'">';
					resp_table_data +='<div class="cell" id="'+value.id+'">';
					resp_table_data +=value.id;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell iw_uppercase" id="'+value.id+'">';
					resp_table_data +=value.pro_nom;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell iw_uppercase" id="'+value.id+'">';
					resp_table_data +=value.pro_prenom;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" id="'+value.id+'">';
					resp_table_data +=value.pro_telephone;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" id="'+value.id+'">';
					resp_table_data +=value.pro_email;
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

	/*onglet biens*/
	function Display_Table_List_Biens($id){

		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

		$('#list_table_biens .table').empty();

		var data_specific = {
			"search_nom": '',
			"search_proprietaire": $id
		};

		var data_search = { 
			"zone":"gl", 
			"action":"get_biens",
			"data": data_specific
		};
		
		var data_json = '&json='+JSON.stringify(data_search);
		

		$.getJSON("/GL?action=biens_list_json",data_json, function(data){  
			$('#list_table_biens .table').empty();

			var resp_table_data='';

			resp_table_data +='<div class="row header">';
			resp_table_data +='<div class="cell" style="min-width: 100px;">';
			resp_table_data +='Nom du bien';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 100px;">';
			resp_table_data +='Type de gestion';
			resp_table_data +='</div>';
			resp_table_data +='<div class="cell" style="min-width: 100px;">';
			resp_table_data +='Nombre de places';
			resp_table_data +='</div>';
			resp_table_data +='</div>';
			
			if(data.length>0){
				var css_class_row='';
				var counter = 0;
		
				$.each(data, function(key, value){  


					css_class_row='';

					if(counter % 2 != 0){
						css_class_row+=' iw-alternate';
					}


					resp_table_data +='<div class="row body '+css_class_row+'">';
					resp_table_data +='<div class="cell" id="'+value.id+'">';
					resp_table_data +=value.lc_gl_nom_suite;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" id="'+value.id+'">';
					resp_table_data +=value.lc_gl_type_gestion;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell" id="'+value.id+'">';
					resp_table_data +=value.lc_gl_nombre_places;
					resp_table_data +='</div>';
					resp_table_data +='</div>';

					$('<input>', {
						type: 'hidden',
						id: 'id'+value.id,
						name: 'id'+value.id,
						value: value.id
					}).appendTo('#list_table_biens');


					counter = counter + 1;
				});
			}

			$("#list_table_biens .table").append(resp_table_data); 
		}).done(function() {//success

		})
		.fail(function() { //error

		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
	}

   /************ sidebar action ***********/
   	if(sbaction=='new'){
		Nouvelle_Fiche(); 
 	}

	//==========================================================================================================//
	// Liste
	//==========================================================================================================//

	var sbajaxurl=url_base+'/GL?action=proprietaires_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

	function Init_DataTable_Liste(){
		var $table =$("#list_table_proprietaires")
		.tablesorter({
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
					sorter: true,filter: false 
					},
				1: { 
					sorter: true,filter: false 
					},
				2: { 
					sorter: true,filter: false 
					},
				3: { 
					sorter:true,filter: false 
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
			//$("#list_table_proprietaires").html('').html(var_tableliste_content);
			
			$('#list_table_proprietaires').trigger('updateHeaders');
			$("#list_table_proprietaires").trigger("update"); 

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

		});


		$table.on('pagerComplete', function(){
			$.LoadingOverlay("hide");
		});

		$table.on('filterInit', function(){
			
		});
	}

	Init_DataTable_Liste();

	function Trigger_Search_Liste(){
		TS_Show_Loader = true;
		$("#list_table_proprietaires").trigger("update"); 

		var sorting = [[1,0]]; 
		TS_Show_Loader = false;
		$("#list_table_proprietaires").trigger("sorton",[sorting]);

		var sorting = [ [1,1] ]; 
		$("#list_table_proprietaires").trigger("sorton",[sorting]); 
	}

	$('body').on('click','#list_table_proprietaires div', function(ev) {
		$('#id_selected').val('');

		if(ev.target.id!=''){

			$('#id_selected').val(ev.target.id);

			Get_Proprietaire_Data(ev.target.id);
			Get_Address(ev.target.id);
			Get_Bank_Data(ev.target.id);
			Display_Table_List_Biens(ev.target.id);

			var var_popup = $('#iw_form_popup').html();
			$('#iw_form_popup').html('');


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

							Save_Record();

							$('#iw_form_popup').html(var_popup);
							$('#id_selected').val('');

							return true;
						}
					},
					cancel: {
						text: 'Fermer',
						action: function () {

							$('#iw_form_popup').html(var_popup);
							$('#id_selected').val('');
			
						
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

							$("#list_table_proprietaires div").click(function(ev){
	
								var $id_bien = ev.target.id;

								if($id_bien!=''){ 

								$(location).attr('href', '/GL?action=bien&id='+$id_bien+'&retour=proprietaires');
								}

							});  
					
						//Get_Heberge_Data($('#hb_referenceid').val());


				}
			});



		}
		

	});

	//=======================================================================================================================//
});  