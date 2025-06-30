//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : DebutDecVarParam
//{
//{          Mercredi 10 décembre 2008 à 15:18
//{          Modifiée : 31 octobre 2008 à 15:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}  
//Mode de Gestion
C_LONGINT:C283(<>ve_Si_ModeCHRS)
<>ve_Si_ModeCHRS:=0

C_TEXT:C284(<>va_T_Site)  //Code du site
<>va_T_Site:=""

C_TEXT:C284(<>va_T_00)  //Titre  : SAMU SOCIAL DE PARIS
C_TEXT:C284(<>va_T_01)  //Titre  : SAMU SOCIAL DE PARIS
C_TEXT:C284(<>va_T_02)  //Nom suite  : Groupement d'intérêt public - Arrété du 19 décembre 1994
C_TEXT:C284(<>va_T_03)  //Adresse :35, avenue de Courteline - 75012 Paris - Tél 43 88 38 18 - Fax 43 98 39
C_TEXT:C284(<>va_T_04)  // Administration : 2-4, rue Saint-Martin - 75004 Paris - Tél 40 27 42 21 - Fax 40
C_TEXT:C284(<>va_T_05)  //CCP 0921738 V PARIS
C_TEXT:C284(<>vt_T_CheminRép)
C_TEXT:C284(<>vt_T_CheminRépServeur)
C_TEXT:C284(<>vt_T_CheminRépDalo)
C_TEXT:C284(<>vt_T_DossierRep)
C_BOOLEAN:C305(<>vb_T_BoiteLettres)
C_BOOLEAN:C305(<>vb_T_BoiteDalo)
C_LONGINT:C283(<>vl_T_ColorCadreH)
C_LONGINT:C283(<>vl_T_ColorCadreC)
C_LONGINT:C283(<>vl_T_ColorCadreB)
C_BOOLEAN:C305(<>vb_T_ModeCHRS)
C_BOOLEAN:C305(<>vb_T_Ecran115)
C_BOOLEAN:C305(<>vb_T_MasqueETCV)
C_BOOLEAN:C305(<>vb_T_Cryptage)
C_BOOLEAN:C305(<>vb_T_TransTransfert)
C_BOOLEAN:C305(<>vb_T_FullDuplex)
C_LONGINT:C283(<>ve_T_CentreCode)
C_LONGINT:C283(<>vl_T_CentreCodeDebut; <>vl_T_CentreCodeFin)
C_BOOLEAN:C305(<>vb_T_EcranGrand)
C_BOOLEAN:C305(<>vb_T_Windows)

C_BOOLEAN:C305(<>vb_T_SansPrestations)
C_LONGINT:C283(<>ve_Quel_MasqueETCV)

C_LONGINT:C283(<>vl_T_JourSortant)  //28/4/2010

<>va_T_00:="PAXTEL"
<>va_T_01:="PAXTEL"
<>va_T_02:=""
<>va_T_03:=""
<>va_T_04:=""
<>va_T_05:=""
<>vt_T_CheminRép:=""
<>vt_T_CheminRépServeur:=""
<>vt_T_CheminRépDalo:=""
<>vt_T_DossierRep:=""
<>vb_T_BoiteLettres:=False:C215
<>vb_T_BoiteDalo:=False:C215
<>vl_T_ColorCadreH:=0  //Haut : Blanc
<>vl_T_ColorCadreC:=61691  //Centre : Gris tres clair
<>vl_T_ColorCadreB:=3072  //Bas : Gris  clair
<>vb_T_ModeCHRS:=False:C215
<>vb_T_Ecran115:=False:C215
<>vb_T_MasqueETCV:=False:C215
<>vb_T_Cryptage:=False:C215
<>vb_T_TransTransfert:=False:C215
<>vb_T_FullDuplex:=False:C215
<>ve_T_CentreCode:=0

<>vb_T_EcranGrand:=True:C214
<>vb_T_Windows:=False:C215

<>vb_T_SansPrestations:=False:C215
<>ve_Quel_MasqueETCV:=0
<>vl_T_JourSortant:=3

//Pour le boîte aux lettres
C_TEXT:C284(<>va_T_QuelleBoiteLettres)
C_TEXT:C284(<>va_T_LaBoiteLettres; <>va_T_LaBoiteDalo)

<>va_T_QuelleBoiteLettres:=""
<>va_T_LaBoiteLettres:="BoîteAuxLettres"
<>va_T_LaBoiteDalo:="BoîteDalo"

C_BOOLEAN:C305(<>vb_T_OccupMinuteur)
C_LONGINT:C283(<>vl_T_OccupMinuteurTicks)
C_BOOLEAN:C305(<>vb_T_OccupMinuteurMess)

<>vb_T_OccupMinuteur:=False:C215
<>vl_T_OccupMinuteurTicks:=3600*5
<>vb_T_OccupMinuteurMess:=False:C215


C_TEXT:C284(<>va_T_Onglet3Note; <>va_T_Onglet4Note; <>va_T_Onglet5Note; <>va_T_Ongle6Note; <>va_T_Onglet7Note; <>va_T_Onglet8Note; <>va_T_Onglet9Note; <>va_T_Onglet10Note)

<>va_T_Onglet3Note:="Note 2"
<>va_T_Onglet4Note:="Note 3"
<>va_T_Onglet5Note:="Note 4"
<>va_T_Onglet6Note:="Note 6"  //#20180509-1
<>va_T_Onglet7Note:="Note 7"  //#20180509-1
<>va_T_Onglet8Note:="Maraude"
<>va_T_Onglet9Note:="Maraude2"
<>va_T_Onglet10Note:="FVV"

C_TEXT:C284(<>va_T_PièceNéOu; <>va_T_PièceNationalité; <>va_T_PièceCNI; <>va_T_PiècePasseport)
<>va_T_PièceNéOu:="Lieu de naissance"
<>va_T_PièceNationalité:="Nationalité"
<>va_T_PièceCNI:="C.N.I."
<>va_T_PiècePasseport:="Passeport"

C_BOOLEAN:C305(<>vb_T_RéfHébergé)  //29/9/2009
<>vb_T_RéfHébergé:=False:C215

C_BOOLEAN:C305(<>vb_T_CryptageHébergé)  //29/9/2009
<>vb_T_CryptageHébergé:=False:C215

C_LONGINT:C283(<>vl_T_CryptageHébergéJour)
<>vl_T_CryptageHébergéJour:=10

C_BOOLEAN:C305(<>vb_T_CalcTroisEnfants)  //5/1/2010
<>vb_T_CalcTroisEnfants:=False:C215

C_BOOLEAN:C305(<>vb_T_ImprimerAction)  //22/02/2010
<>vb_T_ImprimerAction:=False:C215

C_BOOLEAN:C305(<>vb_T_NoteNonModifiables)  //14/6/2010
<>vb_T_NoteNonModifiables:=False:C215

C_BOOLEAN:C305(<>vb_T_NoteMARNonModifiables)  //14/6/2010
<>vb_T_NoteMARNonModifiables:=False:C215

C_LONGINT:C283(<>ve_ConsoRegion_Mode)  //3/11/2010 
C_TEXT:C284(<>vt_ConsoRegion_Dosssier)  //3/11/2010 
C_TEXT:C284(<>vt_ConsoRegion_DosPourRegion)  //3/11/2010 

<>ve_ConsoRegion_Mode:=0
<>vt_ConsoRegion_Dosssier:=""
<>vt_ConsoRegion_DosPourRegion:=""

ARRAY TEXT:C222(<>tt_T_CheminsRegionaux; 0)  //19/7/2010

C_TEXT:C284(<>vt_CheminRégion)  //28/01/2011 
C_TEXT:C284(<>vt_DossierRégion)  //28/01/2011 
<>vt_CheminRégion:=""
<>vt_DossierRégion:=""

C_TIME:C306(<>vh_T_HeureNuit)  //6/10/2010
<>vh_T_HeureNuit:=?20:00:00?

C_TEXT:C284(<>va_T_Departement)
<>va_T_Departement:=""

C_TEXT:C284(<>va_T_Lettre)
<>va_T_Lettre:=""

C_TEXT:C284(<>va_T_NA1)
<>va_T_NA1:=""

C_BOOLEAN:C305(<>vb_T_DitribSansDecimale)
<>vb_T_DitribSansDecimale:=False:C215

C_BOOLEAN:C305(<>vb_T_SIAO_Insertion)
<>vb_T_SIAO_Insertion:=True:C214

C_BOOLEAN:C305(<>vb_T_Version510)
<>vb_T_Version510:=False:C215

C_BOOLEAN:C305(<>vb_T_SIAOsynchroHG; <>vb_T_SIAOsynchroHGBT)
<>vb_T_SIAOsynchroHG:=False:C215
<>vb_T_SIAOsynchroHGBT:=False:C215

C_LONGINT:C283(<>vl_T_MPLongueur; <>vl_T_MPJoursValide)  //28/3/2011
<>vl_T_MPLongueur:=4
<>vl_T_MPJoursValide:=365

C_BOOLEAN:C305(<>vb_T_CentreCritMasquer)  //28/3/2011
<>vb_T_CentreCritMasquer:=False:C215

C_BOOLEAN:C305(<>vb_T_PrestaMasquer)  //28/3/2011
<>vb_T_PrestaMasquer:=False:C215

C_BOOLEAN:C305(<>vb_T_CtrlNation)  //29/3/2011
<>vb_T_CtrlNation:=False:C215

C_BOOLEAN:C305(<>vb_T_MPMasquePlus)  //6/4/2011
<>vb_T_MPMasquePlus:=False:C215

C_BOOLEAN:C305(<>vb_T_LogActif)  //13/4/2011
<>vb_T_LogActif:=False:C215

C_BOOLEAN:C305(<>vb_T_Prestations)  //29/4/2011
C_TEXT:C284(<>vb_T_PrestationsChemin)  //29/4/2011
C_TEXT:C284(<>vb_T_PrestationsDossier)  //29/4/2011
<>vb_T_Prestations:=False:C215
<>vb_T_PrestationsChemin:=""
<>vb_T_PrestationsDossier:=""

C_BOOLEAN:C305(<>vb_T_Fiches115)  //25/5/2011
<>vb_T_Fiches115:=False:C215

C_LONGINT:C283(<>vl_T_SIAOType)
<>vl_T_SIAOType:=3

C_TEXT:C284(<>va_T_HBsignal)  //21/6/2011
<>va_T_HBsignal:=""
C_LONGINT:C283(<>ve_T_ColonneOrienter)  //26/7/2011
<>ve_T_ColonneOrienter:=1

C_LONGINT:C283(<>ve_T_CNILMessage)  //29/7/2011
<>ve_T_CNILMessage:=1

C_TEXT:C284(<>va_T_CodePostal)  //25/11/2011
<>va_T_CodePostal:=""

C_TEXT:C284(<>va_T_Ville)  //25/11/2011
<>va_T_Ville:=""

C_TEXT:C284(<>va_T_TerritoireCode)  //25/11/2011
<>va_T_TerritoireCode:=""

C_TEXT:C284(<>va_T_TerritoireLibelle)  //25/11/2011
<>va_T_TerritoireLibelle:=""

C_TEXT:C284(<>va_T_DepartementLibelle)  //25/11/2011
<>va_T_DepartementLibelle:=""

C_TEXT:C284(<>va_T_RegionCode)  //25/11/2011
<>va_T_RegionCode:=""
C_TEXT:C284(<>va_T_RegionLibelle)  //25/11/2011
<>va_T_RegionLibelle:=""

C_BOOLEAN:C305(<>vb_T_DosSIAO)  //13/12/2011
<>vb_T_DosSIAO:=False:C215

C_TEXT:C284(<>va_T_CentreSIAOPrestation)  //26/1/2012
<>va_T_CentreSIAOPrestation:=""

C_TEXT:C284(<>va_T_RefusCHRS; <>va_T_RefusDEMANDEUR; <>va_T_RefusAFFECTE)  //08/2/2012
<>va_T_RefusCHRS:=""
<>va_T_RefusDEMANDEUR:=""
<>va_T_RefusAFFECTE:=""

C_LONGINT:C283(<>vl_T_ErrorJours)  //09/5/2012
<>vl_T_ErrorJours:=7

C_TEXT:C284(<>vt_T_CheminSO_CheminRepDistant)
<>vt_T_CheminSO_CheminRepDistant:=""

C_TEXT:C284(<>vt_T_CheminBoite)
<>vt_T_CheminBoite:=""

C_BOOLEAN:C305(<>vb_T_PlateformeMod)  //06/06/2011
<>vb_T_PlateformeMod:=False:C215