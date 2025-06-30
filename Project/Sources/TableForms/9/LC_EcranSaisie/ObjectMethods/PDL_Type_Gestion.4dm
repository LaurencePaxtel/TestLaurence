
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_LONGINT:C283($pos)
		ARRAY TEXT:C222(PDL_Type_Gestion; 0)
		
		APPEND TO ARRAY:C911(PDL_Type_Gestion; "Location")
		APPEND TO ARRAY:C911(PDL_Type_Gestion; "Sous location")
		APPEND TO ARRAY:C911(PDL_Type_Gestion; "Hébergement")
		
		$pos:=Find in array:C230(PDL_Type_Gestion; [LesCentres:9]LC_GL_Type_Gestion:62)
		If ($pos>0)
			PDL_Type_Gestion:=$pos
		End if 
		
	Else 
		[LesCentres:9]LC_GL_Type_Gestion:62:=PDL_Type_Gestion{PDL_Type_Gestion}
End case 

