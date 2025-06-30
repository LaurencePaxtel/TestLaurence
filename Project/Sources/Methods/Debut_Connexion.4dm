//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Debut_Connexion
//{
//{          Lundi 10 mai 2010 à 15:31:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)

$0:=True:C214

If (Accès_User)
	QUERY:C277([TypesTables:11]; [TypesTables:11]TT_RéférenceID:1=40)
	
	If (Records in selection:C76([TypesTables:11])=1)
		
		If ([TypesTables:11]TT_NbNiveaux:2#2)
			READ WRITE:C146([TypesTables:11])
			
			Repeat 
				LOAD RECORD:C52([TypesTables:11])
			Until (Not:C34(Locked:C147([TypesTables:11])))
			
			[TypesTables:11]TT_NbNiveaux:2:=2
			SAVE RECORD:C53([TypesTables:11])
			
			UNLOAD RECORD:C212([TypesTables:11])
			READ ONLY:C145([TypesTables:11])
		End if 
		
	End if 
	
	DébutInitLienGPS(0)
	
	
	<>vb_RéservationActive:=True:C214
	
	P_Debut_Suite
	
End if 