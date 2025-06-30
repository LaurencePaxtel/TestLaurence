C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($va_Date)
C_TEXT:C284($va_Environ)
C_TEXT:C284($vt_Document; $vt_Texte)
C_TIME:C306($wRéf)
C_LONGINT:C283($ii)

$vb_OK:=(Size of array:C274(<>ta_RubNom)>0)
If ($vb_OK)
	If (i_Confirmer("Export des attributs : "+<>ta_vDSLibel{<>ta_vDSLibel}))
		$va_Environ:=Replace string:C233(<>ta_vDSLibel{<>ta_vDSLibel}; "-"; "")
		$va_Environ:=Replace string:C233($va_Environ; "/"; "")
		$va_Environ:=Replace string:C233($va_Environ; "\\"; "")
		
		$va_Date:=String:C10(Current date:C33; Interne date court:K1:7)
		$va_Date:=Substring:C12($va_Date; 9; 2)+Substring:C12($va_Date; 4; 2)+Substring:C12($va_Date; 1; 2)
		
		$va_Environ:="x"+$va_Date+$va_Environ
		If (Length:C16($va_Environ)>28)
			$va_Environ:=Substring:C12($va_Environ; 1; 28)
		End if 
		$vt_Document:=<>vt_DossierApplication+$va_Environ+".TXT"
		
		$wRéf:=Create document:C266($vt_Document)
		If (OK=1)
			USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
			
			$vt_Texte:=""
			$vt_Texte:=$vt_Texte+<>ta_vDSLibel{<>ta_vDSLibel}+<>va_CR
			$vt_Texte:=$vt_Texte+String:C10(Size of array:C274(<>ta_RubNom))+<>va_CR
			For ($ii; 1; Size of array:C274(<>ta_RubNom))
				$vt_Texte:=$vt_Texte+String:C10(<>te_RubTri{$ii})+<>va_TAB
				$vt_Texte:=$vt_Texte+<>ta_RubNom{$ii}+<>va_TAB
				$vt_Texte:=$vt_Texte+<>ta_RubNomNew{$ii}+<>va_TAB
				$vt_Texte:=$vt_Texte+"x"
				$vt_Texte:=$vt_Texte+String:C10(Num:C11(<>tb_RubVis{$ii}))
				$vt_Texte:=$vt_Texte+String:C10(Num:C11(<>tb_RubSais{$ii}))
				$vt_Texte:=$vt_Texte+String:C10(Num:C11(<>tb_RubMod{$ii}))
				$vt_Texte:=$vt_Texte+String:C10(Num:C11(<>tb_RubObli{$ii}))
				$vt_Texte:=$vt_Texte+String:C10(Num:C11(<>tb_RubPopVis{$ii}))
				$vt_Texte:=$vt_Texte+String:C10(Num:C11(<>tb_RubTrans{$ii}))
				$vt_Texte:=$vt_Texte+"x"+<>va_TAB
				$vt_Texte:=$vt_Texte+String:C10(<>te_RubOrdre{$ii})+<>va_TAB
				$vt_Texte:=$vt_Texte+<>va_TAB+<>ta_RubAlert{$ii}+<>va_CR
			End for 
			$vt_Texte:=$vt_Texte+<>ta_vDSLibel{<>ta_vDSLibel}+" FIN"+<>va_CR
			SEND PACKET:C103($wRéf; _O_Mac to Win:C463($vt_Texte))
			
			USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
			CLOSE DOCUMENT:C267($wRéf)
		End if 
	End if 
End if 



