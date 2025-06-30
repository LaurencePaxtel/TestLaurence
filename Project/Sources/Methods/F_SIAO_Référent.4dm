//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Référent
//{
//{          Lundi 6 décembre 2010 à 12:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($2)
Case of 
	: ($1=1)  //Acuueil
		$0:=($2>0)
		If ($0=False:C215)
			ALERT:C41("L'accueil n'est pas enregistré !")
		End if 
		
	: ($1=2)  //Référent
		$0:=($2>0)
		If ($0=False:C215)
			ALERT:C41("Le référent n'est pas enregistré !")
		End if 
End case 