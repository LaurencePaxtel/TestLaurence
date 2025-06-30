//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02-02-19, 08:07:03
// ----------------------------------------------------
// Method: Web_GL_Get_Reglements
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_OBJECT:C1216($O_Data)
C_LONGINT:C283($size; $i; $search_destinataire)
C_DATE:C307($search_date_du; $search_date_au)
C_TEXT:C284($JSON)

READ ONLY:C145([Reglements:93])

READ ONLY:C145([LesCentres:9])
READ ONLY:C145([HeBerge:4])

ALL RECORDS:C47([Reglements:93])
MultiSoc_Filter(->[Reglements:93])

ORDER BY:C49([Reglements:93]; [Reglements:93]REG_Date_Piece:4; <)

$O_Data:=Web_AGL_Get_Post_Json_Data

$search_date_du:=Date:C102(OB Get:C1224($O_Data; "search_date_du"; Is text:K8:3))
$search_date_au:=Date:C102(OB Get:C1224($O_Data; "search_date_au"; Is text:K8:3))
$search_destinataire:=Num:C11(OB Get:C1224($O_Data; "search_destinataire"; Is text:K8:3))

If (($search_date_du#!00-00-00!) & ($search_date_au#!00-00-00!))
	QUERY SELECTION:C341([Reglements:93]; [Reglements:93]REG_Date_Piece:4>=$search_date_du; *)
	QUERY SELECTION:C341([Reglements:93];  & ; [Reglements:93]REG_Date_Piece:4<=$search_date_au)
End if 

If ($search_destinataire#0)
	QUERY SELECTION:C341([Reglements:93]; [Reglements:93]REG_Destinataire_ID:9=$search_destinataire)
End if 

SET DATABASE PARAMETER:C642(Dates inside objects:K37:73; String type without time zone:K37:86)

$size:=Records in selection:C76([Reglements:93])

ARRAY OBJECT:C1221($tb_result; $size)

$i:=1

While (Not:C34(End selection:C36([Reglements:93])))
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Reglements:93]REG_Destinataire_ID:9)
	QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Reglements:93]REG_Destinataire_ID:9)
	
	OB SET:C1220($tb_result{$i}; "id"; String:C10([Reglements:93]ID:1); "reg_date"; String:C10([Reglements:93]REG_Date_Piece:4); "reg_no_piece"; String:C10([Reglements:93]REG_No_Piece:3); "reg_destinataire"; [Reglements:93]REG_Destinataire_Nom:11; "reg_montant"; String:C10([Reglements:93]REG_Montant:5); "reg_date_echeance"; String:C10([Reglements:93]REG_Date_Echeance:8); "reg_statut"; String:C10([Reglements:93]REG_Statut:12); "reg_mode_reglement"; [Reglements:93]REG_Mode_Reglement:7; "reg_bien_nom"; [Reglements:93]REG_Bien_Nom:26; "reg_locataire_nom"; [Reglements:93]REG_Locataire_Nom:27)
	
	$i:=$i+1
	NEXT RECORD:C51([Reglements:93])
End while 

$JSON:=JSON Stringify array:C1228($tb_result)

WEB SEND TEXT:C677($JSON)

