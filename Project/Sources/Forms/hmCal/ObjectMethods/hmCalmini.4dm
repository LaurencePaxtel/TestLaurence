// Method hmCal.hmCalmini  
// 
// 
// #SYNTAX: $L_Erreur:=hmCal.hmCalmini(param_1;->param_N) 
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

// #DATE CREATION: 07/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2



Case of 
	: (Form event code:C388=Sur appel zone du plug in:K2:16)
		
		C_LONGINT:C283($L_Zone; $L_ZoneMini)
		$L_Zone:=hm_Get_Zoneref("hmCal")
		$L_ZoneMini:=hm_Get_Zoneref("hmCalmini")
		
		C_DATE:C307($D_Date)
		$D_Date:=hmCal_mini_Get Date($L_ZoneMini)
		hmCal_SET START DATE($L_Zone; $D_Date)
		
		hmCal_DELETE ALL SPECIAL DAYS($L_Zone)
		hmCal_Add Special Day($L_Zone; $D_Date; -1; -1; -1)
		
End case 