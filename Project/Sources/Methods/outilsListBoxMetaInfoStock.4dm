//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 19/01/22, 11:36:45
// ----------------------------------------------------
// Méthode : outilsListBoxMetaInfoStock
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_OBJECT:C1216($0)

C_COLLECTION:C1488($1)
C_LONGINT:C283($2)

C_OBJECT:C1216($meta_o)

If (Num:C11(This:C1470.hebergeID)=[HeberGement:5]HG_HB_ID:19)
	$meta_o:=New object:C1471("stroke"; "red")
End if 

$0:=$meta_o