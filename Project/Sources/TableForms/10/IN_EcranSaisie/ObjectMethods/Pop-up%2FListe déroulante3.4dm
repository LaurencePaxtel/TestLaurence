C_LONGINT:C283($Pos)

If (Size of array:C274(<>ta_Plateforme)>0)
	
	If (<>ta_Plateforme>0)
		
		If (Find in array:C230(ta_LesPlatefomes; <>ta_Plateforme{<>ta_Plateforme})>0)
			ta_LesPlatefomes:=Find in array:C230(ta_LesPlatefomes; <>ta_Plateforme{<>ta_Plateforme})
		Else 
			$Pos:=Size of array:C274(ta_LesPlatefomes)+1
			INSERT IN ARRAY:C227(ta_LesPlatefomes; $Pos; 1)
			
			ta_LesPlatefomes{$Pos}:=<>ta_Plateforme{<>ta_Plateforme}
			SORT ARRAY:C229(ta_LesPlatefomes; >)
			
			$Pos:=Find in array:C230(ta_LesPlatefomes; <>ta_Plateforme{<>ta_Plateforme})
			
			If ($Pos>0)
				ta_LesPlatefomes:=$Pos
			Else 
				ta_LesPlatefomes:=0
			End if 
			
		End if 
		
	End if 
	
End if 