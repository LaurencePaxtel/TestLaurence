
vb_Dupliquer:=False:C215
FORM SET INPUT:C55([LesCentres:9]; "LC_EcranSaisie")
ADD RECORD:C56([LesCentres:9]; *)
ALL RECORDS:C47([LesCentres:9])
MultiSoc_Filter(->[LesCentres:9])
ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)

