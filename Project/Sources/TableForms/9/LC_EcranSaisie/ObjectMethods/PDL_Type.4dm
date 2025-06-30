Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_LONGINT:C283($pos)
		ARRAY TEXT:C222(PDL_Type; 0)
		
		APPEND TO ARRAY:C911(PDL_Type; "")
		APPEND TO ARRAY:C911(PDL_Type; "F1")
		APPEND TO ARRAY:C911(PDL_Type; "F2")
		APPEND TO ARRAY:C911(PDL_Type; "F3")
		APPEND TO ARRAY:C911(PDL_Type; "F4")
		APPEND TO ARRAY:C911(PDL_Type; "F5")
		APPEND TO ARRAY:C911(PDL_Type; "F6")
		APPEND TO ARRAY:C911(PDL_Type; "F7")
		APPEND TO ARRAY:C911(PDL_Type; "F8")
		APPEND TO ARRAY:C911(PDL_Type; "F9")
		APPEND TO ARRAY:C911(PDL_Type; "F10")
		
		$pos:=Find in array:C230(PDL_Type; [LesCentres:9]LC_GL_Type:64)
		If ($pos>0)
			PDL_Type:=$pos
		End if 
	Else 
		[LesCentres:9]LC_GL_Type:64:=PDL_Type{PDL_Type}
End case 
