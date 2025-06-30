//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtelî
//{
//{          Script ◊ta_Utils  
//{          Mercredi 29 Octobre 1997 à 12:43:02
//{          Mercredi 29 janvier 2003 à 16:10:00 
//{          Mercredi 19 février 2003 à 18:10:00 
//{          Lundi 02 février 2004 à 18:15:00 
//{          Vendredi 14 novembre 2008 à 11:18:00 
//{
//{       Méthode : F_PouUp_Utilitaires
//{          Vendredi 6 janvier 2011 à 14:14:00 
//{ 
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)

C_TEXT:C284($position_t)
C_BOOLEAN:C305($vb_OK)
C_OBJECT:C1216($form_o; $table_o; $enregistrement_o; $position_o)

$0:=True:C214

// Modifié par : Scanu Rémy (27/10/2021)
// Du fait de l'ajout de menu "Paramétrage des impressions" tout à été décalé...
If (<>ta_Utils>26)
	<>ta_Utils:=<>ta_Utils-1
End if 

$vb_OK:=(Size of array:C274(<>ta_Utils)>0)

If ($vb_OK)
	$vb_OK:=(<>ta_Utils>0)
End if 

If ($vb_OK)
	
	// Changer d'utilisateur
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
	
	// Changer de mot de passe
	If (<>ta_Utils=6) & ($vb_OK)  // "Utilisateurs : Changer de mot de passe"  
		
		If (User in group:C338(Current user:C182; <>Groupe_MotPasse)) & ($vb_OK)
			Go_uMotPasseChanger
			
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
	
	// Numérotations de fiches
	If (<>ta_Utils=12) & ($vb_OK)  // "Numérotation des fiches"
		Process_Go(-><>PR_NoFicheH; "Go_uNoFiche"; "NoFiche"; 64)
		
		$vb_OK:=False:C215
	End if 
	
	// Paramètres Reports
	If (<>ta_Utils=19) & ($vb_OK)  // "Paramètres : Reports"  
		
		If (User in group:C338(Current user:C182; <>Groupe_ReportAuto)) & ($vb_OK)
			Process_Go(-><>PR_ReportAUTO; "Go_uReportAUTO"; "ReportParam"; 64)
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	// Paramètres màj énumérations
	If (<>ta_Utils=23) & ($vb_OK)  // "Paramètres màj énumérations"
		
		If (User in group:C338(Current user:C182; <>Groupe_MajEnum)) & ($vb_OK)
			
			If (i_Confirmer("Mise à jour des énumérations ?"))
				Go_uMàJEnum
			End if 
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	// Paramètres consolidation
	If (<>ta_Utils=25) & ($vb_OK)  // "Paramètres : Consolidation"  
		
		If (User in group:C338(Current user:C182; <>Groupe_Conso)) & ($vb_OK)
			Process_Go(-><>PR_ConsoParam; "Go_uConsolidation115"; "ConsoParam"; 64)
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	//Correction fusion
	If (<>ta_Utils=50) & ($vb_OK)
		
		If (User in group:C338(Current user:C182; <>Groupe_Fusion)) & ($vb_OK)
			Process_Go(-><>PR_Fusion; "Go_uFusionMultiple"; "Fusion"; 64)
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	//Correction de item
	If (<>ta_Utils=51) & ($vb_OK)
		
		If (User in group:C338(Current user:C182; <>Groupe_Item)) & ($vb_OK)
			Process_Go(-><>PR_Item; "Go_uItem"; "Item"; 64)
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	//Export : Report"
	If (<>ta_Utils=59) & ($vb_OK)  //"Export : Report"  
		
		If (User in group:C338(Current user:C182; <>Groupe_VeilleExport_report)) & ($vb_OK)
			Go_uExportReport
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	//Données pour le WebSite 115" données exportées pour les graphes web
	If (<>ta_Utils=62) & ($vb_OK)  //"Website 115    
		
		If (User in group:C338(Current user:C182; <>Groupe_Conso)) & ($vb_OK)
			Process_Go(-><>PR_Website; "Go_Website"; "Website"; 64)
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	//Consolidation Client"
	If (<>ta_Utils=66) & ($vb_OK)  //"Paramètres : Consolidation"  
		
		If (User in group:C338(Current user:C182; <>Groupe_Conso)) & ($vb_OK)
			Process_Go(-><>PR_ConsoClient; "Go_uConsolidationClient"; "ConsoClient"; 64)
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	//Paramètres : serveur de Mails  
	If (<>ta_Utils=67) & ($vb_OK)  //"Paramètres : e Mails  
		
		If (User in group:C338(Current user:C182; <>Groupe_Conso)) & ($vb_OK)
			Process_Go(-><>PR_ParamMail; "Go_uMailsParam"; "MailsParam"; 64)
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	//Paramètres Consolidation régionale"
	If (<>ta_Utils=69) & ($vb_OK)  //"Paramètres : Consolidation régionale"  
		
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
	
	If (<>ta_Utils=73) & ($vb_OK)  //"Paramètres : Consolidation régionale"  
		
		If (User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_DEVELOP)) & ($vb_OK)
			Process_Go(-><>PR_ConsoTransfert; "Go_uConsoTransfert"; "ConsoTransP"; 64)
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	If (7=8)  //Replacer sur lemenu general le 1 février 2011
		
		If (<>ta_Utils=71) & ($vb_OK)  //"Paramètres : Consolidation SIAO
			
			If (User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_DEVELOP)) & ($vb_OK)
				Process_Go(-><>PR_SIAO; "Go_SIAO"; "SIAO"; 128)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
	Else 
		
		//Données SIAO Defaut dans hébergement 
		If (<>ta_Utils=71) & ($vb_OK)  //"Données Hébergement SIAO par défaut"
			
			If (User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_DEVELOP)) & ($vb_OK)
				Process_Go(-><>PR_HgSiaoD; "Go_uHgSiaoD"; "HgSiaoDéfaut"; 64)
				
				$vb_OK:=False:C215
			End if 
			
		End if 
		
	End if 
	
	If (<>ta_Utils=14) & ($vb_OK)  //"Suppression d'une fiche d'hébergement"  
		
		If (User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_FicheHGSup)) & ($vb_OK)
			Go_uHebergementSup
			
			$vb_OK:=False:C215
		End if 
		
	End if 
	
	If (<>ta_Utils=11) & ($vb_OK)  //"Utilisateurs : Plateformes"  
		
		If (Size of array:C274(<>ta_UserPlateforme)>0)
			Tab_PopIn1("Plateforme"; -><>ta_UserPlateforme; -><>va_UserPlateforme)
			
			<>Va_CentreCtrl:=<>va_UserPlateforme
			ALERT:C41("Votre acces plateforme est : "+<>va_UserPlateforme)
		Else 
			ALERT:C41("Votre acces plateforme est unique : "+<>va_UserPlateforme)
		End if 
		
		$vb_OK:=False:C215
	End if 
	
	// Modifié par : Kevin HASSAL (07/07/2018)
	// Ajout : l'export  & option veille
	If (<>ta_Utils=75) & ($vb_OK)  //"Export"  
		NAV_Lance_Export
	End if 
	
	If (<>ta_Utils=76) & ($vb_OK)  //"Option veille"  
		NAV_Lance_Option_Veille
	End if 
	
	If (<>ta_Utils=79) & (User in group:C338(Current user:C182; <>Groupe_DEVELOP)) & ($vb_OK)  //"Paramétrage du navigateur"  
		NAV_Lance_Parametrage
	End if 
	
	If (<>ta_Utils=80) & (User in group:C338(Current user:C182; <>Groupe_DEVELOP)) & ($vb_OK)  //"Paramétrage des structures"  
		NAV_Lance_Structures
	End if 
	
	If (<>ta_Utils=81) & ($vb_OK)  //"Navigateur du développement"  
		NAV_Lance_Developpement
	End if 
	
	If (<>ta_Utils=82) & ($vb_OK)  //"Paramétrage des fiches Max"  
		Go_uMaxFiche
	End if 
	
	If (<>ta_Utils=83) & ($vb_OK)  //"Financeurs"  
		NAV_Lance_Financeurs
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
			: (<>ta_Utils=12)  //"-"
			: (<>ta_Utils=13)  //"Numérotation des fiches"
				Process_Go(-><>PR_NoFicheH; "Go_uNoFiche"; "NoFiche"; 64)
			: (<>ta_Utils=14)  //"Suppression d'une fiche d'hébergement"
				Go_uHebergementSup
			: (<>ta_Utils=15)  //"-"
			: (<>ta_Utils=16)  //"Les Champs des écrans de saisie"
				Process_Go(-><>PR_Rubrique; "Go_uEcranSaisie"; "LesRub"; 64)
			: (<>ta_Utils=17)  //"-"
			: (<>ta_Utils=18)  //"Paramètres Age par défaut des inconnus"
				Process_Go(-><>PR_AgeDéfaut; "Go_uAgeDéfaut"; "AgeDéfaut"; 64)
			: (<>ta_Utils=19)  //"Paramètres Reports"
				Process_Go(-><>PR_ReportAUTO; "Go_uReportAUTO"; "ReportParam"; 64)
			: (<>ta_Utils=20)  //"Paramètres Centres LOFT"
				Process_Go(-><>PR_LOFT; "Go_uLOFT"; "CentresLOFT"; 64)
			: (<>ta_Utils=21)  //"Paramètres STR"
				Process_Go(-><>PR_STR; "Go_uSTR"; "LesSTR"; 64)
			: (<>ta_Utils=22)  //"Paramètres TEXTE"
				Process_Go(-><>PR_TXT; "Go_uTXT"; "LesTXT"; 64)
			: (<>ta_Utils=23)  //"Paramètres màj énumérations"   
				If (i_Confirmer("Mise à jour des énumérations ?"))
					Go_uMàJEnum
				End if 
			: (<>ta_Utils=24)  //"Paramètres de disponibilité"
				Process_Go(-><>PR_JN; "Go_uJN"; "LesJN"; 64)
			: (<>ta_Utils=26)  //"Paramétrage des impressions"
				// Modifié par : Scanu Rémy - remy@connect-io.fr (27/10/2021)
				// Ajout du paramétrage des impressions
				$position_t:="center"
				
				$table_o:=ds:C1482.PARAM.query("type = :1 AND structureRef = :2"; "*IMPRESSION"; <>ref_soc_active)
				
				If ($table_o.length<3)
					$table_o.drop()
					
					For ($i_el; 1; 3)
						$enregistrement_o:=ds:C1482.PARAM.new()
						
						$enregistrement_o.structureRef:=<>ref_soc_active
						$enregistrement_o.type:="*IMPRESSION"
						
						$enregistrement_o.extraParam:=New object:C1471("detail"; New collection:C1472)
						
						Case of 
							: ($i_el=1)
								$enregistrement_o.valeur:="Impression A4"
							: ($i_el=2)
								$enregistrement_o.valeur:="Impression B34"
							: ($i_el=3)
								$enregistrement_o.valeur:="Impression Rapport"
						End case 
						
						$enregistrement_o.extraParam.detail.push(\
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 40); "champ"; "HG_EtatCivil"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 5); "champ"; "HG_Signalement"; "visible"; True:C214); \
							New object:C1471("label"; "Fiche n°"; "champ"; "HG_FicheNuméro"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 19); "champ"; "HG_Maraude1_1"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 7); "champ"; "HG_CodePostal"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 48); "champ"; "HG_Orientation1"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 8); "champ"; "HG_Gare"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 49); "champ"; "HG_Orientation2"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 9); "champ"; "HG_Métro"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 50); "champ"; "HG_AutreSolutio"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 10); "champ"; "HG_Emplacement"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 28); "champ"; "HG_RupMajeur1"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 29); "champ"; "HG_RupMajeur2"; "visible"; True:C214); \
							New object:C1471("label"; Get indexed string:C510(<>vlSTR_Std; 30); "champ"; "HG_RupMajeur3"; "visible"; True:C214); \
							New object:C1471("label"; "Référence produit 1"; "champ"; "refProduit1"; "visible"; True:C214); \
							New object:C1471("label"; "Référence produit 2"; "champ"; "refProduit2"; "visible"; True:C214); \
							New object:C1471("label"; "Référence produit 3"; "champ"; "refProduit3"; "visible"; True:C214))
						
						$enregistrement_o.save()
					End for 
					
				Else 
					
					For each ($enregistrement_o; $table_o)
						$collection_c:=$enregistrement_o.extraParam.detail.query("label = :1"; "Référence produit@")
						
						If ($collection_c.length=0)
							$enregistrement_o.extraParam.detail.push(\
								New object:C1471("label"; "Référence produit 1"; "champ"; "refProduit1"; "visible"; True:C214); \
								New object:C1471("label"; "Référence produit 2"; "champ"; "refProduit2"; "visible"; True:C214); \
								New object:C1471("label"; "Référence produit 3"; "champ"; "refProduit3"; "visible"; True:C214))
							
							$enregistrement_o.save()
						End if 
						
					End for each 
					
				End if 
				
				$table_o:=ds:C1482.PARAM.query("type = :1 AND structureRef = :2"; "*IMPRESSION"; <>ref_soc_active)
				$form_o:=New object:C1471("entitySelection"; $table_o)
				
				outilsCreateWindowsForm("DL_ParamImp"; ->$position_t; $form_o; ->[DiaLogues:3])
			: (<>ta_Utils=27)  //"Gestion des purges"
				Process_Go(-><>PR_Purge; "Go_uPurge"; "Purge1"; 64)
			: (<>ta_Utils=28)  //"Gestion des dates de naissance"
				Process_Go(-><>PR_ModNé; "Go_uModNéle"; "Néle"; 64)
			: (<>ta_Utils=29)  //"Préparation des disponibilités …"
				Go_PréparerDispos
			: (<>ta_Utils=30)  //"-"
			: (<>ta_Utils=31)  //"Visualisation des reports"
				Process_Go(-><>PR_RésReport; "Go_uRésReport"; "RésReport"; 64)
			: (<>ta_Utils=32)  //"-"
			: (<>ta_Utils=33)  //"Plateforme réservée"·
				Process_Go(-><>PR_DévTables; "Go_uTablesDév"; "TablesDév"; 64)
			: (<>ta_Utils=35)  //"Export"
				Process_Go(-><>PR_Export0312770; "export_global"; "export_global"; 128)
				Process_Go(-><>PR_Export0312771; "export_table_50"; "export_global1"; 128)
				Process_Go(-><>PR_Export0312772; "export_table_51"; "export_global2"; 128)
				Process_Go(-><>PR_Export0312773; "export_table_52"; "export_global3"; 128)
			: (<>ta_Utils=36)  //"-"
			: (<>ta_Utils=37)  //"Coordinateur par défaut"
				Process_Go(-><>PR_CoorD; "Go_uCoorD"; "CoorDéfaut"; 64)
			: (<>ta_Utils=38)  //"Asile Famille par défaut"
				Process_Go(-><>PR_AsileD; "Go_uAsileD"; "AsileDéfaut"; 64)
			: (<>ta_Utils=39)  //"Signalements liés aux touches F1, F2"
				Process_Go(-><>PR_SigltD; "Go_uSignalD"; "SignalDéfaut"; 64)
			: (<>ta_Utils=40)  //"Groupes nombre de membres"
				Process_Go(-><>PR_GpeNb; "Go_uGroupeNb"; "◊PR_GpeNb"; 64)
			: (<>ta_Utils=41)  //"Champs à dupliquer"
				Process_Go(-><>PR_DupChamp; "Go_uDup"; "ChampDupliquer"; 64)
			: (<>ta_Utils=77)  //"Champs à dupliquer : nouvelles fiches"
				Process_Go(-><>PR_DupChamp; "Go_uDup_Nv"; "ChampDupliquer"; 64)
			: (<>ta_Utils=42)  //"Gestion des centres"
				Process_Go(-><>PR_CentreEXC; "Go_uCentreEXC"; "CentreEXC"; 64)
			: (<>ta_Utils=43)  //"Autres solutions"
				Process_Go(-><>PR_AutreSolD; "Go_uAutreSolD"; "AutreSolD"; 64)
			: (<>ta_Utils=44)  //"Prolongations : paramètres"
				Process_Go(-><>PR_ProlongationID; "Go_uProlongationID"; "ProlongationIlD"; 64)
			: (<>ta_Utils=45)  //"Prolongations : paramètres"
				DebutDecAge(1)
			: (<>ta_Utils=46)  //"Fusions : paramètres"
				Process_Go(-><>PR_FusionNotes; "Go_uFusionNotes"; "FusionNotes"; 64)
			: (<>ta_Utils=47)  //"-"
			: (<>ta_Utils=48)  //"Fusions : Etat civil"        
				Process_Go(-><>PR_FusionEtCv; "Go_uFusionEtCv"; "FusionEtCv"; 64)
			: (<>ta_Utils=52)  //"Item : Rattrapage"      
				Process_Go(-><>PR_Correction; "Go_Correction"; "Correction"; 64)
			: (<>ta_Utils=54)  //"GPS"        
				Process_Go(-><>PR_LienGPS; "P_LienGPS"; "LienGPS"; 64)
			: (<>ta_Utils=55)  //"Fiches max"                
				Process_Go(-><>PR_MaxFiche; "Go_uMaxFiche"; "MaxFiche"; 64)
			: (<>ta_Utils=56)  //"Conso : Voir fichesl"        
				Process_Go(-><>PR_Conso115Voir; "Go_uConsolidation115Voir"; "ConsoVoir"; 64)
			: (<>ta_Utils=57)  //"Paramètres de pointage"
				// Modifié par : Scanu Rémy - remy@connect-io.fr (12/07/2021)
				// Ajout du paramètre de pointage Hébergement
				CONFIRM:C162("Souhaitez-vous paramétrer le pointage \"Hébergement\" ?"; "Oui"; "Non")
				
				If (OK=1)
					Process_Go(-><>PR_Pointage; "Go_uPointageHebergement"; "Pointage"; 64)
				Else 
					Process_Go(-><>PR_Pointage; "Go_uPointage"; "Pointage"; 64)
				End if 
				
			: (<>ta_Utils=58)  //"Regroupement d'Items                
				Process_Go(-><>PR_ItemGrouper; "Go_uItemGrouper"; "temGroupe"; 64)
				
			: (<>ta_Utils=60)  //"Regroupement d'Items      (PRÉSENTATION   
				Process_Go(-><>PR_Présentation; "Go_uPrésentation"; "Présentation"; 64)
				
			: (<>ta_Utils=62)  //"Website 115   
				Process_Go(-><>PR_Website; "Go_Website"; "Website"; 64)
				
			: (<>ta_Utils=64)  //"Botttin social
				Process_Go(-><>PR_Bottin; "Go_Bottin"; "Bottin"; 0)
			: (<>ta_Utils=85)  //"4D Write PRO
				READ WRITE:C146([DOCWPRO:121])
				$position_o:=New object:C1471("ecartHautEcran"; 30; "ecartBasEcran"; 70)
				
				outilsCreateWindowsForm("DL_DocWPro"; ->$position_o; $form_o; ->[DiaLogues:3])
			: (<>ta_Utils=87)  //"Gestion du stock
				
				If (User in group:C338(Current user:C182; "GestionStock")=True:C214)
					$position_o:=New object:C1471("ecartHautEcran"; Tool bar height:C1016+Menu bar height:C440+10; "ecartBasEcran"; 70)
					
					outilsCreateWindowsForm("Gestion"; ->$position_o; New object:C1471; ->[StockBis:122])
				Else 
					ALERT:C41("Fonction indisponible")
				End if 
				
			: (<>ta_Utils=89)  //"Gestion des CGU
				$position_t:="center"
				outilsCreateWindowsForm("FormCGUGestion"; ->$position_t)
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
			: (<>ta_Utils=13)  //"Numérotation des fiches"
				Process_Go(-><>PR_NoFicheH; "Go_uNoFiche"; "NoFiche"; 64)
			: (<>ta_Utils=14)  //"Suppression d'une fiche d'hébergement"
				Go_uHebergementSup
			: (<>ta_Utils=15)  //"-"        
			: (<>ta_Utils=18)  //"Paramètres Age par défaut des inconnus"
				Process_Go(-><>PR_AgeDéfaut; "Go_uAgeDéfaut"; "AgeDéfaut"; 64)
			: (<>ta_Utils=35)  //"Export"
				Process_Go(-><>PR_Export0312770; "Go_uExportTGIP"; "uExport"; 64)
			: (<>ta_Utils=36)  //"-"
			: (<>ta_Utils=37)  //"Coordinateur par défaut"
				Process_Go(-><>PR_CoorD; "Go_uCoorD"; "CoorDéfaut"; 64)
			: (<>ta_Utils=38)  //"Asile Famille par défaut"
				Process_Go(-><>PR_AsileD; "Go_uAsileD"; "AsileDéfaut"; 64)
			: (<>ta_Utils=39)  //"Signalements liés aux touches F1, F2, F3"
				Process_Go(-><>PR_SigltD; "Go_uSignalD"; "SignalDéfaut"; 64)
			: (<>ta_Utils=40)  //"Groupes nombre de membres"
				Process_Go(-><>PR_GpeNb; "Go_uGroupeNb"; "◊PR_GpeNb"; 64)
			: (<>ta_Utils=41)  //"Champs à dupliquer"
				Process_Go(-><>PR_DupChamp; "Go_uDup"; "ChampDupliquer"; 64)
			: (<>ta_Utils=42)  //"Gestion des centres"
				Process_Go(-><>PR_CentreEXC; "Go_uCentreEXC"; "CentreEXC"; 64)
			: (<>ta_Utils=43)  //"Autres solutions"
				Process_Go(-><>PR_AutreSolD; "Go_uAutreSolD"; "AutreSolD"; 64)
			: (<>ta_Utils=44)  //"Prolongations : paramètres"
				Process_Go(-><>PR_ProlongationID; "Go_uProlongationID"; "ProlongationIlD"; 64)
			: (<>ta_Utils=45)  //"Prolongations : paramètres"
				DebutDecAge(1)
			: (<>ta_Utils=46)  //"Fusions : paramètres"
				Process_Go(-><>PR_FusionNotes; "Go_uFusionNotes"; "FusionNotes"; 64)
			: (<>ta_Utils=47)  //"-"
			: (<>ta_Utils=48)  //"Fusions : Etat civil"        
				Process_Go(-><>PR_FusionEtCv; "Go_uFusionEtCv"; "FusionEtCv"; 64)
			: (<>ta_Utils=80)  //"4D Write PRO
				READ WRITE:C146([DOCWPRO:121])
				$position_o:=New object:C1471("ecartHautEcran"; 30; "ecartBasEcran"; 70)
				
				outilsCreateWindowsForm("DL_DocWPro"; ->$position_o; $form_o; ->[DiaLogues:3])
			: (<>ta_Utils=82)  //"Gestion du stock
				
				If (User in group:C338(Current user:C182; "GestionStock")=True:C214)
					$position_o:=New object:C1471("ecartHautEcran"; Tool bar height:C1016+Menu bar height:C440+10; "ecartBasEcran"; 70)
					
					outilsCreateWindowsForm("Gestion"; ->$position_o; New object:C1471; ->[StockBis:122])
				Else 
					ALERT:C41("Fonction indisponible")
				End if 
				
			: (<>ta_Utils=84)  //"Gestion des CGU
				$position_t:="center"
				outilsCreateWindowsForm("FormCGUGestion"; ->$position_t)
			Else 
				ALERT:C41("Plateforme réservée au développement !")
		End case 
		
		$vb_OK:=False:C215
	End if 
	
End if 