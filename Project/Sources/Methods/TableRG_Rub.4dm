//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableRG_Rub
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
Case of 
	: ($1=1)
		COPY ARRAY:C226(<>ta_AdUtil; <>ta_PrestThé)
	: ($1=2)
		
		ALL RECORDS:C47([Assocs:14])
		MultiSoc_Filter(->[Assocs:14])
		SELECTION TO ARRAY:C260([Assocs:14]AS_Nom:2; <>ta_PrestThé; [Assocs:14]AS_Nom2:3; ta_PrestNom)
		SORT ARRAY:C229(<>ta_PrestThé; >)
	: ($1=3)
		COPY ARRAY:C226(<>ta_DemP; <>ta_PrestThé)
	: ($1=4)
		COPY ARRAY:C226(<>ta_SitPar; <>ta_PrestThé)
End case 
If (Size of array:C274(<>ta_PrestThé)>0)
	<>ta_PrestThé:=1
Else 
	<>ta_PrestThé:=0
End if 

//◊ta_PrestThé{0}:=◊ta_PrestThé{◊ta_PrestThé}


<>ta_PrestNom:=0
<>va_PrestNom:=""