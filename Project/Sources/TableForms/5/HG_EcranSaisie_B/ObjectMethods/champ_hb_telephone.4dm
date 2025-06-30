// Method [HeberGement].HG_EcranSaisie_B.Champ  
// 
// 
// #SYNTAX: $L_Erreur:=[HeberGement].HG_EcranSaisie_B.Champ(param_1;->param_N) 
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

// #DATE CREATION: 20/07/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_TEXT:C284($T_Message)
C_LONGINT:C283($L_Erreur)

// #20170720-2
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		OBJECT SET FORMAT:C236([HeBerge:4]HB_Telephone:66; "##-##-##-##-##")
	: (Form event code:C388=Sur clic:K2:4)
		READ WRITE:C146([HeBerge:4])  // je mets en RW pour le champs téléphone
		
		$L_Erreur:=4DREC_Load_Record(->[HeBerge:4]; ->$T_Message)
		
		If ($L_Erreur#1)
			ALERT:C41($T_Message)
		End if 
		
	: (Form event code:C388=Sur données modifiées:K2:15)
		SAVE RECORD:C53([HeBerge:4])
	: (Form event code:C388=Sur perte focus:K2:8)
		UNLOAD RECORD:C212([HeBerge:4])
		
		READ ONLY:C145([HeBerge:4])
		LOAD RECORD:C52([HeBerge:4])
End case 