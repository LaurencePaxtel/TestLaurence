//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ClacDirTab2
//{
//{          Vendrdi 25 Juin 2004 à 13:41:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //Colonne du tableau ou le centre concerné

C_LONGINT:C283($ii; $vl_IndTps)

For ($ii; 1; Size of array:C274(<>tl_PopCT_IDHB{$1}))
	<>tl_PopCT_NbTout{$1}{$ii}:=<>tl_PopCT_NbJ{$1}{$ii}+<>tl_PopCT_NbN{$1}{$ii}
	<>tl_PopCT_NbToutc{$1}{$ii}:=<>tl_PopCT_NbJc{$1}{$ii}+<>tl_PopCT_NbNc{$1}{$ii}
End for 

SORT ARRAY:C229(<>tl_PopCT_NbToutc{$1}; <>tl_PopCT_IDHB{$1}; <>tl_PopCT_NbJ{$1}; <>tl_PopCT_NbN{$1}; <>tl_PopCT_NbJc{$1}; <>tl_PopCT_NbNc{$1}; <>tl_PopCT_NbTout{$1}; >)

For ($ii; 1; Size of array:C274(<>tl_PopCT_IDHB{$1}))
	
	If (<>tl_PopCT_NbToutc{$1}{$ii}>0)
		<>tl_PopCT_OrNb:=Find in array:C230(<>tl_PopCT_OrNb{$1}; <>tl_PopCT_NbToutc{$1}{$ii})
		
		If (<>tl_PopCT_OrNb>0)
			<>tl_PopCT_OrT{$1}{<>tl_PopCT_OrNb}:=<>tl_PopCT_OrT{$1}{<>tl_PopCT_OrNb}+1
		Else 
			$vl_IndTps:=Size of array:C274(<>tl_PopCT_OrNb{$1})+1
			
			INSERT IN ARRAY:C227(<>tl_PopCT_OrNb{$1}; $vl_IndTps; 1)
			INSERT IN ARRAY:C227(<>tl_PopCT_OrJ{$1}; $vl_IndTps; 1)
			INSERT IN ARRAY:C227(<>tl_PopCT_OrN{$1}; $vl_IndTps; 1)
			INSERT IN ARRAY:C227(<>tl_PopCT_OrT{$1}; $vl_IndTps; 1)
			
			<>tl_PopCT_OrNb{$1}{$vl_IndTps}:=<>tl_PopCT_NbToutc{$1}{$ii}
			<>tl_PopCT_OrT{$1}{$vl_IndTps}:=<>tl_PopCT_OrT{$1}{$vl_IndTps}+1
		End if 
		
	End if 
	
End for 