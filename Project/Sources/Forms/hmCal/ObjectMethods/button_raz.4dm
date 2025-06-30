// Method hmCal.Bouton image52  
// 
// 
// #SYNTAX: $L_Erreur:=hmCal.Bouton image52(param_1;->param_N) 
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

// #DATE CREATION: 15/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		C_POINTER:C301($P_LB)
		hm_Get_Pointer_LB_usagers(->$P_LB)
		
		C_LONGINT:C283($i)
		For ($i; 1; Size of array:C274($P_LB->))
			$P_LB->{$i}:=False:C215
		End for 
		
		C_LONGINT:C283($L_Zone)
		$L_Zone:=hm_Get_Zoneref("hmCal")
		hmCal_UPDATE APPOINTMENTS($L_Zone)
End case 