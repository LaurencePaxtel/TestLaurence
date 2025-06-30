//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_HBNotesActT  
//{
//{          Mardi 15 Juin 2004 à 14:56:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
BEEP:C151
CONFIRM:C162("Voulez-vous enregistrer les modifications ?")
If (Ok=1)
	If (7=8)
		If (Length:C16([HeBerge:4]HB_ActionsF:49)>=31000)
			[HeBerge:4]HB_ActionsF:49:="… "+Substring:C12([HeBerge:4]HB_ActionsF:49; Length:C16([HeBerge:4]HB_ActionsF:49)+1000)
		End if 
	End if 
	ACCEPT:C269
Else 
	CANCEL:C270
End if 