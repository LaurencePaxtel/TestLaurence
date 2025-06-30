var $colonne_el; $ligne_el; $indice_el : Integer
var $line_c : Collection

LISTBOX GET CELL POSITION:C971(LB_Recherche_appel; $colonne_el; $ligne_el)

If (tb_centre_choix{$ligne_el}=False:C215)
	ALERT:C41("Veuillez cocher la boite à cocher de la ligne avant de pouvoir modifier la quantité")
	tb_centre_liste_quantite{$ligne_el}:=0
End if 

$line_c:=Form:C1466.lineInfo.indices("id = :1"; tb_centre_liste_id{$ligne_el})
$indice_el:=$line_c[0]

Form:C1466.lineInfo[$indice_el].quantite:=tb_centre_liste_quantite{$ligne_el}