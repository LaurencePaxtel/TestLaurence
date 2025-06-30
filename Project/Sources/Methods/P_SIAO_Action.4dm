//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAO_Action
//{          Lundi 6 décembre 2010 à 10:45:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
Case of 
	: ($1=0)
		vl_SIAO_Action:=0
		va_SIAO_Action:=""
		
	: ($1=1)
		vl_SIAO_Action:=1
		va_SIAO_Action:="Nouvelle demande individuelle"
		
	: ($1=2)
		vl_SIAO_Action:=2
		va_SIAO_Action:="Nouvelle demande familiale"
		
		
	: ($1=3)
		vl_SIAO_Action:=3
		va_SIAO_Action:="Nouvelle demande groupée"
		
		
End case 