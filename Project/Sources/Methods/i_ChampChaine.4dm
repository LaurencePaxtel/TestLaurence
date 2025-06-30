//%attributes = {}
C_TEXT:C284($0)
$0:=""

C_POINTER:C301($1)
C_LONGINT:C283(ve_Type)
C_LONGINT:C283(vl_Long)
C_BOOLEAN:C305(vb_Index)

GET FIELD PROPERTIES:C258($1; ve_Type; vl_Long; vb_Index)
Case of 
	: (ve_Type=Est un champ alpha:K8:1)
		$0:=$1->
	: (ve_Type=Est un texte:K8:3)
		
		$0:=$1->
		$0:=Replace string:C233($0; "≤"; "-")
		$0:=Replace string:C233($0; Char:C90(13); "≤")
		
	: (ve_Type=Est un numérique:K8:4)
		$0:=String:C10($1->)
	: (ve_Type=Est un entier:K8:5)
		$0:=String:C10($1->)
	: (ve_Type=Est un entier long:K8:6)
		$0:=String:C10($1->)
	: (ve_Type=Est une date:K8:7)
		$0:=String:C10($1->; Interne date court:K1:7)
	: (ve_Type=Est une heure:K8:8)
		$0:=String:C10($1->; h mn s:K7:1)
	: (ve_Type=Est un booléen:K8:9)
		
		If ($1->)
			$0:="Oui"
		Else 
			$0:="Non"
		End if 
		
	: (ve_Type=Est une image:K8:10)
	: (ve_Type=Est une sous table:K8:11)
	: (ve_Type=Est un BLOB:K8:12)
End case 