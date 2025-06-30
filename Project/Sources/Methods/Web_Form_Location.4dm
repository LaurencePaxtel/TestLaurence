//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 17-12-18, 18:22:03
// ----------------------------------------------------
// Method: Web_Form_Location
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)

C_TEXT:C284(SCRIPT; $mode; $loc_duree_mois; $statut_t; $propriete_t)
C_LONGINT:C283($o; $i)
C_POINTER:C301($id)
C_OBJECT:C1216($userPreferences_o)

ARRAY TEXT:C222($tb_enum_values; 0)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$id:=$1
$mode:=$2

$statut_t:=";;"
$loc_duree_mois:=";;"

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

APPEND TO ARRAY:C911($tb_enum_values; "3")
APPEND TO ARRAY:C911($tb_enum_values; "6")
APPEND TO ARRAY:C911($tb_enum_values; "9")

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="location"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="location"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="loc_date"
$TB_HTML{$o}{4}:=String:C10([Locations:84]LOC_Date:2)
$TB_HTML{$o}{5}:="Date du bail"
$TB_HTML{$o}{6}:="loc_date"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7 iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bien_en_location"
$TB_HTML{$o}{4}:=[LesCentres:9]LC_Nom:4
$TB_HTML{$o}{5}:="Bien en location"
$TB_HTML{$o}{6}:="bien_en_location"
$TB_HTML{$o}{7}:="span7 search iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="usager"
$TB_HTML{$o}{4}:=[Locations:84]LOC_Usager_Prenom_Nom:16
$TB_HTML{$o}{5}:="Locataire principal"
$TB_HTML{$o}{6}:="usager"
$TB_HTML{$o}{7}:="span7 search iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="loc_montant_initial"
$TB_HTML{$o}{4}:=String:C10([Locations:84]LOC_Montant_Initial:6)
$TB_HTML{$o}{5}:="Montant du loyer"
$TB_HTML{$o}{6}:="loc_montant_initial"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="loc_montant_revise"
$TB_HTML{$o}{4}:=String:C10([Locations:84]LOC_Montant_Revise:7)
$TB_HTML{$o}{5}:="Montant revisé"
$TB_HTML{$o}{6}:="loc_montant_revise"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder disabled iw_cg_width_third"

// Modifié par : Scanu Rémy (05/05/2021)
// Ajout du champ LOC_Qualification
$userPreferences_o:=JSON Parse:C1218(w_userPreferences)

If ($userPreferences_o.location#Null:C1517)
	
	For each ($propriete_t; $userPreferences_o.location.statut)
		$statut_t:=$statut_t+"|"+$propriete_t+"_"+$propriete_t
	End for each 
	
End if 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="loc_statut"
$TB_HTML{$o}{4}:=$statut_t
$TB_HTML{$o}{5}:="Statut"
$TB_HTML{$o}{6}:="loc_statut"
$TB_HTML{$o}{7}:="span7 search iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="loc_date_entree"
$TB_HTML{$o}{4}:=String:C10([Locations:84]LOC_Date_Entree:9)
$TB_HTML{$o}{5}:="Date d'entrée dans les lieux"
$TB_HTML{$o}{6}:="loc_date_entree"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7 fdp_row_start iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="loc_date_sortie"
$TB_HTML{$o}{4}:=String:C10([Locations:84]LOC_Date_Sortie:10)
$TB_HTML{$o}{5}:="Date de sortie des lieux"
$TB_HTML{$o}{6}:="loc_date_sortie"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7 iw_cg_width_third"

For ($i; 1; Size of array:C274($tb_enum_values))
	$loc_duree_mois:=$loc_duree_mois+"|"+$tb_enum_values{$i}+"_"+$tb_enum_values{$i}
End for 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="loc_duree_mois"
$TB_HTML{$o}{4}:=$loc_duree_mois
$TB_HTML{$o}{5}:="Durée de location (années)"
$TB_HTML{$o}{6}:="loc_duree_mois"
$TB_HTML{$o}{7}:="fdp_span3  span7 iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="loc_garantie_montant"
$TB_HTML{$o}{4}:=String:C10([Locations:84]LOC_Garantie_Montant:11)
$TB_HTML{$o}{5}:="Montant du dépôt de garantie"
$TB_HTML{$o}{6}:="loc_garantie_montant"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="checkbox_simple"
$TB_HTML{$o}{3}:="loc_garantie_encaisse"
$TB_HTML{$o}{4}:="loc_garantie_encaisse;Dépôt de garantie encaissé;"+String:C10([Locations:84]LOC_Garantie_Encaisse:4)+"|"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="loc_garantie_encaisse"
$TB_HTML{$o}{7}:="iw_label iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="checkbox_simple"
$TB_HTML{$o}{3}:="loc_apl"
$TB_HTML{$o}{4}:="loc_apl;Gestion des APL;"+String:C10([Locations:84]LOC_APL:23)+"|"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="loc_garantie_encaisse"
$TB_HTML{$o}{7}:="fdp_row_start iw_label iw_cg_width_third"

ARRAY TEXT:C222($ta_InPerm_t; 0)
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=4)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; $ta_InPerm_t)
SORT ARRAY:C229($ta_InPerm_t; >)
$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="loc_referent"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$ta_InPerm_t)
$TB_HTML{$o}{5}:="Référent"
$TB_HTML{$o}{6}:="loc_referent"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third"

ARRAY TEXT:C222($ta_InCoo_t; 0)
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=2)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; $ta_InCoo_t)
SORT ARRAY:C229($ta_InCoo_t; >)
$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="loc_coordinateur"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML(->$ta_InCoo_t)
$TB_HTML{$o}{5}:="Chef de service"
$TB_HTML{$o}{6}:="loc_coordinateur"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="loc_hb_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="loc_hb_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="loc_bien_id"
$TB_HTML{$o}{4}:=String:C10([Locations:84]LOC_Bien_ID:5)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="loc_bien_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="loc_nombre_jours"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="loc_nombre_jours"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory"
$TB_HTML{$o}{4}:="loc_date;usager;bien_en_location;loc_date_entree"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM; $mode)