//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexBufferC
//{
//{          Mardi 14 novembre 2008 à 12:46
//{          Modifiée : 14 novembre 2008 à 12:46
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_TIME:C306($1)
C_TEXT:C284($vt_Buffer)
C_LONGINT:C283($vl_Position; $vl_Indice)
C_BOOLEAN:C305($vb_OK)
<>va_ConsoB_FicheSite:=""

$vl_Indice:=0
Repeat 
	RECEIVE PACKET:C104($1; $vt_Buffer; <>va_CR)
	$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
	If ($vt_Buffer#"SSPFINEXPORTSSP")
		If ($vl_Indice=0)
			//1 ère ligne du document      
			<>vt_ConsoB_Titre:=""
			$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
			$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
			$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
			<>vt_ConsoB_Titre:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
			$vl_Indice:=$vl_Indice+1
		Else 
			
			INSERT IN ARRAY:C227(<>te_ConsoB_Ligne; $vl_Indice)
			INSERT IN ARRAY:C227(<>tt_ConsoB_LeDocument; $vl_Indice)
			INSERT IN ARRAY:C227(<>ta_ConsoB_Titre; $vl_Indice)
			INSERT IN ARRAY:C227(<>tt_ConsoB_Valeur; $vl_Indice)
			INSERT IN ARRAY:C227(<>te_ConsoB_Table; $vl_Indice)
			INSERT IN ARRAY:C227(<>te_ConsoB_Champ; $vl_Indice)
			INSERT IN ARRAY:C227(<>te_ConsoB_ChampType; $vl_Indice)
			INSERT IN ARRAY:C227(<>ta_ConsoB_ChampType; $vl_Indice)
			
			<>tt_ConsoB_LeDocument{$vl_Indice}:=vt_TitreDocument
			
			<>te_ConsoB_Ligne{$vl_Indice}:=$vl_Indice
			
			$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
			<>ta_ConsoB_Titre{$vl_Indice}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
			$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
			
			$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
			<>tt_ConsoB_Valeur{$vl_Indice}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
			$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
			If ($vl_Indice=4)
				<>va_ConsoB_FicheSite:=<>tt_ConsoB_Valeur{$vl_Indice}
			End if 
			
			
			$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
			<>te_ConsoB_Table{$vl_Indice}:=Num:C11(Substring:C12($vt_Buffer; 1; $vl_Position-1))
			$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
			
			<>te_ConsoB_Champ{$vl_Indice}:=Num:C11($vt_Buffer)
			If (<>te_ConsoB_Champ{$vl_Indice}>0) & (<>te_ConsoB_Champ{$vl_Indice}<512)
				<>te_ConsoB_ChampType{$vl_Indice}:=(Type:C295(Field:C253(<>te_ConsoB_Table{$vl_Indice}; <>te_ConsoB_Champ{$vl_Indice})->))
				<>ta_ConsoB_ChampType{$vl_Indice}:=F_TypeLibellé(<>te_ConsoB_ChampType{$vl_Indice})
			Else 
				<>te_ConsoB_ChampType{$vl_Indice}:=-1
				<>ta_ConsoB_ChampType{$vl_Indice}:=""
			End if 
			$vl_Indice:=$vl_Indice+1
		End if 
	End if 
	
	$vb_OK:=($vt_Buffer="SSPFINEXPORTSSP")
Until ($vb_OK)
