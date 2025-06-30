//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 11-02-19, 08:11:05
// ----------------------------------------------------
// Method: Web_GL_Get_Colocataires
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data)
C_LONGINT:C283($size; $i; $record_id)
C_TEXT:C284($JSON)

READ ONLY:C145([Locations:84])
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([HeBerge:4])

$O_Data:=Web_AGL_Get_Post_Json_Data

$record_id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

If ($record_id#0)
	QUERY:C277([Locations:84]; [Locations:84]ID:1=$record_id)
End if 

MultiSoc_Filter(->[Locations:84])

If (Records in selection:C76([Locations:84])=1)
	SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
	
	QUERY:C277([Location_LK_Colocataires:95]; [Location_LK_Colocataires:95]COL_LOC_ID:3=[Locations:84]ID:1)
	MultiSoc_Filter(->[Location_LK_Colocataires:95])
	
	$size:=Records in selection:C76([Location_LK_Colocataires:95])
	
	ARRAY LONGINT:C221($tb_locataires_ids; 0)
	SELECTION TO ARRAY:C260([Location_LK_Colocataires:95]ID:1; $tb_locataires_ids)
	
	ARRAY OBJECT:C1221($tb_result; $size)
	
	$i:=1
	
	For ($i; 1; Size of array:C274($tb_locataires_ids))
		QUERY:C277([Location_LK_Colocataires:95]; [Location_LK_Colocataires:95]ID:1=$tb_locataires_ids{$i})
		QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Location_LK_Colocataires:95]COL_ID:2)
		
		If (Records in selection:C76([HeBerge:4])=1)
			OB SET:C1220($tb_result{$i}; "id"; String:C10([HeBerge:4]ID:65); "loc_nom"; [HeBerge:4]HB_Nom:3; "loc_prenom"; [HeBerge:4]HB_Prénom:4)
		End if 
		
	End for 
	
Else 
	ARRAY OBJECT:C1221($tb_result; 0)
End if 

$JSON:=JSON Stringify array:C1228($tb_result)

WEB SEND TEXT:C677($JSON)