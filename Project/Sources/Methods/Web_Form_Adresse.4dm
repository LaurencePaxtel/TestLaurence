//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 04/12/18, 20:20:17
// ----------------------------------------------------
// Méthode : Web_Form_Adresse
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($0; SCRIPT; $UID; $disabled)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)
C_POINTER:C301($1; $uid_origine)

$uid_origine:=$1
RECORD_ACT_EDIT:=True:C214
$disabled:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

$action:=WEB_UTL_GET_PARAMS("action")
$UID:=WEB_UTL_GET_PARAMS("UID")
$actionm:=WEB_UTL_GET_PARAMS("actionm")

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="adresse"
$TB_FORM{0}{4}:="adresse"
$TB_FORM{0}{5}:="adresse"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_champ(->[Adresses:53]AD_Adresse1:16)
$TB_HTML{$o}{4}:=[Adresses:53]AD_Adresse1:16
$TB_HTML{$o}{5}:="Adresse"
$TB_HTML{$o}{6}:="ad_adresse1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne fdp_row_start "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_champ(->[Adresses:53]AD_Adresse2:17)
$TB_HTML{$o}{4}:=[Adresses:53]AD_Adresse2:17
$TB_HTML{$o}{5}:="Adresse ligne 2"
$TB_HTML{$o}{6}:="ad_adresse2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_champ(->[Adresses:53]AD_Adresse3:18)
$TB_HTML{$o}{4}:=[Adresses:53]AD_Adresse3:18
$TB_HTML{$o}{5}:="Adresse ligne 3"
$TB_HTML{$o}{6}:="ad_adresse3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_champ(->[Adresses:53]AD_Code_postal:19)
$TB_HTML{$o}{4}:=[Adresses:53]AD_Code_postal:19
$TB_HTML{$o}{5}:="Code postal"
$TB_HTML{$o}{6}:="ad_code_postal"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne_autre "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:=UTL_champ(->[Adresses:53]AD_Ville:20)
$TB_HTML{$o}{4}:=[Adresses:53]AD_Ville:20
$TB_HTML{$o}{5}:="Ville"
$TB_HTML{$o}{6}:="ad_ville"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne_autre "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="adr_uid_origine"
$TB_HTML{$o}{4}:=String:C10($uid_origine->)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="adr_uid_origine"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)


