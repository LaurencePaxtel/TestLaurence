//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ExportHG_Liste
//{
//{          Lundi 27 juillet 2009 à 15:16:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($1)

C_TEXT:C284($vt_Dossier; vt_TitreDocument; $vt_Texte)
C_TIME:C306($h_RefDoc; $vh)
C_DATE:C307($vd)


F_Report_FullDuplexTableau
$vt_Dossier:=Select folder:C670
If (OK=1)
	i_Message("     Export en cours…")
	vt_FullDuplexDossier:=$vt_Dossier
	SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
	$vd:=Current date:C33
	$vh:=Current time:C178
	vt_TitreDocument:="Hebergements"+String:C10(Year of:C25($vd); "0000")+String:C10(Month of:C24($vd); "00")+String:C10(Day of:C23($vd); "00")
	vt_TitreDocument:=vt_TitreDocument+String:C10(($vh\3600); "00")+String:C10((($vh\60)%60); "00")+String:C10(($vh%60); "00")
	
	$vt_Texte:="Date"+<>va_TAB
	$vt_Texte:=$vt_Texte+"Heure"+<>va_TAB
	$vt_Texte:=$vt_Texte+"N° de fiche"+<>va_TAB
	$vt_Texte:=$vt_Texte+"J/NP"+<>va_TAB
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 100)+<>va_TAB  //[HéberGement]HG_Plateforme
	$vt_Texte:=$vt_Texte+"DDASS"+<>va_TAB  //[HéberGement]HG_Trans_DDASS
	
	$vt_Texte:=$vt_Texte+"Nom"+<>va_TAB
	$vt_Texte:=$vt_Texte+"Prénom"+<>va_TAB
	$vt_Texte:=$vt_Texte+"Date de naissance"+<>va_TAB
	$vt_Texte:=$vt_Texte+"Age"+<>va_TAB
	$vt_Texte:=$vt_Texte+"Genre"+<>va_TAB
	$vt_Texte:=$vt_Texte+"Clé"+<>va_TAB
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 40)+<>va_TAB  //[HéberGement]HG_EtatCivil
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 5)+<>va_TAB  //[HéberGement]HG_Signalement
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 6)+<>va_TAB  //[HéberGement]HG_SignalCentre
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 7)+<>va_TAB  //[HéberGement]HG_CodePostal
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 8)+<>va_TAB  //[HéberGement]HG_Gare
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 9)+<>va_TAB  //[HéberGement]HG_Métro
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 10)+<>va_TAB  //[HéberGement]HG_Emplacement
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 11)+<>va_TAB  //[HéberGement]HG_Lien
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 12)+<>va_TAB  //[HéberGement]HG_Nationalité
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 13)+<>va_TAB  //[HéberGement]HG_SituFamille
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 14)+<>va_TAB  //[HéberGement]HG_TempsErrance
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 15)+<>va_TAB  //[HéberGement]HG_DernierHéber
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 16)+<>va_TAB  //[HéberGement]HG_SituProfess
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 17)+<>va_TAB  //[HéberGement]HG_DernierEmplo
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 18)+<>va_TAB  //[HéberGement]HG_DuréSanEmplo
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 25)+<>va_TAB  //[HéberGement]HG_PiècesIdté1
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 26)+<>va_TAB  //[HéberGement]HG_PiècesIdté2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 27)+<>va_TAB  //[HéberGement]HG_PiècesIdté3
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 28)+<>va_TAB  //[HéberGement]HG_RupMajeur1
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 28)+" 2"+<>va_TAB  //[HéberGement]HG_RupMajeur1_2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 29)+<>va_TAB  //[HéberGement]HG_RupMajeur2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 29)+" 2"+<>va_TAB  //[HéberGement]HG_RupMajeur2_2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 30)+<>va_TAB  //[HéberGement]HG_RupMajeur3
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 30)+" 2"+<>va_TAB  //[HéberGement]HG_RupMajeur3_2
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 31)+<>va_TAB  //[HéberGement]HG_Ressources1
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 31)+" 2"+<>va_TAB  //[HéberGement]HG_Ressource1_2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 32)+<>va_TAB  //[HéberGement]HG_Ressources2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 32)+" 2"+<>va_TAB  //[HéberGement]HG_Ressource2_2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 33)+<>va_TAB  //[HéberGement]HG_Ressources3
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 33)+" 2"+<>va_TAB  //[HéberGement]HG_Ressource3_2
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 34)+<>va_TAB  //[HéberGement]HG_SuiviSocial1
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 35)+<>va_TAB  //[HéberGement]HG_SuiviSocial2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 36)+<>va_TAB  //[HéberGement]HG_SuiviSocial3
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 37)+<>va_TAB  //[HéberGement]HG_CouvSocial2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 38)+<>va_TAB  //[HéberGement]HG_CouvSocial2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 39)+<>va_TAB  //[HéberGement]HG_CouvSocial3
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 41)+<>va_TAB  //[HéberGement]HG_NiveauEtude
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 42)+<>va_TAB  //[HéberGement]HG_Médicalisé
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 43)+<>va_TAB  //[HéberGement]HG_Status
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 44)+<>va_TAB  //[HéberGement]HG_Réservation
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 45)+<>va_TAB  //[HéberGement]HG_NuitenCours
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 46)+<>va_TAB  //[HéberGement]HG_NuitTOTAL
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 47)+<>va_TAB  //[HéberGement]HG_Reporté
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 54)+<>va_TAB  //[HéberGement]HG_EnAttente
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 55)+<>va_TAB  //[HéberGement]HG_AttenteHeur
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 56)+<>va_TAB  //[HéberGement]HG_Transmis
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 57)+<>va_TAB  //[HéberGement]HG_TransmisHeur
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 58)+<>va_TAB  //[HéberGement]HG_PriseCharge
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 59)+<>va_TAB  //[HéberGement]HG_PrChargeHeur
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 60)+<>va_TAB  //[HéberGement]HG_Cloturée
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 61)+<>va_TAB  //[HéberGement]HG_CloturéeHeur
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 48)+<>va_TAB  //[HéberGement]HG_Orientation1
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 49)+<>va_TAB  //[HéberGement]HG_Orientation2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 50)+<>va_TAB  //[HéberGement]HG_AutreSolutio
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 50)+" 2"+<>va_TAB  //[HéberGement]HG_AutreSolSuite
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 51)+"/"+xliff_Txt_Get_Indexed_String_(31011; 5)+<>va_TAB  //[HéberGement]HG_CentreNom
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 52)+<>va_TAB  //[HéberGement]HG_CentreARR
	$vt_Texte:=$vt_Texte+"P"+<>va_TAB  //[HéberGement]HG_Priorité
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 53)+" 2"+<>va_TAB  //[HéberGement]HG_DispoSpé
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 1)+<>va_TAB  //[HéberGement]HG_Coordinateur
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 2)+<>va_TAB  //[HéberGement]HG_Régulateur
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 3)+<>va_TAB  //[HéberGement]HG_Permanencier
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 4)+<>va_TAB  //[HéberGement]HG_AssistSocial
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 19)+<>va_TAB  //[HéberGement]HG_Maraude1_1
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 20)+<>va_TAB  //[HéberGement]HG_DateEntree
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 21)+<>va_TAB  //[HéberGement]HG_Maraude2_1
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 22)+<>va_TAB  //[HéberGement]HG_Maraude2_2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 23)+<>va_TAB  //[HéberGement]HG_Maraude3_1
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 24)+<>va_TAB  //[HéberGement]HG_DateSortie
	
	
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 89)+<>va_TAB  //[HéberGement]HG_ER_Excuse
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 90)+<>va_TAB  //[HéberGement]HG_ER_DateDébut
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 91)+<>va_TAB  //[HéberGement]HG_ER_DateFin
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 92)+<>va_TAB  //[HéberGement]HG_ER_NuitEnCours
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 93)+<>va_TAB  //[HéberGement]HG_ER_NuitTotal
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 94)+<>va_TAB  //[HéberGement]HG_ER_NuitReste
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 95)+<>va_TAB  //[HéberGement]HG_ER_Remplaçant
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 97)+<>va_TAB  //[HéberGement]HG_ER_RemplaceQui
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 62)+<>va_TAB  //[HéberGement]HG_FamGroupe
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 63)+<>va_TAB  //[HéberGement]HG_FamChef
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 64)+<>va_TAB  //[HéberGement]HG_FamClé
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 66)+<>va_TAB  //Sous chaine([HéberGement]HG_FamCompoVar;2;1)
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 67)+<>va_TAB  //Sous chaine([HéberGement]HG_FamCompoVar;4;1)
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 68)+<>va_TAB  //Sous chaine([HéberGement]HG_FamCompoVar;6;1)
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 69)+<>va_TAB  //Sous chaine([HéberGement]HG_FamCompoVar;8;2)
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 70)+<>va_TAB  //Sous chaine([HéberGement]HG_FamCompoVar;11;2)
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 71)+<>va_TAB  //Sous chaine([HéberGement]HG_FamCompoVar;14;1)
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 72)+<>va_TAB  //Sous chaine([HéberGement]HG_FamCompoVar;16;1)
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 73)+<>va_TAB  //[HéberGement]HG_FamNbPers
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 74)+<>va_TAB  //[HéberGement]HG_FamNbJour
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 75)+<>va_TAB  //[HéberGement]HG_FamNbChambre
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 76)+<>va_TAB  //[HéberGement]HG_FamPrixJour
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 77)+<>va_TAB  //[HéberGement]HG_FamTotal
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 98)+<>va_TAB  //[HéberGement]HG_FamNoDeBon
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 99)+<>va_TAB  //[HéberGement]HG_Participation
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 78)+<>va_TAB  //[HéberGement]HG_FamDistri1
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 84)+<>va_TAB  //[HéberGement]HG_FamDistri1M
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 79)+<>va_TAB  //[HéberGement]HG_FamDistri2
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 85)+<>va_TAB  //[HéberGement]HG_FamDistri2M
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 80)+<>va_TAB  //[HéberGement]HG_FamDistri3M
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 86)+<>va_TAB  //[HéberGement]HG_FamDistri3M
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 81)+<>va_TAB  //[HéberGement]HG_FamDistri4
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 87)+<>va_TAB  //[HéberGement]HG_FamDistri4M
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 82)+<>va_TAB  //[HéberGement]HG_FamDistri5
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 88)+<>va_TAB  //[HéberGement]HG_FamDistri5M
	
	$vt_Texte:=$vt_Texte+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 83)+<>va_CR  //[HéberGement]HG_FamCasSpéc
	
	
	$h_RefDoc:=Create document:C266(vt_FullDuplexDossier+vt_TitreDocument)
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		FIRST RECORD:C50([HeberGement:5])
		$ii:=0
		Repeat 
			$ii:=$ii+1
			i_MessageSeul("     Export en cours : "+String:C10(Size of array:C274(tl_Trans_Réf_HG))+"/"+String:C10($ii))
			
			$vt_Texte:=String:C10([HeberGement:5]HG_Date:4; Interne date court:K1:7)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_HeureAppel:5; h mn s:K7:1)+<>va_TAB
			$vt_Texte:=$vt_Texte+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215))+("N"*Num:C11([HeberGement:5]HG_Nuit:2=True:C214))+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_FicheNuméro:3+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Plateforme:139+<>va_TAB
			$vt_Texte:=$vt_Texte+("DDASS"*Num:C11([HeberGement:5]HG_Trans_DDASS:141=True:C214))+<>va_TAB
			
			
			
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
			MultiSoc_Filter(->[HeBerge:4])
			If (Records in selection:C76([HeBerge:4])=1)
				If ($1)
					$vt_Texte:=$vt_Texte+[HeBerge:4]HB_Nom:3+<>va_TAB
					$vt_Texte:=$vt_Texte+[HeBerge:4]HB_Prénom:4+<>va_TAB
					$vt_Texte:=$vt_Texte+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7)+<>va_TAB
					$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_Age:23)+<>va_TAB
					$vt_Texte:=$vt_Texte+("F"*Num:C11([HeBerge:4]HG_Genre:39=True:C214))+("M"*Num:C11([HeBerge:4]HG_Genre:39=False:C215))+<>va_TAB
					$vt_Texte:=$vt_Texte+[HeBerge:4]HB_Clé:2+<>va_TAB
				Else 
					$vt_Texte:=$vt_Texte+<>va_T_Site+" "+String:C10([HeberGement:5]HG_HB_ID:19)+<>va_TAB
					$vt_Texte:=$vt_Texte+<>va_TAB
					$vt_Texte:=$vt_Texte+String:C10([HeBerge:4]HB_DateNéLe:5; Interne date court:K1:7)+<>va_TAB
					$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_Age:23)+<>va_TAB
					$vt_Texte:=$vt_Texte+("F"*Num:C11([HeBerge:4]HG_Genre:39=True:C214))+("M"*Num:C11([HeBerge:4]HG_Genre:39=False:C215))+<>va_TAB
					$vt_Texte:=$vt_Texte+<>va_T_Site+" "+String:C10([HeberGement:5]HG_HB_ID:19)+<>va_TAB
				End if 
			Else 
				$vt_Texte:=$vt_Texte+<>va_TAB
				$vt_Texte:=$vt_Texte+<>va_TAB
				$vt_Texte:=$vt_Texte+<>va_TAB
				$vt_Texte:=$vt_Texte+<>va_TAB
				$vt_Texte:=$vt_Texte+<>va_TAB
				$vt_Texte:=$vt_Texte+<>va_TAB
			End if 
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_EtatCivil:20+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Signalement:12+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_SignalCentre:13+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_CodePostal:14+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Gare:15+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Métro:16+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Emplacement:17+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Lien:18+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Nationalité:25+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_SituFamille:29+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_TempsErrance:34+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_DernierHéber:35+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_SituProfess:36+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_DernierEmplo:37+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_DuréSanEmplo:38+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_PiècesIdté1:31+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_PiècesIdté2:32+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_PiècesIdté3:33+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_RupMajeur1:40+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_RupMajeur1_2:72+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_RupMajeur2:41+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_RupMajeur2_2:73+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_RupMajeur3:42+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_RupMajeur3_2:74+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Ressources1:45+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Ressource1_2:75+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Ressources2:46+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Ressource2_2:76+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Ressources3:47+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Ressource3_2:77+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_SuiviSocial1:49+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_SuiviSocial2:50+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_SuiviSocial3:51+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_CouvSocial2:54+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_CouvSocial2:54+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_CouvSocial3:55+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_NiveauEtude:43+<>va_TAB
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_Médicalisé:56))+("Non"*Num:C11([HeberGement:5]HG_Médicalisé:56=False:C215))+<>va_TAB
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_Status:89))+("Non"*Num:C11([HeberGement:5]HG_Status:89=False:C215))+<>va_TAB
			
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_Réservation:91))+("Non"*Num:C11([HeberGement:5]HG_Réservation:91=False:C215))+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_NuitenCours:92)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_NuitTOTAL:93)+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Reporté:94+<>va_TAB
			
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_EnAttente:64))+("Non"*Num:C11([HeberGement:5]HG_EnAttente:64=False:C215))+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_AttenteHeur:83; h mn s:K7:1)+<>va_TAB
			
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_Transmis:65))+("Non"*Num:C11([HeberGement:5]HG_Transmis:65=False:C215))+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_TransmisHeur:84; h mn s:K7:1)+<>va_TAB
			
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_PriseCharge:66))+("Non"*Num:C11([HeberGement:5]HG_PriseCharge:66=False:C215))+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_PrChargeHeur:85; h mn s:K7:1)+<>va_TAB
			
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_Cloturée:67))+("Non"*Num:C11([HeberGement:5]HG_Cloturée:67=False:C215))+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_CloturéeHeur:86; h mn s:K7:1)+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Orientation1:58+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Orientation2:60+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_AutreSolutio:88+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_AutreSolSuite:123+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_CentreNom:62+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_CentreARR:63+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_Priorité:57)+<>va_TAB
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_DispoSpé:90))+("Non"*Num:C11([HeberGement:5]HG_DispoSpé:90=False:C215))+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Coordinateur:7+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Régulateur:8+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Permanencier:9+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_AssistSocial:87+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Maraude1_1:10+<>va_TAB
			$vt_Texte:=$vt_Texte+"[HeberGement]HG_DateEntree"+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Maraude2_1:98+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Maraude2_2:99+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Maraude3_1:100+<>va_TAB
			$vt_Texte:=$vt_Texte+"[HeberGement]HG_DateSortie"+<>va_TAB
			
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_ER_Excuse:124))+("Non"*Num:C11([HeberGement:5]HG_ER_Excuse:124=False:C215))+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_ER_DateDébut:125; Interne date court:K1:7)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_ER_DateFin:126; Interne date court:K1:7)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_ER_NuitEnCours:127)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_ER_NuitTotal:128)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_ER_NuitReste:129)+<>va_TAB
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_ER_Remplaçant:130))+("Non"*Num:C11([HeberGement:5]HG_ER_Remplaçant:130=False:C215))+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_ER_RemplaceQui:132+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_FamGroupe:102+<>va_TAB
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_FamChef:103))+("Non"*Num:C11([HeberGement:5]HG_FamChef:103=False:C215))+<>va_TAB
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_FamClé:104+<>va_TAB
			
			If ([HeberGement:5]HG_FamCompoVar:117>"")
				$vt_Texte:=$vt_Texte+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 2; 1)+<>va_TAB
				$vt_Texte:=$vt_Texte+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 4; 1)+<>va_TAB
				$vt_Texte:=$vt_Texte+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 6; 1)+<>va_TAB
				$vt_Texte:=$vt_Texte+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 8; 2)+<>va_TAB
				$vt_Texte:=$vt_Texte+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 11; 2)+<>va_TAB
				$vt_Texte:=$vt_Texte+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 14; 1)+<>va_TAB
				$vt_Texte:=$vt_Texte+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 16; 1)+<>va_TAB
			Else 
				$vt_Texte:=$vt_Texte+"0"+<>va_TAB
				$vt_Texte:=$vt_Texte+"0"+<>va_TAB
				$vt_Texte:=$vt_Texte+"0"+<>va_TAB
				$vt_Texte:=$vt_Texte+"0"+<>va_TAB
				$vt_Texte:=$vt_Texte+"0"+<>va_TAB
				$vt_Texte:=$vt_Texte+"0"+<>va_TAB
				$vt_Texte:=$vt_Texte+"0"+<>va_TAB
				
				ve_FamH:=0
				ve_FamF:=0
				ve_FamFe:=0
				ve_FamEMi:=0
				ve_FamEMa:=0
				ve_FamPMi:=0
				ve_FamPMa:=0
			End if 
			
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamNbPers:106)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamNbJour:107)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamNbChambre:108)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamPrixJour:109)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamTotal:110)+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamNoDeBon:136)+<>va_TAB
			$vt_Texte:=$vt_Texte+("Oui"*Num:C11([HeberGement:5]HG_Participation:138))+("Non"*Num:C11([HeberGement:5]HG_Participation:138=False:C215))+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_FamDistri1:112+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamDistri1M:118)+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_FamDistri2:113+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamDistri2M:119)+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_FamDistri3:114+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamDistri3M:120)+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_FamDistri4:115+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamDistri4M:121)+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_FamDistri5:116+<>va_TAB
			$vt_Texte:=$vt_Texte+String:C10([HeberGement:5]HG_FamDistri5M:122)+<>va_TAB
			
			$vt_Texte:=$vt_Texte+[HeberGement:5]HG_FamCasSpéc:111+<>va_CR
			
			
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			
			NEXT RECORD:C51([HeberGement:5])
		Until (End selection:C36([HeberGement:5]))
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
	
	
	QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_Trans_Réf_HG)
	P_HébergementVeilleSort(2)
	CLOSE WINDOW:C154
	BEEP:C151
	BEEP:C151
End if 
F_Report_FullDuplexTableau

