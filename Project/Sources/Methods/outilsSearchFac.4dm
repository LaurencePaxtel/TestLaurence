//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 26/08/21, 15:31:54
// ----------------------------------------------------
// Méthode : outilsSearchFac
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)  //[Factures]FAC_No_Piece
C_LONGINT:C283($1)
C_TEXT:C284($2)  // [Reglements]REG_Libelle_Plus_1

C_LONGINT:C283($i_el)
C_BOOLEAN:C305($stop_b)

Case of 
	: ($1=1)
		
	: ($1=2)
		
		For ($i_el; Length:C16($2); 1; -1)
			
			If (Character code:C91(" ")#Character code:C91($2[[$i_el]]))
				$0:=Insert string:C231($0; $2[[$i_el]]; 0)
			Else 
				$stop_b:=True:C214
			End if 
			
			If ($stop_b=True:C214)
				$i_el:=1
			End if 
			
		End for 
		
End case 