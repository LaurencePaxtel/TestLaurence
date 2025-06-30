If (<>ve_Si_ModeCHRS=0)  //• Si fiche d'hébergement profil Prestation
	OBJECT SET ENTERABLE:C238([HeberGement:5]HG_NuitTOTAL:93; ([HeberGement:5]HG_Réservation:91=True:C214))
	
	If ([HeberGement:5]HG_Réservation:91=False:C215)
		
		If ([HeberGement:5]HG_NuitenCours:92>0)
			[HeberGement:5]HG_NuitTOTAL:93:=[HeberGement:5]HG_NuitenCours:92
		Else 
			[HeberGement:5]HG_NuitTOTAL:93:=1
		End if 
		
		[HeberGement:5]HG_NuitReste:95:=0
	End if 
	
	//10/01/2011
	[HeberGement:5]HG_RéservationDateFin:134:=F_RéservationDateFin([HeberGement:5]HG_Date:4; [HeberGement:5]HG_NuitReste:95)
End if 