$vl_eventFF:=Form event code:C388
Case of 
	: ($vl_eventFF=Sur entête:K2:17)
		SET WINDOW TITLE:C213("Liste des utilisateurs : "+String:C10(Records in selection:C76([INtervenants:10])))
	: ($vl_eventFF=Sur chargement:K2:1)
	: ($vl_eventFF=Sur affichage corps:K2:22)
		If ([INtervenants:10]IN_Type:2#0)
			va_Type:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)
		End if 
		
		
	: ($vl_eventFF=Sur double clic:K2:5)
		FILTER EVENT:C321
End case 
