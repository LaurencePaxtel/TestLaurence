$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur entête:K2:17)
	: ($vl_EventFF=Sur impression corps:K2:18)
		
		If (VEntierLong1=[CentresLits:16]CL_Niveau:17)
			vl_LC_cCapaT:=vl_LC_cCapaT+[CentresLits:16]CL_Capacité:4
			vl_LC_cDpTT:=vl_LC_cDpTT+[CentresLits:16]CL_DispoTotal:5
			vl_LC_cNbPersT:=vl_LC_cNbPersT+[CentresLits:16]CL_NbPersonnes:18
			vl_LC_cNbPersNewT:=vl_LC_cNbPersNewT+[CentresLits:16]CL_NbPersonnesNouvelles:19
			vl_LC_cNbFamilleT:=vl_LC_cNbFamilleT+[CentresLits:16]CL_NbFamilles:20
			vl_LC_cNbAdulteT:=vl_LC_cNbAdulteT+[CentresLits:16]CL_NbAdultes:21
			vl_LC_cEnfantT:=vl_LC_cEnfantT+[CentresLits:16]CL_NbEnfants:22
		Else 
			VEntierLong1:=[CentresLits:16]CL_Niveau:17
			vl_LC_cCapaT:=[CentresLits:16]CL_Capacité:4
			vl_LC_cDpTT:=[CentresLits:16]CL_DispoTotal:5
			vl_LC_cNbPersT:=[CentresLits:16]CL_NbPersonnes:18
			vl_LC_cNbPersNewT:=[CentresLits:16]CL_NbPersonnesNouvelles:19
			vl_LC_cNbFamilleT:=[CentresLits:16]CL_NbFamilles:20
			vl_LC_cNbAdulteT:=[CentresLits:16]CL_NbAdultes:21
			vl_LC_cEnfantT:=[CentresLits:16]CL_NbEnfants:22
			
		End if 
		
		
	: ($vl_EventFF=Sur impression pied de page:K2:20)
		vl_Page:=Printing page:C275
End case 