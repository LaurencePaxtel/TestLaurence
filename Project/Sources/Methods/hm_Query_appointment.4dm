//%attributes = {}
// Method hm_Query_appointment va chercher le rendez-vous
// 
// #SYNTAX: $L_Erreur:=hm_Query_appointment($L_ID;->$T_Message 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Long            : ID du rendez-vous
//     $2 Pointer         : Message d'erreur

// #DATE CREATION: 08/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_LONGINT:C283($0; $L_My_Error)
$L_My_Error:=1

C_LONGINT:C283($1; $L_ID_appointment)
$L_ID_appointment:=$1
C_POINTER:C301($2; $P_Message)
$P_Message:=$2

SET QUERY LIMIT:C395(1)
QUERY:C277([APPOINTMENTS:73]; [APPOINTMENTS:73]ID:1=$L_ID_appointment)
MultiSoc_Filter(->[APPOINTMENTS:73])
SET QUERY LIMIT:C395(0)

Case of 
	: (Records in selection:C76([APPOINTMENTS:73])<1)
		$L_My_Error:=-1
	Else 
		
		If (Read only state:C362([APPOINTMENTS:73]))
			
			$L_My_Error:=-2
		Else 
			
			LOAD RECORD:C52([APPOINTMENTS:73])
			If (Locked:C147([APPOINTMENTS:73]))
				C_LONGINT:C283($L_Process)
				C_TEXT:C284($T_User; $T_Session; $T_Process)
				LOCKED BY:C353([APPOINTMENTS:73]; $L_Process; $T_User; $T_Session; $T_Process)
				
				$L_My_Error:=-3
			End if 
		End if 
End case 

C_TEXT:C284($T_Message)
Case of 
	: ($L_My_Error=-1)
		$T_Message:="Le rendez-vous "+String:C10($L_ID_appointment)+" n'existe plus"
	: ($L_My_Error=-2)
		$T_Message:="La table "+Table name:C256(->[APPOINTMENTS:73])+" est en lecture seule"
	: ($L_My_Error=-3)
		$T_Message:="L'enregistrement de "+Table name:C256(->[APPOINTMENTS:73])+" est verrouillé par: "+$T_User+" - process: "+$T_Process
	Else 
		$T_Message:="OK"
End case 

$0:=$L_My_Error
$P_Message->:=$T_Message

// EOM

