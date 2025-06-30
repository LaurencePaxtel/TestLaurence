Case of 
	: (vl_3FR_CAS=-1)  //PÉRIODE MENSUELLE    
		
	: (vl_3FR_CAS=6)  //Demandes satisfaites
		COPY ARRAY:C226(te_LesCentre; te_3FR_SatisfCtr)
	: (vl_3FR_CAS=7)  //Demandes non satisfaites
		COPY ARRAY:C226(te_LesCentre; te_3FR_NonSatisfCtr)
	: (vl_3FR_CAS=8)  //Demandes oientées structures
		COPY ARRAY:C226(te_LesCentre; te_3FR_Non115Ctr)
	: (vl_3FR_CAS=9)
		COPY ARRAY:C226(te_LesCentre; te_3FR_NouveauCtr)
	: (vl_3FR_CAS=10)
		ARRAY INTEGER:C220(te_LesCentre; 0)
	: (vl_3FR_CAS=11)
		COPY ARRAY:C226(te_LesCentre; te_3FR_115Ctr)
	: (vl_3FR_CAS=12)
		COPY ARRAY:C226(te_LesCentre; te_3FR_PrimoCtr)
		
End case 