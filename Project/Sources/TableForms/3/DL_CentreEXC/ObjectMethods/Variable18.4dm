If (Form event code:C388=Sur clic:K2:4)
	
	//<>va_CentreEXC:=("O"*q1)+("N"*q2)
	//<>va_CentreEXCExc:=("O"*r1)+("N"*r2)
	//<>va_CentreEXCSor:=("O"*s1)+("N"*s2)
	
	//<>vb_CentreEXC:=(<>va_CentreEXC="O")
	//<>vb_CentreEXClits:=((<>va_CentreEXC="O") & ((<>va_CentreEXCSor="O")))
	
	
	//<>vb_CentreEXCExc:=(<>va_CentreEXCExc="O")
	
	//<>vh_CentreEXChD:=vh_CentreEXChD
	//<>vh_CentreEXChF:=vh_CentreEXChF
	
	//DébutInitCentreEXC(1)
	i_Message("Gestion des centres : mise à jour")
	
	READ WRITE:C146([LesCentres:9])
	For ($ii; 1; vl_TT)
		i_MessageSeul("Gestion des centres mise à jour : "+String:C10(vl_TT)+"/"+String:C10($ii))
		If (te_CCE_Check{$ii}=Num:C11(tb_CCE_Check{$ii}))
		Else 
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tl_CCE_Réf{$ii})
			If (Records in selection:C76([LesCentres:9])=1)
				Repeat 
					LOAD RECORD:C52([LesCentres:9])
				Until (Not:C34(Locked:C147([LesCentres:9])))
				[LesCentres:9]LC_Excuse:49:=(te_CCE_Check{$ii}=1)
				SAVE RECORD:C53([LesCentres:9])
				UNLOAD RECORD:C212([LesCentres:9])
			End if 
		End if 
		UNLOAD RECORD:C212([LesCentres:9])
	End for 
	READ ONLY:C145([LesCentres:9])
	CLOSE WINDOW:C154
End if 