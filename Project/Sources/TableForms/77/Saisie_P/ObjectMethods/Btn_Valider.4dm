// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 06/07/18, 11:30:34
// ----------------------------------------------------
// Méthode : [NAV_Parametrage].Saisie_P.Btn_Valider
// Description
// 
//
// Paramètres
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		If (Is new record:C668([NAV_Menus:77]))
			MultiSoc_Init_Structure(->[NAV_Menus:77])
		End if 
		SAVE RECORD:C53([NAV_Menus:77])
		ACCEPT:C269
End case 
