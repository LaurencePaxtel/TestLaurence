//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Trans_FullDuplexDecoupage
//{
//{          Lundi 22 décembre 2008 à 17:50
//{          Modifiée : 14 novembre 2008 à 12:46
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_TIME:C306($1)
C_TEXT:C284($vt_Buffer)
C_LONGINT:C283($vl_Position; $vl_Indice)
C_BOOLEAN:C305($vb_OK)

$vl_Indice:=1
Repeat 
	RECEIVE PACKET:C104($1; $vt_Buffer; <>va_CR)
	$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
	If ($vt_Buffer#"SSPFINEXPORTSSP")
		INSERT IN ARRAY:C227(<>te_ConsoT_Ligne; $vl_Indice)
		INSERT IN ARRAY:C227(<>tt_ConsoT_LeDocument; $vl_Indice)
		INSERT IN ARRAY:C227(<>ta_ConsoT_Titre; $vl_Indice)
		INSERT IN ARRAY:C227(<>tt_ConsoT_Valeur; $vl_Indice)
		INSERT IN ARRAY:C227(<>te_ConsoT_Table; $vl_Indice)
		INSERT IN ARRAY:C227(<>te_ConsoT_Champ; $vl_Indice)
		INSERT IN ARRAY:C227(<>te_ConsoT_ChampType; $vl_Indice)
		INSERT IN ARRAY:C227(<>ta_ConsoT_ChampType; $vl_Indice)
		
		<>tt_ConsoT_LeDocument{$vl_Indice}:=vt_TitreDocument
		<>te_ConsoT_Ligne{$vl_Indice}:=$vl_Indice
		
		$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
		<>ta_ConsoT_Titre{$vl_Indice}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
		$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
		
		$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
		<>tt_ConsoT_Valeur{$vl_Indice}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
		$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
		
		$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
		<>te_ConsoT_Table{$vl_Indice}:=Num:C11(Substring:C12($vt_Buffer; 1; $vl_Position-1))
		$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
		
		<>te_ConsoT_Champ{$vl_Indice}:=Num:C11($vt_Buffer)
		If (<>te_ConsoT_Champ{$vl_Indice}>0) & (<>te_ConsoT_Champ{$vl_Indice}<512)
			<>te_ConsoT_ChampType{$vl_Indice}:=(Type:C295(Field:C253(<>te_ConsoT_Table{$vl_Indice}; <>te_ConsoT_Champ{$vl_Indice})->))
			<>ta_ConsoT_ChampType{$vl_Indice}:=F_TypeLibellé(<>te_ConsoT_ChampType{$vl_Indice})
		Else 
			<>te_ConsoT_ChampType{$vl_Indice}:=-1
			<>ta_ConsoT_ChampType{$vl_Indice}:=""
		End if 
		
		$vl_Indice:=$vl_Indice+1
	End if 
	$vb_OK:=($vt_Buffer="SSPFINEXPORTSSP")
Until ($vb_OK)
