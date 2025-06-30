//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementRGFind
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

If ($1>0)
	QUERY:C277([RenseiGnements:20]; [RenseiGnements:20]RG_HB_ID:2=$1)
	MultiSoc_Filter(->[RenseiGnements:20])
	ORDER BY:C49([RenseiGnements:20]; [RenseiGnements:20]RG_Date:3; <; *)
	ORDER BY:C49([RenseiGnements:20]; [RenseiGnements:20]RG_Heure:4; <)
	UNLOAD RECORD:C212([RenseiGnements:20])
	//FIRST RECORD([RenseiGnements])
	//PREVIOUS RECORD([RenseiGnements])
	P_HébergementNotesBt(1)
	OBJECT SET ENABLED:C1123(b_PrestNew; True:C214)
Else 
	REDUCE SELECTION:C351([RenseiGnements:20]; 0)
	va_Identité:=""
	P_HébergementNotesBt(0)
	OBJECT SET ENABLED:C1123(b_PrestNew; False:C215)
End if 
vL_Nb_HG_F:=Records in selection:C76([RenseiGnements:20])


OBJECT SET ENABLED:C1123(b_PrestMod; False:C215)
OBJECT SET ENABLED:C1123(b_PrestSup; False:C215)
If (vL_Nb_HG_F>0)
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		OBJECT SET ENABLED:C1123(b_PrestImp; False:C215)
	Else 
		OBJECT SET ENABLED:C1123(b_PrestImp; True:C214)
	End if 
Else 
	OBJECT SET ENABLED:C1123(b_PrestImp; False:C215)
End if 