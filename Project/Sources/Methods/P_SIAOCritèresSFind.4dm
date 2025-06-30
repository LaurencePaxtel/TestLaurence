//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAOCritèresFind  
//{          Lundi 28 février 2011 à 17:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_BOOLEAN:C305($0)
$0:=False:C215

C_LONGINT:C283($1)  //cas
C_POINTER:C301($2)  //Tableau : libellé
C_POINTER:C301($3)  //Tableau : Cas
C_POINTER:C301($4)  //Table
C_POINTER:C301($5)  //Champ

C_TEXT:C284($6)  //$va_Theme
C_TEXT:C284($7)  //$va_SousTheme
C_LONGINT:C283($8)  // rang

C_LONGINT:C283($i; $j)
C_BOOLEAN:C305($vbOK)

If (Size of array:C274($2->)>0)
	$j:=0
	$vbOK:=False:C215
	For ($i; 1; Size of array:C274($2->))
		$j:=$j+$3->{$i}
	End for 
	If ($j>0) & ($j<Size of array:C274($2->))
		
		For ($i; 1; Size of array:C274($2->))
			
			If ($3->{$i}=1)
				
				QUERY SELECTION:C341([SIAO_Situations:52]; [SIAO_Situations:52]Ss_Theme:5=$6; *)
				QUERY SELECTION:C341([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$7; *)
				QUERY SELECTION:C341([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Rang:7=$8; *)
				
				If ($vbOK)
					QUERY SELECTION:C341($4->;  | ; $5->=$2->{$i}; *)
				Else 
					QUERY SELECTION:C341($4->;  & ; $5->=$2->{$i}; *)
				End if 
				$vbOK:=True:C214
			End if 
		End for 
		
		
		QUERY SELECTION:C341($4->)
		$0:=(Records in selection:C76($4->)>0)
	Else 
		
		//If ($j=Size of array($2->))  // tout est selectionné
		//ALL RECORDS($4->)
		//$0:=(Records in selection($4->)>0)
		//End if 
		
	End if 
	
End if 