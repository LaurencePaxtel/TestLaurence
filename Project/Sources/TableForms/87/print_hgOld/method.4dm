// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 19:28:12
// ----------------------------------------------------
// Method: [Factures].print
// Description
// 
//
// Parameters
// ----------------------------------------------------


GES_Imp_Maj_Variables(->[Factures:86])

Case of 
	: (Section="Corps")
		
		Print_Resize_Zone(->txt_lig_usager)
		Print_Resize_Zone(->txt_lig_libelle)
		
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Entete")
		
		Print_Resize_Zone(->txt_strc_adresse)
		
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Entete1")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Entete2")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Pied")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Rupture0")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Rupture1")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Rupture2")
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Rupture3")
		taille_taquet_base:=Get print marker:C708(taquet)
		
End case 

If (Mode_impression="Mesure")
	taille_taquet:=Get print marker:C708(taquet)
	CANCEL:C270
End if 