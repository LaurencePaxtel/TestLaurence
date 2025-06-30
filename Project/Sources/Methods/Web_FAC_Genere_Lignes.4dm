//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 21-02-19, 08:24:21
// ----------------------------------------------------
// Method: Web_FAC_Genere_Lignes
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($T_JSON; $Status)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id_piece; $id_bien; $id_locataire; $mois_numero; $annee; $nbre_jours_du_mois)
C_REAL:C285($total_charges; $total_apl)

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "facture"; Est un objet:K8:27)

$id_piece:=Num:C11(OB Get:C1224($O_Data; "id_piece"; Est un texte:K8:3))
$id_bien:=Num:C11(OB Get:C1224($O_Data; "id_bien"; Est un texte:K8:3))
$id_locataire:=Num:C11(OB Get:C1224($O_Data; "id_locataire"; Est un texte:K8:3))

$mois_numero:=Month of:C24(Current date:C33(*))
$annee:=Year of:C25(Current date:C33(*))

READ ONLY:C145([Locations:84])
READ ONLY:C145([Factures:86])
READ WRITE:C146([Factures_Lignes:87])

QUERY:C277([Factures:86]; [Factures:86]FAC_Bien_ID:28=$id_bien; *)
QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Locataire_ID:29=$id_locataire; *)
QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Mois:33=$mois_numero; *)
QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Annee:34=$annee)

MultiSoc_Filter(->[Factures:86])

If (Records in selection:C76([Factures:86])=0)
	
	READ WRITE:C146([Factures:86])
	QUERY:C277([Factures:86]; [Factures:86]ID:1=$id_piece; *)
	QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Statut:16="temp")
	MultiSoc_Filter(->[Factures:86])
	
	If (Records in selection:C76([Factures:86])=1)
		
		QUERY:C277([Locations:84]; [Locations:84]LOC_Bien_ID:5=$id_bien; *)
		QUERY:C277([Locations:84];  & ; [Locations:84]LOC_HB_ID:3=$id_locataire; *)
		QUERY:C277([Locations:84];  & ; [Locations:84]LOC_Facture:13=False:C215)
		MultiSoc_Filter(->[Locations:84])
		
		For ($i; 1; Records in selection:C76([Locations:84]))
			
			QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=$id_piece; *)
			QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Mois:23=$mois_numero; *)
			QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Annee:24=$annee; *)
			QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Service_ID:4=[Locations:84]ID:1; *)
			QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Type_Ligne:26="location"; *)
			QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Statut:17#"Annulée")
			
			MultiSoc_Filter(->[Factures_Lignes:87])
			
			If (Records in selection:C76([Factures_Lignes:87])=0)
				
				$adr_facturation:=Web_FAC_Get_Address([Locations:84]LOC_Bien_ID:5; [Locations:84]LOC_HB_ID:3)
				$nbre_jours_du_mois:=UTL_Get_Nbre_Jous_Mois(Current date:C33(*))
				
				//===========================================//
				// LOCATION
				//===========================================//
				
				CREATE RECORD:C68([Factures_Lignes:87])
				MultiSoc_Init_Structure(->[Factures_Lignes:87])
				[Factures_Lignes:87]FACL_Piece_ID:3:=$id_piece
				[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
				[Factures_Lignes:87]FACL_Service_ID:4:=[Locations:84]ID:1
				[Factures_Lignes:87]FACL_Mois:23:=$mois_numero
				[Factures_Lignes:87]FACL_Annee:24:=$annee
				[Factures_Lignes:87]FACL_Titre:6:=[Locations:84]LOC_Titre:14
				//[Factures_Lignes]FACL_Libelle:=[Locations]LOC_Titre
				[Factures_Lignes:87]FACL_Libelle:5:="Loyer"
				
				[Factures_Lignes:87]FACL_Date_Du:21:=Web_FAC_Get_Loc_Details("date_du"; [Locations:84]LOC_Date_Entree:9; [Locations:84]LOC_Date_Sortie:10)
				[Factures_Lignes:87]FACL_Date_Au:22:=Web_FAC_Get_Loc_Details("date_au"; [Locations:84]LOC_Date_Entree:9; [Locations:84]LOC_Date_Sortie:10)
				[Factures_Lignes:87]FACL_Quantite:18:=([Factures_Lignes:87]FACL_Date_Au:22-[Factures_Lignes:87]FACL_Date_Du:21)+1  //Web_FAC_Get_Loc_Details ("jours";[Locations]LOC_Date_Entree;[Locations]LOC_Date_Sortie)
				
				[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[Locations:84]LOC_Montant_Revise:7/$nbre_jours_du_mois
				
				[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
				[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
				
				[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
				[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
				
				[Factures_Lignes:87]FACL_Type_Ligne:26:="location"
				
				SAVE RECORD:C53([Factures_Lignes:87])
				UNLOAD RECORD:C212([Factures_Lignes:87])
				
				//===========================================//
				// APL
				//===========================================//
				
				QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Mois:23=$mois_numero; *)
				QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Annee:24=$annee; *)
				QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Service_ID:4=[Locations:84]ID:1; *)
				QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Type_Ligne:26="apl"; *)
				QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Statut:17#"Annulée")
				
				If (Records in selection:C76([Factures_Lignes:87])=0)
					
					READ ONLY:C145([Charges:92])
					QUERY:C277([Charges:92]; [Charges:92]CHA_Origine_ID:6=[Locations:84]ID:1; *)
					QUERY:C277([Charges:92];  & ; [Charges:92]CHA_Libelle:3="APL"; *)
					QUERY:C277([Charges:92];  & ; [Charges:92]CHA_Mois:9=$mois_numero; *)
					QUERY:C277([Charges:92];  & ; [Charges:92]CHA_Annee:10=$annee)
					
					MultiSoc_Filter(->[Charges:92])
					
					While (Not:C34(End selection:C36([Charges:92])))
						
						CREATE RECORD:C68([Factures_Lignes:87])
						MultiSoc_Init_Structure(->[Factures_Lignes:87])
						[Factures_Lignes:87]FACL_Piece_ID:3:=$id_piece
						[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
						[Factures_Lignes:87]FACL_Service_ID:4:=[Locations:84]ID:1
						[Factures_Lignes:87]FACL_Mois:23:=$mois_numero
						[Factures_Lignes:87]FACL_Annee:24:=$annee
						[Factures_Lignes:87]FACL_Titre:6:=[Charges:92]CHA_Libelle:3
						[Factures_Lignes:87]FACL_Libelle:5:=[Charges:92]CHA_Libelle:3
						
						
						[Factures_Lignes:87]FACL_Quantite:18:=1
						
						[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[Charges:92]CHA_Montant:5
						
						[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
						[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
						
						[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
						[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
						
						[Factures_Lignes:87]FACL_Type_Ligne:26:="apl"
						
						$total_apl:=$total_apl+[Factures_Lignes:87]FACL_Montant_TTC:12
						
						SAVE RECORD:C53([Factures_Lignes:87])
						UNLOAD RECORD:C212([Factures_Lignes:87])
						
						NEXT RECORD:C51([Charges:92])
					End while 
					
				End if 
				
				// Ajouté selon les spécifications du 09-09-2020
				[Factures:86]FAC_Total_APL:54:=$total_apl
				
				//===========================================//
				
				//===========================================//
				// Charges
				//===========================================//
				
				QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Mois:23=$mois_numero; *)
				QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Annee:24=$annee; *)
				QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Service_ID:4=[Locations:84]ID:1; *)
				QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Type_Ligne:26="charge"; *)
				QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Statut:17#"Annulée")
				
				If (Records in selection:C76([Factures_Lignes:87])=0)
					
					READ ONLY:C145([Charges:92])
					QUERY:C277([Charges:92]; [Charges:92]CHA_Origine_ID:6=[Locations:84]ID:1)
					MultiSoc_Filter(->[Charges:92])
					
					While (Not:C34(End selection:C36([Charges:92])))
						
						CREATE RECORD:C68([Factures_Lignes:87])
						MultiSoc_Init_Structure(->[Factures_Lignes:87])
						[Factures_Lignes:87]FACL_Piece_ID:3:=$id_piece
						[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
						[Factures_Lignes:87]FACL_Service_ID:4:=[Locations:84]ID:1
						[Factures_Lignes:87]FACL_Mois:23:=$mois_numero
						[Factures_Lignes:87]FACL_Annee:24:=$annee
						[Factures_Lignes:87]FACL_Titre:6:=[Charges:92]CHA_Libelle:3
						[Factures_Lignes:87]FACL_Libelle:5:=[Charges:92]CHA_Libelle:3
						
						
						[Factures_Lignes:87]FACL_Quantite:18:=1
						
						[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[Charges:92]CHA_Montant:5
						
						[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
						[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
						
						[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
						[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
						
						[Factures_Lignes:87]FACL_Type_Ligne:26:="charge"
						
						$total_charges:=$total_charges+[Factures_Lignes:87]FACL_Montant_TTC:12
						
						SAVE RECORD:C53([Factures_Lignes:87])
						UNLOAD RECORD:C212([Factures_Lignes:87])
						
						NEXT RECORD:C51([Charges:92])
					End while 
					
				End if 
				
				// Ajouté selon les spécifications du 09-09-2020
				[Factures:86]FAC_Total_Charges:53:=$total_charges
				[Factures:86]FAC_Total_APL:54:=$total_apl
				[Factures:86]FAC_Total_Charges_APL:55:=$total_charges+$total_apl
				
				//===========================================//
				
			Else 
				$continu:=False:C215
			End if 
			
			NEXT RECORD:C51([Locations:84])
		End for 
		
		If ($continu)
			[Factures:86]FAC_Mois:33:=$mois_numero
			[Factures:86]FAC_Annee:34:=$annee
			[Factures:86]FAC_Periode:32:=String:C10($mois_numero)+"/"+String:C10($annee)
			SAVE RECORD:C53([Factures:86])
			$status:="Success"
		Else 
			$status:="Failed"
		End if 
		
		UNLOAD RECORD:C212([Factures:86])
	End if 
	
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)