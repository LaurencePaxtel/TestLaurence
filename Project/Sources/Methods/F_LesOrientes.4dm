//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_LesOrientes
//{          Lundi      : 18 juin 2001 à 11:27:55
//{          Modifiée : 13 mars 2012
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

Case of 
	: ($1=-1)
		C_LONGINT:C283(ve_LesOrentes)
		C_TEXT:C284(va_LesOrentes)
		C_TEXT:C284(va_LesOrentesTitre)
		C_TEXT:C284(va_TitreSuite)
		
		ve_LesOrentes:=<>ve_T_ColonneOrienter
		va_LesOrentes:=""
		va_LesOrentesTitre:=""
		
	: ($1=0)
		
		Case of 
			: (ve_LesOrentes=0)
				va_LesOrentesTitre:=xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 48)
			: (ve_LesOrentes=1)
				va_LesOrentesTitre:=xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 49)
			: (ve_LesOrentes=2)
				va_LesOrentesTitre:=xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 50)
		End case 
		
	: ($1=1)
		ve_LesOrentes:=ve_LesOrentes+1
		
		If (ve_LesOrentes>2)
			ve_LesOrentes:=0
		End if 
		
		F_LesOrientes(0)
		
		REDRAW:C174([HeberGement:5])
	: ($1=2)
		
		Case of 
			: (ve_LesOrentes=0)
				va_LesOrentes:=[HeberGement:5]HG_Orientation1:58
			: (ve_LesOrentes=1)
				va_LesOrentes:=[HeberGement:5]HG_Orientation2:60
			: (ve_LesOrentes=2)
				va_LesOrentes:=[HeberGement:5]HG_AutreSolutio:88
			Else 
				va_LesOrentes:="????"
		End case 
		
End case 