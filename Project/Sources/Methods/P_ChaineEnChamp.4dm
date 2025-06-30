//%attributes = {}

C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_LONGINT:C283(ve_Type)
C_LONGINT:C283(vl_Long)
C_BOOLEAN:C305(vb_Index)


GET FIELD PROPERTIES:C258(Field:C253($1; $2); ve_Type; vl_Long; vb_Index)
Case of 
	: (ve_Type=Est un champ alpha:K8:1)
		Field:C253($1; $2)->:=$3
		
	: (ve_Type=Est un texte:K8:3)
		$3:=Replace string:C233($3; "≤"; Char:C90(13))
		Field:C253($1; $2)->:=$3
		
	: (ve_Type=Est un numérique:K8:4)
		Field:C253($1; $2)->:=Num:C11($3)
		
	: (ve_Type=Est un entier:K8:5)
		Field:C253($1; $2)->:=Num:C11($3)
		
	: (ve_Type=Est un entier long:K8:6)
		Field:C253($1; $2)->:=Num:C11($3)
		
	: (ve_Type=Est une date:K8:7)
		Field:C253($1; $2)->:=Date:C102($3)
		
	: (ve_Type=Est une heure:K8:8)
		Field:C253($1; $2)->:=Time:C179($3)
		
	: (ve_Type=Est un booléen:K8:9)
		Field:C253($1; $2)->:=($3="1")
		
	: (ve_Type=Est une image:K8:10)
	: (ve_Type=Est une sous table:K8:11)
	: (ve_Type=Est un BLOB:K8:12)
End case 