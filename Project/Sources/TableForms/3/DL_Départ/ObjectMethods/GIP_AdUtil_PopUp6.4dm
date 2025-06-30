// ----------------------------------------------------
// Developpeur : Kevin HASSAL
// Date et heure : 08/07/18, 15:07:18
// ----------------------------------------------------
// Méthode : [DiaLogues].DL_Depart_NV.GIP_AdUtil_PopUp5
// Description
// 
//
// Paramètres
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		Menu_Lance_Process("<>Menu_Btn_Stats"; <>TAB_Menu_Btn_Stats{<>TAB_Menu_Btn_Stats})
	: (Form event code:C388=Sur début survol:K2:33)
		GET MOUSE:C468($sourisX; sourisY; $state)
		POST CLICK:C466($sourisX; sourisY)
End case 