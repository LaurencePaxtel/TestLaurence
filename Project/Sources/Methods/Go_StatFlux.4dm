//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_StatFlux
//{
//{          Jeudi 21 avril 2011 à 14:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TEXT:C284($1)
C_TEXT:C284(va_CasSupervision)
va_CasSupervision:=$1

SET MENU BAR:C67(1)

If (7=8)
	ALERT:C41("Développement en cours…")
Else 
	
	C_BOOLEAN:C305(vb_Show)
	vb_Show:=False:C215
	If (vb_Show)
		Général_Hide
	End if 
	READ ONLY:C145(*)
	
	C_LONGINT:C283($vl_Fenetre)
	
	C_BOOLEAN:C305($vb_OK; vb_OK)
	C_LONGINT:C283(vL_NbFiches; vL_NbFichesRupture)
	vL_NbFichesRupture:=0
	
	
	C_TEXT:C284(va_Titre)
	
	vb_OK:=False:C215
	vL_NbFiches:=0  //Enregistrements trouves([HéberGement]))
	va_Titre:="Statistiques : Supervision  des flux"
	
	
	C_LONGINT:C283(vl_ii; vl_jj)
	C_LONGINT:C283(vl_Annee)
	vl_Annee:=Year of:C25(Current date:C33)
	
	
	C_LONGINT:C283(vl_FichesNuites; vl_FichesPersonnes; vl_FichesFamilles)
	C_TEXT:C284(vt_ii)
	ARRAY TEXT:C222(tt_va_ii; 0)
	
	C_POINTER:C301(vp_LePointeur)
	
	
	
	//••• PROFIL
	P_Profil
	
	//••• DATE DE SÉLECTION
	$vb_OK:=P_DatesPlageEnCours(0; False:C215)
	$vb_OK:=P_DatesMoisEnCours(0)
	$vb_OK:=P_FluxEnCours(0)
	
	
	//••• CRITERES DE TRI
	P_HébergementVeilleSort(0)
	P_HébergementVeilleSort(-4)
	
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
	
	
	
	//Etat civil
	ARRAY TEXT:C222(ta_CritEtCiv; 0)
	ARRAY INTEGER:C220(te_CritEtCiv; 0)
	//Etat civil    
	COPY ARRAY:C226(<>ta_TBEtCiv; ta_CritEtCiv)
	i_TableauInitEntier(1; ->ta_CritEtCiv; ->te_CritEtCiv)
	//P_HébergementDécoupageEtCv (0)
	//P_HébergementDécoupageEtCv (2)
	
	
	
	//••• RECHERCHE PAR NOM OU PAR CLÉ
	C_BOOLEAN:C305(vb_RecClé)
	C_LONGINT:C283(vl_RecCléID)
	vb_RecClé:=False:C215
	vl_RecCléID:=0
	
	
	
	READ WRITE:C146([DiaLogues:3])
	FORM SET INPUT:C55([DiaLogues:3]; "DL_StatFlux")
	If (va_CasSupervision="Anonyme")
		$vl_Fenetre:=i_FenêtreNo(914; 308; 4; va_Titre; 1; "Quit_Show")
	Else 
		$vl_Fenetre:=i_FenêtreNo(914; 638; 4; va_Titre; 1; "Quit_Show")
	End if 
	ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
	UNLOAD RECORD:C212([DiaLogues:3])
	CLOSE WINDOW:C154($vl_Fenetre)
	READ ONLY:C145([DiaLogues:3])
	
	
	
	If (vb_Show)
		Général_Show
	End if 
End if 

<>PR_Stat_Flux:=0