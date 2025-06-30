//%attributes = {}

If (vt_TempObs>"")
	If (Length:C16([DossierSante:33]DE_NoteObservation:71)>=30000)
		[DossierSante:33]DE_NoteObservation:71:="… "+Substring:C12([DossierSante:33]DE_NoteObservation:71; Length:C16([DossierSante:33]DE_NoteObservation:71)+1000)
	End if 
	[DossierSante:33]DE_NoteObservation:71:=[DossierSante:33]DE_NoteObservation:71+<>va_CR+vt_TempObs
End if 
vt_TempObs:=""

If (vt_TempTrans>"")
	If (Length:C16([DossierSante:33]DE_NoteTransmission:72)>=30000)
		[DossierSante:33]DE_NoteTransmission:72:="… "+Substring:C12([DossierSante:33]DE_NoteTransmission:72; Length:C16([DossierSante:33]DE_NoteTransmission:72)+1000)
	End if 
	[DossierSante:33]DE_NoteTransmission:72:=[DossierSante:33]DE_NoteTransmission:72+<>va_CR+vt_TempTrans
End if 
vt_TempTrans:=""

If (vt_TempPans>"")
	If (Length:C16([DossierSante:33]DE_NotePansement:73)>=30000)
		[DossierSante:33]DE_NotePansement:73:="… "+Substring:C12([DossierSante:33]DE_NotePansement:73; Length:C16([DossierSante:33]DE_NotePansement:73)+1000)
	End if 
	[DossierSante:33]DE_NotePansement:73:=[DossierSante:33]DE_NotePansement:73+<>va_CR+vt_TempPans
End if 
vt_TempPans:=""

If (vt_TempAS>"")
	If (Length:C16([DossierSante:33]DE_NoteAS:133)>=30000)
		[DossierSante:33]DE_NoteAS:133:="… "+Substring:C12([DossierSante:33]DE_NoteAS:133; Length:C16([DossierSante:33]DE_NoteAS:133)+1000)
	End if 
	[DossierSante:33]DE_NoteAS:133:=[DossierSante:33]DE_NoteAS:133+<>va_CR+vt_TempAS
End if 
vt_TempAS:=""