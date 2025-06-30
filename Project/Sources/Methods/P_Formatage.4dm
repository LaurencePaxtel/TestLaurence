//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Formatage
//{
//{                          Jeudi 21 avril 2011 à 14:30:00
//{          Modifiée : Mardi 13 mars 2012
//{          Développement : GABBAY Jean-Guy
//{==================================================} 
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

Case of 
	: ($1="FamDistribution")
		If ($2)
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri1M:118; "### ### ##0")
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri2M:119; "### ### ##0")
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri3M:120; "### ### ##0")
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri4M:121; "### ### ##0")
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri5M:122; "### ### ##0")
			
		Else 
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri1M:118; "### ### ##0.00")  // #20180531-1
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri2M:119; "### ### ##0.00")
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri3M:120; "### ### ##0.00")
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri4M:121; "### ### ##0.00")
			OBJECT SET FORMAT:C236([HeberGement:5]HG_FamDistri5M:122; "### ### ##0.00")
			
		End if 
End case 