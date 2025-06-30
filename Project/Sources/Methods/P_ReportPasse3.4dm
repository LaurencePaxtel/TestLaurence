//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ReportPasse3
//{
//{          Lundi 18 juin 2001 à 11:27:55
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
		
		[HeberGement:5]HG_Reporté:94:=<>va_RepR
		[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
		SAVE RECORD:C53([HeberGement:5])
		
		UNLOAD RECORD:C212([HeberGement:5])
	Else 
		
		If (i_NonVerrou(->[HeberGement:5]))
			
			If ([HeberGement:5]HG_Cloturée:67)
				
				If (ve_IDT_ProlongTotN>0)
					[HeberGement:5]HG_Reporté:94:=<>va_RepRP
				Else 
					[HeberGement:5]HG_Reporté:94:=<>va_RepR
				End if 
				
			Else 
				[HeberGement:5]HG_Reporté:94:=<>va_RepRE
			End if 
			
			[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
			
			// Modifié par : Scanu Rémy (10/10/2023)
			[HeberGement:5]HG_TimeStamp:180:=outilsTimeStamp(Current date:C33(*); Current time:C178(*))
			
			// Modifié par : Scanu Rémy (09/11/2023)
			// Mise en place d'un booléen pour savoir si la sauvegarde provient de l'application mobile ou pas
			[HeberGement:5]importApplicationMobile:184:=False:C215
			SAVE RECORD:C53([HeberGement:5])
		End if 
		
	End if 
	
End if 

UNLOAD RECORD:C212([HeberGement:5])
READ ONLY:C145([HeberGement:5])