//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableEnum_Lister  
//{
//{          Mercredi 29 Octobre 1997 à 12:47:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=[TypesTables:11]TT_RéférenceID:1)
MultiSoc_Filter(->[TAbles:12])

If (Records in selection:C76([TAbles:12])>0)
	ORDER BY:C49([TAbles:12]; [TAbles:12]TB_Code:5; >)
	UNLOAD RECORD:C212([TAbles:12])
End if 

<>Vl_TB_NbFic:=Records in selection:C76([TAbles:12])