$(document).ready(function(){  
    Display_Table_Lignes();

    var mandatory_fields = $("#mandatory").val().split(';');
    var mandatory_fields_ligne = $("#mandatory_ligne").val().split(';');
    var mandatory_fields_intervenant = $("#mandatory_ligne_intervenant").val().split(';');

    var var_intl_equ_id = "";
    var var_intl_operation = "";
    var var_intl_montant_ht = "";
    var var_intl_tva_taux = "";
    var var_intl_montant_tva = "";
    var var_intl_montant_ttc = "";
    var var_intl_prestation = "";

    var st_mat_montant_ht = 0;
    var st_mat_montant_tva = 0;
    var st_mat_montant_ttc = 0;
    var st_pres_montant_ht = 0;
    var st_pres_montant_tva = 0;
    var st_pres_montant_ttc = 0;

    Mark_All_Required_Fields_Default(mandatory_fields);
    Mark_All_Required_Fields_Default(mandatory_fields_ligne);

    Init_Autocomplete_Immeubles('#int_immeuble_nom','#int_immeuble_id','GB','get_autocomplete_immeubles');
    Init_Autocomplete_Logements('#int_lc_nom','#int_lc_referenceid','GB','get_autocomplete_logements','#int_immeuble_id');

    IW_bootstrapSwitch_LK("int_pee","int_pee_montant");
    IW_bootstrapSwitch("int_autorisationabsence");

    if ($("#int_immeuble_nom").val() == "") {
        $('#int_lc_nom').attr("disabled", true);
    }

    $('#int_intervenants_ids').multiSelect({});
    DATA_Get_Intervenants();

    $("#btn_new_equipement").click(function(ev){ 
        $("#id_selected").val('');

        FORM_POPUP_Equipement();
        return false;
    });
 
    $("#btn_new_prestation").click(function(ev){ 
        $("#id_selected").val('');

        FORM_POPUP_prestation(ev);
        return false;
    });  
  
    $("#fdp_piece_valider").click(function(ev){ 
 
        if (Check_Required_Fields(mandatory_fields)){
            Mark_All_Required_Fields(mandatory_fields);

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

        }else{
            Save_Piece();
        } 
            
        return false;
    });

    $("#fdp_piece_quitter").click(function(ev){ 
        $(location).attr('href', '/GL?action=interventions');
        return false;
    });

    $("#list_table_equipements div").click(function(ev){ 

        if ($.isNumeric(ev.target.id)){

            if (ev.target.id != ''){
                $('#id_selected').val(ev.target.id);
                Get_Record_Data("equipement");
            }

        }

    });  

    $("#list_table_prestations div").click(function(ev){ 

        if ($.isNumeric(ev.target.id)){

            if (ev.target.id!=''){
                $('#id_selected').val(ev.target.id);
                Get_Record_Data("prestation");
            }

        }
    });

    $("#btn_add_filtre_intervenants").click(function(ev){ 
        Popup_Form_Intervenant(true);
        return false;
    });

    $("#btn_updt_filtre_intervenants").click(function(ev){ 
        Popup_Form_Intervenant($('#lc_immeuble_id option:selected').val() );
        return false;
    });

    $("#filtre_intervenants").change( function() {        
        DATA_Get_Intervenants();
    });

    $("#fdp_piece_imprimer").click(function(){
        WritePopup("Fiche d'intervention",{"interventionID": $("#record_id").val(), "lescentresID": $("#int_lc_referenceid").val()});
    });

    function Init_Autocomplete_Immeubles($id_field, $id_hidden, $module,$action){

        $($id_field).autocomplete({
            
            source: function (request, response) {    
                var tb_request_term = request.term.split(' ');

                if (tb_request_term.length == 2){

                    var data_specific = {
                        "data_first": tb_request_term[0],
                        "data_second": tb_request_term[1]
                    };

                }else{

                    var data_specific = {
                        "data_first": request.term,
                        "data_second": ''
                    };
                
                }

                var data_search = { 
                    "zone": "globale", 
                    "action": "get_autocomplete",
                    "data": data_specific
                };
                
                var data_json = '&json='+JSON.stringify(data_search);

                $.ajax({
                    type: "GET",
                    url: "/"+$module+"?action="+$action,
                    dataType: "json",
                    data: data_json,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data, function (item) {

                            return {
                                id: item.id,
                                value: item.value
                            }

                        }));
                    }
                });
            },
                minLength: 0,
            select: function (event, ui) {
                $($id_hidden).val(ui.item.id);
                $($id_field).val(ui.item.value);     

                $('#int_lc_nom').attr("disabled", true);

                if ($($id_field).val() != "") {
                    $('#int_lc_nom').attr("disabled", false);
                }
                
                return false;
            }
        }).focus(function () {

            setTimeout(
                "if ($('"+$id_field+"').val().length == 0) $('"+$id_field+"').autocomplete(\"search\", \"\"); "
            ,1);

        }).live("blur", function(event) {
            var autocomplete = $(this).data("autocomplete");
        
            if (autocomplete.selectedItem) {

                autocomplete._trigger("select", event, {
                    item: autocomplete.selectedItem
                });

            } else {
                $(this).val('');
            }

        });

    }

    function Init_Autocomplete_Logements($id_field,$id_hidden,$module,$action,$id_origin){

        $($id_field).autocomplete({
            
            source: function (request, response) {

                var tb_request_term = request.term.split(' ');

            var data_specific = {
                "data_first": tb_request_term[0],
                "data_second": tb_request_term[1],
                "id": $($id_origin).val()
            };

            var data_search = { 
                "zone": "globale", 
                "action": "get_autocomplete",
                "data": data_specific
                };
            
            var data_json = '&json='+JSON.stringify(data_search);

                $.ajax({
                    type: "GET",
                    url: "/"+$module+"?action="+$action,
                    dataType: "json",
                    data: data_json,
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        response($.map(data, function (item) {

                            return {
                                id: item.id,
                                value: item.value
                            }

                        }));
                    }
                });
            },
                minLength: 0,
            select: function (event, ui) {
                $($id_hidden).val(ui.item.id);
                $($id_field).val(ui.item.value); 

                return false;
            }
        }).focus(function () {

            setTimeout( "if ($('"+$id_field+"').val().length == 0) $('"+$id_field+"').autocomplete(\"search\", \"\"); ",1);

        }).live("blur", function(event) {

            var autocomplete = $(this).data("autocomplete");
        
            if (autocomplete.selectedItem) {
                autocomplete._trigger("select", event, {
                    item: autocomplete.selectedItem
                });

            } else {
                $(this).val('');
            }

        });

    }

    function Get_Record_Data($type_ligne){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var_intl_equ_id = "";
        var_intl_operation = "";
        var_intl_montant_ht = "";
        var_intl_tva_taux = "";
        var_intl_montant_tva = "";
        var_intl_montant_ttc = "";
        var_intl_prestation = "";

        var data_module = { 
            "id": $("#id_selected").val()
        };

        var data = { 
            "zone":"gl", 
            "action":"get_intl",
            "data": {
                "data": data_module
            }
        };

        var data_json = '&json='+JSON.stringify(data);

        $.getJSON("/GL?action=get_intervention_ligne",data_json, function(data){  

            $.each(data, function(key, value){ 
                var_intl_equ_id = value.intl_equ_id;
                var_intl_operation = value.intl_operation;
                var_intl_montant_ht = value.intl_montant_ht;
                var_intl_tva_taux = value.intl_tva_taux;
                var_intl_montant_tva = value.intl_montant_tva;
                var_intl_montant_ttc = value.intl_montant_ttc;
                var_intl_prestation = value.intl_prestation;
            });  
            

        }).done(function() {//success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            
            $.LoadingOverlay("hide");

            if ($type_ligne == "equipement"){
                FORM_POPUP_Equipement();
            }else{
                FORM_POPUP_prestation();
            }

        });  

    }

    function Delete_Piece(){

            $.confirm({
                title: 'Intervention',
                content: 'Voulez-vous vraiment supprimer cette intervention ?',
                icon: 'fa fa-warning',
                animation: 'scale',
                closeAnimation: 'zoom',
                columnClass: 'iw_alert',
                buttons: {
                    confirm: {
                        text: 'Oui',
                        btnClass: 'btn-orange',
                        action: function () {
                                
                                Delete_Piece_Exec();

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

    function Delete_Piece_Exec(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var data_piece = {
            "id": $("#record_id").val()
        }   

        var data = { 
            "zone":"gl", 
            "action":"int_delete",
            "data": {
                "data": data_piece
            }
        };

        var data_json = '&json='+JSON.stringify(data);

        var save_status='';

        $.getJSON("/GL?action=int_delete",data_json, function(data){  
            
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
                $(location).attr('href', '/GL?action=interventions');
            }else{

                $.alert({
                    title: 'Erreur',
                    content: 'Impossible de supprimer une intervention clôturée',
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

    function Save_Piece(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var data_piece = {
            "id": $("#record_id").val(),
            "int_type": $('#int_type option:selected').val(),
            "int_nom": $("#int_nom").val(),
            "int_etape": $('#int_etape option:selected').val(),
            "int_immeuble_id": $("#int_immeuble_id").val(),
            "int_immeuble_nom": $("#int_immeuble_nom").val(),
            "int_lc_referenceid": $("#int_lc_referenceid").val(),
            "int_lc_nom": $("#int_lc_nom").val(),
            "int_date_debut": $("#int_date_debut").val(),
            "int_date_fin": $("#int_date_fin").val(),
            "int_pee": $('#int_pee').val(),
            "int_pee_montant": $("#int_pee_montant").val(),
            "int_autorisationabsence": $("#int_autorisationabsence").val(),
            "hebergeid": $("#hebergeid").val(),
            "int_referent": $("#int_referent").val(),
            "int_notes": $("#int_notes").val(),
            "int_total_ht": $("#int_total_ht").val(),
            "int_total_tva": $("#int_total_tva").val(),
            "int_total_ttc": $("#int_total_ttc").val(),
            "int_equ_total_ttc": $("#int_equ_total_ttc").val(),
            "int_prestation_total_ttc": $("#int_prestation_total_ttc").val(),
            "int_intervenants_ids": $("#int_intervenants_ids").val()
        }

        var data = { 
            "zone":"gl", 
            "action":"intervention_valider",
            "data": {
                "data": data_piece
            }
        };

        var data_json = '&json='+JSON.stringify(data);
        var save_status='';

        $.getJSON("/GL?action=intervention_valider",data_json, function(data){  
        
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
                                btnClass: 'btn-blue',
                                action: function () {
                                    Display_Table_Lignes();
                                    window.location.href = 'GL?action=interventions&getPreviousList=vrai';
                                }
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

    function Save_Record_Line($type_ligne){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var $intl_equ_id = "";
        var $intl_equ_nom = "";
        var $intl_operation = "";
        var $intl_prestation = "";

        var $prefixe = "";

        if ($type_ligne == 'equipement'){
            $intl_equ_id = $("#intl_equ_id option:selected").val();
            $intl_equ_nom = $("#intl_equ_id option:selected").text();
            $intl_operation = $('#intl_operation option:selected').val();         
        }else{
            $intl_prestation = $("#intl_prestation").val();
            $prefixe = "p_";
        }

        var data_ligne = {
            "id_piece": $("#record_id").val(),
            "id_ligne": $("#id_selected").val(),
            "intl_equ_id": $intl_equ_id,
            "intl_equ_nom": $intl_equ_nom,
            "intl_operation": $intl_operation,                 
            "intl_prestation":$intl_prestation,
            "intl_montant_ht": $("#"+$prefixe+"intl_montant_ht").val(),
            "intl_tva_taux": $('#'+$prefixe+'intl_tva_taux option:selected').val(),
            "intl_montant_tva": $("#"+$prefixe+"intl_montant_tva").val(),// Get_Input_DataValue("#facl_prix_unit_ht")
            "intl_montant_ttc": $("#"+$prefixe+"intl_montant_ttc").val()
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

        $.getJSON("/GL?action=intervention_ligne_valider",data_json, function(data){  
        
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
                Display_Table_Lignes();

                if ($intl_equ_id!=''){
                    ges_stock
                }
            
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

    function Display_Table_Lignes(){
        Display_Table_Equipements();
    }

    function Display_Table_Equipements(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var data_specific = {
            "id": $("#record_id").val(),
            "type_ligne": "equipement"
        };

        var data_search = { 
            "zone":"gl", 
            "action":"get_int_lignes",
            "data": data_specific
        };
        
        var data_json = '&json='+JSON.stringify(data_search);

        st_mat_montant_ht = 0;
        st_mat_montant_tva = 0;
        st_mat_montant_ttc = 0;

        $.getJSON("/GL?action=int_lignes_list_json",data_json, function(data){  
            $('#list_table_equipements .table').empty();

            var resp_table_data='';
            resp_table_data +='<div class="row header">';
            resp_table_data +='<div class="cell" style="min-width: 120px;">';
            resp_table_data +='Équipement';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell" style="min-width: 120px;">';
            resp_table_data +='Pièce';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell" style="min-width: 120px;">';
            resp_table_data +='Opération';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell" style="min-width: 120px;">';
            resp_table_data +='Quantité';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant">';
            resp_table_data +='Taux de TVA';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant  " >';
            resp_table_data +='Montant HT';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant">';
            resp_table_data +='Montant TVA';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant">';
            resp_table_data +='Montant TTC';
            resp_table_data +='</div>';
            resp_table_data +='</div>'; 
        
            if (data.length>0){
                var css_class_row='';
                var counter = 0;

                $.each(data, function(key, value){  
                    css_class_row='';

                    if (counter % 2 != 0){
                        css_class_row+=' iw-alternate';
                    }

                    st_mat_montant_ht = st_mat_montant_ht + value.intl_montant_ht; 
                    st_mat_montant_tva = st_mat_montant_tva + value.intl_montant_tva; 
                    st_mat_montant_ttc = st_mat_montant_ttc + value.intl_montant_ttc; 

                    resp_table_data +='<div class="row body '+css_class_row+'">';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data += value.intl_equ_nom;
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data += value.intl_piece_nom;
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell  " id="'+value.id+'">';
                    resp_table_data +=value.intl_operation;
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data += value.intl_quantite;
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data +=iw_round(value.intl_tva_taux);
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell  " id="'+value.id+'">';
                    resp_table_data +=value.intl_montant_ht;
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data +=iw_round(value.intl_montant_tva);
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data +=iw_round(value.intl_montant_ttc);
                    resp_table_data +='</div>';
                    resp_table_data +='</div>';

                    $('<input>', {
                        type: 'hidden',
                        id: 'id'+value.id,
                        name: 'id'+value.id,
                        value: value.id
                    }).appendTo('#list_table_equipements');

                    $('<input>', {
                        type: 'hidden',
                        id: 'facl_type_'+value.id,
                        name: 'facl_type_'+value.id,
                        value: value.facl_type
                    }).appendTo('#list_table_equipements');

                    counter = counter + 1;
                });

            }

            resp_table_data +='<div class="row footer ">';
            resp_table_data +='<div class="cell " >';
            resp_table_data += '';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell " >';
            resp_table_data += '';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell  " >';
            resp_table_data += ''
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell ">';
            resp_table_data +='';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell ">';
            resp_table_data +='';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell  " >';
            resp_table_data += '<input data-column="" type="text" id="mat_montant_ht" name="mat_montant_ht" value="'+iw_round(st_mat_montant_ht)+'" class="" readonly>';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell ">';
            resp_table_data +='<input data-column="" type="text" id="mat_montant_tva" name="mat_montant_tva" value="'+iw_round(st_mat_montant_tva)+'" class="" readonly>';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell ">';
            resp_table_data +='<input data-column="" type="text" id="int_equ_total_ttc" name="int_equ_total_ttc" value="'+iw_round(st_mat_montant_ttc)+'" class="" readonly>';
            resp_table_data +='</div>';
            resp_table_data +='</div>';

            $("#list_table_equipements .table").append(resp_table_data); 
        }).done(function() {//success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            $.LoadingOverlay("hide");
            Display_Table_Prestations();
        });   
        
    }

    function Display_Table_Prestations(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var data_specific = {
            "id": $("#record_id").val(),
            "type_ligne": "prestation"
        };

        var data_search = { 
            "zone":"gl", 
            "action":"get_int_prestations",
            "data": data_specific
        };
        
        var data_json = '&json='+JSON.stringify(data_search);
        
        st_pres_montant_ht = 0;
        st_pres_montant_tva = 0;
        st_pres_montant_ttc = 0;

        $.getJSON("/GL?action=int_lignes_list_json",data_json, function(data){  
            $('#list_table_prestations .table').empty();

            var resp_table_data='';
            resp_table_data +='<div class="row header">';
            resp_table_data +='<div class="cell" style="min-width: 120px;">';
            resp_table_data +='Prestation';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant" style="min-width: 120px;">';
            resp_table_data +='Taux de TVA';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant" style="min-width: 100px;">';
            resp_table_data +='Montant HT';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant" style="min-width: 120px;">';
            resp_table_data +='Montant TVA';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant" style="min-width: 120px;">';
            resp_table_data +='Montant TTC';
            resp_table_data +='</div>';
            resp_table_data +='</div>'; 
            
            if (data.length>0){
                var css_class_row='';
                var counter = 0;

                $.each(data, function(key, value){  
                    css_class_row='';

                    if (counter % 2 != 0){
                        css_class_row += ' iw-alternate';
                    }

                    st_pres_montant_ht = st_pres_montant_ht + value.intl_montant_ht; 
                    st_pres_montant_tva = st_pres_montant_tva + value.intl_montant_tva; 
                    st_pres_montant_ttc = st_pres_montant_ttc + value.intl_montant_ttc; 

                    resp_table_data +='<div class="row body '+css_class_row+'">';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data += value.intl_prestation;
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell  " id="'+value.id+'">';
                    resp_table_data +=value.intl_montant_ht;
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data +=iw_round(value.intl_tva_taux);
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data +=iw_round(value.intl_montant_tva);
                    resp_table_data +='</div>';
                    resp_table_data +='<div class="cell " id="'+value.id+'">';
                    resp_table_data +=iw_round(value.intl_montant_ttc);
                    resp_table_data +='</div>';
                    resp_table_data +='</div>';

                    $('<input>', {
                        type: 'hidden',
                        id: 'id'+value.id,
                        name: 'id'+value.id,
                        value: value.id
                    }).appendTo('#list_table_prestations');


                    $('<input>', {
                        type: 'hidden',
                        id: 'facl_type_'+value.id,
                        name: 'facl_type_'+value.id,
                        value: value.facl_type
                    }).appendTo('#list_table_prestations');

                    counter = counter + 1;
                });  

            }

            resp_table_data +='<div class="row footer ">';
            resp_table_data +='<div class="cell " >';
            resp_table_data += '';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell ">';
            resp_table_data +='';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell  " >';
            resp_table_data += '<input data-column="" type="text" id="pres_montant_ht" name="pres_montant_ht" value="'+iw_round(st_pres_montant_ht)+'" class="" readonly>';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell ">';
            resp_table_data +='<input data-column="" type="text" id="pres_montant_tva" name="pres_montant_tva" value="'+iw_round(st_pres_montant_tva)+'" class="" readonly>';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell ">';
            resp_table_data +='<input data-column="" type="text" id="int_prestation_total_ttc" name="int_prestation_total_ttc" value="'+iw_round(st_pres_montant_ttc)+'" class="" readonly>';
            resp_table_data +='</div>';
            resp_table_data +='</div>';

            $("#list_table_prestations .table").append(resp_table_data); 

            // TOTAL GLOBAL

            $('#intervention_pied .table').empty();

            var resp_table_data='';

            resp_table_data +='<div class="row footer ">';
            resp_table_data +='<div class="cell " >';
            resp_table_data += '';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell ">';
            resp_table_data +='';
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant" >';
            resp_table_data +='<div class="control-group">'
            resp_table_data +='<label id="total ht" for="" class="fdp_width100">Total HT</label>'
            resp_table_data += '<input data-column="" type="text" id="int_total_ht" name="int_total_ht" value="'+iw_round(st_mat_montant_ht+st_pres_montant_ht)+'" class="" readonly>';
            resp_table_data +='</div>'
            resp_table_data +='</div>';
            resp_table_data +='<div class="cell montant">';
            resp_table_data +='<div class="control-group">'
            resp_table_data +='<label id="total ht" for="" class="fdp_width100">Total TVA</label>'
            resp_table_data +='<input data-column="" type="text" id="int_total_tva" name="int_total_tva" value="'+iw_round(st_mat_montant_tva+st_pres_montant_tva)+'" class="" readonly>';
            resp_table_data +='</div>';
            resp_table_data +='</div>'
            resp_table_data +='<div class="cell montant">';
            resp_table_data +='<div class="control-group">'
            resp_table_data +='<label id="total ht" for="" class="fdp_width100">Total TTC</label>'
            resp_table_data +='<input data-column="" type="text" id="int_total_ttc" name="int_total_ttc" value="'+iw_round(st_mat_montant_ttc+st_pres_montant_ttc)+'" class="" readonly>';
            resp_table_data +='</div>';
            resp_table_data +='</div>'
            resp_table_data +='</div>';

            $("#intervention_pied .table").append(resp_table_data); 

        }).done(function() {//success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            $.LoadingOverlay("hide");
        });   

    }

    function FORM_POPUP_Equipement(){
        $('#titre_popup_intl').html('Équipement');

        var var_popup =''; 
        var_popup = $('#iw_form_popup_intl').html();

        $('#iw_form_popup_intl').html('');

        $.confirm({
            title: '',
            content: '' +
            '<div>' + var_popup +     
            '</div>',
            buttons: {
                Supprimer: {
                    text: 'Supprimer',
                    btnClass: 'btn-red iw_btn_delete',
                    keys: ['del'],
                    isHidden: false,
                    isDisabled: false,
                    action: function() {

                        $.confirm({
                            title: 'Suppression',
                            content: 'Voulez-vous vraiment supprimer cette équipement ?',
                            icon: 'fa fa-warning',
                            animation: 'scale',
                            closeAnimation: 'zoom',
                            columnClass: 'iw_alert',
                            buttons: {
                                confirm: {
                                    text: 'Oui',
                                    btnClass: 'btn-orange',
                                    action: function() {
                                        $('#iw_form_popup_intl').html(var_popup);
                                        Remove_Equipement();
                                    }
                                },
                                cancel: {
                                    text: 'Non',
                                    action: function() {
                                    }
                                }
                            }
                        });
                    }
                },
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'btn-blue',
                    action: function () {

                        if (Check_Required_Fields(mandatory_fields_ligne)){
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
                            Save_Record_Line("equipement");
                            $('#iw_form_popup_intl').html(var_popup);

                            return true;
                        }

                    }
                },
                cancel: {
                text: 'Fermer',
                action: function () {

                        $('#iw_form_popup_intl').html(var_popup);
                            
                    
                }
                },
            },
            onContentReady: function () {
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });

                $(".jconfirm-buttons").find(".iw_btn_delete").hide();

                if ($("#id_selected").val() == "") {
                    var_intl_equ_id = "";
                    var_intl_operation = "";
                    var_intl_montant_ht = "";
                    var_intl_tva_taux = "";
                    var_intl_montant_tva = "";
                    var_intl_montant_ttc = "";
                    var_intl_prestation = "";
                }else{

                    if (visiteur.Privilege.indexOf("Suppression_gestion_immo") != -1) {
                        $(".jconfirm-buttons").find(".iw_btn_delete").show();
                    }

                }

                $("#intl_equ_id > [value='" + var_intl_equ_id + "']").attr("selected", "true");	
                $("#intl_operation > [value='" + var_intl_operation + "']").attr("selected", "true");					
                Set_Input_Value("#intl_montant_ht",var_intl_montant_ht);    

                $("#intl_tva_taux > [value='" + var_intl_tva_taux + "']").attr("selected", "true");
                Set_Input_Value("#intl_montant_tva",var_intl_montant_tva); 
                Set_Input_Value("#intl_montant_ttc",var_intl_montant_ttc); 

                $("#intl_prestation").attr('value', var_intl_prestation);  

                $("#intl_montant_ttc").change( function() {
                    GES_Calcul_Ligne(1,"equipement");
                });

                $("#intl_tva_taux").change( function() {
                    GES_Calcul_Ligne(2,"equipement");
                });

                $("#intl_montant_ht").change( function() {
                    GES_Calcul_Ligne(2,"equipement");
                });
            }
        });

    }

    function FORM_POPUP_prestation(ev){
        $('#titre_popup_intlp').html('Prestation');

        var var_popup =''; 
        var_popup = $('#iw_form_popup_intlp').html();

        $('#iw_form_popup_intlp').html('');

        $.confirm({
            title: '',
            content: '' +
            '<div>' +var_popup+     
            '</div>',
            buttons: {
                Supprimer: {
                    text: 'Supprimer',
                    btnClass: 'btn-red iw_btn_delete',
                    keys: ['del'],
                    isHidden: false,
                    isDisabled: false,
                    action: function() {

                        $.confirm({
                            title: 'Suppression',
                            content: 'Voulez-vous vraiment supprimer cette prestation ?',
                            icon: 'fa fa-warning',
                            animation: 'scale',
                            closeAnimation: 'zoom',
                            columnClass: 'iw_alert',
                            buttons: {
                                confirm: {
                                    text: 'Oui',
                                    btnClass: 'btn-orange',
                                    action: function() {
                                        $('#iw_form_popup_intlp').html(var_popup);
                                        Remove_Prestation();
                                    }
                                },
                                cancel: {
                                    text: 'Non',
                                    action: function() {
                                    }
                                }
                            }
                        });

                    }
                },
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
                            Save_Record_Line("prestation");

                            $('#iw_form_popup_intlp').html(var_popup);
                            return true;
                        }

                    }
                },
                cancel: {
                    text: 'Fermer',
                    action: function () {
                        $('#iw_form_popup_intlp').html(var_popup);
                    }
                },
            },
            onContentReady: function () {
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });

                $(".jconfirm-buttons").find(".iw_btn_delete").hide();

                if ($("#id_selected").val() == "") {
                    var_intl_equ_id= "";
                    var_intl_operation= "";
                    var_intl_montant_ht= "";
                    var_intl_tva_taux= "";
                    var_intl_montant_tva= "";
                    var_intl_montant_ttc= "";
                    var_intl_prestation= "";
                }else{

                    if (visiteur.Privilege.indexOf("Suppression_gestion_immo") != -1) {
                        $(".jconfirm-buttons").find(".iw_btn_delete").show();
                    }

                }
				
                Set_Input_Value("#p_intl_montant_ht",var_intl_montant_ht);    
                $("#p_intl_tva_taux > [value='" + var_intl_tva_taux + "']").attr("selected", "true");	

                Set_Input_Value("#p_intl_montant_tva",var_intl_montant_tva); 
                Set_Input_Value("#p_intl_montant_ttc",var_intl_montant_ttc); 
                $("#intl_prestation").attr('value', var_intl_prestation);  

                $("#p_intl_montant_ttc").change( function() {
                    GES_Calcul_Ligne(1,"prestation");
                });

                $("#p_intl_tva_taux").change( function() {
                GES_Calcul_Ligne(2,"prestation");
                });

                $("#p_intl_montant_ht").change( function() {
                GES_Calcul_Ligne(2,"prestation");
                });
            }
        });

    }

    //======================================================================//
    // Methodes de Gestion
    //======================================================================//
    function GES_Calcul_Ligne($type,$type_ligne){
        var $prefixe = "";

        if ($type_ligne == 'prestation'){        
            $prefixe = "p_";
        }

        var var_result = 0;
        var montant_ht = $("#"+$prefixe+"intl_montant_ht").val();
        var tva_taux = $("#"+$prefixe+"intl_tva_taux option:selected").val();
        var montant_ttc = $("#"+$prefixe+"intl_montant_ttc").val();

        var montant_tva = montant_ht * (tva_taux/100);
        Set_Input_Value("#"+$prefixe+"intl_montant_tva",montant_tva);
        
        switch($type){
            case 1:
                var_result = montant_ttc / (1+(tva_taux/100))
                Set_Input_Value("#"+$prefixe+"intl_montant_ht",var_result);

                break;
            case 2:
                var_result = montant_ht * (1+(tva_taux/100))
                Set_Input_Value("#"+$prefixe+"intl_montant_ttc",var_result);

                break;
            default:
                break;
        }

    }

    //======================================================================//
    // Intervenants
    //======================================================================//

    function DATA_Get_Intervenants(){
        var tb_selected_hb_list = [];

        $('#int_intervenants_ids > option:selected').each(function() {

            var heberger_data = {  
                "id" : $(this).val(),                                
                "value" : $(this).text()
            };

            tb_selected_hb_list.push(heberger_data);
        });

        $('#int_intervenants_ids').empty();

        tb_selected_hb_list.forEach(function(item) {
            $('#int_intervenants_ids').append('<option value="' + item.id + '" selected>' + item.value + '</option>');
        });

        var data_specific = {
            "search_nom": $("#filtre_intervenants").val(),
            "id_selected": $("#record_id").val()
        };

        var data_search = { 
            "zone":"GL", 
            "action":"get_intervenants",
            "data": data_specific
        };
        
        var data_json = 'json='+JSON.stringify(data_search);

        $.getJSON("/GL?action=get_intervenants",data_json, function(data){  
    
            if (data.length>0){
            
                $.each(data, function(key, value){  

                    if (UTL_Select_OptionExists(value.userid,'int_intervenants_ids') == false){  
                        
                        if (value.usr_societe!=''){
                            $('#int_intervenants_ids').append('<option value="' + value.userid + '" '+value.status+'>' + value.user_nom_prenom + " ("+value.usr_societe+")"+ '</option>');
                        }else{
                            $('#int_intervenants_ids').append('<option value="' + value.userid + '" '+value.status+'>' + value.user_nom_prenom  + '</option>');
                        }

                    }

                });                  
                        
            }

        }).done(function() {//success
        })
        .fail(function() { //error 
        })
        .always(function() { //complete
            $('#int_intervenants_ids').multiSelect('refresh');

            $('#iw_selected_list_title').html("Liste des intervenants choisis");
            $('#iw_selectable_list_title').html("Liste des intervenants");
        
            // Ajout par Scanu Rémy - remy@connect-io.fr
            // On va rajouter à la mano le bouton pour éditer chaque item
            var $ulToCopy = $("#ms-int_intervenants_ids .ms-selectable .ms-list");

            $("<div class=\"row\">").insertBefore($ulToCopy);
            $("<ul class=\"ms-list ulCopy span4\">"+ $ulToCopy.html() +"</ul></div>").insertAfter($ulToCopy);

            $ulToCopy.addClass("span8");

            $ulToCopy.css({"width": "80%", "margin-right": "10px"});
            $(".ulCopy").css({"width": "15%","border": "0px"});

            $(".ulCopy li").each(function(index){
                $(this).html("<img class=\"edit\" data-id=\""+ $('#int_intervenants_ids option').eq(index).val() +"\" data-index=\""+ index +"\" src=\"/layouts/default/images/edit.png\" width=\"20\">");
            });

            $(".ulCopy li").css({"border": "none"});
            $(".ulCopy img").css({"cursor": "pointer"});

            $(".edit").click(function(){
                var $intervenant_t = $ulToCopy.find("li").eq($(this).attr("data-index")).text();
                $("#titre_popup_intn").text("Modification de l'intervenant " + $intervenant_t);
                
                $objet_o = {
                    "nom": "",
                    "prenom": "",
                    "societe": "",
                    "id": $(this).attr("data-id")
                };

                // Il faut spliter la chaine pour mettre les bons eléments dans les bons champs
                $pos_el = $intervenant_t.indexOf("(");

                // Il y a un nom de société indiqué
                if ($pos_el > 0) {
                    $nomPrenom_t = $intervenant_t.substring(0,$pos_el-1)
                    $objet_o.societe = $intervenant_t.substring($pos_el+1,$intervenant_t.length-1)
                }else{
                    $nomPrenom_t = $intervenant_t
                }

                $collection_c = $nomPrenom_t.split(" ");

                switch (true) {
                    case ($collection_c.length > 1):

                        $.each($collection_c, function(index, value){

                            if (index == 0) {
                                $objet_o.nom = $collection_c[0];
                            }else{

                                if (index < $collection_c.length - 1) {
                                    $objet_o.prenom += $collection_c[index]+" " 
                                }else{
                                    $objet_o.prenom += $collection_c[index]
                                }
                            }

                        });
                        
                        break;
                    default:
                        $objet_o.nom = $collection_c[0];

                        break;
                }

                Popup_Form_Intervenant(false,$objet_o);
            });
        });
    }

    function Popup_Form_Intervenant($is_new_record,$parameter){

        if ($is_new_record == true){
            $('#titre_popup_intn').html('Nouveau intervenant');
        }

        var var_popup = $('#iw_form_popup_intn').html();

        $('#iw_form_popup_intn').html('');
        
        $.confirm({
            title: '',
            columnClass: 'iw_popup_form iw_popup_form_small',
            content: '' +
            '<div>' +var_popup+     
            '</div>',
            buttons: {
                cancel: {
                    text: 'Fermer',
                    btnClass: 'iw_btn_close',
                    action: function () {
                        $('#iw_form_popup_intn').html(var_popup);
                    }
                },
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'btn-blue iw_btn_save',
                    action: function () {

                        if (Check_Required_Fields(mandatory_fields_intervenant)){
                            Mark_All_Required_Fields(mandatory_fields_intervenant);

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

                            if ($is_new_record == true) {
                                Save_Record_Intervenant(true);
                            }else{
                                Save_Record_Intervenant(false,$parameter.id);
                            }

                            $('#iw_form_popup_intn').html(var_popup);

                            return true;
                        }
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

                if ($is_new_record==true){
                    $('#gii_nom').val('');
                    $('#gii_prenom').val('');
                    $('#gii_societe').val('');
                }else{
                    $('#gii_nom').val($parameter.nom);
                    $('#gii_prenom').val($parameter.prenom);

                    $('#gii_societe').val($parameter.societe);
                }

            }
        });

    }

    function Save_Record_Intervenant($is_new_record,$id){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var data_ligne = {
            "id": "0",
            "gii_nom": $("#gii_nom").val(),
            "gii_prenom": $("#gii_prenom").val(),
            "gii_nomprenom": $("#gii_nom").val()+' '+$("#gii_prenom").val(),
            "gii_societe": $("#gii_societe").val()
        }

        if ($is_new_record==true){
            data_ligne.id = "0"
        }else{
            data_ligne.id = $id
        }

        var data = { 
            "zone":"gl", 
            "action":"set_intervenant",
            "data": {
                "data": data_ligne
            }
        };

        var data_json = '&json='+JSON.stringify(data);

        var save_status='';

        $.getJSON("/GL?action=set_intervenant",data_json, function(data){  
        
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
                DATA_Get_Intervenants();
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

    function Remove_Equipement() {
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
            "action": "gl_remove_equipement",
            "data": {
                "data": data_ligne
            }
        };

        var data_json = 'json=' + JSON.stringify(data);

        var operation_status = '';

        $.getJSON("/GL?action=gl_remove_equipement", data_json, function(data) {

			$.each(data, function(key, value) {
				operation_status = value;
			});

		}).done(function() { //success

		})
		.fail(function() { //error

		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (operation_status == 'Failed') {

				$.confirm({
					title: 'Suppression',
					content: 'Impossible d\'effectuer la suppression.',
					icon: 'fa fa-warning',
					animation: 'scale',
					closeAnimation: 'zoom',
					columnClass: 'iw_alert',
					buttons: {
						cancel: {
							text: 'Ok',
							action: function() {

							}
						}
					}
				});

			} else {
				Display_Table_Equipements();
			}
		});
    }

    function Remove_Prestation() {
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
            "action": "gl_remove_prestation",
            "data": {
                "data": data_ligne
            }
        };

        var data_json = 'json=' + JSON.stringify(data);

        var operation_status = '';

        $.getJSON("/GL?action=gl_remove_prestation", data_json, function(data) {

			$.each(data, function(key, value) {
				operation_status = value;
			});

		}).done(function() { //success

		})
		.fail(function() { //error

		})
		.always(function() { //complete
			$.LoadingOverlay("hide");

			if (operation_status == 'Failed') {

				$.confirm({
					title: 'Suppression',
					content: 'Impossible d\'effectuer la suppression.',
					icon: 'fa fa-warning',
					animation: 'scale',
					closeAnimation: 'zoom',
					columnClass: 'iw_alert',
					buttons: {
						cancel: {
							text: 'Ok',
							action: function() {

							}
						}
					}
				});

			} else {
				Display_Table_Prestations();
			}
		});
    }

    $(".col-6").removeClass("control-group");
});