If (Records in set:C195("UserSet")=1)
	CREATE SET:C116([INtervenants:10]; "$Templ")
	USE SET:C118("UserSet")
	LOAD RECORD:C52([INtervenants:10])
	$ii:=[INtervenants:10]IN_RéférenceID:1
	va_InC_Nom:=[INtervenants:10]IN_Nom:4
	va_InC_Prénom:=[INtervenants:10]IN_Prénom:5
	va_InC_login:=[INtervenants:10]IN_Login:3
	ve_inC_Type:=[INtervenants:10]IN_Type:2
	va_inC_Initiales:=[INtervenants:10]IN_Initiales:7
	va_inC_NomPrénom:=[INtervenants:10]IN_NomPrénom:8
	vi_inC_Signature:=[INtervenants:10]IN_Signature:9
	vb_inC_Loft:=[INtervenants:10]IN_LOFT:10
	vb_inC_Messagerie:=[INtervenants:10]IN_Messagerie:12
	vb_inC_Pointage:=[INtervenants:10]IN_Pointage:14
	va_inC_Plateforme:=[INtervenants:10]IN_Plateforme:13
	UNLOAD RECORD:C212([INtervenants:10])
	USE SET:C118("$Templ")
	ORDER BY:C49([INtervenants:10]; [INtervenants:10]IN_Nom:4; >)
	
	
	SET QUERY DESTINATION:C396(Vers ensemble:K19:2; "Ee_Dum")
	QUERY:C277([INtervenants:10]; [INtervenants:10]IN_RéférenceID:1=$ii)
	
	SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
	
	
	HIGHLIGHT RECORDS:C656("Ee_Dum")
	
Else 
	ALERT:C41("Veuillez sélectionner une fiche et une seule !")
	
End if 