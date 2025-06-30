// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 06/02/20, 10:35:01
// ----------------------------------------------------
// Method: [DiaLogues].DL_HébergementVeille_b.b_Facturation
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Accès_Groupe(<>Groupe_Comptable))
	C_DATE:C307(txt_filtre_date1; txt_filtre_date2)
	
	txt_filtre_date1:=[DiaLogues:3]DL_Date:2
	txt_filtre_date2:=[DiaLogues:3]DL_Date2:8
	
	If (<>PR_Facturation=0)
		<>PR_Facturation:=New process:C317("Go_Facturation"; 0; "Facturation"; txt_filtre_date1; txt_filtre_date2)
	Else 
		Process_Show(<>PR_Facturation)
	End if 
	
End if 