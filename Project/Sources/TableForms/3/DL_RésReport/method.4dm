$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		rJourNuit1:=1
		rJourNuit2:=1
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		If ((vl_SourisX>7) & (vl_SourisX<764)) & ((vl_SourisY>109) & (vl_SourisY<469))
			If ([HeberGement:5]HG_ReferenceID:1>0)
				vl_IDT_ID:=[HeberGement:5]HG_HB_ID:19
				rJourNuit1:=1
				rJourNuit2:=1
			Else 
				vl_IDT_ID:=0
			End if 
		End if 
End case 