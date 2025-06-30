//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : wUut_MàJCentres
//{
//{          Mardi 27 octobre 2009 à 19:27
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}




If ([LesCentres:9]LC_JourMoisOuverture:58>"") & (Length:C16([LesCentres:9]LC_JourMoisOuverture:58)=4) & ([LesCentres:9]LC_JourMoisFermeture:59>"") & (Length:C16([LesCentres:9]LC_JourMoisFermeture:59)=4)
	
	
	//[LesCentres]LC_JourMoisFermeture:=""
	//  LesCentres]LC_JourMoisOuverture:=""
	
	
Else 
	If ([LesCentres:9]LC_Fermé:53)
		[LesCentres:9]LC_JourMoisFermeture:59:=String:C10(Month of:C24(vd_Date); "00")+String:C10(Day of:C23(vd_Date); "00")
		[LesCentres:9]LC_JourMoisOuverture:58:="0000"
	Else 
		[LesCentres:9]LC_JourMoisFermeture:59:="0000"
		[LesCentres:9]LC_JourMoisOuverture:58:="0000"
		
	End if 
End if 