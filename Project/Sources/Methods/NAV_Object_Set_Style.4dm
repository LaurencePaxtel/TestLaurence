//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 13/07/18, 12:39:59
// ----------------------------------------------------
// Méthode : NAV_Object_Set_Style
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($object; $1)
C_POINTER:C301($2)
$object:=$1
object_2:=$2

OBJECT SET FONT SIZE:C165(*; $object; 12)
OBJECT SET FONT STYLE:C166(*; $object; Gras:K14:2)
OBJECT SET FONT:C164(*; $object; "Arial")
OBJECT SET FONT SIZE:C165(object_2->; 12)