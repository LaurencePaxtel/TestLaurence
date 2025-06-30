// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 13/12/21, 18:42:48
// ----------------------------------------------------
// Méthode : Sur démarrage serveur
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $T_Text_error : Text
var $B_Restart : Boolean

// Modifié par : Scanu Rémy (17/07/2024)
// Ajout d'une interface pour modifier port 4D et port Web
//$L_Erreur:=Port(->$B_Restart; ->$T_Text_error)

If ($B_Restart)
	ALERT:C41($T_Text_error)
	QUIT 4D:C291
Else 
	Debut_Serveur
End if 

$process_el:=New process:C317("outilsFormDialog"; 0; "Administration 4D Server"; "FormManageServer"; New object:C1471("position"; "left"); New object:C1471)