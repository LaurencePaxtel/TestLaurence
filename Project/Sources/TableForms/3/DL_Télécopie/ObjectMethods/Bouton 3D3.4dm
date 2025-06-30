If ([HeberGement:5]HG_ReferenceID:1>0)
	
	If ([HeberGement:5]HG_FamGroupe:102>"")
		<>vt_Hotel:=<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"N° de bon "+String:C10([HeberGement:5]HG_FamNoDeBon:136)+<>va_CR+<>va_CR
		
		<>vt_Hotel:=<>vt_Hotel+[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22+<>va_CR+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"("+[HeberGement:5]HG_FamCompo:105+")"+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"Nb de personnes : "+String:C10([HeberGement:5]HG_FamNbPers:106)+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"Nb de chambres : "+String:C10([HeberGement:5]HG_FamNbChambre:108)+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"Prix par jour : "+String:C10([HeberGement:5]HG_FamPrixJour:109)+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"Nb de nuits : "+String:C10([HeberGement:5]HG_FamNbJour:107)+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"TOTAL : "+String:C10([HeberGement:5]HG_FamTotal:110)+" €"+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+<>va_CR
		
		<>vt_Hotel:=<>vt_Hotel+"1 -"+[HeberGement:5]HG_FamDistri1:112+" : "+String:C10([HeberGement:5]HG_FamDistri1M:118)+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"2 -"+[HeberGement:5]HG_FamDistri2:113+" : "+String:C10([HeberGement:5]HG_FamDistri2M:119)+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"3 -"+[HeberGement:5]HG_FamDistri3:114+" : "+String:C10([HeberGement:5]HG_FamDistri3M:120)+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"4 -"+[HeberGement:5]HG_FamDistri4:115+" : "+String:C10([HeberGement:5]HG_FamDistri4M:121)+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+"5 -"+[HeberGement:5]HG_FamDistri5:116+" : "+String:C10([HeberGement:5]HG_FamDistri5M:122)+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+<>va_CR
		<>vt_Hotel:=<>vt_Hotel+<>va_CR
		
		<>vt_Hotel:=<>vt_Hotel+"Réservation du "+String:C10([HeberGement:5]HG_Date:4)+" au "+String:C10([HeberGement:5]HG_Date:4+[HeberGement:5]HG_FamNbJour:107)+" au matin"+<>va_CR
		
		P_HébergementTextes("TH"; -><>PR_HBTexteH; -13; "Texte fax hôtel")
	Else 
		ALERT:C41("Vous devez vous positionner dans la liste sur la bonne personne !")
	End if 
	
Else 
	StrAlerte(22; "")
End if 