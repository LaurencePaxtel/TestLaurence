$(document).ready(function() {
    $("#fdp-usager-print").click(function() {

        return function(e) {
            var t = $("#int-usager-table").html(),
                i = $("<iframe />");
            i[0].name = "frame1", i.css({
                position: "absolute",
                top: "-1000000px"
            }), $("body").append(i);
            var n = i[0].contentWindow ? i[0].contentWindow : i[0].contentDocument.document ? i[0].contentDocument.document : i[0].contentDocument;
            n.document.open(), n.document.write("<html moznomarginboxes mozdisallowselectionprint>"), n.document.write('<link href="layouts/default/css/table/print.css" rel="stylesheet" type="text/css" media="print"  />'), n.document.write("</head><body>"), n.document.write(t), n.document.write("</body></html>"), n.document.close(), setTimeout(function() {
                window.frames.frame1.focus(), window.frames.frame1.print(), i.remove()
            }, 500)
        }(), !1
    });

    $("#fdp-usager-clear").click(function() {
        document.getElementById("profile").reset();
    });
    
    $("#int-usager-table .table").empty(), $("#fdp-usager-search").click(function() {
        $.LoadingOverlaySetup({
            background: "rgba(0, 0, 0, 0.5)",
            imageColor: "#fff"
        })

        $.LoadingOverlay("show");
        
        if ($("#datedu").val() == "" && $("#dateau").val() == "") {

            $.alert({
                title: 'Alerte',
                content: "Veuillez entrer une date de début ou une date de fin",
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

            $.LoadingOverlay("hide");
        }else{
            var e = {
                zone: "centre",
                action: "get_centres",
                data: {
                    datedu: $("#datedu").val(),
                    dateau: $("#dateau").val(),
                    nom: $("#centre").val(),
                    complet: $("#complet").val(),
                    typegestion: $("#typegestion").val()
                }
            };
            
            t = "&json=" + JSON.stringify(e);
            i = !1;
    
            return $.getJSON("/INT?action=get_json_centres", t, function(e) {
    
                if (e.rows.length > 0) {
                    i = !0, $("#int-usager-table .table").empty(), $("#int-usager-table .iw-header").empty();
                    var t = "",
                        n = "",
                        c = "";
                    n += (e.rows.length == 1) ? "1 réservation" : e.rows.length - e.rowsEmpty + " réservations sur " + e.rows.length + " centre(s)", t += '<div class="row header">', t += '<div class="cell fdp-min-width-320px">', t += "Nom du centre", t += "</div>", t += '<div class="cell fdp-min-width-110px">', t += "Date", t += "</div>", t += '<div class="cell" style="min-width: 60px;">', t += "Capacité", t += "</div>", t += '<div class="cell" style="min-width: 60px;">', t += "Distribué", t += "</div>", t += '<div class="cell" style="min-width: 60px;">', t += "Restants", t += "</div>", t += '<div class="cell" style="min-width: 210px;">', t += "Chef de famille <a href=\"#\" class=\"g-color-white\"><i class='fa fa-sort fdp-icon-white'></i></a>", t += "</div>", t += '<div class="cell" style="min-width: 90px;">', t += "Date début", t += "</div>", t += '<div class="cell" style="min-width: 90px;">', t += "Date fin", t += "</div>", t += '<div class="cell" style="min-width: 60px;">', t += "Complet", t += "</div>", t += '<div class="cell" style="min-width: 60px;">', t += "Réservation provisoire", t += "</div>", t += "</div>";
    
                    var l = 0;
                    $.each(e.rows, function(e, i) {
                        c = "", l % 2 != 0 && (c = "iw-alternate"), t += '<div class="row body ' + c + '">', t += '<div class="cell" id="colf' + i.id + '">', t += i.lc_nom, t += "</div>", t += '<div class="cell" id="colf' + i.id + '">', t += i.hg_date, t += "</div>", t += '<div class="cell" id="colf' + i.id + '">', t += i.cl_capacite, t += "</div>", t += '<div class="cell" id="colf' + i.id + '">', t += i.cl_distribue, t += "</div>", t += '<div class="cell" id="colf' + i.id + '">', t += i.cl_restant, t += "</div>", t += '<div class="cell" id="colf' + i.id + '">', t += i.nomUsager, t += "</div>", t += '<div class="cell" id="colf' + i.id + '">', t += i.dateDebut, t += "</div>", t += '<div class="cell" id="colf' + i.id + '">', t += i.dateFin, t += "</div>", t += '<div class="cell" id="colf' + i.id + '">', t += i.complet, t += "</div>", t += '<div class="cell" id="colf' + i.id + '">', t += i.reservationProvisoire, t += "</div>", t += "</div>", l += 1
                    }), $("#int-usager-table .iw-header").append(n), $("#int-usager-table .table").append(t);

                    $(".changeStatutComplet").click(function(){
                        var $this = $(this);

                        $.confirm({
                            title: '',
                            content: 'Souhaitez-vous vraiment mettre le statut « Complet » ?',
                            buttons: {
                                formSubmit: {
                                    text: 'Oui',
                                    btnClass: 'btn-blue',
                                    action: function () {
                                        $.LoadingOverlay("show");

                                        $.ajax({
                                            method: 'POST',
                                            url: "/4DACTION/outilsManageReservation",
                                            data: {
                                                "hebergementID": extractNumber($this.closest("div").attr("id"))
                                            },
                                            success: function(response){
                                                $.LoadingOverlay("hide");
                                                $("#fdp-usager-search").click();
                                            }
                                        });

                                    }
                                },
                                cancel: {
                                    text: 'Non',
                                    action: function () {

                                    }
                                }
                            },

                        });
                    
                    });

                }else{
    
                    $.alert({
                        title: 'Alerte',
                        content: "Aucune réservation trouvée",
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
                    
                    $("#int-usager-table .table").empty();
                    $("#int-usager-table .iw-header").empty()
                }
    
            }).done(function() {}).fail(function() {}).always(function() {
                $.LoadingOverlay("hide"), $("#int-usager-table .table").show(), i && $("#fdp-usager-print").show()
            }), !1
        }
    });

    $("#int-usager-table").css({ "overflow-x": "auto"});
});

// Petite fonction pour extraire les chiffres d'une chaine de caractère
function extractNumber(string) {
    var matches = string.match(/(\d+)/);

    if (matches) {
        return matches[0];
    }
};