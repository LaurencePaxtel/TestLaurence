//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HG_StatutEnCharge  
//{
//{          Lundi 28 Juillet 1997 à 17:35:37
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
P_BoolHeureCommute(->[HeberGement:5]HG_PriseCharge:66; ->[HeberGement:5]HG_PrChargeHeur:85)

If ([HeberGement:5]HG_PriseCharge:66)
	
	If ([HeberGement:5]HG_Transmis:65=False:C215)
		[HeberGement:5]HG_Transmis:65:=True:C214
		P_BoolHeureCommute(->[HeberGement:5]HG_Transmis:65; ->[HeberGement:5]HG_TransmisHeur:84)
	End if 
	
End if 