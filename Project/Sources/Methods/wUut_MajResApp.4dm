//%attributes = {}
If ([HeberGement:5]HG_NuitTOTAL:93<=0)
	[HeberGement:5]HG_Réservation:91:=False:C215
	[HeberGement:5]HG_NuitTOTAL:93:=1
	[HeberGement:5]HG_NuitenCours:92:=1
	[HeberGement:5]HG_NuitReste:95:=0
	[HeberGement:5]HG_Reporté:94:=""
Else 
	[HeberGement:5]HG_Réservation:91:=True:C214
	[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
	If ([HeberGement:5]HG_Reporté:94=<>va_RepF)
		[HeberGement:5]HG_Reporté:94:=""
	End if 
	If ([HeberGement:5]HG_Reporté:94=<>va_RepO)
		[HeberGement:5]HG_Reporté:94:=""
	End if 
End if 

//06/09/2004
[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)