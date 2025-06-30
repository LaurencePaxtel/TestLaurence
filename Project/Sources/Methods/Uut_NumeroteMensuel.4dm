//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : Uut_NumeroteMensuel 
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//Recherche et sélection de la numérotation mensuelle
C_LONGINT:C283($0)
READ WRITE:C146([DePart:1])
i_Message("Recherche en cours…")
QUERY:C277([DePart:1]; [DePart:1]DP_Param:3=True:C214)
MultiSoc_Filter(->[DePart:1])

Repeat 
	LOAD RECORD:C52([DePart:1])
	If (Locked:C147([DePart:1]))
		i_MessageSeul("Réseau occupé, patientez…")
	Else 
		[DePart:1]DP_NumHeberg:4:=[DePart:1]DP_NumHeberg:4+1
		SAVE RECORD:C53([DePart:1])
		$0:=[DePart:1]DP_NumHeberg:4
		UNLOAD RECORD:C212([DePart:1])
	End if 
Until (Not:C34(Locked:C147([DePart:1])))
CLOSE WINDOW:C154
READ ONLY:C145([DePart:1])
