//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_MaraudeVeilleB
//{
//{          Vendredi 1 juillet 2004 à 11:04
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

C_LONGINT:C283(vL_NbFiches; $ii)
vL_NbFiches:=0
C_TEXT:C284(va_Titre)

C_TEXT:C284(va_LibelléMRs)


ARRAY TEXT:C222(ta_Page; 4)
ta_Page{1}:="Maraude"
ta_Page{2}:="Fiche sociale"
ta_Page{3}:="Référents"
ta_Page{4}:="Sanitaire"
ta_Page:=1

C_TEXT:C284(va_QuelDossier)
va_QuelDossier:="MR"

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

C_TEXT:C284($T_Window_titre)
$T_Window_titre:="Veille Maraude"

P_MaraudeVeilleSort(0)

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_MaraudeVeilleB")
va_Titre:="Veille maraude"
// $vl_Fenetre:=i_FenêtreNo (786;508;4;va_Titre;1;"Quit_Show")
$vl_Fenetre:=FEN_OpenFormWindow(->[DiaLogues:3]; "DL_MaraudeVeilleB"; Form fenêtre standard:K39:10; $T_Window_titre)  //lpc plein écran 12/10/2018
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])


POST OUTSIDE CALL:C329(<>PR_HBNotesV)
<>PR_MaraudeVeille:=0
If (vb_Show)
	Général_Show
End if 