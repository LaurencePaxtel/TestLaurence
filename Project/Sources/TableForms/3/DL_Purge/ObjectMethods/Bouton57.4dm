If (Form event code:C388=Sur clic:K2:4)
	
	If (Records in table:C83([LesCentres:9])>0)
		CONFIRM:C162("Mettre à jour les fermetures de centres  (case à coché Fermé )"+Char:C90(13)+"Confirmez-vous la mise à jour ?")
		If (OK=1)
			i_Message("Mise à jour en cours …")
			C_DATE:C307(vd_Date)
			
			vd_Date:=Current date:C33
			
			//Etat du centre Fermé ou ouvert
			ALL RECORDS:C47([LesCentres:9])
			MultiSoc_Filter(->[LesCentres:9])
			READ WRITE:C146([LesCentres:9])
			APPLY TO SELECTION:C70([LesCentres:9]; wUut_MàJCentres)
			READ ONLY:C145([LesCentres:9])
			
			
			CLOSE WINDOW:C154
		End if 
	End if 
End if 