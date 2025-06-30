$(document).ready(function(){  

    var url_base= window.location.origin;

    var mandatory_fields_ligne = $("#mandatory_ligne").val().split(';');

    Mark_All_Required_Fields_Default(mandatory_fields_ligne);

    var TS_Show_Loader = true;

    var var_stkm_date ="";
    var var_stkm_heure ="";
    var var_stkm_quantite ="";
    var var_stkm_motif ="";
    var var_stkm_description ="";;

   function Get_Record_Data($id){

	$.LoadingOverlaySetup({
		background      : "rgba(0, 0, 0, 0.5)",
		imageColor      : "#fff"
	});

	$.LoadingOverlay("show");

	$('#titre_popup_stkm').html('Modification');

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

		var_stkm_date ="";
		var_stkm_heure ="";
		var_stkm_quantite ="";
		var_stkm_motif ="";
		var_stkm_description ="";;

		$.getJSON("/GL?action=get_stock_mouvement",data_json, function(data){  

          if(data.length>0){

			$.each(data, function(key, value){ 

                var_stkm_date = value.stkm_date;
                var_stkm_heure =value.stkm_heure;
                var_stkm_quantite =value.stkm_quantite;
                var_stkm_motif =value.stkm_motif;
                var_stkm_description =value.stkm_description;

			});  
          }

		}).done(function() {//success

		})
		.fail(function() { //error
		})
		.always(function() { //complete
		   
		   $.LoadingOverlay("hide");

		   FORM_POPUP_Mouvement(false);


		});  

   }



   function Save_Record_Line($type_ligne){

       $.LoadingOverlaySetup({
           background      : "rgba(0, 0, 0, 0.5)",
           imageColor      : "#fff"
       });

       $.LoadingOverlay("show");

           var data_ligne = {
             "id_piece": $("#record_id").val(),
             "id_ligne": $("#id_selected").val(),
             "stkm_date": $("#stkm_date").val(),
             "stkm_heure":$("#stkm_heure").val(),
             "stkm_quantite":$("#stkm_quantite").val(),                 
             "stkm_motif":$("#stkm_motif").val(),
             "stkm_description":$("#stkm_description").val()
           }

           var data = { 
               "zone":"gl", 
               "action":"set_intl",
               "data": {
                 "data": data_ligne
               }
           };

           var data_json = '&json='+JSON.stringify(data);

           var save_status='';

           $.getJSON("/GL?action=stock_ligne_valider",data_json, function(data){  
            

            $.each(data, function(key, value){  
             
                save_status = value;
              
            });

           }).done(function() {//success

           })
           .fail(function() { //error

           })
           .always(function() { //complete
              $.LoadingOverlay("hide");

              if(save_status!='Failed'){
                  
                Trigger_Search_Liste();
           
                 /*  $.alert({
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


   $("#btn_new_mouvement").click(function(ev){ 

       $("#id_selected").val('');

       FORM_POPUP_Mouvement(true);
          
       return false;

    });  
 



function FORM_POPUP_Mouvement($is_new_record){

            if($is_new_record==true){
                $('#titre_popup_stkm').html('Nouveau mouvement de stock');
            }else{
                $('#titre_popup_stkm').html('Modification du mouvement de stock');
            }

            var var_popup =''; 

            var_popup = $('#iw_form_popup_stkm').html();
            $('#iw_form_popup_stkm').html('');

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

                           if(Check_Required_Fields(mandatory_fields_ligne)){

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
                        
                        
                           }else{

                               Save_Record_Line();

                               $('#iw_form_popup_stkm').html(var_popup);

                               return true;

                           }


                       }
                   },
                     cancel: {
                       text: 'Fermer',
                       action: function () {

                            $('#iw_form_popup_stkm').html(var_popup);
                                 
                          
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

                  $('#stkm_date').datepicker({
                    format: 'dd/mm/yyyy'
                  });

                  $('#stkm_heure').datetimepicker({
                    pickDate: false,
                    minuteStep: 15,
                    pickerPosition: 'bottom-right',
                    autoclose: true,
                    startView: 1,
                    maxView: 1,
                    timeOnly: true,  
                    format: 'hh:i',
                    dateFormat: 'dd/mm/yyyy',
                    timeFormat: 'hh:mm:ss TT'
                 });

                 if($is_new_record==true){
                     var_stkm_date ="";
                     var_stkm_heure ="";
                     var_stkm_quantite ="";
                     var_stkm_motif ="";
                     var_stkm_description ="";;
                 }

                    if(var_stkm_date==""){
                         $("#stkm_date").datepicker().datepicker("setDate", new Date());
                    }else{
                         UTL_Date_Picker_Formatted(var_stkm_date,'#stkm_date');
                    }
                    $("#stkm_heure").val(var_stkm_heure);
                    UTL_Time_Picker_Formatted($('#stkm_date').val(),'#stkm_heure'); 
                    Set_Input_Value("#stkm_quantite",var_stkm_quantite); 
                    Set_Input_Value("#stkm_description",var_stkm_description);
                    $("#stkm_motif").attr('value', var_stkm_motif);
                    $("#stkm_description").attr('value', var_stkm_description);


               }
           });

}


$("#fdp_piece_quitter").click(function(ev){ 

    $(location).attr('href', '/GL?action=stocks');
        
    return false;

});  

//==========================================================================================================//
// Liste
//==========================================================================================================//

var sbajaxurl=url_base+'/GL?action=stkm_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}&id='+$('#record_id').val();

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

		    Get_Record_Data(ev.target.id);

		}     				
	}

});




/*============================================================================================================================================*/



});  
