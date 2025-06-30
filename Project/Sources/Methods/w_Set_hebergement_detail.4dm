//%attributes = {}
// Method w_Set_hebergement_detail met à jour un hébergement
// 
// #SYNTAX: $L_Erreur:=w_Set_hebergement_detail(json) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Text            : json

// #DATE CREATION: 18/08/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_LONGINT:C283($0; $L_MyError)
$L_MyError:=1

C_TEXT:C284($1; $T_JSON)
$T_JSON:=$1
C_POINTER:C301($2; $P_Message)
$P_Message:=$2

C_OBJECT:C1216($O_Input)
$O_Input:=JSON Parse:C1218($T_JSON)

If (False:C215)
	// Pour l'instant j'oublie l'individu
	C_OBJECT:C1216($O_Heberge)
	$O_Heberge:=OB Get:C1224($O_Input; "heberge"; Est un objet:K8:27)
End if 


C_OBJECT:C1216($O_Hebergement)
$O_Hebergement:=OB Get:C1224($O_Input; "hebergement"; Est un objet:K8:27)

C_TEXT:C284($T_ID)
$T_ID:=FieldName_to_property(->[HeberGement:5]HG_ReferenceID:1)

C_LONGINT:C283($L_ID)
$L_ID:=OB Get:C1224($O_Hebergement; $T_ID; Est un entier long:K8:6)

SET QUERY LIMIT:C395(1)
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_ReferenceID:1=$L_ID)
SET QUERY LIMIT:C395(0)

Case of 
	: (Records in selection:C76([HeberGement:5])#1)
		$L_MyError:=-1
	Else 
		
		C_BOOLEAN:C305($B_RO)
		$B_RO:=4DTABLE_MakeRW(->[HeberGement:5])
		
		C_LONGINT:C283($L_Erreur)
		C_TEXT:C284($T_Message)
		$L_Erreur:=4DREC_Load_Record(->[HeberGement:5]; ->$T_Message)
		If ($L_Erreur#1)
			$L_MyError:=-2
		Else 
			C_BOOLEAN:C305($B_Modified)
			$B_Modified:=4DREC_Object_to_Record(->[HeberGement:5]; $O_Hebergement)
			If ($B_Modified)
				SAVE RECORD:C53([HeberGement:5])
			End if 
		End if 
		UNLOAD RECORD:C212([HeberGement:5])
		4DTABLE_MakeRW_Restore(->[HeberGement:5]; $B_RO)
End case 

Case of 
	: ($L_MyError=-1)
		$T_Message:="Cet hébergement n'existe plus: "+String:C10($L_ID)
	: ($L_MyError=-2)
		$T_Message:=$T_Message
	Else 
		$T_Message:="OK"
End case 

$P_Message->:=$T_Message
$0:=$L_MyError

// EOM





