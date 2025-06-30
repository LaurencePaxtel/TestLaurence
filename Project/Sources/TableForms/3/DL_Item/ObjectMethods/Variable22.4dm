If (va_IDT_Typ1<="")
	ALERT:C41("Vous devez renseigner le nouveau libellé !")
Else 
	MESSAGES ON:C181
	
	If (Records in selection:C76([HeberGement:5])>0)
		vl_itemNb:=Records in selection:C76([HeberGement:5])
		
		If (i_Confirmer("Remplacer : "+va_IDT_Typ2+" par "+va_IDT_Typ1+<>va_CR+<>va_CR+String:C10(Records in selection:C76([HeberGement:5]))+" fiche(s)"))
			CREATE SET:C116([HeberGement:5]; "E_TempHG")
			READ WRITE:C146([HeberGement:5])
			
			FIRST RECORD:C50([HeberGement:5])
			APPLY TO SELECTION:C70([HeberGement:5]; P_Item_Affecter)
			
			UNLOAD RECORD:C212([HeberGement:5])
			READ ONLY:C145([HeberGement:5])
			
			USE SET:C118("E_TempHG")
			CLEAR SET:C117("E_TempHG")
			
			FIRST RECORD:C50([HeberGement:5])
		End if 
		
	Else 
		StrAlerte(1; "")
	End if 
	
	MESSAGES OFF:C175
End if 

vl_itemNb:=Records in selection:C76([HeberGement:5])