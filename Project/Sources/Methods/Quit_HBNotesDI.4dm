//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_HBNotes  
//{
//{          Lundi 28 Juillet 1997 à 17:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
BEEP:C151
CONFIRM:C162("Voulez-vous enregistrer les modifications ?")
If (Ok=1)
	If (7=8)
		If (Length:C16([HeBerge:4]HB_Infirmier:43)>=31000)
			[HeBerge:4]HB_Infirmier:43:="… "+Substring:C12([HeBerge:4]HB_Infirmier:43; Length:C16([HeBerge:4]HB_Infirmier:43)+1000)
		End if 
	End if 
	ACCEPT:C269
Else 
	CANCEL:C270
End if 