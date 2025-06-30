//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Script b_ImpHB  
//{
//{          Vendredi 7 Mars 1997 à 14:32:49
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Form event code:C388=Sur clic:K2:4)
	If ([HeBerge:4]HB_ReferenceID:1>0)
		vl_RéfU_HB:=[HeBerge:4]HB_ReferenceID:1
		va_Identité:=[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4+" "+String:C10([HeBerge:4]HB_DateNéLe:5)
		
		P_HébergementRGFind([HeBerge:4]HB_ReferenceID:1)
		
		If (Records in selection:C76([RenseiGnements:20])>0)
			vL_NbFiches:=Records in selection:C76([RenseiGnements:20])
			_O_PAGE SETUP:C299([RenseiGnements:20]; "RG_PrtListe")
			PRINT SETTINGS:C106
			If (OK=1)
				FORM SET OUTPUT:C54([RenseiGnements:20]; "RG_PrtListe")
				PRINT SELECTION:C60([RenseiGnements:20]; *)
			End if 
			
		Else 
			StrAlerte(1; "")
		End if 
	Else 
		StrAlerte(3; "")
	End if 
End if 