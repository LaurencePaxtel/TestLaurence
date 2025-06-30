If (Size of array:C274(tl_ItemOldRéf)>0)
	READ WRITE:C146([HeberGement:5])
	QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_ItemOldRéf)
	If (Records in selection:C76([HeberGement:5])>0)
		APPLY TO SELECTION:C70([HeberGement:5]; tp_ItemRub{ta_ItemRub}->:=va_ItemValeur)
	End if 
	UNLOAD RECORD:C212([HeberGement:5])
	READ ONLY:C145([HeberGement:5])
	
	i_Message("Recherche…")
	P_HébergementVeilleFind
	CLOSE WINDOW:C154
	
End if 