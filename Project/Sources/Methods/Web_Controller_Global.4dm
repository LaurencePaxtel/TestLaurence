//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 02/12/18, 23:50:41
// ----------------------------------------------------
// Méthode : Web_Controller_Global
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($action; $saction; $staction; $user_type; $UIDP; $UIDT; $sform; $folder)
C_LONGINT:C283($id)
C_BOOLEAN:C305($boolean_b; $param_2_)
C_POINTER:C301($param_1; $param_2)

C_TEXT:C284(MESSAGE_INFO; MESSAGE_ETAT)

ARRAY TEXT:C222($_field; 0)
ARRAY TEXT:C222(TB_SLISTE; 0)
ARRAY TEXT:C222(TB_METHODE_REFRESH; 1)

WEB GET HTTP HEADER:C697($_field; $_content)

$method:=$_content{1}
$method:=WEB_UTL_GET_PARAMS("method")
$action:=WEB_UTL_GET_PARAMS("action")

$UID:=WEB_UTL_GET_PARAMS("UID")  // sinon utl_champ est utilisé -> WEB_GET_VALUE_CHAMP(->[Taches]UID)
UIDM:=WEB_UTL_GET_PARAMS("UIDM")

$Page:=Num:C11(WEB_UTL_GET_PARAMS("page"))
$champAuto:=WEB_UTL_GET_PARAMS("c")
$annuler:=WEB_UTL_GET_PARAMS("annuler")
$search:=WEB_UTL_GET_PARAMS("search")

$user_type:=WEB_UTL_GET_PARAMS("user")
$profile_type:=WEB_UTL_GET_PARAMS("type")

$saction:=WEB_UTL_GET_PARAMS("saction")
$staction:=WEB_UTL_GET_PARAMS("staction")
$UIDP:=WEB_UTL_GET_PARAMS("UIDP")

$UIDT:=WEB_UTL_GET_PARAMS("UIDT")
$sform:=WEB_UTL_GET_PARAMS("sform")

$Length:=60

$param_1:=Null:C1517
$param_2:=Null:C1517  //$param_2:=True (->$param_2) modifié suite à la demande de laurence le 10-07-2019 pour afficher les usagers + locataires lors de la saisie d'une location

BTN_MAIL:=True:C214
CHERCHER_TRANSACTION:=False:C215

BTN_LISTE:=""

FIX_PARAM_BTNS:=""
FIX_PARAM_BTNS_LN:=""
FIX_PARAM_BTNS_LND:=""

HTML_NAME_MODULE:=LANG_TXT_USAGER_ACCUEIL
HTML_HOME:=LANG_TXT_USAGER_ACCUEIL
HTML_NAME_NAV:=LANG_TXT_LISTE
HTML_NAME_NAV_MODULE:=LANG_TXT_USAGER_RECHERCHE

vDate:=Current date:C33
vHour:=Current time:C178

Case of 
	: ($action="get_heberge")
		Web_Int_Get_Heberge
	: ($action="get_autocomplete_usagers")
		WebAGL_Autocomplete_Data(->[HeBerge:4]; ->[HeBerge:4]ID:65; ->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4)
	: ($action="get_autocomplete_utilisateurs")
		WebAGL_Autocomplete_Data(->[INtervenants:10]; ->[INtervenants:10]ID:16; ->[INtervenants:10]IN_NomPrénom:8)
	: ($action="get_usr_info")
		Web_USR_Get_Info
	: ($action="get_autocomplete_heberges")
		WebAGL_Autocomplete_Data(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; ->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4)
	: ($action="get_autocomplete_locataires")
		Web_Autocomplete_Heberges(->[HeBerge:4]; ->[HeBerge:4]ID:65; ->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4; $param_1; ->[HeBerge:4]HB_Locataire:71; $param_2)
	: ($action="get_autocomplete_colocataires")
		Web_Autocomplete_Heberges(->[HeBerge:4]; ->[HeBerge:4]ID:65; ->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4; $param_1; ->[HeBerge:4]HB_Locataire:71; $param_2)
	: ($action="get_autocomplete_loc_locataires")
		$param_1:=->[HeBerge:4]ID:65
		$param_2_:=True:C214
		
		WebAGL_Autocomplete_Loc_Data(->[HeBerge:4]; ->[HeBerge:4]ID:65; ->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4; $param_1; ->[HeBerge:4]HB_Locataire:71; ->$param_2_)
	: ($action="get_autocomplete_heberge")
		WebAGL_Autocomplete_Data(->[HeBerge:4]; ->[HeBerge:4]ID:65; ->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4)
	: ($action="get_autocomplete_proprietaires")
		WebAGL_Autocomplete_Data(->[Proprietaires:83]; ->[Proprietaires:83]ID:1; ->[Proprietaires:83]PRO_Nom:2; ->[Proprietaires:83]PRO_Prenom:3)
	: ($action="get_autocomplete_centres")
		// Modifié par : Scanu Rémy (29/07/2021)
		//WebAGL_Autocomplete_Data (->[LesCentres];->[LesCentres]ID;->[LesCentres]LC_GL_Nom_Suite)
		WebAGL_Autocomplete_Data(->[LesCentres:9]; ->[LesCentres:9]ID:60; ->[LesCentres:9]LC_Nom:4; $param_1; $param_2; ->[LesCentres:9]LC_Prestation:55; ->$boolean_b)
	: ($action="get_autocomplete_locations")
		Web_Autocomplete_Locations(->[Locations:84]; ->[Locations:84]ID:1; ->[Locations:84]LOC_Titre:14; $param_1; ->[Locations:84]LOC_Bien_ID:5)
	: ($action="get_autocomplete_usr_locations")
		Web_Autocomplete_Locations(->[Locations:84]; ->[Locations:84]ID:1; ->[Locations:84]LOC_Titre:14; $param_1; ->[Locations:84]LOC_Bien_ID:5; ->[Locations:84]LOC_HB_ID:3)
	: ($action="get_autocomplete_banques")
		Web_Autocomplete_Locations(->[Locations:84]; ->[Locations:84]ID:1; ->[Locations:84]LOC_Titre:14; $param_1; ->[Locations:84]LOC_Bien_ID:5)
	: ($action="get_autocomplete_charges")
		Web_Autocomplete_Charges(->[Charges:92]; ->[Charges:92]ID:1; ->[Charges:92]CHA_Libelle:3; $param_1; ->[Charges:92]CHA_Origine_ID:6)
	: ($action="get_autocomplete_immeubles")
		WebAGL_Autocomplete_Data(->[Immeuble:105]; ->[Immeuble:105]ID:1; ->[Immeuble:105]IMM_Nom:3)
	: ($action="get_autocomplete_logements")
		WebAGL_Autocomplete_Data(->[LesCentres:9]; ->[LesCentres:9]ID:60; ->[LesCentres:9]LC_Nom:4; $param_1; ->[LesCentres:9]LC_Immeuble_ID:84)
	: ($action="get_file")  //base documentaire 
		$id:=Num:C11(WEB_UTL_GET_PARAMS("id"))
		$folder:=WEB_UTL_GET_PARAMS("type")
		
		Web_BD_Get_File($id; $folder)
End case 