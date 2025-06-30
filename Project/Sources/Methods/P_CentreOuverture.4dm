//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : P_CentreOuverture  
//{
//{          Mardi 27 octobre 2009 à 17:27
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)

C_DATE:C307($vd_Date)
C_TEXT:C284($va_LeJourMois; $va_LOuverture; $va_LaFermeture; $va_LaBorneSup; $va_LaBorneinf)
$va_LeJourMois:=""
$va_LOuverture:=""
$va_LaFermeture:=""
$va_LaBorneSup:="1231"
$va_LaBorneinf:="0101"


Case of 
	: ($1=1)
		$2->:=String:C10($4->; "00")+String:C10($3->; "00")
		
	: ($1=2)
		If ($2->>"") & (Length:C16($2->)=4)
		Else 
			$2->:="0000"
		End if 
		$3->:=Num:C11(Substring:C12($2->; 3; 2))
		$4->:=Num:C11(Substring:C12($2->; 1; 2))
		
	: ($1=3)
		If ($4->=0)
			$5->:=14
		Else 
			$5->:=$4->
		End if 
		
	: ($1=4)
		If ($5->>12)
			$4->:=0
		Else 
			$4->:=$5->
		End if 
		$2->:=String:C10($4->; "00")+String:C10($3->; "00")
		P_CentreOuverture(6; $2; $3; $4; $5)
		
		
	: ($1=5)
		$2->:=String:C10($4->; "00")+String:C10($3->; "00")
		P_CentreOuverture(6; $2; $3; $4; $5)
		
	: ($1=6)
		
		Case of 
			: ((ve_JourOuverture=0) & (ve_MoisOuverture=0) & (ve_JourFermeture=0) & (ve_MoisFermeture=0))  //Rien donc ouvert
				[LesCentres:9]LC_Fermé:53:=False:C215
				
			: ((ve_JourOuverture>0) & (ve_MoisOuverture>0) & (ve_JourFermeture>0) & (ve_MoisFermeture>0))  //Ouvert ou fermé par période
				$vd_Date:=Current date:C33
				$va_LeJourMois:=String:C10(Month of:C24($vd_Date); "00")+String:C10(Day of:C23($vd_Date); "00")
				$va_LOuverture:=[LesCentres:9]LC_JourMoisOuverture:58
				$va_LaFermeture:=[LesCentres:9]LC_JourMoisFermeture:59
				
				If ($va_LOuverture<$va_LaFermeture)
					[LesCentres:9]LC_Fermé:53:=Not:C34(($va_LeJourMois>=$va_LOuverture) & ($va_LeJourMois<=$va_LaFermeture))
				Else 
					[LesCentres:9]LC_Fermé:53:=Not:C34((($va_LeJourMois>=$va_LOuverture) & ($va_LeJourMois<=$va_LaBorneSup)) | (($va_LeJourMois>=$va_LaBorneinf) & ($va_LeJourMois<=$va_LaFermeture)))
				End if 
				
				
			: ((ve_JourOuverture>0) & (ve_MoisOuverture>0))  //Donc tout le temps ouvert
				[LesCentres:9]LC_Fermé:53:=False:C215
				
			: ((ve_JourFermeture>0) & (ve_MoisFermeture>0))  //Donc tout le temps fermé
				[LesCentres:9]LC_Fermé:53:=True:C214
		End case 
		
		
End case 