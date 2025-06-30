//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatTroisEnfants
//{
//{          Lundi 28 Décembre 2009 à 10:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($1)
C_TEXT:C284(va_CasSupervision)
va_CasSupervision:=$1

SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
READ ONLY:C145(*)



C_BOOLEAN:C305(vb_OK)
C_LONGINT:C283(vL_NbFiches)
C_TEXT:C284(va_Titre)

vb_OK:=False:C215
vL_NbFiches:=0  //Enregistrements trouves([HéberGement]))
va_Titre:="Statistiques : Supervision  journalière 115"


C_LONGINT:C283(vl_ii; vl_jj)
C_LONGINT:C283(vl_Annee)
vl_Annee:=Year of:C25(Current date:C33)


C_LONGINT:C283(vl_FichesNuites; vl_FichesPersonnes; vl_FichesFamilles)
C_TEXT:C284(vt_ii)
ARRAY TEXT:C222(tt_va_ii; 0)

C_POINTER:C301(vp_LePointeur)

C_POINTER:C301(vp_TroisPtr01; vp_TroisPtr02; vp_TroisPtr03)
C_POINTER:C301(vp_TroisPtrLib)



//••• PROFIL
P_Profil


//••• DATE DE SÉLECTION
//$vb_OK:=P_DatesPlageEnCours (0;faux)

//••• CRITERES DE TRI
P_HébergementVeilleSort(0)
P_HébergementVeilleSort(-3)

//••• POINTEUR SUR LES CHAMPS
P_ItemCorrection(0)
P_ItemCorrection2(0)


ta_ItemRub2:=Size of array:C274(ta_ItemRub2)
ve_PosRub:=ta_ItemRub2
vl_ItemNuméro2:=ta_ItemRub2
va_Item2:=""
va_ItemTitre2:=ta_ItemRub2{ta_ItemRub2}
P_ItemCorrection2(1)


//••• CENTRES
P_CritèreCentre(2)



P_TroisFoisRien(0; 0; 0; !00-00-00!)


READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_StatTroisFoisRien")

C_LONGINT:C283($vl_Fenetre)
If (va_CasSupervision="Anonyme")
	$vl_Fenetre:=i_FenêtreNo(916; 277; 4; va_Titre; 1; "Quit_Show")
Else 
	$vl_Fenetre:=i_FenêtreNo(916; 638; 4; va_Titre; 1; "Quit_Show")
End if 
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])




<>PR_Stat_TroisFoisRien:=0
If (vb_Show)
	Général_Show
End if 

