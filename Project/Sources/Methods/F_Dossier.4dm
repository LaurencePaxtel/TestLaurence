//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : F_Dossier
//{          Mercredi 16 mai 2012 à 12:30:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)
C_POINTER:C301(${2})
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283(vl_ii; vl_ij)
C_TEXT:C284($vt_Chemin)

Case of 
	: ($1="DocuSSP")
		$vt_Chemin:=$2->+<>va_Rép_TransReport+Séparateur dossier:K24:12
		//•   Le répertoir existe-t-il
		If (F_Répertoire($vt_Chemin))
			//• `Y t il des fiches
			DOCUMENT LIST:C474($vt_Chemin; ta_ConsoDocuFichier)
			If (Size of array:C274(ta_ConsoDocuFichier)>0)
				//NE CONSERVER QUE CE QUI EST UNE FICHE D HÉBERGEMENT
				vl_ii:=1
				vl_ij:=Size of array:C274(ta_ConsoDocuFichier)
				
				Repeat 
					//AH 09022508h15J01810 FS49.TXT            
					//•(x1) Longueur 25 caractères
					If (Substring:C12(ta_ConsoDocuFichier{vl_ii}; Length:C16(ta_ConsoDocuFichier{vl_ii})-3; 4)=".TXT")
						$vb_OK:=(Length:C16(ta_ConsoDocuFichier{vl_ii})=29)
					Else 
						$vb_OK:=(Length:C16(ta_ConsoDocuFichier{vl_ii})=25)
					End if 
					//•(x2) Année               
					If ($vb_OK)
						$vb_OK:=(Num:C11(ta_ConsoDocuFichier{vl_ii}[[4]])>=0) & (Num:C11(ta_ConsoDocuFichier{vl_ii}[[4]])<=9)
						$vb_OK:=$vb_OK & ((Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 4; 2))>0) & (Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 4; 2))<=99))
					End if 
					//•(x3) Mois               
					If ($vb_OK)
						$vb_OK:=((Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 6; 2))>0) & (Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 6; 2))<=12))
					End if 
					//•(x4) Jour              
					If ($vb_OK)
						$vb_OK:=((Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 8; 2))>0) & (Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 8; 2))<=31))
					End if 
					//•(x5) h          
					If ($vb_OK)
						$vb_OK:=(ta_ConsoDocuFichier{vl_ii}[[12]]="h")
					End if 
					//•(x6) Jour   ou Nuit                 
					If ($vb_OK)
						$vb_OK:=((ta_ConsoDocuFichier{vl_ii}[[15]]="J") | (ta_ConsoDocuFichier{vl_ii}[[15]]="N"))
					End if 
					//•(x7) Homme   ou Femme             
					If ($vb_OK)
						$vb_OK:=((ta_ConsoDocuFichier{vl_ii}[[22]]="H") | (ta_ConsoDocuFichier{vl_ii}[[22]]="F"))
					End if 
					
					If ($vb_OK)
						vl_ii:=vl_ii+1
					Else 
						DELETE FROM ARRAY:C228(ta_ConsoDocuFichier; vl_ii; 1)
					End if 
					$vb_OK:=(vl_ii>Size of array:C274(ta_ConsoDocuFichier))
				Until ($vb_OK)
			End if 
			$0:=True:C214
		End if 
		
		
	: ($1="DocuChemin")
		$vt_Chemin:=$2->+<>va_Rép_TransReport+Séparateur dossier:K24:12
		vl_ij:=Size of array:C274(ta_ConsoDocuFichier)
		ARRAY INTEGER:C220(te_ConsoDocuCheck; vl_ij)
		ARRAY TEXT:C222(tt_ConsoDocu; vl_ij)
		If (vl_ij>0)
			For (vl_ii; 1; vl_ij)
				te_ConsoDocuCheck{vl_ii}:=0
				// tt_ConsoDocu{vl_ii}:=$vt_Chemin+ta_ConsoDocuFichier{vl_ii}
			End for 
		End if 
		
	: ($1="DocuSSPNuit")
		$vt_Chemin:=$2->+<>va_Rép_TransPresta+Séparateur dossier:K24:12
		//•   Le répertoir existe-t-il
		If (F_Répertoire($vt_Chemin))
			//• `Y t il des fiches
			DOCUMENT LIST:C474($vt_Chemin; ta_ConsoDocuFichier)
			If (Size of array:C274(ta_ConsoDocuFichier)>0)
				//NE CONSERVER QUE CE QUI EST UNE FICHE D HÉBERGEMENT
				vl_ii:=1
				vl_ij:=Size of array:C274(ta_ConsoDocuFichier)
				
				Repeat 
					//AH 09022508h15J01810 FS49.TXT            
					//•(x1) Longueur 25 caractères
					If (Substring:C12(ta_ConsoDocuFichier{vl_ii}; Length:C16(ta_ConsoDocuFichier{vl_ii})-3; 4)=".TXT")
						$vb_OK:=(Length:C16(ta_ConsoDocuFichier{vl_ii})=29)
					Else 
						$vb_OK:=(Length:C16(ta_ConsoDocuFichier{vl_ii})=25)
					End if 
					//•(x2) Année               
					If ($vb_OK)
						$vb_OK:=(Num:C11(ta_ConsoDocuFichier{vl_ii}[[4]])>=0) & (Num:C11(ta_ConsoDocuFichier{vl_ii}[[4]])<=9)
						$vb_OK:=$vb_OK & ((Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 4; 2))>0) & (Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 4; 2))<=99))
					End if 
					//•(x3) Mois               
					If ($vb_OK)
						$vb_OK:=((Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 6; 2))>0) & (Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 6; 2))<=12))
					End if 
					//•(x4) Jour              
					If ($vb_OK)
						$vb_OK:=((Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 8; 2))>0) & (Num:C11(Substring:C12(ta_ConsoDocuFichier{vl_ii}; 8; 2))<=31))
					End if 
					//•(x5) h          
					If ($vb_OK)
						$vb_OK:=(ta_ConsoDocuFichier{vl_ii}[[12]]="h")
					End if 
					//•(x6) Jour   ou Nuit                 
					If ($vb_OK)
						$vb_OK:=((ta_ConsoDocuFichier{vl_ii}[[15]]="J") | (ta_ConsoDocuFichier{vl_ii}[[15]]="N"))
					End if 
					//•(x7) Homme   ou Femme             
					If ($vb_OK)
						$vb_OK:=((ta_ConsoDocuFichier{vl_ii}[[22]]="H") | (ta_ConsoDocuFichier{vl_ii}[[22]]="F"))
					End if 
					
					If ($vb_OK)
						vl_ii:=vl_ii+1
					Else 
						DELETE FROM ARRAY:C228(ta_ConsoDocuFichier; vl_ii; 1)
					End if 
					$vb_OK:=(vl_ii>Size of array:C274(ta_ConsoDocuFichier))
				Until ($vb_OK)
			End if 
			$0:=True:C214
		End if 
		
		
	: ($1="DocuCheminNuit")
		$vt_Chemin:=$2->+<>va_Rép_TransPresta+Séparateur dossier:K24:12
		vl_ij:=Size of array:C274(ta_ConsoDocuFichier)
		ARRAY INTEGER:C220(te_ConsoDocuCheck; vl_ij)
		ARRAY TEXT:C222(tt_ConsoDocu; vl_ij)
		If (vl_ij>0)
			For (vl_ii; 1; vl_ij)
				te_ConsoDocuCheck{vl_ii}:=0
				// tt_ConsoDocu{vl_ii}:=$vt_Chemin+ta_ConsoDocuFichier{vl_ii}
			End for 
		End if 
		
End case 

