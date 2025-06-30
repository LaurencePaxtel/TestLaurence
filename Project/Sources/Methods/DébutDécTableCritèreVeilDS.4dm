//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutDécTableCritèreVeilDS
//{
//{          Vendredi 10 mars 2006 à 12:44
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//••• TABLEAU •••

C_LONGINT:C283($1)

C_LONGINT:C283($ii)
Case of 
	: ($1=0)
		//Etat civil
		ARRAY TEXT:C222(<>ta_vDSEtCiv; 0)
		ARRAY INTEGER:C220(<>te_vDSEtCiv; 0)
		//Nationalité
		ARRAY TEXT:C222(<>ta_vDSNation; 0)
		ARRAY INTEGER:C220(<>te_vDSNation; 0)
		//NeOu
		ARRAY TEXT:C222(<>ta_vDSNeOu; 0)
		ARRAY INTEGER:C220(<>te_vDSNeOu; 0)
		//Langue
		ARRAY TEXT:C222(<>ta_vDSLang; 0)
		ARRAY INTEGER:C220(<>te_vDSLang; 0)
		//dernier hébergement
		ARRAY TEXT:C222(<>ta_vDSDerH; 0)
		ARRAY INTEGER:C220(<>te_vDSDerH; 0)
		//Personne majeu = haute garonne depuis
		ARRAY TEXT:C222(<>ta_vDSPMaj; 0)
		ARRAY INTEGER:C220(<>te_vDSPMaj; 0)
		//Temps d'errance
		ARRAY TEXT:C222(<>ta_vDSTsEr; 0)
		ARRAY INTEGER:C220(<>te_vDSTsEr; 0)
		//Problématique = compagnie
		ARRAY TEXT:C222(<>ta_vDSOrient2; 0)
		ARRAY INTEGER:C220(<>te_vDSOrient2; 0)
		//Probléme de santé = connaissance
		ARRAY TEXT:C222(<>ta_vDSCon; 0)
		ARRAY INTEGER:C220(<>te_vDSCon; 0)
		//papier d'identité 1
		ARRAY TEXT:C222(<>ta_vDSPidt; 0)
		ARRAY INTEGER:C220(<>te_vDSPidt; 0)
		//Régime 1
		ARRAY TEXT:C222(<>ta_vDSRégim; 0)
		ARRAY INTEGER:C220(<>te_vDSRégim; 0)
		//Motif = connu SSP
		ARRAY TEXT:C222(<>ta_vDCssp; 0)
		ARRAY INTEGER:C220(<>te_vDSCssp; 0)
		//Couverture so 1
		ARRAY TEXT:C222(<>ta_vDScs1; 0)
		ARRAY INTEGER:C220(<>te_vDScs1; 0)
		//Couverture so 2
		ARRAY TEXT:C222(<>ta_vDScs2; 0)
		ARRAY INTEGER:C220(<>te_vDScs2; 0)
		//Couverture so 3
		ARRAY TEXT:C222(<>ta_vDScs3; 0)
		ARRAY INTEGER:C220(<>te_vDScs3; 0)
		//Ressource 1
		ARRAY TEXT:C222(<>ta_vDSres1; 0)
		ARRAY INTEGER:C220(<>te_vDSres1; 0)
		//Ressource 2
		ARRAY TEXT:C222(<>ta_vDSres2; 0)
		ARRAY INTEGER:C220(<>te_vDSres2; 0)
		//Ressource 3
		ARRAY TEXT:C222(<>ta_vDSres3; 0)
		ARRAY INTEGER:C220(<>te_vDSres3; 0)
		
		
		//Ressource 3
		ARRAY TEXT:C222(<>ta_vDSres3; 0)
		ARRAY INTEGER:C220(<>te_vDSres3; 0)
		
		
	: ($1=1)
		//Etat civil    
		COPY ARRAY:C226(<>ta_TBEtCiv; <>ta_vDSEtCiv)
		ARRAY INTEGER:C220(<>te_vDSEtCiv; Size of array:C274(<>ta_vDSEtCiv))
		For ($ii; 1; Size of array:C274(<>te_vDSEtCiv))
			<>te_vDSEtCiv{$ii}:=1
		End for 
		
		//Nationalité
		COPY ARRAY:C226(<>ta_TBNatio; <>ta_vDSNation)
		ARRAY INTEGER:C220(<>te_vDSNation; Size of array:C274(<>ta_vDSNation))
		For ($ii; 1; Size of array:C274(<>te_vDSNation))
			<>te_vDSNation{$ii}:=1
		End for 
		
		//NeOu
		COPY ARRAY:C226(<>ta_TBLieuNé; <>ta_vDSNeOu)
		ARRAY INTEGER:C220(<>te_vDSNeOu; Size of array:C274(<>ta_vDSNeOu))
		For ($ii; 1; Size of array:C274(<>te_vDSNeOu))
			<>te_vDSNeOu{$ii}:=1
		End for 
		
		//Langue
		COPY ARRAY:C226(<>ta_Lgs; <>ta_vDSLang)
		ARRAY INTEGER:C220(<>te_vDSLang; Size of array:C274(<>ta_vDSLang))
		For ($ii; 1; Size of array:C274(<>te_vDSLang))
			<>te_vDSLang{$ii}:=1
		End for 
		
		//dernier hébergement
		COPY ARRAY:C226(<>ta_DerLH; <>ta_vDSDerH)
		ARRAY INTEGER:C220(<>te_vDSDerH; Size of array:C274(<>ta_vDSDerH))
		For ($ii; 1; Size of array:C274(<>te_vDSDerH))
			<>te_vDSDerH{$ii}:=1
		End for 
		
		//Personne majeu = haute garonne depuis
		COPY ARRAY:C226(<>ta_MRMpro; <>ta_vDSPMaj)
		ARRAY INTEGER:C220(<>te_vDSPMaj; Size of array:C274(<>ta_vDSPMaj))
		For ($ii; 1; Size of array:C274(<>te_vDSPMaj))
			<>te_vDSPMaj{$ii}:=1
		End for 
		
		//Temps d'errance
		COPY ARRAY:C226(<>ta_MRMpro; <>ta_vDSTsEr)
		ARRAY INTEGER:C220(<>te_vDSTsEr; Size of array:C274(<>ta_vDSTsEr))
		For ($ii; 1; Size of array:C274(<>te_vDSTsEr))
			<>te_vDSTsEr{$ii}:=1
		End for 
		
		//Problématique = compagnie
		ARRAY TEXT:C222(<>ta_vDSOrient2; 0)
		ARRAY INTEGER:C220(<>te_vDSOrient2; 0)
		COPY ARRAY:C226(<>ta_MRMpro; <>ta_vDSOrient2)
		ARRAY INTEGER:C220(<>te_vDSTsEr; Size of array:C274(<>ta_vDSOrient2))
		For ($ii; 1; Size of array:C274(<>te_vDSTsEr))
			<>te_vDSTsEr{$ii}:=1
		End for 
		
		//Probléme de santé = connaissance
		ARRAY TEXT:C222(<>ta_vDSCon; 0)
		ARRAY INTEGER:C220(<>te_vDSCon; 0)
		//papier d'identité 1
		ARRAY TEXT:C222(<>ta_vDSPidt; 0)
		ARRAY INTEGER:C220(<>te_vDSPidt; 0)
		//Régime 1
		ARRAY TEXT:C222(<>ta_vDSRégim; 0)
		ARRAY INTEGER:C220(<>te_vDSRégim; 0)
		//Motif = connu SSP
		ARRAY TEXT:C222(<>ta_vDCssp; 0)
		ARRAY INTEGER:C220(<>te_vDSCssp; 0)
		//Couverture so 1
		ARRAY TEXT:C222(<>ta_vDScs1; 0)
		ARRAY INTEGER:C220(<>te_vDScs1; 0)
		//Couverture so 2
		ARRAY TEXT:C222(<>ta_vDScs2; 0)
		ARRAY INTEGER:C220(<>te_vDScs2; 0)
		//Couverture so 3
		ARRAY TEXT:C222(<>ta_vDScs3; 0)
		ARRAY INTEGER:C220(<>te_vDScs3; 0)
		//Ressource 1
		ARRAY TEXT:C222(<>ta_vDSres1; 0)
		ARRAY INTEGER:C220(<>te_vDSres1; 0)
		//Ressource 2
		ARRAY TEXT:C222(<>ta_vDSres2; 0)
		ARRAY INTEGER:C220(<>te_vDSres2; 0)
		//Ressource 3
		ARRAY TEXT:C222(<>ta_vDSres3; 0)
		ARRAY INTEGER:C220(<>te_vDSres3; 0)
		
End case 
