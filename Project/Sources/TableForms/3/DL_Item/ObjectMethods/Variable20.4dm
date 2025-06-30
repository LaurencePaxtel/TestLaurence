
If (ta_ItemRub=8)
	ALERT:C41("La rubrique 'Date de naissance' ne peut être modifiée ici, voir fusion !")
Else 
	If (va_IDT_Typ1<="")
		ALERT:C41("Vous devez renseigner le nouveau libellé !")
	Else 
		$nosel:=0
		MESSAGES ON:C181
		If ([HeberGement:5]HG_FicheNuméro:3>"")
			$nosel:=Selected record number:C246([HeberGement:5])
			If (i_Confirmer("Remplacer : "+va_IDT_Typ2+" par "+va_IDT_Typ1+Char:C90(13)+String:C10(Records in selection:C76([HeberGement:5]))))
				
				CREATE SET:C116([HeberGement:5]; "E_TempHG")
				READ WRITE:C146([HeberGement:5])
				Repeat 
					LOAD RECORD:C52([HeberGement:5])
				Until (Not:C34(Locked:C147([HeberGement:5])))
				
				tp_ItemRub{ta_ItemRub}->:=va_IDT_Typ1
				If (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_Plateforme:139))
					F_Report_FullPlateforme(->[HeberGement:5]HG_Trans_DDASS:141; [HeberGement:5]HG_Plateforme:139)
				End if 
				
				If (tp_ItemRub{ta_ItemRub}=(->[HeberGement:5]HG_CentreNom:62))
					[HeberGement:5]HG_LC_ID:61:=<>vl_TBItemCtreID
				End if 
				
				[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010
				
				SAVE RECORD:C53([HeberGement:5])
				UNLOAD RECORD:C212([HeberGement:5])
				READ ONLY:C145([HeberGement:5])
				USE SET:C118("E_TempHG")
				CLEAR SET:C117("E_TempHG")
				FIRST RECORD:C50([HeberGement:5])
				GOTO SELECTED RECORD:C245([HeberGement:5]; $nosel)
			End if 
			
		Else 
			StrAlerte(5; "")
		End if 
		MESSAGES OFF:C175
		
	End if 
End if 
vl_itemNb:=Records in selection:C76([HeberGement:5])