//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 15-12-18, 10:15:09
// ----------------------------------------------------
// Method: Web_GL_Get_Factures
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($search_type; $JSON)
C_LONGINT:C283($i; $search_reglement_id; $search_bien_id; $search_locataire_id)
C_DATE:C307($search_date)
C_OBJECT:C1216($O_Data)

READ ONLY:C145([Factures:86])
READ ONLY:C145([Factures_Lignes:87])
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([HeBerge:4])

ALL RECORDS:C47([Factures:86])

$O_Data:=Web_AGL_Get_Post_Json_Data

$search_date:=Date:C102(OB Get:C1224($O_Data; "search_date"; Est un texte:K8:3))

$search_bien_id:=Num:C11(OB Get:C1224($O_Data; "search_bien_id"; Est un texte:K8:3))
$search_locataire_id:=Num:C11(OB Get:C1224($O_Data; "search_locataire_id"; Est un texte:K8:3))

$search_type:=OB Get:C1224($O_Data; "search_type"; Est un texte:K8:3)

If ($search_date#!00-00-00!)
	QUERY SELECTION:C341([Factures:86]; [Factures:86]FAC_Date_Piece:3=$search_date)
End if 

If ($search_bien_id#0)
	QUERY SELECTION:C341([Factures:86]; [Factures:86]FAC_Bien_ID:28=$search_bien_id)
End if 

If ($search_locataire_id#0)
	QUERY SELECTION:C341([Factures:86]; [Factures:86]FAC_Locataire_ID:29=$search_locataire_id)
End if 

If ($search_type="non soldée")
	QUERY SELECTION:C341([Factures:86]; [Factures:86]FAC_Type:21="Définitive")
	//CHERCHER DANS SÉLECTION([Factures]; ds.Factures.get([Factures]ID).FAC_Solde_Du_cal>0)
End if 

If ($search_type="reglées")
	$search_reglement_id:=Num:C11(OB Get:C1224($O_Data; "search_reglement_id"; Est un texte:K8:3))
	
	READ ONLY:C145([Reglements:93])
	QUERY:C277([Reglements:93]; [Reglements:93]ID:1=$search_reglement_id)
	
	ARRAY TEXT:C222($tab_ids_factures_regles; 0)
	ARRAY LONGINT:C221($tb_ids_fac_regles; 0)
	
	UTL_Decoupe_texte(->[Reglements:93]REG_Origine_IDS:21; ->$tab_ids_factures_regles; ";")
	
	For ($j; 1; Size of array:C274($tab_ids_factures_regles))
		APPEND TO ARRAY:C911($tb_ids_fac_regles; Num:C11($tab_ids_factures_regles{$j}))
	End for 
	
	QUERY SELECTION WITH ARRAY:C1050([Factures:86]ID:1; $tb_ids_fac_regles)
End if 

ORDER BY:C49([Factures:86]; [Factures:86]FAC_Date_Piece:3; <)
MultiSoc_Filter(->[Factures:86])

SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)

ARRAY OBJECT:C1221($tb_result; Records in selection:C76([Factures:86]))

$i:=1

While (Not:C34(End selection:C36([Factures:86])))
	QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Factures:86]FAC_Destinataire_ID:11)
	QUERY:C277([Proprietaires:83]; [Proprietaires:83]ID:1=[LesCentres:9]LC_GL_Proprietaire_ID:66)
	
	var $factures_e : cs:C1710.FacturesEntity
	$factures_e:=ds:C1482.Factures.get([Factures:86]ID:1)
	
	OB SET:C1220($tb_result{$i}; "id"; String:C10([Factures:86]ID:1); \
		"fac_date"; String:C10([Factures:86]FAC_Date_Piece:3); \
		"fac_no_piece"; String:C10([Factures:86]FAC_No_Piece:2); \
		"fac_destinataire"; [Factures:86]FAC_Destinataire_Nom:13; \
		"fac_montant_ht"; String:C10([Factures:86]FAC_Montant_HT:6); \
		"fac_montant_ttc"; String:C10([Factures:86]FAC_Montant_TTC:8); \
		"fac_solde_du"; String:C10($factures_e.FAC_Solde_Du_cal); \
		"fac_solde_regle"; String:C10([Factures:86]FAC_Solde_Regle:26); \
		"fac_date_echeance"; String:C10([Factures:86]FAC_Date_Echeance:20); \
		"fac_statut"; String:C10([Factures:86]FAC_Statut:16); \
		"fac_cloture"; String:C10([Factures:86]FAC_Cloture:10); \
		"fac_centre_nom"; [LesCentres:9]LC_GL_Nom_Suite:63; \
		"fac_locataire_nom"; [Factures:86]FAC_Locataire_Nom:31; \
		"fac_proprietaire_nom"; [Factures:86]FAC_Bien_Proprietaire_Nom:36; \
		"fac_bien_id"; String:C10([Factures:86]FAC_Bien_ID:28); \
		"fac_locataire_id"; String:C10([Factures:86]FAC_Locataire_ID:29); \
		"fac_periode"; [Factures:86]FAC_Periode:32; \
		"fac_bien_nom"; [Factures:86]FAC_Bien_Nom:30; \
		"fac_type"; [Factures:86]FAC_Type:21; \
		"fac_avoir_id"; String:C10([Factures:86]FAC_Avoir_ID:38))
	
	$i:=$i+1
	NEXT RECORD:C51([Factures:86])
End while 

$JSON:=JSON Stringify array:C1228($tb_result)

WEB SEND TEXT:C677($JSON)