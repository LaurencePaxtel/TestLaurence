//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutDecTable  
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
ARRAY TEXT:C222(<>ta_FamilleClé; 0)
ARRAY TEXT:C222(<>ta_FamilleEtCv; 0)

ARRAY LONGINT:C221(<>tl_FamilleID; 0)

P_Tab_GP(0; 0)
P_Tab_PR(0; 0)
P_Tab_Pro(0; 0)

//#Utilitaires
ARRAY TEXT:C222(<>ta_Utils; 77)

<>ta_Utils{1}:="Raison sociale"

<>ta_Utils{2}:="-"
<>ta_Utils{3}:="Gestion des tables d'énumérations"

<>ta_Utils{4}:="-"
<>ta_Utils{5}:="-"  // "Utilisateurs : Changer d'utilisateur"
<>ta_Utils{6}:="Utilisateurs : Changer de mot de passe"
<>ta_Utils{7}:="Utilisateurs : Effacer le mot de passe"
<>ta_Utils{8}:="Utilisateurs : Privilèges"
<>ta_Utils{9}:="Utilisateurs : Liste"
<>ta_Utils{10}:="Utilisateurs : Profils"
<>ta_Utils{11}:="Utilisateurs : Plateformes"

<>ta_Utils{12}:="-"
<>ta_Utils{13}:="Numérotation des fiches"
<>ta_Utils{14}:="Suppression d'une fiche d'hébergement"

<>ta_Utils{15}:="-"
<>ta_Utils{16}:="Les Champs des écrans de saisie"

<>ta_Utils{17}:="-"
<>ta_Utils{18}:="Paramètres Age par défaut des inconnus"
<>ta_Utils{19}:="Paramètres Reports"
<>ta_Utils{20}:="Paramètres Centres LOFT"
<>ta_Utils{21}:="Paramètres STR"
<>ta_Utils{22}:="Paramètres TEXTE"
<>ta_Utils{23}:="Paramètres Mise à jour des énumérations"
<>ta_Utils{24}:="Paramètres de disponibilité"
<>ta_Utils{25}:="Paramètres de Consolidation"

<>ta_Utils{26}:="-"
<>ta_Utils{27}:="Gestion des purges"
<>ta_Utils{28}:="Gestion des dates de naissance"
<>ta_Utils{29}:="Préparation des disponibilités "

<>ta_Utils{30}:="-"
<>ta_Utils{31}:="Visualisation des reports"
<>ta_Utils{32}:="-"
<>ta_Utils{33}:="Plateforme réservée"

<>ta_Utils{34}:="-"
<>ta_Utils{35}:="Export des données"

<>ta_Utils{36}:="-"
<>ta_Utils{37}:="Coordinateur par défaut"
<>ta_Utils{38}:="Asile par défaut"
<>ta_Utils{39}:="Signalements liés aux touches F1, F2"
<>ta_Utils{40}:="Groupes : nombre de membres"
<>ta_Utils{41}:="Champs à dupliquer"
<>ta_Utils{42}:="Gestion des centres"
<>ta_Utils{43}:="Autres solutions"
<>ta_Utils{44}:="Prolongations : paramètres"
<>ta_Utils{45}:="Tranches d'Âge"
<>ta_Utils{46}:="Fusion : paramètres"

<>ta_Utils{47}:="-"
<>ta_Utils{48}:="Fusion Etat civil"

<>ta_Utils{49}:="-"
<>ta_Utils{50}:="Correction fusion"
<>ta_Utils{51}:="Correction items"
<>ta_Utils{52}:="Rattrapage items"

<>ta_Utils{53}:="-"
<>ta_Utils{54}:="Lien GPS"
<>ta_Utils{55}:="Nombre de fiches d'hébergement"
<>ta_Utils{56}:="Fiches de consolidation"
<>ta_Utils{57}:="Paramètres de pointage"
<>ta_Utils{58}:="Regroupement d'items"
<>ta_Utils{59}:="Export report"
<>ta_Utils{60}:="Présentation"

<>ta_Utils{61}:="-"
<>ta_Utils{62}:="Website 115"

<>ta_Utils{63}:="-"

<>ta_Utils{64}:="Bottin social"

<>ta_Utils{65}:="-"

<>ta_Utils{66}:="Consolidation sur le client"
<>ta_Utils{67}:="Serveur de mails"

<>ta_Utils{68}:="-"
<>ta_Utils{69}:="Consolidation régionale"


<>ta_Utils{70}:="-"
<>ta_Utils{71}:="Données par défaut de l'orientation SIAO"

<>ta_Utils{72}:="-"
<>ta_Utils{73}:="Consolidation transfert 115"

// Modifié par : Kevin HASSAL (07/07/2018)
<>ta_Utils{74}:="-"
<>ta_Utils{75}:="Export"
<>ta_Utils{76}:="Option veille"

<>ta_Utils{77}:="Champs à dupliquer : nouvelles fiches"

If (Current user:C182="apaxtel")
	APPEND TO ARRAY:C911(<>ta_Utils; "-")
	
	APPEND TO ARRAY:C911(<>ta_Utils; "Paramétrage du navigateur")
	APPEND TO ARRAY:C911(<>ta_Utils; "Paramétrage des structures")
	APPEND TO ARRAY:C911(<>ta_Utils; "Navigateur du développement")
	APPEND TO ARRAY:C911(<>ta_Utils; "Paramétrage des fiches Max")
End if 

APPEND TO ARRAY:C911(<>ta_Utils; "Financeurs")

// Modifié par : Scanu Rémy (27/10/2021)
INSERT IN ARRAY:C227(<>ta_Utils; 26)
<>ta_Utils{26}:="Paramétrage des impressions"

// Modifié par : Scanu Rémy (16/11/2021)
outilsAddToArray(-><>ta_Utils; "-"; "4D Write Pro")

// Modifié par : Scanu Rémy (04/01/2022)
outilsAddToArray(-><>ta_Utils; "-"; "Gestion du stock")

// Modifié par : Scanu Rémy (22/04/2022)
If (Current user:C182="apaxtel")
	outilsAddToArray(-><>ta_Utils; "-"; "Gestion des CGU")
End if 


//#Utilitaires
ARRAY TEXT:C222(<>ta_ItemGroupe; 3)

<>ta_ItemGroupe{1}:="Etat civil"
<>ta_ItemGroupe{2}:="Centre Hébergement"
<>ta_ItemGroupe{3}:="Centre Prestation"

//#Dossiers dans la version Maraude
ARRAY TEXT:C222(<>ta_DosMR; 5)

<>ta_DosMR{1}:="Dossier social"
<>ta_DosMR{2}:="Dossier infirmier"
<>ta_DosMR{3}:="Dossier psycho-social"
<>ta_DosMR{4}:="Dossier médical"
<>ta_DosMR{5}:="Dossier santé"

//Prestation
ARRAY TEXT:C222(<>ta_PrestRub; 4)

<>ta_PrestRub{1}:="Adresses utiles"
<>ta_PrestRub{2}:="Association"
<>ta_PrestRub{3}:="Demande de prestations"
<>ta_PrestRub{4}:="Situations particulières"

//Graphes répartition
ARRAY TEXT:C222(<>ta_GrapheRépartition; 19)

ARRAY TEXT:C222(<>ta_PrestThé; 0)
ARRAY TEXT:C222(<>ta_PrestNom; 0)

C_TEXT:C284(<>va_PrestThé)
C_TEXT:C284(<>va_PrestNom)
C_TEXT:C284(<>va_PrestBis)

//#Users
ARRAY TEXT:C222(<>ta_InUser; 0)
ARRAY LONGINT:C221(<>tl_InUser; 0)

//#Coordinateurs
ARRAY TEXT:C222(<>ta_InCoo; 0)

//#Régulateurs
ARRAY TEXT:C222(<>ta_InRég; 0)

//#Permanencier
ARRAY TEXT:C222(<>ta_InPerm; 0)

//#Infirmier
ARRAY TEXT:C222(<>ta_InInf; 0)
ARRAY LONGINT:C221(<>tl_InInf; 0)

//#Médecins
ARRAY TEXT:C222(<>ta_InMéd; 0)
ARRAY LONGINT:C221(<>tl_InMéd; 0)

//#Médecins Hébergement
ARRAY TEXT:C222(<>ta_InMédH; 0)
ARRAY LONGINT:C221(<>tl_InMédH; 0)

//#Assistante sociale
ARRAY TEXT:C222(<>ta_InAsSoc; 0)

//#Opérateurs
ARRAY TEXT:C222(<>ta_InOpér; 0)
ARRAY LONGINT:C221(<>tl_InOpér; 0)

ARRAY TEXT:C222(<>ta_SsTh; 0)
ARRAY TEXT:C222(<>ta_SsThCd; 0)

//#Demande de prestation
C_TEXT:C284(<>va_DemP_L)
C_TEXT:C284(<>va_DemP_R)

ARRAY TEXT:C222(<>ta_DemP; 0)
ARRAY TEXT:C222(<>ta_DemPCd; 0)
ARRAY PICTURE:C279(<>ti_DemP; 0)

//#Adresses utiles
C_TEXT:C284(<>va_AdUtil_L)
C_TEXT:C284(<>va_AdUtil_R)

ARRAY TEXT:C222(<>ta_AdUtil; 0)
ARRAY TEXT:C222(<>ta_AdUtilCd; 0)
ARRAY PICTURE:C279(<>ti_AdUtil; 0)

//#Stuations particulières
C_TEXT:C284(<>va_SitPar_L)
C_TEXT:C284(<>va_SitPar_R)

ARRAY TEXT:C222(<>ta_SitPar; 0)
ARRAY TEXT:C222(<>ta_SitParCd; 0)
ARRAY PICTURE:C279(<>ti_SitPar; 0)

//#Association
C_TEXT:C284(<>va_Ass_L)
C_TEXT:C284(<>va_Ass_R)

ARRAY TEXT:C222(<>ta_Ass; 0)
ARRAY TEXT:C222(<>ta_AssCd; 0)
ARRAY PICTURE:C279(<>ti_Ass; 0)


ARRAY TEXT:C222(<>ta_TBArr; 0)

ARRAY TEXT:C222(<>ta_TBGare; 0)


ARRAY TEXT:C222(<>ta_TBMetro; 0)

ARRAY TEXT:C222(<>ta_TBPlace; 0)

ARRAY TEXT:C222(<>ta_TBPorte; 0)

ARRAY TEXT:C222(<>ta_TBMaraud; 0)


ARRAY TEXT:C222(<>ta_TBLien; 0)

ARRAY TEXT:C222(<>ta_TBLieuNé; 0)

ARRAY TEXT:C222(<>ta_TBSitFam; 0)

ARRAY TEXT:C222(<>ta_TBTpsErr; 0)

ARRAY TEXT:C222(<>ta_TBDerHéb; 0)

ARRAY TEXT:C222(<>ta_TBSitPro; 0)

ARRAY TEXT:C222(<>ta_TBDerJob; 0)

ARRAY TEXT:C222(<>ta_TBDurJob; 0)

ARRAY TEXT:C222(<>ta_TBNivEtu; 0)

ARRAY TEXT:C222(<>ta_TBPIdté; 0)

ARRAY TEXT:C222(<>ta_TBPIdté2; 0)

ARRAY TEXT:C222(<>ta_TBPIdté3; 0)

ARRAY TEXT:C222(<>ta_TBEtCiv; 0)

ARRAY TEXT:C222(<>ta_TBNatio; 0)

ARRAY TEXT:C222(<>ta_TBSglt; 0)

ARRAY TEXT:C222(<>ta_TBResAct; 0)

ARRAY TEXT:C222(<>ta_TBResAct2; 0)

ARRAY TEXT:C222(<>ta_TBResAct3; 0)

ARRAY TEXT:C222(<>ta_TBSuiSoc; 0)

ARRAY TEXT:C222(<>ta_TBSuiSoc2; 0)

ARRAY TEXT:C222(<>ta_TBSuiSoc3; 0)

ARRAY TEXT:C222(<>ta_TBCouSoc; 0)


ARRAY TEXT:C222(<>ta_TBCouSoc2; 0)

ARRAY TEXT:C222(<>ta_TBCouSoc3; 0)

ARRAY TEXT:C222(<>ta_TBRupMaj; 0)

ARRAY TEXT:C222(<>ta_TBRupMaj2; 0)

ARRAY TEXT:C222(<>ta_TBRupMaj3; 0)

ARRAY TEXT:C222(<>ta_TBProv; 0)

ARRAY TEXT:C222(<>ta_TBPlain; 0)

ARRAY TEXT:C222(<>ta_TBHospi; 0)

ARRAY TEXT:C222(<>ta_TBTrCour; 0)

ARRAY TEXT:C222(<>ta_TBToxico; 0)

ARRAY TEXT:C222(<>ta_TBPneumo; 0)

ARRAY TEXT:C222(<>ta_TBCardio; 0)

ARRAY TEXT:C222(<>ta_TBNeuro; 0)

ARRAY TEXT:C222(<>ta_TBInfect; 0)

ARRAY TEXT:C222(<>ta_TBGastro; 0)

ARRAY TEXT:C222(<>ta_TBPsychi; 0)

ARRAY TEXT:C222(<>ta_TBDerm; 0)

ARRAY TEXT:C222(<>ta_TBTrauma; 0)

ARRAY TEXT:C222(<>ta_TBDivers; 0)

ARRAY TEXT:C222(<>ta_TBTrAdm; 0)

ARRAY TEXT:C222(<>ta_TBTrSort; 0)


ARRAY TEXT:C222(<>ta_TBOr1; 0)

ARRAY TEXT:C222(<>ta_TBOr2; 0)


ARRAY TEXT:C222(<>ta_AtS; 0)

ARRAY TEXT:C222(<>ta_TBOr1suite; 0)


ARRAY TEXT:C222(<>ta_AtSsuite; 0)

ARRAY TEXT:C222(<>ta_Appels; 0)

ARRAY TEXT:C222(<>ta_Resp; 0)

ARRAY TEXT:C222(<>ta_ChB; 0)


ARRAY TEXT:C222(<>ta_EMA; 0)


ARRAY TEXT:C222(<>ta_Lgs; 0)

ARRAY TEXT:C222(<>ta_OrSc; 0)


ARRAY TEXT:C222(<>ta_OrMd; 0)


ARRAY TEXT:C222(<>ta_DerLH; 0)


ARRAY TEXT:C222(<>ta_CpAct; 0)


ARRAY TEXT:C222(<>ta_MRsg; 0)

ARRAY TEXT:C222(<>ta_MRsm; 0)


ARRAY TEXT:C222(<>ta_MRpt; 0)


ARRAY TEXT:C222(<>ta_MRcs; 0)

ARRAY TEXT:C222(<>ta_MRrs; 0)

ARRAY TEXT:C222(<>ta_MRrg; 0)


ARRAY TEXT:C222(<>ta_MRss; 0)


ARRAY TEXT:C222(<>ta_MRrefu; 0)


ARRAY TEXT:C222(<>ta_MRSctr; 0)

ARRAY TEXT:C222(<>ta_MRMpro; 0)


ARRAY TEXT:C222(<>ta_MRQui; 0)


ARRAY TEXT:C222(<>ta_MRCssp; 0)


ARRAY TEXT:C222(<>ta_MRPssp; 0)

ARRAY TEXT:C222(<>ta_MRPch; 0)


ARRAY TEXT:C222(<>ta_MRDem; 0)


ARRAY TEXT:C222(<>ta_MReGé; 0)


ARRAY TEXT:C222(<>ta_MReCu; 0)

ARRAY TEXT:C222(<>ta_MRrel; 0)


ARRAY TEXT:C222(<>ta_Qmod; 0)


ARRAY TEXT:C222(<>ta_Qmot; 0)


ARRAY TEXT:C222(<>ta_Indic; 0)

ARRAY TEXT:C222(<>ta_Dépen; 0)


ARRAY TEXT:C222(<>ta_Patho; 0)


ARRAY TEXT:C222(<>ta_HopL; 0)

ARRAY TEXT:C222(<>ta_LitInf; 0)


ARRAY TEXT:C222(<>ta_MRhyg; 0)

ARRAY TEXT:C222(<>ta_MRhan; 0)

ARRAY TEXT:C222(<>ta_MRqua; 0)

ARRAY TEXT:C222(<>ta_MRorS; 0)

ARRAY TEXT:C222(<>ta_MRaid; 0)

ARRAY TEXT:C222(<>ta_MRPro; 0)

ARRAY TEXT:C222(<>ta_DSidté; 0)

ARRAY TEXT:C222(<>ta_DSrég; 0)

ARRAY TEXT:C222(<>ta_DSsuivi; 0)

ARRAY TEXT:C222(<>ta_DScomp; 0)

ARRAY TEXT:C222(<>ta_DScs; 0)

ARRAY TEXT:C222(<>ta_DPpsy; 0)

ARRAY TEXT:C222(<>ta_DPanté; 0)

ARRAY TEXT:C222(<>ta_DPOr; 0)

ARRAY TEXT:C222(<>ta_DMmEnt; 0)

ARRAY TEXT:C222(<>ta_DMmSor; 0)

ARRAY TEXT:C222(<>ta_DMtAdm; 0)

ARRAY TEXT:C222(<>ta_DMtSor; 0)

ARRAY TEXT:C222(<>ta_DMpds; 0)

ARRAY TEXT:C222(<>ta_DMTail; 0)

ARRAY TEXT:C222(<>ta_DMvlg; 0)

ARRAY TEXT:C222(<>ta_DMvld; 0)

ARRAY TEXT:C222(<>ta_DMvpg; 0)

ARRAY TEXT:C222(<>ta_DMvpd; 0)

ARRAY TEXT:C222(<>ta_DManté; 0)

ARRAY TEXT:C222(<>ta_DMety; 0)

ARRAY TEXT:C222(<>ta_DMetyQ; 0)

ARRAY TEXT:C222(<>ta_DMetyT; 0)

ARRAY TEXT:C222(<>ta_DMetyA; 0)

ARRAY TEXT:C222(<>ta_DMTab; 0)

ARRAY TEXT:C222(<>ta_DMTabP; 0)

ARRAY TEXT:C222(<>ta_DMTabA; 0)

ARRAY TEXT:C222(<>ta_DMmad; 0)

ARRAY TEXT:C222(<>ta_DMexam; 0)

ARRAY TEXT:C222(<>ta_DMtox; 0)


ARRAY TEXT:C222(<>ta_ACTIONS; 0)

ARRAY TEXT:C222(<>ta_EXCLUS; 0)


ARRAY TEXT:C222(<>ta_FMGrp; 0)

//Copie pour CHRS
ARRAY TEXT:C222(<>ta_FMGrpCHRS; 0)


ARRAY TEXT:C222(<>ta_FMComp; 0)


ARRAY TEXT:C222(<>ta_FMnbP; 0)


ARRAY TEXT:C222(<>ta_FMnbJ; 0)


ARRAY TEXT:C222(<>ta_FMnbC; 0)


ARRAY TEXT:C222(<>ta_FMCaS; 0)


ARRAY TEXT:C222(<>ta_FMDis1; 0)


ARRAY TEXT:C222(<>ta_FMDis2; 0)

ARRAY TEXT:C222(<>ta_FMDis3; 0)


ARRAY TEXT:C222(<>ta_FMDis4; 0)

ARRAY TEXT:C222(<>ta_FMDis5; 0)


ARRAY TEXT:C222(<>ta_DEAuto; 0)


ARRAY TEXT:C222(<>ta_DEDép; 0)


ARRAY TEXT:C222(<>ta_DEPara; 0)

ARRAY TEXT:C222(<>ta_DEAlle; 0)


ARRAY TEXT:C222(<>ta_DEMdEnt; 0)


ARRAY TEXT:C222(<>ta_DEMtEnt; 0)


ARRAY TEXT:C222(<>ta_DEOPat; 0)


ARRAY TEXT:C222(<>ta_DEOEquip; 0)


ARRAY TEXT:C222(<>ta_DEOrient; 0)


ARRAY TEXT:C222(<>ta_DMTabT; 0)


ARRAY TEXT:C222(<>ta_DEToxi; 0)


ARRAY TEXT:C222(<>ta_DEToxiQ; 0)


ARRAY TEXT:C222(<>ta_DEToxiT; 0)


ARRAY TEXT:C222(<>ta_DEToxiA; 0)


ARRAY TEXT:C222(<>ta_DEVisionQF; 0)


ARRAY TEXT:C222(<>ta_DECtr; 0)


ARRAY TEXT:C222(<>ta_DETrH; 0)


ARRAY TEXT:C222(<>ta_DEToxiC; 0)


ARRAY TEXT:C222(<>ta_DEToxiC; 0)


ARRAY TEXT:C222(<>ta_DEExamAdr; 0)

ARRAY TEXT:C222(<>ta_DEExamSec; 0)


ARRAY TEXT:C222(<>ta_URL; 0)


ARRAY TEXT:C222(<>ta_Plateforme; 0)


ARRAY TEXT:C222(<>ta_Attestations; 0)


ARRAY TEXT:C222(<>ta_SIAO_SiteAccueil; 0)
ARRAY LONGINT:C221(<>tl_SIAO_SiteAccueil; 0)


ARRAY TEXT:C222(<>ta_SIAO_Role; 0)


ARRAY TEXT:C222(<>ta_SIAO_SitPhysique; 0)

ARRAY TEXT:C222(<>ta_SIAO_CatHeberge; 0)

ARRAY TEXT:C222(<>ta_SIAO_CatPlace; 0)


ARRAY TEXT:C222(<>ta_SIAO_CatStruc; 0)


ARRAY TEXT:C222(<>ta_SIAO_Competent; 0)


ARRAY TEXT:C222(<>ta_SIAO_Etat; 0)


ARRAY TEXT:C222(<>ta_SIAO_Civilite; 0)


ARRAY TEXT:C222(<>ta_SIAO_NeLeLieu; 0)


ARRAY TEXT:C222(<>ta_SIAO_NeLePays; 0)


ARRAY TEXT:C222(<>ta_SIAO_SitFam; 0)


ARRAY TEXT:C222(<>ta_SIAO_Parente; 0)


ARRAY TEXT:C222(<>ta_SIAO_Nationalite; 0)


ARRAY TEXT:C222(<>ta_SIAO_Papier; 0)


ARRAY TEXT:C222(<>ta_SIAO_Ressource; 0)


ARRAY TEXT:C222(<>ta_SIAO_Locomotion; 0)


ARRAY TEXT:C222(<>ta_SIAO_SitProf; 0)

ARRAY TEXT:C222(<>ta_SIAO_SanSitProf; 0)


ARRAY TEXT:C222(<>ta_SIAO_Dette; 0)


ARRAY TEXT:C222(<>ta_SIAO_CouvSoc; 0)


ARRAY TEXT:C222(<>ta_SIAO_TypePapier; 0)


ARRAY TEXT:C222(<>ta_SIAO_CasSpec; 0)


ARRAY TEXT:C222(<>ta_SIAO_LogActuel; 0)


ARRAY TEXT:C222(<>ta_SIAO_AccueilCol; 0)


ARRAY TEXT:C222(<>ta_SIAO_MotifDem; 0)


ARRAY TEXT:C222(<>ta_SIAO_TitreSej; 0)


ARRAY TEXT:C222(<>ta_SIAO_Besoins; 0)


ARRAY TEXT:C222(<>ta_SIAO_TypeAcc; 0)


ARRAY TEXT:C222(<>ta_SIAO_TypeAccS; 0)


ARRAY TEXT:C222(<>ta_SIAO_LogAdapte; 0)


ARRAY TEXT:C222(<>ta_SIAO_Orienter; 0)


ARRAY TEXT:C222(<>ta_SIAO_BesAidF; 0)


ARRAY TEXT:C222(<>ta_SIAO_EtCiv; 0)


ARRAY TEXT:C222(<>ta_SIAO_Credit; 0)


ARRAY TEXT:C222(<>ta_HG_DosSIAO; 0)


ARRAY TEXT:C222(<>ta_HG_TypDemSIAO; 0)


ARRAY TEXT:C222(<>ta_HG_TypPresSIAO; 0)

ARRAY TEXT:C222(<>ta_HG_TypPlaceSIAO; 0)


ARRAY TEXT:C222(<>ta_TypeDocLocation; 0)

ARRAY TEXT:C222(<>ta_GL_LibelleSinistres; 0)


ARRAY TEXT:C222(<>ta_GL_LibelleCharges; 0)


ARRAY TEXT:C222(<>ta_GL_ModesReglements; 0)


ARRAY TEXT:C222(<>ta_GL_TypeBien; 0)


ARRAY TEXT:C222(<>ta_GL_Banques; 0)


ARRAY TEXT:C222(<>ta_TVA; 0)


ARRAY TEXT:C222(<>ta_DossiersEncours; 0)


ARRAY TEXT:C222(<>ta_DOS_Jours_Rappel; 0)


ARRAY TEXT:C222(<>ta_RDV_Types; 0)

ARRAY TEXT:C222(<>ta_RDV_Presence; 0)


ARRAY TEXT:C222(<>ta_RDV_Rappel; 0)

ARRAY TEXT:C222(<>ta_GI_Types_Equipements; 0)


ARRAY TEXT:C222(<>ta_GI_Garantie; 0)


ARRAY TEXT:C222(<>ta_GI_Quantite_initiale; 0)


ARRAY TEXT:C222(<>ta_GI_Types_Interventions; 0)


ARRAY TEXT:C222(<>ta_GI_PEE; 0)


ARRAY TEXT:C222(<>ta_GP_Annees; 0)


ARRAY TEXT:C222(<>ta_Emplacement; 0)


ARRAY TEXT:C222(<>ta_LC_Categorie; 0)