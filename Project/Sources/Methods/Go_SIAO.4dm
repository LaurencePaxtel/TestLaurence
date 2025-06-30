//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_SIAO
//{          Lundi 29 novembre 2010 à 18:26
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_Fenetre)
C_BOOLEAN:C305($vb_OK)

C_TEXT:C284(va_Titre; va_NNN; va_FrappeClavier; va_IDT_CléFam; va_IDT_LienFam; va_IDT_Typ1; va_IDT_Clé; va_IDT_Nom; va_IDT_Pré)
C_LONGINT:C283(vL_NbFiches; vl_Sel_CleUnique; vL_Nb_HG_F; vl_NbHGi; vL_Nb_SI_F; vl_NbHGs; ve_NbSP; vL_Nb_HB_F; vL_Nb_HG_F; vl_RéfU_HBB; ve_IDT_Age; ve_IDT_PCAge; x_IDTG_1; x_IDTG_2; vl_CleUnique_ID)
C_BOOLEAN:C305(vb_Show; vb_Sel_CleUnique)
C_DATE:C307(vd_IDT_NéLe)

C_LONGINT:C283(<>LH_ListeSIAOinfo)

va_Titre:="SIAO"

va_NNN:=""
va_FrappeClavier:=""

va_IDT_CléFam:=""
va_IDT_LienFam:=""
va_IDT_Typ1:=""
va_IDT_Clé:=""
va_IDT_Nom:=""
va_IDT_Pré:=""

vL_Nb_HB_F:=0
vL_Nb_HG_F:=0

ve_IDT_Age:=0
ve_IDT_PCAge:=0

x_IDTG_1:=0
x_IDTG_2:=0

vL_NbFiches:=0

vb_Show:=False:C215

vd_IDT_NéLe:=!00-00-00!

READ ONLY:C145(*)
SET MENU BAR:C67(1)

//••• DATE DE SÉLECTION
$vb_OK:=P_DatesPlageEnCours(0; True:C214)

V_IDT_Déc(0)
P_SIAO_Var(0; 0)

<>LH_ListeSIAOinfo:=New list:C375

//SITUATION FAMILIALE
//   Demandeur
//   Conjoint
//   Enfants
//SITUATION PROFESSIONNELLE
//  Emploi
//     Demandeur
//     Conjoint
//  Demandeur d'emploi inscrit
//     Demandeur
//     Conjoint
//  Retraire
//     Demandeur
//     Conjoint
//  Sans Activité
//     Demandeur
//     Conjoint
//RESSOURCES DE LA FAMILLE
//  Revenus
//     Demandeur
//     Conjoint
//RENSEIGNEMENTS ADMINISTRATIFS
//  Numéros
//     Demandeur
//     Conjoint
//  Demandes
//     Demandeur
//     Conjoint

//ENDETTEMENTS
//  Demandeur endetté
//  Les endettements
//     Famille
//     Demandeur
//     Conjoint
//  Dossier de surendettement

//SITUATION AU REGARD DES DISPOSITIFS D'AIDE AU LOGEMEMENT
//  Demande
//  Accord
//SITUATION AU REGARD DU LOGEMEMENT OU DE L'HEBERGEMENT
//MOTIF de la DEMANDE DE LA PERSONNE

P_SIAO_Var(2; 0)

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_SIAOAccueil")

$vl_Fenetre:=i_FenêtreNo(1024; 675; 4; va_Titre; 1; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_SIAO:=0

If (vb_Show)
	Général_Show
End if 