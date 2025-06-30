If ([HeBerge:4]HB_ReferenceID:1>0)
	If ([HeBerge:4]HB_CléFam:47>"")
		StrAlerte(19; "")
	Else 
		READ WRITE:C146([HeBerge:4])
		If (i_NonVerrou(->[HeBerge:4]))
			[HeBerge:4]HB_Trans_CléFam:56:=[HeBerge:4]HB_CléFam:47
			[HeBerge:4]HB_CléFam:47:=F_LienDeFamille("Nouveau")
			
			SAVE RECORD:C53([HeBerge:4])
			va_LeNoFAM:=[HeBerge:4]HB_CléFam:47
		End if 
		UNLOAD RECORD:C212([HeBerge:4])
		READ ONLY:C145([HeBerge:4])
		If (va_LeNoFAM>"")
			CANCEL:C270
		Else 
			va_LeNoFAM:=""
		End if 
	End if 
Else 
	StrAlerte(2; "")
End if 