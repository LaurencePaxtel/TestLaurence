//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_Maraude
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($vl_TailTab; $ii)
C_TIME:C306($h_RefDoc)
C_BOOLEAN:C305($vb_OK1)
C_BOOLEAN:C305($vb_OK2)
C_BOOLEAN:C305($vb_OK3)
C_BOOLEAN:C305($vb_OK4)
CONFIRM:C162("Exporter les statistiques en mode texte sur disque."+Char:C90(13)+"Confirmez-vous ?")
If (OK=1)
	i_Message("Export en cours …")
	$h_RefDoc:=?00:00:00?
	$vb_OK1:=False:C215
	$vb_OK2:=False:C215
	$vb_OK3:=False:C215
	$vb_OK4:=False:C215
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$vt_Texte:="Statistiques 'SP maraude' du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)+<>va_CR
		Case of 
			: (rJourNuit1=1) & (rJourNuit2=1)
				$vt_Texte:=$vt_Texte+"Jour et Nuit"
			: (rJourNuit1=1) & (rJourNuit2=0)
				$vt_Texte:=$vt_Texte+"Jour"
			: (rJourNuit1=0) & (rJourNuit2=1)
				$vt_Texte:=$vt_Texte+"Nuit"
		End case 
		
		$vt_Texte:=$vt_Texte+<>va_TAB
		$vt_Texte:=$vt_Texte+("Avec les inconnus"*u1)+("Sans les inconnus"*u2)+<>va_CR+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de demandes"+<>va_TAB+String:C10(vl_NbHB)+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de personnes"+<>va_TAB+String:C10(vl_NbHBd)+<>va_CR+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		$vt_Texte:=""
		//Tableau 1
		$vl_TailTab:=Size of array:C274(ta_it1)
		If ($vl_TailTab>0)
			$vb_OK1:=False:C215
			For ($ii; 1; $vl_TailTab)
				If (te_Sel1{$ii}=1)
					$vb_OK1:=True:C214
				End if 
			End for 
			If ($vb_OK1)
				$vt_Texte:=$vt_Texte+Uppercase:C13(ta_Rub1{0})+<>va_CR+<>va_CR
				
				For ($ii; 1; $vl_TailTab)
					If (te_Sel1{$ii}=1)
						$vt_Texte:=$vt_Texte+ta_iT1{$ii}+<>va_TAB+String:C10(tl_Nb1{$ii})+<>va_TAB+String:C10(tl_Nb1_1{$ii})+<>va_CR
					End if 
				End for 
				$vt_Texte:=$vt_Texte+<>va_CR
			End if 
		End if 
		$vt_Texte:=$vt_Texte+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		If ($vb_OK1)
			$vt_Texte:=""
			//Tableau 2
			$vl_TailTab:=Size of array:C274(ta_it2)
			If ($vl_TailTab>0)
				$vb_OK1:=False:C215
				For ($ii; 1; $vl_TailTab)
					If (te_Sel2{$ii}=1)
						$vb_OK2:=True:C214
					End if 
				End for 
				If ($vb_OK2)
					$vt_Texte:=$vt_Texte+Uppercase:C13(ta_Rub2{0})+<>va_CR+<>va_CR
					
					For ($ii; 1; $vl_TailTab)
						If (te_Sel2{$ii}=1)
							$vt_Texte:=$vt_Texte+ta_iT2{$ii}+<>va_TAB+String:C10(tl_Nb2{$ii})+<>va_TAB+String:C10(tl_Nb2_2{$ii})+<>va_CR
						End if 
					End for 
					$vt_Texte:=$vt_Texte+<>va_CR
				End if 
			End if 
			$vt_Texte:=$vt_Texte+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		If ($vb_OK2)
			$vt_Texte:=""
			//Tableau3
			$vl_TailTab:=Size of array:C274(ta_it3)
			If ($vl_TailTab>0)
				$vb_OK3:=False:C215
				For ($ii; 1; $vl_TailTab)
					If (te_Sel3{$ii}=1)
						$vb_OK3:=True:C214
					End if 
				End for 
				If ($vb_OK3)
					$vt_Texte:=$vt_Texte+Uppercase:C13(ta_Rub3{0})+<>va_CR+<>va_CR
					
					For ($ii; 1; $vl_TailTab)
						If (te_Sel3{$ii}=1)
							$vt_Texte:=$vt_Texte+ta_iT3{$ii}+<>va_TAB+String:C10(tl_Nb3{$ii})+<>va_TAB+String:C10(tl_Nb3_3{$ii})+<>va_CR
						End if 
					End for 
					$vt_Texte:=$vt_Texte+<>va_CR
				End if 
			End if 
			$vt_Texte:=$vt_Texte+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		
		If ($vb_OK3)
			$vt_Texte:=""
			//Tableau4
			$vl_TailTab:=Size of array:C274(ta_it4)
			If ($vl_TailTab>0)
				$vb_OK4:=False:C215
				For ($ii; 1; $vl_TailTab)
					If (te_Sel4{$ii}=1)
						$vb_OK4:=True:C214
					End if 
				End for 
				If ($vb_OK4)
					$vt_Texte:=$vt_Texte+Uppercase:C13(ta_Rub4{0})+<>va_CR+<>va_CR
					
					For ($ii; 1; $vl_TailTab)
						If (te_Sel4{$ii}=1)
							$vt_Texte:=$vt_Texte+ta_iT4{$ii}+<>va_TAB+String:C10(tl_Nb4{$ii})+<>va_TAB+String:C10(tl_Nb4_4{$ii})+<>va_CR
						End if 
					End for 
					$vt_Texte:=$vt_Texte+<>va_CR
				End if 
			End if 
			$vt_Texte:=$vt_Texte+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; <>va_CR)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(<>va_CR))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
	CLOSE WINDOW:C154
End if 

