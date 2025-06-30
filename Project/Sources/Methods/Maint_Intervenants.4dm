//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 27/08/18, 04:38:15
// ----------------------------------------------------
// Méthode : Maint_Intervenants
// Description
// 
//
// Paramètres
// ----------------------------------------------------

ALL RECORDS:C47([INtervenants:10])
MultiSoc_Filter(->[INtervenants:10])
ORDER BY:C49([INtervenants:10]; [INtervenants:10]ID:16; >)

While (Not:C34(End selection:C36([INtervenants:10])))
	
	If ([INtervenants:10]ID:16=0)
		[INtervenants:10]ID:16:=(Random:C100%(999+1))+1
		SAVE RECORD:C53([INtervenants:10])
	End if 
	
	
	NEXT RECORD:C51([INtervenants:10])
End while 

ALERT:C41("Opération effectuée avec succès.")