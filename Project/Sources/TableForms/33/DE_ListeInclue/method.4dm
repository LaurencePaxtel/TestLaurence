If (Form event code:C388=Sur affichage corps:K2:22)
	ve_Durée:=0
	If ([DossierSante:33]DE_EntréeDate:62>!00-00-00!) & ([DossierSante:33]DE_SortieDate:69>!00-00-00!) & ([DossierSante:33]DE_SortieDate:69>=[DossierSante:33]DE_EntréeDate:62)
		ve_Durée:=[DossierSante:33]DE_SortieDate:69-[DossierSante:33]DE_EntréeDate:62+1
	End if 
End if 