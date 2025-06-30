//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_MaraudeVeille
//{
//{          Mercredi 23 mars 2001 à 16:43
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 

C_TEXT:C284(va_CtrLib)
va_CtrLib:=""

C_LONGINT:C283(vl_RéfU_HG)
C_TIME:C306(vh_Clic1)
vl_RéfU_HG:=0
vh_Clic1:=?00:00:00?
C_LONGINT:C283(vl_Page)
vl_Page:=0
C_TEXT:C284(va_Rép)
C_TEXT:C284(va_Rép2)

C_TEXT:C284(vt_Action)

//••• TABLEAU •••
//Etat civil
ARRAY TEXT:C222(ta_xEtCiv; 0)
COPY ARRAY:C226(<>ta_TBEtCiv; ta_xEtCiv)
ARRAY INTEGER:C220(te_xEtCiv; Size of array:C274(ta_xEtCiv))
For ($ii; 1; Size of array:C274(ta_xEtCiv))
	te_xEtCiv{$ii}:=1
End for 
//Signalement
ARRAY TEXT:C222(ta_xSglt; 0)
COPY ARRAY:C226(<>ta_TBSglt; ta_xSglt)
ARRAY INTEGER:C220(te_xSglt; Size of array:C274(ta_xSglt))
For ($ii; 1; Size of array:C274(ta_xSglt))
	te_xSglt{$ii}:=1
End for 

P_MaraudeSort(0)

C_LONGINT:C283(vL_NbFiches)
vL_NbFiches:=Records in table:C83([Maraude:24])
C_TEXT:C284(va_Titre)
C_TEXT:C284($T_Window_titre)
$T_Window_titre:="Veille Maraude"  //lpc plein écran 12/10/2018
FORM SET INPUT:C55([DiaLogues:3]; "DL_MaraudeVeille")
va_Titre:="Veille maraude"
// $vl_Fenetre:=i_FenêtreNo (786;508;4;va_Titre;1;"Quit_Show")
$vl_Fenetre:=FEN_OpenFormWindow(->[DiaLogues:3]; "DL_MaraudeVeille"; Form fenêtre standard:K39:10; $T_Window_titre)  //lpc plein écran 12/10/2018
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

POST OUTSIDE CALL:C329(<>PR_HBNotesV)
<>PR_MaraudeVeille:=0
If (vb_Show)
	Général_Show
End if 
