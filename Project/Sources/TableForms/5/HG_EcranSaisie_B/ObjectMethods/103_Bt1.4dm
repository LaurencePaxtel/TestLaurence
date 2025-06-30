C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($va_Type)
C_LONGINT:C283($vl_Position1)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		// Modified by: Kevin HASSAL (20-12-2018)
		// Correction du bug de sélection du chef de famille Oui/Non
		If ([HeberGement:5]HG_FamChef:103=False:C215)
			x1:=0
			x2:=1
		Else 
			x1:=1
			x2:=0
		End if 
		
	Else 
		
		If (7=7)
			
			//6/1/2012
			If ([HeberGement:5]HG_FamChef:103=False:C215)
				$vl_Position1:=Position:C15("("; [HeberGement:5]HG_EtatCivil:20)
				$va_Type:=""
				
				If ($vl_Position1>0)
					$va_Type:=Substring:C12([HeberGement:5]HG_EtatCivil:20; $vl_Position1+1; 2)
				End if 
				
				$vb_OK:=($va_Type="FP")
				$vb_OK:=$vb_OK | ($va_Type="HP")
				
				If ($vb_OK)
					ALERT:C41("Enfants avec parents "+"ne peuvent pas être chef de famille.")
					
					x1:=0
					x2:=1
				Else 
					[HeberGement:5]HG_FamChef:103:=(x1=1)
					
					P_HG_FamilleChef(1)
				End if 
				
			End if 
			
			F_SIAO_Dossier("SIAODossierChef")
		Else 
			
			If (7=7)
				
				If ([HeberGement:5]HG_FamChef:103=False:C215)
					$va_Type:=Substring:C12([HeberGement:5]HG_EtatCivil:20; Length:C16([HeberGement:5]HG_EtatCivil:20)-2; 2)
					
					$vb_OK:=($va_Type="FP")
					$vb_OK:=$vb_OK | ($va_Type="HP")
					$vb_OK:=$vb_OK | ($va_Type="FS")
					$vb_OK:=$vb_OK | ($va_Type="HS")
					
					If ($vb_OK)
						
						If (i_Confirmer("Homme seul, femme seule, enfants avec parents "+"ne peuvent pas être chef de famille."+<>va_CR+"Si vous voulez quand même le faire cliquez sur OK sinon Annuler !"))
							[HeberGement:5]HG_FamChef:103:=(x1=1)
							P_HG_FamilleChef(1)
						Else 
							x1:=0
							x2:=1
						End if 
						
					Else 
						[HeberGement:5]HG_FamChef:103:=(x1=1)
						P_HG_FamilleChef(1)
					End if 
					
				End if 
				
				F_SIAO_Dossier("SIAODossierChef")
			Else 
				//Ancienne méthode : jusqu'au 03/02/2010  
				[HeberGement:5]HG_FamChef:103:=(x1=1)
				
				P_HG_FamilleChef(1)
			End if 
			
		End if 
		
End case 