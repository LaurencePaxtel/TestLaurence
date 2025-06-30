//%attributes = {}
// Method API_Coordinateur_regulateur retourne les noms des coordinateur et régulateur par défaut 
// 
// #SYNTAX: $L_Erreur:=API_Coordinateur_regulateur("GET";->$O_Output) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK 
//     $1 Pointer         : 

// #DATE CREATION: 26/02/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


// La méthode SET n'est pas implémentée


C_TEXT:C284($1; $T_Selecteur)
$T_Selecteur:=$1
C_POINTER:C301($2; $P_Output)
$P_Output:=$2

C_LONGINT:C283($0; $L_MyError)
$L_MyError:=1
Case of 
	: ($T_Selecteur="get")
		
		// inspiré de la méthode DébutInitCoord
		
		SET QUERY LIMIT:C395(1)
		QUERY:C277([DePart:1]; [DePart:1]DP_ReferenceID:1=-25)
		MultiSoc_Filter(->[DePart:1])
		SET QUERY LIMIT:C395(0)
		
		C_LONGINT:C283($L_Trouve)
		$L_Trouve:=Records in selection:C76([DePart:1])
		C_TEXT:C284($T_String)
		$T_String:=[DePart:1]DP_Texte:7
		UNLOAD RECORD:C212([DePart:1])
		
		C_LONGINT:C283($L_Pos)
		$L_Pos:=Position:C15(";"; $T_String)
		
		C_TEXT:C284($T_Coordinateur; $T_Regulateur)
		$T_Coordinateur:=""
		$T_Regulateur:=""
		Case of 
			: ($L_Trouve#1)
				$L_MyError:=-3
			: ($L_Pos=0)
				$T_Coordinateur:=$T_String
			Else 
				If ($L_Pos=1)
					$T_Regulateur:=Substring:C12($T_String; Position:C15(";"; $T_String)+1)
				Else 
					$T_Coordinateur:=Substring:C12($T_String; 1; Position:C15(";"; $T_String)-1)
					$T_Regulateur:=Substring:C12($T_String; Position:C15(";"; $T_String)+1)
				End if 
		End case 
		OB SET:C1220($P_Output->; "regulateur"; $T_Coordinateur)
		OB SET:C1220($P_Output->; "coordinateur"; $T_Coordinateur)
		
	: ($T_Selecteur="set")
		$L_MyError:=-1
	Else 
		$L_MyError:=-2
End case 

Case of 
	: ($L_MyError=-1)
		$T_Message:="Sélecteur pas encore développé"
	: ($L_MyError=-2)
		$T_Message:="Sélecteur inconnu"
	: ($L_MyError=-3)
		$T_Message:=String:C10($L_Trouve)+" enregistrement pour coordinateur ou régulateur. Normal = 1"
	Else 
		$T_Message:="OK"
End case 

$0:=$L_MyError
OB SET:C1220($P_Output->; "message"; $T_Message)

// EOM

