//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 03-03-19, 15:37:18
// ----------------------------------------------------
// Method: Web_Reglement_Auto
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($T_Json; $Status; $ids_factures)
C_LONGINT:C283($reg_genere_count; $bien_id_old; $locataire_id_old; $id_facture; $id_el)
C_REAL:C285($montant_regle)
C_BOOLEAN:C305($continu)
C_OBJECT:C1216($O_Output; $O_Data)

ARRAY TEXT:C222($tb_fac_id; 0)
ARRAY LONGINT:C221($id_ai; 0)
var $facture_e : cs:C1710.FacturesEntity

READ WRITE:C146([Factures:86])

$O_Output:=New object:C1471

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; "reglement"; Est un objet:K8:27)

$ids_factures:=OB Get:C1224($O_Data; "ids_factures"; Est un texte:K8:3)
$status:="Failed"

UTL_Decoupe_texte(->$ids_factures; ->$tb_fac_id; ";")
outilsManageArray(1; ->$tb_fac_id; ->$id_ai)

// Modifié par : Scanu Rémy - remy@connect-io.fr (13/10/2021)
QUERY WITH ARRAY:C644([Factures:86]ID:1; $id_ai)
$facture_e:=ds:C1482.Factures.get([Factures:86]ID:1)

If (Records in selection:C76([Factures:86])>1)
	ORDER BY:C49([Factures:86]; [Factures:86]FAC_Annee:34; <; [Factures:86]FAC_Mois:33; <)
	
	$id_el:=[Factures:86]ID:1
End if 

$continu:=True:C214

For ($i; 1; Size of array:C274($tb_fac_id))
	QUERY:C277([Factures:86]; [Factures:86]ID:1=Num:C11($tb_fac_id{$i}))
	
	If (Records in selection:C76([Factures:86])=1)
		
		Case of 
			: ($i=1) | (($i>1) & ($montant_regle=0))
				$id_facture:=[Factures:86]ID:1
				$continue_b:=True:C214
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (11/10/2021)
				If (Size of array:C274($tb_fac_id)>1)
					$continue_b:=([Factures:86]ID:1=$id_el)
				End if 
				
				If ($continue_b=True:C214)
					$montant_regle:=$facture_e.FAC_Net_A_Payer_cal-[Factures:86]FAC_Solde_Regle:26
				End if 
				
			: ([Factures:86]FAC_Bien_ID:28#$bien_id_old) | ([Factures:86]FAC_Locataire_ID:29#$locataire_id_old)  // S'il ne n'agit pas du même locataire OU du même bien
				$continu:=False:C215
		End case 
		
		If ($continu=True:C214)  // Vérification qu'on facture le même bien pour le même locataire si plusieurs factures sont sélectionnées par l'utilisateur
			$bien_id_old:=[Factures:86]FAC_Bien_ID:28
			$locataire_id_old:=[Factures:86]FAC_Locataire_ID:29
			
			$reg_genere_count:=$reg_genere_count+1
			
			If (([Factures:86]FAC_Mode_Reglement:22="Chèque") | ([Factures:86]FAC_Mode_Reglement:22="Prélèvement"))
				CLEAR VARIABLE:C89($continu)
				
				$reg_genere_count:=-1
				$i:=Size of array:C274($tb_fac_id)
			End if 
			
		End if 
		
	End if 
	
End for 

If ($continu)
	CREATE RECORD:C68([Reglements:93])
	MultiSoc_Init_Structure(->[Reglements:93])
	
	[Reglements:93]REG_Bien_ID:24:=[Factures:86]FAC_Bien_ID:28
	[Reglements:93]REG_Bien_Nom:26:=[Factures:86]FAC_Bien_Nom:30
	[Reglements:93]REG_Locataire_ID:25:=[Factures:86]FAC_Locataire_ID:29
	[Reglements:93]REG_Locataire_Nom:27:=[Factures:86]FAC_Locataire_Nom:31
	[Reglements:93]REG_Date_Echeance:8:=[Factures:86]FAC_Date_Echeance:20
	[Reglements:93]REG_Mode_Reglement:7:=[Factures:86]FAC_Mode_Reglement:22
	[Reglements:93]REG_Montant:5:=$montant_regle
	[Reglements:93]REG_Origine_IDS:21:=$ids_factures
	[Reglements:93]REG_Date_Piece:4:=Current date:C33(*)
	[Reglements:93]REG_Origine_Table_No:19:=Table:C252(->[Factures:86])
	[Reglements:93]REG_No_Piece:3:="RC/"+UTL_Numerotation_Piece(->[Reglements:93]REG_Date_Piece:4)
	[Reglements:93]REG_Statut:12:=""
	
	SAVE RECORD:C53([Reglements:93])
	
	//===============================================//
	// IMPUTATION FACTURES
	//===============================================//
	QUERY WITH ARRAY:C644([Factures:86]ID:1; $id_ai)
	$facture_e:=ds:C1482.Factures.get([Factures:86]ID:1)
	
	While (Not:C34(End selection:C36([Factures:86])))
		[Factures:86]FAC_Solde_Regle:26:=$facture_e.FAC_Net_A_Payer_cal
		
		outilsManageFacture(3; False:C215)
		
		[Factures:86]FAC_Statut:16:="Réglée"
		SAVE RECORD:C53([Factures:86])
		
		NEXT RECORD:C51([Factures:86])
	End while 
	
	UNLOAD RECORD:C212([Factures:86])
End if 

OB SET:C1220($O_Output; "Status"; $reg_genere_count)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)