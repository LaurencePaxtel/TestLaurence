
If (ta_ItemRub=8)
	ALERT:C41("La rubrique 'Date de naissance' ne peut être modifiée ici, voir fusion !")
Else 
	If (va_IDT_Typ1<="")
		ALERT:C41("Vous devez renseigner le nouveau libellé !")
	Else 
		$nosel:=0
		$noHGID:=0
		MESSAGES ON:C181
		If ([HeberGement:5]HG_FicheNuméro:3>"")
			$noHGID:=[HeberGement:5]HG_HB_ID:19
			CREATE SET:C116([HeberGement:5]; "E_TempHG")
			$nosel:=Selected record number:C246([HeberGement:5])
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$noHGID)
			If (i_Confirmer("Remplacer : "+va_IDT_Typ2+" par "+va_IDT_Typ1+Char:C90(13)+String:C10(Records in selection:C76([HeberGement:5]))))
				
				READ WRITE:C146([HeberGement:5])
				FIRST RECORD:C50([HeberGement:5])
				APPLY TO SELECTION:C70([HeberGement:5]; tp_ItemRub{ta_ItemRub}->:=va_IDT_Typ1)
				UNLOAD RECORD:C212([HeberGement:5])
				READ ONLY:C145([HeberGement:5])
				USE SET:C118("E_TempHG")
				CLEAR SET:C117("E_TempHG")
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
				ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)
				
				FIRST RECORD:C50([HeberGement:5])
				GOTO SELECTED RECORD:C245([HeberGement:5]; $nosel)
			End if 
			
			CLEAR SET:C117("E_TempHG")
		Else 
			StrAlerte(5; "")
		End if 
		MESSAGES OFF:C175
		
	End if 
End if 
vl_itemNb:=Records in selection:C76([HeberGement:5])