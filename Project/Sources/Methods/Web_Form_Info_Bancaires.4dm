//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02-02-19, 02:03:55
// ----------------------------------------------------
// Method: Web_Form_Info_Bancaires
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($0; SCRIPT; $disabled)
ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)
C_LONGINT:C283($o)

RECORD_ACT_EDIT:=True:C214
$disabled:=""
FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="coordonnees_bancaires"
$TB_FORM{0}{4}:="coordonnees_bancaires"
$TB_FORM{0}{5}:="coordonnees_bancaires"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bqe_domiciliation"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Domiciliation"
$TB_HTML{$o}{6}:="bqe_domiciliation"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne fdp_row_start "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bqe_nom_bancaire"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Nom bancaire"
$TB_HTML{$o}{6}:="bqe_nom_bancaire"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bqe_iban"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="IBAN"
$TB_HTML{$o}{6}:="bqe_iban"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bqe_bic"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="BIC"
$TB_HTML{$o}{6}:="bqe_bic"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bqe_adresse_1"
$TB_HTML{$o}{4}:=[Banques:91]BQE_Adresse_1:11
$TB_HTML{$o}{5}:="Adresse"
$TB_HTML{$o}{6}:="bqe_adresse_1"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne fdp_row_start "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bqe_adresse_2"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Adresse ligne 2"
$TB_HTML{$o}{6}:="bqe_adresse_2"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bqe_adresse_3"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Adresse ligne 3"
$TB_HTML{$o}{6}:="bqe_adresse_3"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bqe_code_postal"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Code postal"
$TB_HTML{$o}{6}:="bqe_code_postal"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne_autre "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="bqe_ville"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Ville"
$TB_HTML{$o}{6}:="bqe_ville"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder adresse_ligne_autre "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="bqe_origine_id"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="bqe_origine_id"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)


