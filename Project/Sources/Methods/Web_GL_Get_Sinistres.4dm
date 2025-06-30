//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02-02-19, 08:00:48
// ----------------------------------------------------
// Method: Web_GL_Get_Sinistres
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_OBJECT:C1216($O_Data)
C_LONGINT:C283($i; $search_immeuble_id; $search_bien_id; $search_proprietaire_id)
C_TEXT:C284($JSON)

ARRAY LONGINT:C221($tb_id; 0)

READ ONLY:C145([Sinistres:89])

ALL RECORDS:C47([Sinistres:89])
MultiSoc_Filter(->[Sinistres:89])

ORDER BY:C49([Sinistres:89]; [Sinistres:89]SIN_Date:2; <)

$O_Data:=Web_AGL_Get_Post_Json_Data

$search_immeuble_id:=Num:C11(OB Get:C1224($O_Data; "search_immeuble_id"; Est un texte:K8:3))
$search_bien_id:=Num:C11(OB Get:C1224($O_Data; "search_bien_id"; Est un texte:K8:3))
$search_proprietaire_id:=Num:C11(OB Get:C1224($O_Data; "search_proprietaire_id"; Est un texte:K8:3))

If ($search_immeuble_id#0)
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Immeuble_ID:84=$search_immeuble_id)
	MultiSoc_Filter(->[LesCentres:9])
	
	ARRAY LONGINT:C221($tb_bien_ids; 0)
	SELECTION TO ARRAY:C260([LesCentres:9]ID:60; $tb_bien_ids)
	
	QUERY SELECTION WITH ARRAY:C1050([Sinistres:89]SIN_Origine_ID:12; $tb_bien_ids)
End if 

If ($search_bien_id#0)
	QUERY SELECTION:C341([Sinistres:89]; [Sinistres:89]SIN_Origine_ID:12=$search_bien_id)
End if 


If ($search_proprietaire_id#0)
	
	ARRAY LONGINT:C221($tb_biens_ids; 0)
	
	READ ONLY:C145([LesCentres:9])
	
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_GL_Proprietaire_ID:66=$search_proprietaire_id)
	SELECTION TO ARRAY:C260([LesCentres:9]ID:60; $tb_biens_ids)
	
	QUERY SELECTION WITH ARRAY:C1050([Sinistres:89]SIN_Origine_ID:12; $tb_biens_ids)
	
End if 

SELECTION TO ARRAY:C260([Sinistres:89]ID:1; $tb_id)
ARRAY OBJECT:C1221($tb_result; Size of array:C274($tb_id))

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

For ($i; 1; Size of array:C274($tb_id))
	
	QUERY:C277([Sinistres:89]; [Sinistres:89]ID:1=$tb_id{$i})
	MultiSoc_Filter(->[Sinistres:89])
	
	QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Sinistres:89]SIN_Origine_ID:12)
	MultiSoc_Filter(->[LesCentres:9])
	
	QUERY:C277([Immeuble:105]; [Immeuble:105]ID:1=[LesCentres:9]LC_Immeuble_ID:84)
	MultiSoc_Filter(->[Immeuble:105])
	
	OB SET:C1220($tb_result{$i}; "id"; String:C10([Sinistres:89]ID:1); "sin_date"; String:C10([Sinistres:89]SIN_Date:2); "sin_libelle"; [Sinistres:89]SIN_Libelle:3; "sin_nom_bien"; [LesCentres:9]LC_GL_Nom_Suite:63; "sin_cout"; String:C10([Sinistres:89]SIN_Cout:5); "sin_assurance_pe"; String:C10([Sinistres:89]SIN_Assurance_PE:6); "sin_assurance_contrat_no"; [Sinistres:89]SIN_Assurance_Contrat_No:9; "sin_assurance_montant"; String:C10([Sinistres:89]SIN_Assurance_Montant:10); "sin_travaux_cloture"; String:C10([Sinistres:89]SIN_Travaux_Cloture:11); "sin_immeuble_nom"; [Immeuble:105]IMM_Nom:3)
	
End for 

$JSON:=JSON Stringify array:C1228($tb_result)

WEB SEND TEXT:C677($JSON)

