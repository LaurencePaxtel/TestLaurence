var $position_t : Text

// Modifié par : Scanu Rémy (25/10/2022)
vb_Start:=False:C215

$position_t:="center"
outilsCreateWindowsForm("IN_EcranSaisie"; ->$position_t; New object:C1471; New object:C1471("entree"; "IN_EcranSaisie"; \
"sortie"; "IN_Liste"; \
"entreeClose"; "IN_EcranSaisie"; \
"sortieClose"; "liste"; \
"table"; "INtervenants"; \
"useFormTable"; True:C214; \
"addNewRecord"; True:C214))

/*FORM FIXER ENTRÉE([INtervenants]; "IN_EcranSaisie")
FORM FIXER SORTIE([INtervenants]; "IN_Liste")

AJOUTER ENREGISTREMENT([INtervenants]; *)*/

If (OK=1)
	ADD TO SET:C119([INtervenants:10]; "E_Courant")
End if 

USE SET:C118("E_Courant")
ORDER BY:C49([INtervenants:10]; [INtervenants:10]IN_Nom:4; >)