MESSAGES ON:C181
vl_K_Ctre_SerieA:=Storage:C1525.societeDetail.codeCentre
P_CodeCentre(->vl_K_Ctre_SerieAD; ->vl_K_Ctre_SerieAF)
QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>vl_K_Ctre_SerieAD; *)
QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_RéférenceID:1<vl_K_Ctre_SerieAF)
If (Records in selection:C76([LesCentres:9])>0)
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; >)
	FIRST RECORD:C50([LesCentres:9])
	vl_K_Ctre_SerieCD:=[LesCentres:9]LC_RéférenceID:1
	ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1; <)
	FIRST RECORD:C50([LesCentres:9])
	vl_K_Ctre_SerieCF:=[LesCentres:9]LC_RéférenceID:1
Else 
	vl_K_Ctre_SerieCD:=0
	vl_K_Ctre_SerieCF:=0
End if 
MESSAGES OFF:C175

FORM GOTO PAGE:C247(3)