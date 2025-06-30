//---------------------------------------------------//
// Modified by: Kevin HASSAL (10/07/2020)
// Traitement spécifique pour les financeurs
//---------------------------------------------------//

[TAbles:12]TB_Texte:7:=(" "*([TAbles:12]TB_Niveau:3-1)*5)+[TAbles:12]TB_Libellé:6

//Si (([TAbles]TB_TT_Niveau=<>va_FMGrp_R) & (Ancien([TAbles]TB_Libellé)#[TAbles]TB_Libellé))

var $TT_RéférenceID : Text

Début_LienTable([TypesTables:11]TT_Libellé:4; ->$TT_RéférenceID)

If (([TAbles:12]TB_TT_Niveau:4=$TT_RéférenceID) & (Old:C35([TAbles:12]TB_Libellé:6)#[TAbles:12]TB_Libellé:6))
	
	READ WRITE:C146([Financeurs:117])
	QUERY:C277([Financeurs:117]; [Financeurs:117]FIN_Code:4=Old:C35([TAbles:12]TB_Libellé:6))
	MultiSoc_Filter(->[Financeurs:117])
	
	If (Records in selection:C76([Financeurs:117])=1)
		[Financeurs:117]FIN_Code:4:=[TAbles:12]TB_Libellé:6
		SAVE RECORD:C53([Financeurs:117])
	End if 
	
	UNLOAD RECORD:C212([Financeurs:117])
	READ ONLY:C145([Financeurs:117])
End if 