//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_VarMR
//{
//{          Jeudi 3 juin 2004 à 17:53:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//les variables sont déclarées et initialisée dans : 
//                    DebutDécVarTrans
//                    DebutInitVarTrans
C_LONGINT:C283($1)

C_POINTER:C301($P_SubTable)
C_LONGINT:C283($vl_Nb)

Case of 
	: ($1=-1)
		<>vb_Dupliquer:=False:C215
	: ($1=0)
		DebutInitVarTrans
		//[Maraude]MR_RéférenceID : unique
		//[Maraude]MR_Nuit : calculée
		//[Maraude]MR_FicheNuméro : calculée
		//[Maraude]MR_Date : calculée
		//[Maraude]MR_Heure : calculée
		//[Maraude]MR_Modifiéle : calculée
		//[DossierSocial]DS_Opérateur  : calculée : Utilisateur courant
		//[Maraude]MR_HB_ID : affecté
		//[Maraude]MR_EtatCivil : affecté
		//[Maraude]MR_Nom : affecté
		
		//[Maraude]MR_Prénom : affecté 
		//[Maraude]MR_DateNéLe : affecté 
		//[Maraude]MR_Prénom : calculée◊va_Responsable:=[Maraude]MR_Conseiller
		//[Maraude]MR_Genre •???
		
		
	: ($1=1)
		<>vb_Dupliquer:=True:C214
		
		If (True:C214)
			//[Maraude]MR_RéférenceID : unique
			//[Maraude]MR_Nuit : calculée
			//[Maraude]MR_FicheNuméro : calculée
			//[Maraude]MR_Date : calculée
			//[Maraude]MR_Heure : calculée
			//[Maraude]MR_Modifiéle : calculée
			//[DossierSocial]DS_Opérateur  : calculée : Utilisateur courant
			//[Maraude]MR_HB_ID : affecté
			//[Maraude]MR_EtatCivil : affecté
			//[Maraude]MR_Nom : affecté
			
			//[Maraude]MR_Prénom : affecté 
			//[Maraude]MR_DateNéLe : affecté 
			//[Maraude]MR_Prénom : calculée◊va_Responsable:=[Maraude]MR_Conseiller
			//[Maraude]MR_Genre •???
			
			//◊va_Opérateur:=[Maraude]MR_Opérateur
			<>va_Responsable:=[Maraude:24]MR_Conseiller:7
			<>va_Assistante:=[Maraude:24]MR_ChefBord:9
			<>va_EMA:=[Maraude:24]MR_EMA:11
			
			<>va_Signalt:=[Maraude:24]MR_Signalt:12
			<>va_SignaltSuite:=[Maraude:24]MR_SignaltSuite:13
			<>va_Emplace1:=[Maraude:24]MR_Emplacement:14
			<>va_ArrondCP:=[Maraude:24]MR_ArrondCP:15
			
			<>va_EtatCivil:=[Maraude:24]MR_EtatCivil:16
			
			<>va_Demande:=[Maraude:24]MR_Demande:24
			
			<>va_Motif:=[Maraude:24]MR_Motif:25
			<>va_EtatGénéral:=[Maraude:24]MR_EtatGénéral:26
			
			<>va_EtatCutané:=[Maraude:24]MR_EtatCutané:27
			<>va_Relation:=[Maraude:24]MR_Relation:28
			
			<>va_Langue1:=[Maraude:24]MR_Lange1:29
			<>va_Langue2:=[Maraude:24]MR_Lange2:30
			<>va_Langue3:=[Maraude:24]MR_Lange3:31
			
			<>vb_QuestOrMéd:=[Maraude:24]MR_OrMédical:32
			<>va_OrMéd1:=[Maraude:24]MR_OrMéd:33
			<>va_OrMéd2:=[Maraude:24]MR_OrMédSuite:34
			
			<>vb_QuestOrSocial:=[Maraude:24]MR_OrSocial:35
			<>va_OrSocial1:=[Maraude:24]MR_OrSoc:36
			<>va_OrSocial2:=[Maraude:24]MR_OrSocSuite:37
			
			<>vb_FicheSociale:=[Maraude:24]MR_SocialOK:38
			<>vb_FichePsycho:=[Maraude:24]MR_PsychoOK:39
			<>vb_FicheInfirmiere:=[Maraude:24]MR_InfirmiereOK:40
			<>vb_FicheVerrouillée:=[Maraude:24]MR_Verrouillée:41
			
			
			<>va_EMAEnCharge:=[Maraude:24]MR_EnChargeEMA:43
			<>va_EMARefus:=[Maraude:24]MR_RefusEMA:44
			
			<>va_LastHébergt:=[Maraude:24]MR_DernierHéber:45
			<>va_LastHébergt1:=[Maraude:24]MR_DernierHéb1:46
			<>va_LastHébergt2:=[Maraude:24]MR_DernierHéb2:47
			<>va_Mode1:=[Maraude:24]MR_Mode1:48
			<>va_Mode2:=[Maraude:24]MR_Mode2:49
			
			<>va_TempsErr:=[Maraude:24]MR_TempsErrance:50
			<>va_Connaissance:=[Maraude:24]MR_Connaissance:51
			<>va_Compagnie1:=[Maraude:24]MR_Compagnie:52
			<>va_Compagnie2:=[Maraude:24]MR_Compagnie2:53
			
			<>vb_QuestPapier:=[Maraude:24]MR_PapiersQuest:54
			<>va_Papier1:=[Maraude:24]MR_Papier1:55
			<>va_Papier2:=[Maraude:24]MR_Papier2:56
			
			<>vb_QuestCouvSoc:=[Maraude:24]MR_CouvSocQuest:57
			<>va_CouvSoc1_1:=[Maraude:24]MR_CouvSoc1_1:58
			<>va_CouvSoc1_2:=[Maraude:24]MR_CouvSoc1_2:59
			<>va_CouvSoc2_1:=[Maraude:24]MR_CouvSoc2_1:60
			<>va_CouvSoc2_2:=[Maraude:24]MR_CouvSoc2_2:61
			<>va_CouvSoc3_1:=[Maraude:24]MR_CouvSoc3_1:62
			<>va_CouvSoc3_2:=[Maraude:24]MR_CouvSoc3_2:63
			
			
			<>vb_QuestRessource:=[Maraude:24]MR_ResourcQuest:64
			<>va_Ressource1_1:=[Maraude:24]MR_Ressour1_1:65
			<>va_Ressource1_2:=[Maraude:24]MR_Ressour1_2:66
			<>va_Ressource2_1:=[Maraude:24]MR_Ressour2_1:67
			<>va_Ressource2_2:=[Maraude:24]MR_Ressour2_2:68
			<>va_Ressource3_1:=[Maraude:24]MR_Ressour3_1:69
			<>va_Ressource3_2:=[Maraude:24]MR_Ressour3_2:70
			
			<>vb_QuestRégime:=[Maraude:24]MR_RégimeQuest:71
			<>va_Régime1:=[Maraude:24]MR_Régime1:72
			<>va_Régime2:=[Maraude:24]MR_Régime2:73
			<>va_Régime3:=[Maraude:24]MR_Régime3:74
			
			<>vb_QuestSuiviS:=[Maraude:24]MR_SuiviSQuest:75
			<>va_SuiviS1:=[Maraude:24]MR_SuiviS1:76
			<>va_SuiviS2:=[Maraude:24]MR_SuiviS2:77
			
			<>va_Emplace2:=[Maraude:24]MR_Emplacement2:78
			
			
			<>vb_QuestDemHB:=[Maraude:24]MR_DemHB:80
			<>va_Hygiène:=[Maraude:24]MR_Hygiène:81
			<>va_Handicap:=[Maraude:24]MR_Handicap:82
			<>va_MotifDétail:=[Maraude:24]MR_MotifDétail:83
		End if 
		
		//ici sous fiches référents
		
		// BS MIGRATION v15
		
		// _o_ALL SUBRECORDS([Maraude]MR_RéférentList)
		// $vl_Nb:=_o_Records in subselection([Maraude]MR_RéférentList)
		//_o_FIRST SUBRECORD([Maraude]MR_RéférentList)
		
		
		RELATE MANY:C262([Maraude:24]ID:91)
		
		$P_SubTable:=->[Maraude_MR_ReferentList:60]
		$vl_Nb:=Records in selection:C76($P_SubTable->)
		
		ARRAY LONGINT:C221($rL_Subtable_selection; 0)
		LONGINT ARRAY FROM SELECTION:C647($P_SubTable->; $rL_Subtable_selection)
		
		ARRAY TEXT:C222(<>ta_RéfCatégorie; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfNom; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfAdr1; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfAdr2; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfCP; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfVille; $vl_Nb)
		ARRAY TEXT:C222(<>ta_RéfTél; $vl_Nb)
		
		C_LONGINT:C283($ii)
		For ($ii; 1; $vl_Nb)
			
			If (False:C215)
				//<>ta_RéfCatégorie{$ii}:=[Maraude]MR_RéférentList'Catégorie
				//<>ta_RéfNom{$ii}:=[Maraude]MR_RéférentList'Nom
				//<>ta_RéfAdr1{$ii}:=[Maraude]MR_RéférentList'Adresse1
				//<>ta_RéfAdr2{$ii}:=[Maraude]MR_RéférentList'Adresse2
				//<>ta_RéfCP{$ii}:=[Maraude]MR_RéférentList'CodePostal
				//<>ta_RéfVille{$ii}:=[Maraude]MR_RéférentList'Ville
				//<>ta_RéfTél{$ii}:=[Maraude]MR_RéférentList'Téléphone
				//_o_NEXT SUBRECORD([Maraude]MR_RéférentList)
			End if 
			
			GOTO RECORD:C242($P_SubTable->; $rL_Subtable_selection{$i})
			
			<>ta_RéfCatégorie{$ii}:=[Maraude_MR_ReferentList:60]Catégorie:1
			<>ta_RéfNom{$ii}:=[Maraude_MR_ReferentList:60]Nom:2
			<>ta_RéfAdr1{$ii}:=[Maraude_MR_ReferentList:60]Adresse1:3
			<>ta_RéfAdr2{$ii}:=[Maraude_MR_ReferentList:60]Adresse2:4
			<>ta_RéfCP{$ii}:=[Maraude_MR_ReferentList:60]CodePostal:5
			<>ta_RéfVille{$ii}:=[Maraude_MR_ReferentList:60]Ville:6
			<>ta_RéfTél{$ii}:=[Maraude_MR_ReferentList:60]Téléphone:7
		End for 
		UNLOAD RECORD:C212($P_SubTable->)  // sécurité car je ne sais pas si je suis en lecture écriture
		
		// _o_ALL SUBRECORDS([Maraude]MR_SuiviMédicalList)
		//$vl_Nb:=_o_Records in subselection([Maraude]MR_SuiviMédicalList)
		// _o_FIRST SUBRECORD([Maraude]MR_SuiviMédicalList)
		
		$P_SubTable:=->[Maraude_MR_SuiviMedicalList:61]
		$vl_Nb:=Records in selection:C76($P_SubTable->)
		
		ARRAY LONGINT:C221($rL_Subtable_selection; 0)
		LONGINT ARRAY FROM SELECTION:C647($P_SubTable->; $rL_Subtable_selection)
		
		ARRAY TEXT:C222(<>ta_SMCatégorie; $vl_Nb)
		ARRAY TEXT:C222(<>ta_SMCom; $vl_Nb)
		
		For ($ii; 1; $vl_Nb)
			
			GOTO RECORD:C242($P_SubTable->; $rL_Subtable_selection{$i})
			
			<>ta_SMCatégorie{$ii}:=[Maraude_MR_SuiviMedicalList:61]Catégorie:1
			<>ta_SMCom{$ii}:=[Maraude_MR_SuiviMedicalList:61]Commentaire:2
		End for 
		UNLOAD RECORD:C212($P_SubTable->)  // sécurité car je ne sais pas si je suis en lecture écriture
		
		// _o_ALL SUBRECORDS([Maraude]MR_PathologieListe)
		// $vl_Nb:=_o_Records in subselection([Maraude]MR_PathologieListe)
		// _o_FIRST SUBRECORD([Maraude]MR_PathologieListe)
		//_o_NEXT SUBRECORD([Maraude]MR_PathologieListe)
		
		$P_SubTable:=->[Maraude_MR_PathologieListe:62]
		$vl_Nb:=Records in selection:C76($P_SubTable->)
		
		ARRAY LONGINT:C221($rL_Subtable_selection; 0)
		LONGINT ARRAY FROM SELECTION:C647($P_SubTable->; $rL_Subtable_selection)
		
		ARRAY TEXT:C222(<>ta_PTCatégorie; $vl_Nb)
		ARRAY TEXT:C222(<>ta_PTCom; $vl_Nb)
		
		For ($ii; 1; $vl_Nb)
			
			GOTO RECORD:C242($P_SubTable->; $rL_Subtable_selection{$i})
			
			<>ta_PTCatégorie{$ii}:=[Maraude_MR_PathologieListe:62]Catégorie:1
			<>ta_PTCom{$ii}:=[Maraude_MR_PathologieListe:62]Commentaire:2
		End for 
		UNLOAD RECORD:C212($P_SubTable->)  // sécurité car je ne sais pas si je suis en lecture écriture
		
		
	: ($1=2) & (<>vb_Dupliquer)
		
		<>vb_Dupliquer:=False:C215
		// [Maraude]MR_Opérateur:=◊va_Opérateur`
		
		If (True:C214)
			[Maraude:24]MR_Conseiller:7:=<>va_Responsable
			[Maraude:24]MR_ChefBord:9:=<>va_Assistante
			[Maraude:24]MR_EMA:11:=<>va_EMA
			
			[Maraude:24]MR_Signalt:12:=<>va_Signalt
			[Maraude:24]MR_SignaltSuite:13:=<>va_SignaltSuite
			[Maraude:24]MR_Emplacement:14:=<>va_Emplace1
			[Maraude:24]MR_ArrondCP:15:=<>va_ArrondCP
			
			[Maraude:24]MR_EtatCivil:16:=<>va_EtatCivil
			
			[Maraude:24]MR_Demande:24:=<>va_Demande
			
			[Maraude:24]MR_Motif:25:=<>va_Motif
			[Maraude:24]MR_EtatGénéral:26:=<>va_EtatGénéral
			
			[Maraude:24]MR_EtatCutané:27:=<>va_EtatCutané
			[Maraude:24]MR_Relation:28:=<>va_Relation
			
			[Maraude:24]MR_Lange1:29:=<>va_Langue1
			[Maraude:24]MR_Lange2:30:=<>va_Langue2
			[Maraude:24]MR_Lange3:31:=<>va_Langue3
			
			[Maraude:24]MR_OrMédical:32:=<>vb_QuestOrMéd
			[Maraude:24]MR_OrMéd:33:=<>va_OrMéd1
			[Maraude:24]MR_OrMédSuite:34:=<>va_OrMéd2
			
			[Maraude:24]MR_OrSocial:35:=<>vb_QuestOrSocial
			[Maraude:24]MR_OrSoc:36:=<>va_OrSocial1
			[Maraude:24]MR_OrSocSuite:37:=<>va_OrSocial2
			
			[Maraude:24]MR_SocialOK:38:=<>vb_FicheSociale
			[Maraude:24]MR_PsychoOK:39:=<>vb_FichePsycho
			[Maraude:24]MR_InfirmiereOK:40:=<>vb_FicheInfirmiere
			[Maraude:24]MR_Verrouillée:41:=<>vb_FicheVerrouillée
			
			
			[Maraude:24]MR_EnChargeEMA:43:=<>va_EMAEnCharge
			[Maraude:24]MR_RefusEMA:44:=<>va_EMARefus
			
			[Maraude:24]MR_DernierHéber:45:=<>va_LastHébergt
			[Maraude:24]MR_DernierHéb1:46:=<>va_LastHébergt1
			[Maraude:24]MR_DernierHéb2:47:=<>va_LastHébergt2
			[Maraude:24]MR_Mode1:48:=<>va_Mode1
			[Maraude:24]MR_Mode2:49:=<>va_Mode2
			
			[Maraude:24]MR_TempsErrance:50:=<>va_TempsErr
			[Maraude:24]MR_Connaissance:51:=<>va_Connaissance
			[Maraude:24]MR_Compagnie:52:=<>va_Compagnie1
			[Maraude:24]MR_Compagnie2:53:=<>va_Compagnie2
			
			[Maraude:24]MR_PapiersQuest:54:=<>vb_QuestPapier
			[Maraude:24]MR_Papier1:55:=<>va_Papier1
			[Maraude:24]MR_Papier2:56:=<>va_Papier2
			
			[Maraude:24]MR_CouvSocQuest:57:=<>vb_QuestCouvSoc
			[Maraude:24]MR_CouvSoc1_1:58:=<>va_CouvSoc1_1
			[Maraude:24]MR_CouvSoc1_2:59:=<>va_CouvSoc1_2
			[Maraude:24]MR_CouvSoc2_1:60:=<>va_CouvSoc2_1
			[Maraude:24]MR_CouvSoc2_2:61:=<>va_CouvSoc2_2
			[Maraude:24]MR_CouvSoc3_1:62:=<>va_CouvSoc3_1
			[Maraude:24]MR_CouvSoc3_2:63:=<>va_CouvSoc3_2
			
			
			[Maraude:24]MR_ResourcQuest:64:=<>vb_QuestRessource
			[Maraude:24]MR_Ressour1_1:65:=<>va_Ressource1_1
			[Maraude:24]MR_Ressour1_2:66:=<>va_Ressource1_2
			[Maraude:24]MR_Ressour2_1:67:=<>va_Ressource2_1
			[Maraude:24]MR_Ressour2_2:68:=<>va_Ressource2_2
			[Maraude:24]MR_Ressour3_1:69:=<>va_Ressource3_1
			[Maraude:24]MR_Ressour3_2:70:=<>va_Ressource3_2
			
			[Maraude:24]MR_RégimeQuest:71:=<>vb_QuestRégime
			[Maraude:24]MR_Régime1:72:=<>va_Régime1
			[Maraude:24]MR_Régime2:73:=<>va_Régime2
			[Maraude:24]MR_Régime3:74:=<>va_Régime3
			
			[Maraude:24]MR_SuiviSQuest:75:=<>vb_QuestSuiviS
			[Maraude:24]MR_SuiviS1:76:=<>va_SuiviS1
			[Maraude:24]MR_SuiviS2:77:=<>va_SuiviS2
			
			[Maraude:24]MR_Emplacement2:78:=<>va_Emplace2
			
			
			[Maraude:24]MR_DemHB:80:=<>vb_QuestDemHB
			[Maraude:24]MR_Hygiène:81:=<>va_Hygiène
			[Maraude:24]MR_Handicap:82:=<>va_Handicap
			[Maraude:24]MR_MotifDétail:83:=<>va_MotifDétail
		End if 
		
		// Migration
		
		$P_SubTable:=->[Maraude_MR_ReferentList:60]
		
		//ici sous fiches référents
		$vl_Nb:=Size of array:C274(<>ta_RéfCatégorie)
		For ($ii; 1; $vl_Nb)
			
			// _o_CREATE SUBRECORD([Maraude]MR_RéférentList)
			
			CREATE RECORD:C68($P_SubTable->)
			[Maraude_MR_ReferentList:60]Ref_Maraude:10:=[Maraude:24]ID:91  // nouveau migration
			[Maraude_MR_ReferentList:60]Catégorie:1:=<>ta_RéfCatégorie{$ii}
			[Maraude_MR_ReferentList:60]Nom:2:=<>ta_RéfNom{$ii}
			[Maraude_MR_ReferentList:60]Adresse1:3:=<>ta_RéfAdr1{$ii}
			[Maraude_MR_ReferentList:60]Adresse2:4:=<>ta_RéfAdr2{$ii}
			[Maraude_MR_ReferentList:60]CodePostal:5:=<>ta_RéfCP{$ii}
			[Maraude_MR_ReferentList:60]Ville:6:=<>ta_RéfVille{$ii}
			[Maraude_MR_ReferentList:60]Téléphone:7:=<>ta_RéfTél{$ii}
			SAVE RECORD:C53($P_SubTable->)
		End for 
		UNLOAD RECORD:C212($P_SubTable->)
		
		
		$P_SubTable:=->[Maraude_MR_SuiviMedicalList:61]
		
		//ici sous fiches suivi médical
		$vl_Nb:=Size of array:C274(<>ta_SMCatégorie)
		For ($ii; 1; $vl_Nb)
			// _o_CREATE SUBRECORD([Maraude]MR_SuiviMédicalList)
			
			CREATE RECORD:C68($P_SubTable->)
			[Maraude_MR_SuiviMedicalList:61]Ref_Maraude:5:=[Maraude:24]ID:91  // nouveau migration
			[Maraude_MR_SuiviMedicalList:61]Catégorie:1:=<>ta_SMCatégorie{$ii}
			[Maraude_MR_SuiviMedicalList:61]Commentaire:2:=<>ta_SMCom{$ii}
			SAVE RECORD:C53($P_SubTable->)
		End for 
		UNLOAD RECORD:C212($P_SubTable->)
		
		
		$P_SubTable:=->[Maraude_MR_PathologieListe:62]
		
		//ici sous fiches pathologie
		$vl_Nb:=Size of array:C274(<>ta_PTCatégorie)
		For ($ii; 1; $vl_Nb)
			// _o_CREATE SUBRECORD([Maraude]MR_PathologieListe)
			
			CREATE RECORD:C68($P_SubTable->)
			[Maraude_MR_PathologieListe:62]Ref_Maraude:5:=[Maraude:24]ID:91  // nouveau migration
			[Maraude_MR_PathologieListe:62]Catégorie:1:=<>ta_PTCatégorie{$ii}
			[Maraude_MR_PathologieListe:62]Commentaire:2:=<>ta_PTCom{$ii}
			SAVE RECORD:C53($P_SubTable->)
		End for 
		UNLOAD RECORD:C212($P_SubTable->)
		
		
End case 