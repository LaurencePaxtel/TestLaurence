// Method [DiaLogues].DL_HébergementGpeNew.LB  
// 
C_POINTER:C301($P_Col_current)
$P_Col_current:=OBJECT Get pointer:C1124
Case of 
	: (Form event code:C388=Sur double clic:K2:5)
		
		Case of 
			: ($P_Col_current=(-><>te_GpCheck))
				
				// en 6.7: le script qui était sur la colonne <>te_GpCheck
				
				If (Size of array:C274(<>te_GpCheck)>0)
					If (<>te_GpCheck>0)
						If (<>te_GpCheck{<>te_GpCheck}=1)
							<>te_GpCheck{<>te_GpCheck}:=0
						Else 
							<>te_GpCheck{<>te_GpCheck}:=1
						End if 
						SET WINDOW TITLE:C213(F_HébergementGroupeTitre(va_GPNom))
					End if 
				End if 
				
			Else 
				// rien
		End case 
		
		
End case 

