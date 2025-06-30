//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_GIP_RG
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)
C_BOOLEAN:C305(vb_GIPsél)
vb_GIPsél:=True:C214
i_Message("Accès : "+<>Va_DemP)
QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=<>Va_Rubrique; *)
QUERY:C277([GIP:13];  & ; [GIP:13]GI_Theme:3=<>Va_Thème)
MultiSoc_Filter(->[GIP:13])
CREATE SET:C116([GIP:13]; "E_EnCours")
ORDER BY:C49([GIP:13]; [GIP:13]GI_Nom:5; >)
FIRST RECORD:C50([GIP:13])
va_LibSsTh:="Tous"
FORM SET INPUT:C55([GIP:13]; "GI_EcranSaisie")
FORM SET OUTPUT:C54([GIP:13]; "GI_Liste")
ARRAY TEXT:C222(ta_Page; 3)
ta_Page{1}:="Thème"
ta_Page{2}:="Conditions-Horaires"
ta_Page{3}:="Notes"
ta_Page:=1

CLOSE WINDOW:C154
$vl_Fenetre:=i_FenêtreNo(632; 436; 4; <>Va_Rubrique+" : "+<>Va_Thème; 1; "Quit_Simple")
MODIFY SELECTION:C204([GIP:13]; *)
CLOSE WINDOW:C154
READ ONLY:C145([GIP:13])
CLEAR SET:C117("E_EnCours")
<>PR_GIPRG:=0



