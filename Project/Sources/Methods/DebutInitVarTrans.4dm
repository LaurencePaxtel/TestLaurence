//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DebutInitVarTrans  
//{          Initialisation des variable superglobales suite
//{          Jeudi 3 juin 2004 à 16:14:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//[DossierSocial]DS_Référence : unique
<>vd_VueLe:=!00-00-00!

<>va_Responsable:=""
<>va_Opérateur:=""
<>va_Assistante:=""
<>va_EMA:=""

<>vb_Enfants:=False:C215
<>ve_EnfantsNb:=0
//ici sous fiches enfants
ARRAY TEXT:C222(<>ta_EnfantNom; 0)
ARRAY TEXT:C222(<>ta_EnfantPrénom; 0)
ARRAY DATE:C224(<>td_EnfantNeLe; 0)
ARRAY INTEGER:C220(<>te_EnfantAge; 0)
ARRAY BOOLEAN:C223(<>tb_EnfantGenre; 0)
ARRAY TEXT:C222(<>ta_EnfantLieu; 0)
ARRAY TEXT:C222(<>ta_EnfantAdr1; 0)
ARRAY TEXT:C222(<>ta_EnfantAdr2; 0)
ARRAY TEXT:C222(<>ta_EnfantCP; 0)
ARRAY TEXT:C222(<>ta_EnfantVille; 0)


<>va_NeOu:=""
<>va_Conjoint:=""
<>va_Nationalité:=""
<>va_Langue:=""
<>va_Langue1:=""
<>va_Langue2:=""
<>va_Langue3:=""
<>va_PersMajeur:=""
<>va_EMAEnCharge:=""
<>va_EMARefus:=""
<>va_LastHébergt:=""
<>va_LastHébergt1:=""
<>va_LastHébergt2:=""

<>va_Signalt:=""
<>va_SignaltSuite:=""
<>va_Emplace1:=""
<>va_Emplace2:=""
<>va_ArrondCP:=""
<>va_EtatCivil:=""
<>va_Demande:=""
<>va_EtatGénéral:=""
<>va_EtatCutané:=""
<>va_Relation:=""
<>va_Hygiène:=""
<>va_Handicap:=""

<>va_Motif:=""
<>va_MotifDétail:=""

<>vb_QuestOrMéd:=False:C215

<>va_OrMéd1:=""
<>va_OrMéd2:=""

<>vb_QuestOrSocial:=False:C215

<>va_OrSocial1:=""
<>va_OrSocial2:=""

<>vb_FicheSociale:=False:C215
<>vb_FichePsycho:=False:C215
<>vb_FicheInfirmiere:=False:C215
<>vb_FicheVerrouillée:=False:C215
<>vb_QuestDemHB:=False:C215

<>va_EtatMatrimo:=""
<>va_HébergAd1:=""
<>va_HébergAd2:=""
<>va_HébergAd3:=""
<>va_Mode1:=""
<>va_Mode2:=""
<>va_TempsErr:=""
<>va_Connaissance:=""
<>va_Compagnie1:=""
<>va_Compagnie2:=""
<>va_SSPConnu:=""
<>va_SSPPremière:=""
<>va_DerAdr1:=""
<>va_DerAdr2:=""
<>va_DerAdr3:=""
<>va_SecoursAdr1:=""
<>va_SecoursAdr2:=""
<>va_SecoursAdr3:=""

<>vb_QuestPapier:=False:C215
<>va_Papier1:=""
<>va_Papier2:=""

<>vb_QuestCouvSoc:=False:C215
<>va_CouvSoc1_1:=""
<>va_CouvSoc1_2:=""
<>va_CouvSoc2_1:=""
<>va_CouvSoc2_2:=""
<>va_CouvSoc3_1:=""
<>va_CouvSoc3_2:=""

<>vb_QuestRessource:=False:C215
<>va_Ressource1_1:=""
<>va_Ressource1_2:=""
<>va_Ressource2_1:=""
<>va_Ressource2_2:=""
<>va_Ressource3_1:=""
<>va_Ressource3_2:=""

<>vb_Référents:=False:C215
//ici sous fiches référents
ARRAY TEXT:C222(<>ta_RéfCatégorie; 0)
ARRAY TEXT:C222(<>ta_RéfNom; 0)
ARRAY TEXT:C222(<>ta_RéfAdr1; 0)
ARRAY TEXT:C222(<>ta_RéfAdr2; 0)
ARRAY TEXT:C222(<>ta_RéfCP; 0)
ARRAY TEXT:C222(<>ta_RéfVille; 0)
ARRAY TEXT:C222(<>ta_RéfTél; 0)

<>vb_QuestRégime:=False:C215
<>va_Régime1:=""
<>va_Régime2:=""

<>vb_QuestSuiviS:=False:C215
<>va_SuiviS1:=""
<>va_SuiviS2:=""

<>vb_QuestSortie:=False:C215
<>va_SortieCtr1:=""
<>va_SortieCtr2:=""

<>vb_Vérrouillé:=False:C215
<>vb_EnfantsScolarisés:=False:C215

//Les données 
C_TEXT:C284(<>va_Trans_EtCv)
C_TEXT:C284(<>va_Trans_Cle; <>va_Trans_CleAccept)
C_TEXT:C284(<>va_Trans_Nom)
C_TEXT:C284(<>va_Trans_Prenom)
C_DATE:C307(<>vd_Trans_Nele)
C_TEXT:C284(<>vt_Trans_DocuT)
<>va_Trans_Cle:=""

C_TEXT:C284(<>vt_Trans_Infos)
C_BOOLEAN:C305(<>vb_Trans_FicheYaDéja)
C_DATE:C307(<>vd_Trans_FicheDate; <>vd_Trans_FicheDateDu; <>vd_Trans_FicheDateAu; <>vd_Trans_FicheDateJour)

C_DATE:C307(<>vd_Trans_LastReportDate)

C_BOOLEAN:C305(<>vb_Trans_HébergéYaDéja)
C_LONGINT:C283(<>vl_Trans_HébergéRéf)
C_LONGINT:C283(<>vl_Trans_HébergementRéf)
C_LONGINT:C283(<>vl_Trans_CentreRéf)
C_TEXT:C284(<>va_Trans_CentreNom)
C_TEXT:C284(<>va_Trans_CentrePlateforme)
//C_ALPHA(45;◊va_Trans_Plateforme)
C_LONGINT:C283(<>ve_Trans_NuitTotal)
C_TEXT:C284(<>va_Trans_Groupe)
C_TEXT:C284(<>va_Trans_CleFam; <>va_Trans_CleFamCHRS)
C_BOOLEAN:C305(<>vb_Trans_ChefFam)



C_TEXT:C284(<>va_Trans_Plateforme)