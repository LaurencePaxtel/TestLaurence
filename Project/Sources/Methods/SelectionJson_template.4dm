//%attributes = {}
// Method SelectionJson_template fait une template pour la commande selection to json 
// 
// #SYNTAX: $O_Template:=SelectionJson_template(->[table]) 
// #PARAMETERS:
//     $0 Objet           : objet contenant la template 
//     $1 Pointer         : Pointeur sur une table pour faire le selecteur

// #DATE CREATION: 22/11/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_OBJECT:C1216($0)
C_POINTER:C301($1)

C_LONGINT:C283($i; $L_Table)
C_BOOLEAN:C305($B_16R4)
C_POINTER:C301($P_Table; $P_Nil)
C_OBJECT:C1216($O_Template)

$P_Table:=$1

ASSERT:C1129(Is table number valid:C999(Table:C252($P_Table)); "la table n'existe pas")

$B_16R4:=(Num:C11(Application version:C493)>=1640)  // A partir de 16R4
$L_Table:=Table:C252($P_Table)

For ($i; 1; Get last field number:C255($P_Table))
	
	If (Is field number valid:C1000($L_Table; $i))
		
		Case of 
			: (Type:C295((Field:C253($L_Table; $i))->)=Est une image:K8:10) & ($B_16R4=False:C215)
				OB SET:C1220($O_Template; FieldName_to_property(Field:C253($L_Table; $i)); $P_Nil)
			: (Type:C295((Field:C253($L_Table; $i))->)=Est un BLOB:K8:12)
				OB SET:C1220($O_Template; FieldName_to_property(Field:C253($L_Table; $i)); $P_Nil)
			Else 
				OB SET:C1220($O_Template; FieldName_to_property(Field:C253($L_Table; $i)); (Field:C253($L_Table; $i)))
		End case 
		
	End if 
	
	CLEAR VARIABLE:C89($P_Nil)
End for 

$0:=$O_Template