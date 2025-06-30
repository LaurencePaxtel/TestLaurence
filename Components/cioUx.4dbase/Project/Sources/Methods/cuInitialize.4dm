//%attributes = {"shared":true}
/*------------------------------------------------------------------------------
Méthode : cuInitialize
Méthode à appeler dans la base hôte pour initialiser le composant.

Historique
12/04/22 - Grégory Fromain <gregory@connect-io.fr> - Import du composant cioWeb
------------------------------------------------------------------------------*/

var $color_o : Object

$color_o:=New object:C1471()

$color_o.primary:="#21759B"
$color_o.secondary:="#F4AC45"

$color_o.notification:=New object:C1471()
$color_o.notification.information:=New object:C1471()
$color_o.notification.information.background:="#eff5fb"
$color_o.notification.information.text:="#296fa8"

$color_o.notification.warning:=New object:C1471()
$color_o.notification.warning.background:="#fffaeb"
$color_o.notification.warning.text:="#946c00"

$color_o.notification.success:=New object:C1471()
$color_o.notification.success.background:="#effaf5"
$color_o.notification.success.text:="#257953"

$color_o.notification.error:=New object:C1471()
$color_o.notification.error.background:="#feecf0"
$color_o.notification.error.text:="#cc0f35"

Use (Storage:C1525)
	Storage:C1525.color:=OB Copy:C1225($color_o; ck shared:K85:29)
End use 