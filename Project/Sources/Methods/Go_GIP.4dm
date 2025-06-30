//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_GIP
//{
//{          Lundi 18 juin 2001 à 11:27:55
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
C_BOOLEAN:C305(vb_Ville)
vb_Ville:=True:C214
C_TEXT:C284(va_Ville)
va_Ville:=("Ville"*Num:C11(vb_Ville=True:C214))+("Metro"*Num:C11(vb_Ville=False:C215))
C_TEXT:C284(va_VilleLib)
va_VilleLib:=""

i_Message("Accès : "+<>Va_DemP)
QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=<>Va_Rubrique; *)
QUERY:C277([GIP:13];  & ; [GIP:13]GI_Theme:3=<>Va_Thème)
MultiSoc_Filter(->[GIP:13])
CREATE SET:C116([GIP:13]; "E_EnCours")
ORDER BY:C49([GIP:13]; [GIP:13]GI_Nom:5; >)
FIRST RECORD:C50([GIP:13])
va_LibSsTh:="Tous"
ARRAY TEXT:C222(ta_Page; 3)
ta_Page{1}:="Thème"
ta_Page{2}:="Conditions-Horaires"
ta_Page{3}:="Notes"
ta_Page:=1
If (7=8)
	FORM SET INPUT:C55([GIP:13]; "GI_EcranSaisie")
	FORM SET OUTPUT:C54([GIP:13]; "GI_Liste")
Else 
	FORM SET INPUT:C55([GIP:13]; "GI_EcranSaisie_2")
	FORM SET OUTPUT:C54([GIP:13]; "GI_Liste_2")
End if 

If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN) | User in group:C338(Current user:C182; <>Groupe_Coordinateur) | User in group:C338(Current user:C182; <>Groupe_Régulateur))
	READ WRITE:C146([GIP:13])
Else 
	READ ONLY:C145([GIP:13])
End if 
CLOSE WINDOW:C154
If (7=8)
	$vl_Fenetre:=i_FenêtreNo(632; 436; 4; <>Va_Rubrique+" : "+<>Va_Thème; 1; "Quit_Simple")
Else 
	$vl_Fenetre:=i_FenêtreNo(717; 466; 4; <>Va_Rubrique+" : "+<>Va_Thème; 1; "Quit_Simple")
End if 
MODIFY SELECTION:C204([GIP:13]; *)
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([GIP:13])
CLEAR SET:C117("E_EnCours")
<>PR_GIP:=0
If (vb_Show)
	Général_Show
End if 

