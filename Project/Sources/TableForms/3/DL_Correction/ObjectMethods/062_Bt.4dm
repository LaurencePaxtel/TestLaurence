//Script b_RecHéb
If (7=7)
	<>vl_NoHHisto:=0
	va_CtrLib:=""
	Case of 
		: (Macintosh option down:C545 | Windows Alt down:C563)
			If ([HeberGement:5]HG_ReferenceID:1>0)
				[DiaLogues:3]DL_LibelPlus:6:=[HeberGement:5]HG_CentreNom:62
			End if 
		: (Macintosh control down:C544 | Windows Ctrl down:C562)
			[DiaLogues:3]DL_LibelPlus:6:=""
		Else 
			If (F_CentreSelectionner(<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{51}))
				[DiaLogues:3]DL_LibelPlus:6:=va_RH_Typ1
			End if 
	End case 
	
Else 
	<>vl_NoHHisto:=0
	va_CtrLib:=""
	If (Macintosh control down:C544) | (Windows Ctrl down:C562)
		[DiaLogues:3]DL_LibelPlus:6:=""
	Else 
		If (F_CentreSelectionner(<>ta_RdsNomNew{<>vlSTR_HG-<>vlSTR}{51}))
			[DiaLogues:3]DL_LibelPlus:6:=va_RH_Typ1
		Else 
		End if 
	End if 
End if 