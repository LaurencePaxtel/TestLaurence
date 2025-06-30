// Method File_navigateur.button_parcourir  
//  
// #SYNTAX: $L_Erreur:=File_navigateur.button_parcourir(param_1;->param_N) 
// #PARAMETERS:
//     None

// #DATE CREATION: 10/05/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


// On ajoute des fichiers

C_LONGINT:C283($L_Erreur)
$L_Erreur:=FileBrowser_upload

If ($L_Erreur=1)
	SET TIMER:C645(-1)
End if 

// EOM
