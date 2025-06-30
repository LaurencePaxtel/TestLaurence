If (Form event code:C388=Sur clic:K2:4)
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)  //3/2/2009
	QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)  //3/2/2009    
	QUERY SELECTION:C341([LesCentres:9]; [LesCentres:9]LC_Prestation:55=False:C215)
	vL_NbFiches:=Records in selection:C76([LesCentres:9])
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Niveau:52; >; *)
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
	FIRST RECORD:C50([LesCentres:9])
	PREVIOUS RECORD:C110([LesCentres:9])
End if 