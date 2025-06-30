//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementCritèresFind Plus 
//{
//{          Lundi 26 juillet 2004 à 11:03:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}



C_POINTER:C301($1)  //Table
C_POINTER:C301($2)  //Champ
C_POINTER:C301($3)  //Tableau : libellé
C_POINTER:C301($4)  //Tableau : Cas
C_LONGINT:C283($ii; $ij)
C_BOOLEAN:C305($vbOK)

If (Size of array:C274($3->)>0)
	If (Records in selection:C76($1->)>0)
		$ij:=0
		$vbOK:=False:C215
		For ($ii; 1; Size of array:C274($3->))
			$ij:=$ij+$4->{$ii}
		End for 
		If ($ij>0) & ($ij<Size of array:C274($3->))
			For ($ii; 1; Size of array:C274($3->))
				If ($4->{$ii}=1)
					If ($vbOK)
						QUERY SELECTION:C341($1->;  | ; $2->=($3->{$ii}+"@"); *)
					Else 
						QUERY SELECTION:C341($1->; $2->=($3->{$ii}+"@"); *)
					End if 
					$vbOK:=True:C214
				End if 
			End for 
			QUERY SELECTION:C341($1->)
		End if 
	End if 
End if 