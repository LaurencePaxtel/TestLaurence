If (Form event code:C388=Sur clic:K2:4)
	If (vl_Fiches>0)
		If (i_Confirmer("Transfert de "+String:C10(vl_Fiches)+" fiche(s) ?"))
			vb_ReporEnCours:=True:C214
			
			If (7=8)  //Pour les test
				<>vb_T_ModeCHRS:=True:C214
				<>vb_T_FullDuplex:=True:C214
			End if 
			
			
			If (F_Report_FullDuplex(->tl_Trans_Réf_HG; False:C215; "Reprise du transfert du "+String:C10(vd_Date1; Interne date court:K1:7)))
			End if 
			
			
			vb_ReporEnCours:=False:C215
		End if 
	Else 
		ALERT:C41("Aucune fiche à transférer !")
	End if 
End if 
