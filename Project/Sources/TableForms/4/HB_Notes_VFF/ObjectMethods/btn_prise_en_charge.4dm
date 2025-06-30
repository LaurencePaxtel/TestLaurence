// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 10/07/2020, 15:25:19
// ----------------------------------------------------
// Method: [HeBerge].HB_Notes_VFF.btn_prise_en_charge
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		QUERY:C277([Prise_en_Charge:118]; [Prise_en_Charge:118]PE_HB_ID:4=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[Prise_en_Charge:118])
		
		$vl_Fenetre:=Open form window:C675([Prise_en_Charge:118]; "Liste_PE"; Form fenêtre standard:K39:10; À gauche:K39:2; En haut:K39:5)
		DIALOG:C40([Prise_en_Charge:118]; "Liste_PE")
		CLOSE WINDOW:C154($vl_Fenetre)
		
End case 