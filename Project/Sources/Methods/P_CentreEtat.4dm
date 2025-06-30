//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : P_CentreEtat
//{
//{          Mardi 27 octobre 2009 à 19:27
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($va_LeJourMois; $va_LOuverture; $va_LaFermeture; $va_LaBorneSup; $va_LaBorneinf)
C_LONGINT:C283($ve_JourOuverture; $ve_MoisOuverture; $ve_JourFermeture; $ve_MoisFermeture)
C_DATE:C307($vd_Date)

$va_LaBorneSup:="1231"
$va_LaBorneinf:="0101"

If ([LesCentres:9]LC_JourMoisOuverture:58>"") & (Length:C16([LesCentres:9]LC_JourMoisOuverture:58)=4)
	$ve_JourOuverture:=Num:C11(Substring:C12([LesCentres:9]LC_JourMoisOuverture:58; 3; 2))
	$ve_MoisOuverture:=Num:C11(Substring:C12([LesCentres:9]LC_JourMoisOuverture:58; 1; 2))
Else 
	[LesCentres:9]LC_JourMoisOuverture:58:="0000"
End if 

If ([LesCentres:9]LC_JourMoisFermeture:59>"") & (Length:C16([LesCentres:9]LC_JourMoisFermeture:59)=4)
	$ve_JourFermeture:=Num:C11(Substring:C12([LesCentres:9]LC_JourMoisFermeture:59; 3; 2))
	$ve_MoisFermeture:=Num:C11(Substring:C12([LesCentres:9]LC_JourMoisFermeture:59; 1; 2))
Else 
	[LesCentres:9]LC_JourMoisFermeture:59:="0000"
End if 

Case of 
	: (($ve_JourOuverture=0) & ($ve_MoisOuverture=0) & ($ve_JourFermeture=0) & ($ve_MoisFermeture=0))  //Rien donc ouvert
		[LesCentres:9]LC_Fermé:53:=False:C215
	: (($ve_JourOuverture>0) & ($ve_MoisOuverture>0) & ($ve_JourFermeture>0) & ($ve_MoisFermeture>0))  //Ouvert ou fermé par période
		$vd_Date:=vd_DateRéelle
		
		$va_LeJourMois:=String:C10(Month of:C24($vd_Date); "00")+String:C10(Day of:C23($vd_Date); "00")
		$va_LOuverture:=[LesCentres:9]LC_JourMoisOuverture:58
		$va_LaFermeture:=[LesCentres:9]LC_JourMoisFermeture:59
		
		If ($va_LOuverture<$va_LaFermeture)
			[LesCentres:9]LC_Fermé:53:=Not:C34(($va_LeJourMois>=$va_LOuverture) & ($va_LeJourMois<=$va_LaFermeture))
		Else 
			[LesCentres:9]LC_Fermé:53:=Not:C34((($va_LeJourMois>=$va_LOuverture) & ($va_LeJourMois<=$va_LaBorneSup)) | (($va_LeJourMois>=$va_LaBorneinf) & ($va_LeJourMois<=$va_LaFermeture)))
		End if 
		
	: (($ve_JourOuverture>0) & ($ve_MoisOuverture>0))  //Donc tout le temps ouvert
		[LesCentres:9]LC_Fermé:53:=False:C215
	: (($ve_JourFermeture>0) & ($ve_MoisFermeture>0))  //Donc tout le temps fermé
		[LesCentres:9]LC_Fermé:53:=True:C214
	Else 
		TRACE:C157  // #20170626-2
End case 