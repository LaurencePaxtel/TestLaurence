//%attributes = {}
// Method MIG_Delete_Users supprime tous les utilisateur hors super_U
// 
// #SYNTAX: $L_Erreur:=MIG_Delete_Users
// #PARAMETERS:
//     None

// #DATE CREATION: 12/05/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

ARRAY TEXT:C222($rT_UserNames; 0)
GET USER LIST:C609($rT_UserNames; $rL_UserID)

C_LONGINT:C283($i)
For ($i; 1; Size of array:C274($rL_UserID))
	
	If ($rL_UserID{$i}<0)
		DELETE USER:C615($rL_UserID{$i})
	End if 
End for 


// EOM

