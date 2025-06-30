// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 26/08/18, 11:50:26
// ----------------------------------------------------
// Méthode : LB_NAV_Structures
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283(order_max)

ARRAY LONGINT:C221($tb_uid_users; 0)

Case of 
	: (Form event code:C388=Sur double clic:K2:5)
		READ WRITE:C146([Structures:79])
		
		QUERY:C277([Structures:79]; [Structures:79]UID:1=Form:C1466.elementSelected[0].UID)
		MultiSoc_Filter(->[Structures:79])
		
		QUERY:C277([Structure_User:80]; [Structure_User:80]UID_Structure:1=[Structures:79]UID:1)
		MultiSoc_Filter(->[Structure_User:80])
		
		SELECTION TO ARRAY:C260([Structure_User:80]UID_Utilisateur:2; $tb_uid_users)
		QUERY WITH ARRAY:C644([INtervenants:10]ID:16; $tb_uid_users)
		
		order_max:=Records in selection:C76([NAV_Sous_Menus:78])
		
		MODIFY RECORD:C57([Structures:79])
		
		UNLOAD RECORD:C212([Structures:79])
		UNLOAD RECORD:C212([Structure_User:80])
End case 