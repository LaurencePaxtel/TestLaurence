// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 08:47:17
// ----------------------------------------------------
// Method: [Events].print_liste
// Description
// 
//
// Parameters
// ----------------------------------------------------



Case of 
	: (Section="Corps")
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Events:103]EVE_HB_ID:14)
		MultiSoc_Filter(->[HeBerge:4])
		
		If (Not:C34(Print_Resize_Zone(->[HeBerge:4]HB_Clé:2)))
			If (Not:C34(Print_Resize_Zone(->[Events:103]EVE_Type:10)))
				If (Not:C34(Print_Resize_Zone(->[Events:103]EVE_Presence:11)))
					If (Not:C34(Print_Resize_Zone(->[Events:103]EVE_Titre:3)))
						If (Not:C34(Print_Resize_Zone(->[Events:103]EVE_User_NomPrenom:16)))
						End if 
					End if 
				End if 
			End if 
		End if 
		
		
		taille_taquet_base:=Get print marker:C708(taquet)
		
	: (Section="Entete")
		
		taille_taquet_base:=Get print marker:C708(taquet)
		
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