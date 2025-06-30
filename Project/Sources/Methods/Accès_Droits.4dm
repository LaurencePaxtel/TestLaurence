//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Accès_Droits
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
Case of 
	: (User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	: (User in group:C338(Current user:C182; <>Groupe_ADMIN))
		
	Else 
		//éléments du fond
		If (7=8)
			OBJECT SET VISIBLE:C603(*; "Main_BleuCadre"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_BleuTitre"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_Fond"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_Ligne1"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_Ligne2"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_Rectangle1"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_Rectangle2"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_User"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_UserVariable1"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_Profil"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_ProfilVariable1"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_Date"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_ProfilVariable2"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Main_Version"; False:C215)
		End if 
		//Boutons et fonctions
		OBJECT SET VISIBLE:C603(*; "DemPrest_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "AdrUtil_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "SitPart_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Assoc_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Centre_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Dispo_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "OptVeille_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Outil_@"; False:C215)
		
		OBJECT SET VISIBLE:C603(*; "NoFiche_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Localisation_Texte1"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LocRecherche_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LocNoFiche_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Hébergement_Texte1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "HébergementJ_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "HébergementN_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Télécopie_Texte1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "TélécopieJ_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "TélécopieN_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Correction_Texte1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "CorrectionItem_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "CorrectionFusion_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Veille_Texte1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Veille115_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "MaraudeVeille_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Maraude_Texte1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "MaraudeJ_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "MaraudeN_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Statistiques_Texte1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Statistiques_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Prestation_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Dossier_Texte1@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Dossier_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "Report_@"; False:C215)
		
		//••••
		OBJECT SET VISIBLE:C603(*; "Différé_@"; False:C215)
		//••••
		
		If (User in group:C338(Current user:C182; <>Groupe_DemPrestations))
			OBJECT SET VISIBLE:C603(*; "DemPrest_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_DemAdrUtil))
			OBJECT SET VISIBLE:C603(*; "AdrUtil_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_DemSitPart))
			OBJECT SET VISIBLE:C603(*; "SitPart_@"; True:C214)
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Association))
			OBJECT SET VISIBLE:C603(*; "Assoc_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_Centre))
			OBJECT SET VISIBLE:C603(*; "Centre_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_Disponibilité))
			OBJECT SET VISIBLE:C603(*; "Dispo_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_OptVeille))
			OBJECT SET VISIBLE:C603(*; "OptVeille_@"; True:C214)
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Utilitaires))
			OBJECT SET VISIBLE:C603(*; "Outil_@"; True:C214)
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_FicheEnCours))
			OBJECT SET VISIBLE:C603(*; "NoFiche_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_Recherche))
			OBJECT SET VISIBLE:C603(*; "Localisation_Texte1"; True:C214)
			OBJECT SET VISIBLE:C603(*; "LocRecherche_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_FicheNo))
			OBJECT SET VISIBLE:C603(*; "Localisation_Texte1"; True:C214)
			OBJECT SET VISIBLE:C603(*; "LocNoFiche_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_Jour))
			OBJECT SET VISIBLE:C603(*; "Hébergement_Texte1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "HébergementJ_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_Nuit))
			OBJECT SET VISIBLE:C603(*; "Hébergement_Texte1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "HébergementN_@"; True:C214)
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_FaxJour))
			OBJECT SET VISIBLE:C603(*; "Télécopie_Texte1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "TélécopieJ_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_FaxNuit))
			OBJECT SET VISIBLE:C603(*; "Télécopie_Texte1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "TélécopieN_@"; True:C214)
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Item))
			OBJECT SET VISIBLE:C603(*; "Correction_Texte1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "CorrectionItem_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_Fusion))
			OBJECT SET VISIBLE:C603(*; "Correction_Texte1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "CorrectionFusion_@"; True:C214)
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Veille))
			OBJECT SET VISIBLE:C603(*; "Veille_Texte1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "Veille115_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_Prestations))
			OBJECT SET VISIBLE:C603(*; "Prestation_@"; True:C214)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_Report))
			OBJECT SET VISIBLE:C603(*; "Report_@"; True:C214)
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Maraude))
			OBJECT SET VISIBLE:C603(*; "Veille_Texte1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "MaraudeVeille_@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "Maraude_Texte1@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "MaraudeJ_@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "MaraudeN_@"; True:C214)
		End if 
		
		C_LONGINT:C283($ii)
		$ii:=0
		$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_DosInfirmier))
		$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_DosMédical))
		$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_DosPsycho))
		$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_DosSocial))
		If ($ii>0)
			OBJECT SET VISIBLE:C603(*; "Dossier_Texte1@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "Dossier_@"; False:C215)
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Statistiques))
			OBJECT SET VISIBLE:C603(*; "Statistiques_@"; True:C214)  //Statistiques
		Else 
			$ii:=0
			$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_StatCoor))
			$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_StatCoorS))
			$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_StatDirection))
			$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_StatEtude))
			$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_StatSpécifique))
			$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_StatDASS))
			$ii:=$ii+Num:C11(User in group:C338(Current user:C182; <>Groupe_StatGroupe))
			If ($ii>0)
				OBJECT SET VISIBLE:C603(*; "Statistiques_@"; False:C215)
			End if 
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Externe))
			// ACTIVER BOUTON(b_FSH_i)
			//ACTIVER BOUTON(b_FSH_F)
			//ACTIVER BOUTON(b_FSH_J)
			//ACTIVER BOUTON(b_FSH_N)
			//ACTIVER BOUTON(b_Veil)
			//ACTIVER BOUTON(b_RG)
			//ACTIVER BOUTON(b_CE_D)
		End if 
		If (User in group:C338(Current user:C182; <>Groupe_Médecin))
		End if 
		If (<>vb_UserLOFT)
			OBJECT SET VISIBLE:C603(*; "OptVeille_@"; False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*; "OptVeille_@"; True:C214)
		End if 
		
		If (User in group:C338(Current user:C182; <>Groupe_Différé))
			OBJECT SET VISIBLE:C603(*; "Différé_@"; True:C214)
		End if 
		
		OBJECT SET VISIBLE:C603(*; "Outil_@"; True:C214)
End case 