//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Dossier
//{
//{          Mercredi 28 décembre 2011 à 14:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_POINTER:C301(${2})

C_TEXT:C284($va_Cas)
C_LONGINT:C283($vl_Position)
C_BOOLEAN:C305($vb_OK)

Case of 
	: ($1="SIAODossierSurChargement")
		
		If (7=7)
		Else 
			
			If (Is new record:C668([HeberGement:5]))
				MultiSoc_Init_Structure(->[HeberGement:5])
				
				If ([HeberGement:5]HG_NuitenCours:92=1)
					[HeberGement:5]HG_DossierSIAO:164:=""
					
					If ([HeberGement:5]HG_FamChef:103)
						
						Case of 
							: (<>vl_T_SIAOType=1)  //1 INSERTION
								$va_Cas:="2@"
							: (<>vl_T_SIAOType=2)  //2 URGENCE         
								$va_Cas:="1@"
							Else 
								$va_Cas:="xtx"
						End case 
						
						$vl_Position:=Find in array:C230(<>ta_HG_DosSIAO; $va_Cas)
						
						If ($vl_Position>0)
							[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{$vl_Position}
						Else 
							[HeberGement:5]HG_DossierSIAO:164:=""
						End if 
						
					Else 
						
						If ([HeberGement:5]HG_FamClé:104>"")
							$vl_Position:=Find in array:C230(<>ta_HG_DosSIAO; "3@")
							
							If ($vl_Position>0)
								[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{$vl_Position}
							End if 
							
						Else 
							$vl_Position:=Find in array:C230(<>ta_HG_DosSIAO; "4@")
							
							If ($vl_Position>0)
								[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{$vl_Position}
							End if 
							
						End if 
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
		
	: ($1="SIAODossierClic")
		//Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{125}; -><>ta_HG_DosSIAO; ->[HeberGement]HG_DossierSIAO)
		Tab_PopIn1("Dossier SIAO"; -><>ta_HG_DosSIAO; ->[HeberGement:5]HG_DossierSIAO:164)
		
		If ([HeberGement:5]HG_DossierSIAO:164>"")
			$va_Cas:=Substring:C12([HeberGement:5]HG_DossierSIAO:164; 1; 1)
			$va_Cas:=$va_Cas  //+"@"
		Else 
			$va_Cas:="xtx"
		End if 
		
		If ([HeberGement:5]HG_FamChef:103)
			
			Case of 
				: ($va_Cas="3")
					ALERT:C41("Un chef de famille ne peut pas être co-demandeur.")
					[HeberGement:5]HG_DossierSIAO:164:=""
			End case 
			
		Else 
			
			Case of 
				: ($va_Cas="1") | ($va_Cas="2")
					ALERT:C41("Une personne non chef de famille ne peut  être que co-demandeur.")
					[HeberGement:5]HG_DossierSIAO:164:=""
			End case 
			
		End if 
		
	: ($1="SIAODossierVider")
		[HeberGement:5]HG_DossierSIAO:164:=""
	: ($1="SIAODossierChef")
		
		If ([HeberGement:5]HG_NuitenCours:92=1)
			
			If ([HeberGement:5]HG_FamChef:103)
				
				If (7=8)
					
					Case of 
						: (<>vl_T_SIAOType=1)  //1 INSERTION
							$vl_Position:=Find in array:C230(<>ta_HG_DosSIAO; "2@")
						: (<>vl_T_SIAOType=2)  //2 URGENCE         
							$vl_Position:=Find in array:C230(<>ta_HG_DosSIAO; "1@")
						Else 
							$vl_Position:=-1
					End case 
					
				Else 
					$vl_Position:=-1
				End if 
				
				If ($vl_Position>0)
					[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{$vl_Position}
				Else 
					[HeberGement:5]HG_DossierSIAO:164:=""
				End if 
				
			End if 
			
		End if 
		
	: ($1="SIAODossierNonChef")
		
		If ([HeberGement:5]HG_NuitenCours:92=1)
			
			If ([HeberGement:5]HG_FamChef:103=False:C215)
				[HeberGement:5]HG_DossierSIAO:164:=""
				
				If (7=8)
					
					If ([HeberGement:5]HG_FamClé:104>"")
						$vl_Position:=Find in array:C230(<>ta_HG_DosSIAO; "3@")
						
						If ($vl_Position>0)
							[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{$vl_Position}
						End if 
						
					Else 
						$vl_Position:=Find in array:C230(<>ta_HG_DosSIAO; "4@")
						
						If ($vl_Position>0)
							[HeberGement:5]HG_DossierSIAO:164:=<>ta_HG_DosSIAO{$vl_Position}
						End if 
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	: ($1="SIAODossierCleLien")
		
		If ([HeberGement:5]HG_FamChef:103)
			$vb_OK:=F_SIAO_Dossier("SIAODossierChef")
		Else 
			$vb_OK:=F_SIAO_Dossier("SIAODossierNonChef")
		End if 
		
	: ($1="SIAODossierBtSaisie")
		
		If (7=8)
			
			If (<>te_RdsRub{8}{125}>0)
				
				If (<>tb_RdsVis{8}{125}=False:C215)  //Ne pas afficher à l'écran
				Else 
					OBJECT SET VISIBLE:C603(*; "164_Bt"; True:C214)
					OBJECT SET VISIBLE:C603(*; "164_ico@"; True:C214)
					OBJECT SET ENTERABLE:C238([HeberGement:5]HG_DossierSIAO:164; True:C214)
				End if 
				
			End if 
			
		End if 
		
	: ($1="SIAODossierBtVoir")
		
		If (7=8)
			
			If (<>te_RdsRub{8}{125}>0)
				
				If (<>tb_RdsVis{8}{125}=False:C215)  //Ne pas afficher à l'écran
				Else 
					OBJECT SET VISIBLE:C603(*; "164_Bt"; False:C215)
					OBJECT SET VISIBLE:C603(*; "164_ico@"; False:C215)
					OBJECT SET ENTERABLE:C238([HeberGement:5]HG_DossierSIAO:164; False:C215)
				End if 
				
			End if 
			
		End if 
		
End case 