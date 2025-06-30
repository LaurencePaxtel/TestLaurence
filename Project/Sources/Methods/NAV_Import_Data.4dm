//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 17/09/18, 17:44:37
// ----------------------------------------------------
// Méthode : NAV_Import_Data
// Description
// 
//
// Paramètres
// ----------------------------------------------------

If (False:C215)  // Historique
	// 22/07/22 remy@connect-io.fr - Correction de la méthode lors de la création d'une nouvelle structure
End if 

READ ONLY:C145([Structures:79])
QUERY:C277([Structures:79]; [Structures:79]Ref_Structure:3=<>ref_soc_active)

If (Records in selection:C76([Structures:79])=1)
	NAV_Import_Menus
End if 