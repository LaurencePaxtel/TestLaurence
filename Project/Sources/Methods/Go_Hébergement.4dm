//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{          Procédure : Go_Hébergement
//{          Jeudi 25 mars 2004 à 13:17
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($vb_OK; $continue_b)

C_TEXT:C284(va_GPClé; va_Transfert_HBAlors; va_Transfert_Centre; va_TransFrom; va_JourNuit; va_FormatFrom; va_GPmembresT; va_GPmembres; va_GPLib; va_GPLibel)
C_LONGINT:C283(vl_NbBoucle; vl_NbHéberGements; wSansFiltre)
C_BOOLEAN:C305(vb_Show; vb_PasseR; vb_ResMulti; vb_RecHéb; vb_ResGroupe; vb_GroupeFamille)
C_DATE:C307(vd_LastDate; vd_FinRésa)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=True:C214

If (vb_Show)
	Général_Hide
End if 

V_HG_Dec(0)
V_HG_Dec(1)

$vb_OK:=F_SIAO_DansHebergement("Declarer")

F_VariablesTransite(0; 0; False:C215)
F_VariablesTransite(1; 0; False:C215)

V_HG_Famille(-1)
P_Tab_GP(0; 0)

MESSAGES OFF:C175

va_JourNuit:=$1
va_FormatFrom:=$2

vl_NbBoucle:=0
vl_NbHéberGements:=0

vb_PasseR:=False:C215
vb_ResMulti:=False:C215
vb_ResGroupe:=False:C215
vb_RecHéb:=False:C215

vd_LastDate:=!00-00-00!
vd_FinRésa:=!00-00-00!

F_LesOrientes(-1)
F_LesOrientes(0)

$vb_OK:=F_Report_FullDuplexVAR

wSansFiltre:=0
F_Report_FullDuplexTableau

$vb_OK:=F_Regional_RefsTableau(0)
$vb_OK:=F_Prestation_RefsTableau(0; 0)

P_HébergementProfil(va_JourNuit; "")
$continue_b:=F_HebergementNouveau

If ($continue_b=False:C215)
	CANCEL:C270
End if 

ARRAY LONGINT:C221(<>tl_FamilleID; 0)
ARRAY TEXT:C222(<>ta_FamilleClé; 0)
ARRAY TEXT:C222(<>ta_FamilleEtCv; 0)

P_Tab_GP(0; 0)

If (<>PR_HébergementMul#0)
	<>va_RéserveAction:="Quit"
	
	POST OUTSIDE CALL:C329(<>PR_HébergementMul)
End if 

<>PR_Hébergement:=0

If (vb_Show)
	Général_Show
End if 

POST OUTSIDE CALL:C329(<>PR_Genéral)