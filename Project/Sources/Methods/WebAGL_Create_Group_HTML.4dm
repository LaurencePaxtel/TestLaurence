//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25-01-19, 09:07:30
// ----------------------------------------------------
// Method: WebAGL_Create_Group_HTML
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_POINTER:C301($6)
C_TEXT:C284($7)
C_TEXT:C284($8)

C_TEXT:C284($input; $titre; $id; $type; $css_class_cg; $css_class)
C_LONGINT:C283($o)
C_POINTER:C301($HTML_CONTENT; $value)

ARRAY TEXT:C222($TB_HTML; 100; 15)

$HTML_CONTENT:=$1
$input:=$2
$type:=$3
$id:=$4
$titre:=$5
$value:=$6
$css_class_cg:=$7
$css_class:=$8

If ($type#"hidden")
	$HTML_CONTENT->:=$HTML_CONTENT->+"<div class=\"control-group "+$css_class_cg+" \">"
	
	If ($type#"multiple")
		$o:=$o+1
		
		$TB_HTML{$o}{1}:="label"
		$TB_HTML{$o}{2}:="label"
		$TB_HTML{$o}{3}:=$id
		$TB_HTML{$o}{4}:=""
		$TB_HTML{$o}{5}:=$titre
		$TB_HTML{$o}{6}:=$id+"Label"
		$TB_HTML{$o}{7}:="fdp_width100 search "
		$HTML_CONTENT->:=$HTML_CONTENT->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})
	End if 
	
End if 

$o:=$o+1
$TB_HTML{$o}{1}:=$input
$TB_HTML{$o}{2}:=$type
$TB_HTML{$o}{3}:=$id
$TB_HTML{$o}{4}:=String:C10($value->)
$TB_HTML{$o}{5}:=$id
$TB_HTML{$o}{6}:=$id
$TB_HTML{$o}{7}:="span7 search "+$css_class
$HTML_CONTENT->:=$HTML_CONTENT->+WebAGL_Create_Tag_HTML($TB_HTML{$o}{1}; $TB_HTML{$o}{2}; $TB_HTML{$o}{3}; $TB_HTML{$o}{4}; $TB_HTML{$o}{5}; $TB_HTML{$o}{6}; $TB_HTML{$o}{7})

If ($type#"hidden")
	$HTML_CONTENT->:=$HTML_CONTENT->+"</div>"
End if 