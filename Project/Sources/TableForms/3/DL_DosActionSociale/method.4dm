$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		
		vl_SourisXb:=0
		vl_SourisYb:=0
		vl_SourisBtb:=0
		
		ta_MRLib:=Size of array:C274(ta_MRLib)
		ta_MRCode:=Size of array:C274(ta_MRLib)
		QUERY:C277([ActionSociale:26]; [ActionSociale:26]AA_DS_ID:12=[DossierSocial:25]DS_Référence:1)
		ORDER BY:C49([ActionSociale:26]; [ActionSociale:26]AA_Evénement:4; >)
		OBJECT SET ENABLED:C1123(b_Modk; False:C215)
		OBJECT SET ENABLED:C1123(b_Supk; False:C215)
	: ($vl_EventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisXb; vl_SourisYb; vl_SourisBtb)
		If ((vl_SourisXb>7) & (vl_SourisXb<610)) & ((vl_SourisYb>76) & (vl_SourisYb<272))
			If ([ActionSociale:26]AA_Référence:1>0)
				OBJECT SET ENABLED:C1123(b_Modk; True:C214)
				OBJECT SET ENABLED:C1123(b_Supk; True:C214)
			Else 
				OBJECT SET ENABLED:C1123(b_Modk; False:C215)
				OBJECT SET ENABLED:C1123(b_Supk; False:C215)
			End if 
		End if 
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisXb; vl_SourisYb; vl_SourisBtb)
		If ((vl_SourisXb>7) & (vl_SourisXb<610)) & ((vl_SourisYb>76) & (vl_SourisYb<272))
			If ([ActionSociale:26]AA_Référence:1>0)
				READ WRITE:C146([ActionSociale:26])
				If (i_NonVerrou(->[ActionSociale:26]))
					FORM SET INPUT:C55([ActionSociale:26]; "AA_EcranSaisie")
					$vl_Fenetre:=i_FenêtreNo(358; 357; 4; "Actions sociale : modifier"; 3; "")
					MODIFY RECORD:C57([ActionSociale:26]; *)
					CLOSE WINDOW:C154($vl_Fenetre)
				End if 
				READ ONLY:C145([ActionSociale:26])
			Else 
				StrAlerte(22; "")
			End if 
			
		End if 
End case 