//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script : ta_Centre
//{
//{          Lundi 10 janvier 2005 à 18:52:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If (Size of array:C274(ta_Centre)>0)
	If (ta_Centre>0)
		If (t_CT_ID{ta_Centre}=t_CT_ID{0})
		Else 
			t_CT_ID:=ta_Centre
			ta_Centre{0}:=ta_Centre{ta_Centre}
			t_CT_ID{0}:=t_CT_ID{t_CT_ID}
			ALERT:C41("Vous avez changé de centre !"+<>va_CR+"Vous devez recalculer.")
		End if 
	End if 
End if 