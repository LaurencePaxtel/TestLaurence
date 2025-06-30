// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 09/07/2020, 15:45:58
// ----------------------------------------------------
// Method: LB_NAV_PE
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283(colonne; ligne; order_max)

Case of 
	: (Form event code:C388=Sur double clic:K2:5)
		
		LISTBOX GET CELL POSITION:C971(LB_NAV_PE; colonne; ligne)
		
		READ WRITE:C146([Prise_en_Charge:118])
		GOTO SELECTED RECORD:C245([Prise_en_Charge:118]; ligne)
		LOAD RECORD:C52([Prise_en_Charge:118])
		
		MODIFY RECORD:C57([Prise_en_Charge:118])
		
		READ ONLY:C145([Prise_en_Charge:118])
		
		QUERY:C277([Prise_en_Charge:118]; [Prise_en_Charge:118]PE_HB_ID:4=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[Prise_en_Charge:118])
		
	: (Form event code:C388=Sur chargement:K2:1)
		
		READ ONLY:C145([Prise_en_Charge:118])
		
		QUERY:C277([Prise_en_Charge:118]; [Prise_en_Charge:118]PE_HB_ID:4=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[Prise_en_Charge:118])
		
		REDRAW:C174(LB_NAV_PE)
		
End case 


