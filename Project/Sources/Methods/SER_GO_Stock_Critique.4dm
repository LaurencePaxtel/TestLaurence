//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 14/06/2020, 15:22:56
// ----------------------------------------------------
// Method: SER_GO_Stock_Critique
// Description
// La méthode de lancement des process auto côté serveur
// Pour la prise en compte de la gestion multi-sociétés
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($i)

ARRAY TEXT:C222($tb_ref_structure; 0)

READ ONLY:C145([Structures:79])
ALL RECORDS:C47([Structures:79])

SELECTION TO ARRAY:C260([Structures:79]Ref_Structure:3; $tb_ref_structure)

For ($i; 1; Size of array:C274($tb_ref_structure))
	MultiSoc_Init_On_Server(2; $tb_ref_structure{$i})
	
	<>PR_GI_Stock:=New process:C317("GI_Stock_Critique"; 0; "Gestion de stock : Le stock critique ("+<>ref_soc_active+")"; True:C214; <>ref_soc_active; *)
End for 