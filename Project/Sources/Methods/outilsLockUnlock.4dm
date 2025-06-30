//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Administrator
// Date et heure : 29/03/21, 09:16:52
// ----------------------------------------------------
// Méthode : outilsLockUnlock
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)
C_OBJECT:C1216($1)
C_BOOLEAN:C305($2)  // Booléen qui indique qu'on veut forcer le passage

C_OBJECT:C1216($statut_o)

$statut_o:=$1.lock()

If (Bool:C1537($statut_o.success)=True:C214) | ($2=True:C214)
	$statut_o:=$1.unlock()
	
	$0:=(Bool:C1537($statut_o.success)=True:C214)
End if 