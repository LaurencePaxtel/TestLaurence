//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 11-12-18, 14:50:50
// ----------------------------------------------------
// Method: Web_User_Get_privileges
// Description
// 
//
// Parameters
// ----------------------------------------------------
/*
var $1 : Integer

var $user_login; $user_proc; $user_password : Text
var $id; $ii; $user_utilisations; $pos_el : Integer
var $user_date : Date

var va_UserPlateforme : Text

TABLEAU TEXTE($ta_UserLog; 0)
TABLEAU TEXTE($tb_groupes_names; 0)

TABLEAU ENTIER LONG($tl_UserNo; 0)
TABLEAU ENTIER LONG($tb_groupes_ids; 0)
TABLEAU ENTIER LONG($tb_user_groupes_ids; 0)

TABLEAU TEXTE(<>tb_profils_user_groupes; 0)  // Les groupes définisants les privilèges d'un utilisateur

Si (Nombre de paramètres=1)
$id:=$1

LECTURE SEULEMENT([INtervenants])
CHERCHER([INtervenants]; [INtervenants]ID=$id)
Fin de si 

// La liste des groupes référencés
LIRE LISTE GROUPE($tb_groupes_names; $tb_groupes_ids)

// La liste des utilisateurs référencés
LIRE LISTE UTILISATEURS($ta_UserLog; $tl_UserNo)

Si (Taille tableau($tb_groupes_names)>0)
$tb_groupes_names:=3
$tb_groupes_ids:=3
Sinon 
$tb_groupes_names:=0
$tb_groupes_ids:=0
Fin de si 

Si (Enregistrements trouvés([INtervenants])=1)
va_UserPlateforme:=[INtervenants]IN_Plateforme

gError:=0
APPELER SUR ERREUR("i_Error")

$pos_el:=Chercher dans tableau($ta_UserLog; [INtervenants]IN_Login)

Si ($pos_el>0)
APPELER SUR ERREUR("i_Error")

// Modifié par : Scanu Rémy (04/01/2023)
Si ([INtervenants]IN_RéfUser#$tl_UserNo{$pos_el})
[INtervenants]IN_RéfUser:=$tl_UserNo{$pos_el}
Fin de si 

Fin de si 

$pos_el:=Chercher dans tableau($tl_UserNo; [INtervenants]IN_RéfUser)

Si ($pos_el>0)
LIRE PROPRIÉTÉS UTILISATEUR([INtervenants]IN_RéfUser; $user_login; $user_proc; $user_password; $user_utilisations; $user_date; $tb_user_groupes_ids)
Fin de si 

APPELER SUR ERREUR("")

Si (Taille tableau($tb_user_groupes_ids)>0)  // Si l'utilisateur a des droits sur certains groupes
TABLEAU TEXTE(<>tb_profils_user_groupes; Taille tableau($tb_user_groupes_ids))

Boucle ($ii; 1; Taille tableau($tb_user_groupes_ids))
$Position:=Chercher dans tableau($tb_groupes_ids; $tb_user_groupes_ids{$ii})

Si ($Position>0)  // Si le groupe existe toujours dans les groupes de la base
<>tb_profils_user_groupes{$ii}:=$tb_groupes_names{$Position}
Sinon 
<>tb_profils_user_groupes{$ii}:="???"
Fin de si 

Fin de boucle 

Fin de si 

Fin de si 

Web_Genere_Variable_Process(-><>tb_profils_user_groupes)
*/