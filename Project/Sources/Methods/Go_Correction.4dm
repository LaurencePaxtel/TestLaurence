//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Correction
//{
//{          Mercredi 9 décembre 2009 à 13:00
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

C_LONGINT:C283($vl_Fenetre)

C_BOOLEAN:C305($vb_OK; vb_OK)
C_LONGINT:C283(vL_NbFiches)
C_TEXT:C284(va_Titre)
C_LONGINT:C283(vl_ii; vl_jj)


//••• LA DERNIÈRE FICHE
ARRAY LONGINT:C221(tl_Der_Référence; 0)
ARRAY DATE:C224(td_Der_Date; 0)
ARRAY LONGINT:C221(tl_Der_HB; 0)
ARRAY LONGINT:C221(tl_Der_Nb; 0)
C_DATE:C307(vd_Der_Date)
C_LONGINT:C283(vl_Der_HB; 0)

//••• RECHERCHE PAR NOM OU PAR CLÉ
C_BOOLEAN:C305(vb_RecClé)
C_LONGINT:C283(vl_RecCléID)
vb_RecClé:=False:C215
vl_RecCléID:=0

vb_OK:=False:C215
vL_NbFiches:=0  //Enregistrements trouves([HéberGement]))
va_Titre:="Rattrapage items"

//••• PROFIL
P_Profil

//••• AUTRES CRITERES
DébutDécTableCritèreVeille(1)
DébutDécTableCritèreVeille(2)

//••• CRITERES DE TRI
P_HébergementVeilleSort(0)

//••• AGE
P_HébergementFindAge(0)

//••• RÉSERVATION
P_HébergementFindRéserve(0)

//••• DATE DE SÉLECTION
$vb_OK:=P_DatesPlageEnCours(0; False:C215)

//••• POINTEUR SUR LES CHAMPS
P_ItemCorrection(0)



READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Correction")
$vl_Fenetre:=i_FenêtreNo(876; 638; 4; va_Titre; 1; "Quit_Show")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])


If (vb_Show)
	Général_Show
End if 


<>PR_Correction:=0