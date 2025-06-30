// Method [DiaLogues].DL_DialTri2.LB  
// 

Case of 
	: (Form event code:C388=Sur double clic:K2:5)
		
		
		// en 6.7 on avait 2 colonne de gauche avec le même code
		// la colonne de droite un autre code
		C_POINTER:C301($P_Col)
		$P_Col:=OBJECT Get pointer:C1124
		
		C_LONGINT:C283($ii; $jj)
		Case of 
			: ($P_Col=(->te_TriSel)) | ($P_Col=(->ta_TriRub))
				
				// Colonne gauche ou centre
				If (te_TriSel>0)
					If (te_TriSel{te_TriSel}>0)
						te_TriSel{te_TriSel}:=0
					Else 
						$jj:=1
						For ($ii; 1; Size of array:C274(te_TriSel))
							If (te_TriSel{$ii}>0)
								If (te_TriSel{$ii}>=$jj)
									$jj:=te_TriSel{$ii}+1
								End if 
							End if 
						End for 
						te_TriSel{te_TriSel}:=$jj
						
					End if 
				End if 
				
			Else 
				// colonne droite
				If (te_TriSens>0)
					If (te_TriSens{te_TriSens}=1)
						te_TriSens{te_TriSens}:=-1
					Else 
						te_TriSens{te_TriSens}:=1
					End if 
				End if 
		End case 
End case 