//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris
//{ © DBsolutions/Paxtel
//{
//{          Procédure : DébutDécTableCritèreDS
//{
//{          Mardi 18 avril 2006 à 17:23
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
//••• TABLEAU •••

C_LONGINT:C283($1)

C_LONGINT:C283($ii)


Case of 
	: ($1=0)
		//Etat civil
		ARRAY TEXT:C222(<>ta_DsEtCiv; 0)
		ARRAY INTEGER:C220(<>te_DsEtCiv; 0)
		
		//Nationalité
		ARRAY TEXT:C222(<>ta_DsNat; 0)
		ARRAY INTEGER:C220(<>te_DsNat; 0)
		
		//PersMaj
		ARRAY TEXT:C222(<>ta_DsPmaj; 0)
		ARRAY INTEGER:C220(<>te_DsPmaj; 0)
		
		//ConnuSSP_Motif
		ARRAY TEXT:C222(<>ta_DsCoSSP; 0)
		ARRAY INTEGER:C220(<>te_DsCoSSP; 0)
		
		//Compagnie_Problèmatique
		ARRAY TEXT:C222(<>ta_DsComp; 0)
		ARRAY INTEGER:C220(<>te_DsComp; 0)
		
		//Régime1
		ARRAY TEXT:C222(<>ta_DsRgim1; 0)
		ARRAY INTEGER:C220(<>te_DsRgim1; 0)
		
		//Papier1
		ARRAY TEXT:C222(<>ta_DsPap1; 0)
		ARRAY INTEGER:C220(<>te_DsPap1; 0)
		
		//Soc1
		ARRAY TEXT:C222(<>ta_DsSoc1; 0)
		ARRAY INTEGER:C220(<>te_DsSoc1; 0)
		
		//Res1
		ARRAY TEXT:C222(<>ta_DsRes1; 0)
		ARRAY INTEGER:C220(<>te_DsRes1; 0)
		
		//Err
		ARRAY TEXT:C222(<>ta_DsErr; 0)
		ARRAY INTEGER:C220(<>te_DsErr; 0)
		
		//NeOu
		ARRAY TEXT:C222(<>ta_DsNeOu; 0)
		ARRAY INTEGER:C220(<>te_DsNeOu; 0)
		
		
		//Langue
		ARRAY TEXT:C222(<>ta_DsLang; 0)
		ARRAY INTEGER:C220(<>te_DsLang; 0)
		
		//Provenance_DerHeb
		ARRAY TEXT:C222(<>ta_DsDerH; 0)
		ARRAY INTEGER:C220(<>te_DsDerH; 0)
		
		
		
		
		
		//CouSoc
		ARRAY TEXT:C222(<>ta_DsCouvS; 0)
		ARRAY INTEGER:C220(<>te_DsCouvS; 0)
		
		
		
	: ($1=1)
		
		//Etat civil    
		COPY ARRAY:C226(<>ta_TBEtCiv; <>ta_DsEtCiv)
		ARRAY INTEGER:C220(<>te_DsEtCiv; Size of array:C274(<>ta_DsEtCiv))
		For ($ii; 1; Size of array:C274(<>ta_DsEtCiv))
			<>te_DsEtCiv{$ii}:=1
		End for 
		
		//Nationalité    
		COPY ARRAY:C226(<>ta_TBNatio; <>ta_DsNat)
		ARRAY INTEGER:C220(<>te_DsNat; Size of array:C274(<>ta_DsNat))
		For ($ii; 1; Size of array:C274(<>ta_DsNat))
			<>te_DsNat{$ii}:=1
		End for 
		
		//PersMaj
		COPY ARRAY:C226(<>ta_MRMpro; <>ta_DsPmaj)
		ARRAY INTEGER:C220(<>te_DsPmaj; Size of array:C274(<>ta_DsPmaj))
		For ($ii; 1; Size of array:C274(<>ta_DsPmaj))
			<>te_DsPmaj{$ii}:=1
		End for 
		
		//ConnuSSP_Motif
		COPY ARRAY:C226(<>ta_MRCssp; <>ta_DsCoSSP)
		ARRAY INTEGER:C220(<>te_DsCoSSP; Size of array:C274(<>ta_DsCoSSP))
		For ($ii; 1; Size of array:C274(<>ta_DsCoSSP))
			<>te_DsCoSSP{$ii}:=1
		End for 
		
		//Compagnie_Problèmatique
		COPY ARRAY:C226(<>ta_MRCssp; <>ta_DsComp)
		ARRAY INTEGER:C220(<>te_DsComp; Size of array:C274(<>ta_DsComp))
		For ($ii; 1; Size of array:C274(<>ta_DsComp))
			<>te_DsComp{$ii}:=1
		End for 
		
		//Régime1
		COPY ARRAY:C226(<>ta_DSrég; <>ta_DsRgim1)
		ARRAY INTEGER:C220(<>te_DsRgim1; Size of array:C274(<>ta_DsRgim1))
		For ($ii; 1; Size of array:C274(<>ta_DsRgim1))
			<>te_DsRgim1{$ii}:=1
		End for 
		
		//Papier1
		COPY ARRAY:C226(<>ta_DSidté; <>ta_DsPap1)
		ARRAY INTEGER:C220(<>te_DsPap1; Size of array:C274(<>ta_DsPap1))
		For ($ii; 1; Size of array:C274(<>ta_DsPap1))
			<>te_DsPap1{$ii}:=1
		End for 
		
		//Soc1
		COPY ARRAY:C226(<>ta_DSsuivi; <>ta_DsSoc1)
		ARRAY INTEGER:C220(<>te_DsSoc1; Size of array:C274(<>ta_DsSoc1))
		For ($ii; 1; Size of array:C274(<>ta_DsSoc1))
			<>te_DsSoc1{$ii}:=1
		End for 
		
		//Res1
		COPY ARRAY:C226(<>ta_MRrs; <>ta_DsRes1)
		ARRAY INTEGER:C220(<>te_DsRes1; Size of array:C274(<>ta_DsRes1))
		For ($ii; 1; Size of array:C274(<>ta_DsRes1))
			<>te_DsRes1{$ii}:=1
		End for 
		
		//Err
		COPY ARRAY:C226(<>ta_TBTpsErr; <>ta_DsErr)
		ARRAY INTEGER:C220(<>te_DsErr; Size of array:C274(<>ta_DsErr))
		For ($ii; 1; Size of array:C274(<>ta_DsErr))
			<>te_DsErr{$ii}:=1
		End for 
		
		//NeOu
		COPY ARRAY:C226(<>ta_TBLieuNé; <>ta_DsNeOu)
		ARRAY INTEGER:C220(<>te_DsNeOu; Size of array:C274(<>ta_DsNeOu))
		For ($ii; 1; Size of array:C274(<>ta_DsNeOu))
			<>te_DsNeOu{$ii}:=1
		End for 
		
		//Langue
		COPY ARRAY:C226(<>ta_Lgs; <>ta_DsLang)
		ARRAY INTEGER:C220(<>te_DsLang; Size of array:C274(<>ta_DsLang))
		For ($ii; 1; Size of array:C274(<>ta_DsLang))
			<>te_DsLang{$ii}:=1
		End for 
		
		//Provenance_DerHeb
		COPY ARRAY:C226(<>ta_DerLH; <>ta_DsDerH)
		ARRAY INTEGER:C220(<>te_DsDerH; Size of array:C274(<>ta_DsDerH))
		For ($ii; 1; Size of array:C274(<>ta_DsDerH))
			<>te_DsDerH{$ii}:=1
		End for 
		
		
		
		//CouSoc
		COPY ARRAY:C226(<>ta_DScs; <>ta_DsCouvS)
		ARRAY INTEGER:C220(<>te_DsCouvS; Size of array:C274(<>ta_DsCouvS))
		For ($ii; 1; Size of array:C274(<>ta_DsCouvS))
			<>te_DsCouvS{$ii}:=1
		End for 
		
		
End case 
