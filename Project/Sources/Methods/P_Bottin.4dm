//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Bottin
//{
//{          Mercredi 1 juillet 2009 à 11:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)  //le cas
C_TEXT:C284($2)  //◊Va_DemP; ◊Va_Assoc etc
C_POINTER:C301($3)  //Le nombre de fiches
C_POINTER:C301($4)  //Le nombre de fiches table(énumération)

C_POINTER:C301($5)  //Le chemin
C_BOOLEAN:C305($6)  //Ajouter/remplacer

C_LONGINT:C283($ii; $jj; $vl_no)
C_BOOLEAN:C305($vb_OK)
C_TIME:C306($h_RefDoc)
C_TEXT:C284($vt_Texte)
C_POINTER:C301(vp_UneTable)  //Le chemin

C_TEXT:C284($va_FinGIP)
$va_FinGIP:="SSP 469FIN DATA GIP"


Case of 
	: ($1=1)
		$vb_OK:=False:C215
		If ($2=<>Va_Assoc)
			vp_UneTable:=->[Assocs:14]
			ALL RECORDS:C47([Assocs:14])
			MultiSoc_Filter(->[Assocs:14])
			If (Records in selection:C76([Assocs:14])>0)
				ORDER BY:C49([Assocs:14]; [Assocs:14]AS_Nom:2; >)
				FIRST RECORD:C50([Assocs:14])
				$vb_OK:=True:C214
			End if 
			$4->:=0
		Else 
			vp_UneTable:=->[GIP:13]
			QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=$2)
			MultiSoc_Filter(->[GIP:13])
			$3->:=Records in selection:C76([GIP:13])
			If ($3->>0)
				ORDER BY:C49([GIP:13]; [GIP:13]GI_SousTheme:4; <; *)
				ORDER BY:C49([GIP:13]; [GIP:13]GI_Theme:3; >; *)
				ORDER BY:C49([GIP:13]; [GIP:13]GI_Nom:5; >)
				FIRST RECORD:C50([GIP:13])
				$vb_OK:=True:C214
			End if 
			Case of 
				: ($2=<>Va_DemP)
					$vt_Texte:=Substring:C12(<>va_DemP_R; 1; 3)
				: ($2=<>Va_AdUtil)
					$vt_Texte:=Substring:C12(<>va_AdUtil_R; 1; 3)
				: ($2=<>Va_SitPar)
					$vt_Texte:=Substring:C12(<>va_SitPar_R; 1; 3)
			End case 
			QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=Num:C11($vt_Texte))
			MultiSoc_Filter(->[TAbles:12])
			$4->:=Records in selection:C76([TAbles:12])
		End if 
		
		If ($vb_OK)
			$h_RefDoc:=Create document:C266("")
			If (OK=1)
				i_Message($2+" : Export …")
				$vt_Texte:=$2+<>va_Tab+String:C10($3->)+<>va_Tab+String:C10($4->)+<>va_Tab+String:C10(Current date:C33; Interne date court:K1:7)+<>va_Tab+String:C10(Current time:C178)+<>va_CR
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
				$ii:=0
				Repeat 
					$ii:=$ii+1
					i_MessageSeul($2+" : Export  : "+String:C10($3->)+"/"+String:C10($ii))
					If ($2=<>Va_Assoc)
						$vt_Texte:=String:C10([Assocs:14]AS_ReferenceID:1)+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_Nom:2+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_Nom2:3+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_Adresse1:4+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_Adresse2:5+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_Adresse3:6+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_CP:7+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_Ville:8+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_Téléphone:9+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_Télécopie:10+<>va_Tab
						$vt_Texte:=$vt_Texte+[Assocs:14]AS_Contact:11+<>va_Tab
						$vt_Texte:=$vt_Texte+Replace string:C233([Assocs:14]AS_Notes:12; <>va_CR; "<X>")+<>va_CR
					Else 
						$vt_Texte:=String:C10([GIP:13]GI_ReferenceID:1)+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Rubrique:2+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Theme:3+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_SousTheme:4+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Nom:5+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Nom2:6+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Adresse1:7+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Adresse2:8+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Adresse3:9+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_CP:10+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Ville:11+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Arr:12+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Metro:13+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Téléphone:14+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Télécopie:15+<>va_Tab
						$vt_Texte:=$vt_Texte+[GIP:13]GI_Contact:16+<>va_Tab
						
						$vt_Texte:=$vt_Texte+Replace string:C233([GIP:13]GI_Conditions:17; <>va_CR; "<X>")+<>va_Tab
						$vt_Texte:=$vt_Texte+Replace string:C233([GIP:13]GI_Horaires:18; <>va_CR; "<X>")+<>va_Tab
						$vt_Texte:=$vt_Texte+Replace string:C233([GIP:13]GI_Notes:19; <>va_CR; "<X>")+<>va_CR
					End if 
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
					NEXT RECORD:C51(vp_UneTable->)
				Until (End selection:C36(vp_UneTable->))
				$vt_Texte:=$va_FinGIP+<>va_CR
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
				
				If ($4->>0)
					Case of 
						: ($2=<>Va_DemP)
							$vt_Texte:=Substring:C12(<>va_DemP_R; 1; 3)
						: ($2=<>Va_AdUtil)
							$vt_Texte:=Substring:C12(<>va_AdUtil_R; 1; 3)
						: ($2=<>Va_SitPar)
							$vt_Texte:=Substring:C12(<>va_SitPar_R; 1; 3)
					End case 
					QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=Num:C11($vt_Texte))
					MultiSoc_Filter(->[TAbles:12])
					$4->:=Records in selection:C76([TAbles:12])
					If ($4->>0)
						FIRST RECORD:C50([TAbles:12])
						$ii:=0
						Repeat 
							$ii:=$ii+1
							i_MessageSeul($2+" : Export  enumération: "+String:C10($jj)+"/"+String:C10($ii))
							$vt_Texte:=String:C10([TAbles:12]TB_RéférenceID:1)+<>va_Tab
							$vt_Texte:=$vt_Texte+String:C10([TAbles:12]TB_TT_ID:2)+<>va_Tab
							$vt_Texte:=$vt_Texte+String:C10([TAbles:12]TB_Niveau:3)+<>va_Tab
							$vt_Texte:=$vt_Texte+[TAbles:12]TB_TT_Niveau:4+<>va_Tab
							$vt_Texte:=$vt_Texte+[TAbles:12]TB_Code:5+<>va_Tab
							$vt_Texte:=$vt_Texte+[TAbles:12]TB_Libellé:6+<>va_Tab
							$vt_Texte:=$vt_Texte+String:C10([TAbles:12]TB_Ordre:8)+<>va_CR
							SEND PACKET:C103($h_RefDoc; $vt_Texte)
							NEXT RECORD:C51([TAbles:12])
						Until (End selection:C36([TAbles:12]))
					End if 
				End if 
				CLOSE DOCUMENT:C267($h_RefDoc)
				CLOSE WINDOW:C154
			End if 
		Else 
			ALERT:C41("Acune fiche à exporter !")
		End if 
		
		
	: ($1=10)
		$vb_OK:=False:C215
		$h_RefDoc:=Open document:C264(""; Mode lecture:K24:5)
		If (OK=1)
			
			USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
			
			$5->:=document
			RECEIVE PACKET:C104($h_RefDoc; $vt_Texte; <>va_CR)
			$vt_Texte:=Replace string:C233($vt_Texte; <>va_LF; "")
			If (Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)=$2)
				$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
				$3->:=Num:C11(Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1))
				$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
				$4->:=Num:C11(Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1))
				If (($3->)>0)
					$vb_OK:=True:C214
				Else 
					$5->:=$2+" : aucune fiche à importer !"
				End if 
			Else 
				BEEP:C151
				$5->:="Ce n'est pas un fichier de "+$2+" !"
			End if 
			CLOSE DOCUMENT:C267($h_RefDoc)
			
			USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
		End if 
		If ($vb_OK)
			i_Message($2+" : Import…")
			If ($6)  //Remplacer
				i_MessageSeul($2+" : Import : suppression en cours…")
				//On supprime
				If ($2=<>Va_Assoc)
					READ WRITE:C146([Assocs:14])
					ALL RECORDS:C47([Assocs:14])
					MultiSoc_Filter(->[Assocs:14])
					DELETE SELECTION:C66([Assocs:14])
					READ ONLY:C145([Assocs:14])
					If (Records in table:C83([Assocs:14])=0)
						Uut_NumeroteInit(->[Assocs:14])
					End if 
				Else 
					READ WRITE:C146([GIP:13])
					QUERY:C277([GIP:13]; [GIP:13]GI_Rubrique:2=<>Va_DemP)
					MultiSoc_Filter(->[GIP:13])
					If (Records in selection:C76([GIP:13])>0)
						DELETE SELECTION:C66([GIP:13])
					End if 
					READ ONLY:C145([GIP:13])
					Case of 
						: ($2=<>Va_DemP)
							$vt_Texte:=Substring:C12(<>va_DemP_R; 1; 3)
						: ($2=<>Va_AdUtil)
							$vt_Texte:=Substring:C12(<>va_AdUtil_R; 1; 3)
						: ($2=<>Va_SitPar)
							$vt_Texte:=Substring:C12(<>va_SitPar_R; 1; 3)
					End case 
					READ WRITE:C146([TAbles:12])
					QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_ID:2=Num:C11($vt_Texte))
					MultiSoc_Filter(->[TAbles:12])
					If (Records in selection:C76([TAbles:12])>0)
						DELETE SELECTION:C66([TAbles:12])
					End if 
					READ ONLY:C145([TAbles:12])
				End if 
			End if   // Fin Remplacer
			
			//Import
			$vt_Texte:=""
			If ($2=<>Va_Assoc)
				$vl_no:=Uut_NumerotePlus(->[Assocs:14]; $3->)
				$h_RefDoc:=Open document:C264($5->)
				If (OK=1)
					
					USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
					
					//ligne de titre          
					RECEIVE PACKET:C104($h_RefDoc; $vt_Texte; <>va_CR)
					$vb_OK:=False:C215
					$ii:=0
					READ WRITE:C146([Assocs:14])
					Repeat 
						$ii:=$ii+1
						i_MessageSeul($2+" : Import "+String:C10($3->)+"/"+String:C10($ii))
						
						RECEIVE PACKET:C104($h_RefDoc; $vt_Texte; <>va_CR)
						$vt_Texte:=Replace string:C233($vt_Texte; <>va_LF; "")
						$vb_OK:=(($vt_Texte="") | ($vt_Texte=$va_FinGIP))
						If ($vb_OK=False:C215)
							CREATE RECORD:C68([Assocs:14])
							MultiSoc_Init_Structure(->[Assocs:14])
							[Assocs:14]AS_ReferenceID:1:=$vl_no
							$vl_no:=$vl_no+1
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							
							[Assocs:14]AS_Nom:2:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[Assocs:14]AS_Nom2:3:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[Assocs:14]AS_Adresse1:4:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[Assocs:14]AS_Adresse2:5:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[Assocs:14]AS_Adresse3:6:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[Assocs:14]AS_CP:7:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[Assocs:14]AS_Ville:8:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[Assocs:14]AS_Téléphone:9:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[Assocs:14]AS_Télécopie:10:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[Assocs:14]AS_Contact:11:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							
							[Assocs:14]AS_Notes:12:=$vt_Texte
							[Assocs:14]AS_Notes:12:=Replace string:C233([Assocs:14]AS_Notes:12; "<X>"; <>va_CR)
							MultiSoc_Init_Structure(->[Assocs:14])
							SAVE RECORD:C53([Assocs:14])
							UNLOAD RECORD:C212([Assocs:14])
						End if 
					Until ($vb_OK)
					READ ONLY:C145([Assocs:14])
					CLOSE DOCUMENT:C267($h_RefDoc)
					
					USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
				End if 
				
			Else 
				$vl_no:=Uut_NumerotePlus(->[GIP:13]; $3->)
				$h_RefDoc:=Open document:C264($5->)
				If (OK=1)
					
					USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
					
					//Ligne de titre          
					RECEIVE PACKET:C104($h_RefDoc; $vt_Texte; <>va_CR)
					$vb_OK:=False:C215
					$ii:=0
					READ WRITE:C146([GIP:13])
					
					Repeat 
						$ii:=$ii+1
						i_MessageSeul($2+" : Import "+String:C10($3->)+"/"+String:C10($ii))
						
						RECEIVE PACKET:C104($h_RefDoc; $vt_Texte; <>va_CR)
						$vt_Texte:=Replace string:C233($vt_Texte; <>va_LF; "")
						$vb_OK:=(($vt_Texte="") | ($vt_Texte=$va_FinGIP))
						If ($vb_OK=False:C215)
							CREATE RECORD:C68([GIP:13])
							MultiSoc_Init_Structure(->[GIP:13])
							[GIP:13]GI_ReferenceID:1:=$vl_no
							$vl_no:=$vl_no+1
							
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							
							[GIP:13]GI_Rubrique:2:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Theme:3:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_SousTheme:4:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Nom:5:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Nom2:6:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Adresse1:7:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Adresse2:8:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Adresse3:9:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_CP:10:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Ville:11:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Arr:12:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Metro:13:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Téléphone:14:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Télécopie:15:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Contact:16:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							
							[GIP:13]GI_Conditions:17:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							[GIP:13]GI_Conditions:17:=Replace string:C233([GIP:13]GI_Conditions:17; "<X>"; <>va_CR)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Horaires:18:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
							[GIP:13]GI_Horaires:18:=Replace string:C233([GIP:13]GI_Horaires:18; "<X>"; <>va_CR)
							$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
							[GIP:13]GI_Notes:19:=$vt_Texte
							[GIP:13]GI_Notes:19:=Replace string:C233([GIP:13]GI_Notes:19; "<X>"; <>va_CR)
							
							SAVE RECORD:C53([GIP:13])
							UNLOAD RECORD:C212([GIP:13])
						End if 
					Until ($vb_OK)
					READ ONLY:C145([GIP:13])
					
					
					If ($4->>0)  //Le nombre de fiches table(énumération)            
						Case of 
							: ($2=<>Va_DemP)
								$vt_Texte:=Substring:C12(<>va_DemP_R; 1; 3)
							: ($2=<>Va_AdUtil)
								$vt_Texte:=Substring:C12(<>va_AdUtil_R; 1; 3)
							: ($2=<>Va_SitPar)
								$vt_Texte:=Substring:C12(<>va_SitPar_R; 1; 3)
						End case 
						QUERY:C277([TypesTables:11]; [TypesTables:11]TT_RéférenceID:1=Num:C11($vt_Texte))
						MultiSoc_Filter(->[TypesTables:11])
						If (Records in selection:C76([TypesTables:11])=1)
						Else 
							READ WRITE:C146([TypesTables:11])
							CREATE RECORD:C68([TypesTables:11])
							MultiSoc_Init_Structure(->[TypesTables:11])
							[TypesTables:11]TT_RéférenceID:1:=Num:C11($vt_Texte)
							[TypesTables:11]TT_NbNiveaux:2:=2
							[TypesTables:11]TT_Ordre:3:=0
							[TypesTables:11]TT_Libellé:4:=$2
							SAVE RECORD:C53([TypesTables:11])
							UNLOAD RECORD:C212([TypesTables:11])
							READ ONLY:C145([TypesTables:11])
						End if 
						
						
						$vl_no:=Uut_NumerotePlus(->[TAbles:12]; $4->)
						READ WRITE:C146([TAbles:12])
						$ii:=0
						$vb_OK:=False:C215
						Repeat 
							$ii:=$ii+1
							i_MessageSeul($2+" : Import Rubriques et thèmes : "+String:C10($4->)+"/"+String:C10($ii))
							
							RECEIVE PACKET:C104($h_RefDoc; $vt_Texte; <>va_CR)
							$vt_Texte:=Replace string:C233($vt_Texte; <>va_LF; "")
							$vb_OK:=($vt_Texte="")
							If ($vt_Texte>"")
								CREATE RECORD:C68([TAbles:12])
								MultiSoc_Init_Structure(->[TAbles:12])
								[TAbles:12]TB_RéférenceID:1:=$vl_no
								$vl_no:=$vl_no+1
								
								$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
								[TAbles:12]TB_TT_ID:2:=Num:C11(Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1))
								$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
								[TAbles:12]TB_Niveau:3:=Num:C11(Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1))
								$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
								[TAbles:12]TB_TT_Niveau:4:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
								[TAbles:12]TB_TT_Niveau:4:=Replace string:C233([TAbles:12]TB_TT_Niveau:4; "O"; "0")
								$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
								[TAbles:12]TB_Code:5:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
								[TAbles:12]TB_Code:5:=Replace string:C233([TAbles:12]TB_Code:5; "O"; "0")
								$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
								[TAbles:12]TB_Libellé:6:=Substring:C12($vt_Texte; 1; Position:C15(<>va_Tab; $vt_Texte)-1)
								$vt_Texte:=Substring:C12($vt_Texte; Position:C15(<>va_Tab; $vt_Texte)+1)
								[TAbles:12]TB_Ordre:8:=Num:C11($vt_Texte)
								
								[TAbles:12]TB_Texte:7:=(" "*([TAbles:12]TB_Niveau:3-1)*5)+[TAbles:12]TB_Libellé:6
								
								SAVE RECORD:C53([TAbles:12])
								UNLOAD RECORD:C212([TAbles:12])
							End if 
						Until ($vb_OK)
						READ ONLY:C145([TAbles:12])
						
						P_Bottin(11; $2; $3; $4; $5; $6)
					End if 
					
					CLOSE DOCUMENT:C267($h_RefDoc)
					USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
				End if 
				
			End if 
			
			CLOSE WINDOW:C154
		End if 
		
		
		
		
	: ($1=11)
		//Valeur des rubriques/Thèmes/Sous-thèmes
		If (7=8)
			//Demande de prestation
			<>va_DemP_R:="040/1@"
			<>va_DemP_L:="Demande de prestations"
			
			//Adresses utiles
			<>va_AdUtil_R:="041/1@"
			<>va_AdUtil_L:="Adresses utiles"
			
			//Stuations particulières
			<>va_SitPar_R:="042/1@"
			<>va_SitPar_L:="Stuations particulières"
		End if 
		
		Case of 
			: ($2=<>Va_DemP)  //Demande de prestation
				QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=<>va_DemP_R)
				MultiSoc_Filter(->[TAbles:12])
				SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_DemP; [TAbles:12]TB_TT_Niveau:4; <>ta_DemPCd)
				SORT ARRAY:C229(<>ta_DemPCd; <>ta_DemP; >)
				vl_Demande_Items:=Size of array:C274(<>ta_DemP)
				
			: ($2=<>Va_AdUtil)  //Adresses utiles
				QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=<>va_AdUtil_R)
				MultiSoc_Filter(->[TAbles:12])
				SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_AdUtil; [TAbles:12]TB_TT_Niveau:4; <>ta_AdUtilCd)
				SORT ARRAY:C229(<>ta_AdUtilCd; <>ta_AdUtil; >)
				vl_Adresse_Items:=Size of array:C274(<>ta_AdUtil)
				
			: ($2=<>Va_SitPar)  //Stuations particulières
				QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=<>va_SitPar_R)
				MultiSoc_Filter(->[TAbles:12])
				SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; <>ta_SitPar; [TAbles:12]TB_TT_Niveau:4; <>ta_SitParCd)
				SORT ARRAY:C229(<>ta_SitParCd; <>ta_SitPar; >)
				vl_Situation_Items:=Size of array:C274(<>ta_SitPar)
		End case 
		
		
End case 

