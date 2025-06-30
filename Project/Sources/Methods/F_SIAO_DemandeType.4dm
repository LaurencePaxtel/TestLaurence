//%attributes = {}
C_TEXT:C284($0)
C_LONGINT:C283($1)
Case of 
	: ($1=1)
		$0:="Individuelle"
	: ($1=2)
		$0:="Famille"
	: ($1=3)
		$0:="Groupe"
	Else 
		$0:=""
End case 