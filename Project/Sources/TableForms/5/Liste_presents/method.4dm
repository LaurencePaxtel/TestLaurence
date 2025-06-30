// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 14/03/20, 04:11:02
// ----------------------------------------------------
// Method: [HeberGement].Liste_presents
// Description
// 
//
// Parameters
// ----------------------------------------------------


Case of 
	: (Section="Corps")
		
		If (Not:C34(Print_Resize_Zone(->txt_lundi)))
			If (Not:C34(Print_Resize_Zone(->txt_mardi)))
				If (Not:C34(Print_Resize_Zone(->txt_mercredi)))
					If (Not:C34(Print_Resize_Zone(->txt_jeudi)))
						If (Not:C34(Print_Resize_Zone(->txt_vendredi)))
							If (Not:C34(Print_Resize_Zone(->txt_samedi)))
								If (Not:C34(Print_Resize_Zone(->txt_dimanche)))
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
		
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Entete")
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