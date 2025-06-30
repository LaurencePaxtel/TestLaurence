//Script 

C_LONGINT:C283($ii)
$ii:=Records in table:C83([HeBerge:4])
If ($ii>0)
	CONFIRM:C162("Suppression des notes Dossier social."+Char:C90(13)+"Confirmez-vous la suppression ?")
	If (OK=1)
		MESSAGES ON:C181
		READ WRITE:C146([HeBerge:4])
		ALL RECORDS:C47([HeBerge:4])
		APPLY TO SELECTION:C70([HeBerge:4]; [HeBerge:4]HB_Social:42:="")
		UNLOAD RECORD:C212([HeBerge:4])
		READ ONLY:C145([HeBerge:4])
		MESSAGES OFF:C175
		BEEP:C151
	End if 
Else 
	BEEP:C151
End if 