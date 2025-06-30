var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

ON ERR CALL:C155("i_Error")

CREATE SET:C116([INtervenants:10]; "$selectionEnCours_es")
USE SET:C118("UserSet")

If (Records in selection:C76([INtervenants:10])>0)
	CONFIRM:C162("Souhaitez-vous vraiment supprimer "+Choose:C955(Records in selection:C76([INtervenants:10])>1; "ces utilisateurs"; "cet utilisateur")+" ?"; "Oui"; "Non")
	
	If (OK=1)
		$intervenant_es:=Create entity selection:C1512([INtervenants:10])
		
		For each ($intervenant_e; $intervenant_es)
			DELETE USER:C615($intervenant_e.IN_RéfUser)
		End for each 
		
		DELETE SELECTION:C66([INtervenants:10])
	End if 
	
End if 

USE SET:C118("$selectionEnCours_es")
ORDER BY:C49([INtervenants:10]; [INtervenants:10]IN_Nom:4; >)

CLEAR SET:C117("$selectionEnCours_es")
ON ERR CALL:C155("")