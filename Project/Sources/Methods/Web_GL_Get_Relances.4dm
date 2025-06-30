//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07-02-19, 08:54:27
// ----------------------------------------------------
// Method: Web_GL_Get_Relances
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data)
C_LONGINT:C283($size; $i; $search_destinataire)
C_DATE:C307($search_date)
C_TEXT:C284($JSON)

READ ONLY:C145([Relances:94])
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([HeBerge:4])

ALL RECORDS:C47([Relances:94])

$O_Data:=Web_AGL_Get_Post_Json_Data

$search_date:=Date:C102(OB Get:C1224($O_Data; "search_date"; Est un texte:K8:3))
$search_destinataire:=Num:C11(OB Get:C1224($O_Data; "search_destinataire"; Est un texte:K8:3))


If ($search_date#!00-00-00!)
	QUERY SELECTION:C341([Relances:94]; [Relances:94]RLC_Date:11=$search_date)
End if 

If ($search_destinataire#0)
	QUERY SELECTION:C341([Relances:94]; [Relances:94]RLC_Destinataire_ID:12=$search_destinataire)
End if 

ORDER BY:C49([Relances:94]; [Relances:94]RLC_Date:11; <)

MultiSoc_Filter(->[Relances:94])

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

$size:=Records in selection:C76([Relances:94])

ARRAY OBJECT:C1221($tb_result; $size)

$i:=1

While (Not:C34(End selection:C36([Relances:94])))
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Relances:94]RLC_Destinataire_ID:12)
	QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Relances:94]RLC_Destinataire_ID:12)
	
	OB SET:C1220($tb_result{$i}; "id"; String:C10([Relances:94]ID:1); "rlc_date"; String:C10([Relances:94]RLC_Date:11); "rlc_libelle"; [Relances:94]RLC_Libelle:4; "rlc_retard"; String:C10([Relances:94]RLC_Nombre_Jours:9))
	
	$i:=$i+1
	
	NEXT RECORD:C51([Relances:94])
End while 

$JSON:=JSON Stringify array:C1228($tb_result)

WEB SEND TEXT:C677($JSON)

