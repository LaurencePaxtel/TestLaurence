//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Raison  
//{
//{          Mercredi 29 Octobre 1997 à 12:47:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($position_t)


C_TEXT:C284(vt_CheminRepertoire; vt_Chem)
C_LONGINT:C283(vl_ColorCadre; ModeConsoR1; ModeConsoR3; ModeConsoR3; ve_T_CentreCodeNew; vl_T_CentreCodeNewDebut; vl_T_CentreCodeNewFin)
C_BOOLEAN:C305(vb_T_CentreCodeNew; vb_Show)
C_TIME:C306(vh_TauxOccup)

ARRAY TEXT:C222(ta_Page; 9)

vt_Chem:=""
vb_Show:=False:C215

ta_Page{1}:="Entité"
ta_Page{2}:="Chemins"
ta_Page{3}:="Options"
ta_Page{4}:="Libellés"
ta_Page{5}:="Facturation"
ta_Page{6}:="Export des factures"
ta_Page{7}:="Signature électronique"
ta_Page{8}:="Autres fonctionnalités"
ta_Page{9}:="Divers"

// Modifié par : Scanu Rémy (31/03/2023) et Re-Modifié par LPC (10/05/2023)
/*
Si (Utilisateur courant="apaxtel")
AJOUTER À TABLEAU(ta_Page; "Export des factures")
Fin de si 
*/
ta_Page:=1

READ ONLY:C145(*)
SET MENU BAR:C67(1)

P_HébergementProfil("J"; "")

FORM SET INPUT:C55([SOciete:18]; "SO_EcranSaisie")
va_Titre:="Raison sociale"

QUERY:C277([SOciete:18]; [SOciete:18]SO_ReferenceID:1=1)
MultiSoc_Filter(->[SOciete:18])

If (Records in selection:C76([SOciete:18])=1)
	READ WRITE:C146([SOciete:18])
	
	If (i_NonVerrou(->[SOciete:18]))
		
		// Modifié par : Scanu Rémy (11/10/2023) 
/*
$vl_Fenetre:=Créer fenêtre formulaire([SOciete]; "SO_EcranSaisie"; 4; Centrée horizontalement; Centrée verticalement; *)  // #20180608-2
MODIFIER ENREGISTREMENT([SOciete]; *)
		
LIBÉRER ENREGISTREMENT([SOciete])
FERMER FENÊTRE($vl_Fenetre)
*/
		$position_t:="center"
		outilsCreateWindowsForm("SO_EcranSaisie"; ->$position_t; \
			New object:C1471("table"; "SOciete"; "formName"; "SO_EcranSaisie"); \
			New object:C1471("table"; "SOciete"; "useFormTable"; True:C214; "useSubForm"; True:C214))
	End if 
	
	READ ONLY:C145([SOciete:18])
End if 

<>PR_Raison:=0

If (vb_Show)
	Général_Show
End if 