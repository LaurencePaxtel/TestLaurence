//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 00:36:57
// ----------------------------------------------------
// Méthode : WebAGL_Init
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284(HTML_MESSAGE; SYNTH_MEMO_LH_HTML; DATACOL; REFRESH_HTML; FIX_PARAM_BTNS_LN; w_structure; Page_Custom_Scrirpts; Page_Custom_Scrirpts_TOP_1; Page_Custom_Scrirpts_L1; Page_Custom_CSS; UID_SESSION; HTML_HOME; HTML_NAME_NAV; HTML_NB_MODULE; \
HTML_VIEW; HTML_CONTENT; HTML_NAME_MODULE; HTML_MESSAGE_PRS; web_form_back_view; ref_soc_active; WFLP_FULLTIME)
C_LONGINT:C283(w_userUID)
C_BOOLEAN:C305(invisible_table; RECORD_ACT_EDIT)


ARRAY TEXT:C222(FIX_TABLEAUX_DUP_UIDS; 0)  // Récuperer les uids au moment de duplication des lignes on utilisant la methode WebAGL_dupliquer_lignes
ARRAY TEXT:C222(TB_PARAMS; 0; 10)
ARRAY TEXT:C222(TB_PARAMS_COLS; 0; 10)
ARRAY TEXT:C222(TB_COULEURS_LIGNES; 0; 0)
ARRAY TEXT:C222(TB_GLISSE_LIGNES; 0; 0)

ACTIONS_LIST:=""  // La liste des actions pour la gestion du clic droit
ALERTE_MESSAGE:=""

BTN_PRINT_MENU:=""  // pour remplire le menu dropdown d'impression dans un fiche

FIX_PARAM_ACTION:=w_action
FIX_PARAM_UID_M:=""
FIX_PARAM_BTNS:="Right"  // A utiliser en cas de besoin specifique pour modifier les droits dans un controlleur standard (VAESDR)
FIX_PARAM_BTNS_LN:="Right"  // A utiliser en cas de besoin specifique pour modifier les droits dans un controlleur ligne (VAES)
FIX_PARAM_MODE:=""
FIX_PARAM_ACTION_M:=""
FIX_PARAM_BTN_MODE:=""
FIX_POSITION_TABS:="top"  // Déterminer la positionement des onglets
FIX_PARAM_BOOL:="Oui|Non"  // Si on veux changer la valeur boolean a afficher au lieu de mettre vrai/faux
FIX_PARAM_SEP:="|"  // Default espace
FIX_ORDER_LH:="ALPHA ASC"
FIX_POPOUP_TAILLE_X:="span6"  // pour changer la taille des popup (span1,span8....span12)
FIX_DATE_FORMAT:="mm/dd/yyyy"

FOLDER_NAV:="nav-main"  // Le nom du dossier dans lequel on peut trouver le navigateur

HTML_LAYOUT_PATH:="/layouts/default/"  // Le chemin vers le dossier projet
HTML_NB_MODULE:=""

HTML_VIEW:=""
HTML_CONTENT:=""
HTML_LAYOUT_NAME:="app"  // Le fichier html template ,il faut prendre on consideration que l'extension c'est .html
HTML_DEVERSEMENT:=""  // A remplir avec le code html au cas de deversement
HTML_MESSAGE:=""
HTML_VIEW_ERROR:=""
HTML_NAV_MENU_IMAGES:=""
HTML_NAME_MODULE:=""
HTML_NAME_NAV:=""
HTML_NAME_NAV_MODULE:=""
HTML_TABLE_WORKFLOW:=""
HTML_MODALS:=""

LH_LISTE:=""  // A remplir en cas de construction d'un LH liste
LH_SAISIE:=""  // A remplir en cas de construction d'un LH saisie

MESSAGE_ETAT:=" hide"

NAV_BODY:=""
NOM_PREF_RECHERCHE:="#"  // Il faut mettre a jours ce paramtre dans chaque controlleur , il faut voir dans la methode liste de l'agl 4D

Page_Custom_Scrirpts:=""
Page_Custom_Scrirpts_TOP_1:=""
Page_Custom_CSS:=""

ref_soc_active:=""
REDIRECT:=""
REDIRECT_TAB:=""

selects:=""
SCRIPT:=""
SCRIPT_PERSO:=""
TRADUCTION_LANG:=""  // [Collaborateurs]USR_Langue

UID_SESSION:="16092013V1"

w_structure:="Paxtel"
web_form_back_view:=""

Environnement_web:=True:C214

FIX_PARAM_DEVERSEMENT:=False:C215  // Mettre en vrai dans une methode de deversement 
FIX_TRADUCTION:=True:C214
FIX_PARAM_LH:=True:C214
FIX_EXPORT_EXCEL:=True:C214
FIX_IMPRESSION:=True:C214
FIX_PARAM_LH_SAISIE:=False:C215
FIX_PARAM_RECHERCHE:=True:C214
FIX_PARAM_RECHERCHE_LIGNE:=False:C215
FIX_PARAM_POPUP:=False:C215
FIX_PARAM_BTN_REFRESH:=False:C215
FIX_WORKFLOW:=False:C215

invisible_table:=False:C215

toutes_structures:=False:C215

Web_Error:=False:C215

FIX_TIME_LOCK:=360  // Le temps nécessaire pour verouiller une fiche



If (Undefined:C82(scriptPluginCTI))
	C_TEXT:C284(scriptPluginCTI)
End if 

RECORD_ACT_EDIT:=False:C215
LANG_French