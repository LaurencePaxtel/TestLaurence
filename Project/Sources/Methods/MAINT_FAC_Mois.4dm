//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 17/03/20, 15:30:45
// ----------------------------------------------------
// Method: MAINT_FAC_Mois
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_BOOLEAN:C305($continu)
C_LONGINT:C283($mois_numero)

ARRAY LONGINT:C221($tb_fac_mois; 0)
ARRAY TEXT:C222($tb_fac_mois_annee; 0)

$continu:=True:C214

READ WRITE:C146([Factures:86])

ALL RECORDS:C47([Factures:86])


While (Not:C34(End selection:C36([Factures:86])))
	
	QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
	MultiSoc_Filter(->[Factures_Lignes:87])
	
	While (Not:C34(End selection:C36([Factures_Lignes:87])))
		
		ARRAY TEXT:C222($tb_données; 0)
		UTL_Cut_Text(->[Factures_Lignes:87]FACL_Service_Ids:30; ->$tb_données; ";")
		ARRAY LONGINT:C221($tb_donnees_num; Size of array:C274($tb_données))
		
		For ($j; 1; Size of array:C274($tb_données))
			$tb_donnees_num{$j}:=Num:C11($tb_données{$j})
		End for 
		
		READ ONLY:C145([HeberGement:5])
		
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; $tb_donnees_num)
		
		While (Not:C34(End selection:C36([HeberGement:5])))
			$mois_numero:=Month of:C24([HeberGement:5]HG_Date:4)
			$mois_annee_libelle:=String:C10($mois_numero; "0#")+"/"+String:C10(Year of:C25([HeberGement:5]HG_Date:4))
			
			If (Find in array:C230($tb_fac_mois_annee; $mois_annee_libelle)<0)
				APPEND TO ARRAY:C911($tb_fac_mois; $mois_numero)
				APPEND TO ARRAY:C911($tb_fac_mois_annee; $mois_annee_libelle)
			End if 
			NEXT RECORD:C51([HeberGement:5])
		End while 
		
		NEXT RECORD:C51([Factures_Lignes:87])
	End while 
	
	
	//======== Mois de facturation =======//
	
	If (Size of array:C274($tb_fac_mois_annee)=1)
		[Factures:86]FAC_Mois:33:=$tb_fac_mois{1}
		[Factures:86]FAC_Mois_Annee:48:=$tb_fac_mois_annee{1}
		SAVE RECORD:C53([Factures:86])
	End if 
	
	DELETE FROM ARRAY:C228($tb_fac_mois; 1; Size of array:C274($tb_fac_mois))
	DELETE FROM ARRAY:C228($tb_fac_mois_annee; 1; Size of array:C274($tb_fac_mois_annee))
	
	
	//================//
	
	
	NEXT RECORD:C51([Factures:86])
End while 

If (Not:C34($continu))
	ALERT:C41("erreur")
Else 
	ALERT:C41("Opération effectuée avec succès")
End if 

