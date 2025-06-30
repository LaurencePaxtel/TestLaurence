//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26/04/20, 08:40:40
// ----------------------------------------------------
// Method: Web_PLA_Get_HG_Liste
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data; $O_Output)
C_LONGINT:C283($id_selected; $i)

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "pla"; Est un objet:K8:27)

$id_selected:=Num:C11(OB Get:C1224($O_Data; "id_event"; Est un texte:K8:3))

If ($id_selected#0)
	
	READ ONLY:C145([HeberGement:5])
	
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Origine_ID:175=$id_selected)
	MultiSoc_Filter(->[HeberGement:5])
	
	ARRAY OBJECT:C1221($tb_object; Records in selection:C76([HeberGement:5]))
	
	FIRST RECORD:C50([HeberGement:5])
	
	For ($i; 1; Size of array:C274($tb_object))
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
		MultiSoc_Filter(->[LesCentres:9])
		OB SET:C1220($tb_object{$i}; "id"; String:C10([HeberGement:5]ID:168); "hb_id"; String:C10([HeberGement:5]HG_HB_ID:19); "hg_fichenumero"; [HeberGement:5]HG_FicheNuméro:3; "date"; String:C10([HeberGement:5]HG_Date:4); "prestation"; [LesCentres:9]LC_Nom:4)
		NEXT RECORD:C51([HeberGement:5])
	End for 
	
	$JSON:=JSON Stringify array:C1228($tb_object)
	
Else 
	OB SET:C1220($O_Output; "status"; "failed")
	$JSON:=JSON Stringify:C1217($O_Output)
End if 

WEB SEND TEXT:C677($JSON)