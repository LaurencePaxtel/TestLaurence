//Script 
vd_DtRAZ:=Current date:C33
va_DtRAZ:=Request:C163("Raz Data Transfert depuis le ?"; String:C10(vd_DtRAZ; Interne date court:K1:7))

If (OK=1)
	vd_DtRAZ:=Date:C102(va_DtRAZ)
	If (vd_DtRAZ>!00-00-00!)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=vd_DtRAZ)  //;*)
		MultiSoc_Filter(->[HeberGement:5])
		//   CHERCHER([HéberGement]; & [HéberGement]HG_Trans_FicheNuméro>"")
		
		vl_DtRAZ_Nombre:=Records in selection:C76([HeberGement:5])
		If (vl_DtRAZ_Nombre>0)
			CONFIRM:C162("Raz Data Transfert :  remettre à blanc ou zero les données des champs Transferts"+Char:C90(13)+"Nombre de fiches : "+String:C10(vl_DtRAZ_Nombre; "## ### ##0")+Char:C90(13)+"Confirmez-vous la remise à zéro ?")
			If (OK=1)
				i_Message("Raz Data Transfert : remise à zéro en cours")
				READ WRITE:C146([HeberGement:5])
				APPLY TO SELECTION:C70([HeberGement:5]; wUut_ChpTransfert)
				READ ONLY:C145([HeberGement:5])
				CLOSE WINDOW:C154
			End if 
		Else 
			ALERT:C41("Aucune fiche trouvée depuis le "+String:C10(vd_DtRAZ; Interne date court:K1:7))
		End if 
	End if 
End if 

