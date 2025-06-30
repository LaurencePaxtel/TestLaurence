var $centre_e : cs:C1710.LesCentresEntity

If (Form event code:C388=Sur affichage corps:K2:22)
	OBJECT Get pointer:C1124(Objet nommé:K67:5; "Champ7")->:=[HeberGement:5]HG_CentreNom:62
	
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
		OBJECT Get pointer:C1124(Objet nommé:K67:5; "reporte")->:=[HeberGement:5]HG_Reporté:94
	Else 
		va_Gpe:=""
		va_LesOrentes:=""
		va_Rép2:=""
	End if 
	
	outilsOrdaSearchSimple(->[LesCentres:9]; ->[LesCentres:9]LC_Nom:4; [HeberGement:5]HG_CentreNom:62; ->$centre_e; "first")
	
	If ($centre_e#Null:C1517)
		
		If ($centre_e.LC_Sante=True:C214)
			
			If (User in group:C338(Current user:C182; "Santé")=False:C215)
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "Champ7")->:="XXX"
			End if 
			
		End if 
		
	End if 
	
End if 