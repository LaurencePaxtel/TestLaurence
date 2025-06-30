// ----------------------------------------------------
// Developer: Kevin HASSAL
// Date and time: 05/10/19, 14:25:52
// ----------------------------------------------------
// Method: [DiaLogues].DL_Purge.Variable65
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		
		C_LONGINT:C283($process_id)
		
		CONFIRM:C162("Voulez vous lancer l'import sur le Client ou sur le Seveur ?"; "Client"; "Serveur")
		If (OK=1)
			DATA_Import
		Else 
			$process_id:=Execute on server:C373("DATA_Import"; 0; "IMPORT"; <>ref_soc_active; *)
		End if 
		
		
End case 