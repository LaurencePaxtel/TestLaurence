//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 25/10/21, 16:56:27
// ----------------------------------------------------
// Méthode : PAR_Gestion
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_BOOLEAN:C305($2)

C_LONGINT:C283($pos_el)

If ($1->="@(@)")
	$pos_el:=Position:C15("("; $1->)
	
	If ($2=True:C214)
		$0:=Substring:C12($1->; 0; $pos_el-2)
	Else 
		$0:=Substring:C12($1->; $pos_el+1; Position:C15(")"; $1->)-1)
	End if 
	
	$1->:=Substring:C12($1->; 0; $pos_el-2)
End if 