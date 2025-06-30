//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexDecoupage
//{
//{          Vendredi 21 novembre 2008 à 13:50
//{          Modifiée : 14 novembre 2008 à 12:46
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_TIME:C306($1)
C_TEXT:C284($vt_Buffer)
C_LONGINT:C283($ii; $vl_Position; $vl_Indice; $vl_IndiceClear)
C_BOOLEAN:C305($vb_OK)


ARRAY INTEGER:C220($te_Conso_Ligne; 0)
ARRAY TEXT:C222($tt_Conso_LeDocument; 0)
ARRAY TEXT:C222($ta_Conso_Titre; 0)
ARRAY TEXT:C222($tt_Conso_Valeur; 0)
ARRAY INTEGER:C220($te_Conso_Table; 0)
ARRAY INTEGER:C220($te_Conso_Champ; 0)
ARRAY INTEGER:C220($te_Conso_ChampType; 0)
ARRAY TEXT:C222($ta_Conso_ChampType; 0)

$0:=True:C214
$vb_OK:=False:C215
$vl_Indice:=1


Repeat 
	RECEIVE PACKET:C104($1; $vt_Buffer; <>va_CR)
	$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")  //Enlève CHR(10)
	If (Length:C16($vt_Buffer)>2)
		If ($vt_Buffer="SSPFINEXPORTSSP")
			$vb_OK:=True:C214
			$0:=True:C214
		Else 
			INSERT IN ARRAY:C227($te_Conso_Ligne; $vl_Indice)
			INSERT IN ARRAY:C227($tt_Conso_LeDocument; $vl_Indice)
			INSERT IN ARRAY:C227($ta_Conso_Titre; $vl_Indice)
			INSERT IN ARRAY:C227($tt_Conso_Valeur; $vl_Indice)
			INSERT IN ARRAY:C227($te_Conso_Table; $vl_Indice)
			INSERT IN ARRAY:C227($te_Conso_Champ; $vl_Indice)
			INSERT IN ARRAY:C227($te_Conso_ChampType; $vl_Indice)
			INSERT IN ARRAY:C227($ta_Conso_ChampType; $vl_Indice)
			
			$tt_Conso_LeDocument{$vl_Indice}:=vt_TitreDocument
			$te_Conso_Ligne{$vl_Indice}:=$vl_Indice
			
			$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
			$ta_Conso_Titre{$vl_Indice}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
			$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
			
			$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
			$tt_Conso_Valeur{$vl_Indice}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
			$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
			
			$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
			$te_Conso_Table{$vl_Indice}:=Num:C11(Substring:C12($vt_Buffer; 1; $vl_Position-1))
			$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
			
			$te_Conso_Champ{$vl_Indice}:=Num:C11($vt_Buffer)
			If ($te_Conso_Champ{$vl_Indice}>0) & ($te_Conso_Champ{$vl_Indice}<512)
				$te_Conso_ChampType{$vl_Indice}:=(Type:C295(Field:C253($te_Conso_Table{$vl_Indice}; $te_Conso_Champ{$vl_Indice})->))
				$ta_Conso_ChampType{$vl_Indice}:=F_TypeLibellé($te_Conso_ChampType{$vl_Indice})
			Else 
				$te_Conso_ChampType{$vl_Indice}:=-1
				$ta_Conso_ChampType{$vl_Indice}:=""
			End if 
			$vl_Indice:=$vl_Indice+1
		End if 
	Else 
		$vb_OK:=True:C214
		$0:=False:C215
	End if 
Until ($vb_OK)
If ($0)
	$vl_Indice:=Size of array:C274($te_Conso_Ligne)
	If ($vl_Indice>0)
		INSERT IN ARRAY:C227(<>te_Conso_Ligne; 1; $vl_Indice)
		INSERT IN ARRAY:C227(<>tt_Conso_LeDocument; 1; $vl_Indice)
		INSERT IN ARRAY:C227(<>ta_Conso_Titre; 1; $vl_Indice)
		INSERT IN ARRAY:C227(<>tt_Conso_Valeur; 1; $vl_Indice)
		INSERT IN ARRAY:C227(<>te_Conso_Table; 1; $vl_Indice)
		INSERT IN ARRAY:C227(<>te_Conso_Champ; 1; $vl_Indice)
		INSERT IN ARRAY:C227(<>te_Conso_ChampType; 1; $vl_Indice)
		INSERT IN ARRAY:C227(<>ta_Conso_ChampType; 1; $vl_Indice)
		For ($ii; 1; $vl_Indice)
			<>te_Conso_Ligne{$ii}:=$te_Conso_Ligne{$ii}
			<>tt_Conso_LeDocument{$ii}:=$tt_Conso_LeDocument{$ii}
			<>ta_Conso_Titre{$ii}:=$ta_Conso_Titre{$ii}
			<>tt_Conso_Valeur{$ii}:=$tt_Conso_Valeur{$ii}
			<>te_Conso_Table{$ii}:=$te_Conso_Table{$ii}
			<>te_Conso_Champ{$ii}:=$te_Conso_Champ{$ii}
			<>te_Conso_ChampType{$ii}:=$te_Conso_ChampType{$ii}
			<>ta_Conso_ChampType{$ii}:=$ta_Conso_ChampType{$ii}
		End for 
	End if 
End if 


If (7=8)  //Old version au 25/10/2010
	Repeat 
		RECEIVE PACKET:C104($1; $vt_Buffer; <>va_CR)
		$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
		If (Length:C16($vt_Buffer)>2)
			If ($vt_Buffer#"SSPFINEXPORTSSP")
				INSERT IN ARRAY:C227(<>te_Conso_Ligne; $vl_Indice)
				INSERT IN ARRAY:C227(<>tt_Conso_LeDocument; $vl_Indice)
				INSERT IN ARRAY:C227(<>ta_Conso_Titre; $vl_Indice)
				INSERT IN ARRAY:C227(<>tt_Conso_Valeur; $vl_Indice)
				INSERT IN ARRAY:C227(<>te_Conso_Table; $vl_Indice)
				INSERT IN ARRAY:C227(<>te_Conso_Champ; $vl_Indice)
				INSERT IN ARRAY:C227(<>te_Conso_ChampType; $vl_Indice)
				INSERT IN ARRAY:C227(<>ta_Conso_ChampType; $vl_Indice)
				
				<>tt_Conso_LeDocument{$vl_Indice}:=vt_TitreDocument
				<>te_Conso_Ligne{$vl_Indice}:=$vl_Indice
				
				$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
				<>ta_Conso_Titre{$vl_Indice}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
				$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
				
				$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
				<>tt_Conso_Valeur{$vl_Indice}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
				$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
				
				$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
				<>te_Conso_Table{$vl_Indice}:=Num:C11(Substring:C12($vt_Buffer; 1; $vl_Position-1))
				$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
				
				<>te_Conso_Champ{$vl_Indice}:=Num:C11($vt_Buffer)
				If (<>te_Conso_Champ{$vl_Indice}>0) & (<>te_Conso_Champ{$vl_Indice}<512)
					<>te_Conso_ChampType{$vl_Indice}:=(Type:C295(Field:C253(<>te_Conso_Table{$vl_Indice}; <>te_Conso_Champ{$vl_Indice})->))
					<>ta_Conso_ChampType{$vl_Indice}:=F_TypeLibellé(<>te_Conso_ChampType{$vl_Indice})
				Else 
					<>te_Conso_ChampType{$vl_Indice}:=-1
					<>ta_Conso_ChampType{$vl_Indice}:=""
				End if 
				
				$vl_Indice:=$vl_Indice+1
			End if 
		Else 
			$vl_IndiceClear:=$vl_Indice-1
			$vt_Buffer:="SSPFINEXPORTSSP"
			$0:=False:C215
		End if 
		
		$vb_OK:=($vt_Buffer="SSPFINEXPORTSSP")
		
	Until ($vb_OK)
	
	If ($0=False:C215)
		If ($vl_IndiceClear>0)
			INSERT IN ARRAY:C227(<>te_Conso_Ligne; 1; $vl_IndiceClear)
			INSERT IN ARRAY:C227(<>tt_Conso_LeDocument; 1; $vl_IndiceClear)
			INSERT IN ARRAY:C227(<>ta_Conso_Titre; 1; $vl_IndiceClear)
			INSERT IN ARRAY:C227(<>tt_Conso_Valeur; 1; $vl_IndiceClear)
			INSERT IN ARRAY:C227(<>te_Conso_Table; 1; $vl_IndiceClear)
			INSERT IN ARRAY:C227(<>te_Conso_Champ; 1; $vl_IndiceClear)
			INSERT IN ARRAY:C227(<>te_Conso_ChampType; 1; $vl_IndiceClear)
			INSERT IN ARRAY:C227(<>ta_Conso_ChampType; 1; $vl_IndiceClear)
			
		End if 
	End if 
End if 