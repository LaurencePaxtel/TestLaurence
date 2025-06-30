//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Quit_SIAODivers  
//{          Mardi 29 mars 2011 à 15:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
BEEP:C151
CONFIRM:C162("Voulez-vous enregistrer les modifications ?")
If (Ok=1)
	If (7=8)
		If (Length:C16([SIAO_Divers:58]Sd_Valeur:4)>=31000)
			[SIAO_Divers:58]Sd_Valeur:4:="… "+Substring:C12([SIAO_Divers:58]Sd_Valeur:4; Length:C16([SIAO_Divers:58]Sd_Valeur:4)+1000)
		End if 
	End if 
	ACCEPT:C269
Else 
	CANCEL:C270
End if 