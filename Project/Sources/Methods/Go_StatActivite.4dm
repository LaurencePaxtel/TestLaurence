//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_StatFlux
//{          Lundi 6 février 2012 à 11:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)


C_BOOLEAN:C305(vb_Show; vb_OK)
C_TEXT:C284(va_Titre)
C_LONGINT:C283(vL_NbFiches; vl_ii; vl_jj; vl_Annee)
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($vl_Fenetre)

vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
READ ONLY:C145(*)

vb_OK:=False:C215
vL_NbFiches:=0  //Enregistrements trouves([HéberGement]))
va_Titre:="Statistiques : Hébergement activité"
vl_Annee:=Year of:C25(Current date:C33)

//••• PROFIL
P_Profil

//••• DATE DE SÉLECTION
$vb_OK:=P_DatesPlageEnCours(0; False:C215)
$vb_OK:=P_DatesMoisEnCours(0)
$vb_OK:=P_ActiviteEnCours(0)


READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatActivite")
$vl_Fenetre:=i_FenêtreNo(914; 638; 4; va_Titre; 1; "Quit_Show")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])



If (vb_Show)
	Général_Show
End if 


<>PR_Stat_Activite:=0
