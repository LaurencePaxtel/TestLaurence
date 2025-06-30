//Formule format : D_Centres
$vl_EventFF:=Form event code:C388
Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		vL_NbFiches:=Records in selection:C76([LesCentres:9])
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Niveau:52; >; *)
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		FIRST RECORD:C50([LesCentres:9])
		PREVIOUS RECORD:C110([LesCentres:9])
		vl_SelF1:=0
		vl_SourisXb:=0
		vl_SourisYb:=0
		vl_SourisBtb:=0
		vb_RecHéb:=False:C215
		
		
		
		OBJECT SET ENTERABLE:C238(vd_DateRecherche; ((User in group:C338(Current user:C182; <>Groupe_DEVELOP)) | (User in group:C338(Current user:C182; <>Groupe_ADMIN))))
		
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisXb; vl_SourisYb; vl_SourisBtb)
		If ((vl_SourisXb>6) & (vl_SourisXb<437)) & ((vl_SourisYb>82) & (vl_SourisYb<472))
			If ([LesCentres:9]LC_RéférenceID:1>0)
				vb_RecHéb:=True:C214
				va_RH_Typ1:=[LesCentres:9]LC_Nom:4
				vl_RH_RéfID:=[LesCentres:9]LC_RéférenceID:1
				CANCEL:C270
			End if 
		End if 
End case 