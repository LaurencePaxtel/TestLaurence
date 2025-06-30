If (Form event code:C388=Sur double clic:K2:5)
	C_TEXT:C284($nomLettre_t)
	
	If (Form:C1466.elementSelection#Null:C1517)
		UNLOAD RECORD:C212([DOCWPRO:121])
		REDUCE SELECTION:C351([DOCWPRO:121]; 0)
		
		Form:C1466.selectionDocument:=True:C214
		
		$nomLettre_t:=Form:C1466.elementSelection[0].nom
		
		QUERY:C277([DOCWPRO:121]; [DOCWPRO:121]nom:3=$nomLettre_t; *)
		QUERY:C277([DOCWPRO:121];  & ; [DOCWPRO:121]structureRef:2=<>ref_soc_active)
		
		ACCEPT:C269
	End if 
	
End if 