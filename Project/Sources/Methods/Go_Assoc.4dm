//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_Assoc  
//{
//{          Mercredi 29 Octobre 1997 à 12:47:45
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

C_BOOLEAN:C305(vb_GIPsél)
vb_GIPsél:=False:C215

ARRAY TEXT:C222(ta_Page; 2)
ta_Page{1}:="Adresse"
ta_Page{2}:="Commentaires"
ta_Page:=1
If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_Coordinateur) | User in group:C338(Current user:C182; <>Groupe_Régulateur))
	READ WRITE:C146([Assocs:14])
Else 
	READ ONLY:C145([Assocs:14])
End if 
FORM SET INPUT:C55([Assocs:14]; "AS_EcranSaisie")
FORM SET OUTPUT:C54([Assocs:14]; "AS_Liste")
ALL RECORDS:C47([Assocs:14])
MultiSoc_Filter(->[Assocs:14])
FIRST RECORD:C50([Assocs:14])

$vl_Fenetre:=i_FenêtreNo(632; 436; 4; "Liste des associations"; 1; "Quit_Simple")
MODIFY SELECTION:C204([Assocs:14]; *)
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([Assocs:14])
<>PR_AS:=0
If (vb_Show)
	Général_Show
End if 