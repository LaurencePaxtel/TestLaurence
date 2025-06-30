//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : Acces_Plateforme
//{          Lundi 23 avril 2012 à 11:30:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_TEXT:C284($vt_Temp)
C_LONGINT:C283($ii; $vl_Position)

Case of 
	: ($1=1)
		
		If ($2>"")
			$vt_Temp:=$2
			
			Repeat 
				$vl_Position:=Position:C15(";"; $vt_Temp)
				
				If ($vl_Position>0)
					$ii:=Size of array:C274(<>ta_UserPlateforme)+1
					INSERT IN ARRAY:C227(<>ta_UserPlateforme; $ii; 1)
					
					<>ta_UserPlateforme{$ii}:=Substring:C12($vt_Temp; 1; $vl_Position-1)
					$vt_Temp:=Substring:C12($vt_Temp; $vl_Position+1)
				End if 
				
			Until (Length:C16($vt_Temp)=0)
			
		End if 
		
	: ($1=2)
		
		If ($2>"")
			$vt_Temp:=$2
			
			Repeat 
				$vl_Position:=Position:C15(";"; $vt_Temp)
				
				If ($vl_Position>0)
					$ii:=Size of array:C274(ta_LesPlatefomes)+1
					INSERT IN ARRAY:C227(ta_LesPlatefomes; $ii; 1)
					
					ta_LesPlatefomes{$ii}:=Substring:C12($vt_Temp; 1; $vl_Position-1)
					$vt_Temp:=Substring:C12($vt_Temp; $vl_Position+1)
				End if 
				
			Until (Length:C16($vt_Temp)=0)
			
		End if 
		
	: ($1=3)
		
		If (Size of array:C274(ta_LesPlatefomes)>0)
			[INtervenants:10]IN_Notes:6:=""
			
			For ($ii; 1; Size of array:C274(ta_LesPlatefomes))
				[INtervenants:10]IN_Notes:6:=[INtervenants:10]IN_Notes:6+ta_LesPlatefomes{$ii}+";"
			End for 
			
		Else 
			[INtervenants:10]IN_Notes:6:=""
		End if 
		
End case 