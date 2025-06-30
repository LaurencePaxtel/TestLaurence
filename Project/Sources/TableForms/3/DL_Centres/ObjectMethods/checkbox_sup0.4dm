// Method [DiaLogues].DL_Centres.checkbox_sup0  
// 
// #DATE CREATION: 27/01/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		C_LONGINT:C283($L_Erreur)
		$L_Erreur:=CentreLits_Handle_query("chercher")
		
End case 