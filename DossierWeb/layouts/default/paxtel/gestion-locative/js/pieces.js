$(document).ready(function() {
    /*****************************************************************************/
    /*LES PIECES*/
    /*****************************************************************************/
    var pieces_post_action = $("#pieces_post_action").val();
    var pieces_get_action = $("#pieces_get_action").val();

	var records_selected = [];
    var ids_equipements = ""

    var htmlTypeEquipement = "";

	$(document).on('change', '.iw_select', function() {	
        var $idParent_el = $(this).closest(".table").parent().attr("id");

        if ($idParent_el != "list_table_equipements") {
	        var id = extractNumber(this.id);
        }else{
            var id = this.id.substring(this.id.lastIndexOf("_") + 1);
        }

        if ($idParent_el != "list_table_pieces") {

            if (this.checked) {
                records_selected.push(id);
            }else{
                var index = records_selected.indexOf(id);
                records_selected.splice(index, 1);
            }
    
            var counter  = 1;
            ids_equipements = "";
    
            for (var i of records_selected) {
                
                if (counter == 1){
                    ids_equipements = ids_equipements + i;
                }else{
                    ids_equipements = ids_equipements + ';' + i;
                }
                
                counter = counter + 1;
            }

        }

	});

    Display_Table_Pieces();

    var mandatory_fields_ligne = $("#mandatory_ligne_pieces").val().split(';');

    $("#btn_new_piece").click(function(ev) {
        $("#id_selected").val('');

        Nouvelle_Fiche_Piece(ev);
        return false;
    });

    function Display_Table_Pieces() {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

        $('#list_table_pieces .table').empty();

        var data_specific = {
            "id": $("#record_id").val()
        };

        var data_search = {
            "zone": "gl",
            "action": "get_bien_pieces",
            "data": data_specific
        };

        var data_json = '&json=' + JSON.stringify(data_search);

        $.getJSON("/GL?action=" + pieces_get_action, data_json, function(data) {
            $('#list_table_pieces .table').empty();

            var resp_table_data = '';

            resp_table_data += '<div class="row header">';
            resp_table_data += '<div class="cell" style="min-width: 120px;">';
            resp_table_data += '';
            resp_table_data += '</div>';
            resp_table_data += '<div class="cell" style="min-width: 120px;">';
            resp_table_data += 'Nom';
            resp_table_data += '</div>';
            resp_table_data += '<div class="cell" style="min-width: 120px;">';
            resp_table_data += 'Capacité';
            resp_table_data += '</div>';
            resp_table_data += '<div class="cell" style="min-width: 120px;">';
            resp_table_data += 'Superficie';
            resp_table_data += '</div>';
            resp_table_data += '</div>';

            if (data.length > 0) {
                var css_class_row = '';
                var counter = 0;

                $.each(data, function(key, value) {
                    css_class_row = '';

                    if (counter % 2 != 0) {
                        css_class_row += ' iw-alternate';
                    }

                    resp_table_data += '<div class="row body ' + css_class_row + '">';
                    resp_table_data += '<div class="cell" id="' + value.id + '">';
                    resp_table_data += '<input type="checkbox" id="chx_' + value.id +'" name="chx_' + value.id +'" class="iw_select" style="height: 20px!important;text-align:left;margin:0px 5px 0px 0px;" />';
                    resp_table_data += '</div>';
                    resp_table_data += '<div class="cell " id="' + value.id + '">';
                    resp_table_data += value.pie_nom;
                    resp_table_data += '</div>';
                    resp_table_data += '<div class="cell " id="' + value.id + '">';
                    resp_table_data += value.pie_capacite;
                    resp_table_data += '</div>';
                    resp_table_data += '<div class="cell " id="' + value.id + '">';
                    resp_table_data += value.pie_superficie;
                    resp_table_data += '</div>';
                    resp_table_data += '</div>';

                    $('<input>', {
                        type: 'hidden',
                        id: 'id' + value.id,
                        name: 'id' + value.id,
                        value: value.id
                    }).appendTo('#list_table_charges');

                    counter = counter + 1;
                });

            }

            $("#list_table_pieces .table").append(resp_table_data);

        }).done(function() { //success

        })
        .fail(function() { //error

        })
        .always(function() { //complete
            $.LoadingOverlay("hide");
        });
    }

    function Nouvelle_Fiche_Piece() {
        $('#titre_popup_piece').html('Nouvelle pièce');

        var var_popup = $('#iw_form_popup_piece').html();

        $('#iw_form_popup_piece').html('');

        $.confirm({
            title: '',
            content: '' +
                '<div>' + var_popup +
                '</div>',
            buttons: {
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'btn-blue',
                    action: function() {

                        if (Check_Required_Fields(mandatory_fields_ligne)) {
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
                        } else {
                            Save_Record_Line_Piece();

                            $('#iw_form_popup_piece').html(var_popup);

                            return true;
                        }


                    }
                },
                cancel: {
                    text: 'Fermer',
                    action: function() {
                        $('#iw_form_popup_piece').html(var_popup);
                    }
                },
            },
            onContentReady: function() {
                // bind to events
                var jc = this;

                this.$content.find('form').on('submit', function(e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();

                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });

            }
        });


    }

    function Save_Record_Line_Piece() {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

        var data_ligne = {
            "id_piece": $("#record_id").val(),
            "id_ligne": $("#id_selected").val(),
            "pie_nom": $("#pie_nom").val(),
            "pie_capacite": $("#pie_capacite").val(),
            "pie_superficie": $("#pie_superficie").val()
        }

        var data = {
            "zone": "gl",
            "action": "set_bien_piece",
            "data": {
                "ligne": data_ligne
            }
        };

        var data_json = '&json=' + JSON.stringify(data);
        var save_status = '';

        $.getJSON("/GL?action=" + pieces_post_action, data_json, function(data) {

            $.each(data, function(key, value) {
                save_status = value;
            });

        }).done(function() { //success

        })
        .fail(function() { //error

        })
        .always(function() { //complete
            $.LoadingOverlay("hide");

            if (save_status != 'Failed') {
                Display_Table_Pieces();
            } else {

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

    $("#list_table_pieces div").click(function(ev) {

        if (ev.target.id != '' && ev.target.id.includes("chx") == false) {
            $('#id_selected').val(ev.target.id);
            Get_Record_Data_Piece(ev.target.id);

            var var_popup = $('#iw_form_popup_piece').html();
            $('#iw_form_popup_piece').html('');

            var btn_save_class = '';

            $.confirm({
                title: '',
                content: '' +
                    '<div>' + var_popup +
                    '</div>',
                buttons: {
                    formSubmit: {
                        text: 'Enregistrer',
                        btnClass: 'btn-blue ' + btn_save_class,
                        action: function() {

                            if (Check_Required_Fields(mandatory_fields_ligne)) {
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
                            } else {
                                Save_Record_Line_Piece();

                                $('#iw_form_popup_piece').html(var_popup);
                                $('#id_selected').val('');

                                return true;
                            }
                        }
                    },
                    cancel: {
                        text: 'Fermer',
                        action: function() {
                            $('#iw_form_popup_piece').html(var_popup);
                            $('#id_selected').val('');
                        }
                    },
                },
                onContentReady: function() {
                    // bind to events
                    var jc = this;

                    this.$content.find('form').on('submit', function(e) {
                        // if the user submits the form by pressing enter in the field.
                        e.preventDefault();

                        jc.$$formSubmit.trigger('click'); // reference the button and click it
                    });

                }
            });
        }

    });

    function Get_Record_Data_Piece($id) {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

        $('#titre_popup_piece').html('Modification');

        var data_module = {
            "id": $id
        };

        var data = {
            "zone": "gl",
            "action": "get_bien_piece",
            "data": {
                "ligne": data_module
            }
        };

        var data_json = '&json=' + JSON.stringify(data);

        $.getJSON("/GL?action=get_bien_piece", data_json, function(data) {

            $.each(data, function(key, value) {
                $("#pie_nom").attr('value', value.pie_nom);
                $("#pie_capacite").attr('value', value.pie_capacite);
                $("#pie_superficie").attr('value', value.pie_superficie);
            });

        }).done(function() { //success
        })
        .fail(function() { //error
            Get_Record_Data_Piece($id);
        })
        .always(function() { //complete
            $.LoadingOverlay("hide");
        });

    }
    /*****************************************************************************/
    /*END PIECES*/
    /*****************************************************************************/

    /*****************************************************************************/
    /*LES EQUIPEMENTS PAR PIECE*/
    /*****************************************************************************/
    var equ_post_action = 'set_pieces_lk_equ';
    var equ_get_action = 'gl_pieces_equ_list_json';
    console.log("coucou : piece");
    var $ple_date_installation = "";
    var $ple_quantite = "";

    Display_Table_Equipements();

    var mandatory_fields_equipement = $("#mandatory_equipement").val().split(';');

    $("#btn_new_equipement").click(function(ev) {
        POPUP_FORM_EQU(true);

        return false;
    });

    $("#btn_suppr_equipement").click(function(ev) {
		Delete_Selection();
			
		return false;
    });

    $("#btn_suppr_piece").click(function(ev) {
		Delete_Selection_Piece();
			
		return false;
    });

	function Delete_Selection(){

		$.confirm({
			title: 'Equipements',
			content: 'Voulez-vous vraiment supprimer cette sélection des équipements ?',
			icon: 'fa fa-warning',
			animation: 'scale',
			closeAnimation: 'zoom',
			columnClass: 'iw_alert',
			buttons: {
				confirm: {
					text: 'Oui',
					btnClass: 'btn-orange',
					action: function () {
						Delete_Selection_Exec();
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

	function Delete_Selection_Piece(){

		$.confirm({
			title: 'Pièces',
			content: 'Voulez-vous vraiment supprimer cette sélection des pièces ?',
			icon: 'fa fa-warning',
			animation: 'scale',
			closeAnimation: 'zoom',
			columnClass: 'iw_alert',
			buttons: {
				confirm: {
					text: 'Oui',
					btnClass: 'btn-orange',
					action: function () {
						Delete_Selection_Piece_Exec();
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

	function Delete_Selection_Exec(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");
		
		var data_piece = {
			"ids": ids_equipements
		  }

		var data = { 
			"data": data_piece
		};

		var data_json = '&json='+JSON.stringify(data);
		var save_status='';

		$.getJSON("/GL?action=equipements_selection_delete",data_json, function(data){  
		 
			$.each(data, function(key, value){ 
				save_status = value;
			});

		}).done(function() {//success
            
		})
		.fail(function() { //error
		})
		.always(function(response) { //complete
	  		$.LoadingOverlay("hide");
  
            if (response.responseText != 'Failed') {
                Display_Table_Equipements();
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

	function Delete_Selection_Piece_Exec(){
		$.LoadingOverlaySetup({
			background      : "rgba(0, 0, 0, 0.5)",
			imageColor      : "#fff"
		});

		$.LoadingOverlay("show");

        var $ids_t = ""

        $("#list_table_pieces").find("input:checked").map(function() { return extractNumber(this.id); }).get().forEach(function(element, index){

            if (index == 0) {
                $ids_t += element;
            }else{
                $ids_t += ";" + element;
            }

        });

		var data = { 
			"data": {
                "ids": $ids_t
            }
		};

		var data_json = '&json='+JSON.stringify(data).replaceAll(",",";");
		var save_status='';

		$.getJSON("/GL?action=pieces_selection_delete",data_json, function(data){  
		 
			$.each(data, function(key, value){ 
				save_status = value;
			});

		}).done(function() {//success
            
            if (save_status != "") {

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

            }else{
                Display_Table_Pieces();
            }
            
		})
		.fail(function() { //error
		})
		.always(function() { //complete
	  		$.LoadingOverlay("hide");
		});
	}

    function Display_Table_Equipements() {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");
        $('#list_table_equipements .table').empty();

        var data_specific = {
            "request_type": "get_records",
            "id_bien": $("#record_id").val()
        };

        var data_search = {
            "zone": "gl",
            "action": "get_piece_equipements",
            "data": {
                "data": data_specific
            }
        };

        var data_json = 'json=' + JSON.stringify(data_search);

        $.getJSON("/GL?action=" + equ_get_action, data_json, function(data) {
            $('#list_table_equipements .table').empty();

            var resp_table_data = '';

            resp_table_data += '<div class="row header">';
            resp_table_data += '<div class="cell" style="min-width: 120px;">';
            resp_table_data += '';
            resp_table_data += '</div>';
            resp_table_data += '<div class="cell" style="min-width: 120px;">';
            resp_table_data += 'Type de l\'équipement';
            resp_table_data += '</div>';
            resp_table_data += '<div class="cell" style="min-width: 120px;">';
            resp_table_data += 'Nom';
            resp_table_data += '</div>';
            resp_table_data += '<div class="cell" style="min-width: 120px;">';
            resp_table_data += 'Date d\'installation';
            resp_table_data += '</div>';
            resp_table_data += '<div class="cell" style="min-width: 120px;">';
            resp_table_data += 'Quantité';
            resp_table_data += '</div>';
            resp_table_data += '</div>';

            console.log(data);

            if (data.rows.length > 0) {
                var css_class_row = '';
                var counter = 0;

                $.each(data.rows, function(key, value) {
                    css_class_row = '';

                    if (counter % 2 != 0) {
                        css_class_row += ' iw-alternate';
                    }

                    resp_table_data += '<div class="row body ' + css_class_row + '">';
                    resp_table_data += '<div class="cell" id="' + value.uid + '">';
                    resp_table_data += '<input type="checkbox" id="chx_' + value.uid +'" name="chx_' + value.uid +'" class="iw_select" style="height: 20px!important;text-align:left;margin:0px 5px 0px 0px;" />';
                    resp_table_data += '</div>';
                    resp_table_data += '<div class="cell" id="' + value.uid + '">';
                    resp_table_data += value.equipementType;
                    resp_table_data += '</div>';
                    resp_table_data += '<div class="cell" id="' + value.uid + '">';
                    resp_table_data += value.equipementNom;
                    resp_table_data += '</div>';
                    resp_table_data += '<div class="cell" id="' + value.uid + '">';
                    resp_table_data += value.dateInstallation;
                    resp_table_data += '</div>';
                    resp_table_data += '<div class="cell" id="' + value.uid + '">';
                    resp_table_data += value.quantite;
                    resp_table_data += '</div>';
                    resp_table_data += '</div>';


                    counter = counter + 1;
                });
            }

            $("#list_table_equipements .table").append(resp_table_data);
        }).done(function() { //success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            $.LoadingOverlay("hide");
        });
    }

    function POPUP_FORM_EQU($is_new_record) {

        if ($is_new_record == true) {
            $('#titre_popup_equipement').html('Ajouter un équipement');
        } else {
            $('#titre_popup_equipement').html('Modification de l\'équipement');
        }

        var var_popup = $('#iw_form_popup_equipement').html();
        $('#iw_form_popup_equipement').html('');

        $.confirm({
            title: '',
            content: '' +
                '<div>' + var_popup +
                '</div>',
            buttons: {
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'btn-blue',
                    action: function() {

                        if (Check_Required_Fields(mandatory_fields_equipement)) {
                            Mark_All_Required_Fields(mandatory_fields_equipement);

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
                            Save_Record_Line_Equipement();

                            $('#iw_form_popup_equipement').html(var_popup);
                            return true;
                        }
                    }
                },
                cancel: {
                    text: 'Fermer',
                    action: function() {
                        $('#iw_form_popup_equipement').html(var_popup);
                    }
                },
            },
            onContentReady: function() {
                var jc = this;

                this.$content.find('form').on('submit', function(e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();

                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });

                if (htmlTypeEquipement == "") {
                    htmlTypeEquipement = $("#equ_type").html();
                }

                $("#equ_type").html(htmlTypeEquipement);
                $('#equ_type').attr('disabled', false);

                $('#dateinstallation').datepicker({
                    format: 'dd/mm/yyyy'
                });

                if ($is_new_record == true) {
                    $equ_type = "";
                    $equ_nom = "";
                    $ple_date_installation = "";
                    $ple_quantite = "";
                }else {
                    
                    $("#equ_id > [value='" + $equ_nom + "']").attr("selected", "true");

                    if ($ple_date_installation == "") {
                        $("#dateinstallation").datepicker().datepicker("setDate", new Date());
                    } else {
                        UTL_Date_Picker_Formatted($ple_date_installation, '#dateinstallation');
                    }

                    $('#quantite').val($ple_quantite);

                    $('#equ_type').empty();

                    $('#equ_type').append('<option value="' + $equ_type + '" >' + $equ_type + '</option>');
                    $("#equ_type > [value='" + $equ_type + "']").attr("selected", "true");
                    $('#equ_type').attr('disabled', true);
                }

                $("#equ_type").change(function() {
                    DATA_Fill_EQU_Noms();
                });

            }
        });
    }

    function Save_Record_Line_Equipement() {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

        var data_ligne = {
            "id": $("#id_selected").val(),
            "bienID":$("#record_id").val(),
            "ple_equ_type": $('#equ_type option:selected').val(),
            "ple_equ_id": $('#equ_id option:selected').val(),
            "ple_quantite": $("#quantite").val(),
            "ple_date_installation": $("#dateinstallation").val()
        }

        var data = {
            "zone": "gl",
            "action": "set_bien_piece",
            "data": {
                "data": data_ligne
            }
        };

        var data_json = '&json=' + JSON.stringify(data);
        var save_status = '';

        $.getJSON("/GL?action=" + equ_post_action, data_json, function(data) {

            $.each(data, function(key, value) {
                save_status = value;
            });

        }).done(function() { //success

        })
        .fail(function() { //error

        })
        .always(function(response) { //complete
            $.LoadingOverlay("hide");

            if (response.responseText != 'Failed') {
                Display_Table_Equipements();
            } else {

                $.alert({
                    title: 'Erreur',
                    content: 'L\'équipement sélectionné est déjà dans la liste des équipements.',
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

    $("#list_table_equipements div").click(function(ev) {

        if (ev.target.id != '' && ev.target.id.includes("chx") == false) {
            $('#id_selected').val(ev.target.id);

            Get_Record_Data_Equipement(ev.target.id);
        }

    });

    function Get_Record_Data_Equipement($id) {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

        $('#titre_popup_equipement').html('Modification');

        var data_module = {
            "request_type": "get_record",
            "id": $id
        };

        var data = {
            "zone": "gl",
            "action": "get_piece_equipement",
            "data": {
                "data": data_module
            }
        };

        var data_json = 'json=' + JSON.stringify(data);

        $equ_type = "";
        $equ_nom = "";
        $ple_date_installation = "";
        $ple_quantite = "";

        $.getJSON("/GL?action=get_piece_equipement", data_json, function(data) {

            $.each(data.rows, function(key, value) {
                $equ_type = value.equipementType;
                $equ_nom = value.equipementNom;
                $ple_date_installation = value.dateInstallation;
                $ple_quantite = value.quantite;
            });


        }).done(function() { //success
        })
        .fail(function() { //error
            Get_Record_Data_Piece($id);
        })
        .always(function() { //complete
            $.LoadingOverlay("hide");

            POPUP_FORM_EQU(false);
        });

    }

    /*********************************************************/
    function DATA_Fill_EQU_Noms() {
        $('#ple_equ_id').empty();

        var data_specific = {
            "type": $('#equ_type option:selected').val()
        };

        var data_search = {
            "zone": "gl",
            "action": "get_piece_equipements",
            "data": data_specific
        };

        var data_json = 'json=' + JSON.stringify(data_search);

        $.getJSON("/GL?action=gl_equ_noms_list_json", data_json, function(data) {
            console.log(data);
            if (data.length > 0) {
                $('#equ_id').empty();
                $.each(data, function(key, value) {
                    console.log('<option value="' + value.id + '" >' + value.equ_nom + '</option>')
                    //if (UTL_Select_OptionExists(value.id, 'equ_id') == false) {
                        $('#equ_id').append('<option value="' + value.id + '" >' + value.equ_nom + '</option>');
                    //}

                });

            }

        }).done(function() { //success
        })
        .fail(function() { //error 
        })
        .always(function() { //complete
        });
    }
    /*****************************************************************************/
    /*END EQU*/
    /*****************************************************************************/

    // Petite fonction pour extraire les chiffres d'une chaine de caractère
    function extractNumber(string) {
        var matches = string.match(/(\d+)/);

        if (matches) {
            return matches[0];
        }
    };
});