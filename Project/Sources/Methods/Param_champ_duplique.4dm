//%attributes = {"preemptive":"capable"}
// Method Param_champ_duplique  
// 
// 
// #SYNTAX: $L_Erreur:=Param_champ_duplique(param_1;->param_N) 
// #PARAMETERS:
//     None
//     $0 Long            : error code. 1 = OK
//     $1 Text            : 
//     $2 Pointer         : 
//     $3 Date            : 
//     $4 Time            : 
//     $5 BLOB            : 
//     $6 Picture         : 
//     $7 Object          :
//     $8 real            :
//     $9 Boolean         :

// #DATE CREATION: 23/01/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_TEXT:C284($1)

C_TEXT:C284($T_Selecteur; $T_Text_error)
C_LONGINT:C283($L_Erreur)
C_BOOLEAN:C305($B_RO)

$T_Selecteur:=$1

Case of 
	: ($T_Selecteur="Charger")
		QUERY:C277([DePart2:76]; [DePart2:76]Reference_ID:4=-29)  // -29 c'est pour rester cohérent avec l'ancien système
		MultiSoc_Filter(->[DePart2:76])
		
		If (Records in selection:C76([DePart2:76])=0)
			CREATE RECORD:C68([DePart2:76])
			MultiSoc_Init_Structure(->[DePart2:76])
			
			[DePart2:76]Reference_ID:4:=-29
			[DePart2:76]Label:3:="Champ à dupliquer"
			SAVE RECORD:C53([DePart2:76])
			
			Param_champ_duplique("set")
		End if 
		
	: ($T_Selecteur="liberer")
		UNLOAD RECORD:C212([DePart2:76])
	: ($T_Selecteur="set") | ($T_Selecteur="get")
		
		If ([DePart2:76]Reference_ID:4#-29)
			Param_champ_duplique("Charger")
		End if 
		
		If ($T_Selecteur="set")
			READ WRITE:C146([DePart2:76])
			
			LOAD RECORD:C52([DePart2:76])
			
			READ ONLY:C145([DePart2:76])
		End if 
		
	Else 
		TRACE:C157
End case 