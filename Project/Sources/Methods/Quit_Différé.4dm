//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : Quit_Différé
//{
//{          Lundi 26 Juillet 2004 à 16:51:18
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

If (False:C215)
	
	If (User in group:C338(Current user:C182; <>Groupe_DEVELOP) | User in group:C338(Current user:C182; <>Groupe_ADMIN))
		P_Debut_Suite
		
		CANCEL:C270
	Else 
		CONFIRM:C162("Vous allez quitter l'application !"+Char:C90(13)+"Confirmez-vous ?")
		
		If (OK=1)
			CANCEL:C270
			QUIT 4D:C291
		End if 
		
	End if 
	
End if 

// #20180503-1
P_Debut_Suite

CANCEL:C270