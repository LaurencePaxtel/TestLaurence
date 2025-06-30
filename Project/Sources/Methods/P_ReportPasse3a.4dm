//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ReportPasse3
//{
//{          Lundi 19 janvier 2004 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

READ WRITE:C146([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]HG_FicheNuméro:3=Va_NoUFicR)
If (Records in selection:C76([HeberGement:5])=1)
	If ($1=0)
		Repeat 
			LOAD RECORD:C52([HeberGement:5])
		Until (Not:C34(Locked:C147([HeberGement:5])))
		If ([HeberGement:5]HG_Cloturée:67)
			[HeberGement:5]HG_Reporté:94:=<>va_RepR
			<>vl_RepR:=<>vl_RepR+1
		Else 
			[HeberGement:5]HG_Reporté:94:=<>va_RepRE
			<>vl_RepRE:=<>vl_RepRE+1
		End if 
		[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
		
		SAVE RECORD:C53([HeberGement:5])
		UNLOAD RECORD:C212([HeberGement:5])
	Else 
		LOAD RECORD:C52([HeberGement:5])
		If (Not:C34(Locked:C147([HeberGement:5])))
			If ([HeberGement:5]HG_Cloturée:67)
				[HeberGement:5]HG_Reporté:94:=<>va_RepR
				<>vl_RepR:=<>vl_RepR+1
			Else 
				[HeberGement:5]HG_Reporté:94:=<>va_RepRE
				<>vl_RepRE:=<>vl_RepRE+1
			End if 
			[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
			
			SAVE RECORD:C53([HeberGement:5])
		End if 
		UNLOAD RECORD:C212([HeberGement:5])
		
		
	End if 
End if 
UNLOAD RECORD:C212([HeberGement:5])
READ ONLY:C145([HeberGement:5])
