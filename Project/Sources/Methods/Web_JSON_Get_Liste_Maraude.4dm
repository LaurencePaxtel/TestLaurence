//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 10/11/18, 09:35:14
// ----------------------------------------------------
// Méthode : Web_JSON_Get_Liste_Maraude
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($type; $titre)
C_LONGINT:C283($L_Size; $i)
ARRAY TEXT:C222($ta_TBMaraud; 0)

$type:=$1
$titre:="Maraude "+$type

//$ta_TBMaraud:=Web_Get_Variable_Process(-><>ta_TBMaraud)
$values_c:=UTL_Web_Get_Enumeration_Values("Maraude")
If ($values_c.length#0)
	COLLECTION TO ARRAY:C1562($values_c; $ta_TBMaraud)
End if 


$L_Size:=Size of array:C274($ta_TBMaraud)

ARRAY OBJECT:C1221($result; $L_Size)

For ($i; 1; $L_Size)
	OB SET:C1220($result{$i}; "id"; Generate UUID:C1066)
	OB SET:C1220($result{$i}; "value"; $ta_TBMaraud{$i})
End for 

$object:=New object:C1471("title"; $titre; "type"; "radio"; "value"; $titre)
OB SET ARRAY:C1227($object; "list"; $result)

$JSON:=JSON Stringify:C1217($object)
WEB SEND TEXT:C677($JSON)