		 
 $(document).ready(function(){  

     Display_Table_List();

     var required_fields = '';

      $("#btn_new").click(function(ev){ 

		   Nouvelle_Fiche(ev);
		   	
		    return false;
 
      });  


        $("#list_table div").click(function(ev){ 

        	 
			var data_search = {
				"id": ev.target.id
			};
	
			$('#id_selected').val(ev.target.id);

            $(location).attr('href', '/GL?action=relance&id='+ev.target.id);        

        });  



  $("#btn_search").click(function(){  

	    Display_Table_List();
	   	
	    return false;

  });  



  $("#btn_reset").click(function(){  

	    document.getElementById('relances').reset();

		$("#search_destinataire_id").val('')

	    Display_Table_List();
	   	
	    return false;

  });  


function Nouvelle_Fiche(){

   $(location).attr('href', '/GL?action=relance');

}

function Display_Table_List(){

			$.LoadingOverlaySetup({
			    background      : "rgba(0, 0, 0, 0.5)",
			    imageColor      : "#fff"
			});
	  
			$.LoadingOverlay("show");

			$('#list_table .table').empty();

			var data_specific = {
				"search_date": $("#search_date").val(),
				"search_destinataire": $("#search_destinataire_id").val()
			};

			var data_search = { 
				"zone":"gl", 
				"action":"get_relances",
				"data": data_specific
		    };
			
			var data_json = '&json='+JSON.stringify(data_search);
			

           $.getJSON("/GL?action=relances_list_json",data_json, function(data){  
		        
		        $('#list_table .table').empty();

		        var resp_table_data='';

					resp_table_data +='<div class="row header">';
					resp_table_data +='<div class="cell" style="min-width: 120px;">';
					resp_table_data +='Date relance';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell iw_second_column" style="min-width: 100px;">';
					resp_table_data +='Libellé';
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " style="min-width: 120px;">';
					resp_table_data +='Retard';
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
					resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data += Get_Date_Formatted(value.rlc_date);
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell  " id="'+value.id+'">';
					resp_table_data +=value.rlc_libelle;
					resp_table_data +='</div>';
					resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data +=value.rlc_retard;
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
			     Display_Table_List();
			  })
			  .always(function() { //complete
			    $.LoadingOverlay("hide");
			  });   
		   



}

    Init_Autocomplete('#search_destinataire','#search_destinataire_id','GB','get_autocomplete_centres');


 });  
