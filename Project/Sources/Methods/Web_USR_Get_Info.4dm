//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/04/20, 08:51:37
// ----------------------------------------------------
// Method: Web_USR_Get_Info
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data; $O_Output)
C_TEXT:C284($JSON)
C_LONGINT:C283($id_selected)

READ ONLY:C145([INtervenants:10])

$O_Data:=Web_AGL_Get_Post_Json_Data

$id_selected:=Num:C11(OB Get:C1224($O_Data; "id_selected"; Est un texte:K8:3))

If ($id_selected=0)
	$id_selected:=w_userUID
End if 

READ ONLY:C145([INtervenants:10])
QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=$id_selected)
MultiSoc_Filter(->[INtervenants:10])

If (Records in selection:C76([INtervenants:10])=1)
	
	ARRAY OBJECT:C1221($tb_object; 1)
	
	OB SET:C1220($tb_object{1}; "userid"; String:C10([INtervenants:10]ID:16); "user_nom_prenom"; [INtervenants:10]IN_NomPrénom:8)
	
	$JSON:=JSON Stringify array:C1228($tb_object)
	
Else 
	OB SET:C1220($O_Output; "Status"; "Failed")
	$JSON:=JSON Stringify:C1217($O_Output)
End if 

WEB SEND TEXT:C677($JSON)