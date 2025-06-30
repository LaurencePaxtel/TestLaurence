$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		C_TEXT:C284(va_TypeN)
		C_TEXT:C284(va_Type)
		OBJECT SET TITLE:C194(b_AnnIN; "Quitter")
		SET WINDOW TITLE:C213("Nouvel utilisateur")
		
		If (Is new record:C668([INtervenants:10]))
			MultiSoc_Filter(->[INtervenants:10])
			[INtervenants:10]IN_RéférenceID:1:=Uut_Numerote(->[INtervenants:10])
			[INtervenants:10]IN_Login:3:=Current user:C182
			
		End if 
		va_Type:=""
		If ([INtervenants:10]IN_Type:2#0)
			va_Type:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
			va_TypeN:=String:C10([INtervenants:10]IN_Type:2)
		Else 
			[INtervenants:10]IN_Type:2:=1
			va_TypeN:=String:C10([INtervenants:10]IN_Type:2)
			va_Type:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
		End if 
		GET USER LIST:C609(ta_UserLog; tl_UserNo)
		If (Size of array:C274(ta_UserLog)>0)
			$Position:=Find in array:C230(ta_UserLog; Current user:C182)
			If ($Position>0)
				[INtervenants:10]IN_RéfUser:11:=tl_UserNo{$Position}
			End if 
		End if 
	: ($vl_EventFF=Sur données modifiées:K2:15)
		If (Modified:C32([INtervenants:10]IN_Nom:4) | Modified:C32([INtervenants:10]IN_Prénom:5))
			[INtervenants:10]IN_NomPrénom:8:=[INtervenants:10]IN_Nom:4+" "+[INtervenants:10]IN_Prénom:5
		End if 
End case 