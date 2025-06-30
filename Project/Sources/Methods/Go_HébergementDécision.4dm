//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementDécision
//{
//{          Mardi 18 avril 2006 à 12:28:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_TIME:C306(vh_HeurTemp)


C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 

C_LONGINT:C283(vL_NbFiches)
C_TEXT:C284(va_Titre)
vL_NbFiches:=0  //Enregistrements trouves([HéberGement]))
ARRAY LONGINT:C221(tl_Décision_Réf; vL_NbFiches)
ARRAY LONGINT:C221(tl_Décision_RéfClé; vL_NbFiches)
ARRAY TEXT:C222(ta_Décision_Clé; vL_NbFiches)
ARRAY TEXT:C222(ta_Décision_Nom; vL_NbFiches)
ARRAY TEXT:C222(ta_Décision_Prénom; vL_NbFiches)
ARRAY DATE:C224(td_Décision_NéLe; vL_NbFiches)

ARRAY TEXT:C222(ta_Décision_no; vL_NbFiches)
ARRAY LONGINT:C221(th_Décision_heure; vL_NbFiches)
ARRAY TEXT:C222(ta_Décision_heure; vL_NbFiches)
ARRAY LONGINT:C221(tl_Décision_Hébgnt; vL_NbFiches)
ARRAY LONGINT:C221(tl_Décision_Dem; vL_NbFiches)
ARRAY TEXT:C222(ta_Décision_Tri; vL_NbFiches)


va_Titre:="Aide décisionnelle"
READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Décisionnel")
$vl_Fenetre:=i_FenêtreNo(686; 508; 4; va_Titre; 3; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)

<>PR_HébergementDéc:=0


If (vb_Show)
	Général_Show
End if 

