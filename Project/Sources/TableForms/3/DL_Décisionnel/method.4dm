//Formule Format : DL_Décisionnel
If (Form event code:C388=Sur chargement:K2:1)
	[DiaLogues:3]DL_Date:2:=Current date:C33(*)
	[DiaLogues:3]DL_LibelléN:9:=""
	
	r1:=0
	r2:=1
	r3:=0
	r4:=0
	rJourNuit1:=1  //Jour
	rJourNuit2:=1  //Nuit
	vh_HeurTemp:=Current time:C178
	If (<>vb_ParamDisActivée) & (((<>vb_ParamDisJour) & (<>vb_ParamDisNuit=False:C215)) | ((<>vb_ParamDisJour=False:C215) & (<>vb_ParamDisNuit=True:C214)))
		rJourNuit1:=Num:C11(<>vb_ParamDisJour)
		rJourNuit2:=Num:C11(<>vb_ParamDisNuit)
	Else 
		If (<>vb_CentreEXC)
			rJourNuit1:=1
			rJourNuit2:=0
		Else 
			rJourNuit1:=Num:C11((vh_HeurTemp>=?08:00:00?) & (vh_HeurTemp<=?19:59:59?))  //Jour
			rJourNuit2:=Num:C11(rJourNuit1=0)  //Nuit
		End if 
	End if 
	i_Message("Recherche en cours…")
	P_HébergementDécisionFind(0)
	P_HébergementDécisionFind(1)
	BEEP:C151
	BEEP:C151
	CLOSE WINDOW:C154
End if 