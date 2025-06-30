//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementFAX
//{
//{          Mercredi 23 mars 2001 à 16:43
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=True:C214
If (vb_Show)
	Général_Hide
End if 

C_TEXT:C284(vt_Texte)
vt_Texte:=""
C_LONGINT:C283(vl_NbHB)
C_LONGINT:C283(vl_NbCT)
C_DATE:C307(Vd_DateDuJ)
C_BOOLEAN:C305(Vb_JouNuit)
C_BOOLEAN:C305(Vb_Valide)
C_TEXT:C284(va_CléFax)
C_TEXT:C284(va_Titre)
ARRAY LONGINT:C221(tl_CTRéf; 0)
ARRAY INTEGER:C220(tl_CTSél; 0)
ARRAY TEXT:C222(ta_CTNom; 0)
ARRAY TEXT:C222(ta_CTLieu; 0)
ARRAY TEXT:C222(ta_CTTél; 0)
ARRAY TEXT:C222(ta_CTFax; 0)
ARRAY INTEGER:C220(tl_CTCH; 0)
ARRAY INTEGER:C220(tl_CTCHAt; 0)
ARRAY TEXT:C222(ta_CTRépertoire; 0)
C_PICTURE:C286(vi_Vide; vi_Signatur)
C_TEXT:C284(va_LC_Res)


C_TEXT:C284(va_faxASol)
va_faxASol:=""

ARRAY TEXT:C222(ta_ValFam; 1)
ta_ValFam{1}:="Toutes"
ta_ValFam:=1
ta_ValFam{0}:=ta_ValFam{1}

C_LONGINT:C283(vl_SourisX; vl_SourisY; vl_SourisBt)
vl_SourisX:=0
vl_SourisY:=0
vl_SourisBt:=0

vl_NbHB:=0
vl_NbCT:=0
C_DATE:C307(vd_DtJF)
C_TIME:C306(vh_HrJF)
C_LONGINT:C283(ve_LC_Pg)

C_LONGINT:C283(vl_Old)
C_LONGINT:C283(vl_Nouveau)
vl_Nouveau:=0
C_TEXT:C284(va_Nouveau)

Vd_DateDuJ:=Current date:C33(*)
Vb_JouNuit:=($1=1)
Vb_Valide:=True:C214
<>vt_Hotel:=""

C_BOOLEAN:C305(vb_SansAS; vb_FirstNight)
vb_SansAS:=False:C215
vb_FirstNight:=False:C215

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_Télécopie")
va_Titre:="Liste des éléments à télécopier : "+("Matin"*Num:C11($1=0))+("Soir"*Num:C11($1=1))
$vl_Fenetre:=i_FenêtreNo(786; 508; 4; va_Titre; 1; "Quit_Show")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_Fax:=0
If (vb_Show)
	Général_Show
End if 