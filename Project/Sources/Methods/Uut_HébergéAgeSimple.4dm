//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Uut_HébergéAgeSimple  
//{          Mardi 29 mars 2011 à 12:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_DATE:C307($2)  //Date
C_LONGINT:C283($0)  //Age
C_DATE:C307($vd_Date)
$vd_Date:=$2


$0:=0
If (Year of:C25($1->)>0)
	If (Month of:C24($vd_Date)>Month of:C24($1->))
		$0:=Year of:C25($vd_Date)-Year of:C25($1->)
	Else 
		If (Month of:C24($vd_Date)=Month of:C24($1->))
			If (Day of:C23($vd_Date)>=Day of:C23($1->))
				$0:=Year of:C25($vd_Date)-Year of:C25($1->)
			Else 
				$0:=Year of:C25($vd_Date)-Year of:C25($1->)-1
			End if 
		Else 
			$0:=Year of:C25($vd_Date)-Year of:C25($1->)-1
		End if 
	End if 
	If ($0<1)
		$0:=0
	End if 
End if 

