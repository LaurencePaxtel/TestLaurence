//Formule format : LC_EcranSaisie
$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		C_BOOLEAN:C305(chk_LC_Facturation_1_Active; chk_LC_Facturation_2_Active; chk_LC_Facturation_3_Active)
		
		chk_LC_Facturation_1_Active:=[LesCentres:9]LC_Facturation_1_Active:81
		chk_LC_Facturation_2_Active:=[LesCentres:9]LC_Facturation_2_Active:82
		chk_LC_Facturation_3_Active:=[LesCentres:9]LC_Facturation_3_Active:83
		
		If (chk_LC_Facturation_1_Active=False:C215) & (chk_LC_Facturation_2_Active=False:C215) & (chk_LC_Facturation_3_Active=False:C215)
			chk_LC_Facturation_1_Active:=True:C214
			[LesCentres:9]LC_Facturation_1_Active:81:=chk_LC_Facturation_1_Active
		End if 
		
		ARRAY TEXT:C222(<>ta_TVA_2; 0)
		COPY ARRAY:C226(<>ta_TVA; <>ta_TVA_2)
		
		ARRAY TEXT:C222(<>ta_TVA_3; 0)
		COPY ARRAY:C226(<>ta_TVA; <>ta_TVA_3)
		
		ve_JourOuverture:=0
		ve_JourFermeture:=0
		ve_MoisOuverture:=0
		ve_MoisFermeture:=0
		
		If (Is new record:C668([LesCentres:9]))
			MultiSoc_Init_Structure(->[LesCentres:9])
			[LesCentres:9]LC_Niveau:52:=1
			
			If (<>vb_T_SansPrestations)
				OBJECT SET VISIBLE:C603([LesCentres:9]LC_Prestation:55; False:C215)
				[LesCentres:9]LC_Excuse:49:=True:C214
			Else 
				OBJECT SET VISIBLE:C603([LesCentres:9]LC_Prestation:55; True:C214)
			End if 
			
			P_CentreOuverture(1; ->[LesCentres:9]LC_JourMoisOuverture:58; ->ve_JourOuverture; ->ve_MoisOuverture; ->ta_LesMoisOuverts)
			P_CentreOuverture(1; ->[LesCentres:9]LC_JourMoisFermeture:59; ->ve_JourFermeture; ->ve_MoisFermeture; ->ta_LesMoisFermés)
			
			[LesCentres:9]LC_H:6:=True:C214
			[LesCentres:9]LC_F:7:=True:C214
			[LesCentres:9]LC_M:8:=True:C214
			[LesCentres:9]LC_E:9:=True:C214
			[LesCentres:9]LC_FA:10:=True:C214
			
			[LesCentres:9]LC_16à24:11:=True:C214
			[LesCentres:9]LC_18à25:12:=True:C214
			[LesCentres:9]LC_18à40:13:=True:C214
			[LesCentres:9]LC_28etPlus:14:=True:C214
			[LesCentres:9]LC_18à55:15:=True:C214
			[LesCentres:9]LC_Toxico:16:=True:C214
			[LesCentres:9]LC_Alcool:45:=True:C214
			[LesCentres:9]LC_HIV:46:=True:C214
			[LesCentres:9]LC_Prostitué:17:=True:C214
			[LesCentres:9]LC_Violent:18:=True:C214
			[LesCentres:9]LC_Prison:19:=True:C214
			[LesCentres:9]LC_TraitPsy:20:=True:C214
			[LesCentres:9]LC_Irrégulier:21:=True:C214
		Else 
			P_CentreOuverture(2; ->[LesCentres:9]LC_JourMoisOuverture:58; ->ve_JourOuverture; ->ve_MoisOuverture; ->ta_LesMoisOuverts)
			P_CentreOuverture(2; ->[LesCentres:9]LC_JourMoisFermeture:59; ->ve_JourFermeture; ->ve_MoisFermeture; ->ta_LesMoisFermés)
		End if 
		
		P_CentreOuverture(3; ->[LesCentres:9]LC_JourMoisOuverture:58; ->ve_JourOuverture; ->ve_MoisOuverture; ->ta_LesMoisOuverts)
		P_CentreOuverture(3; ->[LesCentres:9]LC_JourMoisFermeture:59; ->ve_JourFermeture; ->ve_MoisFermeture; ->ta_LesMoisFermés)
		
		
		If ([LesCentres:9]LC_RéférenceID:1=0)
			[LesCentres:9]LC_RéférenceID:1:=Uut_Numerote_Centres(->[LesCentres:9])
			
			If ([LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut) & ([LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin)
			Else 
				ALERT:C41("Erreur de numérotation,  veuillez vérifier les options de numérotation des codes des centres dans la fiche de la société. (la référence générée "+String:C10([LesCentres:9]LC_RéférenceID:1)+" n'est pas comprise entre "+String:C10(<>vl_T_CentreCodeDebut)+"  et "+String:C10(<>vl_T_CentreCodeFin)+" )")
				CANCEL:C270
			End if 
			
		End if 
		
		If (vb_Dupliquer)
			SET WINDOW TITLE:C213("Dupliquer un centre")
		Else 
			SET WINDOW TITLE:C213("Un centre")
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_CentreSaisie))
			OBJECT SET VISIBLE:C603(*; "RP_@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "PL_@"; True:C214)
			OBJECT SET ENTERABLE:C238([LesCentres:9]LC_Répertoire:54; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "RP_@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "PL_@"; False:C215)
			OBJECT SET ENTERABLE:C238([LesCentres:9]LC_Répertoire:54; False:C215)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "LeBtSup"; False:C215)
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP))
			OBJECT SET VISIBLE:C603(*; "LeBtSup"; True:C214)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "LeBtDispos"; (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN)))
		
		OBJECT SET ENTERABLE:C238([LesCentres:9]LC_Excuse:49; False:C215)
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP))
		Else 
			
			If (Is new record:C668([LesCentres:9]))
				MultiSoc_Init_Structure(->[LesCentres:9])
			Else 
				P_FicheCentreHorsCentres([LesCentres:9]LC_RéférenceID:1)
			End if 
			
		End if 
		
		OBJECT SET VISIBLE:C603(*; "CritersCT_@"; Not:C34(<>vb_T_CentreCritMasquer))
		
		// Modifié par : Scanu Rémy (05/09/2022)
		If ([LesCentres:9]LC_AlerteRappelAvantEcheance:98=Null:C1517)
			[LesCentres:9]LC_AlerteNom:96:=[LesCentres:9]LC_Nom:4
			
			[LesCentres:9]LC_AlerteRappelAvantEcheance:98:=New object:C1471("15j"; True:C214; "7j"; True:C214; "5j"; True:C214; "2j"; True:C214; "1j"; True:C214)
			[LesCentres:9]LC_AlerteRappelApresEcheance:99:=True:C214
			
			SAVE RECORD:C53([LesCentres:9])
		End if 
		
	: ($vl_EventFF=Sur validation:K2:3)
End case 