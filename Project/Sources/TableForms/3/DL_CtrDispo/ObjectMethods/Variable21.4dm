//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script DL_CentresLits : b_Màj
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ((b_MàJ=1) & ([DiaLogues:3]DL_Date:2>!00-00-00!))
	CONFIRM:C162("Voulez-vous mettre à jour les attributions pour le : "+String:C10([DiaLogues:3]DL_Date:2))
	
	If (OK=1)
		i_Message("Création en cours …")
		
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=[DiaLogues:3]DL_Date:2)
		CLOSE WINDOW:C154
		
		If (Records in selection:C76([CentresLits:16])=0)
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1>=<>vl_T_CentreCodeDebut; *)  //3/2/2009
			QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_RéférenceID:1<=<>vl_T_CentreCodeFin; *)  //3/2/2009
			QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_Prestation:55=False:C215)
			
			FIRST RECORD:C50([LesCentres:9])
			
			If (Records in selection:C76([LesCentres:9])>0)
				i_Message("Création en cours …")
				
				Repeat 
					
					If ([LesCentres:9]LC_Fermé:53=False:C215)
						P_DisponibilitéCréer(0; "J"; [DiaLogues:3]DL_Date:2; 0; 0; 0; 0; 0)
						P_DisponibilitéCréer(0; "N"; [DiaLogues:3]DL_Date:2; 0; 0; 0; 0; 0)
					End if 
					
					NEXT RECORD:C51([LesCentres:9])
				Until (End selection:C36([LesCentres:9]))
				
				Rec_CentreLits
				CLOSE WINDOW:C154
			End if 
			
		End if 
		
	End if 
	
End if 