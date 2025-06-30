//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_SIAOCritèresFind  
//{          Vendrdi 11 février 2011 à 11:03:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_BOOLEAN:C305($0)
$0:=False:C215
C_LONGINT:C283($1; $L_Cas)  //cas
$L_Cas:=$1  // pas utilisé !

C_POINTER:C301($2; $P_Tableau_libelles)  //Tableau : libellé
$P_Tableau_libelles:=$2
C_POINTER:C301($3; $P_Tableau_cas)  //Tableau : Cas
$P_Tableau_cas:=$3
C_POINTER:C301($4; $P_Table)  //Table
$P_Table:=$4
C_POINTER:C301($5; $P_Champ)  //Champ
$P_Champ:=$5


If (Size of array:C274($P_Tableau_libelles->)>0)
	
	C_LONGINT:C283($ii; $ij)
	C_BOOLEAN:C305($vbOK)
	
	$ij:=0
	$vbOK:=False:C215
	
	For ($ii; 1; Size of array:C274($P_Tableau_libelles->))
		$ij:=$ij+$P_Tableau_cas->{$ii}
	End for 
	
	If ($ij>0) & ($ij<Size of array:C274($P_Tableau_libelles->))
		
		For ($ii; 1; Size of array:C274($P_Tableau_libelles->))
			If ($P_Tableau_cas->{$ii}=1)
				If ($vbOK)
					QUERY SELECTION:C341($P_Table->;  | ; $P_Champ->=$P_Tableau_libelles->{$ii}; *)
				Else 
					QUERY SELECTION:C341($P_Table->; $P_Champ->=$P_Tableau_libelles->{$ii}; *)
				End if 
				$vbOK:=True:C214
			End if 
		End for 
		QUERY SELECTION:C341($P_Table->)
	Else 
		
		If ($ij=Size of array:C274($P_Tableau_libelles->))  // tout est selectionné
			//ALL RECORDS($P_Table->)
		End if 
	End if 
	
	$0:=(Records in selection:C76($P_Table->)>0)
	
End if 


