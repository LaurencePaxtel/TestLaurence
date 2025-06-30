//%attributes = {}
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([CentresLits:16])

READ ONLY:C145([DePart:1])



C_TEXT:C284($1)  //Nom de la table 
C_BOOLEAN:C305($0)
READ WRITE:C146([DePart:1])
FORM SET INPUT:C55([DePart:1]; "DP_CentreSel")
$vl_Fenetre:=i_FenêtreNo(732; 508; 16; "Sélectionner un "+$1; 12; "Quit_Simple")
ADD RECORD:C56([DePart:1]; *)  //lpc 08122017 ascenceur
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DePart:1])
$0:=vb_RecHéb