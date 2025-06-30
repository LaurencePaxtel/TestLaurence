//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_uNoFiche
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée : Lundi 16 avril 2012 à 16:44:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ ONLY:C145(*)
SET MENU BAR:C67(1)
C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 

Process_Hide(<>PR_Appel)
C_LONGINT:C283(vL_Nb_HG_F)
C_LONGINT:C283($ii; $kk)

C_LONGINT:C283(vl_SourisX; vl_SourisY; vl_SourisBt)

C_TEXT:C284(va_Libellé)
C_LONGINT:C283(vl_Numéro; vl_Nombre; vl_NombrePG)
C_LONGINT:C283(vl_NuméroRéf; vl_NombreRéf; vl_NombreRéfPG)

C_TEXT:C284(va_LibelléClé; va_LibelléClé2)

$kk:=34
ARRAY TEXT:C222(ta_Champs; $kk)
ARRAY POINTER:C280(tp_Champs; $kk)
ARRAY TEXT:C222(ta_ChampsCode; $kk)
$ii:=1
ta_Champs{$ii}:="FICHIERS"
ta_ChampsCode{$ii}:="-"

$ii:=$ii+1
ta_Champs{$ii}:="-"
ta_ChampsCode{$ii}:="-"

$ii:=$ii+1
ta_Champs{$ii}:="Action sociale"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[ActionSociale:26]AA_Référence:1

$ii:=$ii+1
ta_Champs{$ii}:="Associations"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[Assocs:14]AS_ReferenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Centres d'hébergement"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[LesCentres:9]LC_RéférenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Demandes diverses(GIP)"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[GIP:13]GI_ReferenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Dossier infirmier"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[DossierInfirmie:27]DI_Référence:1

$ii:=$ii+1
ta_Champs{$ii}:="Dossier médical"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[DossierMedical:29]DM_Référence:1

$ii:=$ii+1
ta_Champs{$ii}:="Dossier psychologique"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[DossierPsycho:28]DY_Référence:1

$ii:=$ii+1
ta_Champs{$ii}:="Dossier santé"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[DossierSante:33]DE_Référence:1

$ii:=$ii+1
ta_Champs{$ii}:="Dossier social"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[DossierSocial:25]DS_Référence:1

$ii:=$ii+1
ta_Champs{$ii}:="Hébergés (Demandeurs)"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[HeBerge:4]HB_ReferenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Hébergements"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[HeberGement:5]HG_ReferenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Maraude"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[Maraude:24]MR_RéférenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Raison sociale"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[SOciete:18]SO_ReferenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Renseignements"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[RenseiGnements:20]RG_RéférenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Tables"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[TypesTables:11]TT_RéférenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Tables énumérations"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[TAbles:12]TB_RéférenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="Utilisateurs"
ta_ChampsCode{$ii}:="T"
tp_Champs{$ii}:=->[INtervenants:10]IN_RéférenceID:1

$ii:=$ii+1
ta_Champs{$ii}:="-"
ta_ChampsCode{$ii}:="-"

$ii:=$ii+1
ta_Champs{$ii}:="NUMEROTATION"
ta_ChampsCode{$ii}:="-"

$ii:=$ii+1
ta_Champs{$ii}:="-"
ta_ChampsCode{$ii}:="-"

$ii:=$ii+1
ta_Champs{$ii}:="Fiche hébergement"
ta_ChampsCode{$ii}:="HG"
tp_Champs{$ii}:=->[HeberGement:5]HG_FicheNuméro:3

$ii:=$ii+1
ta_Champs{$ii}:="Fiche maraude"
ta_ChampsCode{$ii}:="MR"
tp_Champs{$ii}:=->[Maraude:24]MR_FicheNuméro:3


$ii:=$ii+1
ta_Champs{$ii}:="Fiche dossier infirmier"
ta_ChampsCode{$ii}:="DI"
tp_Champs{$ii}:=->[DossierInfirmie:27]DI_FicheNuméro:3


$ii:=$ii+1
ta_Champs{$ii}:="Fiche dossier médical"
ta_ChampsCode{$ii}:="DM"
tp_Champs{$ii}:=->[DossierMedical:29]DM_FicheNuméro:3


$ii:=$ii+1
ta_Champs{$ii}:="Fiche dossier psychologique"
ta_ChampsCode{$ii}:="DY"
tp_Champs{$ii}:=->[DossierPsycho:28]DY_FicheNuméro:3

$ii:=$ii+1
ta_Champs{$ii}:="Fiche dossier santé"
ta_ChampsCode{$ii}:="DE"
tp_Champs{$ii}:=->[DossierSante:33]DE_FicheNuméro:3


$ii:=$ii+1
ta_Champs{$ii}:="Fiche dossier social"
ta_ChampsCode{$ii}:="DS"
tp_Champs{$ii}:=->[DossierSocial:25]DS_FicheNuméro:3


$ii:=$ii+1
ta_Champs{$ii}:="Fiche GROUPE"
ta_ChampsCode{$ii}:="GP"
tp_Champs{$ii}:=->[GrouPe:36]GP_Numéro:7


$ii:=$ii+1
ta_Champs{$ii}:="-"
ta_ChampsCode{$ii}:="-"

$ii:=$ii+1
ta_Champs{$ii}:="No inconnu"
ta_ChampsCode{$ii}:="X0"
tp_Champs{$ii}:=->[HeBerge:4]HB_Nom:3

$ii:=$ii+1
ta_Champs{$ii}:="-"
ta_ChampsCode{$ii}:="-"
$ii:=$ii+1
ta_Champs{$ii}:="TOUT MONTRER"
ta_ChampsCode{$ii}:="@"

C_BOOLEAN:C305(vb_Passe)
vb_Passe:=False:C215
C_TEXT:C284(vt_StTexte)

READ WRITE:C146([DePart:1])
FORM SET INPUT:C55([DePart:1]; "DP_NoFiche")
$vl_Fenetre:=i_FenêtreNo(467; 435; 4; "Références et numérotations"; 3; "")
ADD RECORD:C56([DePart:1]; *)
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DePart:1])

<>PR_NoFicheH:=0
If (vb_Show)
	Général_Show
End if 

Process_Show(<>PR_Appel)