//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Uut_HébergéAgePlus
//{
//{          Lundi 28 Juillet 1997 à 16:53:54
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($0)  // Age
C_POINTER:C301($1)  // Date de naissance
C_POINTER:C301($2)  // Date du jour concerné

If (Year of:C25($1->)>0)
	
	If (Month of:C24($2->)>Month of:C24($1->))
		$0:=Year of:C25($2->)-Year of:C25($1->)
	Else 
		
		If (Month of:C24($2->)=Month of:C24($1->))
			
			If (Day of:C23($2->)>=Day of:C23($1->))
				$0:=Year of:C25($2->)-Year of:C25($1->)
			Else 
				$0:=Year of:C25($2->)-Year of:C25($1->)-1
			End if 
			
		Else 
			$0:=Year of:C25($2->)-Year of:C25($1->)-1
		End if 
		
	End if 
	
	If ($0<1)
		$0:=0
	End if 
	
End if 