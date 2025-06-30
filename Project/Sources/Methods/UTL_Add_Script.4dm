//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 03:46:20
// ----------------------------------------------------
// Méthode : UTL_Add_Script
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($type)

$type:=$1

Case of 
	: ($type="adress_autocomplete")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/adress_autocomplete.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\"https://maps.googleapis.com/maps/api/js?key=AIzaSyD_UvFGHMQSVgRTCRx-JVZ-QbjaPAqEP6o&signed_in=true&libraries=places&callback=initAutocomplete\" async defer></script>"
	: ($type="fdp_checkboxes")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/fdp_checkboxes.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="fdp_multiselect_single")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/multiselect_single.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="fdp_subscription")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/fdp_subscription.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="fdp_stars")
	: ($type="fdp_fb_login")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/teamguru/fb_login.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="fdp_login")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/teamguru/login.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="fdp_team_tabs")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/teamguru/fdp-team-tabs.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="fdp_calendar")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/fullcalendar/fullcalendar/fullcalendar.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="fdp_calendar_fr")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/fullcalendar/fullcalendar/fullcalendar.min.fr.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="fdp_events")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/teamguru/events.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="fdp_calendar_filters")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"js/teamguru/fdp_calendar_filters.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="int_usager_table")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/resp-table-usager.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="int_tableau_de_bord")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/resp-tableau-bord.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="int_centres")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/resp-table-centres.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="int_usager_fiche")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/int_usager_fiche.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		
		// Modifié par : Scanu Rémy (08/06/2022)
		// Ajout dataTable
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/js/jquery.dataTables.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/js/dataTables.bootstrap4.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/select/1.3.1/js/dataTables.select.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/button/1.6.1/js/dataTables.buttons.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/button/1.6.1/js/buttons.flash.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/jszip/3.3.0/js/jszip.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/button/1.6.1/js/buttons.html5.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/button/1.6.1/js/buttons.print.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/plugin/sorting/js/currency.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/plugin/sorting/js/date-euro.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/plugin/fixedColumn/js/fixedColumns.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/plugin/editor/js/dataTables.editor.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_locataires")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_locataires.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_proprietaires")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_proprietaires.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_situation_usagers")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_situation_usagers.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_irl")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_irl.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_locations")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_locations.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_biens")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_biens.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_equipements")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_equipements.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_equipements_b")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_equipements_biens.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_interventions")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_interventions.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_factures")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_factures.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_fiche_facture")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/fiche_facture.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_fiche_reglement")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/fiche_reglement.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_reglements")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script type=\"text/javascript\" src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_reglements.js\"  charset=\"utf-8\"></script>"
	: ($type="gl_fiche_bien")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/fiche_bien.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_fiche_location")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/fiche_location.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="iw_datatable")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/js/jquery.dataTables.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/js/dataTables.bootstrap4.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/select/1.3.1/js/dataTables.select.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/button/1.6.1/js/dataTables.buttons.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/button/1.6.1/js/buttons.flash.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/jszip/3.3.0/js/jszip.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/button/1.6.1/js/buttons.html5.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/button/1.6.1/js/buttons.print.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/plugin/sorting/js/currency.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/plugin/sorting/js/date-euro.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/plugin/fixedColumn/js/fixedColumns.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/plugin/editor/js/dataTables.editor.min.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_charges")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/charges.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_bien_pieces")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/pieces.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_bien_inventaire_pieces")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/inventaire_pieces.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_dashboard_sinistres")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/dashboard_sinistres.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_dashboard_charges")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/dashboard_charges.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_relances")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_relances.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_fiche_relance")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/fiche_relance.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_dashboard")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/dashboard.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_fiche_intervention")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/fiche_intervention.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_fiche_stock")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/fiche_stock.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_documents")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_documents.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_main")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/main.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="basedoc")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/base_documentaire/js/liste.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/base_documentaire/js/fiche.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="iw_signature")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"plugins/iw-signature/jq-signature.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="calendar")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/core/main.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/interaction/main.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/daygrid/main.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/timegrid/main.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/list/main.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/bundle/locales/fr.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="planning")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"paxtel/planning/js/planning.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="eve_events_list")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"paxtel/planning/js/liste.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="gl_liste_stock")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/liste_stock.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="iw_popups")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"plugins/iw-popups/assets/js/app.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="iw_print")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script  src=\""+HTML_LAYOUT_PATH+"plugins/iw_print/dist/html2canvas.js\" type=\"text/javascript\" charset=\"utf-8\"></script>"
	: ($type="iw_select2")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\"https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js\"></script>"
	: ($type="iw_bootbox")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"plugins/iw_bootbox/dist/bootbox.min.js\"></script>"
	: ($type="iw_editableTable")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"plugins/iw_editableTable/js/mindmup-editabletable.js\"></script>"
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"plugins/iw_editableTable/js/numeric-input-example.js\"></script>"
	: ($type="iw_tableCellEditor")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"plugins/iw_tableCellEditor/js/tableCellEditor.min.js\"></script>"
	: ($type="iw_moment")
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"plugins/iw_moment/js/moment.js\"></script>"
	Else 
		Page_Custom_Scrirpts:=Page_Custom_Scrirpts+"<script src=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/"+$type+"\" type=\"text/javascript\" charset=\"utf-8\"></script>"
End case 