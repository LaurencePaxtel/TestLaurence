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
C_OBJECT:C1216($0)
C_BOOLEAN:C305($1)

C_TEXT:C284($T_JSON; $T_Zone; $T_Action)
C_LONGINT:C283($i)
C_BOOLEAN:C305($keepWebVariable_b)
C_OBJECT:C1216($O_Variables_web; $O_Request; $O_Data)

$O_Variables_web:=New object:C1471

ARRAY TEXT:C222($rT_names; 0)
ARRAY TEXT:C222($rT_values; 0)

WEB GET VARIABLES:C683($rT_names; $rT_values)

For ($i; 1; Size of array:C274($rT_names))
	OB SET:C1220($O_Variables_web; $rT_names{$i}; $rT_values{$i})
End for 

If (Count parameters:C259=1)
	$keepWebVariable_b:=$1
End if 

Case of 
	: ($keepWebVariable_b=True:C214)
		$O_Data:=OB Copy:C1225($O_Variables_web)
	: (OB Is defined:C1231($O_Variables_web; "json"))
		$T_JSON:=OB Get:C1224($O_Variables_web; "json"; Est un texte:K8:3)
		
		$O_Request:=JSON Parse:C1218($T_JSON)
		
		$T_Zone:=OB Get:C1224($O_Request; "zone"; Est un texte:K8:3)
		$T_Action:=OB Get:C1224($O_Request; "action"; Est un texte:K8:3)
		$O_Data:=OB Get:C1224($O_Request; "data"; Est un objet:K8:27)
		
	: (Find in array:C230(w_variables; "json")#0)  // le cas du greg
		$T_JSON:=w_valeurs{Find in array:C230(w_variables; "json")}
		$O_Request:=JSON Parse:C1218($T_JSON)
		$O_Data:=OB Get:C1224($O_Request; "data"; Est un objet:K8:27)
	Else 
		TRACE:C157
End case 

$0:=$O_Data