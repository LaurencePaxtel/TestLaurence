//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 20/01/22, 14:40:59
// ----------------------------------------------------
// Méthode : F_HebergementNewValider
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)  // On y passe ou pas
C_BOOLEAN:C305($1)  // Click sur le bouton NOUVEL HEBERGEMENT
C_BOOLEAN:C305($2)  // Gestion de la résevation multiple

C_BOOLEAN:C305($vb_OK)

C_DATE:C307(dateFiche_d)

vb_PasseR:=False:C215

If ($1)
	vb_ResGroupe:=False:C215
	vb_ResMulti:=False:C215
	
	vb_PasseR:=True:C214
	
	If ($2)
		
		If (wresMulti=1)  //Réservation multiple
			vl_NbBoucle:=Size of array:C274(<>ta_FamilleClé)
			
			If (vl_NbBoucle>0)
				vb_ResMulti:=True:C214
			Else 
				vb_PasseR:=False:C215
				StrAlerte(16; "")
			End if 
			
		Else 
			$vb_OK:=True:C214
		End if 
		
	Else 
		$vb_OK:=True:C214
	End if 
	
	If ($vb_OK)
		vl_NbBoucle:=1
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			<>vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
			
			vl_RéfU_HBB:=[HeBerge:4]HB_ReferenceID:1
			$vb_OK:=F_HébergementEtatCivilAge([HeBerge:4]HB_DateNéLe:5; Current date:C33)
			
			// Modifié par : Scanu Rémy (28/02/2023)
			If (Bool:C1537(Form:C1466.dupliquerFiche)=False:C215)
				
				Repeat 
					Tab_PopIn1n("Type"; -><>ta_TBEtCiv; ->va_IDT_Typ1)
					
					If (<>vb_EtatCivilAge)
						$vb_OK:=F_HébergementEtatCivil(va_IDT_Typ1; ve_HébergéAge)
					Else 
						$vb_OK:=True:C214
					End if 
					
				Until ($vb_OK)
				
			End if 
			
			If (va_IDT_Typ1>"")
				P_EtatCivil("Sexe_rIDTG_1"; va_IDT_Typ1)
				
				x_IDTG_1:=rIDTG_1
				x_IDTG_2:=rIDTG_2
				
				If (Substring:C12(va_IDT_Nom; 1; 2)="X0")  // Les inconnus commencent par X0
					
					If ([HeberGement:5]HG_Date:4#!00-00-00!)
						Uut_HébergéAgeInconnu([HeberGement:5]HG_Date:4)
					Else 
						Uut_HébergéAgeInconnu(Current date:C33)  // Date du jour(*)
					End if 
				End if 
				
				// Modifié par : Scanu Rémy (28/02/2023)
				If (Bool:C1537(Form:C1466.dupliquerFiche)=False:C215)
					outilsCleanVariable(->dateFiche_d)
					
					If (User in group:C338(Current user:C182; "dateFiche")=True:C214) & (<>ve_Si_ModeCHRS#1)
						
						Repeat 
							dateFiche_d:=Date:C102(Request:C163("Quelle est la date de prise en charge de votre usager svp ?"; String:C10(Current date:C33(*)); "Valider"; "Annuler"))
							
							Case of 
								: (dateFiche_d>Current date:C33(*))
									ALERT:C41("Il est impossible de créer des hébergements à une date postérieure à aujourd'hui.")
								: (dateFiche_d=!00-00-00!) & (OK#0)
									ALERT:C41("Date invalide, veuillez recommencer votre saisie.")
							End case 
							
						Until ((dateFiche_d#!00-00-00!) & (dateFiche_d<=Current date:C33(*))) | (OK=0)
						
					End if 
					
				End if 
				
				vb_PasseR:=(OK=1)
				
				If (vb_PasseR=True:C214)
					
					If (F_HébergementCtrlCréation(va_JourNuit; dateFiche_d))
						
						If (vl_NbHéberGements>0)
							
							// Modifié par : Scanu Rémy (10/03/2023)
							F_VariablesTransite(2; 1; True:C214)
							
						Else 
							F_VariablesTransite(3; 1; False:C215)
						End if 
						
						x_IDTG_1:=rIDTG_1
						x_IDTG_2:=rIDTG_2
					Else 
						vb_PasseR:=False:C215
					End if 
					
				End if 
				
			Else 
				vb_PasseR:=False:C215
			End if 
			
		Else 
			StrAlerte(3; "")
			vb_PasseR:=False:C215
		End if 
		
	End if 
	
End if 

$0:=vb_PasseR