C_TEXT:C284($va_Environ)

C_TIME:C306($wRéf)
C_LONGINT:C283($ii; $vl_Taille)


$wRéf:=Open document:C264("")
If (OK=1)
	
	USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 1)  // Filtre import. BS Migration v15
	
	RECEIVE PACKET:C104($wRéf; $vt_Temp; <>va_CR)
	$vt_Temp:=_O_Win to Mac:C464($vt_Temp)
	If ($vt_Temp=<>ta_vDSLibel{<>ta_vDSLibel})
		RECEIVE PACKET:C104($wRéf; $vt_Temp; <>va_CR)
		$vt_Temp:=_O_Win to Mac:C464($vt_Temp)
		$vt_Temp:=Replace string:C233($vt_Temp; <>va_LF; "")
		$vl_Taille:=Num:C11($vt_Temp)
		If ($vl_Taille>0)
			If (Size of array:C274(<>ta_RubNom)=$vl_Taille)
				For ($ii; 1; Size of array:C274(<>ta_RubNom))
					RECEIVE PACKET:C104($wRéf; $vt_Temp; <>va_CR)
					$vt_Temp:=_O_Win to Mac:C464($vt_Temp)
					$vt_Temp:=Replace string:C233($vt_Temp; <>va_LF; "")
					If ($vt_Temp>"")
						<>te_RubTri{$ii}:=Num:C11(Substring:C12($vt_Temp; 1; Position:C15(<>va_Tab; $vt_Temp)-1))
						$vt_Temp:=Substring:C12($vt_Temp; Position:C15(<>va_Tab; $vt_Temp)+1)
						
						<>ta_RubNom{$ii}:=Substring:C12($vt_Temp; 1; Position:C15(<>va_Tab; $vt_Temp)-1)
						$vt_Temp:=Substring:C12($vt_Temp; Position:C15(<>va_Tab; $vt_Temp)+1)
						
						<>ta_RubNomNew{$ii}:=Substring:C12($vt_Temp; 1; Position:C15(<>va_Tab; $vt_Temp)-1)
						$vt_Temp:=Substring:C12($vt_Temp; Position:C15(<>va_Tab; $vt_Temp)+1)
						
						$va_Environ:=Substring:C12($vt_Temp; 1; Position:C15(<>va_Tab; $vt_Temp)-1)
						
						<>tb_RubVis{$ii}:=($va_Environ[[2]]="1")
						<>tb_RubSais{$ii}:=($va_Environ[[3]]="1")
						<>tb_RubMod{$ii}:=($va_Environ[[4]]="1")
						<>tb_RubObli{$ii}:=($va_Environ[[5]]="1")
						<>tb_RubPopVis{$ii}:=($va_Environ[[6]]="1")
						<>tb_RubTrans{$ii}:=($va_Environ[[7]]="1")
						
						
						$vt_Temp:=Substring:C12($vt_Temp; Position:C15(<>va_Tab; $vt_Temp)+1)
						
						<>te_RubOrdre{$ii}:=Num:C11(Substring:C12($vt_Temp; 1; Position:C15(<>va_Tab; $vt_Temp)-1))
						$vt_Temp:=Substring:C12($vt_Temp; Position:C15(<>va_Tab; $vt_Temp)+1)
						
						<>ta_RubAlert{$ii}:=$vt_Temp
						
					End if 
				End for 
			Else 
				ALERT:C41("Le nombre de champs n'est pas identique ("+String:C10($vl_Taille)+") .")
			End if 
		Else 
			ALERT:C41("Import annulé .")
		End if 
	Else 
		ALERT:C41("Ce ne sont pas les attributs de l'environnement : '"+<>ta_vDSLibel{<>ta_vDSLibel}+"'   mais de : '"+$vt_Temp+"'.")
	End if 
	CLOSE DOCUMENT:C267($wRéf)
	USE CHARACTER SET:C205(*; 1)  // reset Filtre import. BS Migration v15
End if 