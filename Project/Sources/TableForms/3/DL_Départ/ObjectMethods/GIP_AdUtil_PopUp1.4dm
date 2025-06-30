// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 07/07/18, 19:57:04
// ----------------------------------------------------
// Méthode : [DiaLogues].DL_Depart_NV.GIP_AdUtil_PopUp1
// Description
// 
//
// Paramètres
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		Menu_Lance_Process("<>Menu_Btn_DA"; <>TAB_Menu_Btn_DA{<>TAB_Menu_Btn_DA})
	: (Form event code:C388=Sur début survol:K2:33)
		GET MOUSE:C468($sourisX; sourisY; $state)
		
		POST CLICK:C466($sourisX; sourisY)
End case 