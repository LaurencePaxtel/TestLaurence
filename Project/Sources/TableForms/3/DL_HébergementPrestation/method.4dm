$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		P_HébergementRGFindS(vl_RéfU_HBB)
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
	: ($vl_EventFF=Sur double clic:K2:5)
		
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>7) & (vl_SourisX<615)) & ((vl_SourisY>53) & (vl_SourisY<396))
			If ([RenseiGnements:20]RG_RéférenceID:1>0) & (vl_RéfU_HBB>0)
				
				
				READ WRITE:C146([RenseiGnements:20])
				If (i_NonVerrou(->[RenseiGnements:20]))
					FORM SET INPUT:C55([RenseiGnements:20]; "RG_EcranSaisie")
					$vl_Fenetre:=i_FenêtreNo(632; 270; 4; va_IdentitS+" : "+"Fiche demande : modifier"; 4; "")
					MODIFY RECORD:C57([RenseiGnements:20]; *)
					UNLOAD RECORD:C212([RenseiGnements:20])
					CLOSE WINDOW:C154($vl_Fenetre)
				End if 
				READ ONLY:C145([RenseiGnements:20])
				P_HébergementRGFindS(vl_RéfU_HBB)
			Else 
				StrAlerte(18; "")
			End if 
			
		End if 
		
End case 