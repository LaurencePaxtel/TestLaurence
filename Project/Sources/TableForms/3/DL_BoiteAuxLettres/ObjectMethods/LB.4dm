// Method [DiaLogues].DL_BoiteAuxLettres.LB  
// 
// 
// #SYNTAX: $L_Erreur:=[DiaLogues].DL_BoiteAuxLettres.LB(param_1;->param_N) 
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


If (Form event code:C388=Sur clic:K2:4)
	
	// Dans les anciens tableaux groupés
	// la ligne ci-dessous était seulement pour la colonne  de te_TransDocuCas
	// Je commente la ligne pour cette listbox
	
	// tt_TransDocu:=te_TransDocuCas
	P_BAL_B(3)
End if 