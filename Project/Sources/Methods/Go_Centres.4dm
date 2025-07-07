//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Centres  
//{
//{          Mercredi 29 Octobre 1997 à 12:47:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($vl_Fenetre)

C_LONGINT:C283(ve_JourOuverture; ve_JourFermeture; ve_MoisOuverture; ve_MoisFermeture)
C_BOOLEAN:C305(vb_Show; vb_Dupliquer)

ARRAY TEXT:C222(ta_LesMoisOuverts; 0)
ARRAY TEXT:C222(ta_LesMoisFermés; 0)

READ ONLY:C145(*)
SET MENU BAR:C67(1)

vb_Show:=True:C214

If (vb_Show)
	Général_Hide
End if 

COPY ARRAY:C226(<>ta_LesMois; ta_LesMoisOuverts)
COPY ARRAY:C226(<>ta_LesMois; ta_LesMoisFermés)

vb_Dupliquer:=False:C215

// Modified by: Kevin HASSAL (15-12-2018)
// Ajout de l'onglet : Gestion immobilière
ARRAY TEXT:C222(ta_Page; 4)

ta_Page{1}:="Centre"
ta_Page{2}:="Description"
ta_Page{3}:="Notes"
ta_Page{4}:="Gestion immobilière"

If (User in group:C338(Current user:C182; <>Groupe_Comptable))
	APPEND TO ARRAY:C911(ta_Page; "Facturation")
End if 

// Modifié par : Scanu Rémy (05/09/2022)
If (User in group:C338(Current user:C182; <>Groupe_Comptable))
	APPEND TO ARRAY:C911(ta_Page; "Paramètre Rétroplanning")
End if 

ta_Page:=1

FORM SET INPUT:C55([LesCentres:9]; "LC_EcranSaisie")
FORM SET OUTPUT:C54([LesCentres:9]; "LC_Liste")

ALL RECORDS:C47([LesCentres:9])
MultiSoc_Filter(->[LesCentres:9])

ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)

$vl_Fenetre:=i_FenêtreNo(1000; 700; 8; "Liste des centres"; 1; "Quit_Simple")

If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_CentreSaisie))
	READ WRITE:C146([LesCentres:9])
	MODIFY SELECTION:C204([LesCentres:9]; *)
Else 
	DISPLAY SELECTION:C59([LesCentres:9]; *)
End if 

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([LesCentres:9])

<>PR_CEL:=0

If (vb_Show)
	Général_Show
End if 