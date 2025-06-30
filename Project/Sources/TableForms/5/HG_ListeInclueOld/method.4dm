If (Form event code:C388=Sur affichage corps:K2:22)
	
	If ([HeberGement:5]HG_ReferenceID:1>0)
		
		F_LesOrientes(2)
		
		va_Rép2:=String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93)
		If ([HeberGement:5]HG_FamGroupe:102="") | ([HeberGement:5]HG_FamGroupe:102="115")
			va_Gpe:=""
		Else 
			va_Gpe:="DA"
			If ([HeberGement:5]HG_FamChef:103)
				OBJECT SET FONT STYLE:C166(va_Gpe; 4)
			Else 
				OBJECT SET FONT STYLE:C166(va_Gpe; 0)
			End if 
		End if 
		
		
		// #BS 11/07/16 le champ ne voulait pas s'afficher
		// Je passe par une variable et ça marche
		C_POINTER:C301($P)
		$P:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "reporte")
		$P->:=[HeberGement:5]HG_Reporté:94
		
		
	Else 
		va_Gpe:=""
		va_LesOrentes:=""
		va_Rép2:=""
	End if 
End if 