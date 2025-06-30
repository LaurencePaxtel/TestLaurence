//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableTXT
//{
//{          Mercredi 29 Aôut 2001 à 12:27
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($ii)
C_TIME:C306($vh_RefDoc)
C_TEXT:C284($vt_DOSSIER; $vt_TEXTE)


Case of 
	: ($1=0)
		C_TEXT:C284(vt_TXTlibellé)
		C_TEXT:C284(va_TXT; 0)
		// ARRAY TEXT(ta_STR;0)
		ARRAY TEXT:C222(ta_TXT; 0)
		
		// STRING LIST TO ARRAY(30002;ta_STR)
		
		
		// #BS Migration v15 30/05/16
		// Remplacement de la commande obsolète
		// STRING LIST TO ARRAY par xliff_STRING_LIST_TO_ARRAY
		ARRAY TEXT:C222(ta_STR; 0)
		xliff_STRING_LIST_TO_ARRAY_(30002; ->ta_STR)
		
		
		
		If (Size of array:C274(ta_STR)>0)
			Repeat 
				$ii:=$ii+1
				If (Substring:C12(ta_STR{$ii}; 7; 5)="infos")
				Else 
					DELETE FROM ARRAY:C228(ta_STR; $ii; 1)
					$ii:=$ii-1
				End if 
			Until ($ii=Size of array:C274(ta_STR))
		End if 
		
		
		INSERT IN ARRAY:C227(ta_STR; 1; 1)
		//ta_STR:=2
		// ta_STR{ta_STR}:="30001 infos Orientation SIAO"
		
		ta_STR:=1
		ta_STR{ta_STR}:="30000 infos à propos de…"
		ta_STR{0}:=ta_STR{ta_STR}
		ARRAY TEXT:C222(ta_TXT; 1)
		
		va_TXT:="30000 infos à propos de…"
		ta_TXT:=1
		ta_TXT{1}:=va_TXT
		ta_TXT{0}:=ta_TXT{ta_TXT}
		$ii:=Num:C11(Substring:C12(ta_TXT{0}; 1; 5))
		vt_TXTlibellé:=xliff_Get_text_resource($ii)
		
	: ($1=1)
		ta_STR:=$2
		ta_STR{0}:=ta_STR{ta_STR}
		
	: ($1=2)
		ta_TXT:=$2
		ta_TXT{0}:=ta_TXT{ta_TXT}
		If (ta_TXT>0)
			$ii:=Num:C11(Substring:C12(ta_TXT{0}; 1; 5))
			vt_TXTlibellé:=xliff_Get_text_resource($ii)
			va_TXT:=ta_TXT{0}
		Else 
			vt_TXTlibellé:=""
			va_TXT:=""
		End if 
		
	: ($1=3)
		
		Case of 
			: ($2=0)
			: ($2=1)
				ARRAY TEXT:C222(ta_TXT; 1)
				ta_TXT:=1
				ta_TXT{1}:="30000 infos à propos de…"
				ta_TXT{0}:=ta_TXT{ta_TXT}
				$ii:=Num:C11(Substring:C12(ta_TXT{0}; 1; 5))
				vt_TXTlibellé:=xliff_Get_text_resource($ii)
				va_TXT:=ta_TXT{0}
			: ($2>1)
				$ii:=Num:C11(Substring:C12(ta_STR{0}; 1; 5))
				
				// STRING LIST TO ARRAY($ii;ta_TXT)
				
				
				// #BS Migration v15 30/05/16
				// Remplacement de la commande obsolète
				// STRING LIST TO ARRAY par xliff_STRING_LIST_TO_ARRAY
				ARRAY TEXT:C222(ta_TXT; 0)
				xliff_STRING_LIST_TO_ARRAY_($ii; ->ta_TXT)
				
				
				
				ta_TXT:=0
				vt_TXTlibellé:=""
				va_TXT:=""
				If (Size of array:C274(ta_TXT)>0)
					ta_TXT:=1
					ta_TXT{0}:=ta_TXT{ta_TXT}
					$ii:=Num:C11(Substring:C12(ta_TXT{0}; 1; 5))
					vt_TXTlibellé:=xliff_Get_text_resource($ii)
					va_TXT:=ta_TXT{0}
				End if 
		End case 
		
	: ($1=4)
		
		If (i_Confirmer(ta_STR{0}+Char:C90(13)+ta_TXT{0}+Char:C90(13)+"Enregistrer la modification du texte ?"))
			i_Message("Enregistrements en cours…")
			$ii:=Num:C11(Substring:C12(ta_TXT{0}; 1; 5))
			ASSERT:C1129(False:C215; "BS à deboguer")
			_O_SET TEXT RESOURCE:C505($ii; vt_TXTlibellé)
			CLOSE WINDOW:C154
			
			If ($ii>=30201) & ($ii<=30211)
				
				P_InfoDansDepart("Validation"; $ii; ta_TXT{0}; vt_TXTlibellé)
				
				
				
			End if 
			
			
		End if 
		
		
		
	: ($1=5)
		$vb_OK:=True:C214
		If (va_TXT>"")
			UTL_Trace
			For ($ii; 1; Size of array:C274(ta_TXT))
				If (Substring:C12(va_TXT; 1; 5)=Substring:C12(ta_TXT{$ii}; 1; 5))
					$vb_OK:=False:C215
				End if 
			End for 
			If ($vb_OK)
				$ii:=Size of array:C274(ta_TXT)+1
				INSERT IN ARRAY:C227(ta_TXT; $ii)
				ta_TXT:=$ii
				ta_TXT{ta_TXT}:=va_TXT
				ta_TXT{0}:=ta_TXT{ta_TXT}
				vt_TXTlibellé:=""
				$ii:=Num:C11(Substring:C12(ta_STR{0}; 1; 5))
				
				// _o_ARRAY TO STRING LIST(ta_TXT;$ii)
				
				// #BS Migration v15 30/05/16
				// Remplacement de la commande obsolète
				// _o_ARRAY TO STRING LIST par xliff_ARRAY_TO_XLIFF_
				xliff_ARRAY_TO_XLIFF_(->ta_TXT; $ii)
				
				//====================================================//
				// Modified by: Kevin HASSAL (12/10/2020)
				//  Gestion Multi-Sociétés : Gestion des fichiers XLIFF par structure
				//====================================================//
				xliff_ARRAY_TO_XLIFF_(->ta_TXT; ($ii*1000)+<>ID_Societe_Active)
				
			Else 
				StrAlerte(52; va_TXT)
			End if 
		End if 
	: ($1=6)
		If ($2>0)
			$ii:=Num:C11(Substring:C12(ta_TXT{0}; 1; 5))
			_O_DELETE RESOURCE:C501("TEXT"; $ii)
			DELETE FROM ARRAY:C228(ta_TXT; $2; 1)
			$ii:=Num:C11(Substring:C12(ta_STR{0}; 1; 5))
			
			// _o_ARRAY TO STRING LIST(ta_TXT;$ii)
			
			// #BS Migration v15 30/05/16
			// Remplacement de la commande obsolète
			// _o_ARRAY TO STRING LIST par xliff_ARRAY_TO_XLIFF_
			xliff_ARRAY_TO_XLIFF_(->ta_TXT; $ii)
			
			//====================================================//
			// Modified by: Kevin HASSAL (12/10/2020)
			//  Gestion Multi-Sociétés : Gestion des fichiers XLIFF par structure
			//====================================================//
			xliff_ARRAY_TO_XLIFF_(->ta_TXT; ($ii*1000)+<>ID_Societe_Active)
			
		End if 
		If ($2>Size of array:C274(ta_TXT))
			$2:=Size of array:C274(ta_TXT)
		End if 
		ta_TXT:=$2
		ta_TXT{0}:=ta_TXT{ta_TXT}
		$ii:=Num:C11(Substring:C12(ta_TXT{0}; 1; 5))
		vt_TXTlibellé:=xliff_Get_text_resource($ii)
		va_TXT:=ta_TXT{0}
		If ($2>0)
		Else 
			ta_TXT{0}:=""
			vt_TXTlibellé:=""
			va_TXT:=""
		End if 
		
		
	: ($1=10)  //In 
		
		If (Size of array:C274(ta_STR)>0)
			If (ta_STR>0)
				$vt_DOSSIER:=Select folder:C670("Veuillez sélectioner le dossier  CONTENANT Les fichiers "+ta_STR{ta_STR}+" .")
				If (OK=1)
					DOCUMENT LIST:C474($vt_DOSSIER; ta_TXT)
					If (Size of array:C274(ta_TXT)>0)
						$ii:=0
						
						Repeat 
							$ii:=$ii+1
							$vb_OK:=(Num:C11(Substring:C12(ta_TXT{$ii}; 1; 5))>=30201)
							$vb_OK:=$vb_OK & (Num:C11(Substring:C12(ta_TXT{$ii}; 1; 5))<=30211)
							If ($vb_OK)
							Else 
								DELETE FROM ARRAY:C228(ta_TXT; $ii; 1)
								$ii:=$ii-1
							End if 
						Until ($ii=Size of array:C274(ta_TXT))
						If (Size of array:C274(ta_TXT)>0)
							For ($ii; 1; Size of array:C274(ta_TXT))
								$vh_RefDoc:=Open document:C264($vt_DOSSIER+ta_TXT{$ii})
								If (OK=1)
									USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
									
									RECEIVE PACKET:C104($vh_RefDoc; $vt_TEXTE; <>va_CR)
									$vt_TEXTE:=Replace string:C233($vt_TEXTE; <>va_LF; "")
									If ($vt_TEXTE>"")
										
										
										ta_TXT{$ii}:=_O_Win to Mac:C464($vt_TEXTE)
										RECEIVE PACKET:C104($vh_RefDoc; $vt_TEXTE; "SSPFINEXPORTSSP")
										$vt_TEXTE:=Replace string:C233($vt_TEXTE; <>va_LF; "")
										If ($vt_TEXTE>"")
											$vt_TEXTE:=_O_Win to Mac:C464($vt_TEXTE)
											ASSERT:C1129(False:C215; "BS à deboguer")
											_O_SET TEXT RESOURCE:C505(Num:C11(Substring:C12(ta_TXT{$ii}; 1; 5)); $vt_TEXTE)
										End if 
									End if 
									CLOSE DOCUMENT:C267($vh_RefDoc)
									USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
								End if 
							End for 
							
							// _o_ARRAY TO STRING LIST(ta_TXT;Num(Substring(ta_STR{ta_STR};1;5)))
							
							// #BS Migration v15 30/05/16
							// Remplacement de la commande obsolète
							// _o_ARRAY TO STRING LIST par xliff_ARRAY_TO_XLIFF_
							xliff_ARRAY_TO_XLIFF_(->ta_TXT; Num:C11(Substring:C12(ta_STR{ta_STR}; 1; 5)))
							
							//====================================================//
							// Modified by: Kevin HASSAL (12/10/2020)
							//  Gestion Multi-Sociétés : Gestion des fichiers XLIFF par structure
							//====================================================//
							xliff_ARRAY_TO_XLIFF_(->ta_TXT; (Num:C11(Substring:C12(ta_STR{ta_STR}; 1; 5))*1000)+<>ID_Societe_Active)
							
							
						End if 
					End if 
				End if 
			End if 
		End if 
		
	: ($1=11)  //Out 
		If (Size of array:C274(ta_STR)>0)
			If (ta_STR>0)
				If (Size of array:C274(ta_TXT)>0)
					$vt_DOSSIER:=Select folder:C670("Veuillez sélectioner le dossier destinataire des fichiers "+ta_STR{ta_STR}+" .")
					If (OK=1)
						i_Message("Export : ")
						For ($ii; 1; Size of array:C274(ta_TXT))
							i_MessageSeul("Export : "+ta_TXT{$ii})
							$vh_RefDoc:=Create document:C266($vt_DOSSIER+Substring:C12(ta_TXT{$ii}; 1; 5)+"ResTexte")
							If (OK=1)
								USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
								
								$vt_TEXTE:=xliff_Get_text_resource(Num:C11(Substring:C12(ta_TXT{$ii}; 1; 5)))
								$vt_TEXTE:=ta_TXT{$ii}+<>va_CR+$vt_TEXTE+"SSPFINEXPORTSSP"
								SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463($vt_TEXTE))
								
								USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
								CLOSE DOCUMENT:C267($vh_RefDoc)
							End if 
						End for 
						CLOSE WINDOW:C154
					End if 
				End if 
			End if 
		End if 
End case 