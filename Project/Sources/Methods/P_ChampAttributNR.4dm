//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ChampAttribut
//{
//{          Mardi 22 février 2005 à 16:09
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_LONGINT:C283($ii; $ij)

$ij:=Size of array:C274(<>te_RdsRub{$1})
For ($ii; 1; $ij)
	If (<>tb_RdsObli{$1}{$ii})
		If (Type:C295(Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->)=0)
			If ((Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->)>"")
			Else 
				Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->:="NR"
			End if 
		End if 
	End if 
End for 