//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script : ◊ta_Attestations
//{
//{          Mardi 24 juin 2008 à 13:43:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


// #REW20170428-1
// Le popup est ré-écrit

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		P_Attestations("init")
	: (Form event code:C388=Sur clic:K2:4)
		LOAD RECORD:C52([HeBerge:4])  // #Fix20170424-5
		
		If ([HeBerge:4]HB_ReferenceID:1>0)
			P_Attestations("attestation")
		Else 
			ALERT:C41("Veuillez sélectionner un demandeur !")
		End if 
		
End case 