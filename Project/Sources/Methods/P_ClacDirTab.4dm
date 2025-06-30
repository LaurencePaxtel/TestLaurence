//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ClacDirTab
//{
//{          Lundi 21 Juin 2004 à 14:29:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //Colonne du tableau ou le centre concerné

C_DATE:C307($DtOld)
C_LONGINT:C283($ii; $vl_IndTps; $vl_IndDr; $IDHBOld)

SORT ARRAY:C229(<>ts_Date; <>ts_Nuit; <>ts_IDHB; <>ts_IDLC; <>ts_Cloturé; >)

$vl_IndTps:=Size of array:C274(<>tl_PopCT_IDHB{$1})
$vl_IndDr:=Size of array:C274(<>td_PopCT_DrDt{$1})

For ($ii; 1; Size of array:C274(<>ts_Date))
	<>tl_PopCT_IDHB:=Find in array:C230(<>tl_PopCT_IDHB{$1}; <>ts_IDHB{$ii})
	
	If (<>tl_PopCT_IDHB>0)
		$vl_IndTps:=<>tl_PopCT_IDHB
	Else 
		$vl_IndTps:=Size of array:C274(<>tl_PopCT_IDHB{$1})+1
		
		INSERT IN ARRAY:C227(<>tl_PopCT_IDHB{$1}; $vl_IndTps)
		INSERT IN ARRAY:C227(<>tl_PopCT_NbJ{$1}; $vl_IndTps)
		INSERT IN ARRAY:C227(<>tl_PopCT_NbN{$1}; $vl_IndTps)
		INSERT IN ARRAY:C227(<>tl_PopCT_NbJc{$1}; $vl_IndTps)
		INSERT IN ARRAY:C227(<>tl_PopCT_NbNc{$1}; $vl_IndTps)
		INSERT IN ARRAY:C227(<>tl_PopCT_NbTout{$1}; $vl_IndTps)
		INSERT IN ARRAY:C227(<>tl_PopCT_NbToutc{$1}; $vl_IndTps)
		
		<>tl_PopCT_IDHB{$1}{$vl_IndTps}:=<>ts_IDHB{$ii}
	End if 
	
	If (<>ts_Cloturé{$ii})
		
		If (<>ts_Nuit{$ii}=True:C214)
			<>tl_PopCT_NbNc{$1}{$vl_IndTps}:=<>tl_PopCT_NbNc{$1}{$vl_IndTps}+1
		Else 
			<>tl_PopCT_NbJc{$1}{$vl_IndTps}:=<>tl_PopCT_NbJc{$1}{$vl_IndTps}+1
		End if 
		
	Else 
		
		If (<>ts_Nuit{$ii}=True:C214)
			<>tl_PopCT_NbN{$1}{$vl_IndTps}:=<>tl_PopCT_NbN{$1}{$vl_IndTps}+1
		Else 
			<>tl_PopCT_NbJ{$1}{$vl_IndTps}:=<>tl_PopCT_NbJ{$1}{$vl_IndTps}+1
		End if 
		
	End if 
	
	//Tableau des Jours
	If ($DtOld#<>ts_Date{$ii})
		$DtOld:=<>ts_Date{$ii}
		$vl_IndDr:=Size of array:C274(<>td_PopCT_DrDt{$1})+1
		
		INSERT IN ARRAY:C227(<>td_PopCT_DrDt{$1}; $vl_IndDr)
		INSERT IN ARRAY:C227(<>tl_PopCT_DrAjJ{$1}; $vl_IndDr)
		INSERT IN ARRAY:C227(<>tl_PopCT_DrAjN{$1}; $vl_IndDr)
		INSERT IN ARRAY:C227(<>tl_PopCT_DrAjT{$1}; $vl_IndDr)
		INSERT IN ARRAY:C227(<>tl_PopCT_DrOjJ{$1}; $vl_IndDr)
		INSERT IN ARRAY:C227(<>tl_PopCT_DrOjN{$1}; $vl_IndDr)
		INSERT IN ARRAY:C227(<>tl_PopCT_DrOjT{$1}; $vl_IndDr)
		<>td_PopCT_DrDt{$1}{$vl_IndDr}:=$DtOld
	End if 
	
	If (<>ts_Cloturé{$ii})
		
		If (<>ts_Nuit{$ii}=True:C214)
			<>tl_PopCT_DrOjN{$1}{$vl_IndDr}:=<>tl_PopCT_DrOjN{$1}{$vl_IndDr}+1
		Else 
			<>tl_PopCT_DrOjJ{$1}{$vl_IndDr}:=<>tl_PopCT_DrOjJ{$1}{$vl_IndDr}+1
		End if 
		
	End if 
	
	<>tl_PopCT_DrOjT{$1}{$vl_IndDr}:=0
	
	If (<>ts_Nuit{$ii}=True:C214)
		<>tl_PopCT_DrAjN{$1}{$vl_IndDr}:=<>tl_PopCT_DrAjN{$1}{$vl_IndDr}+1
	Else 
		<>tl_PopCT_DrAjJ{$1}{$vl_IndDr}:=<>tl_PopCT_DrAjJ{$1}{$vl_IndDr}+1
	End if 
	
	<>tl_PopCT_DrAjT{$1}{$vl_IndDr}:=0
End for 

$vl_IndDr:=Size of array:C274(<>td_PopCT_DrDt{$1})

If ($vl_IndDr>0)
	$IDHBOld:=0
	
	//Tableau des Totaux des jours et des Mois
	For ($ii; 1; Size of array:C274(<>td_PopCT_DrDt{$1}))
		<>tl_PopCT_DrOjT{$1}{$ii}:=<>tl_PopCT_DrOjT{$1}{$ii}+<>tl_PopCT_DrOjJ{$1}{$ii}+<>tl_PopCT_DrOjN{$1}{$ii}
		
		If ($IDHBOld#Month of:C24(<>td_PopCT_DrDt{$1}{$ii}))
			$IDHBOld:=Month of:C24(<>td_PopCT_DrDt{$1}{$ii})
			$vl_IndDr:=Size of array:C274(<>td_PopCT_DrMs{$1})+1
			
			INSERT IN ARRAY:C227(<>td_PopCT_DrMs{$1}; $vl_IndDr)
			INSERT IN ARRAY:C227(<>tl_PopCT_DrAmJ{$1}; $vl_IndDr)
			INSERT IN ARRAY:C227(<>tl_PopCT_DrAmN{$1}; $vl_IndDr)
			INSERT IN ARRAY:C227(<>tl_PopCT_DrAmT{$1}; $vl_IndDr)
			INSERT IN ARRAY:C227(<>tl_PopCT_DrOmJ{$1}; $vl_IndDr)
			
			// Modifié par : Scanu Rémy (21/08/2023)
			// Correction bug colonne Prestations à 0 sauf pour la ligne du dernier mois affiché
			INSERT IN ARRAY:C227(<>tl_PopCT_DrOmN{$1}; $vl_IndDr)
			INSERT IN ARRAY:C227(<>tl_PopCT_DrOmT{$1}; $vl_IndDr)
			
			<>td_PopCT_DrMs{$1}{$vl_IndDr}:=Date:C102("01/"+String:C10(Month of:C24(<>td_PopCT_DrDt{$1}{$ii}))+"/"+String:C10(Year of:C25(<>td_PopCT_DrDt{$1}{$ii})))
		End if 
		
		<>tl_PopCT_DrAmJ{$1}{$vl_IndDr}:=<>tl_PopCT_DrAmJ{$1}{$vl_IndDr}+<>tl_PopCT_DrAjJ{$1}{$ii}
		<>tl_PopCT_DrAmN{$1}{$vl_IndDr}:=<>tl_PopCT_DrAmN{$1}{$vl_IndDr}+<>tl_PopCT_DrAjN{$1}{$ii}
		<>tl_PopCT_DrAmT{$1}{$vl_IndDr}:=<>tl_PopCT_DrAmT{$1}{$vl_IndDr}+<>tl_PopCT_DrAjT{$1}{$ii}
		<>tl_PopCT_DrOmJ{$1}{$vl_IndDr}:=<>tl_PopCT_DrOmJ{$1}{$vl_IndDr}+<>tl_PopCT_DrOjJ{$1}{$ii}
		<>tl_PopCT_DrOmN{$1}{$vl_IndDr}:=<>tl_PopCT_DrOmN{$1}{$vl_IndDr}+<>tl_PopCT_DrOjN{$1}{$ii}
		<>tl_PopCT_DrOmT{$1}{$vl_IndDr}:=<>tl_PopCT_DrOmT{$1}{$vl_IndDr}+<>tl_PopCT_DrOjJ{$1}{$ii}+<>tl_PopCT_DrOjN{$1}{$ii}
	End for 
	
End if 