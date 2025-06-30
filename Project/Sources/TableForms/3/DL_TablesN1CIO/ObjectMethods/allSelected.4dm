var $gauche_el; $haut_el; $droite_el; $bas_el; $milieuX_el : Integer
var $element_o : Object

For each ($element_o; Form:C1466.t_TabNiv1)
	$element_o.checked:=True:C214
End for each 

OBJECT GET COORDINATES:C663(*; "LB"; $gauche_el; $haut_el; $droite_el; $bas_el)

$milieuX_el:=$gauche_el+(($droite_el-$gauche_el)/2)
POST CLICK:C466($milieuX_el; $haut_el+20)