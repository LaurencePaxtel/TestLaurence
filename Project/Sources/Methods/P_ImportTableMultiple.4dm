//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : P_ImportTableMultiple  
//{
//{          Lundi 20 juillet 2009 à 10:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?
C_TEXT:C284($vt_Cartouche; $vt_CheminDossier)
C_LONGINT:C283($ii; $vl_TailleTableau; $vl_IndiceTableau; $vl_Nombre; $vl_Position; $vl_Référence; $vl_Fenetre)
C_BOOLEAN:C305($vb_OK)
$vb_OK:=False:C215

C_TEXT:C284($va_TableLibellé)
C_LONGINT:C283($vl_TableRéf; $vl_TableRéfOld)
C_LONGINT:C283($vl_TableNbNiveau; $vl_TableOrdre)

ARRAY TEXT:C222(tt_EnumEx_Chemin; 0)
ARRAY TEXT:C222(tt_EnumEx_Nom; 0)
ARRAY TEXT:C222(ta_EnumEx_Libel; 0)
ARRAY LONGINT:C221(tl_EnumEx_Réf; 0)
ARRAY INTEGER:C220(te_EnumEx_Check; 0)

ARRAY TEXT:C222($ta_EnumLibellé; 0)
ARRAY INTEGER:C220($te_EnumNbNiveau; 0)
ARRAY INTEGER:C220($te_EnumOrdre; 0)
ARRAY TEXT:C222($ta_EnumCode; 0)


$vt_CheminDossier:=Select folder:C670("Veuillez sélectionner le dossier contenant les énumérations.")
If (OK=1)
	DOCUMENT LIST:C474($vt_CheminDossier; tt_EnumEx_Nom)
	$vl_TailleTableau:=Size of array:C274(tt_EnumEx_Nom)
	If ($vl_TailleTableau>0)
		ARRAY INTEGER:C220(te_EnumEx_Check; $vl_TailleTableau)
		ARRAY TEXT:C222(ta_EnumEx_Libel; $vl_TailleTableau)
		For ($vl_IndiceTableau; 1; $vl_TailleTableau)
			$h_RefDoc:=Open document:C264($vt_CheminDossier+tt_EnumEx_Nom{$vl_IndiceTableau})
			If (OK=1)
				
				USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
				
				RECEIVE PACKET:C104($h_RefDoc; $vt_Cartouche; <>va_CR)
				$vt_Cartouche:=Replace string:C233($vt_Cartouche; <>va_LF; "")
				If (Substring:C12($vt_Cartouche; 1; 13)="SSPEnumExport")
					te_EnumEx_Check{$vl_IndiceTableau}:=1
				Else 
					te_EnumEx_Check{$vl_IndiceTableau}:=-1
				End if 
				
				RECEIVE PACKET:C104($h_RefDoc; $vt_Cartouche; <>va_CR)
				$vt_Cartouche:=Replace string:C233($vt_Cartouche; <>va_LF; "")
				$vl_Position:=Position:C15(<>va_Tab; $vt_Cartouche)
				ta_EnumEx_Libel{$vl_IndiceTableau}:=Substring:C12($vt_Cartouche; 1; $vl_Position-1)
				
				CLOSE DOCUMENT:C267($h_RefDoc)
				
				USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
			End if 
		End for 
		
		$vl_IndiceTableau:=1
		Repeat 
			If (te_EnumEx_Check{$vl_IndiceTableau}=-1)
				DELETE FROM ARRAY:C228(tt_EnumEx_Nom; $vl_IndiceTableau; 1)
				DELETE FROM ARRAY:C228(te_EnumEx_Check; $vl_IndiceTableau; 1)
				DELETE FROM ARRAY:C228(ta_EnumEx_Libel; $vl_IndiceTableau; 1)
			Else 
				$vl_IndiceTableau:=$vl_IndiceTableau+1
			End if 
		Until ($vl_IndiceTableau>Size of array:C274(tt_EnumEx_Nom))
		$vl_TailleTableau:=Size of array:C274(tt_EnumEx_Nom)
		$vb_OK:=($vl_TailleTableau>0)
	End if 
End if 
If ($vb_OK)
	$vl_Fenetre:=i_FenêtreNo(357; 399; 5; "Enumération : Import"; 4; "")
	DIALOG:C40([DiaLogues:3]; "DL_ImportEnum")
	CLOSE WINDOW:C154($vl_Fenetre)
	If (OK=1)
		$vl_Position:=0
		For ($vl_IndiceTableau; 1; $vl_TailleTableau)
			$vl_Position:=$vl_Position+te_EnumEx_Check{$vl_IndiceTableau}
		End for 
		If ($vl_Position>0)
			i_Message("Import en cours…")
			
			For ($vl_IndiceTableau; 1; $vl_TailleTableau)
				i_MessageSeul("Import en cours : "+String:C10($vl_TailleTableau)+"/"+String:C10($vl_IndiceTableau))
				
				$vb_OK:=False:C215
				If (te_EnumEx_Check{$vl_IndiceTableau}=1)
					
					//OUVERTURE ET DECOUPAGE DU DOCUMENT
					$h_RefDoc:=Open document:C264($vt_CheminDossier+tt_EnumEx_Nom{$vl_IndiceTableau})
					If (OK=1)
						
						USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
						
						RECEIVE PACKET:C104($h_RefDoc; $vt_Cartouche; <>va_CR)
						$vt_Cartouche:=Replace string:C233($vt_Cartouche; <>va_LF; "")
						If (Substring:C12($vt_Cartouche; 1; 13)="SSPEnumExport")
							
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
							
							$vb_OK:=True:C214
							
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
						End if 
						USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
					End if 
				End if 
				
				If ($vb_OK)
					//•••  ici la maitrise des références 
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
					$vb_OK:=($vl_TableRéf>60)
					If ($vb_OK)
						QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4=$va_TableLibellé)
					Else 
						QUERY:C277([TypesTables:11]; [TypesTables:11]TT_RéférenceID:1=$vl_TableRéf)
					End if 
					MultiSoc_Filter(->[TypesTables:11])
					If (Records in selection:C76([TypesTables:11])=1)
						If ($vb_OK)
							$vl_TableRéfOld:=$vl_TableRéf
							$vl_TableRéf:=[TypesTables:11]TT_RéférenceID:1
						End if 
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
							[TypesTables:11]TT_RéférenceID:1:=Uut_Numerote(->[TypesTables:11])
							$vl_TableRéfOld:=$vl_TableRéf
							$vl_TableRéf:=[TypesTables:11]TT_RéférenceID:1
						Else 
							[TypesTables:11]TT_RéférenceID:1:=$vl_TableRéf
						End if 
						[TypesTables:11]TT_Libellé:4:=$va_TableLibellé
						[TypesTables:11]TT_NbNiveaux:2:=$vl_TableNbNiveau
						[TypesTables:11]TT_Ordre:3:=$vl_TableOrdre
						SAVE RECORD:C53([TypesTables:11])
					End if 
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
				End if 
				
			End for 
			CLOSE WINDOW:C154
			
			
			$vl_IndiceTableau:=1
			QUERY:C277([TypesTables:11]; [TypesTables:11]TT_Libellé:4=ta_EnumEx_Libel{$vl_IndiceTableau}; *)
			For ($vl_IndiceTableau; 2; $vl_TailleTableau-1)
				QUERY:C277([TypesTables:11];  | ; [TypesTables:11]TT_Libellé:4=ta_EnumEx_Libel{$vl_IndiceTableau}; *)
			End for 
			$vl_IndiceTableau:=$vl_TailleTableau
			QUERY:C277([TypesTables:11];  | ; [TypesTables:11]TT_Libellé:4=ta_EnumEx_Libel{$vl_IndiceTableau})
			MultiSoc_Filter(->[TypesTables:11])
			
			
		Else 
			ALERT:C41("Aucun document n'est sélectionné dans la liste !")
		End if 
	End if 
Else 
	ALERT:C41("Aucun document trouvé dans le dossier !")
End if 
