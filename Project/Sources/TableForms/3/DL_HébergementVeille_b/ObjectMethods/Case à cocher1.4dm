If (Form event code:C388=Sur clic:K2:4)
	
	If (uEmplace=1)
		OBJECT SET TITLE:C194(uEmplace; "Affichage: "+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 48))
	Else 
		OBJECT SET TITLE:C194(uEmplace; "Affichage: "+xliff_Txt_Get_Indexed_String_(<>vlSTR_Std; 10))
	End if 
	
	REDRAW:C174([HeberGement:5])
End if 