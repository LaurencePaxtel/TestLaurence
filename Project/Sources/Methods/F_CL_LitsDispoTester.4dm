//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CL_LitsDispTester
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_DATE:C307($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_LONGINT:C283($5)

READ ONLY:C145([CentresLits:16])

QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID_date:1=Uut_NumeroteLits($1; $2))
MultiSoc_Filter(->[CentresLits:16])

If (Records in selection:C76([CentresLits:16])>0)
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_Type:8=$4)
	
	If (Records in selection:C76([CentresLits:16])=1)
		
		If ([CentresLits:16]CL_Restant:7<$3)
			$0:="Le centre : "+[HeberGement:5]HG_CentreNom:62+" n'a plus assez de lits disponibles."
		End if 
		
	Else 
		$0:="La disponibilité pour le centre : "+[HeberGement:5]HG_CentreNom:62+" n'existe pas, veuillez contacter la hotline."
	End if 
	
Else 
	$0:="La disponibilité pour le centre : "+[HeberGement:5]HG_CentreNom:62+" n'existe pas, veuillez contacter la hotline."
End if 