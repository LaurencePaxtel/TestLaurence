//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_CheminCarto
//{
//{          Mercredi 12 mai 2004 à 11:21
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

// BS 180516

C_TEXT:C284($0)
$0:=""

C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TIME:C306($wRéf)
C_TEXT:C284($vt_Temp)
Case of 
	: ($1=0)
		If (Application type:C494=4D mode local:K5:1)  //=4D Client )
			$0:=i_NomChemin(Application file:C491)
		End if 
		
	: ($1=1)
		
		If (Test path name:C476($2)=Est un document:K24:1)
			
			USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // BS Migration v15
			
			$wRéf:=Open document:C264($2)
			If (OK=1)
				RECEIVE PACKET:C104($wRéf; $vt_Temp; <>va_CR)
				$vt_Temp:=Replace string:C233($vt_Temp; <>va_LF; "")
				If ($vt_Temp="SSP carto")
					RECEIVE PACKET:C104($wRéf; $vt_Temp; <>va_CR)
					$vt_Temp:=Replace string:C233($vt_Temp; <>va_LF; "")
					If (Substring:C12($vt_Temp; 1; 2)=$3)
						$0:=Substring:C12($vt_Temp; 4)
					End if 
				End if 
			End if 
			CLOSE DOCUMENT:C267($wRéf)
			
			USE CHARACTER SET:C205(*; 1)  // BS Migration v15
		End if 
		
		
	: ($1=2)
		
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // BS Migration v15
		
		$wRéf:=Open document:C264(""; ""; Lire chemin accès:K24:6)
		If (OK=1)
			$0:=document
			CLOSE DOCUMENT:C267($wRéf)
		End if 
		
		If ($0>"")
			
			If (Test path name:C476(<>vt_AppelCheminCarto)=Est un document:K24:1)
				$wRéf:=Open document:C264(<>vt_AppelCheminCarto)
			Else 
				
				$wRéf:=Create document:C266(<>vt_AppelCheminCarto)
			End if 
			
			If (OK=1)
				SEND PACKET:C103($wRéf; "SSP carto"+<>va_CR)
				SEND PACKET:C103($wRéf; $3+"="+$0+<>va_CR)
				SEND PACKET:C103($wRéf; "SSP carto FIN"+<>va_CR)
				CLOSE DOCUMENT:C267($wRéf)
			End if 
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // BS Migration v15
		
	: ($1=3)
		
		
	: ($1=5)
		
		If (Test path name:C476($2)=Est un document:K24:1)
			
			USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // BS Migration v15
			
			$wRéf:=Open document:C264($2)
			If (OK=1)
				RECEIVE PACKET:C104($wRéf; $vt_Temp; <>va_CR)
				$vt_Temp:=Replace string:C233($vt_Temp; <>va_LF; "")
				If ($vt_Temp="SSP docu")
					RECEIVE PACKET:C104($wRéf; $vt_Temp; <>va_CR)
					$vt_Temp:=Replace string:C233($vt_Temp; <>va_LF; "")
					If (Substring:C12($vt_Temp; 1; 2)=$3)
						$0:=Substring:C12($vt_Temp; 4)
					End if 
				End if 
			End if 
			CLOSE DOCUMENT:C267($wRéf)
			
			USE CHARACTER SET:C205(*; 1)  // BS Migration v15
			
		End if 
		
		
	: ($1=6)
		
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$wRéf:=Open document:C264(""; ""; Lire chemin accès:K24:6)
		If (OK=1)
			$0:=document
			CLOSE DOCUMENT:C267($wRéf)
		End if 
		
		If ($0>"")
			If (Test path name:C476(<>vt_AppelCheminDocu)=Est un document:K24:1)
				$wRéf:=Open document:C264(<>vt_AppelCheminDocu)
			Else 
				$wRéf:=Create document:C266(<>vt_AppelCheminDocu)
			End if 
			
			If (OK=1)
				SEND PACKET:C103($wRéf; "SSP docu"+<>va_CR)
				SEND PACKET:C103($wRéf; $3+"="+$0+<>va_CR)
				SEND PACKET:C103($wRéf; "SSP docu FIN"+<>va_CR)
				CLOSE DOCUMENT:C267($wRéf)
			End if 
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // filtre export. BS Migration v15
		
	: ($1=7)
		
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$wRéf:=Open document:C264(""; ""; Lire chemin accès:K24:6)
		If (OK=1)
			$0:=document
			CLOSE DOCUMENT:C267($wRéf)
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // filtre export. BS Migration v15 
		
	: ($1=8)
		
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		If (Test path name:C476(<>vt_AppelCheminDocu)=Est un document:K24:1)
			$wRéf:=Open document:C264(<>vt_AppelCheminDocu)
		Else 
			$wRéf:=Create document:C266(<>vt_AppelCheminDocu)
		End if 
		
		If (OK=1)
			SEND PACKET:C103($wRéf; "SSP docu"+<>va_CR)
			SEND PACKET:C103($wRéf; $3+"="+$2+<>va_CR)
			SEND PACKET:C103($wRéf; "SSP docu FIN"+<>va_CR)
			CLOSE DOCUMENT:C267($wRéf)
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // filtre export. BS Migration v15
End case 
