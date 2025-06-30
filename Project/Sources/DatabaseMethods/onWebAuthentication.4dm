// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 13/12/21, 18:42:48
// ----------------------------------------------------
// Méthode : Sur Authentification Web
// Description
// 
//
// Paramètres
// $1  Texte  URL
// $2  Texte  En-tête+Corps HTTP
// $3  Texte  Adresse IP du navig
// $4  Texte  Adresse IP appelée 
// $5  Texte  Nom d’utilisateur
// $6  Texte  Mot de passe
// $0  Booléen  Vrai = requête acceptée, Faux = requête rejetée 
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_TEXT:C284($6)
// La page web utilise les mêmes indentifiants qu'un client 4D
C_TEXT:C284($T_NameUser; $T_Message; $T_Json)
C_LONGINT:C283($L_Erreur)
C_BOOLEAN:C305($B_Autorise; $B_Connected)
C_OBJECT:C1216($O_Output)

// Simplification de la méthode - GF le 16/12/24
$B_Autorise:=True:C214

/*
$T_NameUser:=$5

Si (Longueur($T_NameUser)>1)  // Si c'est une requête d'authentification

Si (Position("+"; $T_NameUser)=0)  // Si on autorise alors on permet d'aller chercher un token
$B_Autorise:=Valider mot de passe($T_NameUser; $6)
Fin de si 

Sinon 
$B_Autorise:=Vrai
Fin de si 

Si (Non($B_Autorise))
$O_Output:=Créer objet
$L_Erreur:=-1

$T_Message:="Erreur d'authentification"

OB FIXER($O_Output; "connected"; $B_Connected)
OB FIXER($O_Output; "message"; $T_Message; "error_code"; $L_Erreur)

$T_Json:=JSON Stringify($O_Output)
WEB ENVOYER TEXTE($T_Json)
Fin de si 
*/

// Modifié par : Scanu Rémy (08/03/2023)
If ($1="/4DACTION@")
	UTL_preprocess
	
	// Modifié par : Scanu Rémy (22/07/2024)
	// Création méthode générique pour initialiser des propriétés de l'objet w_visiteur
	outilsWebVisiteurInit(w_cookie)
End if 

$0:=$B_Autorise