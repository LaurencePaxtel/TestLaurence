$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur entête:K2:17)
		va_Titre:="Les excusés : "+String:C10(vl_NbHéberGements)
		SET WINDOW TITLE:C213(va_Titre)
		
	: ($vl_EventFF=Sur double clic:K2:5)
		
		P_HébergementListeValider(1; ve_ProcessEnCours)
		
		
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		P_HébergementExcuserRec
End case 