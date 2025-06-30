// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 03/03/20, 08:13:05
// ----------------------------------------------------
// Method: [DiaLogues].DL_Dossiers_Encours.tb_dos_noms_1
// Description
// 
//
// Parameters
// ----------------------------------------------------

Case of 
	: (Form event code:C388=Sur données modifiées:K2:15)
		C_TEXT:C284(DOS_Nom_8)
		
		DOS_Nom_8:=Self:C308->{Self:C308->}
End case 

