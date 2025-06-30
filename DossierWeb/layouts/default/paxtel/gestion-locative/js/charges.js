/*****************************************************************************/
/*LES CHARGES*/
/*****************************************************************************/
$(document).ready(function() {
    var cha_post_action = $("#cha_post_action").val();
    var cha_get_action = $("#cha_get_action").val();

    Display_Table_Charges();

    var mandatory_fields_ligne = $("#mandatory_ligne_charge").val().split(';');

    var cha_selected_month = '';
	var cha_fin_selected_month = '';

    $("#btn_new_charge").click(function(ev) {
        Nouvelle_Fiche_Charge(ev);

        return false;
    });

    function Display_Table_Charges() {

        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });


        $.LoadingOverlay("show");
        $('#list_table_charges .table').empty();

        var data_specific = {
            "id": $("#record_id").val()
        };

        var data_search = {
            "zone": "gl",
            "action": "get_bien_lignes",
            "data": data_specific
        };

        var data_json = '&json=' + JSON.stringify(data_search);

        $.getJSON("/GL?action=" + cha_get_action, data_json, function(data) {
			$('#list_table_charges .table').empty();

			var resp_table_data = '';

			resp_table_data += '<div class="row header">';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += 'Mois début';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += 'Mois fin';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell iw_second_column" style="min-width: 100px;">';
			resp_table_data += 'Libellé';
			resp_table_data += '</div>';
			resp_table_data += '<div class="cell" style="min-width: 120px;">';
			resp_table_data += 'Montant';
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
					resp_table_data += value.cha_periode;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell" id="' + value.id + '">';
					resp_table_data += value.cha_periode_fin;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell" id="' + value.id + '">';
					resp_table_data += value.cha_libelle;
					resp_table_data += '</div>';
					resp_table_data += '<div class="cell" id="' + value.id + '">';
					resp_table_data += iw_round(value.cha_montant);
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

			$("#list_table_charges .table").append(resp_table_data);

		}).done(function() { //success

		})
		.fail(function() { //error
			Display_Table_Charges();
		})
		.always(function() { //complete
			$.LoadingOverlay("hide");
		});
    }

    function Nouvelle_Fiche_Charge() {
        $('#titre_popup_charge').html('NOUVELLE CHARGE');

        var var_popup = $('#iw_form_popup_charge').html();
        $('#iw_form_popup_charge').html('');

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


                        }else {
                            Save_Record_Line_Charge();
                            $('#iw_form_popup_charge').html(var_popup);

                            return true;
                        }
                    }
                },
                cancel: {
                    text: 'Fermer',
                    action: function() {
                        $('#iw_form_popup_charge').html(var_popup);
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

                $("input[type='checkbox']").on('change', function() {
                    $(this).val(this.checked ? "true" : "false");
                });

                $('#cha_periode').datepicker({
                    "format": "mm-yyyy",
                    'startView': 1,
                    'maxViewMode': 1
                }).on('changeMonth', function(e) {
                    var dp = $(e.currentTarget).data('datepicker');

                    dp.date = e.date;
                    dp.setValue();
                    dp.hide();

                    cha_selected_month = $('#cha_periode').val();
                });

				$("#cha_periode").parent().find(".fa-calendar").click(function() {
                    $('#cha_periode').datepicker('show');
                });

				// Ajout d'une période de fin par Scanu Rémy - remy@connect-io.fr
                $('#cha_periode_fin').datepicker({
                    "format": "mm-yyyy",
                    'startView': 1,
                    'maxViewMode': 1
                }).on('changeMonth', function(e) {
                    var dp = $(e.currentTarget).data('datepicker');

                    dp.date = e.date;
                    dp.setValue();
                    dp.hide();
					
                    cha_fin_selected_month = $('#cha_periode_fin').val();
                });

				$("#cha_periode_fin").parent().find(".fa-calendar").click(function() {
                    $('#cha_periode_fin').datepicker('show');
                });

                $("#cha_libelle").change(function(){
                    var $this = $(this);

                    $.LoadingOverlay("show");

                    $.ajax({
                        type: "GET",
                        url: "/4DACTION/outilsWebManageAccounting",
                        data: {
                            "action": "compteComptable",
                            "charge": $this.val()
                        },
                        success: function (response) {
                            var reponseParse = JSON.parse(response);

                            if (reponseParse.notificationError != null) {

                                $.alert({
                                    title: '',
                                    content: reponseParse.notificationError,
                                    icon: 'fa fa-error',
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
                                $("#cha_account_product").val(reponseParse.compteComptable);
                            }
                            
                            $.LoadingOverlay("hide");
                        }
                    });
                });
            }
        });
    }

    function Save_Record_Line_Charge() {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

        var charge_montant = $("#cha_montant").val().replace(/,/g, '.');

        var data_ligne = {
            "id_piece": $("#record_id").val(),
            "id_ligne": $("#id_selected").val(),
            "cha_date": $("#cha_date").val(),
            "cha_periode": cha_selected_month,
            "cha_periode_fin": cha_fin_selected_month,
            "cha_libelle": $("#cha_libelle").val(),
            "cha_montant": charge_montant,
            "cha_account_product": $("#cha_account_product").val()
        }

        var data = {
            "zone": "gl",
            "action": "set_bien_ligne",
            "data": {
                "ligne": data_ligne
            }
        };

        var data_json = '&json=' + JSON.stringify(data);
        var save_status = '';

        $.getJSON("/GL?action=" + cha_post_action, data_json, function(data) {

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



				Display_Table_Charges();


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

    $("#list_table_charges div").click(function(ev) {

        if (ev.target.id != '') {
            $('#id_selected').val(ev.target.id);
            Get_Record_Data_Charge(ev.target.id);

            var var_popup = $('#iw_form_popup_charge').html();
            $('#iw_form_popup_charge').html('');

            var btn_save_class = '';

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
                                content: 'Voulez-vous vraiment supprimer cette charge ?',
                                icon: 'fa fa-warning',
                                animation: 'scale',
                                closeAnimation: 'zoom',
                                columnClass: 'iw_alert',
                                buttons: {
                                    confirm: {
                                        text: 'Oui',
                                        btnClass: 'btn-orange',
                                        action: function() {
                                            $('#iw_form_popup_charge').html(var_popup);
                                            Remove_Charge();
                                        }
                                    },
                                    cancel: {
                                        text: 'Non',
                                        action: function() {
                                            $('#iw_form_popup_charge').html(var_popup);
                                        }
                                    }
                                }
                            });
                        }
                    },
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
                                Save_Record_Line_Charge();

                                $('#iw_form_popup_charge').html(var_popup);
                                $('#id_selected').val('');

                                return true;
                            }
                        }
                    },
                    cancel: {
                        text: 'Fermer',
                        action: function() {
                            $('#iw_form_popup_charge').html(var_popup);
                            $('#id_selected').val('');
                        }
                    }
                },
                onContentReady: function() {
                    var jc = this;
                    this.$content.find('form').on('submit', function(e) {
                        e.preventDefault();
                        jc.$$formSubmit.trigger('click');
                    });
                    
					$('#cha_periode').datepicker({
						"format": "mm-yyyy",
						'startView': 1,
						'maxViewMode': 1
					}).on('changeMonth', function(e) {
						var dp = $(e.currentTarget).data('datepicker');
	
						dp.date = e.date;
						dp.setValue();
						dp.hide();
	
						cha_selected_month = $('#cha_periode').val();
					});
	
					$("#cha_periode").parent().find(".fa-calendar").click(function() {
						$('#cha_periode').datepicker('show');
					});
					
					// Ajout d'une période de fin par Scanu Rémy - remy@connect-io.fr
					$('#cha_periode_fin').datepicker({
						"format": "mm-yyyy",
						'startView': 1,
						'maxViewMode': 1
					}).on('changeMonth', function(e) {
						var dp = $(e.currentTarget).data('datepicker');
	
						dp.date = e.date;
						dp.setValue();
						dp.hide();
						
						cha_fin_selected_month = $('#cha_periode_fin').val();
					});
	
					$("#cha_periode_fin").parent().find(".fa-calendar").click(function() {
						$('#cha_periode_fin').datepicker('show');
					});

                    $("#cha_libelle").change(function(){
                        var $this = $(this);
    
                        $.LoadingOverlay("show");
    
                        $.ajax({
                            type: "GET",
                            url: "/4DACTION/outilsWebManageAccounting",
                            data: {
                                "action": "compteComptable",
                                "charge": $this.val()
                            },
                            success: function (response) {
                                var reponseParse = JSON.parse(response);
    
                                if (reponseParse.notificationError != null) {
    
                                    $.alert({
                                      title: '',
                                      content: reponseParse.notificationError,
                                      icon: 'fa fa-error',
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
                                    $("#cha_account_product").val(reponseParse.compteComptable);
                                }
                                
                                $.LoadingOverlay("hide");
                            }
                        });
                    });
                }
            });
        }
    });

    function Remove_Charge() {
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
            "action": "gl_remove_charge",
            "data": {
                "data": data_ligne
            }
        };

        var data_json = 'json=' + JSON.stringify(data);

        var operation_status = '';

        $.getJSON("/GL?action=gl_remove_charge", data_json, function(data) {

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
				Display_Table_Charges();
			}
		});
    }

    function Get_Record_Data_Charge($id) {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        });

        $.LoadingOverlay("show");

        $('#titre_popup_charge').html('Modification');

        var data_module = {
            "id": $id
        };

        var data = {
            "zone": "gl",
            "action": "get_bien_ligne",
            "data": {
                "ligne": data_module
            }
        };

        var data_json = '&json=' + JSON.stringify(data);

        $.getJSON("/GL?action=get_charge", data_json, function(data) {

            $.each(data, function(key, value) {
                $("#cha_libelle").attr('value', value.cha_libelle);
                $("#cha_montant").attr('value', iw_round(value.cha_montant));

                cha_selected_month = value.cha_periode;
                cha_fin_selected_month = value.cha_periode_fin;

                $("#cha_periode").val(cha_selected_month);
                $("#cha_periode_fin").val(cha_fin_selected_month);

                $("#cha_account_product").val(value.cha_account_product);

                UTL_Date_Picker_Formatted(getDateData(value.cha_date), '#cha_date');

                $("input[type='checkbox']").on('change', function() {
                    $(this).val(this.checked ? "true" : "false");
                });
            });

        }).done(function() { //success

        })
        .fail(function() { //error
            Get_Record_Data_Charge($id);
        })
        .always(function() { //complete
            $.LoadingOverlay("hide");
        });
    }
});