//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_DisposLits
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_Fenetre)

C_TEXT:C284(va_DateType)
C_LONGINT:C283(ve_TriConso; vL_NbFiches; vL_NbFichesConso; vl_RéfU_HG; vl_Page)
C_BOOLEAN:C305(vb_OK)
C_DATE:C307(vd_DateEnCours)
C_TIME:C306(vh_Clic1)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vL_NbFiches:=0
vl_RéfU_HG:=0
vh_Clic1:=?00:00:00?
vd_DateEnCours:=!00-00-00!

ve_TriConso:=1

P_SommeLit(-1)

READ WRITE:C146([DiaLogues:3])
va_Titre:="Situation des centres"

Repeat 
	vb_OK:=User in group:C338(Current user:C182; <>Groupe_Coordinateur)
	vb_OK:=(vb_OK | User in group:C338(Current user:C182; <>Groupe_Régulateur))
	vb_OK:=(vb_OK | User in group:C338(Current user:C182; <>Groupe_ADMIN))
	vb_OK:=(vb_OK | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
	
	If (vb_OK)
		READ WRITE:C146([CentresLits:16])
	Else 
		READ ONLY:C145([CentresLits:16])
	End if 
	
	vb_OK:=False:C215
	
	FORM SET INPUT:C55([DiaLogues:3]; "DL_CtrDispo")
	$vl_Fenetre:=i_FenêtreNo(810; 520; 4; va_Titre; 1; "Quit_SimpleVBOK")
	
	ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
	UNLOAD RECORD:C212([CentresLits:16])
	
	If (vb_OK=False:C215)
		READ WRITE:C146([CentresLits:16])
		FORM SET INPUT:C55([DiaLogues:3]; "DL_CtrDispoConsolidés")
		
		$vl_Fenetre:=i_FenêtreNo(786; 508; 4; va_Titre; 1; "Quit_Simple")
		ADD RECORD:C56([DiaLogues:3])
	End if 
	
Until (vb_OK)

CLOSE WINDOW:C154($vl_Fenetre)

<>PR_Lits:=0

READ ONLY:C145([DiaLogues:3])
READ ONLY:C145([CentresLits:16])