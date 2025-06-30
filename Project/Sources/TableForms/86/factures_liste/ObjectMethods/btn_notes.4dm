// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25/02/20, 19:22:50
// ----------------------------------------------------
// Method: [Factures].factures_liste.btn_notes
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		READ ONLY:C145([HeBerge:4])
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=fac_heberge_selected_id)
		MultiSoc_Filter(->[HeBerge:4])
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			Process_Go2(-><>PR_HBNotes; "Go_HébergementNotes"; "Notes"; 32; [HeBerge:4]ID:65; "N")
		Else 
			StrAlerte(3; "")
		End if 
		
End case 
