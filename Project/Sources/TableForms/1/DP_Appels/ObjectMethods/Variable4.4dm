If ([APpels:19]AP_Date:2>!00-00-00!)
	If (i_Confirmer("Suppression de la fiche sélectionnée !"))
		READ WRITE:C146([APpels:19])
		LOAD RECORD:C52([APpels:19])
		If (Not:C34(Locked:C147([APpels:19])))
			DELETE RECORD:C58([APpels:19])
		End if 
		READ ONLY:C145([APpels:19])
		USE SET:C118("E_APliste")
		vl_FichAP:=Records in selection:C76([APpels:19])
		ORDER BY:C49([APpels:19]; [APpels:19]AP_Date:2; <; *)
		ORDER BY:C49([APpels:19]; [APpels:19]AP_Heure:3; <)
	End if 
Else 
	StrAlerte(22; "")
End if 