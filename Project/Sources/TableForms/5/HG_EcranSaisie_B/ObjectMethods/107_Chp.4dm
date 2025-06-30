//29/03/2005


If (7=8)
	[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_FamNbJour:107
	If ([HeberGement:5]HG_NuitTOTAL:93<[HeberGement:5]HG_NuitenCours:92)
		[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_NuitenCours:92
	End if 
	[HeberGement:5]HG_NuitReste:95:=[HeberGement:5]HG_NuitTOTAL:93-[HeberGement:5]HG_NuitenCours:92
	[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
End if 
P_HG_FamilleTotal