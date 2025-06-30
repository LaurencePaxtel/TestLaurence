//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Script ◊ta_Utils  
//{          Mercredi 29 Octobre 1997 à 12:43:02
//{          Mercredi 29 janvier 2003 à 16:10:00 
//{          Mercredi 19 février 2003 à 18:10:00 
//{          Lundi 02 février 2004 à 18:15:00 
//{          Vendredi 14 novembre 2008 à 11:18:00 
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($vb_OK)

If (F_PouUp_Utilitaires=False:C215)
	$vb_OK:=True:C214
	
	If (<>ta_Utils>0)
		
		// Numérotations de fiches
		If (<>ta_Utils=11)  // "Numérotation des fiches"
			Process_Go(-><>PR_NoFicheH; "Go_uNoFiche"; "NoFiche"; 64)
			
			$vb_OK:=False:C215
		End if 
		
		// Changer d'utilisateur
		If (<>ta_Utils=5) & ($vb_OK)  // "Utilisateurs : Changer d'utilisateur"
			
			If (Count user processes:C343>5)
				ALERT:C41("-> Changer d'utilisateur"+<>va_CR+<>va_CR+"Veuillez auparavant quitter les fonctionnalités activées !")
			Else 
				
				If (i_Confirmer("-> Changer d'utilisateur"+<>va_CR+<>va_CR+"Confirmez-vous !"))
					Process_Go(-><>PR_INTChanger; "Go_uUserChanger"; "Changer d'utilisateur"; 32)
				End if 
				
			End if 
			
			$vb_OK:=False:C215
		End if 
		
		// Changer de mot de passe
		If (<>ta_Utils=6) & ($vb_OK)  // "Utilisateurs : Changer de mot de passe"  
			
			If (User in group:C338(Current user:C182; <>Groupe_MotPasse)) & ($vb_OK)
				Go_uMotPasseChanger
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		// Correction d'item
		If (<>ta_Utils=50) & ($vb_OK)
			
			If (User in group:C338(Current user:C182; <>Groupe_Item)) & ($vb_OK)
				Process_Go(-><>PR_Item; "Go_uItem"; "Item"; 64)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		// Correction fusion
		If (<>ta_Utils=49) & ($vb_OK)
			
			If (User in group:C338(Current user:C182; <>Groupe_Fusion)) & ($vb_OK)
				Process_Go(-><>PR_Fusion; "Go_uFusionMultiple"; "Fusion"; 64)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		// Effacer le mot de passe
		If (<>ta_Utils=7) & ($vb_OK)  // "Utilisateurs : Effacer le mot de passe"  
			
			If (User in group:C338(Current user:C182; <>Groupe_MotPasseRAZ)) & ($vb_OK)
				Process_Go(-><>PR_INTRaz; "Go_uIntervenantRAZ"; "IntervenantsRAZ"; 32)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		// Paramètres Reports
		If (<>ta_Utils=18) & ($vb_OK)  // "Paramètres : Reports"  
			
			If (User in group:C338(Current user:C182; <>Groupe_ReportAuto)) & ($vb_OK)
				Process_Go(-><>PR_ReportAUTO; "Go_uReportAUTO"; "ReportParam"; 64)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		// Paramètres màj énumérations
		If (<>ta_Utils=22) & ($vb_OK)  // "Paramètres màj énumérations
			
			If (User in group:C338(Current user:C182; <>Groupe_MajEnum)) & ($vb_OK)
				
				If (i_Confirmer("Mise à jour des énumérations ?"))
					Go_uMàJEnum
				End if 
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		
		// Paramètres Consolidation
		If (<>ta_Utils=24) & ($vb_OK)  // "Paramètres : Consolidation"  
			
			If (User in group:C338(Current user:C182; <>Groupe_Conso)) & ($vb_OK)
				Process_Go(-><>PR_ConsoParam; "Go_uConsolidation115"; "ConsoParam"; 64)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		//Export : Report"
		If (<>ta_Utils=58) & ($vb_OK)  //"Export : Report"  
			
			If (User in group:C338(Current user:C182; <>Groupe_VeilleExport_report)) & ($vb_OK)
				Go_uExportReport
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		//Données pour le WebSite 115" données exportées pour les graphes web
		If (<>ta_Utils=61) & ($vb_OK)  //"Website 115    
			
			If (User in group:C338(Current user:C182; <>Groupe_Conso)) & ($vb_OK)
				Process_Go(-><>PR_Website; "Go_Website"; "Website"; 64)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		//Consolidation Client"
		If (<>ta_Utils=65) & ($vb_OK)  //"Paramètres : Consolidation"  
			
			If (User in group:C338(Current user:C182; <>Groupe_Conso)) & ($vb_OK)
				Process_Go(-><>PR_ConsoClient; "Go_uConsolidationClient"; "ConsoClient"; 64)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		//Paramètres : serveur de Mails  
		If (<>ta_Utils=66) & ($vb_OK)  //"Paramètres : e Mails  
			
			If (User in group:C338(Current user:C182; <>Groupe_Conso)) & ($vb_OK)
				Process_Go(-><>PR_ParamMail; "Go_uMailsParam"; "MailsParam"; 64)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		If (7=8)  //Replacer sur lemenu general le 1 février 2011
			
			If (<>ta_Utils=70) & ($vb_OK)  //"Paramètres : Consolidation SIAO
				
				If (User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_DEVELOP)) & ($vb_OK)
					Process_Go(-><>PR_SIAO; "Go_SIAO"; "SIAO"; 128)
					
					$vb_OK:=False:C215
				End if 
				
			End if 
			
		End if 
		
		//Paramètres Consolidation régionale"
		If (<>ta_Utils=68) & ($vb_OK)  //"Paramètres : Consolidation régionale"  
			
			If (User in group:C338(Current user:C182; <>Groupe_Regional) | User in group:C338(Current user:C182; <>Groupe_DEVELOP)) & ($vb_OK)
				
				If (7=8)
					
					If (Macintosh control down:C544) | (Windows Ctrl down:C562)  //Action manuelle 
						Process_Go1(-><>PR_ConsoRParam; "Go_uConsolidationRg"; "ConsoRParam"; 64; Current date:C33)
					Else 
						Process_Go1(-><>PR_ConsoRParam; "Go_uConsolidationRg"; "ConsoRParam"; 64; !00-00-00!)
					End if 
					
				Else 
					Process_Go(-><>PR_ConsoRGClient; "Go_uConsolidationRGClient"; "ConsoRGClient"; 64)
				End if 
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_DEVELOP)) & ($vb_OK)
			
			Case of 
				: (<>ta_Utils=1)  //"Raison sociale"
					Process_Go(-><>PR_Raison; "Go_uRaison"; "Raison"; 64)
				: (<>ta_Utils=2)  //"-"
				: (<>ta_Utils=3)  //"Gestion des tables d'énumérations"
					Process_Go(-><>PR_Tab; "Go_uTables"; "LesTables"; 64)
				: (<>ta_Utils=4)  //"-"
				: (<>ta_Utils=6)  //"Utilisateurs : Changer de mot de passe"
					Go_uMotPasseChanger
				: (<>ta_Utils=7)  //"Utilisateurs : Effacer le mot de passe"
					Process_Go(-><>PR_INTRaz; "Go_uIntervenantRAZ"; "IntervenantsRAZ"; 32)
				: (<>ta_Utils=8)  //"Utilisateurs : Privilèges"
					EDIT ACCESS:C281
				: (<>ta_Utils=9)  //"Utilisateurs : Liste"        
					Process_Go(-><>PR_INT; "Go_uIntervenant"; "Intervenants"; 32)
				: (<>ta_Utils=10)  //"Utilisateurs : Profils"
					Process_Go(-><>PR_INTPr; "Go_uIntervenantProfils"; "Profils"; 32)
				: (<>ta_Utils=11)  //"-"
				: (<>ta_Utils=12)  //"Numérotation des fiches"
					Process_Go(-><>PR_NoFicheH; "Go_uNoFiche"; "NoFiche"; 64)
				: (<>ta_Utils=13)  //"Suppression d'une fiche d'hébergement"
					Go_uHebergementSup
				: (<>ta_Utils=14)  //"-"
				: (<>ta_Utils=15)  //"Les Champs des écrans de saisie"
					Process_Go(-><>PR_Rubrique; "Go_uEcranSaisie"; "LesRub"; 64)
				: (<>ta_Utils=16)  //"-"
				: (<>ta_Utils=17)  //"Paramètres Age par défaut des inconnus"
					Process_Go(-><>PR_AgeDéfaut; "Go_uAgeDéfaut"; "AgeDéfaut"; 64)
				: (<>ta_Utils=18)  //"Paramètres Reports"
					Process_Go(-><>PR_ReportAUTO; "Go_uReportAUTO"; "ReportParam"; 64)
				: (<>ta_Utils=19)  //"Paramètres Centres LOFT"
					Process_Go(-><>PR_LOFT; "Go_uLOFT"; "CentresLOFT"; 64)
				: (<>ta_Utils=20)  //"Paramètres STR"
					Process_Go(-><>PR_STR; "Go_uSTR"; "LesSTR"; 64)
				: (<>ta_Utils=21)  //"Paramètres TEXTE"
					Process_Go(-><>PR_TXT; "Go_uTXT"; "LesTXT"; 64)
				: (<>ta_Utils=22)  //"Paramètres màj énumérations"   
					If (i_Confirmer("Mise à jour des énumérations ?"))
						Go_uMàJEnum
					End if 
				: (<>ta_Utils=23)  //"Paramètres de disponibilité"
					Process_Go(-><>PR_JN; "Go_uJN"; "LesJN"; 64)
				: (<>ta_Utils=25)  //"-"        
				: (<>ta_Utils=26)  //"Gestion des purges"
					Process_Go(-><>PR_Purge; "Go_uPurge"; "Purge1"; 64)
				: (<>ta_Utils=27)  //"Gestion des dates de naissance"
					Process_Go(-><>PR_ModNé; "Go_uModNéle"; "Néle"; 64)
				: (<>ta_Utils=28)  //"Préparation des disponibilités …"
					Go_PréparerDispos
				: (<>ta_Utils=29)  //"-"
				: (<>ta_Utils=30)  //"Visualisation des reports"
					Process_Go(-><>PR_RésReport; "Go_uRésReport"; "RésReport"; 64)
				: (<>ta_Utils=31)  //"-"
				: (<>ta_Utils=32)  //"Plateforme réservée"·
					Process_Go(-><>PR_DévTables; "Go_uTablesDév"; "TablesDév"; 64)
				: (<>ta_Utils=34)  //"Export"
					Process_Go(-><>PR_Export0312770; "Go_uExportTGIP"; "uExport"; 64)
				: (<>ta_Utils=35)  //"-"
				: (<>ta_Utils=36)  //"Coordinateur par défaut"
					Process_Go(-><>PR_CoorD; "Go_uCoorD"; "CoorDéfaut"; 64)
				: (<>ta_Utils=37)  //"Asile Famille par défaut"
					Process_Go(-><>PR_AsileD; "Go_uAsileD"; "AsileDéfaut"; 64)
				: (<>ta_Utils=38)  //"Signalements liés aux touches F1, F2"
					Process_Go(-><>PR_SigltD; "Go_uSignalD"; "SignalDéfaut"; 64)
				: (<>ta_Utils=39)  //"Groupes nombre de membres"
					Process_Go(-><>PR_GpeNb; "Go_uGroupeNb"; "◊PR_GpeNb"; 64)
				: (<>ta_Utils=40)  //"Champs à dupliquer"
					Process_Go(-><>PR_DupChamp; "Go_uDup"; "ChampDupliquer"; 64)
				: (<>ta_Utils=41)  //"Gestion des centres"
					Process_Go(-><>PR_CentreEXC; "Go_uCentreEXC"; "CentreEXC"; 64)
				: (<>ta_Utils=42)  //"Autres solutions"
					Process_Go(-><>PR_AutreSolD; "Go_uAutreSolD"; "AutreSolD"; 64)
				: (<>ta_Utils=43)  //"Prolongations : paramètres"
					Process_Go(-><>PR_ProlongationID; "Go_uProlongationID"; "ProlongationIlD"; 64)
				: (<>ta_Utils=44)  //"Prolongations : paramètres"
					DebutDecAge(1)
				: (<>ta_Utils=45)  //"Fusions : paramètres"
					Process_Go(-><>PR_FusionNotes; "Go_uFusionNotes"; "FusionNotes"; 64)
				: (<>ta_Utils=46)  //"-"
				: (<>ta_Utils=47)  //"Fusions : Etat civil"        
					Process_Go(-><>PR_FusionEtCv; "Go_uFusionEtCv"; "FusionEtCv"; 64)
				: (<>ta_Utils=51)  //"Item : Rattrapage"      
					Process_Go(-><>PR_Correction; "Go_Correction"; "Correction"; 64)
				: (<>ta_Utils=53)  //"GPS"        
					Process_Go(-><>PR_LienGPS; "P_LienGPS"; "LienGPS"; 64)
				: (<>ta_Utils=54)  //"Fiches max"                
					Process_Go(-><>PR_MaxFiche; "Go_uMaxFiche"; "MaxFiche"; 64)
				: (<>ta_Utils=55)  //"Conso : Voir fichesl"        
					Process_Go(-><>PR_Conso115Voir; "Go_uConsolidation115Voir"; "ConsoVoir"; 64)
				: (<>ta_Utils=56)  //"Paramètres de pointage"        
					Process_Go(-><>PR_Pointage; "Go_uPointage"; "Pointage"; 64)
				: (<>ta_Utils=57)  //"Regroupement d'Items                
					Process_Go(-><>PR_ItemGrouper; "Go_uItemGrouper"; "temGroupe"; 64)
				: (<>ta_Utils=59)  //"Regroupement d'Items      (PRÉSENTATION   
					Process_Go(-><>PR_Présentation; "Go_uPrésentation"; "Présentation"; 64)
				: (<>ta_Utils=61)  //"Website 115   
					Process_Go(-><>PR_Website; "Go_Website"; "Website"; 64)
				: (<>ta_Utils=63)  //"Botttin social
					
					If (7=8)
						ALERT:C41("Développement en cours...")
					Else 
						Process_Go(-><>PR_Bottin; "Go_Bottin"; "Bottin"; 64)
					End if 
					
			End case 
			
			$vb_OK:=False:C215
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_ADMIN)) & ($vb_OK)
			
			Case of 
				: (<>ta_Utils=3)  //"Gestion des tables d'énumérations"
					Process_Go(-><>PR_Tab; "Go_uTables"; "LesTables"; 64)
				: (<>ta_Utils=6)  //"Utilisateurs : Changer de mot de passe"
					Go_uMotPasseChanger
				: (<>ta_Utils=7)  //"Utilisateurs : Effacer le mot de passe"
					Process_Go(-><>PR_INTRaz; "Go_uIntervenantRAZ"; "IntervenantsRAZ"; 32)
				: (<>ta_Utils=8)  //"Utilisateurs : Privilèges"
					EDIT ACCESS:C281
				: (<>ta_Utils=9)  //"Utilisateurs : Liste"        
					Process_Go(-><>PR_INT; "Go_uIntervenant"; "Intervenants"; 32)
				: (<>ta_Utils=12)  //"Numérotation des fiches"
					Process_Go(-><>PR_NoFicheH; "Go_uNoFiche"; "NoFiche"; 64)
				: (<>ta_Utils=13)  //"Suppression d'une fiche d'hébergement"
					Go_uHebergementSup
				: (<>ta_Utils=14)  //"-"        
				: (<>ta_Utils=17)  //"Paramètres Age par défaut des inconnus"
					Process_Go(-><>PR_AgeDéfaut; "Go_uAgeDéfaut"; "AgeDéfaut"; 64)
				: (<>ta_Utils=34)  //"Export"
					Process_Go(-><>PR_Export0312770; "Go_uExportTGIP"; "uExport"; 64)
				: (<>ta_Utils=35)  //"-"
				: (<>ta_Utils=36)  //"Coordinateur par défaut"
					Process_Go(-><>PR_CoorD; "Go_uCoorD"; "CoorDéfaut"; 64)
				: (<>ta_Utils=37)  //"Asile Famille par défaut"
					Process_Go(-><>PR_AsileD; "Go_uAsileD"; "AsileDéfaut"; 64)
				: (<>ta_Utils=38)  //"Signalements liés aux touches F1, F2, F3"
					Process_Go(-><>PR_SigltD; "Go_uSignalD"; "SignalDéfaut"; 64)
				: (<>ta_Utils=39)  //"Groupes nombre de membres"
					Process_Go(-><>PR_GpeNb; "Go_uGroupeNb"; "◊PR_GpeNb"; 64)
				: (<>ta_Utils=40)  //"Champs à dupliquer"
					Process_Go(-><>PR_DupChamp; "Go_uDup"; "ChampDupliquer"; 64)
				: (<>ta_Utils=41)  //"Gestion des centres"
					Process_Go(-><>PR_CentreEXC; "Go_uCentreEXC"; "CentreEXC"; 64)
				: (<>ta_Utils=42)  //"Autres solutions"
					Process_Go(-><>PR_AutreSolD; "Go_uAutreSolD"; "AutreSolD"; 64)
				: (<>ta_Utils=43)  //"Prolongations : paramètres"
					Process_Go(-><>PR_ProlongationID; "Go_uProlongationID"; "ProlongationIlD"; 64)
				: (<>ta_Utils=44)  //"Prolongations : paramètres"
					DebutDecAge(1)
				: (<>ta_Utils=45)  //"Fusions : paramètres"
					Process_Go(-><>PR_FusionNotes; "Go_uFusionNotes"; "FusionNotes"; 64)
				: (<>ta_Utils=46)  //"-"
				: (<>ta_Utils=47)  //"Fusions : Etat civil"        
					Process_Go(-><>PR_FusionEtCv; "Go_uFusionEtCv"; "FusionEtCv"; 64)
				Else 
					ALERT:C41("Plateforme réservée au développement !")
			End case 
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	If (7=8)
		$vb_OK:=True:C214
		
		If (<>ta_Utils>0)
			
			If (<>ta_Utils=11)  //"Numérotation des fiches"
				Process_Go(-><>PR_NoFicheH; "Go_uNoFiche"; "NoFiche"; 64)
				
				$vb_OK:=False:C215
			End if 
			
			If (<>ta_Utils=5) & ($vb_OK)  //"Utilisateurs : Changer d'utilisateur"
				
				If (Count user processes:C343>5)
					ALERT:C41("-> Changer d'utilisateur"+<>va_CR+<>va_CR+"Veuillez auparavant quitter les fonctionnalités activées !")
				Else 
					
					If (i_Confirmer("-> Changer d'utilisateur"+<>va_CR+<>va_CR+"Confirmez-vous !"))
						Process_Go(-><>PR_INTChanger; "Go_uUserChanger"; "Changer d'utilisateur"; 32)
					End if 
					
				End if 
				
				$vb_OK:=False:C215
			End if 
			
			//Changer de mot de passe
			If (<>ta_Utils=6) & ($vb_OK)  //"Utilisateurs : Changer de mot de passe"
				
				If (User in group:C338(Current user:C182; <>Groupe_MotPasse)) & ($vb_OK)
					Go_uMotPasseChanger
					
					$vb_OK:=False:C215
				End if 
				
			End if 
			
			//Correction de item
			If (<>ta_Utils=49) & ($vb_OK)
				
				If (User in group:C338(Current user:C182; <>Groupe_Item)) & ($vb_OK)
					Process_Go(-><>PR_Item; "Go_uItem"; "Item"; 64)
					
					$vb_OK:=False:C215
				End if 
				
			End if 
			
			//Correction fusion
			If (<>ta_Utils=48) & ($vb_OK)
				
				If (User in group:C338(Current user:C182; <>Groupe_Fusion)) & ($vb_OK)
					Process_Go(-><>PR_Fusion; "Go_uFusionMultiple"; "Fusion"; 64)
					
					$vb_OK:=False:C215
				End if 
				
			End if 
			
			//Effacer le mot de passe
			If (<>ta_Utils=7) & ($vb_OK)  //"Utilisateurs : Effacer le mot de passe"  
				
				If (User in group:C338(Current user:C182; <>Groupe_MotPasseRAZ)) & ($vb_OK)
					Process_Go(-><>PR_INTRaz; "Go_uIntervenantRAZ"; "IntervenantsRAZ"; 32)
					
					$vb_OK:=False:C215
				End if 
				
			End if 
			
			//Paramètres Reports"
			If (<>ta_Utils=18) & ($vb_OK)  //"Paramètres : Reports"  
				
				If (User in group:C338(Current user:C182; <>Groupe_ReportAuto)) & ($vb_OK)
					Process_Go(-><>PR_ReportAUTO; "Go_uReportAUTO"; "ReportParam"; 64)
					
					$vb_OK:=False:C215
				End if 
				
			End if 
			
			//Paramètres màj énumérations
			If (<>ta_Utils=22) & ($vb_OK)  //"Paramètres màj énumérations
				
				If (User in group:C338(Current user:C182; <>Groupe_MajEnum)) & ($vb_OK)
					
					If (i_Confirmer("Mise à jour des énumérations ?"))
						Go_uMàJEnum
					End if 
					
					$vb_OK:=False:C215
				End if 
				
			End if 
			
			If (User in group:C338(Current user:C182; <>Groupe_DEVELOP)) & ($vb_OK)
				
				Case of 
					: (<>ta_Utils=1)  //"Raison sociale"
						Process_Go(-><>PR_Raison; "Go_uRaison"; "Raison"; 32)
					: (<>ta_Utils=2)  //"-"
					: (<>ta_Utils=3)  //"Gestion des tables d'énumérations"
						Process_Go(-><>PR_Tab; "Go_uTables"; "LesTables"; 64)
					: (<>ta_Utils=4)  //"-"
					: (<>ta_Utils=6)  //"Utilisateurs : Changer de mot de passe"
						Go_uMotPasseChanger
					: (<>ta_Utils=7)  //"Utilisateurs : Effacer le mot de passe"
						Process_Go(-><>PR_INTRaz; "Go_uIntervenantRAZ"; "IntervenantsRAZ"; 32)
					: (<>ta_Utils=8)  //"Utilisateurs : Privilèges"
						EDIT ACCESS:C281
					: (<>ta_Utils=9)  //"Utilisateurs : Liste"        
						Process_Go(-><>PR_INT; "Go_uIntervenant"; "Intervenants"; 32)
					: (<>ta_Utils=10)  //"Utilisateurs : Profils"
						Process_Go(-><>PR_INTPr; "Go_uIntervenantProfils"; "Profils"; 32)
					: (<>ta_Utils=11)  //"-"
					: (<>ta_Utils=12)  //"Numérotation des fiches"
						Process_Go(-><>PR_NoFicheH; "Go_uNoFiche"; "NoFiche"; 64)
					: (<>ta_Utils=13)  //"Suppression d'une fiche d'hébergement"
						Go_uHebergementSup
					: (<>ta_Utils=14)  //"-"
					: (<>ta_Utils=15)  //"Les Champs des écrans de saisie"
						Process_Go(-><>PR_Rubrique; "Go_uEcranSaisie"; "LesRub"; 64)
					: (<>ta_Utils=16)  //"-"
					: (<>ta_Utils=17)  //"Paramètres Age par défaut des inconnus"
						Process_Go(-><>PR_AgeDéfaut; "Go_uAgeDéfaut"; "AgeDéfaut"; 64)
					: (<>ta_Utils=18)  //"Paramètres Reports"
						Process_Go(-><>PR_ReportAUTO; "Go_uReportAUTO"; "ReportParam"; 64)
					: (<>ta_Utils=19)  //"Paramètres Centres LOFT"
						Process_Go(-><>PR_LOFT; "Go_uLOFT"; "CentresLOFT"; 64)
					: (<>ta_Utils=20)  //"Paramètres STR"
						Process_Go(-><>PR_STR; "Go_uSTR"; "LesSTR"; 64)
					: (<>ta_Utils=21)  //"Paramètres TEXTE"
						Process_Go(-><>PR_TXT; "Go_uTXT"; "LesTXT"; 64)
					: (<>ta_Utils=22)  //"Paramètres màj énumérations"   
						
						If (i_Confirmer("Mise à jour des énumérations ?"))
							Go_uMàJEnum
						End if 
						
					: (<>ta_Utils=23)  //"Paramètres de disponibilité"
						Process_Go(-><>PR_JN; "Go_uJN"; "LesJN"; 64)
					: (<>ta_Utils=24)  //"-"        
					: (<>ta_Utils=25)  //"Gestion des purges"
						Process_Go(-><>PR_Purge; "Go_uPurge"; "Purge1"; 64)
					: (<>ta_Utils=26)  //"Gestion des dates de naissance"
						Process_Go(-><>PR_ModNé; "Go_uModNéle"; "Néle"; 64)
					: (<>ta_Utils=27)  //"Préparation des disponibilités …"
						Go_PréparerDispos
					: (<>ta_Utils=28)  //"-"
					: (<>ta_Utils=29)  //"Visualisation des reports"
						Process_Go(-><>PR_RésReport; "Go_uRésReport"; "RésReport"; 64)
					: (<>ta_Utils=30)  //"-"
					: (<>ta_Utils=31)  //"Plateforme réservée"·
					: (<>ta_Utils=33)  //"Export"
						Process_Go(-><>PR_Export0312770; "Go_uExportTGIP"; "uExport"; 64)
					: (<>ta_Utils=33)  //"-"
					: (<>ta_Utils=35)  //"Coordinateur par défaut"
						Process_Go(-><>PR_CoorD; "Go_uCoorD"; "CoorDéfaut"; 64)
					: (<>ta_Utils=36)  //"Asile Famille par défaut"
						Process_Go(-><>PR_AsileD; "Go_uAsileD"; "AsileDéfaut"; 64)
					: (<>ta_Utils=37)  //"Signalements liés aux touches F1, F2"
						Process_Go(-><>PR_SigltD; "Go_uSignalD"; "SignalDéfaut"; 64)
					: (<>ta_Utils=38)  //"Groupes nombre de membres"
						Process_Go(-><>PR_GpeNb; "Go_uGroupeNb"; "◊PR_GpeNb"; 64)
					: (<>ta_Utils=39)  //"Champs à dupliquer"
						Process_Go(-><>PR_DupChamp; "Go_uDup"; "ChampDupliquer"; 64)
					: (<>ta_Utils=40)  //"Gestion des centres"
						Process_Go(-><>PR_CentreEXC; "Go_uCentreEXC"; "CentreEXC"; 64)
					: (<>ta_Utils=41)  //"Autres solutions"
						Process_Go(-><>PR_AutreSolD; "Go_uAutreSolD"; "AutreSolD"; 64)
					: (<>ta_Utils=42)  //"Prolongations : paramètres"
						Process_Go(-><>PR_ProlongationID; "Go_uProlongationID"; "ProlongationIlD"; 64)
					: (<>ta_Utils=43)  //"Prolongations : paramètres"
						DebutDecAge(1)
					: (<>ta_Utils=44)  //"Fusions : paramètres"
						Process_Go(-><>PR_FusionNotes; "Go_uFusionNotes"; "FusionNotes"; 64)
					: (<>ta_Utils=45)  //"-"
					: (<>ta_Utils=46)  //"Fusions : Etat civil"        
						Process_Go(-><>PR_FusionEtCv; "Go_uFusionEtCv"; "FusionEtCv"; 64)
					: (<>ta_Utils=53)  //"GPS"        
						Process_Go(-><>PR_LienGPS; "P_LienGPS"; "LienGPS"; 64)
					: (<>ta_Utils=54)  //"Fiches max"                
						Process_Go(-><>PR_MaxFiche; "Go_uMaxFiche"; "MaxFiche"; 64)
				End case 
				
				$vb_OK:=False:C215
			End if 
			
			If (User in group:C338(Current user:C182; <>Groupe_ADMIN)) & ($vb_OK)
				
				Case of 
					: (<>ta_Utils=3)  //"Gestion des tables d'énumérations"
						Process_Go(-><>PR_Tab; "Go_uTables"; "LesTables"; 64)
					: (<>ta_Utils=6)  //"Utilisateurs : Changer de mot de passe"
						Go_uMotPasseChanger
					: (<>ta_Utils=7)  //"Utilisateurs : Effacer le mot de passe"
						Process_Go(-><>PR_INTRaz; "Go_uIntervenantRAZ"; "IntervenantsRAZ"; 32)
					: (<>ta_Utils=8)  //"Utilisateurs : Privilèges"
						EDIT ACCESS:C281
					: (<>ta_Utils=9)  //"Utilisateurs : Liste"        
						Process_Go(-><>PR_INT; "Go_uIntervenant"; "Intervenants"; 32)
					: (<>ta_Utils=12)  //"Numérotation des fiches"
						Process_Go(-><>PR_NoFicheH; "Go_uNoFiche"; "NoFiche"; 64)
					: (<>ta_Utils=13)  //"Suppression d'une fiche d'hébergement"
						Go_uHebergementSup
					: (<>ta_Utils=14)  //"-"        
					: (<>ta_Utils=17)  //"Paramètres Age par défaut des inconnus"
						Process_Go(-><>PR_AgeDéfaut; "Go_uAgeDéfaut"; "AgeDéfaut"; 64)
					: (<>ta_Utils=33)  //"Export"
						Process_Go(-><>PR_Export0312770; "Go_uExportTGIP"; "uExport"; 64)
					: (<>ta_Utils=34)  //"-"
					: (<>ta_Utils=35)  //"Coordinateur par défaut"
						Process_Go(-><>PR_CoorD; "Go_uCoorD"; "CoorDéfaut"; 64)
					: (<>ta_Utils=36)  //"Asile Famille par défaut"
						Process_Go(-><>PR_AsileD; "Go_uAsileD"; "AsileDéfaut"; 64)
					: (<>ta_Utils=37)  //"Signalements liés aux touches F1, F2, F3"
						Process_Go(-><>PR_SigltD; "Go_uSignalD"; "SignalDéfaut"; 64)
					: (<>ta_Utils=38)  //"Groupes nombre de membres"
						Process_Go(-><>PR_GpeNb; "Go_uGroupeNb"; "◊PR_GpeNb"; 64)
					: (<>ta_Utils=39)  //"Champs à dupliquer"
						Process_Go(-><>PR_DupChamp; "Go_uDup"; "ChampDupliquer"; 64)
					: (<>ta_Utils=40)  //"Gestion des centres"
						Process_Go(-><>PR_CentreEXC; "Go_uCentreEXC"; "CentreEXC"; 64)
					: (<>ta_Utils=41)  //"Autres solutions"
						Process_Go(-><>PR_AutreSolD; "Go_uAutreSolD"; "AutreSolD"; 64)
					: (<>ta_Utils=42)  //"Prolongations : paramètres"
						Process_Go(-><>PR_ProlongationID; "Go_uProlongationID"; "ProlongationIlD"; 64)
					: (<>ta_Utils=43)  //"Prolongations : paramètres"
						DebutDecAge(1)
					: (<>ta_Utils=44)  //"Fusions : paramètres"
						Process_Go(-><>PR_FusionNotes; "Go_uFusionNotes"; "FusionNotes"; 64)
					: (<>ta_Utils=45)  //"-"
					: (<>ta_Utils=46)  //"Fusions : Etat civil"        
						Process_Go(-><>PR_FusionEtCv; "Go_uFusionEtCv"; "FusionEtCv"; 64)
					Else 
						ALERT:C41("Plateforme réservée au développement !")
				End case 
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
	End if 
	
End if 