// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 07/07/18, 20:39:26
// ----------------------------------------------------
// Méthode : [DiaLogues].DL_Depart_NV.GIP_AdUtil_PopUp3
// Description
// 
//
// Paramètres
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		Menu_Lance_Process("<>Menu_Btn_Maraude"; <>TAB_Menu_Btn_Maraude{<>TAB_Menu_Btn_Maraude})
	: (Form event code:C388=Sur début survol:K2:33)
		GET MOUSE:C468($sourisX; sourisY; $state)
		
		POST CLICK:C466($sourisX; sourisY)
End case 