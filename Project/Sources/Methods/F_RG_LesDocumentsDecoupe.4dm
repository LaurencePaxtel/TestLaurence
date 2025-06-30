//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_RG_LesDocumentsDecoupe
//{          Lundi 15 novembre 2010 à 15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TIME:C306($1)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($vt_Buffer)
C_LONGINT:C283($vl_Position; $vl_Ligne_TP; $vl_Ligne_P; $vl_Ligne_TH; $vl_Ligne_H)

$vl_Ligne_TP:=0  //14
$vl_Ligne_TH:=0  //134


//(•Ligne de titre dans le document
RECEIVE PACKET:C104($1; $vt_Buffer; <>va_CR)
$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
$vb_OK:=(Substring:C12($vt_Buffer; 1; $vl_Position-1)="INFOS REGIONALES")
If ($vb_OK)
	//(•Lignes de la clé
	RECEIVE PACKET:C104($1; $vt_Buffer; <>va_CR)
	$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
	$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
	$vb_OK:=(Substring:C12($vt_Buffer; 1; $vl_Position-1)="PERSONNE REGIONAL")
	If ($vb_OK)
		Repeat 
			RECEIVE PACKET:C104($1; $vt_Buffer; <>va_CR)
			$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
			$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
			$vb_OK:=(Substring:C12($vt_Buffer; 1; $vl_Position-1)="HEBERGEMENT REGIONAL")
			If ($vb_OK=False:C215)
				$vl_Ligne_TP:=$vl_Ligne_TP+1
				$vl_Ligne_P:=Size of array:C274(ta_Conso_P_Titre)+1
				INSERT IN ARRAY:C227(ta_Conso_P_Titre; $vl_Ligne_P)
				INSERT IN ARRAY:C227(ta_Conso_P_Valeur; $vl_Ligne_P)
				INSERT IN ARRAY:C227(te_Conso_P_Table; $vl_Ligne_P)
				INSERT IN ARRAY:C227(te_Conso_P_Champ; $vl_Ligne_P)
				INSERT IN ARRAY:C227(te_Conso_P_ChampType; $vl_Ligne_P)
				
				ta_Conso_P_Titre{$vl_Ligne_P}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
				$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
				
				$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
				ta_Conso_P_Valeur{$vl_Ligne_P}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
				$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
				
				$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
				te_Conso_P_Table{$vl_Ligne_P}:=Num:C11(Substring:C12($vt_Buffer; 1; $vl_Position-1))
				$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
				
				te_Conso_P_Champ{$vl_Ligne_P}:=Num:C11($vt_Buffer)
				te_Conso_P_ChampType{$vl_Ligne_P}:=(Type:C295(Field:C253(te_Conso_P_Table{$vl_Ligne_P}; te_Conso_P_Champ{$vl_Ligne_P})->))
				
			End if 
		Until ($vb_OK) | ($vl_Ligne_TP>14)
		
		
		If ($vb_OK)  //("HEBERGEMENT REGIONAL")
			//(•Lignes de l'hébergement      
			Repeat 
				RECEIVE PACKET:C104($1; $vt_Buffer; <>va_CR)
				$vt_Buffer:=Replace string:C233($vt_Buffer; <>va_LF; "")
				$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
				$vb_OK:=(Substring:C12($vt_Buffer; 1; $vl_Position-1)="SSPFINREGIONALSSP")
				If ($vb_OK=False:C215)
					$vl_Ligne_TH:=$vl_Ligne_TH+1
					$vl_Ligne_H:=Size of array:C274(ta_Conso_H_Titre)+1
					INSERT IN ARRAY:C227(ta_Conso_H_Titre; $vl_Ligne_H)
					INSERT IN ARRAY:C227(ta_Conso_H_Valeur; $vl_Ligne_H)
					INSERT IN ARRAY:C227(te_Conso_H_Table; $vl_Ligne_H)
					INSERT IN ARRAY:C227(te_Conso_H_Champ; $vl_Ligne_H)
					INSERT IN ARRAY:C227(te_Conso_H_ChampType; $vl_Ligne_H)
					
					ta_Conso_H_Titre{$vl_Ligne_H}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
					$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
					
					$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
					ta_Conso_H_Valeur{$vl_Ligne_H}:=Substring:C12($vt_Buffer; 1; $vl_Position-1)
					$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
					
					$vl_Position:=Position:C15(<>va_Tab; $vt_Buffer)
					te_Conso_H_Table{$vl_Ligne_H}:=Num:C11(Substring:C12($vt_Buffer; 1; $vl_Position-1))
					$vt_Buffer:=Substring:C12($vt_Buffer; $vl_Position+1)
					
					te_Conso_H_Champ{$vl_Ligne_H}:=Num:C11($vt_Buffer)
					te_Conso_H_ChampType{$vl_Ligne_H}:=(Type:C295(Field:C253(te_Conso_H_Table{$vl_Ligne_H}; te_Conso_H_Champ{$vl_Ligne_H})->))
					
				End if 
			Until ($vb_OK) | ($vl_Ligne_TH>134)
		End if 
	End if 
End if 

$0:=($vl_Ligne_TP=14) & ($vl_Ligne_TH=134)