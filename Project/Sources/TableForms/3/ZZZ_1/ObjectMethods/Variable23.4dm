//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script DL_CentresLits : b_Sup
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ((b_Sup=1) & ([DiaLogues:3]DL_Date:2>!00-00-00!))
	CONFIRM:C162("Voulez-vous supprimer les attributions pour le : "+String:C10([DiaLogues:3]DL_Date:2))
	If (OK=1)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2)
		MultiSoc_Filter(->[HeberGement:5])
		If (Records in selection:C76([HeberGement:5])>0)
			ALERT:C41("Suppression impossible : il existe des hebergements à cette date.")
		Else 
			i_Message("Suppression en cours …")
			QUERY:C277([CentresLits:16]; [CentresLits:16]CL_Date:3=[DiaLogues:3]DL_Date:2)
			MultiSoc_Filter(->[CentresLits:16])
			CLOSE WINDOW:C154
			If (Records in selection:C76([CentresLits:16])>0)
				i_Message("Suppression en cours …")
				DELETE SELECTION:C66([CentresLits:16])
				UNLOAD RECORD:C212([CentresLits:16])
				CLOSE WINDOW:C154
				Rec_CentreLits
			End if 
		End if 
	End if 
End if 