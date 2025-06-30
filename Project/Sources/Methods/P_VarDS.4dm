//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_VarDS  
//{
//{          Jeudi 3 juin 2004 à 12:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//les variables sont déclarées et initialisée dans : 
//                    DebutDécVarTrans
//                    DebutInitVarTrans
C_LONGINT:C283($1)

Case of 
	: ($1=-1)
		<>vb_Dupliquer:=False:C215
	: ($1=0)
		DebutInitVarTrans
		//[DossierSocial]DS_Référence : unique
		//[DossierSocial]DS_FicheNuméro : calculée
		//[DossierSocial]DS_Date : calculée
		//[DossierSocial]DS_Heure : calculée
		//[DossierSocial]DS_Modifiéle : calculée
		//[DossierSocial]DS_Opérateur  : calculée : Utilisateur courant
		
		//[DossierSocial]DS_HB_ID : affecté
		//[DossierSocial]DS_EtatCivil : affecté
		//[DossierSocial]DS_Nom : affecté
		
		//[DossierSocial]DS_Prénom : affecté 
		//[DossierSocial]DS_DateNéLe : affecté 
		//[DossierSocial]DS_Age : calculée
		
	: ($1=1)
		<>vb_Dupliquer:=True:C214
		//[DossierSocial]DS_Référence : unique
		<>vd_VueLe:=[DossierSocial:25]DS_VuLe:2
		//[DossierSocial]DS_FicheNuméro : calculée
		//[DossierSocial]DS_Date : calculée
		//[DossierSocial]DS_Heure : calculée
		//[DossierSocial]DS_Modifiéle : calculée
		<>va_Responsable:=[DossierSocial:25]DS_Responsable:7
		//[DossierSocial]DS_Opérateur  : calculée : Utilisateur courant
		<>va_Assistante:=[DossierSocial:25]DS_Assistante:9
		//[DossierSocial]DS_HB_ID : affecté
		//[DossierSocial]DS_EtatCivil : affecté
		//[DossierSocial]DS_Nom : affecté
		<>vb_Enfants:=[DossierSocial:25]DS_Enfants:13
		<>ve_EnfantsNb:=[DossierSocial:25]DS_EnfantsNb:14
		//ici sous fiches enfants
		_O_ALL SUBRECORDS:C109([DossierSocial:25]DS_EnfantsNom:15)
		$vl_Nb:=_O_Records in subselection:C7([DossierSocial:25]DS_EnfantsNom:15)
		ARRAY TEXT:C222(<>ta_EnfantNom; $vl_Nb)
		ARRAY TEXT:C222(<>ta_EnfantPrénom; $vl_Nb)
		ARRAY DATE:C224(<>td_EnfantNeLe; $vl_Nb)
		ARRAY INTEGER:C220(<>te_EnfantAge; $vl_Nb)
		ARRAY BOOLEAN:C223(<>tb_EnfantGenre; $vl_Nb)
		ARRAY TEXT:C222(<>ta_EnfantLieu; $vl_Nb)
		ARRAY TEXT:C222(<>ta_EnfantAdr1; $vl_Nb)
		ARRAY TEXT:C222(<>ta_EnfantAdr2; $vl_Nb)
		ARRAY TEXT:C222(<>ta_EnfantCP; $vl_Nb)
		ARRAY TEXT:C222(<>ta_EnfantVille; $vl_Nb)
		If ($vl_Nb>0)
			_O_FIRST SUBRECORD:C61([DossierSocial:25]DS_EnfantsNom:15)
			For ($ii; 1; $vl_Nb)
				<>ta_EnfantNom{$ii}:=[DossierSocial]DS_EnfantsNom'Nom
				<>ta_EnfantPrénom{$ii}:=[DossierSocial]DS_EnfantsNom'Prénom
				<>td_EnfantNeLe{$ii}:=[DossierSocial]DS_EnfantsNom'Néle
				<>te_EnfantAge{$ii}:=[DossierSocial]DS_EnfantsNom'Age
				<>tb_EnfantGenre{$ii}:=[DossierSocial]DS_EnfantsNom'Genre
				<>ta_EnfantLieu{$ii}:=[DossierSocial]DS_EnfantsNom'Lieu de vie
				<>ta_EnfantAdr1{$ii}:=[DossierSocial]DS_EnfantsNom'Adresse1
				<>ta_EnfantAdr2{$ii}:=[DossierSocial]DS_EnfantsNom'Adresse2
				<>ta_EnfantCP{$ii}:=[DossierSocial]DS_EnfantsNom'CodePostal
				<>ta_EnfantVille{$ii}:=[DossierSocial]DS_EnfantsNom'Ville
				_O_NEXT SUBRECORD:C62([DossierSocial:25]DS_EnfantsNom:15)
			End for 
		End if 
		
		//[DossierSocial]DS_Prénom : affecté 
		//[DossierSocial]DS_DateNéLe : affecté 
		//[DossierSocial]DS_Age : calculée
		<>vb_Genre:=[DossierSocial:25]DS_Genre:20
		<>va_NeOu:=[DossierSocial:25]DS_LieuNéOù:19
		<>va_Conjoint:=[DossierSocial:25]DS_Conjoint:21
		<>va_Nationalité:=[DossierSocial:25]DS_Nationalité:22
		<>va_Langue:=[DossierSocial:25]DS_Langue:23
		<>va_PersMajeur:=[DossierSocial:25]DS_PersonMajeur:24
		<>va_EMAEnCharge:=[DossierSocial:25]DS_EnChargeEMA:25
		<>va_EMARefus:=[DossierSocial:25]DS_RefusEMA:26
		<>va_LastHébergt:=[DossierSocial:25]DS_DernierHéber:27
		<>va_LastHébergt1:=[DossierSocial:25]DS_DernierHéb1:28
		<>va_EtatMatrimo:=[DossierSocial:25]DS_EtatMatrimon:29
		<>va_HébergAd1:=[DossierSocial:25]DS_HébergAd1:30
		<>va_HébergAd2:=[DossierSocial:25]DS_HébergAd2:31
		<>va_HébergAd3:=[DossierSocial:25]DS_HébergAd3:32
		<>va_Mode1:=[DossierSocial:25]DS_Mode1:33
		<>va_Mode2:=[DossierSocial:25]DS_Mode2:34
		<>va_TempsErr:=[DossierSocial:25]DS_TempsErrance:35
		<>va_Connaissance:=[DossierSocial:25]DS_Connaissance:36
		<>va_Compagnie1:=[DossierSocial:25]DS_Compagnie:37
		<>va_Compagnie2:=[DossierSocial:25]DS_Compagnie2:38
		<>va_SSPConnu:=[DossierSocial:25]DS_ConnuSSP:39
		<>va_SSPPremière:=[DossierSocial:25]DS_PremièreSSP:40
		<>va_DerAdr1:=[DossierSocial:25]DS_DernierAd1:41
		<>va_DerAdr2:=[DossierSocial:25]DS_DernierAd2:42
		<>va_DerAdr3:=[DossierSocial:25]DS_DernierAd3:43
		<>va_SecoursAdr1:=[DossierSocial:25]DS_SecoursAd1:44
		<>va_SecoursAdr2:=[DossierSocial:25]DS_SecoursAd2:45
		<>va_SecoursAdr3:=[DossierSocial:25]DS_SecoursAd3:46
		
		<>vb_QuestPapier:=[DossierSocial:25]DS_PapiersQuest:47
		<>va_Papier1:=[DossierSocial:25]DS_Papier1:48
		<>va_Papier2:=[DossierSocial:25]DS_Papier2:49
		
		<>vb_QuestCouvSoc:=[DossierSocial:25]DS_CouvSocQuest:50
		<>va_CouvSoc1_1:=[DossierSocial:25]DS_CouvSoc1_1:51
		<>va_CouvSoc1_2:=[DossierSocial:25]DS_CouvSoc1_2:52
		<>va_CouvSoc2_1:=[DossierSocial:25]DS_CouvSoc2_1:53
		<>va_CouvSoc2_2:=[DossierSocial:25]DS_CouvSoc2_2:54
		<>va_CouvSoc3_1:=[DossierSocial:25]DS_CouvSoc3_1:55
		<>va_CouvSoc3_2:=[DossierSocial:25]DS_CouvSoc3_2:56
		
		<>vb_QuestRessource:=[DossierSocial:25]DS_ResourcQuest:57
		<>va_Ressource1_1:=[DossierSocial:25]DS_Ressour1_1:58
		<>va_Ressource1_2:=[DossierSocial:25]DS_Ressour1_2:59
		<>va_Ressource2_1:=[DossierSocial:25]DS_Ressour2_1:60
		<>va_Ressource2_2:=[DossierSocial:25]DS_Ressour2_2:61
		<>va_Ressource3_1:=[DossierSocial:25]DS_Ressour3_1:62
		<>va_Ressource3_2:=[DossierSocial:25]DS_Ressour3_2:63
		
		<>vb_Référents:=[DossierSocial:25]EL_Référents:64
		
		//ici sous fiches référents
		
		
		_O_ALL SUBRECORDS:C109([DossierSocial:25]EL_RéférentList:65)
		$vl_Nb:=_O_Records in subselection:C7([DossierSocial:25]EL_RéférentList:65)
		ARRAY TEXT:C222(<>ta_RéfCatégorie; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfNom; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfAdr1; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfAdr2; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfCP; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfVille; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfTél; $vl_Nb)
		If ($vl_Nb>0)
			_O_FIRST SUBRECORD:C61([DossierSocial:25]EL_RéférentList:65)
			For ($ii; 1; $vl_Nb)
				<>ta_RéfCatégorie{$ii}:=[DossierSocial]EL_RéférentList'Catégorie
				<>ta_RéfNom{$ii}:=[DossierSocial]EL_RéférentList'Nom
				<>ta_RéfAdr1{$ii}:=[DossierSocial]EL_RéférentList'Adresse1
				<>ta_RéfAdr2{$ii}:=[DossierSocial]EL_RéférentList'Adresse2
				<>ta_RéfCP{$ii}:=[DossierSocial]EL_RéférentList'CodePostal
				<>ta_RéfVille{$ii}:=[DossierSocial]EL_RéférentList'Ville
				<>ta_RéfTél{$ii}:=[DossierSocial]EL_RéférentList'Téléphone
				_O_NEXT SUBRECORD:C62([DossierSocial:25]EL_RéférentList:65)
			End for 
		End if 
		
		<>vb_QuestRégime:=[DossierSocial:25]DS_RégimeQuest:66
		<>va_Régime1:=[DossierSocial:25]DS_Régime1:67
		<>va_Régime2:=[DossierSocial:25]DS_Régime2:68
		
		<>vb_QuestSuiviS:=[DossierSocial:25]DS_SuiviSQuest:69
		<>va_SuiviS1:=[DossierSocial:25]DS_SuiviS1:70
		<>va_SuiviS2:=[DossierSocial:25]DS_SuiviS2:71
		
		<>vb_QuestSortie:=[DossierSocial:25]DS_Sortie:72
		<>va_SortieCtr1:=[DossierSocial:25]DS_SortieCtr1:73
		<>va_SortieCtr2:=[DossierSocial:25]DS_SortieCtr2:74
		
		<>vb_Vérrouillé:=[DossierSocial:25]DS_Verrouillée:75
		<>vb_EnfantsScolarisés:=[DossierSocial:25]DS_EnfantsScolarisés:76
		
		
	: ($1=2) & (<>vb_Dupliquer)
		<>vb_Dupliquer:=False:C215
		//[DossierSocial]DS_Référence : unique
		[DossierSocial:25]DS_VuLe:2:=<>vd_VueLe
		//[DossierSocial]DS_FicheNuméro : calculée
		//[DossierSocial]DS_Date : calculée
		//[DossierSocial]DS_Heure : calculée
		//[DossierSocial]DS_Modifiéle : calculée
		[DossierSocial:25]DS_Responsable:7:=<>va_Responsable
		//[DossierSocial]DS_Opérateur  : calculée : Utilisateur courant
		// DossierSocial]DS_Assistante:=<>va_Assistante      // #20180530-2
		//[DossierSocial]DS_HB_ID : affecté
		//[DossierSocial]DS_EtatCivil : affecté
		//[DossierSocial]DS_Nom : affecté
		
		[DossierSocial:25]DS_Enfants:13:=<>vb_Enfants
		[DossierSocial:25]DS_EnfantsNb:14:=<>ve_EnfantsNb
		//ici sous fiches enfants
		$vl_Nb:=Size of array:C274(<>ta_EnfantNom)
		If ($vl_Nb>0)
			For ($ii; 1; $vl_Nb)
				_O_CREATE SUBRECORD:C72([DossierSocial:25]DS_EnfantsNom:15)
				[DossierSocial]DS_EnfantsNom'Nom:=<>ta_EnfantNom{$ii}
				[DossierSocial]DS_EnfantsNom'Prénom:=<>ta_EnfantPrénom{$ii}
				[DossierSocial]DS_EnfantsNom'Néle:=<>td_EnfantNeLe{$ii}
				[DossierSocial]DS_EnfantsNom'Age:=<>te_EnfantAge{$ii}
				[DossierSocial]DS_EnfantsNom'Genre:=<>tb_EnfantGenre{$ii}
				[DossierSocial]DS_EnfantsNom'Lieu de vie:=<>ta_EnfantLieu{$ii}
				[DossierSocial]DS_EnfantsNom'Adresse1:=<>ta_EnfantAdr1{$ii}
				[DossierSocial]DS_EnfantsNom'Adresse2:=<>ta_EnfantAdr2{$ii}
				[DossierSocial]DS_EnfantsNom'CodePostal:=<>ta_EnfantCP{$ii}
				[DossierSocial]DS_EnfantsNom'Ville:=<>ta_EnfantVille{$ii}
			End for 
		End if 
		
		//[DossierSocial]DS_Prénom : affecté 
		//[DossierSocial]DS_DateNéLe : affecté 
		//[DossierSocial]DS_Age : calculée
		[DossierSocial:25]DS_Genre:20:=<>vb_Genre
		[DossierSocial:25]DS_LieuNéOù:19:=<>va_NeOu
		[DossierSocial:25]DS_Conjoint:21:=<>va_Conjoint
		[DossierSocial:25]DS_Nationalité:22:=<>va_Nationalité
		[DossierSocial:25]DS_Langue:23:=<>va_Langue
		[DossierSocial:25]DS_PersonMajeur:24:=<>va_PersMajeur
		[DossierSocial:25]DS_EnChargeEMA:25:=<>va_EMAEnCharge
		[DossierSocial:25]DS_RefusEMA:26:=<>va_EMARefus
		[DossierSocial:25]DS_DernierHéber:27:=<>va_LastHébergt
		[DossierSocial:25]DS_DernierHéb1:28:=<>va_LastHébergt1
		[DossierSocial:25]DS_EtatMatrimon:29:=<>va_EtatMatrimo
		[DossierSocial:25]DS_HébergAd1:30:=<>va_HébergAd1
		[DossierSocial:25]DS_HébergAd2:31:=<>va_HébergAd2
		[DossierSocial:25]DS_HébergAd3:32:=<>va_HébergAd3
		[DossierSocial:25]DS_Mode1:33:=<>va_Mode1
		[DossierSocial:25]DS_Mode2:34:=<>va_Mode2
		[DossierSocial:25]DS_TempsErrance:35:=<>va_TempsErr
		[DossierSocial:25]DS_Connaissance:36:=<>va_Connaissance
		[DossierSocial:25]DS_Compagnie:37:=<>va_Compagnie1
		[DossierSocial:25]DS_Compagnie2:38:=<>va_Compagnie2
		[DossierSocial:25]DS_ConnuSSP:39:=<>va_SSPConnu
		[DossierSocial:25]DS_PremièreSSP:40:=<>va_SSPPremière
		[DossierSocial:25]DS_DernierAd1:41:=<>va_DerAdr1
		[DossierSocial:25]DS_DernierAd2:42:=<>va_DerAdr2
		[DossierSocial:25]DS_DernierAd3:43:=<>va_DerAdr3
		[DossierSocial:25]DS_SecoursAd1:44:=<>va_SecoursAdr1
		[DossierSocial:25]DS_SecoursAd2:45:=<>va_SecoursAdr2
		[DossierSocial:25]DS_SecoursAd3:46:=<>va_SecoursAdr3
		
		[DossierSocial:25]DS_PapiersQuest:47:=<>vb_QuestPapier
		[DossierSocial:25]DS_Papier1:48:=<>va_Papier1
		[DossierSocial:25]DS_Papier2:49:=<>va_Papier2
		
		[DossierSocial:25]DS_CouvSocQuest:50:=<>vb_QuestCouvSoc
		[DossierSocial:25]DS_CouvSoc1_1:51:=<>va_CouvSoc1_1
		[DossierSocial:25]DS_CouvSoc1_2:52:=<>va_CouvSoc1_2
		[DossierSocial:25]DS_CouvSoc2_1:53:=<>va_CouvSoc2_1
		[DossierSocial:25]DS_CouvSoc2_2:54:=<>va_CouvSoc2_2
		[DossierSocial:25]DS_CouvSoc3_1:55:=<>va_CouvSoc3_1
		[DossierSocial:25]DS_CouvSoc3_2:56:=<>va_CouvSoc3_2
		
		[DossierSocial:25]DS_ResourcQuest:57:=<>vb_QuestRessource
		[DossierSocial:25]DS_Ressour1_1:58:=<>va_Ressource1_1
		[DossierSocial:25]DS_Ressour1_2:59:=<>va_Ressource1_2
		[DossierSocial:25]DS_Ressour2_1:60:=<>va_Ressource2_1
		[DossierSocial:25]DS_Ressour2_2:61:=<>va_Ressource2_2
		[DossierSocial:25]DS_Ressour3_1:62:=<>va_Ressource3_1
		[DossierSocial:25]DS_Ressour3_2:63:=<>va_Ressource3_2
		
		[DossierSocial:25]EL_Référents:64:=<>vb_Référents
		
		//ici sous fiches référents
		$vl_Nb:=Size of array:C274(<>ta_RéfCatégorie)
		If ($vl_Nb>0)
			For ($ii; 1; $vl_Nb)
				_O_CREATE SUBRECORD:C72([DossierSocial:25]EL_RéférentList:65)
				[DossierSocial]EL_RéférentList'Catégorie:=<>ta_RéfCatégorie{$ii}
				[DossierSocial]EL_RéférentList'Nom:=<>ta_RéfNom{$ii}
				[DossierSocial]EL_RéférentList'Adresse1:=<>ta_RéfAdr1{$ii}
				[DossierSocial]EL_RéférentList'Adresse2:=<>ta_RéfAdr2{$ii}
				[DossierSocial]EL_RéférentList'CodePostal:=<>ta_RéfCP{$ii}
				[DossierSocial]EL_RéférentList'Ville:=<>ta_RéfVille{$ii}
				[DossierSocial]EL_RéférentList'Téléphone:=<>ta_RéfTél{$ii}
			End for 
		End if 
		
		
		[DossierSocial:25]DS_RégimeQuest:66:=<>vb_QuestRégime
		[DossierSocial:25]DS_Régime1:67:=<>va_Régime1
		[DossierSocial:25]DS_Régime2:68:=<>va_Régime2
		
		[DossierSocial:25]DS_SuiviSQuest:69:=<>vb_QuestSuiviS
		[DossierSocial:25]DS_SuiviS1:70:=<>va_SuiviS1
		[DossierSocial:25]DS_SuiviS2:71:=<>va_SuiviS2
		
		[DossierSocial:25]DS_Sortie:72:=<>vb_QuestSortie
		[DossierSocial:25]DS_SortieCtr1:73:=<>va_SortieCtr1
		[DossierSocial:25]DS_SortieCtr2:74:=<>va_SortieCtr2
		
		[DossierSocial:25]DS_Verrouillée:75:=<>vb_Vérrouillé
		[DossierSocial:25]DS_EnfantsScolarisés:76:=<>vb_EnfantsScolarisés
End case 