//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_HébergementExcuser
//{
//{          Mardi 11 Mai 2004 à 10:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283(ve_ProcessEnCours)
ve_ProcessEnCours:=$1
READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 

C_LONGINT:C283(vL_NbFiches)
vL_NbFiches:=0  //Enregistrements trouves([HéberGement]))
C_TEXT:C284(va_Titre)
C_TEXT:C284(va_Réservation)
C_TEXT:C284(va_Emplacement)
C_TEXT:C284(va_AutSol)
C_TEXT:C284(va_GroupeAS)
C_TEXT:C284(va_NomClé)
C_TEXT:C284(va_Rép2)

P_HébergementExcuserRec
If (vl_NbHéberGements>0)
	va_Titre:="Les excusés : "+String:C10(vl_NbHéberGements)
	READ WRITE:C146([DiaLogues:3])
	FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementListe")
	$vl_Fenetre:=i_FenêtreNo(786; 442; 5; va_Titre; 2; "Quit_Simple")
	ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
	CLOSE WINDOW:C154($vl_Fenetre)
Else 
	ALERT:C41("Plus aucun lit d'excusé !")
End if 
<>PR_HébergementLst:=0


If (vb_Show)
	Général_Show
End if 

