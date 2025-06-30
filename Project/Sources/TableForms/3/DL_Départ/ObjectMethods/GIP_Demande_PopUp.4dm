// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 05/07/18, 17:09:39
// ----------------------------------------------------
// Méthode : [DiaLogues].DL_Départ.GIP_Demande_PopUp
// Description
// 
//
// Paramètres
// ----------------------------------------------------



Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		Menu_Lance_Process("<>Menu_Btn_Social"; <>TAB_Menu_Btn_Social{<>TAB_Menu_Btn_Social})
		
	: (Form event code:C388=Sur début survol:K2:33)
		
		GET MOUSE:C468($sourisX; sourisY; $state)
		POST CLICK:C466($sourisX; sourisY)
		
End case 
