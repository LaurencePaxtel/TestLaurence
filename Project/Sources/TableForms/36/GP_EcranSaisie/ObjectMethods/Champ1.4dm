var $notification_cs : Object

var $groupe_es : cs:C1710.GrouPeSelection

$notification_cs:=cuToolGetClass("Notification").new()

$groupe_es:=ds:C1482.GrouPe.query("GP_Numéro = :1"; [GrouPe:36]GP_Numéro:7)
outilsOrdaSearchByRefStctre(->$groupe_es)

If ($groupe_es.length>0)
	$notification_cs.popUp("warning"; ""; "Un groupe avec le numéro "+[GrouPe:36]GP_Numéro:7+" existe déjà, merci de choisir un autre nom de groupe")
End if 

OBJECT SET ENABLED:C1123(*; "Bt_INVok"; ($groupe_es.length=0))