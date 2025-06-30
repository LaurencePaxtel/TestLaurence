//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexBuffer
//{
//{          Mardi 14 novembre 2008 à 12:46
//{          Modifiée : 14 novembre 2008 à 12:46
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($vt_Buffer)
C_TEXT:C284($vt_Ligne)
C_LONGINT:C283($ii; $jj; $vl_Position; $vl_Indice)
C_BOOLEAN:C305($vb_OK)

$vt_Buffer:=$2
$vb_OK:=(Length:C16($vt_Buffer)>1)
If ($vb_OK)
	
	$vl_Indice:=Size of array:C274(<>ta_Conso_Titre)+1
	//Les 34 premières lignes
	$ii:=34
	INSERT IN ARRAY:C227(<>tt_Conso_LeDocument; $vl_Indice; $ii)
	INSERT IN ARRAY:C227(<>ta_Conso_Titre; $vl_Indice; $ii)
	INSERT IN ARRAY:C227(<>tt_Conso_Valeur; $vl_Indice; $ii)
	INSERT IN ARRAY:C227(<>te_Conso_Table; $vl_Indice; $ii)
	INSERT IN ARRAY:C227(<>te_Conso_Champ; $vl_Indice; $ii)
	INSERT IN ARRAY:C227(<>te_Conso_ChampType; $vl_Indice; $ii)
End if 

If ($vb_OK)
	$vb_OK:=False:C215
	$ii:=0
	$jj:=0
	//Les données strictes de la fiche
	Repeat 
		$ii:=$ii+1
		If ($vt_Buffer[[$ii]]=<>va_CR)
			$jj:=$jj+1
			If ($jj<=34)
			Else 
				//Inserer de nouvelles lignes de tableau et positionner l'indice        
				INSERT IN ARRAY:C227(<>tt_Conso_LeDocument; $vl_Indice; 1)
				INSERT IN ARRAY:C227(<>ta_Conso_Titre; $vl_Indice; 1)
				INSERT IN ARRAY:C227(<>tt_Conso_Valeur; $vl_Indice; 1)
				INSERT IN ARRAY:C227(<>te_Conso_Table; $vl_Indice; 1)
				INSERT IN ARRAY:C227(<>te_Conso_Champ; $vl_Indice; 1)
				INSERT IN ARRAY:C227(<>te_Conso_ChampType; $vl_Indice; 1)
			End if 
			
			<>tt_Conso_LeDocument{$vl_Indice}:=$1
			$vt_Ligne:=Substring:C12($vt_Buffer; 1; $ii-1)
			$vt_Buffer:=Substring:C12($vt_Buffer; $ii-1)
			
			$vl_Position:=Position:C15(<>va_Tab; $vt_Ligne)
			<>ta_Conso_Titre{$vl_Indice}:=Substring:C12($vt_Ligne; 1; $vl_Position-1)
			$vt_Ligne:=Substring:C12($vt_Ligne; $vl_Position+1)
			
			$vl_Position:=Position:C15(<>va_Tab; $vt_Ligne)
			<>tt_Conso_Valeur{$vl_Indice}:=Substring:C12($vt_Ligne; 1; $vl_Position-1)
			$vt_Ligne:=Substring:C12($vt_Ligne; $vl_Position+1)
			
			$vl_Position:=Position:C15(<>va_Tab; $vt_Ligne)
			<>te_Conso_Table{$vl_Indice}:=Num:C11(Substring:C12($vt_Ligne; 1; $vl_Position-1))
			$vt_Ligne:=Substring:C12($vt_Ligne; $vl_Position+1)
			
			$vl_Position:=Position:C15(<>va_CR; $vt_Ligne)
			<>te_Conso_Champ{$vl_Indice}:=Num:C11(Substring:C12($vt_Ligne; 1; $vl_Position-1))
			
			If (<>te_Conso_Champ{$vl_Indice}>0)
				GET FIELD PROPERTIES:C258(<>te_Conso_Table{$vl_Indice}; <>te_Conso_Champ{$vl_Indice}; <>te_Conso_ChampType{$vl_Indice})
				
				If (<>te_Conso_Table{$vl_Indice}=Table:C252(->[HeBerge:4])) & (<>te_Conso_Champ{$vl_Indice}=Field:C253(->[HeBerge:4]HB_NotesTrans:53))
					<>tt_Conso_Valeur{$vl_Indice}:=Replace string:C233(<>tt_Conso_Valeur{$vl_Indice}; "≤"; <>va_CR)
				End if 
			Else 
				<>te_Conso_ChampType{$vl_Indice}:=-1
			End if 
			$vl_Indice:=$vl_Indice+1
		End if 
		
		$vb_OK:=((Length:C16($vt_Buffer)<=1) | ($vt_Buffer=(<>va_FINEXPORT+<>va_CR)))
	Until ($vb_OK)
End if 