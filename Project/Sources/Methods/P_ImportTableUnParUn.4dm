//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : P_ImportTableUnParUn  
//{
//{          Mardi 7 juillet 2009 à 16:26:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?
C_TEXT:C284($vt_Cartouche)
C_LONGINT:C283($ii; $vl_Nombre; $vl_Position; $vl_Référence)
C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215

C_TEXT:C284($va_TableLibellé)
C_LONGINT:C283($vl_TableRéf)
C_LONGINT:C283($vl_TableNbNiveau; $vl_TableOrdre)

ARRAY TEXT:C222($ta_EnumLibellé; 0)
ARRAY INTEGER:C220($te_EnumNbNiveau; 0)
ARRAY INTEGER:C220($te_EnumOrdre; 0)
ARRAY TEXT:C222($ta_EnumCode; 0)



$h_RefDoc:=Open document:C264("")
If (OK=1)
	
	USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
	
	RECEIVE PACKET:C104($h_RefDoc; $vt_Cartouche; <>va_CR)
	$vt_Cartouche:=Replace string:C233($vt_Cartouche; <>va_LF; "")
	If (Substring:C12($vt_Cartouche; 1; 13)="SSPEnumExport")
		i_Message("Vérification en cours…")
		RECEIVE PACKET:C104($h_RefDoc; $vt_Cartouche; <>va_CR)
		$vt_Cartouche:=Replace string:C233($vt_Cartouche; <>va_LF; "")
		
		$vl_Position:=Position:C15(<>va_Tab; $vt_Cartouche)
		$va_TableLibellé:=Substring:C12($vt_Cartouche; 1; $vl_Position-1)
		$vt_Cartouche:=Substring:C12($vt_Cartouche; $vl_Position+1)
		
		$vl_Position:=Position:C15(<>va_Tab; $vt_Cartouche)
		$vl_TableRéf:=Num:C11(Substring:C12($vt_Cartouche; 1; $vl_Position-1))
		$vt_Cartouche:=Substring:C12($vt_Cartouche; $vl_Position+1)
		
		$vl_Position:=Position:C15(<>va_Tab; $vt_Cartouche)
		$vl_TableNbNiveau:=Num:C11(Substring:C12($vt_Cartouche; 1; $vl_Position-1))
		$vt_Cartouche:=Substring:C12($vt_Cartouche; $vl_Position+1)
		
		$vl_TableOrdre:=Num:C11($vt_Cartouche)
		
		RECEIVE PACKET:C104($h_RefDoc; $vt_Cartouche; <>va_CR)
		$vt_Cartouche:=Replace string:C233($vt_Cartouche; <>va_LF; "")
		$vl_Nombre:=Num:C11($vt_Cartouche)
		If ($vl_Nombre>0)
			ARRAY TEXT:C222($ta_EnumLibellé; $vl_Nombre)
			ARRAY INTEGER:C220($te_EnumNbNiveau; $vl_Nombre)
			ARRAY INTEGER:C220($te_EnumOrdre; $vl_Nombre)
			ARRAY TEXT:C222($ta_EnumCode; $vl_Nombre)
			
			
			For ($ii; 1; $vl_Nombre)
				RECEIVE PACKET:C104($h_RefDoc; $vt_Cartouche; <>va_CR)
				$vt_Cartouche:=Replace string:C233($vt_Cartouche; <>va_LF; "")
				$vl_Position:=Position:C15(<>va_Tab; $vt_Cartouche)
				$ta_EnumLibellé{$ii}:=Substring:C12($vt_Cartouche; 1; $vl_Position-1)
				$vt_Cartouche:=Substring:C12($vt_Cartouche; $vl_Position+1)
				
				$vl_Position:=Position:C15(<>va_Tab; $vt_Cartouche)
				$te_EnumNbNiveau{$ii}:=Num:C11(Substring:C12($vt_Cartouche; 1; $vl_Position-1))
				$vt_Cartouche:=Substring:C12($vt_Cartouche; $vl_Position+1)
				
				$vl_Position:=Position:C15(<>va_Tab; $vt_Cartouche)
				$te_EnumOrdre{$ii}:=Num:C11(Substring:C12($vt_Cartouche; 1; $vl_Position-1))
				$vt_Cartouche:=Substring:C12($vt_Cartouche; $vl_Position+1)
				
				$ta_EnumCode{$ii}:=$vt_Cartouche
			End for 
		End if 
		CLOSE DOCUMENT:C267($h_RefDoc)
		CLOSE WINDOW:C154
		
		$vb_OK:=True:C214
		
	Else 
		CLOSE DOCUMENT:C267($h_RefDoc)
		ALERT:C41("Ce fichier n'est pas un fichier d'énumération !")
	End if 
	USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
End if 


If ($vb_OK)
	
	If (i_Confirmer("Confirmez-vous l'import de l'énumération : "+$va_TableLibellé))
		i_Message("Import en cours…")
		//  •••  ici la maitrise des références uniques
		QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256(->[TypesTables:11]))
		MultiSoc_Filter(->[ReferenceUnique:2])
		If (Records in selection:C76([ReferenceUnique:2])=1)  //Ce n'est pas la première fiche
			$vl_Référence:=[ReferenceUnique:2]RU_Numero:3
			If ($vl_Référence>=59)
			Else 
				$vl_Position:=Uut_NumerotePlus(->[TypesTables:11]; 59-$vl_Référence)
			End if 
		Else 
			$vl_Position:=Uut_NumerotePlus(->[TypesTables:11]; 59)
		End if 
		
		//Cas avec référence ou Libellé pour l'unicite et la recherche  
		$vb_OK:=UuT_CodesEnumérations($vl_TableRéf)
		
		//Rechercher
		If ($vb_OK)
			QUERY:C277([TypesTables:11]; [TypesTables:11]TT_RéférenceID:1=$vl_TableRéf)
		Else 
			QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4=$va_TableLibellé)
		End if 
		MultiSoc_Filter(->[TypesTables:11])
		//Affectation de la type de table ou du nom de l'énumération
		If (Records in selection:C76([TypesTables:11])=1)
			LOAD RECORD:C52([TypesTables:11])
			QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=[TypesTables:11]TT_RéférenceID:1)
			MultiSoc_Filter(->[TAbles:12])
			If (Records in selection:C76([TAbles:12])>0)
				DELETE SELECTION:C66([TAbles:12])
			End if 
		Else 
			CREATE RECORD:C68([TypesTables:11])
			MultiSoc_Init_Structure(->[TypesTables:11])
			If ($vb_OK)
				[TypesTables:11]TT_RéférenceID:1:=$vl_TableRéf
			Else 
				[TypesTables:11]TT_RéférenceID:1:=Uut_Numerote(->[TypesTables:11])
				$vl_TableRéf:=[TypesTables:11]TT_RéférenceID:1
			End if 
		End if 
		[TypesTables:11]TT_Libellé:4:=$va_TableLibellé
		[TypesTables:11]TT_NbNiveaux:2:=$vl_TableNbNiveau
		[TypesTables:11]TT_Ordre:3:=$vl_TableOrdre
		
		SAVE RECORD:C53([TypesTables:11])
		UNLOAD RECORD:C212([TypesTables:11])
		
		If ($vl_Nombre>0)
			
			$vl_Position:=Uut_NumerotePlus(->[TAbles:12]; $vl_Nombre)
			For ($ii; 1; $vl_Nombre)
				CREATE RECORD:C68([TAbles:12])
				MultiSoc_Init_Structure(->[TAbles:12])
				[TAbles:12]TB_RéférenceID:1:=$vl_Position
				$vl_Position:=$vl_Position+1
				[TAbles:12]TB_TT_ID:2:=$vl_TableRéf
				[TAbles:12]TB_Libellé:6:=$ta_EnumLibellé{$ii}
				[TAbles:12]TB_Niveau:3:=$te_EnumNbNiveau{$ii}
				[TAbles:12]TB_Ordre:8:=$te_EnumOrdre{$ii}
				
				[TAbles:12]TB_Code:5:=String:C10($vl_TableRéf; "000")+Substring:C12($ta_EnumCode{$ii}; 4)
				[TAbles:12]TB_TT_Niveau:4:=String:C10($vl_TableRéf; "000")+"/"+String:C10([TAbles:12]TB_Niveau:3; "0")+Substring:C12($ta_EnumCode{$ii}; 4)
				[TAbles:12]TB_Texte:7:=(" "*([TAbles:12]TB_Niveau:3-1)*5)+[TAbles:12]TB_Libellé:6
				
				SAVE RECORD:C53([TAbles:12])
				UNLOAD RECORD:C212([TAbles:12])
			End for 
		End if 
		CLOSE WINDOW:C154
	End if 
End if 