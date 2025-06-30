If (Records in selection:C76([HeberGement:5])>0)
	If (i_Confirmer("Confirmez-vous le traitement des dates de naissance"))
		$va_Fiches:=String:C10(Records in selection:C76([HeberGement:5]))
		$ii:=0
		READ WRITE:C146([HeberGement:5])
		READ WRITE:C146([HeBerge:4])
		FIRST RECORD:C50([HeberGement:5])
		i_Message("Traitement en cours : "+$va_Fiches+"/0")
		Repeat 
			i_MessageSeul("Traitement en cours : "+$va_Fiches+"/"+String:C10($ii))
			Repeat 
				LOAD RECORD:C52([HeberGement:5])
			Until (Not:C34(Locked:C147([HeberGement:5])))
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
			If (Records in selection:C76([HeBerge:4])=1)
				Repeat 
					LOAD RECORD:C52([HeBerge:4])
				Until (Not:C34(Locked:C147([HeBerge:4])))
				[HeBerge:4]HB_DateNéLe:5:=vd_item0
				[HeBerge:4]HB_Clé:2:=Uut_HébergéClé(->[HeBerge:4]HB_Nom:3; ->[HeBerge:4]HB_Prénom:4; ->[HeBerge:4]HB_DateNéLe:5)
				SAVE RECORD:C53([HeBerge:4])
				UNLOAD RECORD:C212([HeBerge:4])
			End if 
			
			[HeberGement:5]HG_DateNéLe:24:=vd_item0
			[HeberGement:5]HG_Age:23:=Uut_HébergéAgePlus(->[HeberGement:5]HG_DateNéLe:24; ->[HeberGement:5]HG_Date:4)
			[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
			
			SAVE RECORD:C53([HeberGement:5])
			UNLOAD RECORD:C212([HeberGement:5])
			
			NEXT RECORD:C51([HeberGement:5])
		Until (End selection:C36([HeberGement:5]))
		REDRAW:C174([HeberGement:5])
		CLOSE WINDOW:C154
		READ ONLY:C145([HeberGement:5])
		READ ONLY:C145([HeBerge:4])
	End if 
Else 
	StrAlerte(1; "")
End if 