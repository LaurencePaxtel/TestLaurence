If (Form event code:C388=Sur données modifiées:K2:15)
	If (7=8)
		If (<>vh_Conso115Auto2>=?03:00:00?) & (<>vh_Conso115Auto2<=?06:00:00?)
			If (<>vh_Conso115Auto1=?00:00:00?)
				<>vh_Conso115Auto1:=?03:00:00?
			End if 
			
		Else 
			ALERT:C41("La plage horaire doit être comprise entre 3 h du matin et 6 h du matin !")
			<>vh_Conso115Auto2:=?06:00:00?
		End if 
	End if 
End if 