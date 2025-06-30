C_LONGINT:C283($ii; $Pos)

If (Form event code:C388=Sur clic:K2:4)
	
	If (Size of array:C274(<>ta_Plateforme)>0)
		For ($ii; 1; Size of array:C274(<>ta_Plateforme))
			If (Find in array:C230(ta_LesPlatefomes; <>ta_Plateforme{$ii})>0)
			Else 
				$Pos:=Size of array:C274(ta_LesPlatefomes)+1
				INSERT IN ARRAY:C227(ta_LesPlatefomes; $Pos; 1)
				ta_LesPlatefomes{$Pos}:=<>ta_Plateforme{$ii}
			End if 
		End for 
		SORT ARRAY:C229(ta_LesPlatefomes; >)
		ta_LesPlatefomes:=1
	End if 
End if 