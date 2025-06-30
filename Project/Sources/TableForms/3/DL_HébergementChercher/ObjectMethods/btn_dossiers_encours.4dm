// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04/03/20, 08:09:05
// ----------------------------------------------------
// Method: [DiaLogues].DL_HébergementChercher.btn_dossiers_encours
// Description
// 
//
// Parameters
// ----------------------------------------------------

If (Form event code:C388=Sur clic:K2:4)
	LOAD RECORD:C52([HeBerge:4])
	
	If ([HeBerge:4]HB_ReferenceID:1>0)
		Process_Go(-><>PR_Dossiers_Encours; "Go_Dossiers_Encours"; "Dossiers en cours"; 0; [HeBerge:4]HB_ReferenceID:1)
	Else 
		StrAlerte(3; "")
	End if 
	
End if 