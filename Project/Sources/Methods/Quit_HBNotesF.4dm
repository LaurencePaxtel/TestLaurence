//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Quit_HBNotesF  
//{
//{          Lundi 14 juin 2010 à 11:19:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
BEEP:C151
CONFIRM:C162("Voulez-vous enregistrer les modifications ?")
If (Ok=1)
	If (vt_TempNOTE>"")
		[HeBerge:4]Notes:6:=[HeBerge:4]Notes:6+vt_TempNOTE
	End if 
	If (vt_TempNOTE2>"")
		[HeBerge:4]HB_Notes2:50:=[HeBerge:4]HB_Notes2:50+vt_TempNOTE2
	End if 
	If (vt_TempNOTE3>"")
		[HeBerge:4]HB_Notes3:54:=[HeBerge:4]HB_Notes3:54+vt_TempNOTE3
	End if 
	If (vt_TempNOTETRANS>"")
		[HeBerge:4]HB_NotesTrans:53:=[HeBerge:4]HB_NotesTrans:53+vt_TempNOTETRANS
	End if 
	
	// #20170713-2
	If (vt_TempNOTEMARAUDE>"")
		[HeBerge:4]HB_Maraude:41:=[HeBerge:4]HB_Maraude:41+vt_TempNOTEMARAUDE
	End if 
	If (vt_TempNOTEMARAUDE2>"")
		[HeBerge:4]HB_Maraude2:51:=[HeBerge:4]HB_Maraude2:51+vt_TempNOTEMARAUDE2
	End if 
	
	// Modifié par : Kevin HASSAL (05/12/2018)
	// Ajout de la note FFV
	
	If (vt_TempNOTEFFV>"")
		[HeBerge:4]HB_Note_FVV:69:=[HeBerge:4]HB_Note_FVV:69+vt_TempNOTEFFV
	End if 
	
	
	// Modified by: Kevin HASSAL (13/01/2020)
	// Ajout de la note comptable
	
	If (vt_TempNOTEComptable>"")
		[HeBerge:4]HB_Note_Comptable:75:=[HeBerge:4]HB_Note_Comptable:75+vt_TempNOTEComptable
	End if 
	
	ACCEPT:C269
Else 
	CANCEL:C270
End if 