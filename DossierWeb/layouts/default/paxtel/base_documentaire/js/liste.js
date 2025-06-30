$(document).ready(function(){  
    var url_base= window.location.origin;
    var TS_Show_Loader = true;

    var gb_action = getUrlParameter('action');

    var var_tableliste_content = $('#list_table_basedoc').html();
    var doc_name_previous='';

    $('#id_selected').val('');
    $('#iw_form_popup_child_basedoclist div:first').removeClass('blue');

    /***********************************************************************/
    $("#btn_sb_gi_basedoc_a").click(function(ev){ 
        if(gb_action!="base_documentaire"){
            //POPUP_FORM_DOC_LIST(); 
            POPUP_FORM_DOC(true);
        }  
        return false; 
    });   

    $('#btn_sb_gi_basedoc_l').click(function (e) {
        if(gb_action!="base_documentaire"){
            POPUP_FORM_DOC_LIST(); 
        }  
        return false; 
    });
    /***********************************************************************/

    $("#btn_sb_gi_basedoc_btn").click(function(ev){
        if(gb_action!="base_documentaire"){
            POPUP_FORM_DOC_LIST(); 
        }  
        return false; 
    });   

    function POPUP_FORM_DOC_LIST(){ 
        var continu = true;

        if (($('#table_num').val() == '115') && ($('#record_id').val() == '')){
            continu = false;
        }

        if (continu == true){
            $('#titre_popup_basedoclist').html($('#nav_module').val()+'Base documentaire');

            var var_popup = $('#iw_form_popup_basedoclist').html();
            $('#iw_form_popup_basedoclist').html('');
        
            $.confirm({
                title: '',
                columnClass: 'popup_event_class iw_popup_form iw_popup_form_medium',
                content: '' +
                '<div>' + var_popup +     
                '</div>', 
                buttons: {
                    cancel: {
                        text: 'Fermer',
                        btnClass: 'iw_btn_right',
                        action: function () {
                            $('#iw_form_popup_basedoclist').html(var_popup);
                            $("#id_selected").val('');
                        }
                    },
                telecharger: {
                    text: 'Télécharger',
                    btnClass: 'btn-green iw_btn_right',
                    isDisabled: false,
                    action: function () {

                        if ($('#id_selected').val() != ''){
                            var document_path = '/GB?action=get_file&id=' + $('#id_selected').val() + '&type=' + $('#table_name').val();
                            window.open(document_path , '_blank');
                            return false;
                        }else{

                            $.alert({
                                title: 'Alerte',
                                content: 'Veuillez sélectionner un document dans la liste ci-dessus.',
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

                            return false;
                        }        
                        
                    }
                },
                modifier: {
                    text: 'Modifier',
                    btnClass: 'btn-orange iw_btn_right',
                    isDisabled: false,
                    action: function () {
                
                        if ($('#id_selected').val() != ''){
                            Get_Record_Data();
                            $('#iw_form_popup_basedoclist').html(var_popup);
                        }else{
                            $.alert({
                                title: 'Alerte',
                                content: 'Veuillez sélectionner un document dans la liste ci-dessus.',
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
                            return false;
                        }   

                        return true;
                    }
                },
                nouveau: {
                    text: 'Nouveau',
                    btnClass: 'btn-blue iw_btn_right',
                    isDisabled: false,
                    action: function () {
                        POPUP_FORM_DOC(true);
                        
                        $('#iw_form_popup_basedoclist').html(var_popup);
                        $("#id_selected").val('');

                        return true;
                    }
                },
                supprimer: { 
                    text: 'Supprimer',
                    btnClass: 'btn-red iw_btn_left',
                    isDisabled: false,
                    action: function () {

                        if ($('#id_selected').val() != ''){
                            Delete_Document();

                            $('#iw_form_popup_basedoclist').html(var_popup);
                            $("#id_selected").val('');
                            
                        }else{
                            $.alert({
                                title: 'Alerte',
                                content: 'Veuillez sélectionner un document dans la liste ci-dessus.',
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
                            return false;
                        }

                    }
                }
                },
                onContentReady: function () {
                    var jc = this;
                    this.$content.find('form').on('submit', function (e) {
                        
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click'); 
                    });

                    sbajaxurl = url_base + '/GL?action=basedoc_list_ts_json&page={page}&size={size}&table_num=' + $('#table_num').val() + '&record_id=' + $('#record_id').val() + "&module=" + $('#module_name').val();
                    Init_DataTable_Liste();
                }
            });

        }else{

            $.alert({
                title: 'Alerte',
                content: 'Veuillez sélectionner un élement dans la liste.',
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

    }

	$(document).on('change', '#iw_form_popup_child_basedoclist .iw_select', function() {	
        $('.iw_select').not(this).prop('checked', false);  

        var id_document = this.id.substring(4);
        $('#id_selected').val(id_document);
    });

    function Delete_Document(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var data_ligne = {
            "id_piece": $("#record_id").val(),
            "id": $("#id_selected").val()
        }

        var data = { 
            "zone":"gl", 
            "action":"basedoc_delete_document",
            "data": {
            "ligne": data_ligne
            }
        };

        var data_json = '&json='+JSON.stringify(data);
        var save_status='';

        $.getJSON("/GL?action=basedoc_delete_document&table_name="+$('#table_name').val(),data_json, function(data){

            $.each(data, function(key, value){
            });

        }).done(function() {//success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            $.LoadingOverlay("hide");
        });
    }

    //==========================================================================================================//
    // Liste
    //==========================================================================================================//
    var sbajaxurl = url_base + '/GL?action=basedoc_list_ts_json&page={page}&size={size}&{sortList:col}&{filterList:fcol}&table_num=' + $('#table_num').val() + '&record_id=' + $('#record_id').val();

    function Init_DataTable_Liste(){
        var $table = $("#list_table_basedoc")
        .tablesorter({
            theme: 'blue',
                widthFixed: true,
                sortLocaleCompare: false, 
                sortList: [  [2,1]  ],
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
                    sorter:false,filter: false 
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
                
                if (TS_Show_Loader==true){
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

        //$("#list_table_basedoc").html('').html(var_tableliste_content);
        $('#list_table_basedoc').trigger('updateHeaders');
        $("#list_table_basedoc").trigger("update"); 

        // modify the search input data-column value (swap "0" or "all in this demo)
        $('.selectable').attr( 'data-column', $(this).val() );
        // update external search inputs
        $.tablesorter.filter.bindSearch( $table, $('.search'), false );
        });
        
        //assign the sortStart event
        $("table").bind("sortStart",function() {
            
            if (TS_Show_Loader==true){
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

    function Trigger_Search_Liste(){
        TS_Show_Loader = true;
        $("#list_table_basedoc").trigger("update"); 

        var sorting = [ [0,0] ]; 
        TS_Show_Loader = false;

        $("#list_table_basedoc").trigger("sorton",[sorting]); 

        var sorting = [ [0,1] ]; 
        $("#list_table_basedoc").trigger("sorton",[sorting]); 
    }

    /************************************************************************************************************/
    /* Module : Base documentaire / Global 
    /************************************************************************************************************/

    if (gb_action == "base_documentaire"){
        Init_DataTable_Liste();

        $("#btn_bd_new_document").click(function(ev){ 
            POPUP_FORM_DOC(true); 
            return false;
        });  

        $(document).on('click', '#list_table_basedoc div', function(ev){
        
            $('#id_selected').val(ev.target.id);

            if($('#id_selected').val()!=''){
                Get_Record_Data();
            }else{
                $.alert({
                    title: 'Alerte',
                    content: 'Veuillez sélectionner un document dans la liste.',
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
                return false;
            } 
        }); 

    }

    /************************************************************************************************************/
    /* FICHE 
    /************************************************************************************************************/
    var mandatory_fields_ligne = $("#mandatory_ligne_basedoc").val().split(';');

    var var_doc_titre = '';
    var var_doc_document_nom= '';
    var var_doc_document_type= '';
    var var_doc_date= '';
    var var_doc_extension= '';
    var var_doc_version= '';
    var var_doc_notes= '';
    var var_fakepath= '';

    function POPUP_FORM_DOC($is_new){

        if ($is_new==true){
            $('#titre_popup_basedoc').html('Nouveau document');
            $('#iw_form_popup_child_basedoc .caption i').toggleClass("fa-pencil fa-file");
        }else{
            $('#titre_popup_basedoc').html('Modification du document');
            $('#iw_form_popup_child_basedoc .caption i').toggleClass("fa-file fa-pencil");
        }

        var var_popup = $('#iw_form_popup_basedoc').html();
        $('#iw_form_popup_basedoc').html('');
    
        $.confirm({
            title: '',
            columnClass: 'iw_popup_form iw_popup_form_medium',
            content: '' +
            '<div>' +var_popup+     
            '</div>',
            buttons: {
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
                            Save_Document();

                            $('#iw_form_popup_basedoc').html(var_popup);
                            return true;
                        }

                    }
                },
                cancel: {
                    text: 'Fermer',
                    action: function () {
                        $('#iw_form_popup_basedoc').html(var_popup);
                    }
                },
            },
            onContentReady: function () {
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    e.preventDefault();
                    jc.$$formSubmit.trigger('click'); 
                });

				$("#doc_document").change(function() {
                    var doc = $("#doc_document").get(0).files;
                    $("#fakepath").val('');

                    if (doc.length>0){
                        $("#fakepath").val(doc[0].name);
                        $("#doc_extension").val(getExtension(doc[0].name));
                    }
				});

                $('#doc_date').datepicker({
                    format: 'dd/mm/yyyy'
                });

                if ($is_new==true){
                    $('#doc_date').datepicker('update', getDateData(''));
                }else{
                    $("#doc_titre").attr('value', var_doc_titre);
                    $("#doc_document_nom").attr('value', var_doc_document_nom);
                    $("#doc_document_type > [value='" + var_doc_document_type + "']").attr("selected", "true");
                    $("#doc_extension").attr('value', var_doc_extension);
                    $("#doc_version").attr('value', var_doc_version);
                    $("#doc_notes").attr('value', var_doc_notes);
                    $("#fakepath").attr('value', var_fakepath);
                    $('#doc_date').datepicker('update', getDateData(var_doc_date));
                }
            }
        });

    }

    function Upload_Document($doc,$id_origin){
        var data = new FormData();
        var files = $doc;

        // Add the uploaded file content to the form data collection
        if (files.length > 0) {
            data.append($id_origin, files[0]);

            // Make Ajax request with the contentType = false, and procesDate = false
            var ajaxRequest = $.ajax({
                type: "POST",
                url: "/GL?action=basedoc_save_document&table_name=" + $('#table_name').val() + "&doc_origine_id=" + $('#doc_origine_id').val() + '&doc_name_previous=' + var_fakepath,
                contentType: false,
                processData: false,
                data: data, 
                error: function (xhr, status, error) {

                }
            });

            ajaxRequest.done(function (xhr, textStatus) {
            });

        }

    }

    function Save_Document(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });


        $.LoadingOverlay("show");

        var doc = $("#doc_document").get(0).files;

        var id_document=0;
        var save_status='';

        var data_ligne = {
            "id_piece": $("#record_id").val(),
            "id_ligne": $("#id_selected").val(),
            "doc_titre": $("#doc_titre").val(),
            "doc_document_type": $("#doc_document_type").val(),
            "doc_date": $("#doc_date").val(),
            "doc_extension": $("#doc_extension").val(),
            "doc_version": $("#doc_version").val(),
            "doc_notes": $("#doc_notes").val(),
            "doc_document_nom": $("#fakepath").val().replace("%",""),
            "doc_immeuble_id": $("#doc_immeuble_id").val(),
            "doc_bien_id": $("#doc_bien_id").val(),
            "doc_intervention_id": $("#doc_intervention_id").val()
        }

        var data = { 
            "zone":"gl", 
            "action":"set_bien_ligne",
            "data": {
            "ligne": data_ligne
            }
        };

        var data_json = 'json=' + JSON.stringify(data);
        $.getJSON("/GL?action=basedoc_ligne_valider&table_num=" + $('#table_num').val(), data_json, function(data){  
        
            $.each(data, function(key, value){  
            
                if (key == 'status'){
                    save_status = value;
                }

                if (key == 'id'){
                    id_document = value;
                }

            });

        }).done(function() {//success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            $.LoadingOverlay("hide");

            if (save_status=='success'){
                Upload_Document(doc, id_document);

                if (gb_action=="base_documentaire"){
                    Trigger_Search_Liste();
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

    function Get_Record_Data(){

        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });


        $.LoadingOverlay("show");

        $('#titre_popup_basedoc').html('Modification');

        var data_module = { 
        "id": $('#id_selected').val()
        };

        var data = { 
            "zone":"gl", 
            "action":"get_location_ligne",
            "data": {
            "ligne": data_module
            }
        };

        var data_json = '&json='+JSON.stringify(data);

        var_doc_titre = '';
        var_doc_document_nom= '';
        var_doc_document_type= '';
        var_doc_date= '';
        var_doc_extension= '';
        var_doc_version= '';
        var_doc_notes= '';
        var_fakepath= '';

        $.getJSON("/GL?action=basedoc_get_record",data_json, function(data){  

            $.each(data, function(key, value){ 
                var_doc_titre = value.doc_titre;
                var_doc_document_nom= value.doc_document_nom;
                var_doc_document_type= value.doc_document_type;
                var_doc_date= value.doc_date;
                var_doc_extension= value.doc_extension;
                var_doc_version= value.doc_version;
                var_doc_notes= value.doc_notes;
                var_fakepath= value.doc_document_nom;
            });  
        

        }).done(function() {//success

        })
        .fail(function() { //error

        })
        .always(function() { //complete
            $.LoadingOverlay("hide");
            POPUP_FORM_DOC(false);
        });  

    }

});  