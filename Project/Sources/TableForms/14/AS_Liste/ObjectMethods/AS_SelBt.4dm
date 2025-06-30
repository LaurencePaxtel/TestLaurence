If (Records in set:C195("UserSet")=1)
	USE SET:C118("UserSet")
	<>va_PrestNom:=[Assocs:14]AS_Nom:2
	//APPELER PROCESS(◊PR_HébergementRG)
	//APPELER PROCESS(◊PR_Hébergement)
	//APPELER PROCESS(◊PR_HébergementR)
	CANCEL:C270
Else 
	StrAlerte(22; "")
End if 