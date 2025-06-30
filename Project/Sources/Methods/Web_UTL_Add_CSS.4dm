//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 04/11/18, 02:10:25
// ----------------------------------------------------
// Méthode : Web_UTL_Add_CSS
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

Case of 
	: ($1="fiche_usager")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/css/fiche_usager.css\" />"
		
		// Modifié par : Scanu Rémy (08/06/2022)
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/css/dataTables.bootstrap4.min.css\" />"
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/css/select.dataTables.min.css\" />"
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/css/fixedColumns.dataTables.min.css\" />"
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/css/buttons.dataTables.css\" />"
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/js/datatable/1.10.20/css/editor.dataTables.min.css\" />"
	: ($1="recherche_usager")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/css/recherche_usager.css\" />"
	: ($1="gl_liste_usagers")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/liste_usagers.css\" />"
	: ($1="gl_liste_locataires")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/liste_locataires.css\" />"
	: ($1="form_list")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/css/form_list.css\" />"
	: ($1="gl_liste_locations")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/liste_locations.css\" />"
	: ($1="gl_liste_biens")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/liste_biens.css\" />"
	: ($1="gl_liste_factures")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/liste_factures.css\" />"
	: ($1="fiche_facture")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/fiche_facture.css\" />"
	: ($1="gl_fiche_bien")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/fiche_bien.css\" />"
	: ($1="custom")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/css/custom.css\" />"
	: ($1="gl_fiche_location")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/fiche_location.css\" />"
	: ($1="gl_charges")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/charges.css\" />"
	: ($1="gl_bien_inventaire_pieces")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/inventaire_pieces.css\" />"
	: ($1="gl_liste_proprietaires")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/liste_proprietaires.css\" />"
	: ($1="iw_datatable")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"plugins/iw-datatable/css/jquery.dataTables.min.css\" />"
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"plugins/iw-datatable/css/responsive.dataTables.min.css\" />"
	: ($1="gl_fiche_relance")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/fiche_relance.css\" />"
	: ($1="gl_fiche_reglement")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/fiche_reglement.css\" />"
	: ($1="gl_interventions")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/interventions.css\" />"
	: ($1="int_tableau_de_bord")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/css/tableau_de_bord.css\" />"
	: ($1="calendar")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/core/main.css\" />"
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/daygrid/main.css\" />"
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/timegrid/main.css\" />"
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"plugins/fullcalendar/packages/list/main.css\" />"
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/planning/css/planning.css\" />"
	: ($1="popup_simple")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"css/popups/css/style_simple.css\" />"
	: ($1="events_list")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/planning/css/planning.css\" />"
	: ($1="bootstrap_4_5_0")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"css/bootstrap_4_5_0.min.css\" />"
	: ($1="form")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/css/form.css\" />"
	: ($1="basedoc")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/base_documentaire/css/style.css\" />"
	: ($1="general")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/css/general.css\" />"
	: ($1="iw_select2")
		Page_Custom_CSS:=Page_Custom_CSS+"<link href=\"https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css\" rel=\"stylesheet\"/>"
	: ($1="iw_editableTable")
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"plugins/iw_editableTable/css/mindmup-editabletable.css\" />"
	: ($1="iw_tableCellEditor")
	Else 
		Page_Custom_CSS:=Page_Custom_CSS+"<link rel=\"stylesheet\" type=\"text/css\" href=\""+HTML_LAYOUT_PATH+"paxtel/gestion-locative/css/"+$1+"\" />"
End case 