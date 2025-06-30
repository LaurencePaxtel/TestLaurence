//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04-03-19, 08:57:10
// ----------------------------------------------------
// Method: Web_Genere_Avoir
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($T_Json; $Status; $ids_factures)
C_LONGINT:C283($avoir_genere_count; $id_avoir)
C_REAL:C285($montantTTC_r)
C_BOOLEAN:C305($continu)
C_OBJECT:C1216($O_Output; $O_Data; $enregistrement_o)

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; "facturation"; Est un objet:K8:27)

$ids_factures:=OB Get:C1224($O_Data; "ids_factures"; Est un texte:K8:3)

READ WRITE:C146([Factures:86])
READ WRITE:C146([Factures_Lignes:87])

$status:="Failed"
$avoir_genere_count:=0

ARRAY TEXT:C222($tb_fac_id; 0)

UTL_Decoupe_texte(->$ids_factures; ->$tb_fac_id; ";")

For ($i; 1; Size of array:C274($tb_fac_id))
	QUERY:C277([Factures:86]; [Factures:86]ID:1=Num:C11($tb_fac_id{$i}); *)
	QUERY:C277([Factures:86];  & ; [Factures:86]FAC_Statut:16#"Annulée")
	
	MultiSoc_Filter(->[Factures:86])
	
	If (Records in selection:C76([Factures:86])=1) & (Not:C34(Locked:C147([Factures:86])))
		// Modifié par : Scanu Rémy - remy@connect-io.fr (27/07/2021)
		//[Factures]FAC_Statut:="Annulée"
		//STOCKER ENREGISTREMENT([Factures])
		
		DUPLICATE RECORD:C225([Factures:86])
		[Factures:86]FAC_Date_Piece:3:=Current date:C33(*)
		[Factures:86]FAC_No_Piece:2:=SO_Avoir_Prefixe+"/"+UTL_Numerotation_Piece(->[Factures:86]FAC_Date_Piece:3)
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (27/07/2021)
		// [Factures]FAC_Origine_ID = [Heberge]HB_ReferenceID et non l'id de la facture qui a servi à créer l'avoir
		//[Factures]FAC_Origine_ID:=Num($tb_fac_id{$i})
		[Factures:86]FAC_Statut:16:="Réglée"
		[Factures:86]FAC_Regle:41:=True:C214
		[Factures:86]FAC_Regle_Status_Color:44:=0x0044FC7B  // Réglé
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (27/07/2021)
		// On stocke l'id de la facture d'origine et on ne mets aucune réglement dans l'avoir
		[Factures:86]FAC_Avoir_ID:38:=Num:C11($tb_fac_id{$i})
		
		[Factures:86]FAC_Solde_Regle:26:=0
		
		[Factures:86]FAC_Montant_TTC:8:=-[Factures:86]FAC_Montant_TTC:8
		
		[Factures:86]FAC_Type:21:="Avoir"
		[Factures:86]FAC_Mode_Reglement:22:=""
		
		[Factures:86]FAC_Date_Echeance:20:=[Factures:86]FAC_Date_Piece:3
		
		[Factures:86]FAC_Loyer_Residuel:56:=0
		[Factures:86]FAC_Total_APL:54:=0
		[Factures:86]FAC_Total_Charges_APL:55:=0
		SAVE RECORD:C53([Factures:86])
		
		$id_avoir:=[Factures:86]ID:1
		
		QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=Num:C11($tb_fac_id{$i}))
		MultiSoc_Filter(->[Factures_Lignes:87])
		
		ARRAY LONGINT:C221($tb_facl_id; 0)
		SELECTION TO ARRAY:C260([Factures_Lignes:87]ID:1; $tb_facl_id)
		
		For ($j; 1; Size of array:C274($tb_facl_id))
			
			QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]ID:1=$tb_facl_id{$j})
			MultiSoc_Filter(->[Factures_Lignes:87])
			
			If (Not:C34(Locked:C147([Factures_Lignes:87])))
				[Factures_Lignes:87]FACL_Statut:17:="Annulée"
				SAVE RECORD:C53([Factures_Lignes:87])
				
				DUPLICATE RECORD:C225([Factures_Lignes:87])
				[Factures_Lignes:87]FACL_Piece_ID:3:=$id_avoir
				[Factures_Lignes:87]FACL_Origine_ID:34:=$tb_facl_id{$j}
				[Factures_Lignes:87]FACL_Type:25:="Avoir"
				[Factures_Lignes:87]FACL_Quantite:18:=[Factures_Lignes:87]FACL_Quantite:18*(-1)
				
				[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
				[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
				[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
				[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
				
				SAVE RECORD:C53([Factures_Lignes:87])
			Else 
				$continu:=False:C215
			End if 
			
		End for 
		
		//Calcul pied
		QUERY:C277([Factures:86]; [Factures:86]ID:1=$id_avoir)
		MultiSoc_Filter(->[Factures:86])
		
		QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
		MultiSoc_Filter(->[Factures_Lignes:87])
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (01/07/2021)
		$montantTTC_r:=[Factures:86]FAC_Montant_TTC:8
		Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
		
		[Factures:86]FAC_Montant_TTC:8:=$montantTTC_r
		SAVE RECORD:C53([Factures:86])
		
		//Facture d'origine
		// Modifié par : Scanu Rémy - remy@connect-io.fr (27/07/2021)
		//CHERCHER([Factures];[Factures]ID=Num($tb_fac_id{$i}))
		
		//[Factures]FAC_Avoir_ID:=[Factures]ID
		//STOCKER ENREGISTREMENT([Factures])
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (27/07/2021)
		// Il faut passé la facture d'origine à régler également
		$enregistrement_o:=ds:C1482.Factures.get(Num:C11($tb_fac_id{$i}))
		
		If ($enregistrement_o#Null:C1517)
			$enregistrement_o.FAC_Statut:="Réglée"
			$enregistrement_o.FAC_Regle:=True:C214
			$enregistrement_o.FAC_Regle_Status_Color:=0x0044FC7B  // Réglé
			$enregistrement_o.save()
		End if 
		
		$avoir_genere_count:=$avoir_genere_count+1
	Else 
		$continu:=False:C215
	End if 
	
End for 

If ($continu)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
	$avoir_genere_count:=-1
End if 

OB SET:C1220($O_Output; "Status"; $avoir_genere_count)
$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)