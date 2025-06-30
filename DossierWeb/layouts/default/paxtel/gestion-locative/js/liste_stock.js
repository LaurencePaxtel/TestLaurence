		 
 $(document).ready(function(){  
 
    var url_base= window.location.origin;

    var var_tableliste_content = $('#list_table').html();

	var sbaction = getUrlParameter('sbaction');

	var TS_Show_Loader = true;

	var var_equ_type ="";
	var var_equ_nom ="";
	var var_equ_reference_fabricant ="";
	var var_equ_reference_structure ="";
	var var_equ_garantie ="";
	var var_equ_date_achat ="";
	var var_equ_prix_achat_ht ="";
	var var_equ_tva ="";
	var var_equ_prix_achat_ttc ="";
	var var_equ_stock_min ="";

    $("#btn_search").click(function(){  	   	
            return false;
    });  

    $("#btn_new").click(function(){ 
        $(location).attr('href', '/GL?action=stock'); 	
        return false;
    }); 
    
    $("#btn_reset").click(function(){  

            document.getElementById('equipements').reset();

            Trigger_Search_Liste();
            
            return false;

    });  


    function Get_Equipement_Data($id){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        $('#titre_popup_equipement').html('Modification');

        var data_custom = { 
            "id": $id
        };

        var data = { 
            "zone":"gl", 
            "action":"get_equipement",
            "data": {
                "data": data_custom
            }
        };

        var data_json = '&json='+JSON.stringify(data);

        $.getJSON("/GL?action=get_equipement",data_json, function(data){  

            $.each(data, function(key, value){ 

                $("#equ_nom").attr('value', value.equ_nom);

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
			    "zone":"gl", 
			    "action":"set_equipement",
			    "data": {
			      "data": data_custom
			    }
			};

			var data_json = '&json='+JSON.stringify(data);

			$.getJSON("/GL?action=set_equipement",data_json, function(data){  
			 

			}).done(function() {//success

			})
			.fail(function() { //error

			})
            .always(function() { //complete
                
               $.LoadingOverlay("hide");

			   Trigger_Search_Liste();


               /* $.alert({
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
                });*/

			});  

    }


function FORM_POPUP($is_new_record){

	       if($is_new_record==true){
			$('#titre_popup_equipement').html('Nouveau équipement');
		   }else{
			$('#titre_popup_equipement').html('Modification de l\'équipement');
		   }

	        var var_popup = $('#iw_form_popup_equipement').html();
	        $('#iw_form_popup_equipement').html('');
	       
	        $.confirm({
				title: '',
				columnClass: 'iw_popup_form',
	            content: '' +
	            '<div>' +var_popup+     
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


							if(Check_Required_Fields(required_fields)){

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
				
				
							}else{
				
								Save_Record();

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
					   action: function(heyThereButton){
	
	
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

					$('#equ_date_achat').datepicker({
						format: 'dd/mm/yyyy'
					 });

                    if($is_new_record==true){
						var_equ_type ="";
						var_equ_nom ="";
						var_equ_reference_fabricant ="";
						var_equ_reference_structure ="";
						var_equ_garantie ="";
						var_equ_date_achat ="";
						var_equ_prix_achat_ht ="";
						var_equ_tva ="";
						var_equ_prix_achat_ttc ="";
						var_equ_stock_min ="";	
						$('#id_selected').val("");					
					}
	
					$("#equ_type > [value='" + var_equ_type + "']").attr("selected", "true");					
					$("#equ_nom").attr('value', var_equ_nom);
					$("#equ_reference_fabricant").attr('value', var_equ_reference_fabricant);
					$("#equ_reference_structure").attr('value', var_equ_reference_structure);
					$("#equ_garantie > [value='" + var_equ_garantie + "']").attr("selected", "true");	

					if(var_equ_date_achat==""){
						$("#equ_date_achat").datepicker().datepicker("setDate", new Date());
					}else{
                        UTL_Date_Picker_Formatted(var_equ_date_achat,'#equ_date_achat');
					}

					$("#equ_prix_achat_ht").attr('value', var_equ_prix_achat_ht);
					$("#equ_tva").attr('value', var_equ_tva);
					$("#equ_prix_achat_ttc").attr('value', var_equ_prix_achat_ttc);
					$("#equ_stock_min").attr('value', var_equ_stock_min);

					$("#equ_prix_achat_ttc").change( function() {
						GES_Calcul(1);
					});

					$("#equ_tva").change( function() {
						GES_Calcul(2);
					});

					$("#equ_prix_achat_ht").change( function() {
						GES_Calcul(2);
					});

	            }
	        });


}

function Remove_Record(){

		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});
	
		$.LoadingOverlay("show");
	
		  var data_ligne = { 
				"id": $('#id_selected').val()
		 };
	
			var data = { 
				"zone":"gl", 
				"action":"gl_remove_equipement",
				"data": {
				  "data": data_ligne
				}
			 };
	
	  var data_json = 'json='+JSON.stringify(data);
	
	  var operation_status='';
	
	  $.getJSON("/GL?action=gl_remove_equipement",data_json, function(data){  
	   
	
	   $.each(data, function(key, value){  
			  
				 operation_status = value;
			   
	   });
	
	  }).done(function() {//success
	
	  })
	  .fail(function() { //error
	
	  })
	  .always(function() { //complete
			   $.LoadingOverlay("hide");
	
			   if(operation_status=='Failed'){
	
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
	
	
			   }else{
				Trigger_Search_Liste();
			   }
	
	
	  });  
	
	
}

function Get_Record_Data($id){
  
	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	$('#titre_popup_equipement').html('Modification');

		var data_module = { 
		  "id": $id
		};

		var data = { 
			"zone":"gl", 
			"action":"get_equipement",
			"data": {
			  "data": data_module
			}
		};

		var data_json = '&json='+JSON.stringify(data);

		var_equ_type ="";
		var_equ_nom ="";
		var_equ_reference_fabricant ="";
		var_equ_reference_structure ="";
		var_equ_garantie ="";
		var_equ_date_achat ="";
		var_equ_prix_achat_ht ="";
		var_equ_tva ="";
		var_equ_prix_achat_ttc ="";
		var_equ_stock_min ="";


		$.getJSON("/GL?action=get_equipement",data_json, function(data){  

			$.each(data, function(key, value){ 

				var_equ_nom = value.equ_nom;
				var_equ_type = value.equ_type;
				var_equ_reference_fabricant = value.equ_reference_fabricant;
				var_equ_reference_structure = value.equ_reference_structure;
				var_equ_garantie = value.equ_garantie;
				var_equ_date_achat = UTL_Date_Format(value.equ_date_achat,2);
				var_equ_prix_achat_ht = value.equ_prix_achat_ht;
				var_equ_tva = value.equ_tva;
				var_equ_prix_achat_ttc = value.equ_prix_achat_ttc;
				var_equ_stock_min = value.equ_stock_min;

			});  
		 

		}).done(function() {//success

		})
		.fail(function() { //error
		})
		.always(function() { //complete
		   
		   $.LoadingOverlay("hide");

		   FORM_POPUP(false);


		});  

}
//==========================================================================================================//
// Liste
//==========================================================================================================//

var sbajaxurl=url_base+'/GL?action=stock_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';

function Init_DataTable_Liste(){

	var $table =$("#list_table")
	  .tablesorter({
	  theme: 'blue',
		widthFixed: true,
		sortLocaleCompare: false, 
		sortList: [  [0,1]  ],
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
                },
            4:{
                sorter: true,filter: false 
                },
            5:{
            sorter: true,filter: false 
                },
            6:{
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
			
			if(TS_Show_Loader==true){
                $.LoadingOverlay("show");
			}		
			 
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
		//$("#list_table").html('').html(var_tableliste_content);
		
		$('#list_table').trigger('updateHeaders');
		$("#list_table").trigger("update"); 

		// modify the search input data-column value (swap "0" or "all in this demo)
		$('.selectable').attr( 'data-column', $(this).val() );
		
		// update external search inputs
		$.tablesorter.filter.bindSearch( $table, $('.search'), false );
	});
	
	 //assign the sortStart event
	$("table").bind("sortStart",function() {
		
		if(TS_Show_Loader==true){
			$.LoadingOverlay("show");
		}	

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
	$("#list_table").trigger("update"); 
	var sorting = [[0,0]]; 
	TS_Show_Loader = false;
	$("#list_table").trigger("sorton",[sorting]); 
	var sorting = [ [0,1]]; 
	$("#list_table").trigger("sorton",[sorting]); 

}

$('body').on('click','#list_table div', function(ev) {

	$('#id_selected').val("");

	if(ev.target.id.indexOf('chx') != -1){

	}else{
		if(ev.target.id!=0){
			$('#id_selected').val(ev.target.id);
			$(location).attr('href', '/GL?action=stock&id='+ev.target.id);    
		}     				
	}	

});


//======================================================================//
// Liste choix equ
//======================================================================//

/*$(document).on('change', '.iw_select', function() {	

	var id_locataire = $('#chk_locataire_id'+this.id.substring(4)).val();
	var id_centre = $('#chk_bien_id'+this.id.substring(4)).val();

	if(this.checked) {

	if(records_selected_locataires.length==0){
	  records_selected_locataires.push($('#chk_locataire_id'+this.id.substring(4)).val());
	}

	if(records_selected_locataires.indexOf(id_locataire)!=-1){
		records_selected.push($('#id'+this.id.substring(4)).val());
	}else{
		$(this).prop('checked', false); 
	}

	 
	  Checkboxes_Manage(id_centre,id_locataire,false);
	  

				

	}else{

		var index = records_selected.indexOf($('#id'+this.id.substring(4)).val());
		records_selected.splice(index, 1);

		if(records_selected.length==0){

		var index = records_selected_locataires.indexOf($('#chk_locataire_id'+this.id.substring(4)).val());
		records_selected_locataires.splice(index, 1);
		Checkboxes_Manage(id_centre,id_locataire,true);

		}

	}



   ids_factures_imputes_values = '';
   var counter  = 1;

	for(var i of records_selected) {
		
		if(counter==1){
			ids_factures_imputes_values = ids_factures_imputes_values + i;
		}else{
			ids_factures_imputes_values = ids_factures_imputes_values + ';' + i;
		}
		
		counter = counter+1;
	}

	 $('#records_selected').val(ids_factures_imputes_values);


});*/

   /************ sidebar action ***********/

   if(sbaction=='new'){
		FORM_POPUP(true); 
 	}

 });  
