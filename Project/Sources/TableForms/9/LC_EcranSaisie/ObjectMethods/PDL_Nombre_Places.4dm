
Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		
		C_LONGINT:C283($pos)
		ARRAY LONGINT:C221(PDL_Nombre_Places; 0)
		
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 0)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 1)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 2)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 3)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 4)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 5)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 6)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 7)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 8)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 9)
		APPEND TO ARRAY:C911(PDL_Nombre_Places; 10)
		
		$pos:=Find in array:C230(PDL_Nombre_Places; [LesCentres:9]LC_GL_Nombre_Places:65)
		If ($pos>0)
			PDL_Nombre_Places:=$pos
		End if 
	Else 
		[LesCentres:9]LC_GL_Nombre_Places:65:=PDL_Nombre_Places{PDL_Nombre_Places}
End case 
