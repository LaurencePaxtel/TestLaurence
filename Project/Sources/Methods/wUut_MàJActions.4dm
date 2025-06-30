//%attributes = {}

If ([HeBerge:4]HG_Actions:40>"")
	$ii:=Length:C16([HeBerge:4]HG_Actions:40)
	$ik:=$ii
	$ij:=0
	If ($ii>0)
		Repeat 
			If ([HeBerge:4]HG_Actions:40[[$ii]]=Char:C90(13))
				$ij:=$ij+1
			End if 
			$ii:=$ii-1
		Until ($ii=0) | ($ij=9)
		If ($ij=9)
			[HeBerge:4]HG_Actions:40:=Substring:C12([HeBerge:4]HG_Actions:40; $ii+2)
		End if 
	End if 
End if 