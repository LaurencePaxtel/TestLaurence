//Formule format : D_Centres
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		
		OBJECT SET VISIBLE:C603(*; "Masque_CritCentre"; <>vb_T_CentreCritMasquer)
		If (va_CtrLib>"")
			//CHERCHER([LesCentres];[LesCentres]LC_Nom=([HéberGement]HG_CentreNom+
			//«"@"))
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)  //3/2/2009
			QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)  //3/2/2009                 
			QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_Nom:4=(va_CtrLib+"@"))
		Else 
			//    TOUT SELECTIONNER([LesCentres])
			
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)  //3/2/2009
			QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin)  //3/2/2009                 
		End if 
		vL_NbFichesCL:=Records in selection:C76([LesCentres:9])
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Niveau:52; >; *)
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		FIRST RECORD:C50([LesCentres:9])
		PREVIOUS RECORD:C110([LesCentres:9])
		vl_SelF1:=0
		vl_SourisXb:=0
		vl_SourisYb:=0
		vl_SourisBtb:=0
		vb_RecHéb:=False:C215
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisXb; vl_SourisYb; vl_SourisBtb)
		If ((vl_SourisXb>7) & (vl_SourisXb<615)) & ((vl_SourisYb>235) & (vl_SourisYb<472))
			If ([LesCentres:9]LC_RéférenceID:1>0)
				vb_RecHéb:=True:C214
				va_RH_Typ1:=[LesCentres:9]LC_Nom:4
				va_RH_Typ2:=[LesCentres:9]LC_Lieu:5
				vl_RH_RéfID:=[LesCentres:9]LC_RéférenceID:1
				vb_RH_Médic:=[LesCentres:9]LC_LitMédicalis:47
				CANCEL:C270
			End if 
		End if 
End case 