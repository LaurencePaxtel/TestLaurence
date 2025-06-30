//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DebutDécVar  
//{          initialisation des variable superglobales
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii)

C_LONGINT:C283(<>vl_FenPP)
C_BOOLEAN:C305(<>vb_FenPP)

C_LONGINT:C283(<>vl_EcranL; <>vl_EcranH)
C_PICTURE:C286(<>vi_Vide)
C_PICTURE:C286(<>vi_Siège)
C_PICTURE:C286(<>vi_Limage)
<>vl_EcranL:=Screen width:C187
<>vl_EcranH:=Screen height:C188

C_LONGINT:C283(<>vl_EcranLeft; <>vl_EcranTop; <>vl_EcranOfst)
<>vl_EcranLeft:=5
<>vl_EcranTop:=34+10
<>vl_EcranOfst:=10

C_TEXT:C284(<>va_CR)  //Retout chariot
<>va_CR:=Char:C90(Retour chariot:K15:38)

C_TEXT:C284(<>va_LF)  //Line feed
<>va_LF:=Char:C90(10)

C_TEXT:C284(<>va_FF)  //From feed
<>va_FF:=Char:C90(12)

C_TEXT:C284(<>va_TAB)  //Tabulation
<>va_TAB:=Char:C90(9)

C_TEXT:C284(<>va_B32)  //Blanc
<>va_B32:=Char:C90(32)

C_TEXT:C284(<>va_Diez)  //Car #
<>va_Diez:="#"

C_TEXT:C284(<>va_PtVirg)  //Car ;
<>va_PtVirg:=";"

C_TEXT:C284(<>va_ForCR)  //Car de remplacement pour le retour chariot
<>va_ForCR:=";"

C_LONGINT:C283(<>vl_ArrowBase)
<>vl_ArrowBase:=Character code:C91("@")

C_DATE:C307(<>vd_DateSyst)  //Date du système 
<>vd_DateSyst:=Current date:C33(*)

C_TIME:C306(<>vh_HeurSyst)  //Heure du système 
<>vh_HeurSyst:=Current time:C178(*)

C_TIME:C306(<>vh_HeureVide)  //Heure du système 
<>vh_HeureVide:=?00:00:00?

C_DATE:C307(<>vd_DtJour)
C_TEXT:C284(<>va_ServDH)  //Date et heure du serveur

C_PICTURE:C286(<>vi_FondVide)
C_PICTURE:C286(<>vi_FondDépart)
C_PICTURE:C286(<>vi_FondSigne)
C_PICTURE:C286(<>vi_FondLogoLarge)
C_PICTURE:C286(<>vi_FondLogoPetit)
C_PICTURE:C286(<>vi_Main115)

GET PICTURE RESOURCE:C502(30001; <>vi_FondDépart)
GET PICTURE RESOURCE:C502(30002; <>vi_FondSigne)
GET PICTURE RESOURCE:C502(30004; <>vi_FondLogoPetit)

GET PICTURE RESOURCE:C502(30003; <>vi_FondLogoLarge)

//gestion d'événement clavier ou souris
C_BOOLEAN:C305(<>vb_Event)
C_LONGINT:C283(<>e_MouseDown)
<>e_MouseDown:=0

//gestion des menus
C_LONGINT:C283(<>Vl_Menu)
<>vl_Menu:=0

C_LONGINT:C283(<>Vl_Ligne)
<>vl_Ligne:=0

C_TEXT:C284(<>Va_DemP)
<>Va_DemP:="Demande de prestations"

C_TEXT:C284(<>Va_AdUtil)
<>Va_AdUtil:="Adresses utiles"

C_TEXT:C284(<>Va_SitPar)
<>Va_SitPar:="Situations particulières"

C_TEXT:C284(<>Va_Assoc)
<>Va_Assoc:="Associations"

C_TEXT:C284(<>Va_Rubrique)
<>Va_Rubrique:=""

C_TEXT:C284(<>Va_Thème)
<>Va_Thème:=""

C_TEXT:C284(<>Va_SouThème)
<>Va_SouThème:=""

C_POINTER:C301(<>Vptr_tRub)

ARRAY TEXT:C222(<>ta_DeviseSigle; 0)
ARRAY REAL:C219(<>tr_DeviseCours; 0)
ARRAY REAL:C219(<>tr_DeviseEuro; 0)

C_TEXT:C284(<>va_DeviseSdtSigle)
C_REAL:C285(<>vr_DeviseSdtCours; <>vr_DeviseSdtEuro)
C_TEXT:C284(<>va_DeviseFRF; <>va_DeviseEUR)
C_REAL:C285(<>vr_DeviseFRF; <>vr_DeviseEUR)
<>va_DeviseFRF:="FRF"
<>va_DeviseEUR:="EUR"
<>vr_DeviseFRF:=0.152449
<>vr_DeviseEUR:=6.55957

C_LONGINT:C283(<>vl_Langue; <>vl_LgTips)
<>vl_Langue:=0
<>vl_LgTips:=30021


C_TEXT:C284(<>vaPrFix_115)
<>vaPrFix_115:="115"

//Compteurs SIAO
C_TEXT:C284(<>vaCPT_SIAO)
<>vaCPT_SIAO:=""


//N° des Groupes
C_TEXT:C284(<>vaCPT_GpeJ)
C_TEXT:C284(<>vaCPT_GpeN)
<>vaCPT_GpeJ:="No_GroupeJour"
<>vaCPT_GpeN:="No_GroupeNuit"

C_BOOLEAN:C305(<>vb_GpeOui)
C_LONGINT:C283(<>vl_GpeMaxNbFam)
C_LONGINT:C283(<>vl_GpeMaxNbStd)
DébutInitGroupe(0)

//Procédure : DebutInitVar
C_TEXT:C284(<>vaCPT_MR)
C_TEXT:C284(<>vaCPT_DS)
C_TEXT:C284(<>vaCPT_DI)
C_TEXT:C284(<>vaCPT_DP)
C_TEXT:C284(<>vaCPT_DM)
C_TEXT:C284(<>vaCPT_DE)

//initialisation des variable super globales
C_BOOLEAN:C305(<>vb_StopEven)
<>vb_StopEven:=False:C215

C_BOOLEAN:C305(<>vb_UtDirect)
<>vb_UtDirect:=False:C215

C_TEXT:C284(<>Va_NoUFicV)  //Pour le format veille
<>Va_NoUFicV:=""

C_LONGINT:C283(<>Vl_RefUfich)  //Pour demande de prestations
<>Vl_RefUfich:=0

outilsManageStorage("numerotation")

DebutDecVarParam

READ ONLY:C145([SOciete:18])

QUERY:C277([SOciete:18]; [SOciete:18]SO_ReferenceID:1=1)
MultiSoc_Filter(->[SOciete:18])

If (Records in selection:C76([SOciete:18])>1)
	QUERY SELECTION:C341([SOciete:18]; [SOciete:18]SO_Libel00:2>"")
	
	If (Records in selection:C76([SOciete:18])=1)
		QUERY:C277([SOciete:18]; [SOciete:18]SO_ReferenceID:1=1; *)
		QUERY:C277([SOciete:18];  & ; [SOciete:18]SO_Libel00:2="")
		MultiSoc_Filter(->[SOciete:18])
		
		If (Records in selection:C76([SOciete:18])>1)
			READ WRITE:C146([SOciete:18])
			
			DELETE SELECTION:C66([SOciete:18])
			READ ONLY:C145([SOciete:18])
		End if 
		
	End if 
	
	QUERY:C277([SOciete:18]; [SOciete:18]SO_ReferenceID:1=1)
	MultiSoc_Filter(->[SOciete:18])
End if 

If (Records in selection:C76([SOciete:18])=1)
	<>va_T_00:=[SOciete:18]SO_Libel00:2
	<>va_T_01:=[SOciete:18]SO_Libel01:3
	<>va_T_02:=[SOciete:18]SO_Libel02:4
	<>va_T_03:=[SOciete:18]SO_Libel03:5
	<>va_T_04:=[SOciete:18]SO_Libel04:6
	<>va_T_05:=[SOciete:18]SO_Libel05:7
	
	<>va_T_Site:=[SOciete:18]SO_Site:8
	
	<>vt_T_CheminRép:=[SOciete:18]SO_CheminRépertoire:11
	<>vt_T_CheminRépServeur:=[SOciete:18]SO_CheminRépertoireServeur:25
	<>vt_T_CheminRépDalo:=[SOciete:18]SO_CheminRépertoireDalo:26
	
	<>vt_T_DossierRep:=[SOciete:18]SO_RépertoireSite:12
	<>vb_T_BoiteLettres:=[SOciete:18]SO_BoiteLettres:13
	<>vb_T_BoiteDalo:=[SOciete:18]SO_BoiteDalo:27
	
	<>vl_T_ColorCadreH:=[SOciete:18]SO_CouleurCadreH:14
	<>vl_T_ColorCadreC:=[SOciete:18]SO_CouleurCadreC:15
	<>vl_T_ColorCadreB:=[SOciete:18]SO_CouleurCadreB:16
	
	<>vb_T_ModeCHRS:=[SOciete:18]SO_ModeCHRS:17
	<>vb_T_Ecran115:=[SOciete:18]SO_Ecran115:18
	<>vb_T_MasqueETCV:=[SOciete:18]SO_MasqueEtatCivil:19
	<>vb_T_Cryptage:=[SOciete:18]SO_Cryptage:20
	
	<>vb_T_TransTransfert:=[SOciete:18]SO_TransTransfert:21
	
	<>vb_T_FullDuplex:=[SOciete:18]SO_155FullDuplex:22
	
	<>ve_T_CentreCode:=[SOciete:18]SO_CodeCentre:23
	
	<>vb_T_EcranGrand:=[SOciete:18]SO_EcranGrand:24
	<>vb_T_Windows:=[SOciete:18]SO_Windows:28
	<>vb_T_SansPrestations:=[SOciete:18]SO_SansPrestation:29
	
	<>vb_T_OccupMinuteur:=[SOciete:18]SO_TauxOccup:30
	<>vl_T_OccupMinuteurTicks:=[SOciete:18]SO_TauxOccupTicks:31
	<>vb_T_OccupMinuteurMess:=[SOciete:18]SO_TauxOccupMess:32
	
	// #20180509-2
	<>va_T_Onglet3Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_3:33)>0; [SOciete:18]SO_OngletNote_3:33; "Note 2")
	<>va_T_Onglet4Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_4:73)>0; [SOciete:18]SO_OngletNote_4:73; "Note 4")
	<>va_T_Onglet5Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_5:74)>0; [SOciete:18]SO_OngletNote_5:74; "Note 5")
	<>va_T_Onglet6Note:=Choose:C955(Length:C16([SOciete:18]SO_Ongletnote_6:93)>0; [SOciete:18]SO_Ongletnote_6:93; "Note 1")  //#20180509-1
	<>va_T_Onglet7Note:=Choose:C955(Length:C16([SOciete:18]SO_Ongletnote_7:95)>0; [SOciete:18]SO_Ongletnote_7:95; "Note 3")  // #20180509-1
	
	<>va_T_Onglet8Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_8:122)>0; [SOciete:18]SO_OngletNote_8:122; "Maraude 1")
	<>va_T_Onglet9Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_9:123)>0; [SOciete:18]SO_OngletNote_9:123; "Maraude 2")
	<>va_T_Onglet10Note:=Choose:C955(Length:C16([SOciete:18]SO_OngletNote_10:124)>0; [SOciete:18]SO_OngletNote_10:124; "FVV")
	
	<>va_T_PièceNéOu:=[SOciete:18]SO_PieceChamp1:34  //"Lieu de naissance"
	
	If (<>va_T_PièceNéOu<="")
		<>va_T_PièceNéOu:="Lieu de naissance"
	End if 
	
	<>va_T_PièceNationalité:=[SOciete:18]SO_PieceChamp2:35  //"Nationalité"
	
	If (<>va_T_PièceNationalité<="")
		<>va_T_PièceNationalité:="Nationalité"
	End if 
	
	<>va_T_PièceCNI:=[SOciete:18]SO_PieceChamp3:36  //"C.N.I."
	
	If (<>va_T_PièceCNI<="")
		<>va_T_PièceCNI:="C.N.I."
	End if 
	
	<>va_T_PiècePasseport:=[SOciete:18]SO_PieceChamp4:37  //"Passeport"
	
	If (<>va_T_PiècePasseport<="")
		<>va_T_PiècePasseport:="Passeport"
	End if 
	
	<>vb_T_RéfHébergé:=[SOciete:18]SO_VoirRéfHébergé:38
	<>vb_T_CryptageHébergé:=[SOciete:18]SO_CryptageHébergé:39
	<>vl_T_CryptageHébergéJour:=[SOciete:18]SO_CryptageHébergéJour:40
	
	<>vb_T_CalcTroisEnfants:=[SOciete:18]SO_ModeStatTroisEnfants:41
	
	<>vb_T_ImprimerAction:=[SOciete:18]SO_ImprimeAction:42
	<>vl_T_JourSortant:=[SOciete:18]SO_JourSortant:43
	
	<>vb_T_NoteNonModifiables:=[SOciete:18]SO_NotesNonModifiables:44
	<>vb_T_NoteMARNonModifiables:=[SOciete:18]SO_NotesMARNonModifiable:45
	
	<>ve_ConsoRegion_Mode:=[SOciete:18]SO_ConsoRégion_Mode:46  //3/11/2010
	<>vt_ConsoRegion_Dosssier:=[SOciete:18]SO_ConsoRégion_DosPour115:47  //3/11/2010
	<>vt_ConsoRegion_DosPourRegion:=[SOciete:18]SO_ConsoRégion_DosPourRégion:48  //3/11/2010
	
	P_DecoupeChemins(1; -><>vt_ConsoRegion_DosPourRegion; -><>tt_T_CheminsRegionaux)  //3/11/2010
	
	<>vh_T_HeureNuit:=[SOciete:18]SO_AQuelleHeureTombeLaNuit:49
	<>va_T_Departement:=[SOciete:18]SO_Departement:50
	<>vb_T_DitribSansDecimale:=[SOciete:18]SO_DitribSansDecimale:51
	
	<>vt_CheminRégion:=[SOciete:18]SO_CheminRégion:52  //28/1/2011
	<>vt_DossierRégion:=[SOciete:18]SO_DossierRégion:53  //28/1/2011
	
	<>va_T_Lettre:=[SOciete:18]SO_Lettre:54  //01/2/2011
	
	<>vb_T_SIAO_Insertion:=[SOciete:18]SO_SIAOUrgence:55  //07/2/2011
	<>vb_T_Version510:=[SOciete:18]SO_CinqCentDix:56  //11/2/2011
	
	<>vb_T_SIAOsynchroHG:=[SOciete:18]SO_SIAOSynchroHG:57  //22/3/2011
	<>vb_T_SIAOsynchroHGBT:=[SOciete:18]SO_SIAOSynchroHGBT:58  //22/3/2011
	
	<>vl_T_MPLongueur:=[SOciete:18]SO_MotPasseLongueur:59  //28/3/2011
	<>vl_T_MPJoursValide:=[SOciete:18]SO_MotPasseJoursValide:60  //28/3/2011
	
	<>vb_T_CentreCritMasquer:=[SOciete:18]SO_MasquerCritCentres:61  //28/3/2011
	
	<>vb_T_PrestaMasquer:=[SOciete:18]SO_MasquerPresta:62  //28/3/2011
	<>vb_T_CtrlNation:=[SOciete:18]SO_CtrlNation:63  //29/3/2011
	
	<>vb_T_MPMasquePlus:=[SOciete:18]SO_MotPasseMaquePlus:64  //6/4/2011
	
	<>vb_T_LogActif:=[SOciete:18]SO_LogActif:65  //13/4/2011
	
	<>vb_T_Prestations:=[SOciete:18]SO_Prestation:66  //29/4/2011
	<>vb_T_PrestationsChemin:=[SOciete:18]SO_PrestationChemin:67  //29/4/2011
	<>vb_T_PrestationsDossier:=[SOciete:18]SO_PrestationDossier:68  //29/4/2011
	
	<>vb_T_Fiches115:=[SOciete:18]SO_Fiche115:69  //25/5/2011
	
	<>vl_T_SIAOType:=[SOciete:18]SO_SIAO:70  //21/6/2011
	
	<>va_T_HBsignal:=[SOciete:18]SO_Signalement:71  //21/6/2011
	
	<>ve_T_ColonneOrienter:=[SOciete:18]SO_ColonneOrienter:72  //26/7/2011
	
	//25/11/2011
	<>va_T_CodePostal:=[SOciete:18]SO_CodePostal:75
	<>va_T_Ville:=[SOciete:18]SO_Ville:76
	<>va_T_TerritoireCode:=[SOciete:18]SO_TerritoireCode:77
	<>va_T_TerritoireLibelle:=[SOciete:18]SO_TerritoireLibelle:78
	<>va_T_DepartementLibelle:=[SOciete:18]SO_DeptLibelle:79
	<>va_T_RegionCode:=[SOciete:18]SO_RegionCode:80
	<>va_T_RegionLibelle:=[SOciete:18]SO_RegionLibelle:81
	<>va_T_InseeCode:=[SOciete:18]SO_INSEEcode:82
	
	//13/12/2011
	<>vb_T_DosSIAO:=[SOciete:18]SO_DossierSIAO:83
	
	//26/01/2012
	<>va_T_CentreSIAOPrestation:=[SOciete:18]SO_CentreSIAOPrestation:84
	
	//8/02/2012
	<>va_T_RefusCHRS:=[SOciete:18]SO_Refus_CHRS:85
	<>va_T_RefusDEMANDEUR:=[SOciete:18]SO_Refus_Demandeur:86
	<>va_T_RefusAFFECTE:=[SOciete:18]SO_Refus_AFFECTE:87
	
	<>vl_T_ErrorJours:=[SOciete:18]SO_ErrorJours:88  //9/05/2012
	<>vt_T_CheminSO_CheminRepDistant:=[SOciete:18]SO_CheminRepertoireDistant:89  //16/05/2012
	
	<>vt_T_CheminBoite:=[SOciete:18]SO_CheminBoite:90  //23/05/2012
	
	<>vb_T_PlateformeMod:=[SOciete:18]SO_PlateformeMod:91  //06/06/2012
Else 
	READ WRITE:C146([SOciete:18])
	
	CREATE RECORD:C68([SOciete:18])
	MultiSoc_Init_Structure(->[SOciete:18])
	
	[SOciete:18]SO_ReferenceID:1:=1
	[SOciete:18]SO_Libel00:2:=""
	[SOciete:18]SO_Libel01:3:=""
	[SOciete:18]SO_Libel02:4:=""
	[SOciete:18]SO_Libel03:5:=""
	[SOciete:18]SO_Libel04:6:=""
	[SOciete:18]SO_Libel05:7:=""
	[SOciete:18]SO_Site:8:=""
	[SOciete:18]SO_LibelléSite:9:=""
	[SOciete:18]SO_CheminRépertoire:11:=""
	[SOciete:18]SO_CheminRépertoireServeur:25:=""
	[SOciete:18]SO_CheminRépertoireDalo:26:=""
	[SOciete:18]SO_RépertoireSite:12:=""
	[SOciete:18]SO_BoiteLettres:13:=False:C215
	[SOciete:18]SO_BoiteDalo:27:=False:C215
	[SOciete:18]SO_CouleurCadreH:14:=<>vl_T_ColorCadreH
	[SOciete:18]SO_CouleurCadreC:15:=<>vl_T_ColorCadreC
	[SOciete:18]SO_CouleurCadreB:16:=<>vl_T_ColorCadreB
	[SOciete:18]SO_ModeCHRS:17:=<>vb_T_ModeCHRS
	[SOciete:18]SO_Ecran115:18:=<>vb_T_Ecran115
	[SOciete:18]SO_MasqueEtatCivil:19:=<>vb_T_MasqueETCV
	[SOciete:18]SO_Cryptage:20:=<>vb_T_Cryptage
	[SOciete:18]SO_TransTransfert:21:=<>vb_T_TransTransfert
	[SOciete:18]SO_155FullDuplex:22:=<>vb_T_FullDuplex
	[SOciete:18]SO_CodeCentre:23:=<>ve_T_CentreCode
	[SOciete:18]SO_EcranGrand:24:=<>vb_T_EcranGrand
	[SOciete:18]SO_Windows:28:=<>vb_T_Windows
	[SOciete:18]SO_SansPrestation:29:=<>vb_T_SansPrestations
	
	[SOciete:18]SO_TauxOccup:30:=<>vb_T_OccupMinuteur
	[SOciete:18]SO_TauxOccupTicks:31:=<>vl_T_OccupMinuteurTicks
	[SOciete:18]SO_TauxOccupMess:32:=<>vb_T_OccupMinuteurMess
	
	[SOciete:18]SO_OngletNote_3:33:=<>va_T_Onglet3Note
	[SOciete:18]SO_OngletNote_4:73:=<>va_T_Onglet4Note
	[SOciete:18]SO_OngletNote_5:74:=<>va_T_Onglet5Note
	[SOciete:18]SO_Ongletnote_6:93:=<>va_T_Onglet6Note  //#20180509-1
	[SOciete:18]SO_Ongletnote_7:95:=<>va_T_Onglet7Note  //#20180509-1
	[SOciete:18]SO_OngletNote_8:122:=<>va_T_Onglet8Note  //#20240116
	[SOciete:18]SO_OngletNote_9:123:=<>va_T_Onglet9Note  //#20240116
	[SOciete:18]SO_OngletNote_10:124:=<>va_T_Onglet10Note  //#20240116
	
	[SOciete:18]SO_PieceChamp1:34:=<>va_T_PièceNéOu
	[SOciete:18]SO_PieceChamp2:35:=<>va_T_PièceNationalité
	[SOciete:18]SO_PieceChamp3:36:=<>va_T_PièceCNI
	[SOciete:18]SO_PieceChamp4:37:=<>va_T_PiècePasseport
	
	If ([SOciete:18]SO_PieceChamp1:34<="")
		[SOciete:18]SO_PieceChamp1:34:="Lieu de naissance"
	End if 
	
	If ([SOciete:18]SO_PieceChamp2:35<="")
		[SOciete:18]SO_PieceChamp2:35:="Nationalité"
	End if 
	
	If ([SOciete:18]SO_PieceChamp3:36<="")
		[SOciete:18]SO_PieceChamp3:36:="C.N.I."
	End if 
	
	If ([SOciete:18]SO_PieceChamp4:37<="")
		[SOciete:18]SO_PieceChamp4:37:="Passeport"
	End if 
	
	[SOciete:18]SO_VoirRéfHébergé:38:=<>vb_T_RéfHébergé
	
	[SOciete:18]SO_CryptageHébergé:39:=<>vb_T_CryptageHébergé
	[SOciete:18]SO_CryptageHébergéJour:40:=<>vl_T_CryptageHébergéJour
	
	[SOciete:18]SO_ModeStatTroisEnfants:41:=<>vb_T_CalcTroisEnfants
	
	[SOciete:18]SO_ImprimeAction:42:=<>vb_T_ImprimerAction
	[SOciete:18]SO_JourSortant:43:=<>vl_T_JourSortant
	
	[SOciete:18]SO_NotesNonModifiables:44:=<>vb_T_NoteNonModifiables
	[SOciete:18]SO_NotesMARNonModifiable:45:=<>vb_T_NoteMARNonModifiables
	
	[SOciete:18]SO_ConsoRégion_Mode:46:=<>ve_ConsoRegion_Mode  //3/11/2010
	[SOciete:18]SO_ConsoRégion_DosPour115:47:=<>vt_ConsoRegion_Dosssier  //3/11/2010
	[SOciete:18]SO_ConsoRégion_DosPourRégion:48:=<>vt_ConsoRegion_DosPourRegion  //3/11/2010
	
	[SOciete:18]SO_AQuelleHeureTombeLaNuit:49:=<>vh_T_HeureNuit  //3/11/2010
	[SOciete:18]SO_Departement:50:=<>va_T_Departement
	[SOciete:18]SO_DitribSansDecimale:51:=<>vb_T_DitribSansDecimale
	
	[SOciete:18]SO_CheminRégion:52:=<>vt_CheminRégion  //28/1/2011
	[SOciete:18]SO_DossierRégion:53:=<>vt_DossierRégion  //28/1/2011
	
	[SOciete:18]SO_Lettre:54:=<>va_T_Lettre
	<>vb_T_SIAO_Insertion:=<>vb_T_SIAO_Urgence  //07/2/2011
	
	[SOciete:18]SO_CinqCentDix:56:=<>vb_T_Version510  //11/2/2011
	
	[SOciete:18]SO_SIAOSynchroHG:57:=<>vb_T_SIAOsynchroHG  //22/3/2011
	[SOciete:18]SO_SIAOSynchroHGBT:58:=<>vb_T_SIAOsynchroHGBT  //22/3/2011
	
	[SOciete:18]SO_MotPasseLongueur:59:=<>vl_T_MPLongueur  //28/3/2011
	[SOciete:18]SO_MotPasseJoursValide:60:=<>vl_T_MPJoursValide  //28/3/2011
	
	[SOciete:18]SO_MasquerCritCentres:61:=<>vb_T_CentreCritMasquer  //28/3/2011
	[SOciete:18]SO_MasquerPresta:62:=<>vb_T_PrestaMasquer  //28/3/2011
	
	[SOciete:18]SO_CtrlNation:63:=<>vb_T_CtrlNation  //29/3/2011
	[SOciete:18]SO_MotPasseMaquePlus:64:=<>vb_T_MPMasquePlus  //6/4/2011
	[SOciete:18]SO_LogActif:65:=<>vb_T_LogActif  //13/4/2011
	
	[SOciete:18]SO_Prestation:66:=<>vb_T_Prestations  //29/4/2011
	[SOciete:18]SO_PrestationChemin:67:=<>vb_T_PrestationsChemin  //29/4/2011
	[SOciete:18]SO_PrestationDossier:68:=<>vb_T_PrestationsDossier  //29/4/2011
	
	[SOciete:18]SO_Fiche115:69:=<>vb_T_Fiches115  //25/5/2011
	[SOciete:18]SO_SIAO:70:=<>vl_T_SIAOType  //21/6/2011
	[SOciete:18]SO_Signalement:71:=<>va_T_HBsignal  //21/6/2011
	[SOciete:18]SO_ColonneOrienter:72:=<>ve_T_ColonneOrienter  //26/7/2011
	
	// 25/11/2011
	[SOciete:18]SO_CodePostal:75:=<>va_T_CodePostal
	[SOciete:18]SO_Ville:76:=<>va_T_Ville
	[SOciete:18]SO_TerritoireCode:77:=<>va_T_TerritoireCode
	[SOciete:18]SO_TerritoireLibelle:78:=<>va_T_TerritoireLibelle
	[SOciete:18]SO_DeptLibelle:79:=<>va_T_DepartementLibelle
	[SOciete:18]SO_RegionCode:80:=<>va_T_RegionCode
	[SOciete:18]SO_RegionLibelle:81:=<>va_T_RegionLibelle
	[SOciete:18]SO_INSEEcode:82:=<>va_T_InseeCode
	
	// 13/12/2011
	[SOciete:18]SO_DossierSIAO:83:=<>vb_T_DosSIAO
	
	// 26/01/2012
	[SOciete:18]SO_CentreSIAOPrestation:84:=<>va_T_CentreSIAOPrestation
	
	// 08/02/2012
	[SOciete:18]SO_Refus_CHRS:85:=<>va_T_RefusCHRS
	[SOciete:18]SO_Refus_Demandeur:86:=<>va_T_RefusDEMANDEUR
	[SOciete:18]SO_Refus_AFFECTE:87:=<>va_T_RefusAFFECTE
	
	[SOciete:18]SO_ErrorJours:88:=<>vl_T_ErrorJours  //9/05/2012
	[SOciete:18]SO_CheminRepertoireDistant:89:=<>vt_T_CheminSO_CheminRepDistant  //16/05/2012
	[SOciete:18]SO_CheminBoite:90:=<>vt_T_CheminBoite  //23/05/2012
	[SOciete:18]SO_PlateformeMod:91:=<>vb_T_PlateformeMod  //06/06/2012
	
	SAVE RECORD:C53([SOciete:18])
	
	UNLOAD RECORD:C212([SOciete:18])
	READ ONLY:C145([SOciete:18])
End if 

// Modifié par : Scanu Rémy (19/07/2023)

outilsManageStorage("societe")
P_CodeCentre(-><>vl_T_CentreCodeDebut; -><>vl_T_CentreCodeFin)

C_LONGINT:C283(<>vl_NoHHisto)
<>vl_NoHHisto:=0

C_DATE:C307(<>Vd_NoUDate)
<>Vd_NoUDate:=!00-00-00!

C_TIME:C306(<>Vh_NoUHeure)
<>Vh_NoUHeure:=?00:00:00?

C_BOOLEAN:C305(<>Vb_Nuit)
<>Vb_Nuit:=True:C214

<>DDJ:=Current date:C33  // Sur le dialogue de depart

C_LONGINT:C283(<>vl_RéfU_HB)
<>vl_RéfU_HB:=0

// Variables communes au report constantes
DebutDecVarReport
DebutDecVarPresta
DebutDecVarSIAO

C_TEXT:C284(<>Va_RéfULier)  // Référence unique groupement
<>Va_RéfULier:="RR_Liaison"

C_TEXT:C284(<>va_AppelMes)  // Message Appels

C_BOOLEAN:C305(<>vb_MarNuit)

C_TEXT:C284(<>vt_Hotel)

C_TEXT:C284(<>va_Appel_HGc)  // Message Appels hebergement C
C_LONGINT:C283(<>vl_Appel_HGcRefHB)

//Status des rubriques 
C_LONGINT:C283(<>ve_ageHom)
C_LONGINT:C283(<>ve_ageFem)

QUERY:C277([LesRubriques:21]; [LesRubriques:21]RubFichier:3=-1)
MultiSoc_Filter(->[LesRubriques:21])

If (Records in selection:C76([LesRubriques:21])=1)
	<>ve_ageHom:=[LesRubriques:21]NuméroTri:1
	<>ve_ageFem:=[LesRubriques:21]RubNuméro:4
End if 

If (<>ve_ageHom<=0)
	<>ve_ageHom:=45
End if 

If (<>ve_ageFem<=0)
	<>ve_ageFem:=40
End if 

C_TEXT:C284(<>va_TypeHGt)

<>va_TypeHGt:="FAMILLE"
<>va_NoCléFAM:="NoCléFAM"

C_TEXT:C284(<>va_LienDeFamille)
<>va_LienDeFamille:="LienDeFamille"

C_LONGINT:C283(<>vl_RubNb)
<>vl_RubNb:=45

C_LONGINT:C283(<>ve_StatCoordinateur)
C_LONGINT:C283(<>ve_StatCoordinateurS)
C_LONGINT:C283(<>ve_StatCoordinateurC)
C_LONGINT:C283(<>ve_StatDirection)
C_LONGINT:C283(<>ve_StatDirectionC)
C_LONGINT:C283(<>ve_StatEtude)
C_LONGINT:C283(<>ve_StatEtudeS)

C_LONGINT:C283(<>ve_StatSpécific)
C_LONGINT:C283(<>ve_StatDASS)
C_LONGINT:C283(<>ve_StatCentre)
C_LONGINT:C283(<>ve_StatGroupe)
C_LONGINT:C283(<>ve_StatEMA)
C_LONGINT:C283(<>ve_StatFicheSociale)
C_LONGINT:C283(<>ve_StatFicheSocialeEt)
C_LONGINT:C283(<>ve_StatMaraude)
C_LONGINT:C283(<>ve_StatGraphe)
C_LONGINT:C283(<>ve_StatCentreOccup)

<>ve_StatCoordinateur:=-2
<>ve_StatCoordinateurS:=-8
<>ve_StatCoordinateurC:=-15
<>ve_StatDirection:=-3
<>ve_StatDirectionC:=-16
<>ve_StatEtude:=-4

<>ve_StatSpécific:=-5
<>ve_StatDASS:=-6
<>ve_StatCentre:=-10
<>ve_StatGroupe:=-14
<>ve_StatEMA:=-9
<>ve_StatFicheSociale:=-12
<>ve_StatMaraude:=-11
<>ve_StatGraphe:=-17
<>ve_StatCentreOccup:=-19
<>ve_StatMaraudeEt:=-18
<>ve_StatFicheSocialeEt:=-7


C_LONGINT:C283(<>ve_ParamNum)
<>ve_ParamNum:=-23

C_BOOLEAN:C305(<>vb_ParamNum)
<>vb_ParamNum:=False:C215

C_TEXT:C284(<>va_ParamNum)
<>va_ParamNum:=""

C_DATE:C307(<>vd_ParamNum)
<>vd_ParamNum:=!00-00-00!

C_TIME:C306(<>vh_ParamNum)
<>vh_ParamNum:=?00:00:00?

//Centre Loft
C_LONGINT:C283(<>vl_LOFTCtrRéf)
C_TEXT:C284(<>va_LOFTCtrNom)
C_TEXT:C284(<>va_LOFTCtrCP)
C_TEXT:C284(<>va_LOFTCtrPlateF)
C_LONGINT:C283(<>vl_LOFTCtrMéd)
C_BOOLEAN:C305(<>vb_LOFTCtrMéd)

DébutInitLoft(0)

//Centre Pointage
C_LONGINT:C283(<>vl_PointeCtrRéf)
C_TEXT:C284(<>va_PointeCtrNom)
C_TEXT:C284(<>va_PointeCtrCP)
C_TEXT:C284(<>va_PointeCtrPlateF)
C_LONGINT:C283(<>vl_PointeCtrMéd)
C_BOOLEAN:C305(<>vb_PointeCtrMéd)
C_TEXT:C284(<>va_PointeFMGroupe)

DébutInitPointage(0)

//Website
C_DATE:C307(<>vd_ws_Date)
C_TIME:C306(<>vh_ws_Période)
C_TEXT:C284(<>vt_ws_Répertoire)
C_TEXT:C284(<>va_ws_NomDocument)
C_TEXT:C284(<>va_ws_Heures)

DébutInitWebsite(0)

C_LONGINT:C283(<>ve_MemoFusion)
<>ve_MemoFusion:=-22

// Variable paramètres du report auto
DebutDecVarParamRepAuto

// DébutInitReportAuto (-1)
DébutInitReportAuto(0)

// 07/11/2008 : Variable paramètres de la conso 115
DebutDecVarParamConso115
DébutInitConso115(0)

P_VarParamConsoVoir(0)

DebutDecVarParamConsoR

DébutInitConsoR(0)
DébutInitConsoClient(0)

// Réservation active
C_BOOLEAN:C305(<>vb_RéservationActive)
<>vb_RéservationActive:=True:C214

C_LONGINT:C283(<>ve_MotPasseLongueur)

// Modifié par : Scanu Rémy - remy@connect-io.fr (20/10/2021)
If ([SOciete:18]SO_MotPasseLongueur:59>0)
	<>ve_MotPasseLongueur:=[SOciete:18]SO_MotPasseLongueur:59
Else 
	<>ve_MotPasseLongueur:=4
End if 

C_LONGINT:C283(<>ve_GenéralQuitter)
<>ve_GenéralQuitter:=0

ARRAY LONGINT:C221(<>tl_HBCheffamille; 0)

C_LONGINT:C283(<>vlSTR_Std)
<>vlSTR_Std:=30101
<>vlSTR_Std_Soc:=(<>vlSTR_Std*1000)+<>ID_Societe_Active

DebutDécVarTrans
DebutInitVarTrans

//C_ALPHA(15;◊Va_CentreCtrl)
C_TEXT:C284(<>Va_CentreCtrl)  //31/10/2008
<>Va_CentreCtrl:=""

C_TEXT:C284(<>va_MessagerieSté)
<>va_MessagerieSté:="Santé"

C_TEXT:C284(<>va_Messagerie115)
<>va_Messagerie115:="115"

C_TEXT:C284(<>va_MessagerieVSM)
<>va_MessagerieVSM:="VSM"

C_TEXT:C284(<>va_MessageAE_HG)
<>va_MessageAE_HG:=""

C_TEXT:C284(<>va_MessageAE_HGRemp)
<>va_MessageAE_HGRemp:="Remplaçant"

C_TEXT:C284(<>va_MessageAE_HGTranfert)
<>va_MessageAE_HGTranfert:="Tranfert"

C_TEXT:C284(<>va_HG_Coordinateur)
<>va_HG_Coordinateur:=""

C_TEXT:C284(<>va_HG_Régulateur)
<>va_HG_Régulateur:=""

DébutInitCoord(0)

DébutInitFam(0)


C_TEXT:C284(<>va_HG_SignalF1)
C_TEXT:C284(<>va_HG_SignalF2)
C_TEXT:C284(<>va_HG_SignalF3)

<>va_HG_SignalF1:=""
<>va_HG_SignalF2:=""
<>va_HG_SignalF3:=""

DébutInitSignal(0)


//C_TEXTE(<>va_CentreEXC)
//C_BOOLÉEN(<>vb_CentreEXC)
//<>va_CentreEXC:="N"
//<>vb_CentreEXC:=Faux

//C_TEXTE(<>va_CentreEXCExc)
//<>va_CentreEXCExc:="N"

//C_BOOLÉEN(<>vb_CentreEXCExc)
//<>vb_CentreEXCExc:=Faux

//C_TEXTE(<>va_CentreEXCSor)
//<>va_CentreEXCExc:="N"

//Plage horaire nuit
C_TIME:C306(<>vh_CentreEXChD)
C_TIME:C306(<>vh_CentreEXChF)
<>vh_CentreEXChD:=?00:00:01?
<>vh_CentreEXChF:=?23:59:59?

C_BOOLEAN:C305(<>vb_CentreEXClits)
<>vb_CentreEXClits:=False:C215

//DébutInitCentreEXC(0)

C_TEXT:C284(<>vt_AppelCheminCarto; <>vt_AppelChemin4DCL; <>vt_AppelAppliCarto)
<>vt_AppelCheminCarto:=""
<>vt_AppelChemin4DCL:=""
<>vt_AppelAppliCarto:=""

<>vt_AppelChemin4DCL:=F_CheminCarto(0; ""; "")

<>vt_AppelCheminCarto:=<>vt_AppelChemin4DCL+"SSPCarto"+(".TXT"*Num:C11(<>vb_CestUnMac=False:C215))
<>vt_AppelAppliCarto:=F_CheminCarto(1; <>vt_AppelCheminCarto; "01")

C_TEXT:C284(<>vt_AppelAppliDocu; <>vt_AppelDocuDocu; <>vt_AppelCheminDocu)

<>vt_AppelCheminDocu:=""
<>vt_AppelAppliDocu:=""
<>vt_AppelDocuDocu:=""

<>vt_AppelCheminDocu:=<>vt_AppelChemin4DCL+"SSPDocu"+(".TXT"*Num:C11(<>vb_CestUnMac=False:C215))

If (<>vb_CestUnMac)
	<>vt_AppelDocuDocu:=F_CheminCarto(5; <>vt_AppelCheminDocu; "02")
Else 
	<>vt_AppelAppliDocu:=F_CheminCarto(5; <>vt_AppelCheminDocu; "02")
	<>vt_AppelDocuDocu:=""
	
	If (<>vt_AppelAppliDocu>"")
		$ii:=Position:C15("<"; <>vt_AppelAppliDocu)
		
		If ($ii>0)
			<>vt_AppelDocuDocu:=Substring:C12(<>vt_AppelAppliDocu; $ii+1)
			<>vt_AppelAppliDocu:=Substring:C12(<>vt_AppelAppliDocu; 1; $ii-1)
		End if 
		
	End if 
	
End if 

C_TEXT:C284(<>vt_Temp)

C_TEXT:C284(<>va_HG_AutreSolStd)
C_TEXT:C284(<>va_HG_AutreSolExc)
C_TEXT:C284(<>va_HG_AutreSolRemp)

DébutInitASol(0)

C_LONGINT:C283(<>vl_CtrRepStdJ; <>vl_CtrRepStdN; <>vl_CtrRepRetJ; <>vl_CtrRepRetN; <>vl_CtrRepSorJ; <>vl_CtrRepSorN; <>vl_CtrRepExcJ; <>vl_CtrRepExcN; <>vl_CtrRepProJ; <>vl_CtrRepProN)

CREATE EMPTY SET:C140([HeberGement:5]; "◊E_HGrep")
CREATE EMPTY SET:C140([HeberGement:5]; "◊E_HGrepP")
CREATE EMPTY SET:C140([HeberGement:5]; "◊E_HGrepS")
CREATE EMPTY SET:C140([HeberGement:5]; "◊E_HGrepE")

C_TEXT:C284(<>va_RADAutresolution)
<>va_RADAutresolution:="RAD Excusée"

C_TEXT:C284(<>va_SADAutresolution)
<>va_SADAutresolution:="SAD Remplaçant"

C_BOOLEAN:C305(<>vb_AvecProlongation)
<>vb_AvecProlongation:=False:C215

C_BOOLEAN:C305(<>vb_ProLg_Prolongation)
C_BOOLEAN:C305(<>vb_ProLg_FinMois)
C_LONGINT:C283(<>ve_ProLg_Le)
C_LONGINT:C283(<>ve_ProLg_MaxMois)

<>vb_ProLg_Prolongation:=False:C215
<>ve_ProLg_Le:=0
<>ve_ProLg_MaxMois:=0

DébutInitProLg(0)


C_DATE:C307(<>vd_PourExcuseDate)
C_LONGINT:C283(<>vl_PourExcuseRéf; <>vl_PourExcuseRéfHB; <>vl_PourExcuseRéfCT)
C_BOOLEAN:C305(<>vd_PourExcuseNuit; <>vd_PourExcuseEnCours)
C_TEXT:C284(<>vt_PourExcuseRemp)

DébutBtMenu(0; "")
DébutBtMenu(1; "")

C_BOOLEAN:C305(<>vb_ParamDisActivée)
C_BOOLEAN:C305(<>vb_ParamDisJour; <>vb_ParamDisNuit)
C_BOOLEAN:C305(<>vb_ParamDisBt)

DébutInitPrDispo(0)

C_TEXT:C284(<>va_BtTitreCentreL)
<>va_BtTitreCentreL:="Consolidation"

ARRAY BOOLEAN:C223(<>tb_D_NuitJour; 0)
ARRAY LONGINT:C221(<>tl_D_HGréf; 0)

ARRAY TEXT:C222(<>ta_Niveau; 4)
ARRAY INTEGER:C220(<>te_Niveau; 4)

For ($ii; 1; 4)
	<>ta_Niveau{$ii}:="Niveau "+String:C10($ii)
	<>te_Niveau{$ii}:=$ii
End for 

C_LONGINT:C283(<>ve_FamH; <>ve_FamF; <>ve_FamFe; <>ve_FamEMi; <>ve_FamEMa; <>ve_FamPMi; <>ve_FamPMa)

C_BOOLEAN:C305(<>vb_EtatCivilAge)
<>vb_EtatCivilAge:=True:C214

C_BOOLEAN:C305(<>vb_FusNote_Notes)
C_DATE:C307(<>vd_FusNote_Date)
<>vb_FusNote_Notes:=False:C215
<>vd_FusNote_Date:=!00-00-00!

DébutInitFusNote(0)

C_LONGINT:C283(<>ve_Coordination)
<>ve_Coordination:=-24

C_TEXT:C284(<>va_PrestType1; <>va_PrestType2; <>va_PrestType3)
<>va_PrestType1:="115"
<>va_PrestType2:="MR"
<>va_PrestType3:="DS"

C_TEXT:C284(<>vt_TransHisto)
C_LONGINT:C283(<>vl_NbEtoilesTrait)
<>vl_NbEtoilesTrait:=73

C_TEXT:C284(<>vt_LienGPS)
C_BOOLEAN:C305(<>vb_FondCouleur)
<>vb_FondCouleur:=False:C215

C_BOOLEAN:C305(<>vb_MaxFichesHG)
C_LONGINT:C283(<>vl_MaxFichesHG_J; <>vl_MaxFichesHG_N; <>vl_MaxFichesHG)

DébutInitMaxFiche(0)

//C_TEXTE(<>va_DossierAttestations; 4)
//<>va_DossierAttestations:="Attestations"

C_DATE:C307(<>vd_RAP_Date; <>vd_RAP_Jusque; <>vd_RAP_Départ; <>vd_RAP_Base)
C_LONGINT:C283(<>vl_RAP_Jours)
C_BOOLEAN:C305(<>vb_RAP_CréerDispo)
<>vb_RAP_CréerDispo:=False:C215

C_BOOLEAN:C305(<>vb_FullDuplexDataB)
<>vb_FullDuplexDataB:=False:C215

DebutInitTabConso(0; 0)

//Variables compteur du report
C_LONGINT:C283(<>vl_RepOK)
C_LONGINT:C283(<>vl_RepR)  //Reporté (◊va_RepR:="R")
C_LONGINT:C283(<>vl_RepRE)  //Reporté mais excusé et non clôturé (◊va_RepRE:="RE")
C_LONGINT:C283(<>vl_RepRP)  //Reporté par prolongation la première fois (◊va_RepRP:="RP")
C_LONGINT:C283(<>vl_RepF)  //Fin (◊va_RepF:="F")
C_LONGINT:C283(<>vl_RepA)  //Absence (◊va_RepA:="A")
C_LONGINT:C283(<>vl_RepO)  //O Réorienté (◊va_RepO:="O")
C_LONGINT:C283(<>vl_RepE)  //Report effectué  (◊va_RepE:="")

<>vl_RepOK:=0
<>vl_RepR:=0
<>vl_RepRE:=0
<>vl_RepRP:=0
<>vl_RepF:=0
<>vl_RepA:=0
<>vl_RepO:=0
<>vl_RepE:=0

C_LONGINT:C283(<>LeGraphe)

C_TEXT:C284(<>va_LibScénario)
<>va_LibScénario:="Scénar1"

C_PICTURE:C286(<>vi_Graphe1)
C_PICTURE:C286(<>vi_Graphe2)
C_PICTURE:C286(<>vi_Graphe3)

ARRAY TEXT:C222(<>ta_LesMois; 14)
<>ta_LesMois{1}:="Janvier"
<>ta_LesMois{2}:="Février"
<>ta_LesMois{3}:="Mars"
<>ta_LesMois{4}:="Avril"
<>ta_LesMois{5}:="Mai"
<>ta_LesMois{6}:="Juin"
<>ta_LesMois{7}:="Juillet"
<>ta_LesMois{8}:="Août"
<>ta_LesMois{9}:="Septembre"
<>ta_LesMois{10}:="Octobre"
<>ta_LesMois{11}:="Novembre"
<>ta_LesMois{12}:="Décembre"
<>ta_LesMois{13}:="-"
<>ta_LesMois{14}:="Aucun"

//Compteurs Cohabitation
C_TEXT:C284(<>vaCPT_Cohabitation)
<>vaCPT_Cohabitation:=""

ARRAY TEXT:C222(<>ta_Cohabitation; 2)
<>ta_Cohabitation{1}:="Cohab. difficile (Z01)"
<>ta_Cohabitation{2}:="Fermeture tech. (Z02)"

<>ta_Cohabitation:=1

C_POINTER:C301(<>vp_PointeurMois)
C_POINTER:C301(<>vp_PointeurMoisX)
C_POINTER:C301(<>vp_PointeurTranche)

ARRAY TEXT:C222(<>ta_LesTranches; 0)
ARRAY INTEGER:C220(<>te_LesTranches; 0)

C_BOOLEAN:C305(<>vb_Sortants)
<>vb_Sortants:=False:C215

C_LONGINT:C283(<>vl_RéfSortants)
<>vl_RéfSortants:=0

DebutParamMail(0; 0)
DebutParamMail(1; 0)

C_TEXT:C284(<>vt_TexteRegional_ST; <>vt_TexteRegional_HG; <>vt_TexteRegional_HB; <>vt_TexteRegional_LC)
C_BOOLEAN:C305(<>vb_REPORT_DOUBLONS)
<>vb_REPORT_DOUBLONS:=True:C214


//19/7/2010
C_TEXT:C284(<>va_TransfertRegional)
<>va_TransfertRegional:="Dernière date de transfert régional"

READ WRITE:C146([ReferenceUnique:2])

QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=<>va_TransfertRegional)
MultiSoc_Filter(->[ReferenceUnique:2])

If (Records in selection:C76([ReferenceUnique:2])=0)
	CREATE RECORD:C68([ReferenceUnique:2])  //C'est la première fiche 
	MultiSoc_Init_Structure(->[ReferenceUnique:2])
	
	[ReferenceUnique:2]RU_Fichier:2:=<>va_TransfertRegional
	[ReferenceUnique:2]RU_Numero:3:=1
	[ReferenceUnique:2]RU_ValeurApha:4:=""
	SAVE RECORD:C53([ReferenceUnique:2])
	
	UNLOAD RECORD:C212([ReferenceUnique:2])
End if 

UNLOAD RECORD:C212([ReferenceUnique:2])
READ ONLY:C145([ReferenceUnique:2])

//7/10/2010
C_BOOLEAN:C305(<>vb_TransVeille)
C_TEXT:C284(<>va_TransVeille_Message)
C_TEXT:C284(<>va_TransVeille_Item)
C_TEXT:C284(<>va_TransVeille_Valeur)
C_DATE:C307(<>vd_TransVeille_Date)
<>vb_TransVeille:=False:C215

//3/11/2010
C_BOOLEAN:C305(<>vb_TransfertRegional_Fin)
<>vb_TransfertRegional_Fin:=False:C215

C_TEXT:C284(<>va_TransfertRegional_Action)
<>va_TransfertRegional_Action:=""

C_TEXT:C284(<>va_TransfertRegional_Action0; <>va_TransfertRegional_Action1; <>va_TransfertRegional_Action2; <>va_TransfertRegional_Action3)
<>va_TransfertRegional_Action0:="Thermo init"
<>va_TransfertRegional_Action1:="Thermo"
<>va_TransfertRegional_Action2:="Etat"
<>va_TransfertRegional_Action3:="Etat Endormi"

C_TEXT:C284(<>vt_SIAO_Texte; <>vt_SIAO_Transfert)
C_POINTER:C301(<>vp_SIAO_PointeurVide; <>vp_SIAO_PointeurTemp)

//13/4/2011
C_TEXT:C284(<>va_Log_Entree; <>va_Log_Sortie; <>va_Log_Hebergement; <>va_Log_SIAO)

<>va_Log_Entree:="I"
<>va_Log_Sortie:="O"
<>va_Log_Hebergement:="H"
<>va_Log_SIAO:="S"

ARRAY TEXT:C222(<>tt_Block; 0)

C_LONGINT:C283(<>vl_T_SIAO_IU)  //6/6/2011
C_BOOLEAN:C305(<>vb_SIAO_SaisieDans)  //21/6/2011
<>vb_SIAO_SaisieDans:=False:C215

C_TEXT:C284(<>vt_CNIL_ChampLibre)

<>vt_CNIL_ChampLibre:="Seules doivent être saisies les informations susceptibles d'être "
<>vt_CNIL_ChampLibre:=<>vt_CNIL_ChampLibre+"pertinentes au regard du contexte. "
<>vt_CNIL_ChampLibre:=<>vt_CNIL_ChampLibre+"Elles ne doivent pas comporter d'appréciations subjectives, ni faire apparaître,"
<>vt_CNIL_ChampLibre:=<>vt_CNIL_ChampLibre+" directement ou indirectement, les origines raciales, les opinions politiques,"
<>vt_CNIL_ChampLibre:=<>vt_CNIL_ChampLibre+" philosophiques ou religieuses, les appartenances syndicales ou les moeurs"
<>vt_CNIL_ChampLibre:=<>vt_CNIL_ChampLibre+"  de la personne concernée."

C_TEXT:C284(<>va_RG_Dept)  //6/12/2011 Import region du Dept
<>va_RG_Dept:=""

DébutInitBDOS

C_TEXT:C284(<>va_HG_SIAODossier)
<>va_HG_SIAODossier:=""

C_TEXT:C284(<>va_HG_SIAOPrescripteur)
<>va_HG_SIAOPrescripteur:=""

DébutInitHgSiao(0)

C_TEXT:C284(<>vt_SiaoHgTips_103; <>vt_SiaoHgTips_104; <>vt_SiaoHgTips_156; <>vt_SiaoHgTips_157; <>vt_SiaoHgTips_158; <>vt_SiaoHgTips_159)
C_TEXT:C284(<>vt_SiaoHgTips_160; <>vt_SiaoHgTips_161; <>vt_SiaoHgTips_162; <>vt_SiaoHgTips_163; <>vt_SiaoHgTips_164; <>vt_SiaoHgTips_165; <>vt_SiaoHgTips_166; <>vt_SiaoHgTips_167)

<>vt_SiaoHgTips_103:=xliff_Get_text_resource(30202)  // Chef de famille
<>vt_SiaoHgTips_104:=xliff_Get_text_resource(30203)  // Clé de lien
<>vt_SiaoHgTips_156:=xliff_Get_text_resource(30204)  // Priorité DAHO
<>vt_SiaoHgTips_157:=xliff_Get_text_resource(30206)  // Violence
<>vt_SiaoHgTips_158:=xliff_Get_text_resource(30205)  // Capacité d'acccès
<>vt_SiaoHgTips_159:=xliff_Get_text_resource(30208)  // Logement autonome

<>vt_SiaoHgTips_160:=xliff_Get_text_resource(30209)  // Logement souhaité
<>vt_SiaoHgTips_161:=xliff_Get_text_resource(30207)  // Orientation correspondante
<>vt_SiaoHgTips_162:=xliff_Get_text_resource(30211)  // Refus par structure
<>vt_SiaoHgTips_163:=xliff_Get_text_resource(30210)  // Refus par demandeur
<>vt_SiaoHgTips_164:=xliff_Get_text_resource(30201)  // Orientation Dossier SIAO
<>vt_SiaoHgTips_165:=""
<>vt_SiaoHgTips_166:=xliff_Get_text_resource(30212)  // Type de prescripteur
<>vt_SiaoHgTips_167:=""

C_TEXT:C284(<>vt_SiaoQuoi_1; <>vt_SiaoQuoi_2; <>vt_SiaoQuoi_3)
<>vt_SiaoQuoi_1:=<>vt_SiaoHgTips_103
<>vt_SiaoQuoi_2:=<>vt_SiaoHgTips_104
<>vt_SiaoQuoi_3:=<>vt_SiaoHgTips_164

C_TEXT:C284(<>vt_HG_SiaoNo)
<>vt_HG_SiaoNo:=""

C_TEXT:C284(<>va_LeNoFAM)
<>va_LeNoFAM:=""

DebutDecVarConsoTransfert
DebutInitConsoTranfert(0)