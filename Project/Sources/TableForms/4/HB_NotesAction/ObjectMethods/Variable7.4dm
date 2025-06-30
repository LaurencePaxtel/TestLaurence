C_TEXT:C284($vt_TempTemp)

If (Size of array:C274(<>ta_ACTIONS)>0)
	If (<>ta_ACTIONS>0)
		
		$Pos1:=0
		$Pos2:=0
		$vPosTemp:=0
		GET HIGHLIGHT:C209(vt_TempActi; $Pos1; $Pos2)
		
		If (7=8)
			vt_TempActi:=Insert string:C231(vt_TempActi; String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+<>va_CR; $Pos1)
			$Pos2:=$Pos1+Length:C16((String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_User+<>va_CR))
			$Pos1:=$Pos2
			// [HéBergé]HG_Actions:=Inserer chaine(vt_TempActi;◊ta_ACTIONS{◊ta_ACTIONS};$Pos1)
			
			
		Else 
			vt_TempActi:=Insert string:C231(vt_TempActi; String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_CR; $Pos1)
			$Pos2:=$Pos1+Length:C16((String:C10(Current date:C33)+" - "+String:C10(Current time:C178)+" - "+<>va_CR))
			$Pos1:=$Pos2
			
		End if 
		
		$vt_TempTemp:=xliff_Txt_Get_Indexed_String_(30108; 78)
		$vt_TempTemp:="Données "+$vt_TempTemp
		If (<>ta_ACTIONS{<>ta_ACTIONS}=$vt_TempTemp)
			vt_TempActi:=Insert string:C231(vt_TempActi; vt_TempDistri+<>va_CR; $Pos1)
			$Pos2:=$Pos1+Length:C16(vt_TempDistri+<>va_CR)
			$Pos1:=$Pos2
			
			
			
		Else 
			vt_TempActi:=Insert string:C231(vt_TempActi; <>ta_ACTIONS{<>ta_ACTIONS}; $Pos1)
			$Pos2:=$Pos1+Length:C16(<>ta_ACTIONS{<>ta_ACTIONS})+3
		End if 
		
		HIGHLIGHT TEXT:C210(vt_TempActi; $Pos2; $Pos2)
	End if 
End if 