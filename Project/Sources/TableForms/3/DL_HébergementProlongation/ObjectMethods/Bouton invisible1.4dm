

If (Form event code:C388=Sur clic:K2:4)
	//Si (va_JourNuit="N")
	//CHERCHER([GrouPe];[GrouPe]GP_Nuit=Vrai)
	//Sinon 
	//CHERCHER([GrouPe];[GrouPe]GP_Nuit=Faux)
	//Fin de si 
	ALL RECORDS:C47([GrouPe:36])
	vL_Nb_GP:=Records in selection:C76([GrouPe:36])
	ORDER BY:C49([GrouPe:36]; [GrouPe:36]GP_Intitulé:4; >)
	FIRST RECORD:C50([GrouPe:36])
	POST CLICK:C466(20; 145)
	
	If ([GrouPe:36]GP_ReferenceID:1>0)
		P_Tab_PR(4; 0)
	Else 
		P_Tab_PR(0; 0)
	End if 
End if 