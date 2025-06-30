//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HG_StatutTransmis  
//{
//{          Lundi 28 Juillet 1997 à 17:34:51
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
If ([HeberGement:5]HG_PriseCharge:66)
	[HeberGement:5]HG_Transmis:65:=True:C214
Else 
	P_BoolHeureCommute(->[HeberGement:5]HG_Transmis:65; ->[HeberGement:5]HG_TransmisHeur:84)
	
	If ([HeberGement:5]HG_Transmis:65)
		[HeberGement:5]HG_EnAttente:64:=False:C215
	Else 
		
		If ([HeberGement:5]HG_Cloturée:67=False:C215)
			[HeberGement:5]HG_EnAttente:64:=True:C214
		End if 
		
	End if 
	
End if 