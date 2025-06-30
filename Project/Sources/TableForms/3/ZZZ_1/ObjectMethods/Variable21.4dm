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
		MultiSoc_Filter(->[CentresLits:16])
		CLOSE WINDOW:C154
		If (Records in selection:C76([CentresLits:16])>0)
			
		Else 
			ALL RECORDS:C47([LesCentres:9])
			MultiSoc_Filter(->[LesCentres:9])
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