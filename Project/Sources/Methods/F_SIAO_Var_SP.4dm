//%attributes = {}
//{==================================================}I
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_SP
//{
//{          Lundi 6 décembre 2010 à 12:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_POINTER:C301($4)
C_LONGINT:C283($5)
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(tl_SP_Reference; 0)
		ARRAY LONGINT:C221(tl_SP_SIAO_ID; 0)
		ARRAY LONGINT:C221(tl_SP_Personne_ID; 0)
		ARRAY TEXT:C222(ta_SP_Famille; 0)
		ARRAY TEXT:C222(ta_SP_Theme; 0)
		ARRAY TEXT:C222(ta_SP_SousTheme; 0)
		ARRAY LONGINT:C221(tl_SP_Rang; 0)
		ARRAY TEXT:C222(ta_SP_Nom; 0)
		ARRAY TEXT:C222(ta_SP_Prenom; 0)
		ARRAY DATE:C224(td_SP_NeLeDate; 0)
		
		
		C_TEXT:C284(va_SIAO_SP_Type)
		
		C_LONGINT:C283(vl_SP_Reference)
		C_LONGINT:C283(vl_SP_SIAO_ID)
		C_LONGINT:C283(vl_SP_Personne_ID)
		C_TEXT:C284(va_SP_Famille)
		C_TEXT:C284(va_SP_Theme)
		C_TEXT:C284(va_SP_SousTheme)
		C_LONGINT:C283(vl_SP_Rang)
		
		C_TEXT:C284(va_SP_EtatCivil)
		C_TEXT:C284(va_SP_Civilite)
		C_BOOLEAN:C305(vb_SP_Genre)
		C_LONGINT:C283(vL_SP_Genre1; vL_SP_Genre2)
		
		C_TEXT:C284(va_SP_Nom)
		C_TEXT:C284(va_SP_NomJeuneFille)
		C_TEXT:C284(va_SP_Prenom)
		C_DATE:C307(vd_SP_NeLeDate)
		C_LONGINT:C283(vl_SP_NeLeAge)
		C_TEXT:C284(vla_SP_NeLeAgePlus)
		
		C_TEXT:C284(va_SP_NeLeLieu)
		C_TEXT:C284(va_SP_NeLePays)
		C_LONGINT:C283(vl_SP_SituationFamille)
		C_TEXT:C284(va_SP_SituationFamille)
		C_LONGINT:C283(vl_SP_Parente)
		C_TEXT:C284(va_SP_Parente)
		C_TEXT:C284(va_SP_Nationalite)
		C_TEXT:C284(va_SP_NationalitePlus)
		
		
		C_TEXT:C284(va_SP_Papier)
		C_TEXT:C284(va_SP_PapierType)
		
		C_TEXT:C284(va_SP_EtudeNiveau)
		C_TEXT:C284(va_SP_EtudeLieu)
		C_TEXT:C284(va_SP_CasSpecific)
		
		C_TEXT:C284(va_SP_Telephone)
		
		C_LONGINT:C283(vl_SP_EnfantNombre)
		C_BOOLEAN:C305(vb_SP_EnfantACharge)
		C_TEXT:C284(va_SP_EnfantNote)
		
		C_TEXT:C284(vt_SP_AdrH; vt_SP_AdrD)
		
		
		//Pour impession
		C_TEXT:C284(vt_SP_N_Identite)
		C_DATE:C307(vd_SP_N_DatJour)
		
		C_TEXT:C284(vt_SP_N_Corps)
		
		
	: ($1=1)
		va_SIAO_SP_Type:=""
		
		vl_SP_Reference:=0
		vl_SP_SIAO_ID:=0
		vl_SP_Personne_ID:=0
		va_SP_Famille:=""
		va_SP_Theme:=""
		va_SP_SousTheme:=""
		vl_SP_Rang:=0
		
		va_SP_EtatCivil:=""
		va_SP_Civilite:=""
		vb_SP_Genre:=False:C215
		vL_SP_Genre1:=Num:C11(vb_SP_Genre=False:C215)
		vL_SP_Genre2:=Num:C11(vb_SP_Genre=True:C214)
		
		va_SP_Nom:=""
		va_SP_NomJeuneFille:=""
		va_SP_Prenom:=""
		vd_SP_NeLeDate:=!00-00-00!
		vl_SP_NeLeAge:=0
		va_SP_NeLeAgePlus:=""
		
		va_SP_NeLeLieu:=""
		va_SP_NeLePays:=""
		vl_SP_SituationFamille:=0
		va_SP_SituationFamille:=""
		vl_SP_Parente:=0
		va_SP_Parente:=""
		va_SP_Nationalite:=""
		va_SP_NationalitePlus:=""
		
		va_SP_Papier:=""
		va_SP_PapierType:=""
		
		va_SP_EtudeNiveau:=""
		va_SP_EtudeLieu:=""
		va_SP_CasSpecific:=""
		
		va_SP_Telephone:=""
		
		vl_SP_EnfantNombre:=0
		vb_SP_EnfantACharge:=False:C215
		va_SP_EnfantNote:=""
		
	: ($1=2)
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=$2)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >; *)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Nom:11; >; *)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Prenom:13; >)
		SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_RéférenceID:1; tl_SP_Reference; [SIAO_Personnes:51]Sp_SIAO_ID:2; tl_SP_SIAO_ID; [SIAO_Personnes:51]Sp_Personne_ID:3; tl_SP_Personne_ID; [SIAO_Personnes:51]Sp_Famille:4; ta_SP_Famille; [SIAO_Personnes:51]Sp_Theme:5; ta_SP_Theme; [SIAO_Personnes:51]Sp_SousTheme:6; ta_SP_SousTheme; [SIAO_Personnes:51]Sp_Rang:7; tl_SP_Rang; [SIAO_Personnes:51]Sp_Nom:11; ta_SP_Nom; [SIAO_Personnes:51]Sp_Prenom:13; ta_SP_Prenom; [SIAO_Personnes:51]Sp_Date_de_naissance:14; td_SP_NeLeDate)
		If (Size of array:C274(ta_SP_Nom)>0)
			ta_SP_Nom:=1
		Else 
			ta_SP_Nom:=0
		End if 
		$0:=(ta_SP_Nom>0)
		
	: ($1=3)
		$vb_OK:=False:C215
		If ($2>0)
			QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_RéférenceID:1=$2)
			MultiSoc_Filter(->[SIAO_Personnes:51])
			If (Records in selection:C76([SIAO_Personnes:51])=1)
				$vb_OK:=True:C214
			End if 
		End if 
		If ($vb_OK)
			
			va_SIAO_SP_Type:=ta_SP_SousTheme{ta_SP_Nom}
			
			
			vl_SP_Reference:=[SIAO_Personnes:51]Sp_RéférenceID:1
			vl_SP_SIAO_ID:=[SIAO_Personnes:51]Sp_SIAO_ID:2
			vl_SP_Personne_ID:=[SIAO_Personnes:51]Sp_Personne_ID:3
			va_SP_Famille:=[SIAO_Personnes:51]Sp_Famille:4
			va_SP_Theme:=[SIAO_Personnes:51]Sp_Theme:5
			va_SP_SousTheme:=[SIAO_Personnes:51]Sp_SousTheme:6
			vl_SP_Rang:=[SIAO_Personnes:51]Sp_Rang:7
			
			va_SP_EtatCivil:=[SIAO_Personnes:51]Sp_EtatCivil:8
			va_SP_Civilite:=[SIAO_Personnes:51]Sp_Civilite:9
			vb_SP_Genre:=[SIAO_Personnes:51]Sp_Genre:10
			vL_SP_Genre1:=Num:C11(vb_SP_Genre=False:C215)
			vL_SP_Genre2:=Num:C11(vb_SP_Genre=True:C214)
			
			va_SP_Nom:=[SIAO_Personnes:51]Sp_Nom:11
			va_SP_NomJeuneFille:=[SIAO_Personnes:51]Sp_Nom_de_jeune_fille:12
			va_SP_Prenom:=[SIAO_Personnes:51]Sp_Prenom:13
			vd_SP_NeLeDate:=[SIAO_Personnes:51]Sp_Date_de_naissance:14
			vl_SP_NeLeAge:=[SIAO_Personnes:51]Sp_Age:15
			va_SP_NeLeAgePlus:=[SIAO_Personnes:51]Sp_Age_plus:16
			
			va_SP_NeLeLieu:=[SIAO_Personnes:51]Sp_Lieu_de_naissance_Ville:17
			va_SP_NeLePays:=[SIAO_Personnes:51]Sp_Lieu_de_naissance_pays:18
			vl_SP_SituationFamille:=[SIAO_Personnes:51]Sp_Situation_familiale:19
			va_SP_SituationFamille:=[SIAO_Personnes:51]Sp_Situation_familiale_plus:20
			vl_SP_Parente:=[SIAO_Personnes:51]Sp_Parente:21
			va_SP_Parente:=[SIAO_Personnes:51]Sp_Parente_plus:22
			va_SP_Nationalite:=[SIAO_Personnes:51]Sp_Nationalite:23
			va_SP_NationalitePlus:=[SIAO_Personnes:51]Sp_Nationalité_plus:24
			
			va_SP_Papier:=[SIAO_Personnes:51]Sp_Carte_d_identite_no:26
			va_SP_PapierType:=[SIAO_Personnes:51]Sp_Carte_de_sejour_nature:28
			
			va_SP_EtudeNiveau:=[SIAO_Personnes:51]Sp_Niveau_d_etude:32
			va_SP_EtudeLieu:=[SIAO_Personnes:51]Sp_Lieu_d_etude_en_cours:33
			va_SP_CasSpecific:=[SIAO_Personnes:51]Sp_CasSpecific:38
			
			va_SP_Telephone:=[SIAO_Personnes:51]Sp_Telephone:34
			
			vl_SP_EnfantNombre:=[SIAO_Personnes:51]Sp_EnfantNombre:35
			vb_SP_EnfantACharge:=[SIAO_Personnes:51]Sp_EnfantAcharge:36
			va_SP_EnfantNote:=[SIAO_Personnes:51]Sp_EnfantNote:37
			
		Else 
			F_SIAO_Var_SP(1; 0; 0; <>vp_SIAO_PointeurVide; 0)
		End if 
		
		
	: ($1=5)
		READ WRITE:C146([SIAO_Personnes:51])
		CREATE RECORD:C68([SIAO_Personnes:51])
		MultiSoc_Init_Structure(->[SIAO_Personnes:51])
		[SIAO_Personnes:51]Sp_RéférenceID:1:=Uut_Numerote(->[SIAO_Personnes:51])
		
		[SIAO_Personnes:51]Sp_SIAO_ID:2:=[SIAO:50]Si_RéférenceID:1
		[SIAO_Personnes:51]Sp_Personne_ID:3:=$2
		[SIAO_Personnes:51]Sp_Famille:4:="SITUATION DE FAMILLE"
		[SIAO_Personnes:51]Sp_Theme:5:="ELEMENTS DE LA DEMANDE"
		[SIAO_Personnes:51]Sp_SousTheme:6:=ta_SIAO_PopSitFamCode{ta_SIAO_PopSitFam}
		
		[SIAO_Personnes:51]Sp_Rang:7:=ta_SIAO_PopSitFam-2
		
		[SIAO_Personnes:51]Sp_EtatCivil:8:=va_SIAO_EtatCivil
		[SIAO_Personnes:51]Sp_Civilite:9:=""
		[SIAO_Personnes:51]Sp_Genre:10:=F_EtatCivilGenre([SIAO_Personnes:51]Sp_EtatCivil:8)
		[SIAO_Personnes:51]Sp_Nom:11:=[HeBerge:4]HB_Nom:3  //modif lpc 24/10/2018
		[SIAO_Personnes:51]Sp_Nom_de_jeune_fille:12:=""
		[SIAO_Personnes:51]Sp_Prenom:13:=[HeBerge:4]HB_Prénom:4  //modif lpc 24/10/2018
		[SIAO_Personnes:51]Sp_Date_de_naissance:14:=Current date:C33
		[SIAO_Personnes:51]Sp_Age:15:=0
		[SIAO_Personnes:51]Sp_Age_plus:16:=""
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$2)
		MultiSoc_Filter(->[HeBerge:4])
		If (Records in selection:C76([HeBerge:4])=1)
			[SIAO_Personnes:51]Sp_Nom:11:=[HeBerge:4]HB_Nom:3
			[SIAO_Personnes:51]Sp_Prenom:13:=[HeBerge:4]HB_Prénom:4
			[SIAO_Personnes:51]Sp_Date_de_naissance:14:=[HeBerge:4]HB_DateNéLe:5
			[SIAO_Personnes:51]Sp_Genre:10:=[HeBerge:4]HG_Genre:39
			[SIAO_Personnes:51]Sp_Age:15:=Uut_HébergéAgePlus(->[SIAO_Personnes:51]Sp_Date_de_naissance:14; ->[SIAO:50]Si_Demande_Date:2)
			
		End if 
		[SIAO_Personnes:51]Sp_Lieu_de_naissance_Ville:17:=""
		[SIAO_Personnes:51]Sp_Lieu_de_naissance_pays:18:=""
		[SIAO_Personnes:51]Sp_Situation_familiale:19:=0
		[SIAO_Personnes:51]Sp_Situation_familiale_plus:20:=""
		[SIAO_Personnes:51]Sp_Parente:21:=0
		[SIAO_Personnes:51]Sp_Parente_plus:22:=""
		[SIAO_Personnes:51]Sp_Nationalite:23:=""
		[SIAO_Personnes:51]Sp_Nationalité_plus:24:=""
		
		[SIAO_Personnes:51]Sp_Carte_d_identite_no:26:=""
		[SIAO_Personnes:51]Sp_Carte_de_sejour_nature:28:=""
		
		[SIAO_Personnes:51]Sp_Niveau_d_etude:32:=""
		[SIAO_Personnes:51]Sp_Lieu_d_etude_en_cours:33:=""
		
		[SIAO_Personnes:51]Sp_Telephone:34:=""
		
		[SIAO_Personnes:51]Sp_EnfantNombre:35:=0
		[SIAO_Personnes:51]Sp_EnfantAcharge:36:=False:C215
		[SIAO_Personnes:51]Sp_EnfantNote:37:=""
		
		[SIAO_Personnes:51]Sp_CasSpecific:38:=""
		SAVE RECORD:C53([SIAO_Personnes:51])
		
		vl_SP_Reference:=[SIAO_Personnes:51]Sp_RéférenceID:1
		If (7=8)
			vl_SP_SIAO_ID:=[SIAO_Personnes:51]Sp_SIAO_ID:2
			vl_SP_Personne_ID:=[SIAO_Personnes:51]Sp_Personne_ID:3
			va_SP_Famille:=[SIAO_Personnes:51]Sp_Famille:4
			va_SP_Theme:=[SIAO_Personnes:51]Sp_Theme:5
			va_SP_SousTheme:=[SIAO_Personnes:51]Sp_SousTheme:6
			vl_SP_Rang:=[SIAO_Personnes:51]Sp_Rang:7
			
			va_SP_EtatCivil:=[SIAO_Personnes:51]Sp_EtatCivil:8
			va_SP_Civilite:=[SIAO_Personnes:51]Sp_Civilite:9
			vb_SP_Genre:=[SIAO_Personnes:51]Sp_Genre:10
			va_SP_Nom:=[SIAO_Personnes:51]Sp_Nom:11
			va_SP_NomJeuneFille:=[SIAO_Personnes:51]Sp_Nom_de_jeune_fille:12
			va_SP_Prenom:=[SIAO_Personnes:51]Sp_Prenom:13
			vd_SP_NeLeDate:=[SIAO_Personnes:51]Sp_Date_de_naissance:14
			vl_SP_NeLeAge:=[SIAO_Personnes:51]Sp_Age:15
			va_SP_NeLeAgePlus:=[SIAO_Personnes:51]Sp_Age_plus:16
			
			va_SP_NeLeLieu:=[SIAO_Personnes:51]Sp_Lieu_de_naissance_Ville:17
			va_SP_NeLePays:=[SIAO_Personnes:51]Sp_Lieu_de_naissance_pays:18
			vl_SP_SituationFamille:=[SIAO_Personnes:51]Sp_Situation_familiale:19
			va_SP_SituationFamille:=[SIAO_Personnes:51]Sp_Situation_familiale_plus:20
			vl_SP_Parente:=[SIAO_Personnes:51]Sp_Parente:21
			va_SP_Parente:=[SIAO_Personnes:51]Sp_Parente_plus:22
			va_SP_Nationalite:=[SIAO_Personnes:51]Sp_Nationalite:23
			va_SP_NationalitePlus:=[SIAO_Personnes:51]Sp_Nationalité_plus:24
			
			va_SP_Papier:=[SIAO_Personnes:51]Sp_Carte_d_identite_no:26
			va_SP_PapierType:=[SIAO_Personnes:51]Sp_Carte_de_sejour_nature:28
			
			va_SP_EtudeNiveau:=[SIAO_Personnes:51]Sp_Niveau_d_etude:32
			va_SP_EtudeLieu:=[SIAO_Personnes:51]Sp_Lieu_d_etude_en_cours:33
			
			va_SP_CasSpecific:=[SIAO_Personnes:51]Sp_CasSpecific:38
			
			va_SP_Telephone:=[SIAO_Personnes:51]Sp_Telephone:34
			
			vl_SP_EnfantNombre:=[SIAO_Personnes:51]Sp_EnfantNombre:35
			vb_SP_EnfantACharge:=[SIAO_Personnes:51]Sp_EnfantAcharge:36
			va_SP_EnfantNote:=[SIAO_Personnes:51]Sp_EnfantNote:37
			
			$ii:=Size of array:C274(tl_SP_Reference)+1
			INSERT IN ARRAY:C227(tl_SP_Reference; $ii; 1)
			INSERT IN ARRAY:C227(tl_SP_SIAO_ID; $ii; 1)
			INSERT IN ARRAY:C227(tl_SP_Personne_ID; $ii; 1)
			INSERT IN ARRAY:C227(ta_SP_Famille; $ii; 1)
			INSERT IN ARRAY:C227(ta_SP_Theme; $ii; 1)
			INSERT IN ARRAY:C227(ta_SP_SousTheme; $ii; 1)
			INSERT IN ARRAY:C227(tl_SP_Rang; $ii; 1)
			INSERT IN ARRAY:C227(ta_SP_Nom; $ii; 1)
			INSERT IN ARRAY:C227(ta_SP_Prenom; $ii; 1)
			INSERT IN ARRAY:C227(td_SP_NeLeDate; $ii; 1)
			
			tl_SP_Reference{$ii}:=[SIAO_Personnes:51]Sp_RéférenceID:1
			tl_SP_SIAO_ID{$ii}:=[SIAO_Personnes:51]Sp_SIAO_ID:2
			tl_SP_Personne_ID{$ii}:=[SIAO_Personnes:51]Sp_Personne_ID:3
			ta_SP_Famille{$ii}:=[SIAO_Personnes:51]Sp_Famille:4
			ta_SP_Theme{$ii}:=[SIAO_Personnes:51]Sp_Theme:5
			ta_SP_SousTheme{$ii}:=[SIAO_Personnes:51]Sp_SousTheme:6
			tl_SP_Rang{$ii}:=[SIAO_Personnes:51]Sp_Rang:7
			ta_SP_Nom{$ii}:=[SIAO_Personnes:51]Sp_Nom:11
			ta_SP_Prenom{$ii}:=[SIAO_Personnes:51]Sp_Prenom:13
			td_SP_NeLeDate{$ii}:=[SIAO_Personnes:51]Sp_Date_de_naissance:14
		End if 
		
		UNLOAD RECORD:C212([SIAO_Personnes:51])
		READ ONLY:C145([SIAO_Personnes:51])
		
		
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=$2)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >; *)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Nom:11; >; *)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Prenom:13; >)
		SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_RéférenceID:1; tl_SP_Reference; [SIAO_Personnes:51]Sp_SIAO_ID:2; tl_SP_SIAO_ID; [SIAO_Personnes:51]Sp_Personne_ID:3; tl_SP_Personne_ID; [SIAO_Personnes:51]Sp_Famille:4; ta_SP_Famille; [SIAO_Personnes:51]Sp_Theme:5; ta_SP_Theme; [SIAO_Personnes:51]Sp_SousTheme:6; ta_SP_SousTheme; [SIAO_Personnes:51]Sp_Rang:7; tl_SP_Rang; [SIAO_Personnes:51]Sp_Nom:11; ta_SP_Nom; [SIAO_Personnes:51]Sp_Prenom:13; ta_SP_Prenom; [SIAO_Personnes:51]Sp_Date_de_naissance:14; td_SP_NeLeDate)
		
		
		
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_SIAO_ID:2=[SIAO:50]Si_RéférenceID:1)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Rang:7; >; *)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Nom:11; >; *)
		ORDER BY:C49([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_Prenom:13; >)
		SELECTION TO ARRAY:C260([SIAO_Personnes:51]Sp_RéférenceID:1; tl_SP_Reference; [SIAO_Personnes:51]Sp_SIAO_ID:2; tl_SP_SIAO_ID; [SIAO_Personnes:51]Sp_Personne_ID:3; tl_SP_Personne_ID; [SIAO_Personnes:51]Sp_Famille:4; ta_SP_Famille; [SIAO_Personnes:51]Sp_Theme:5; ta_SP_Theme; [SIAO_Personnes:51]Sp_SousTheme:6; ta_SP_SousTheme; [SIAO_Personnes:51]Sp_Rang:7; tl_SP_Rang; [SIAO_Personnes:51]Sp_Nom:11; ta_SP_Nom; [SIAO_Personnes:51]Sp_Prenom:13; ta_SP_Prenom; [SIAO_Personnes:51]Sp_Date_de_naissance:14; td_SP_NeLeDate)
		$ii:=Find in array:C230(tl_SP_Reference; vl_SP_Reference)
		If ($ii>0)
		Else 
			$ii:=0
		End if 
		tl_SP_Reference:=$ii
		tl_SP_SIAO_ID:=$ii
		tl_SP_Personne_ID:=$ii
		ta_SP_Famille:=$ii
		ta_SP_Theme:=$ii
		ta_SP_SousTheme:=$ii
		tl_SP_Rang:=$ii
		ta_SP_Nom:=$ii
		ta_SP_Prenom:=$ii
		td_SP_NeLeDate:=$ii
		
		P_SIAO_Var_Affecter($ii)
		
	: ($1=10)
		$0:=False:C215
		READ WRITE:C146([SIAO_Personnes:51])
		QUERY:C277([SIAO_Personnes:51]; [SIAO_Personnes:51]Sp_RéférenceID:1=$2)
		MultiSoc_Filter(->[SIAO_Personnes:51])
		If (Records in selection:C76([SIAO_Personnes:51])=1)
			If (i_NonVerrou(->[SIAO_Personnes:51]))
				
				//Field(Table(->[SIAO_Personnes]);$3)->:=$4->
				
				C_POINTER:C301($P_Field)
				$P_Field:=Field:C253(Table:C252(->[SIAO_Personnes:51]); $3)
				$P_Field->:=$4->
				SAVE RECORD:C53([SIAO_Personnes:51])
				
				$0:=True:C214
			End if 
		End if 
		UNLOAD RECORD:C212([SIAO_Personnes:51])
		READ ONLY:C145([SIAO_Personnes:51])
		
		
		
	: ($1=11)
		$vb_OK:=($2=1)
		OBJECT SET ENTERABLE:C238(va_SIAO_SP_Type; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(vl_SP_Reference; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_SP_SIAO_ID; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_SP_Personne_ID; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_Famille; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_Theme; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_SousTheme; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_SP_Rang; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_SP_EtatCivil; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_Civilite; $vb_OK)
		
		If ($vb_OK)
			OBJECT SET ENABLED:C1123(vL_SP_Genre1; True:C214)
			OBJECT SET ENABLED:C1123(vL_SP_Genre2; True:C214)
		Else 
			OBJECT SET ENABLED:C1123(vL_SP_Genre1; False:C215)
			OBJECT SET ENABLED:C1123(vL_SP_Genre2; False:C215)
		End if 
		
		OBJECT SET ENTERABLE:C238(va_SP_Nom; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_NomJeuneFille; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_Prenom; $vb_OK)
		OBJECT SET ENTERABLE:C238(vd_SP_NeLeDate; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_SP_NeLeAge; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_NeLeAgePlus; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_SP_NeLeLieu; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_NeLePays; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_SP_SituationFamille; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_SituationFamille; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_SP_Parente; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_Parente; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_Nationalite; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_NationalitePlus; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_SP_Papier; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_PapierType; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_SP_EtudeNiveau; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_EtudeLieu; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_CasSpecific; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_SP_Telephone; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(vl_SP_EnfantNombre; $vb_OK)
		OBJECT SET ENTERABLE:C238(vb_SP_EnfantACharge; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_EnfantNote; $vb_OK)
		
		
	: ($1=13)
		$vb_OK:=False:C215
		OBJECT SET ENTERABLE:C238(va_SP_EtatCivil; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_Civilite; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_SP_NeLeLieu; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_NeLePays; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_SP_SituationFamille; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_SituationFamille; $vb_OK)
		OBJECT SET ENTERABLE:C238(vl_SP_Parente; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_Parente; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_Nationalite; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_NationalitePlus; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_SP_Papier; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_PapierType; $vb_OK)
		
		OBJECT SET ENTERABLE:C238(va_SP_EtudeNiveau; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_EtudeLieu; $vb_OK)
		OBJECT SET ENTERABLE:C238(va_SP_CasSpecific; $vb_OK)
		
		
		
End case 