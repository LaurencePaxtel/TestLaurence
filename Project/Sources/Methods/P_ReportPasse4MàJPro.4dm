//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{       
//{          Procédure : P_ReportPasse4MàJPro
//{          Mise à jour des disponibilités des centres
//{          Lundi 4 octobre 2004 à 11:16:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)

If ($2=1)
	i_Message("Mise à jour des prolongations…")
End if 

$ii:=Size of array:C274(tl_PR_HGréf)

If ($ii>0)
	QUERY WITH ARRAY:C644([Prolongation:38]PR_RéférenceID:1; tl_PR_PRréf)
	
	If (Records in selection:C76([Prolongation:38])>0)
		READ WRITE:C146([Prolongation:38])
		APPLY TO SELECTION:C70([Prolongation:38]; [Prolongation:38]PR_ProlongationEffectuée:11:=True:C214)
		APPLY TO SELECTION:C70([Prolongation:38]; [Prolongation:38]PR_ProlongationEffectuéeDate:12:=$1)
		
		READ ONLY:C145([Prolongation:38])
	End if 
	
End if 

If ($2=1)
	CLOSE WINDOW:C154
End if 