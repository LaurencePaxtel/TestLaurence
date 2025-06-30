//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 17-01-19, 15:33:26
// ----------------------------------------------------
// Method: Web_Doc_Form
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_BOOLEAN:C305($3)

C_TEXT:C284($suffix; $table_name)
C_LONGINT:C283($o; $origine_table_no; $doc_immeuble_id; $doc_bien_id)
C_POINTER:C301($ptr_table; $uid_origine)

C_TEXT:C284(SCRIPT)

ARRAY TEXT:C222($TB_HTML; 100; 15)
ARRAY TEXT:C222($TB_FORM; 0; 6)

$uid_origine:=$1

If (Count parameters:C259>1)
	$ptr_table:=$2
	$origine_table_no:=Table:C252($ptr_table)
	$table_name:=Lowercase:C14(Table name:C256($ptr_table))
	$suffix:="_basedoc"
End if 

RECORD_ACT_EDIT:=True:C214
FIX_DATE_FORMAT:="dd/mm/yyyy"

$TB_FORM{0}{1}:=""
$TB_FORM{0}{2}:="POST"
$TB_FORM{0}{3}:="document"
$TB_FORM{0}{4}:="document"
$TB_FORM{0}{5}:="document"
$TB_FORM{0}{6}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="doc_titre"
$TB_HTML{$o}{4}:=[Base_documentaire:90]DOC_Titre:8
$TB_HTML{$o}{5}:="Titre"
$TB_HTML{$o}{6}:="doc_titre"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="doc_document_nom"
$TB_HTML{$o}{4}:=[Base_documentaire:90]DOC_Document_Nom:6
$TB_HTML{$o}{5}:="Nom du document"
$TB_HTML{$o}{6}:="doc_document_nom"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="select"
$TB_HTML{$o}{2}:=""
$TB_HTML{$o}{3}:="doc_document_type"
$TB_HTML{$o}{4}:=outilsWebSelectGetOptionHTML("Type Document Upload")
$TB_HTML{$o}{5}:="Type"
$TB_HTML{$o}{6}:="doc_document_type"
$TB_HTML{$o}{7}:="fdp_span3 span7 iw_cg_width_third"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="doc_date"
$TB_HTML{$o}{4}:=String:C10([Base_documentaire:90]DOC_Date:7)
$TB_HTML{$o}{5}:="Créé Le"
$TB_HTML{$o}{6}:="doc_date"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder datepicker iw_cg_width_third readonly "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="doc_extension"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Format"
$TB_HTML{$o}{6}:="doc_extension"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder  iw_cg_width_third readonly"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="text"
$TB_HTML{$o}{3}:="doc_version"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Version"
$TB_HTML{$o}{6}:="doc_version"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder  iw_cg_width_third fdp_start_row"

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="textarea"
$TB_HTML{$o}{3}:="doc_notes"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Notes"
$TB_HTML{$o}{6}:="doc_notes"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder  iw_cg_width_full fdp_row_start "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="file"
$TB_HTML{$o}{3}:="doc_document_"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:="Document"
$TB_HTML{$o}{6}:="doc_document"
$TB_HTML{$o}{7}:="span7 search fdp_placeholder  fdp_row_start "

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="doc_origine_id"
$TB_HTML{$o}{4}:=String:C10($uid_origine->)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="doc_origine_id"
$TB_HTML{$o}{7}:=""

Case of 
	: ($ptr_table=->[Intervention:108])
		$doc_immeuble_id:=[Intervention:108]INT_Immeuble_ID:18
		$doc_bien_id:=[Intervention:108]INT_LC_ReferenceID:16
	: ($ptr_table=->[LesCentres:9])
		$doc_immeuble_id:=[LesCentres:9]LC_Immeuble_ID:84
		$doc_bien_id:=[LesCentres:9]ID:60
End case 

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="doc_immeuble_id"
$TB_HTML{$o}{4}:=String:C10($doc_immeuble_id)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="doc_immeuble_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="doc_bien_id"
$TB_HTML{$o}{4}:=String:C10($doc_bien_id)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="doc_bien_id"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="nav_module"
$TB_HTML{$o}{4}:=HTML_HOME+" / "+HTML_NAME_NAV_MODULE+" / "
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="nav_module"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="table_num"
$TB_HTML{$o}{4}:=String:C10($origine_table_no)
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="table_num"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="table_name"
$TB_HTML{$o}{4}:=$table_name
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="table_name"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="module_name"
$TB_HTML{$o}{4}:=""
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="module_name"
$TB_HTML{$o}{7}:=""

$o:=$o+1
$TB_HTML{$o}{1}:="input"
$TB_HTML{$o}{2}:="hidden"
$TB_HTML{$o}{3}:="mandatory_ligne"+$suffix
$TB_HTML{$o}{4}:="doc_titre;fakepath"
$TB_HTML{$o}{5}:=""
$TB_HTML{$o}{6}:="mandatory_ligne"+$suffix
$TB_HTML{$o}{7}:=""

ARRAY TEXT:C222($TB_HTML; $o; 15)
$0:=WEB_UTL_TAG_HTML(->$TB_HTML; ->$TB_FORM)