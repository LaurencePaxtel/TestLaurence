var dateFicheCreation_t = "";

var dateFicheCreation_b = false;

var dataTable_o = {};
var hebergementSortie_o = {};

visiteur.forceSetTime = (visiteur.id == "-1")

$(document).ready(function(){
    $.fn.bootstrapSwitch.defaults.onText = 'Oui';
    $.fn.bootstrapSwitch.defaults.offText = 'Non';

    var required_fields = $("#mandatory").val().split(';');

    IW_bootstrapSwitch("hg_enattente");
    IW_bootstrapSwitch("hg_transmis");
    IW_bootstrapSwitch("hg_prisecharge");
    IW_bootstrapSwitch("hg_cloturee");
    IW_bootstrapSwitch("hg_reservation");

    $("#hg_famchef").bootstrapSwitch({

        onSwitchChange:function(event, state) {
            var champ = document.getElementById("hg_famchef");

            if (($('#hg_famchef').bootstrapSwitch('state')) == true){
                champ.setAttribute("value", true);

                $.LoadingOverlaySetup({
                    background      : "rgba(0, 0, 0, 0.5)",
                    imageColor      : "#fff"
                });
    
                $.LoadingOverlay("show");

                $.ajax({
                    type: "GET",
                    url: "/4DACTION/outilsWebGenerateFamCle",
                    data: {
                       "hebergementID": $("#id").val(),
                       "hebergeID": $("#hg_hb_id").val()
                    },
                    success: function (response) {
                        var reponseParse = JSON.parse(response);

                        if (reponseParse.etat == true) {
                            $("#hg_famcle").val(reponseParse["HG_FamCle"]);
                        }

                        $.LoadingOverlay("hide");
                    }
                });
            }else{ 
                champ.setAttribute("value", false);
            
                $.confirm({
                    title: 'Chef de famille',
                    content: 'Voulez-vous vraiment effectuer cette action ?<br/>Vous aller supprimer la clé du lien familial.',
                    icon: 'fa fa-warning',
                    animation: 'scale',
                    closeAnimation: 'zoom',
                    columnClass: 'iw_alert',
                    buttons: {
                        confirm: {
                            text: 'Oui',
                            btnClass: 'btn-orange',
                            action: function () {
                                $('#hg_famcle').val('');
                            }
                        },
                        cancel: {
                            text: 'Non',
                            action: function () {
                                $('#hg_famchef').bootstrapSwitch('toggleState');
                                champ.setAttribute("value", true);
                            }
                        }
                    }
                });
            } 

        }

    });

    var champ = document.getElementById("hg_reservation");

    if ($('#hg_reservation').bootstrapSwitch('state') == true){
        champ.setAttribute("value", true);
        //$("#hg_nuittotal").prop('disabled', false);
        $("#buttonChangerDateFinFiche").show();
    }else{
        champ.setAttribute("value", false);

        //$("#hg_nuittotal").prop('disabled', true);
        $("#buttonChangerDateFinFiche").hide();

        //$("#hg_nuittotal").val("1");
        //changeDateFinText("1");
    } 

    $('input[name="hg_reservation"]').on('switchChange.bootstrapSwitch', function (event, state) {

        if (($('#hg_reservation').bootstrapSwitch('state')) == true){
            champ.setAttribute("value", true);

            //$("#hg_nuittotal").prop('disabled', false);
            $("#buttonChangerDateFinFiche").show();
        }else{ 
            champ.setAttribute("value", false);

            //$("#hg_nuittotal").prop('disabled', true);
            $("#buttonChangerDateFinFiche").hide();

            //$("#hg_nuittotal").val("1");
        }

    });

    $('#btn-ghgt-plateforme').on('click', function () {

        if (parseInt($("#hg_nuitencours").val()) > 1) {
            $.confirm({
                title: 'Changement de plateforme',
                content: 'Veuillez confirmer le changement de plateforme',
                icon: 'fa fa-warning',
                animation: 'scale',
                closeAnimation: 'zoom',
                columnClass: 'iw_alert',
                buttons: {
                    confirm: {
                        text: 'Oui',
                        btnClass: 'btn-orange',
                        action: function () {

                            // Si la fiche est indiqué comme étant "Prise en charge", on indique que "Non"
                            if (($('#hg_reservation').bootstrapSwitch('state')) == true){
                                $('#hg_reservation').bootstrapSwitch('toggleState');
                            }

                            $("#hg_nuitencours").val("1");
                            $("#hg_nuittotal").val("1");

                            var $date_t = longFormatDate(dateJSToJJMMYYYY(addDays(dateToYYYYMMJJ(extraireDate($(".active").first().text())), 0)));
                            $("#date_fin_inclue").text($date_t);

                            $("#hg_famgroupe").val("");
                            $("#hg_plateforme").val("");
                            $("#hg_centrenom").val("");
                        }
                    },
                    cancel: {
                        text: 'Non',
                        function () {
                            
                        }
                    }
                }
            });   
        }
        else{
            $.alert({
                title: 'Erreur',
                content: 'Ce n\'est pas une fiche reportée - c\'est la première nuit en cours !',
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

            return;
        }

    });

    $("#fdp_usager_sortie").click(function(event){
        var $dateFiche_t = extraireDate($(".active").first().text());
        var $label_t = "";

        event.preventDefault();

        if ($("#type_fiche").val() != "J") {

            $.alert({
                title: 'Erreur',
                content: 'Bouton accessible uniquement pour les fiches « Jour »',
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

            return;
        }

        if (($('#hg_famchef').bootstrapSwitch('state')) == false){

            $.alert({
                title: 'Erreur',
                content: 'Veuillez vous rendre sur la fiche du chef de famille pour effectuer la sortie',
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

            return;
        }

        if ($("#hg_autresolutio").val() == "") {

            $.alert({
                title: 'Erreur',
                content: 'Veuillez remplir le champ « ' + $("#hg_autresolutio").closest(".control-group").find("label").first().text() + ' »',
                icon: 'fa fa-warning',
                animation: 'scale',
                closeAnimation: 'scale',
                columnClass: 'iw_alert',
                buttons: {
                    okay: {
                        text: 'Ok',
                        btnClass: 'btn-blue',
                        action: function(){
                            $("#hg_autresolutio").click();
                        }
                    }
                }
            });
        
            return;
        }

        if (Check_Required_Fields(required_fields)){
            Mark_All_Required_Fields(required_fields);

            $(".fdp-invalid").each(function(index){

                if ($(this).val() == "") {
                    $label_t += $(this).closest(".control-group").find("label").html() + ", ";
                }
                
            });

            if ($label_t != "") {
                $label_t = $label_t.substring(0,$label_t.length - 2);
            }

            $.alert({
                title: 'Champs obligatoires!',
                content: 'Vous devez remplir tous les champs obligatoires (' + $label_t + ") !",
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

            return;
        }

        $.confirm({
            title: 'Sortie',
            content: 'La date de sortie est-elle celle de la fiche ouverte ("' + $dateFiche_t + '") cliquez sur « Oui », si c\'est le lendemain cliquez sur « Non » ?',
            icon: 'fa fa-warning',
            animation: 'scale',
            closeAnimation: 'zoom',
            columnClass: 'iw_alert',
            buttons: {
                confirm: {
                    text: 'Oui',
                    btnClass: 'btn-green',
                    action: function () {
                        hebergementExitConfirmation($dateFiche_t);
                    }
                },
                cancel: {
                    text: 'Non',
                    btnClass: 'btn-red',
                    action: function () {
                        hebergementExitConfirmation(dateJSToJJMMYYYY(addDays(dateToYYYYMMJJ($dateFiche_t), 1)));
                    }
                }
            }
        });

    });

    $('#fdp_usager_valider').on('click', function () {
        var $label_t = "";
        var $continue_b = true;
        
        if (Check_Required_Fields(required_fields)){
            Mark_All_Required_Fields(required_fields);

            $(".fdp-invalid").each(function(index){

                if ($(this).val() == "") {
                    $label_t += $(this).closest(".control-group").find("label").html() + ", ";
                }
                
            });

            if ($label_t != "") {
                $label_t = $label_t.substring(0,$label_t.length - 2);
            }

            $.alert({
                title: 'Champs obligatoires!',
                content: 'Vous devez remplir tous les champs obligatoires (' + $label_t + ") !",
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

            // Modifié par : Scanu Rémy (18/07/2023)
            // Ajout contrôle de cohérence
            if (visiteur.societe.SO_PlateformeMulti == true) {
                var $plateformeService_t = $("#hg_famgroupe").val().substring(0, 2);
                var $plateforme_t = $("#hg_plateforme").val().substring(0, 2);
                var $plateformeHebergement_t = $("#hg_centrenom").val().substring(0, 2);

                if ($plateformeService_t != $plateforme_t || $plateformeService_t != $plateformeHebergement_t) {
                    $continue_b = false;
                }
            }

            if ($continue_b == true) {
                $.LoadingOverlaySetup({
                    background      : "rgba(0, 0, 0, 0.5)",
                    imageColor      : "#fff"
                });
    
                $.LoadingOverlay("show");
    
                var data_hebergement_cle = { 
                    "hg_referenceid": $("#hg_referenceid").val(),
                    "hg_coordinateur": $("#hg_coordinateur").val(),
                    "hg_regulateur": $("#hg_regulateur").val(),
                    "hg_permanencier": $("#hg_permanencier").val(),
                    "hg_maraude1_1": $("#hg_maraude1_1").val(),
                    "hg_signalement": $("#hg_signalement").val(),
                    "hg_codepostal": $("#hg_codepostal").val(),
                    "hg_gare": $("#hg_gare").val(),
                    "hg_metro": $("#hg_metro").val(),
                    "hg_emplacement": $("#hg_emplacement").val(),
                    "hg_lien": $("#hg_lien").val(),
                    "hg_hb_id": $("#hg_hb_id").val(),
                    "hg_etatcivil": $("#hg_etatcivil").val(),
                    "hg_nationalite": $("#hg_nationalite").val(),
                    "hg_situfamille": $("#hg_situfamille").val(),
                    "hg_piecesidte1": $("#hg_piecesidte1").val(),
                    "hg_piecesidte2": $("#hg_piecesidte2").val(),
                    "hg_piecesidte3": $("#hg_piecesidte3").val(),
                    "hg_tempserrance": $("#hg_tempserrance").val(),
                    "hg_dernierheber": $("#hg_dernierheber").val(),
                    "hg_situprofess": $("#hg_situprofess").val(),
                    "hg_dernieremploi": $("#hg_dernieremploi").val(),
                    "hg_duresanemploi": $("#hg_duresanemploi").val(),
                    "hg_rupmajeur1": $("#hg_rupmajeur1").val(),
                    "hg_rupmajeur2": $("#hg_rupmajeur2").val(),
                    "hg_rupmajeur3": $("#hg_rupmajeur3").val(),
                    "hg_niveauetude": $("#hg_niveauetude").val(),
                    "hg_ressources1": $("#hg_ressources1").val(),
                    "hg_ressources2": $("#hg_ressources2").val(),
                    "hg_ressources3": $("#hg_ressources3").val(),
                    "hg_suivisocial1": $("#hg_suivisocial1").val(),
                    "hg_suivisocial2": $("#hg_suivisocial2").val(),
                    "hg_suivisocial3": $("#hg_suivisocial3").val(),
                    "hg_couvsocial1": $("#hg_couvsocial1").val(),
                    "hg_couvsocial2": $("#hg_couvsocial2").val(),
                    "hg_couvsocial3": $("#hg_couvsocial3").val(),
                    "hg_orientation1": $("#hg_orientation1").val(),
                    "hg_orientation1suite": $("#hg_orientation1suite").val(),
                    "hg_orientation2": $("#hg_orientation2").val(),
                    "hg_centrenom": $("#hg_centrenom").val(),
                    "hg_montant": $("#hg_montant").val(),
                    "hg_lc_id" : $("#hg_centrenom_id").val(),
                    "hg_enattente": $("#hg_enattente").val(),
                    "hg_transmis": $("#hg_transmis").val(),
                    "hg_prisecharge": $("#hg_prisecharge").val(),
                    "hg_cloturee": $("#hg_cloturee").val(),
                    "hg_assistsocial": $("#hg_assistsocial").val(),
                    "hg_autresolutio": $("#hg_autresolutio").val(),
                    "hg_reservation": $("#hg_reservation").val(),
                    "hg_nuitencours": $("#hg_nuitencours").val(),
                    "hg_nuittotal":  $("#hg_nuittotal").val(),
                    "hg_dateentree": $("#hg_dateentree").val(),
                    "hg_maraude2_1": $("#hg_maraude2_1").val(),
                    "hg_maraude2_2": $("#hg_maraude2_2").val(),
                    "hg_maraude3_1": $("#hg_maraude3_1").val(),
                    "hg_datesortie": $("#hg_datesortie").val(),
                    "hg_famgroupe": $("#hg_famgroupe").val(),
                    "hg_famchef": $("#hg_famchef").val(),
                    "hg_famcle": $("#hg_famcle").val(),
                    "hg_famnbpers": $("#hg_famnbpers").val(),
                    "hg_famnbjour": $("#hg_famnbjour").val(),
                    "hg_famnbchambre": $("#hg_famnbchambre").val(),
                    "hg_famprixjour": $("#hg_famprixjour").val(),
                    "hg_famtotal":  $("#hg_famtotal").val(),
                    "hg_famcasspec": $("#hg_famcasspec").val(),
                    "hg_famdistri1": $("#hg_famdistri1").val(),
                    "hg_famdistri2": $("#hg_famdistri2").val(),
                    "hg_famdistri3": $("#hg_famdistri3").val(),
                    "hg_famdistri4": $("#hg_famdistri4").val(),
                    "hg_famdistri5": $("#hg_famdistri5").val(),
                    "hg_famdistri1m": $("#hg_famdistri1m").val(),
                    "hg_famdistri2m": $("#hg_famdistri2m").val(),
                    "hg_famdistri3m": $("#hg_famdistri3m").val(),
                    "hg_famdistri4m": $("#hg_famdistri4m").val(),
                    "hg_famdistri5m": $("#hg_famdistri5m").val(),
                    "hg_autresolsuite": $("#hg_autresolsuite").val(),
                    "hg_participation": $("#hg_participation").val(),
                    "hg_dossiersiao": $("#hg_dossiersiao").val(),
                    "hg_commentaires": $("#hg_commentaires").val(),
                    "ve_famh": $("#ve_famh").val(),
                    "ve_famf": $("#ve_famf").val(),
                    "ve_famfe": $("#ve_famfe").val(),
                    "ve_famemi": $("#ve_famemi").val(),
                    "ve_famema": $("#ve_famema").val(),
                    "ve_fampmi": $("#ve_fampmi").val(),
                    "ve_fampma": $("#ve_fampma").val(),
                    "hg_nuit": $("#type_fiche").val(),
                    "hg_plateforme": $("#hg_plateforme").val(),
                    "fiche_type_action": $("#fiche_type_action").val(),
                    "fiche_numero": $("#fiche_numero").val(),
                    "id": $("#id").val(),
                    "ref_structure": $("#ref_structure").val()
                };
    
                // Modifié par : Scanu Rémy (07/11/2022)
                if (dateFicheCreation_b == true || visiteur.forceSetDate != null) {
                    data_hebergement_cle["hg_date"] = dateFicheCreation_t;
                }

                // Modifié par : Scanu Rémy (01/03/2024)
                if (visiteur.forceSetTime != null) {
                    data_hebergement_cle["hg_heureappel"] = $("#heureFiche").text();
                }

                if (visiteur.reportManuel == true) {
                    data_hebergement_cle["reportManuelDate"] = visiteur.reportManuelDate;
                }
    
                var data = { 
                    "zone":"heberge", 
                    "action":"set_hebergement_cle",
                    "data": {
                        "hebergement_cle": data_hebergement_cle
                    }
                };
                var dataPost = {}
                dataPost.json = data ;
                dataPost.action = "usager_fiche_valider";

                var data_json = '&json=' + JSON.stringify(data);
                var save_status='';

                $.post("/INT?", JSON.stringify(dataPost), function(data){
                    console.log(data);
                    save_status = data.status;

                    if (data.notificationError != null) {
                        $.alert({
                            title: '',
                            content: data.notificationError,
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
                    }
                }, "json")
                .done(function() {//success
                })
                .fail(function() { //error
                })
                .always(function() { //complete
                    $.LoadingOverlay("hide");
                    Mark_All_Required_Fields(required_fields);
    
                    if (save_status == 'success'){

                        if (hebergementSortie_o.confirmation != null) {
                            hebergementExit(hebergementSortie_o.sortieTousMembresFamille);
                            return;
                        }
    
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
                                    action: function(){

                                        setTimeout(() => {
                                            window.location.href = 'home';
                                        }, 1500);

                                    }
                                }
                            }
                        });
                                
                    }

                });    
            }else{

                $.alert({
                    title: 'Erreur',
                    content: 'Il y a un problème de cohérence entre la plateforme "Centre hébergement", "Service" et "Plateforme", impossible de valider !',
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

        }

    });

    $('#fdp_usager_quitter').click(function() {
        window.close();
        return false;
    });

    $('#fdp_usager_actions').on('click', function () {
        var var_notes = $('#iw_notes_actions').html();
        $('#iw_notes_actions').html('');

        $.confirm({
            title: '',
            content: '' +
            '<div>' +var_notes+     
            '</div>',
            buttons: {
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'btn-blue',
                    action: function () {
                        Save_Note_Actions();

                        $('#iw_notes_actions').html(var_notes);
                        return true;
                    }
                },
                cancel: {
                    text: 'Fermer',
                    action: function () {
                        $('#iw_notes_actions').html(var_notes);
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

        return false;
    });

    $('#fdp_usager_af').on('click', function () {
        var var_notes = $('#iw_notes_af').html();

        $('#iw_notes_af').html('');

        $.confirm({
            title: '',
            content: '' +
            '<div>' +var_notes+     
            '</div>',
            buttons: {
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'btn-blue',
                    action: function () {

                            Save_Note_AF();

                            $('#iw_notes_af').html(var_notes);

                        return true;
                    }
                },
                cancel: {
                    text: 'Fermer',
                    action: function () {
                        $('#iw_notes_af').html(var_notes);
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

        return false;
    });

    $('#fdp_usager_notes').on('click', function () {
        var var_notes = $('#iw_notes').html();

        $('#iw_notes').html('');

        $.confirm({
            title: '',
            columnClass: 'iw_popup_form',
            content: '' +
            '<div>' + var_notes +     
            '</div>',
            buttons: {
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'btn-blue',
                    btnClass: 'iw_btn_right',
                    action: function () {
                        Save_Notes();

                        $('#iw_notes').html(var_notes);
                        return true;
                    }
                },
                cancel: {
                    text: 'Fermer',
                    btnClass: 'iw_btn_right',
                    action: function () {
                        $('#iw_notes').html(var_notes);
                    }
                }
                /*,
                date_hour_user: {
                    text: 'Date - Heure - Utilisateur',
                    btnClass: 'iw_btn_left',
                    action: function () {

                        if ($('.tab-pane.active textarea:first').is(':disabled')==false){
                            var dt = new Date();
                            var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();

                            var $date = pad(dt.getDate(),2)+ "/"+pad((dt.getMonth()+1),2)+"/"+ dt.getFullYear();
                            var $heure = time;
                            var $utilisateur = $('#utilisateur').val();

                            var $texte = $date +' - '+$heure+' - '+$utilisateur;

                            var p = $('.tab-pane.active textarea:first');

                            console.log(p);

                            p.val(p.val()+"\n"+$texte);
                        }

                        return false;
                    } 
                },
                trait: {
                    text: 'Trait',
                    btnClass: 'iw_btn_left',
                    action: function () {

                        if ($('.tab-pane.active textarea:first').is(':disabled')==false) {
                            var $trait = "\n**************************************************************************";

                            var p = $('.tab-pane.active textarea:first');

                            console.log(p);

                            p.val(p.val()+$trait);
                        }

                        return false;
                    }
                }*/
            },
            onContentReady: function () {
                // bind to events
                var jc = this;
                this.$content.find('form').on('submit', function (e) {
                    // if the user submits the form by pressing enter in the field.
                    e.preventDefault();

                    jc.$$formSubmit.trigger('click'); // reference the button and click it
                });

                Get_Heberge_Data();
				$('#modifDemandeur').on('click', function () {

					if ($(this).is(':checked')) {
						switchEnabledMultipleElement(["#nomHB", "#prenomHB", "#dateNaissanceHB"], false);
					}else{
						switchEnabledMultipleElement(["#nomHB", "#prenomHB", "#dateNaissanceHB"], true);
					}

				});
            }
        });

        return false;
    });

    function pad (str, max) {
        str = str.toString();
        
        return str.length < max ? pad("0" + str, max) : str;
    }

    $('#fdp_usager_sp').on('click', function () {
        var var_notes = $('#iw_notes_sp').html();
        $('#iw_notes_sp').html('');

        $.confirm({
            title: '',
            content: '' +
            '<div>' +var_notes+     
            '</div>',
            buttons: {
                formSubmit: {
                    text: 'Enregistrer',
                    btnClass: 'btn-blue',
                    action: function () {
                        Save_Notes_SP();

                        var_notes = $('#iw_notes_sp_child').html();

                        $("#iw_notes_sp").prepend("<div id='iw_notes_sp_child'></div>");
                        $('#iw_notes_sp_child').html(var_notes);

                        return true;
                    }
                },
                cancel: {
                    text: 'Fermer',
                    action: function () {
                        var_notes = $('#iw_notes_sp_child').html();

                        $("#iw_notes_sp").prepend("<div id='iw_notes_sp_child'></div>");
                        $('#iw_notes_sp_child').html(var_notes);
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

                $('.datepicker').datepicker({
                    format: 'dd/mm/yyyy'
                });

                $("input[type='checkbox']").on('change', function(){
                    $(this).val(this.checked ? "true" : "false");
                })

                $("#iw_notes_sp_child .search").change(function() { 
                    var id = $(this).attr('id');

                    document.getElementById(id).setAttribute("value", $(this).val());
                }); 


                $("#iw_notes_sp_child .iw_checkbox_wt").change(function() { 
                    var id = $(this).attr('id');

                    if (document.getElementById(id).checked){
                        document.getElementById(id).setAttribute("checked", "true");
                    }else{
                        document.getElementById(id).setAttribute("checked", "false");
                    }
                }); 


            }
        });

        return false;
    });

    Mark_All_Required_Fields(required_fields);

    function Save_Notes(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var data_heberge = { 
            "hg_hb_id": $("#hg_hb_id").val(),  
            "adresse1": $("#adresse1").val(), 
            "adresse2": $("#adresse2").val(), 
            "adresse3": $("#adresse3").val(), 
            "codePostal": $("#codePostal").val(), 
            "ville": $("#ville").val(),
            "nom": $("#nomHB").val(),
            "prenom": $("#prenomHB").val(),
            "dateNaissance": dateToJJMMYYYY($("#dateNaissanceHB").val()),
            "lieuNaissance": $("#lieuNaissanceHB").val(),
            "nationalite": $("#nationaliteHB").val(),
            "numCNI": $("#numCNIHB").val(),
            "numPassport": $("#numPassportHB").val(),
            "email": $("#emailHB").val(), 
            "telephone": $("#telephoneHB").val()
        };

        var data = { 
            "zone":"heberge", 
            "action":"set_heberge",
            "data": {
                "heberge": data_heberge
            }
        };

        var data_json = '&json='+JSON.stringify(data);

        $.getJSON("/home_coordonnees_valider",data_json, function(data){  
        }).done(function() {//success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            location.reload();
            $.LoadingOverlay("hide");
        });  
    }

    function Save_Notes_SP(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });


        $.LoadingOverlay("show");
        var data_heberge = { 
            "id": $("#id").val(), 
            "hg_hb_id": $("#hg_hb_id").val(), 
            "hb_cas1": $("#hb_cas1").val(), 
            "hb_cas2": $("#hb_cas2").val(), 
            "hb_cas3": $("#hb_cas3").val(), 
            "hb_cas4": $("#hb_cas4").val(), 
            "hb_cas5": $("#hb_cas5").val(), 
            "hb_cas6": $("#hb_cas6").val(), 
            "hb_cas7": $("#hb_cas7").val(),
            "hb_cas8": $("#hb_cas8").val(),
            "hb_cas9": $("#hb_cas9").val(),
            "hb_cas10": $("#hb_cas10").val(),
            "hb_casdt1": $("#hb_casdt1").val(),
            "hb_casdt2": $("#hb_casdt2").val(),
            "hb_casdt3": $("#hb_casdt3").val(),
            "hb_casdt4": $("#hb_casdt4").val(),
            "hb_casdt5": $("#hb_casdt5").val(),
            "hb_casdt6": $("#hb_casdt6").val(),
            "hb_casdt7": $("#hb_casdt7").val(),
            "hb_casdt8": $("#hb_casdt8").val(),
            "hb_casdt9": $("#hb_casdt9").val(),
            "hb_casdt10": $("#hb_casdt10").val(),
            "hb_caslib1": $("#hb_caslib1").val(),
            "hb_caslib2": $("#hb_caslib2").val(),
            "hb_caslib3": $("#hb_caslib3").val(),
            "hb_caslib4": $("#hb_caslib4").val(),
            "hb_caslib5": $("#hb_caslib5").val(),
            "hb_caslib6": $("#hb_caslib6").val(),
            "hb_caslib7": $("#hb_caslib7").val(),
            "hb_caslib8": $("#hb_caslib8").val(),
            "hb_caslib9": $("#hb_caslib9").val(),
            "hb_caslib10": $("#hb_caslib10").val()
        };

        var data = { 
            "zone":"heberge", 
            "action":"set_heberge",
            "data": {
                "heberge": data_heberge
            }
        };

        var data_json = '&json='+JSON.stringify(data);

        $.getJSON("/home_sp_valider",data_json, function(data){  
            

        }).done(function() {//success

        })
        .fail(function() { //error

        })
        .always(function() { //complete
            location.reload();

            $.LoadingOverlay("hide");
        });

    }

    function Save_Note_Actions(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });
    
        $.LoadingOverlay("show");

        var data_heberge = { 
            "id": $("#id").val(), 
            "hg_hb_id": $("#hg_hb_id").val(), 
            "hg_actions": $("#hg_actions").val()
        };

        var data = { 
            "zone":"heberge", 
            "action":"set_heberge",
            "data": {
                "heberge": data_heberge
            }
        };

        var data_json = '&json='+JSON.stringify(data);

        $.getJSON("/home_note_actions_valider",data_json, function(data){  
        }).done(function() {//success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            location.reload();
            $.LoadingOverlay("hide");
        });
    }

    function Save_Note_AF(){
        $.LoadingOverlaySetup({
            background      : "rgba(0, 0, 0, 0.5)",
            imageColor      : "#fff"
        });

        $.LoadingOverlay("show");

        var data_heberge = { 
            "id": $("#id").val(), 
            "hg_hb_id": $("#hg_hb_id").val(), 
            "hb_actionsf": $("#hb_actionsf").val()
        };

        var data = { 
            "zone":"heberge", 
            "action":"set_heberge",
            "data": {
                "heberge": data_heberge
            }
        };

        var data_json = '&json='+JSON.stringify(data);

        $.getJSON("/home_note_af_valider",data_json, function(data){  
        }).done(function() {//success
        })
        .fail(function() { //error
        })
        .always(function() { //complete
            location.reload();
            $.LoadingOverlay("hide");
        });  

    }

    $("input[type='checkbox']").on('change', function(){
        $(this).val(this.checked ? "true" : "false");
    });

    // Un peu de mise en forme
    $(document.getElementById('clé de lien familial')).append("&nbsp;<i id=\"buttonLienFamille\" class=\"fa fa-list cursor-pointeur\"></i>");
    $(".cursor-pointeur").css({"cursor":"pointer"});

    $(document.getElementById('date_fin_inclue')).append("&nbsp;<i id=\"buttonChangerDateFinFiche\" class=\"fa fa-edit cursor-pointeur\"></i>");

    // Sur clic du bouton juste à côté de "Chef de famille"
    $("#buttonLienFamille").click(function(){

        if (($('#hg_famchef').bootstrapSwitch('state')) == false){
            $("#modalLienFamille").modal('show');
        }else{

            $.alert({
                title: 'Champs obligatoires!',
                content: 'L\'hébergé ne doit pas être indiqué en tant que chef de famille avant de pouvoir utiliser ce bouton !',
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

        }
        
    });

    // A la fin du chargement complet du modal
    $('#modalLienFamille').on('shown', function (e) {
        $(".modal").css("margin-left", "");

        if (window.innerWidth > 991) {
            $(".modal").css({"margin-left": "-505px"});
        }

        $('#tabToDelete').remove();
        $( "#tabInsertAfter" ).after( "<div id=\"tabToDelete\"> <table id=\"example\" class=\"table table-striped table-bordered\" style=\"width:100%\"><thead> <tr> <th>ID</th> <th>Clé du demandeur</th> <th>Clé de lien familial</th> </tr></thead></table></div>" );

        dataTable_o = {
            "hgID": $("#id").val(),
            "serverSide": 0,
            "cleLienFamilial": $("#hg_famcle").val()
        };

        var tableau = $('#example').DataTable({
            "dom": '<"rowB"<"col-12"B><"col-xl-6 col-md-6 col-12"i><"col-xl-6 col-md-6 col-12 g-pt-10"f>>t<"rowB"<"col-xl-6 col-md-6 col-12"l><"col-xl-6 col-md-6 col-12"p>>',
            buttons: [
                {
                    text: 'Tout afficher',
                    className: 'fdp_Button fdp_btn_top iw_button_blue iw_margin_left_5px iw_float_right',
                    attr:  {
                      id: 'toutAfficher'
                    }
                },
              ],
            "select": {
                style: 'single'
            },
            "language": {
                "sProcessing": "Traitement en cours...",
                "sSearch": "Rechercher dans le tableau&nbsp;:",
                "sLengthMenu": "Afficher _MENU_ &eacute;l&eacute;ments",
                "sInfo": "Affichage de l'&eacute;l&eacute;ment _START_ &agrave; _END_ sur _TOTAL_ &eacute;l&eacute;ments (accessible(s))",
                "sInfoEmpty": "Affichage de l'&eacute;l&eacute;ment 0 &agrave; 0 sur 0 &eacute;l&eacute;ment (accessible(s))",
                "sInfoFiltered": "(filtr&eacute; de _MAX_ &eacute;l&eacute;ments au total)",
                "sInfoPostFix": "",
                "sLoadingRecords": "Chargement en cours...",
                "sZeroRecords": "Aucun &eacute;l&eacute;ment &agrave; afficher",
                "sEmptyTable": "Aucune donn&eacute;e disponible dans le tableau",
                "oPaginate": {
                    "sFirst": "Premier",
                    "sPrevious": "Pr&eacute;c&eacute;dent",
                    "sNext": "Suivant",
                    "sLast": "Dernier"
                },
                "oAria": {
                    "sSortAscending": ": activer pour trier la colonne par ordre croissant",
                    "sSortDescending": ": activer pour trier la colonne par ordre d&eacute;croissant"
                },
                "select": {
                    "rows": {
                        _: "%d lignes séléctionnées",
                        0: "Aucune ligne séléctionnée",
                        1: "1 ligne séléctionnée"
                    }
                },
                "buttons": {
                    "copyTitle": 'Ajouté au presse-papiers',
                    "copyKeys": 'Appuyez sur <i>ctrl</i> ou <i>\u2318</i> + <i>C</i> pour copier les données du tableau à votre presse-papiers. <br><br>Pour annuler, cliquez sur ce message ou appuyez sur Echap.',
                    "copySuccess": {
                      _: '%d lignes copiées',
                      1: '1 ligne copiée'
                    }
                }
            },
            "lengthMenu": [[10, 25, 50, 100, 500, -1], [10, 25, 50, 100, 500, "Tout"]],
            "aaSorting": [],
            // Il s'agit ici des datas en chargement de la page.
            "ajax": {
                "url": "/4DACTION/outilsWebSearchFamCle",
                "data": function ( d ) {
                    console.log(dataTable_o);
                    return dataTable_o;
                },
                beforeSend: function(){

                    // Ajout d'un message de loading en attendant que la requête ajax soit finie (S'EXECUTE A CHAQUE FOIS)
                    $('#example > tbody').html(
                        '<tr class="odd">' +
                        '<td valign="top" colspan="6" class="dataTables_empty"><i class="fa fa-spinner fa-spin fa-2x fa-fw"></i> Chargement en cours...</td>' +
                        '</tr>'
                    );
        
                }
            },
            "rowCallback": function( row, data ) {
                console.log(data);
                $(row).addClass("cursor");
            }
        });

        // Bouton Tout afficher
        $("#toutAfficher").click(function() {
            dataTable_o = {
                "hgID": $("#id").val(),
                "serverSide": 0,
                "cleLienFamilial": ""
            }

            tableau.ajax.reload();
        });

        $("#modalLienFamilleButtonValid").click(function(){
            
            if ($(".selected").length > 0) {
                $("#hg_famcle").val($(".selected").find("td:eq(2)").text());    
                $("#modalLienFamille").modal('hide');
            }
            
        });
    });

    $('#modalLienFamille').on('hidden', function (e) {
        $(".modal").css({"margin-left": "-280px"});
    });

    // Sur clic du bouton pour changer date de la fiche
    $("#buttonChangerDateHeureFiche").click(function(){

        $.confirm({
            title: 'Confirmation',
            content: 'Souhaitez-vous modifier la date de la fiche ou l\'heure ?',
            icon: 'fa fa-warning',
            animation: 'scale',
            closeAnimation: 'zoom',
            columnClass: 'iw_alert',
            buttons: {
                confirm: {
                    text: 'Modifier la date',
                    btnClass: 'btn-green',
                    action: function () {

                        if (visiteur.modifDateFiche == true) {
                            visiteur.forceSetDate = true;
                            setHebergementDate();
                        }else{

                            $.alert({
                                title: 'Erreur',
                                content: 'Vous ne disposez pas des privilèges d\'accès à cette fonction',
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

                        }

                    }
                },
                button: {
                    text: 'Modifier l\'heure',
                    btnClass: 'btn-blue',
                    action: function () {
                        setHebergementTime();
                    }
                },
                cancel: {
                    text: 'Annuler',
                    btnClass: 'btn-red',
                    action: function () {
    
                    }
                }
            }
        });

    });

    // Sur clic du bouton pour changer date de fin de la fiche
    $("#buttonChangerDateFinFiche").click(function(){
        setHebergementDateFin();
    });

    $("#hg_nuittotal").change(function(){
        changeDateFinText($(this).val());
    });

    $("#hg_famgroupe").change(function(){
        var $this = $(this);

        if (visiteur.id == "-1") {
            // Modifié par Scanu Rémy - 20/02/2024
            // $("#hg_plateforme").val($this.val().substring(0, 2));
        }

    });

    document.getElementById("hebergePhoneEdit").addEventListener("input", function() {
        console.log(document.getElementById("hebergePhoneEdit").innerText);

        if (estNumeroTelephone(document.getElementById("hebergePhoneEdit").innerText, "FR") == true || document.getElementById("hebergePhoneEdit").innerText == "") {
            $.LoadingOverlay("show");
    
            var data = {
                "table": "HeBerge",
                "champRecherche": "HB_ReferenceID",
                "enregistrementID": $("#hg_hb_id").val(),
                "data": {
                    'HB_Telephone': document.getElementById("hebergePhoneEdit").innerText
                }
            };
    
            $.getJSON("/4DACTION/outilsWebtableEdit", '&json='+JSON.stringify(data), function(response){
                console.log(response);
    
                if (response.notificationError != null) {
        
                    $.alert({
                      title: '',
                      content: response.notificationError,
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

                }

            }).done(function() {//success
            })
            .fail(function() { //error
            })
            .always(function() { //complete
                $.LoadingOverlay("hide");
            });  

        }

    }, false);

    // Ajouté par Scanu Rémy : (01/03/2024)
	$('#fdp_usager_nouvellesNotes').on('click', function () {
        $("#modalNouvelleNote").modal('show');		
        return false;
	});

    // A la fin du chargement complet du modal
    $('#modalNouvelleNote').on('shown', function (e) {
		$(".modal").css("margin-left", "");

		if (window.innerWidth > 991) {
			$(".modal").css({"margin-left": "-505px"});
		}

		$("#modalNouvelleNote").find(".modal-title").text("Note de " + $("#hb_cle").val());
		chargeValueInSelect("typeNote", "/4DACTION/outilsWebHebergeListeAjax", {"hebergeID": $('#hg_hb_id').val(),"action": "chargeTypeNote"});
		updateDataTableNote({
			"hebergeID": $('#hg_hb_id').val(),
			"action": "chargeNote",
			"typeNote": $("#typeNote").val(),
			"keyword": $("#keyword").val(),
			"dateDu": dateToJJMMYYYY($("#noteDu").val()),
			"dateAu": dateToJJMMYYYY($("#noteAu").val())
		});
	});

    // Ajouté par Scanu Rémy : (29/05/2024)
    $('#fdp_usager_report_manuel').on('click', function () {
        //var $dateReport_d = new Date(visiteur.entity.HG_RéservationDateFin);
        var $dateReport_d = new Date(addDays(dateToYYYYMMJJ(extraireDate($(".active").first().text())), parseInt($("#hg_nuittotal").val()) - parseInt($("#hg_nuitencours").val())));
        var $dateFiche_d = new Date(dateToYYYYMMJJ(extraireDate($(".active").first().text())));

        if (visiteur.societe.SO_ReportManuelToday == true) {
            
            if ($dateReport_d >= new Date()) {
                $dateReport_d = new Date();
            }

        }

        switch (true) {
            case ($dateFiche_d < $dateReport_d):
                
                $.confirm({
                    title: 'Confirmation',
                    content: 'Souhaitez-vous vraiment reporter la fiche jusqu\'au ' + dateJSToJJMMYYYY($dateReport_d) + ' ?',
                    icon: 'fa fa-warning',
                    animation: 'scale',
                    closeAnimation: 'zoom',
                    columnClass: 'iw_alert',
                    buttons: {
                        confirm: {
                            text: 'Oui',
                            btnClass: 'btn-green',
                            action: function () {
                                visiteur.reportManuel = true;
                                visiteur.reportManuelDate = dateJSToJJMMYYYY($dateReport_d);
                            }
                        },
                        cancel: {
                            text: 'Non',
                            btnClass: 'btn-red',
                            action: function () {
            
                            }
                        }
                    }
                });

                break;

            case (visiteur.societe.SO_ReportManuelToday == true):

                $.alert({
                    title: '',
                    content: "Impossible de mettre en place le report car le nombre de nuits n'a pas été indiqué.",
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

                break;
            default:

                $.alert({
                    title: '',
                    content: "Impossible de mettre en place le report car la date de la fiche est supérieure ou égale au dernier jour du séjour au centre " + visiteur.entity.HG_CentreNom + ".",
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

                break;
        }

    });

    $("#hg_centrenom_id").val($("#hg_lc_id").val());
    setHebergementDate();
});

function isAfterToday(date) {
    const today = new Date();
  
    today.setHours(23, 59, 59, 998);
    return date > today;
}

function hebergementCheckExist(dateHebergement){
    var $numFiche_t = $(".active").first().text();
    var $dateOfDay_t = new Date().toLocaleDateString("fr");
    var $dateModif_t = $("#forcesetdate").val();
    
    $.LoadingOverlaySetup({
        background      : "rgba(0, 0, 0, 0.5)",
        imageColor      : "#fff"
    });

    $.LoadingOverlay("show");

    $.ajax({
        method: 'POST',
        url: "/4DACTION/outilsWebHebergementCheckExist",
        data: {
            "hebergeID": $("#hg_hb_id").val(),
            "ficheType": $("#type_fiche").val(),
            "ficheDate": dateToJJMMYYYY(dateHebergement)

        },
        success: function(response){
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
                        btnClass: 'btn-blue',
                        action: function(){

                            if (visiteur.userCreateDate == true || visiteur.forceSetDate != null) {
                                setHebergementDate();
                            }else{
                                $('#fdp_usager_quitter').click();
                            }
                            
                        }
                      }
                    }
                });

            }else{

                if ((visiteur.id == "-1" && visiteur.userCreateDate == true) || (visiteur.forceSetDate != null)) {
                    dateFicheCreation_b = true;
                    dateFicheCreation_t = dateToJJMMYYYY(dateHebergement);

                    $("#hg_dateentree").val(dateFicheCreation_t);
                    $("#hg_datesortie").val('');

                    if (visiteur.forceSetDate != null) {
                        $numFiche_t = $numFiche_t.replaceAll($dateModif_t, dateFicheCreation_t);
                        $numFiche_t += "<span class=\"g-ml-10\"><i id=\"buttonChangerDateFiche\" class=\"fa fa-edit cursor-pointeur\" style=\"cursor: pointer;\"></i></span>"

                        $("#forcesetdate").val(dateFicheCreation_t)
                    }else{
                        $numFiche_t = $numFiche_t.replaceAll($dateOfDay_t, dateFicheCreation_t);
                    }
                    
                    $(".active").first().html($numFiche_t);
                    
                    setTimeout(() => {
                        inputFocus("hg_dateentree");
                    }, 200);
                }else if (visiteur.id == "-1"){
                    $("#hg_dateentree").val("");

                    setTimeout(() => {
                        inputFocus("hg_dateentree");
                    }, 200);

                }

            }

            $.LoadingOverlay("hide");
        }
    });

}

function setHebergementDate(){
    // Modifié par : Scanu Rémy (07/11/2022) et Re-Modifié par : Scanu Rémy (07/06/2023)
    switch (true) {
        case (visiteur.id == "-1" && visiteur.userCreateDate == true) || (visiteur.forceSetDate != null):
            var $dateOfDay_d = new Date().toLocaleDateString("fr");
    
            const [day, month, year] = $dateOfDay_d.split('/');
            const $dateOfDayIsoFormat_d = [year, month, day].join('-');
    
            bootbox.dialog('<div class="rowB"><div class="col-12"><div class="control-group"> <label class="control-label-group">Quelle est la date de prise d\u2019effet de l\u2019action ?</label> <div class="controls "> <input data-val="" data-column="5" type="date" id="dateCreationFiche" name="dateCreationFiche" value="' + $dateOfDayIsoFormat_d + '" class="fdp_span3 search span7 datepicker iw_tag_width_sextuplet iw_data_column_5" data-date-format="dd/mm/yyyy" placeholder="dd/mm/yyyy" autocomplete="off"> </div> </div></div></div>', [
                {
                    "label" : "Valider",
                    "class" : "btn-primary",
                    "callback": function() {
        
                        switch (true) {
                            case (isAfterToday(new Date($("#dateCreationFiche").val())) == true) :
                                
                                $.alert({
                                    title: '',
                                    content: "Il est impossible de créer des hébergements à une date postérieure à aujourd'hui.",
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
        
                                return false;
                                break;
                            case ($("#dateCreationFiche").val() != "") :
                                hebergementCheckExist($("#dateCreationFiche").val());
                                break;
                            default:
        
                                $.alert({
                                    title: '',
                                    content: "Date invalide, veuillez recommencer votre saisie.",
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
                                
                                return false;
                                break;
                        };
        
                    }
                },
                {
                    "label" : "Annuler",
                    "class" : "btn-danger",
                    "callback": function() {

                        if (visiteur.forceSetDate == null) {
                            $('#fdp_usager_quitter').click();
                        }
                        
                    }
                }
            ]);

            break;
        case (visiteur.id == "-1"):
            var $dateOfDay_d = new Date().toLocaleDateString("fr");
            
            hebergementCheckExist($dateOfDay_d);
            break;
        default:
            break;
    }
}

function setHebergementTime(){
    bootbox.dialog('<div class="rowB"><div class="col-12"><div class="control-group"> <label class="control-label-group">Heure de création de la fiche ?</label> <div class="controls "> <input data-val="" data-column="5" type="time" id="heureCreationFiche" name="heureCreationFiche" value="' + $("#heureFiche").text() + '" class="fdp_span3 search span7 iw_tag_width_sextuplet iw_data_column_5" placeholder="12:00:00" autocomplete="off"> </div> </div></div></div>', [
        {
            "label" : "Valider",
            "class" : "btn-primary",
            "callback": function() {

                switch (true) {
                    case ($("#heureCreationFiche").val() != "") :
                        visiteur.forceSetTime = true;
                        $("#heureFiche").text($("#heureCreationFiche").val());
                        break;
                    default:

                        $.alert({
                            title: '',
                            content: "Heure invalide, veuillez recommencer votre saisie.",
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
                        
                        return false;
                        break;
                };

            }
        },
        {
            "label" : "Annuler",
            "class" : "btn-danger",
            "callback": function() {
            }
        }
    ]);
}

function setHebergementDateFin(){
    var $dateMinIsoFormat_d = dateToYYYYMMJJ(extraireDate($(".active").first().text()));
    var $dateFinIsoFormat_d = dateJSToYYYYMMJJ(addDays(dateToYYYYMMJJ(extraireDate($(".active").first().text())), parseInt($("#hg_nuittotal").val()) - parseInt($("#hg_nuitencours").val()) - 1));

    bootbox.dialog('<div class="rowB"><div class="col-12"><div class="control-group"> <label class="control-label-group">Date de fin de la fiche ?</label> <div class="controls "> <input data-val="" data-column="5" type="date" id="dateFinFiche" name="dateFinFiche" value="' + $dateFinIsoFormat_d + '" class="fdp_span3 search span7 datepicker iw_tag_width_sextuplet iw_data_column_5" data-date-format="dd/mm/yyyy" placeholder="dd/mm/yyyy" autocomplete="off"> </div> </div></div></div>', [
        {
            "label" : "Valider",
            "class" : "btn-primary",
            "callback": function() {

                switch (true) {
                    case (isGreaterDate($dateMinIsoFormat_d, $("#dateFinFiche").val()) == true) :
                        
                        $.alert({
                            title: '',
                            content: "Il est impossible que la date de fin soit antérieure à la date de création de la fiche.",
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

                        return false;
                        break;
                    case ($("#dateFinFiche").val() != "") :
                        $("#date_fin_inclue").text(longFormatDate(dateToJJMMYYYY($("#dateFinFiche").val())));
                        $("#date_fin_inclue").append("&nbsp;<i id=\"buttonChangerDateFinFiche\" class=\"fa fa-edit cursor-pointeur\"></i>");

                        // Sur clic du bouton pour changer date de fin de la fiche
                        $("#buttonChangerDateFinFiche").click(function(){
                            setHebergementDateFin();
                        });

                        $("#hg_nuittotal").val(dayDiffNew(dateToYYYYMMJJ(extraireDate($(".active").first().text())), $("#dateFinFiche").val()) + parseInt($("#hg_nuitencours").val()));
                        
                        break;
                    default:

                        $.alert({
                            title: '',
                            content: "Date invalide, veuillez recommencer votre saisie.",
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
                        
                        return false;
                        break;
                };

            }
        },
        {
            "label" : "Annuler",
            "class" : "btn-danger",
            "callback": function() {
            }
        }
    ]);
}

function changeDateFinText(nbNuitTotale){
    var $date_t = longFormatDate(dateJSToJJMMYYYY(addDays(dateToYYYYMMJJ(extraireDate($(".active").first().text())), parseInt(nbNuitTotale) - 1)));
    $("#date_fin_inclue").text($date_t)
}

function hebergementExitConfirmation(dateFiche_t){
    var $dateFiche_t = extraireDate($(".active").first().text());

    $.confirm({
        title: 'Confirmation',
        content: 'Souhaitez-vous vraiment poursuivre ? Cette action est irréversible',
        icon: 'fa fa-warning',
        animation: 'scale',
        closeAnimation: 'zoom',
        columnClass: 'iw_alert',
        buttons: {
            confirm: {
                text: 'Oui',
                btnClass: 'btn-green',
                action: function () {
                    $.LoadingOverlaySetup({
                        background      : "rgba(0, 0, 0, 0.5)",
                        imageColor      : "#fff"
                    });

                    $("#hg_datesortie").val(dateFiche_t);

                    switch (true) {
                        case ($("#hg_datesortie").val() == $dateFiche_t): // L'utilisateur a répondu "Oui"
                            
                            // Si la fiche est indiquée comme étant "Cloturée", on indique que "Non"
                            if (($('#hg_cloturee').bootstrapSwitch('state')) == true){
                                $('#hg_cloturee').bootstrapSwitch('toggleState');
                            }

                            break;
                        case (($('#hg_cloturee').bootstrapSwitch('state')) == false): // Si la fiche est indiquée comme n'étant pas "Cloturée", on indique que "Oui"
                            
                            $('#hg_cloturee').bootstrapSwitch('toggleState');

                            break;
                        default:
                            break;
                    }
                
                    // Si la fiche est indiqué comme étant "Prise en charge", on indique que "Non"
                    if (($('#hg_reservation').bootstrapSwitch('state')) == true){
                        $('#hg_reservation').bootstrapSwitch('toggleState');
                    }
                
                    setTimeout(() => {
                
                        if (visiteur.societe.SO_ModeCHRS == true) {
                            //$("#hg_nuittotal").attr("disabled", true);
                            $("#buttonChangerDateFinFiche").hide();

                            if (parseInt($("#hg_nuitencours").val()) > 0) {
                                $("#hg_nuittotal").val($("#hg_nuitencours").val());
                            }else{
                                $("#hg_nuittotal").val("1");
                            }
                    
                        }

                        $.confirm({
                            title: 'Sortie',
                            content: 'Voulez-vous appliquer cette sortie pour tous les membres de la famille ?',
                            icon: 'fa fa-warning',
                            animation: 'scale',
                            closeAnimation: 'zoom',
                            columnClass: 'iw_alert',
                            buttons: {
                                confirm: {
                                    text: 'Oui',
                                    btnClass: 'btn-green',
                                    action: function () {
                                        $.LoadingOverlay("show");

                                        hebergementSortie_o.confirmation = true;
                                        hebergementSortie_o.sortieTousMembresFamille = true;

                                        $('#fdp_usager_valider').click();
                                    }
                                },
                                cancel: {
                                    text: 'Non',
                                    btnClass: 'btn-red',
                                    action: function () {
                                        $.LoadingOverlay("show");

                                        hebergementSortie_o.confirmation = true;
                                        hebergementSortie_o.sortieTousMembresFamille = false;

                                        $('#fdp_usager_valider').click();
                                    }
                                }
                            }
                        });

                    }, 1000);

                }
            },
            cancel: {
                text: 'Non',
                btnClass: 'btn-red',
                action: function () {

                }
            }
        }
    });

}

function hebergementExit(membersFamily_b){

    $.ajax({
        method: 'POST',
        url: "/4DACTION/outilsWebHebergementExit",
        data: {
            "id": $("#id").val(),
            "sortieTousMembresFamille": membersFamily_b,
            "societeCHRS": visiteur.societe.SO_ModeCHRS
        },
        success: function(response){
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
                        btnClass: 'btn-blue',
                        action: function(){
                            location.reload();
                            $.LoadingOverlay("hide");
                        }
                      }
                    }
                });

            }else{
                $.LoadingOverlay("hide");

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
                            action: function(){
                                $("#fdp_usager_quitter").click();
                            }
                        }
                    }
                });

            }

        }
    });

}

function inputFocus(id){
    var input_j = document.getElementById(id);

    setTimeout(function() {
        input_j.focus();
    }, 0);
}

function Get_Heberge_Data(){
	var data_heberge = { 
		"hg_hb_id": $("#hg_hb_id").val()
	};

	var data = { 
		"zone":"heberge", 
		"action":"get_heberge",
		"data": {
			"heberge": data_heberge
		}
	};

	var data_json = '&json='+JSON.stringify(data);

	$.getJSON("/INT?action=get_heberge",data_json, function(data){  

		$.each(data, function(key, value){
			console.log(value);

			// Coordonnées
			$("#adresse1").val(value.adresse1);
			$("#adresse2").val(value.adresse2);
			$("#adresse3").val(value.adresse3);
			$("#codePostal").val(value.codePostal);
			$("#ville").val(value.ville);

			$("#nomHB").val(value.hb_nom);
			$("#prenomHB").val(value.hb_prenom);
			$("#dateNaissanceHB").val(dateToYYYYMMJJ(value.hb_datenele));
			
			$("#emailHB").val(value.hb_email);
			$("#telephoneHB").val(value.hb_telephone);

			// Pièces
			$("#lieuNaissanceHB").val(value.hb_pieceneou);
			$("#nationaliteHB").val(value.hb_piecenationalite);
			$("#numCNIHB").val(value.hb_piececni);
			$("#numPassportHB").val(value.hb_piecepasseport);

			switchEnabledMultipleElement(["#nomHB", "#prenomHB", "#dateNaissanceHB"], true);
			$("#modifDemandeur").prop( "checked", false);
		});

	}).done(function() {//success
	})
	.fail(function() { //error
	})
	.always(function() { //complete
	});
}