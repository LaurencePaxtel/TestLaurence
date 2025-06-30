//%attributes = {}



If (Accès_Groupe(<>Groupe_Centre))
	Process_Go(-><>PR_CEL; "Go_Centres"; "CentresListe"; 32)
End if 

//If (Accès_Groupe (<>Groupe_Jour))
//If (<>PR_Hébergement=0)
//<>PR_Hébergement:=New process("Go_Hébergement";<>L_Pile_defaut_C;"FicheSignal";"J";"")  // BS 200516 64*1024
//Else 
//Process_Show (<>PR_Hébergement)
//End if 
//End if 
