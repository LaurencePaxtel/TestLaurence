//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 16/06/2020, 10:50:17
// ----------------------------------------------------
// Method: Web_Doc_Form_Liste
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($HTML_VIEW; $type)

ARRAY TEXT:C222($tb_headers_th; 0)

$type:=""

If (Count parameters:C259>0)
	$type:=$1
End if 

APPEND TO ARRAY:C911($tb_headers_th; " ")
APPEND TO ARRAY:C911($tb_headers_th; "Titre du document")
APPEND TO ARRAY:C911($tb_headers_th; "Type")
APPEND TO ARRAY:C911($tb_headers_th; "Créé Le")
APPEND TO ARRAY:C911($tb_headers_th; "Format")

If ($type="GI")
	APPEND TO ARRAY:C911($tb_headers_th; "Immeuble")
	APPEND TO ARRAY:C911($tb_headers_th; "Logement")
	APPEND TO ARRAY:C911($tb_headers_th; "Intervention")
End if 

WebAGL_Table_Liste(->$HTML_VIEW; ->$tb_headers_th; "list_table_basedoc")

$0:=$HTML_VIEW