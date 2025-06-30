		 
 $(document).ready(function(){   

 
    //==================================================//
 	var url_base= window.location.origin;

 	 var var_tableliste_content = $('#list_table_events').html();
 
    var required_fields = $("#mandatory").val().split(';');

	 //==================================================//
	 
	var filtre_nom_heberge = getUrlParameter('usager');
	var filtre_type = getUrlParameter('type');
	var eve_presence = getUrlParameter('presence');
	var filtre_titre = getUrlParameter('titre');
	var filtre_date_du = getUrlParameter('date_du');
	var filtre_date_au = getUrlParameter('date_au');
	var filtre_proprietaire = getUrlParameter('proprietaire');

    $('#filtre_nom_heberge').val(filtre_nom_heberge);
    $('#filtre_titre').val(filtre_titre);
	$("#filtre_type > [value='" + filtre_type + "']").attr("selected", "true");
	$("#filtre_presence > [value='" + eve_presence + "']").attr("selected", "true");
	$("#filtre_proprietaire > [value='" + filtre_proprietaire + "']").attr("selected", "true");
	UTL_Date_Picker_Formatted(filtre_date_du,'#filtre_date_du');
	UTL_Date_Picker_Formatted(filtre_date_au,'#filtre_date_au');


    var gb_trigger_search = false;

	if((filtre_nom_heberge!='')||(filtre_type!='')||(eve_presence!='')||(filtre_titre!='')||(filtre_date_du!='')||(filtre_date_au!='')||(filtre_proprietaire!='')){
         gb_trigger_search = true;
	}
	 ////=================================================//
	 
	$('#list_table_events .table').empty();


	$("#btn_eve_search").click(function(){  
	

	  Trigger_Search_Liste();
	   	
	    return false;

	});  


	$("#btn_eve_export").click(function(){  
	

	  Export_Events();
	   	
	    return false;

	});  

	$("#btn_eve_list_print").click(function(){  
	

	    Print_Events_List();
	   	
	    return false;

	});  

	$("#btn_eve_back").click(function(){  
	

	    $(location).attr('href', '/USR?action=planning');  
	   	
	    return false;

	});  


function Print_Events_List(){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

  
        $.LoadingOverlay("show");

            var data_pla = {
              "filtre_nom_heberge": $('#filtre_nom_heberge').val(),
              "filtre_type": $('#filtre_type').val(),
              "eve_presence": $('#filtre_presence').val(),
              "filtre_titre": $('#filtre_titre').val()     
            }

            var data = { 
                "zone":"usr", 
                "action":"print_liste",
                "data": {
                  "pla": data_pla
                }
             };

      var data_json = '&json='+JSON.stringify(data);

      $(location).attr('href', '/USR?action=print_liste'+data_json);

      $.LoadingOverlay("hide");

	  /*  setTimeout(function(){ 
	    	alert('lll');
	       document.title = 'blah';
	    }, 8000);*/

      


 }



  function Export_Events(){
 	//$(location).attr('href', '/USR?action=export_events');


        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

  
        $.LoadingOverlay("show");

            var data_pla = {
              "filtre_nom_heberge": $('#filtre_nom_heberge').val(),
              "filtre_type": $('#filtre_type').val(),
              "eve_presence": $('#filtre_presence').val(),
              "filtre_titre": $('#filtre_titre').val(),
              "filtre_date_du":$('#filtre_date_du').val(),
              "filtre_date_au":$('#filtre_date_au').val(),
              "filtre_proprietaire":$('#filtre_proprietaire').val()     
            }

            var data = { 
                "zone":"usr", 
                "action":"export_events",
                "data": {
                  "pla": data_pla
                }
             };

      var data_json = '&json='+JSON.stringify(data);

      $(location).attr('href', '/USR?action=export_events'+data_json);

      $.LoadingOverlay("hide");



 }


function Get_JSON_Usagers(){

			$.LoadingOverlaySetup({
			    background      : "rgba(0, 0, 0, 0.5)",
			    imageColor      : "#fff"
			});
 
	  
			$.LoadingOverlay("show");

			Unmark_All_Required_Fields(required_fields);

			$('#int-usager .table').empty();
			$('#int-usager-result .table').empty();

			var data_search = {
				"nom": $("#nom").val(),
				"prenom": $("#prenom").val(),
				"date_naissance": $("#date_naissance").val(),
				"lien_famille": $("#lien_famille").val(),
				"telephone": $("#telephone").val()
			};

			var data_json = null;
		   		

           $.getJSON("/GL?action=usager_list_json",data_search, function(data){  
		        
console.log(data);
		         data_json = JSON.stringify(data);
console.log(data_json);

 $('#example').DataTable( {
	        data: data,
	        destroy: true,
	        "columns": [
	            { "data": "hb_cle" },
	            { "data": "hb_referenceid" },
	            { "data": "hb_referenceid" },
	            { "data": "hb_referenceid" },
	            { "data": "hb_referenceid" },
	            { "data": "hb_referenceid" }
	        ],
  "columnDefs": [ {
    "targets": 0,
    "data": "download_link",
    "render": function ( data, type, row, meta ) {
      return '<a href="'+data+'">Download</a>';
    }
  } ]
	    } );

           }).done(function() {//success

			  })
			  .fail(function() { //error
			    
			  })
			  .always(function() { //complete
			    $.LoadingOverlay("hide");
			  });   
		   
      return data_json;
}





  $("#btn_reset").click(function(){  


	    document.getElementById('events').reset();

	    //sessionStorage.setItem('first_load', 'true');

	    Trigger_Search_Liste();
	   	
	    return false;

  });  



//==========================================================================================================//
// Liste
//==========================================================================================================//


  var sbajaxurl=url_base+'/USR?action=events_list_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}';


  function Init_DataTable_Liste(){

		  var $table =$("#list_table_events")
		    .tablesorter({
		    theme: 'blue',
		      widthFixed: true,
		      sortLocaleCompare: true, 
		      sortList: [ [4,0] ], // [4,0],[6,0],[0,1] 
		      widgets: [ 'filter'],
		      widgetOptions : {
				filter_reset : '.fdp-btn-red',
				filter_external : 'search'

			   },
			          headers: { 
		            0: { 
		                sorter: true,filter: false 
		                },
		            1: { 
		                sorter: true,filter: true 
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
					  sorter: true,filter: true 
						},
					6:{
					     sorter:true,filter: true 
					   },
					7:{
					     sorter:true,filter: true 
					   },
					8:{
					     sorter:true,filter: true 
					   },
					9:{
					     sorter:true,filter: true 
					   },
					10:{
					     sorter:true,filter: true 
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

		  
		/*  $(".search").bind('search keyup', function (e) {
		    $('table').trigger('search', [ [this.value] ]);
		  });*/
		  

		  // Allow changing an input from one column (any column) to another
		  $('.search').change(function(){
			//$("#list_table_events").html('').html(var_tableliste_content);
	        
			$('#list_table_events').trigger('updateHeaders');
			$("#list_table_events").trigger("update"); 

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

					//var first_load = sessionStorage.getItem('first_load');

					//Trigger_Search_Liste();
					//sessionStorage.setItem('first_load', 'false');

				 //$.LoadingOverlay("hide");
			});

			/*$table.on('pagerChange', function(){
               // $.LoadingOverlay("hide");
               alert('pagerChange');
			});*/

			$table.on('pagerComplete', function(){
                $.LoadingOverlay("hide");
			});

			$table.on('filterInit', function(){
			    
			});

         
  }


	$('body').on('click','#list_table_events div', function(ev) {

		if (ev.target.id!=''){
			$(location).attr('href', '/USR?action=planning&atype=eventbyid&id_event='+ev.target.id);  
		}
	});
 	
	
	function Trigger_Search_Liste(){
		//$("#list_table_events").html('').html(var_tableliste_content);

        $('#list_table_events').trigger('updateHeaders');
		$("#list_table_events").trigger("update"); 

		$('#list_table_events').trigger('search');

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

		$.tablesorter.sortOn( $("#list_table_events")[0].config, [ [0,1] ], function() {
		  $.LoadingOverlay("hide");
		});

		$.LoadingOverlay("hide");
	}

   	Init_DataTable_Liste();

	if (gb_trigger_search == true){
		Trigger_Search_Liste();
	}

});  
