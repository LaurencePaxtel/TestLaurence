//%attributes = {}
// Method 4DREC_Object_to_Record recopie un objet dans l'enregistrement courant 
// La méthode ne stocke pas l'enregistrement ne teste pas le verrouillage
// 
// #SYNTAX: $L_Erreur:=4DREC_Object_to_Record(->table;objet) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Pointer         : Table with a current record 
//     $2 Object          : Object with value for the record

// #DATE CREATION: 19/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


C_BOOLEAN:C305($0; $B_Modified)
$B_Modified:=False:C215

C_POINTER:C301($1; $P_Table)
$P_Table:=$1
C_OBJECT:C1216($2; $O_Record)
$O_Record:=$2

ARRAY TEXT:C222($rT_Properties; 0)
OB GET PROPERTY NAMES:C1232($O_Record; $rT_Properties)

C_LONGINT:C283($L_Table)
$L_Table:=Table:C252($P_Table)


C_LONGINT:C283($i)
For ($i; 1; Get last field number:C255($L_Table))
	
	If (Is field number valid:C1000($L_Table; $i))
		
		C_POINTER:C301($P_Field)
		$P_Field:=Field:C253($L_Table; $i)
		
		C_TEXT:C284($T_Property)
		$T_Property:=FieldName_to_property($P_Field)
		
		C_LONGINT:C283($L_Pos)
		$L_Pos:=Find in array:C230($rT_Properties; $T_Property)
		If ($L_Pos>-1)
			
			C_POINTER:C301($P_Buffer)
			CLEAR VARIABLE:C89($P_Buffer)
			
			C_LONGINT:C283($L_Type)
			$L_Type:=Type:C295($P_Field->)
			Case of 
				: ($L_Type=Est un BLOB:K8:12)
					// rien
				: ($L_Type=Est une image:K8:10)
					// à partir de 16R4
				: ($L_Type=Est une date:K8:7)
					
					C_DATE:C307($D_Date)
					$D_Date:=OB Get:C1224($O_Record; $T_Property; Est une date:K8:7)
					$P_Buffer:=->$D_Date
					
				: ($L_Type=Est une heure:K8:8)
					
					C_TIME:C306($H_Time)
					$H_Time:=OB Get:C1224($O_Record; $T_Property; Est une heure:K8:8)
					$P_Buffer:=->$H_Time
					
				: ($L_Type=Est un numérique:K8:4)
					
					C_REAL:C285($R_Real)
					$R_Real:=OB Get:C1224($O_Record; $T_Property; Est un numérique:K8:4)
					$P_Buffer:=->$R_Real
					
				: ($L_Type=Est un entier:K8:5) | ($L_Type=Est un entier long:K8:6)
					
					C_LONGINT:C283($L_Long)
					$L_Long:=OB Get:C1224($O_Record; $T_Property; Est un entier long:K8:6)
					$P_Buffer:=->$L_Long
					
				: ($L_Type=Est un texte:K8:3) | ($L_Type=Est un champ alpha:K8:1)
					
					C_TEXT:C284($T_Text)
					$T_Text:=OB Get:C1224($O_Record; $T_Property; Est un texte:K8:3)
					$P_Buffer:=->$T_Text
					
				: ($L_Type=Est un booléen:K8:9)
					
					C_BOOLEAN:C305($B_Boolean)
					$B_Boolean:=OB Get:C1224($O_Record; $T_Property; Est un booléen:K8:9)
					$P_Buffer:=->$B_Boolean
					
				Else 
					//TRACE
			End case 
			
			If (Not:C34(Is nil pointer:C315($P_Buffer)))
				If ($P_Field->#$P_Buffer->)
					$P_Field->:=$P_Buffer->
					$B_Modified:=True:C214
				End if 
			End if 
		End if 
	End if 
End for 

$0:=$B_Boolean

// EOM
