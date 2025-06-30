var $colonne_el; $ligne_el; $indice_el : Integer
var $line_c : Collection

LISTBOX GET CELL POSITION:C971(LB_Recherche_appel; $colonne_el; $ligne_el)

$line_c:=Form:C1466.lineInfo.indices("id = :1"; tb_centre_liste_id{$ligne_el})
$indice_el:=$line_c[0]

Form:C1466.lineInfo[$indice_el].checked:=tb_centre_choix{$ligne_el}

If (tb_centre_choix{$ligne_el}=True:C214)
	Form:C1466.lineInfo[$indice_el].quantite:=1
	tb_centre_liste_quantite{$ligne_el}:=1
Else 
	Form:C1466.lineInfo[$indice_el].quantite:=0
	tb_centre_liste_quantite{$ligne_el}:=0
End if 

// Modifié par : Scanu Rémy (27/03/2023)
Form:C1466.montant:=0
Form:C1466.lineInfo[$indice_el].montant:=0

tb_centre_liste_montant{$ligne_el}:=0

OBJECT SET VISIBLE:C603(*; "montant@"; tb_centre_choix{$ligne_el})