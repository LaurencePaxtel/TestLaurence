//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 14-12-18, 16:15:09
// ----------------------------------------------------
// Method: Web_Form_IRL
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)

C_TEXT:C284($trimestre; SCRIPT)
C_LONGINT:C283($o)
C_POINTER:C301($id)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$id:=$1

RECORD_ACT_EDIT:=True:C214

FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="irl"
$TB_FORM{0}{4}:=""
$TB_FORM{0}{5}:="irl"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="irc_annee"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Année"
$TB_HTML{$o}{6}:="irc_annee"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"

Case of 
	: ([IRL_CONFIG:85]IRC_IRL:2=1)
		$trimestre:=";;|1_1er trimestre_s|2_2ème trimestre|3_3ème trimestre|4_4ème trimestre"
	: ([IRL_CONFIG:85]IRC_IRL:2=2)
		$trimestre:=";;|1_1er trimestre|2_2ème trimestre_s|3_3ème trimestre|4_4ème trimestre"
	: ([IRL_CONFIG:85]IRC_IRL:2=3)
		$trimestre:=";;|1_1er trimestre|2_2ème trimestre|3_3ème trimestre_s|4_4ème trimestre"
	: ([IRL_CONFIG:85]IRC_IRL:2=4)
		$trimestre:=";;|1_1er trimestre|2_2ème trimestre|3_3ème trimestre|4_4ème trimestre_s"
	Else 
		$trimestre:=";;|1_1er trimestre|2_2ème trimestre|3_3ème trimestre|4_4ème trimestre"
End case 

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="irc_trimestre"
$TB_HTML{$o}{4}:=$trimestre
$TB_HTML{$o}{5}:="Trimestre de référence"
$TB_HTML{$o}{6}:="irc_trimestre"
$TB_HTML{$o}{7}:="fdp_span3 span7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="irc_irl"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="IRL"
$TB_HTML{$o}{6}:="irc_irl"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder fdp_row_start"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="irc_variation_annuelle"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Variation annuelle"
$TB_HTML{$o}{6}:="irc_variation_annuelle"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder"


$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="irc_date_publication"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Date de publication"
$TB_HTML{$o}{6}:="irc_date_publication"
$TB_HTML{$o}{7}:="fdp_span3 datepicker span7"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory"
$TB_HTML{$o}{4}:="irc_irl;irc_trimestre;irc_annee"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory"
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)

If (Count parameters:C259=1)
	$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)
Else 
	C_POINTER:C301($2)
	
	COPY ARRAY:C226($TB_HTML; $2->)
End if 