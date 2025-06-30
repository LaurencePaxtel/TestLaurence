//%attributes = {}
// Method Handle_user gère l'enregistrement d'un USER 
// 
// 
// #SYNTAX: $L_Erreur:=Handle_user(user;pw_clair;->message) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Text            : user
//     $2 Text            : pw en clair
//     $3 Pointer         : message en retour

// #DATE CREATION: 11/10/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_LONGINT:C283($0)

C_TEXT:C284($1; $T_Selecteur)
$T_Selecteur:=$1
C_TEXT:C284($2; $T_Param2)
$T_Param2:=$2
C_TEXT:C284($3; $T_Param3)
$T_Param3:=$3
C_TEXT:C284($4; $T_Param4)
$T_Param4:=$4
C_POINTER:C301($5; $P_Param5)
$P_Param5:=$5
C_POINTER:C301($6; $P_Output)
$P_Output:=$6

C_LONGINT:C283($L_MyError)
$L_MyError:=1

C_DATE:C307($D_Current_date)
$D_Current_date:=Current date:C33
C_TIME:C306($H_Current_time)
$H_Current_time:=Current time:C178

C_LONGINT:C283($L_Trouve)
Case of 
	: ($T_Selecteur="user_create")
		
		$P_Param5->:=""
		
		QUERY:C277([TAB_LOGIN:75]; [TAB_LOGIN:75]User:2=$T_Param2; *)
		QUERY:C277([TAB_LOGIN:75];  & ; [TAB_LOGIN:75]Pw:3=$T_Param3)
		//MultiSoc_Filter (->[TAB_LOGIN])
		
		If (Records in selection:C76([TAB_LOGIN:75])=0)
			
			CREATE RECORD:C68([TAB_LOGIN:75])
			//MultiSoc_Init_Structure (->[TAB_LOGIN])
			[TAB_LOGIN:75]User:2:=$T_Param2
			[TAB_LOGIN:75]Pw:3:=$T_Param3  // PWtoDigest ($T_Param3)
			[TAB_LOGIN:75]User_level_I:7:=Num:C11($T_Param4)
			[TAB_LOGIN:75]Date_modif_D:5:=$D_Current_date
			[TAB_LOGIN:75]Heure_modif_H:6:=$H_Current_time
			[TAB_LOGIN:75]Token_T:4:=doToken([TAB_LOGIN:75]Date_modif_D:5; [TAB_LOGIN:75]Heure_modif_H:6)  // en dernier !
			SAVE RECORD:C53([TAB_LOGIN:75])
			
			$P_Param5->:=[TAB_LOGIN:75]Token_T:4
			OB SET:C1220($P_Output->; "user_level"; [TAB_LOGIN:75]User_level_I:7)
		End if 
		
		// $L_MyError vaut toujours 1
		
	: ($T_Selecteur="user_set_token")
		
		READ WRITE:C146([TAB_LOGIN:75])
		
		QUERY:C277([TAB_LOGIN:75]; [TAB_LOGIN:75]User:2=$T_Param2)
		//MultiSoc_Filter (->[TAB_LOGIN])
		Case of 
			: (Records in selection:C76([TAB_LOGIN:75])=0)
				$L_MyError:=-1
			Else 
				$L_MyError:=1
				
				[TAB_LOGIN:75]Date_modif_D:5:=$D_Current_date
				[TAB_LOGIN:75]Heure_modif_H:6:=$H_Current_time
				[TAB_LOGIN:75]Token_T:4:=doToken([TAB_LOGIN:75]Date_modif_D:5; [TAB_LOGIN:75]Heure_modif_H:6)  // en dernier !
				SAVE RECORD:C53([TAB_LOGIN:75])
		End case 
		$P_Param5->:=[TAB_LOGIN:75]Token_T:4
		OB SET:C1220($P_Output->; "user_level"; [TAB_LOGIN:75]User_level_I:7)
		
		READ ONLY:C145([TAB_LOGIN:75])
		
	: ($T_Selecteur="user_check_token")
		
		C_TEXT:C284($T_Token)
		$T_Token:=$P_Param5->
		
		C_TEXT:C284($T_Token_today)
		$T_Token_today:=String:C10(Year of:C25($D_Current_date); "0000")+String:C10(Month of:C24($D_Current_date); "00")+String:C10(Day of:C23($D_Current_date); "00")  // entete du token attendu aujourd'hui
		If (Position:C15($T_Token_today; $T_Token)=0)
			$L_MyError:=-2
		Else 
			
			SET QUERY DESTINATION:C396(Vers variable:K19:4; $L_Trouve)
			QUERY:C277([TAB_LOGIN:75]; [TAB_LOGIN:75]Token_T:4=$T_Token)
			//MultiSoc_Filter (->[TAB_LOGIN])
			SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
			If ($L_Trouve#1)
				$L_MyError:=-3
			End if 
		End if 
		
	: ($T_Selecteur="user_test")
		
		QUERY:C277([TAB_LOGIN:75]; [TAB_LOGIN:75]User:2=$T_Param2; *)
		QUERY:C277([TAB_LOGIN:75];  & ; [TAB_LOGIN:75]Token_T:4=$P_Param5->)
		//MultiSoc_Filter (->[TAB_LOGIN])
		
		$L_Trouve:=Records in selection:C76([TAB_LOGIN:75])
		Case of 
			: ($L_Trouve=0)
				$L_MyError:=-4
			: ($L_Trouve>1)
				$L_MyError:=-5
			Else 
				OB SET:C1220($P_Output->; "user_level"; [TAB_LOGIN:75]User_level_I:7)
		End case 
		
		
	Else 
		//TRACE
End case 
UNLOAD RECORD:C212([TAB_LOGIN:75])

C_TEXT:C284($T_Message)
Case of 
	: ($L_MyError=-1)
		$T_Message:="Utilisateur ou PW incorrect"
	: ($L_MyError=-2)
		$T_Message:="Token périmé"
	: ($L_MyError=-3)
		$T_Message:="Token inconnu"
	: ($L_MyError=-4)
		$T_Message:="Utilisateur ou token inconnu"
	: ($L_MyError=-5)
		$T_Message:="Utilisateur ou token en doublon"
	Else 
		$T_Message:="OK"
End case 

OB SET:C1220($P_Output->; "message"; $T_Message)
OB SET:C1220($P_Output->; "error_code"; $L_MyError)


$0:=$L_MyError

// EOM


