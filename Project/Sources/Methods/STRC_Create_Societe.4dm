//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 31/08/2020, 11:58:33
// ----------------------------------------------------
// Method: STRC_Create_Societe
// Description
// 
//
// Parameters
// ----------------------------------------------------
READ WRITE:C146([SOciete:18])
READ WRITE:C146([Structures:79])

CREATE RECORD:C68([SOciete:18])
[SOciete:18]SO_ReferenceID:1:=1
[SOciete:18]Ref_Structure:97:="TMP"
[SOciete:18]SO_Libel00:2:="Temp"
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
[SOciete:18]SO_Ongletnote_6:93:=<>va_T_Onglet6Note
[SOciete:18]SO_Ongletnote_7:95:=<>va_T_Onglet7Note
[SOciete:18]SO_OngletNote_8:122:=<>va_T_Onglet8Note
[SOciete:18]SO_OngletNote_9:123:=<>va_T_Onglet9Note
[SOciete:18]SO_OngletNote_10:124:=<>va_T_Onglet10Note

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

[SOciete:18]SO_ConsoRégion_Mode:46:=<>ve_ConsoRegion_Mode
[SOciete:18]SO_ConsoRégion_DosPour115:47:=<>vt_ConsoRegion_Dosssier
[SOciete:18]SO_ConsoRégion_DosPourRégion:48:=<>vt_ConsoRegion_DosPourRegion

[SOciete:18]SO_AQuelleHeureTombeLaNuit:49:=<>vh_T_HeureNuit

[SOciete:18]SO_Departement:50:=<>va_T_Departement

[SOciete:18]SO_DitribSansDecimale:51:=<>vb_T_DitribSansDecimale

[SOciete:18]SO_CheminRégion:52:=<>vt_CheminRégion
[SOciete:18]SO_DossierRégion:53:=<>vt_DossierRégion

[SOciete:18]SO_Lettre:54:=<>va_T_Lettre

[SOciete:18]SO_CinqCentDix:56:=<>vb_T_Version510

[SOciete:18]SO_SIAOSynchroHG:57:=<>vb_T_SIAOsynchroHG
[SOciete:18]SO_SIAOSynchroHGBT:58:=<>vb_T_SIAOsynchroHGBT

[SOciete:18]SO_MotPasseLongueur:59:=<>vl_T_MPLongueur
[SOciete:18]SO_MotPasseJoursValide:60:=<>vl_T_MPJoursValide

[SOciete:18]SO_MasquerCritCentres:61:=<>vb_T_CentreCritMasquer

[SOciete:18]SO_MasquerPresta:62:=<>vb_T_PrestaMasquer
[SOciete:18]SO_CtrlNation:63:=<>vb_T_CtrlNation

[SOciete:18]SO_MotPasseMaquePlus:64:=<>vb_T_MPMasquePlus
[SOciete:18]SO_LogActif:65:=<>vb_T_LogActif

[SOciete:18]SO_Prestation:66:=<>vb_T_Prestations
[SOciete:18]SO_PrestationChemin:67:=<>vb_T_PrestationsChemin
[SOciete:18]SO_PrestationDossier:68:=<>vb_T_PrestationsDossier

[SOciete:18]SO_Fiche115:69:=<>vb_T_Fiches115
[SOciete:18]SO_SIAO:70:=<>vl_T_SIAOType
[SOciete:18]SO_Signalement:71:=<>va_T_HBsignal
[SOciete:18]SO_ColonneOrienter:72:=<>ve_T_ColonneOrienter

[SOciete:18]SO_CodePostal:75:=<>va_T_CodePostal
[SOciete:18]SO_Ville:76:=<>va_T_Ville
[SOciete:18]SO_TerritoireCode:77:=<>va_T_TerritoireCode
[SOciete:18]SO_TerritoireLibelle:78:=<>va_T_TerritoireLibelle
[SOciete:18]SO_DeptLibelle:79:=<>va_T_DepartementLibelle
[SOciete:18]SO_RegionCode:80:=<>va_T_RegionCode
[SOciete:18]SO_RegionLibelle:81:=<>va_T_RegionLibelle
[SOciete:18]SO_INSEEcode:82:=<>va_T_InseeCode

[SOciete:18]SO_DossierSIAO:83:=<>vb_T_DosSIAO
[SOciete:18]SO_CentreSIAOPrestation:84:=<>va_T_CentreSIAOPrestation

[SOciete:18]SO_Refus_CHRS:85:=<>va_T_RefusCHRS
[SOciete:18]SO_Refus_Demandeur:86:=<>va_T_RefusDEMANDEUR
[SOciete:18]SO_Refus_AFFECTE:87:=<>va_T_RefusAFFECTE

[SOciete:18]SO_ErrorJours:88:=<>vl_T_ErrorJours
[SOciete:18]SO_CheminRepertoireDistant:89:=<>vt_T_CheminSO_CheminRepDistant
[SOciete:18]SO_CheminBoite:90:=<>vt_T_CheminBoite
[SOciete:18]SO_PlateformeMod:91:=<>vb_T_PlateformeMod

QUERY:C277([Structures:79]; [Structures:79]STRC_Societe_ID:6=[SOciete:18]ID:94)

If (Records in selection:C76([Structures:79])=0)
	CREATE RECORD:C68([Structures:79])
	[Structures:79]UID:1:=Generate UUID:C1066
	[Structures:79]STRC_Societe_ID:6:=[SOciete:18]ID:94
	[Structures:79]Ref_Structure:3:=[SOciete:18]Ref_Structure:97
	[Structures:79]STRC_Initiales:2:=[SOciete:18]Ref_Structure:97
	[Structures:79]STRC_Nom:4:=[SOciete:18]SO_Libel00:2
End if 