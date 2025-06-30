// Method [DiaLogues].DL_BDOS.LB  
// 
// 
// #SYNTAX: $L_Erreur:=[DiaLogues].DL_BDOS.LB(param_1;->param_N) 
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

// #DATE CREATION: 19/05/2016  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2


If (Size of array:C274(<>ta_BDOS_FichierNom)>0)
	
	If (<>ta_BDOS_FichierNom>0)
		If (F_BDOS_Tables(<>ta_BDOS_FichierCode{<>ta_BDOS_FichierNom}; ""; 0))
		End if 
		<>va_BDOS_FichierNom:=F_BDOS_Fichier(<>ta_BDOS_FichierNom)
		<>va_BDOS_FichierTable:=<>ta_BDOS_FichierNom{<>ta_BDOS_FichierNom}
	Else 
		If (F_BDOS_Tables("Dclare"; ""; 0))
		End if 
		<>va_BDOS_FichierNom:=""
		<>va_BDOS_FichierTable:=""
	End if 
	
End if 