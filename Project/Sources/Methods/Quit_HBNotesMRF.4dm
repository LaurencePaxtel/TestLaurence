//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_HBNotesMRF  
//{
//{          Lundi 14 JUIN 2010 à 12:40:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
BEEP:C151
CONFIRM:C162("Voulez-vous enregistrer les modifications ?")
If (Ok=1)
	If (vt_TempNOTEMAR>"")
		[HeBerge:4]HB_Maraude:41:=[HeBerge:4]HB_Maraude:41+vt_TempNOTEMAR
	End if 
	If (vt_TempNOTEMAR2>"")
		[HeBerge:4]HB_Maraude2:51:=[HeBerge:4]HB_Maraude2:51+vt_TempNOTEMAR2
	End if 
	
	ACCEPT:C269
Else 
	CANCEL:C270
End if 