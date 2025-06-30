//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/11/18, 09:08:48
// ----------------------------------------------------
// Méthode : Web_AGL_Get_Post_Json_Data
// Description
// $0 : Return object of posted data
//
// Paramètres
// ----------------------------------------------------

C_OBJECT:C1216($O_Variables_web)
C_TEXT:C284($T_JSON; $T_Zone; $T_Action)
C_OBJECT:C1216($O_Request; $O_Data; $0)
C_LONGINT:C283($i)

$O_Variables_web:=New object:C1471

ARRAY TEXT:C222($rT_names; 0)
ARRAY TEXT:C222($rT_values; 0)

WEB GET VARIABLES:C683($rT_names; $rT_values)

For ($i; 1; Size of array:C274($rT_names))
	OB SET:C1220($O_Variables_web; $rT_names{$i}; $rT_values{$i})
End for 

If (OB Is defined:C1231($O_Variables_web; "json"))
	
	$T_JSON:=OB Get:C1224($O_Variables_web; "json"; Est un texte:K8:3)
	
	$O_Request:=JSON Parse:C1218($T_JSON)
	
	$T_Zone:=OB Get:C1224($O_Request; "zone"; Est un texte:K8:3)
	$T_Action:=OB Get:C1224($O_Request; "action"; Est un texte:K8:3)
	$O_Data:=OB Get:C1224($O_Request; "data"; Est un objet:K8:27)
	
End if 

$0:=$O_Data