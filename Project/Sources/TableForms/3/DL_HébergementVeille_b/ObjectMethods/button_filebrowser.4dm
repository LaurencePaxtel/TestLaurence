// Method [DiaLogues].DL_HébergementChercher.button_filebrowser  
// 
// #SYNTAX: $L_Erreur:=[DiaLogues].DL_HébergementChercher.button_filebrowser(param_1;->param_N) 
// #PARAMETERS:
//     None

// #DATE CREATION: 11/05/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		LOAD RECORD:C52([HeberGement:5])
		RELATE ONE:C42([HeberGement:5]HG_HB_ID:19)
		//LOAD RECORD([HeBerge])
		FileBrowser_open([HeBerge:4]HB_Clé:2)  // #20180511-1
End case 