//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_Direction
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($vl_TailTab; $ii)
CONFIRM:C162("Exporter les statistiques en mode texte sur disque."+<>va_CR+"Confirmez-vous ?")
If (OK=1)
	i_Message("Export en cours …")
	C_TIME:C306($h_RefDoc)
	$h_RefDoc:=?00:00:00?
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$vt_Texte:="Statistiques du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de demandes"+<>va_TAB+String:C10(vl_NbHB)+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de personnes"+<>va_TAB+String:C10(vl_NbHBd)+<>va_CR+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		
		//Tableau du Nombre d'orientations par personne
		$vl_TailTab:=Size of array:C274(td_ORJ)
		If ($vl_TailTab>0)
			$vt_Texte:="Nombre d'orientations par personne"+<>va_CR
			$vt_Texte:=$vt_Texte+<>va_TAB+"Nombre de personnes"+<>va_CR+<>va_CR
			$vt_Texte:=$vt_Texte+"Orientation"+<>va_TAB+"Jour"+<>va_TAB+"Nuit"+<>va_TAB+"Total"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=String:C10(td_ORnb{$ii})+<>va_TAB+String:C10(td_ORJ{$ii})+<>va_TAB+String:C10(td_ORN{$ii})+<>va_TAB+String:C10(td_ORT{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; Char:C90(13))
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		
		//Tableau du Nombre de personnes orientées
		$vl_TailTab:=Size of array:C274(td_DrDt)
		If ($vl_TailTab>0)
			$vt_Texte:="Nombre de personnes orientées"+<>va_CR+<>va_CR
			$vt_Texte:=$vt_Texte+"Jour"+<>va_TAB+"Demandes"+<>va_TAB+<>va_TAB+<>va_TAB+"Orientations"+<>va_CR
			$vt_Texte:=$vt_Texte+"Date"+<>va_TAB+"Jour"+<>va_TAB+"Nuit"+<>va_TAB+"Total"+<>va_TAB+"Jour"+<>va_TAB+"Nuit"+<>va_TAB+"Total"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=String:C10(td_DrDt{$ii})+<>va_TAB+String:C10(td_DrAjJ{$ii})+<>va_TAB+String:C10(td_DrAjN{$ii})+<>va_TAB+String:C10(td_DrAjT{$ii})+<>va_TAB+String:C10(td_DrOjJ{$ii})+<>va_TAB+String:C10(td_DrOjN{$ii})+<>va_TAB+String:C10(td_DrOjT{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; Char:C90(13))
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		
		//Tableau du Nombre de personnes orientées par mois
		$vl_TailTab:=Size of array:C274(td_DrMs)
		If ($vl_TailTab>0)
			$vt_Texte:="Nombre de personnes orientées"+<>va_CR+<>va_CR
			$vt_Texte:=$vt_Texte+"Mois"+<>va_TAB+"Demandes"+<>va_TAB+<>va_TAB+<>va_TAB+"Orientations"+<>va_CR
			$vt_Texte:=$vt_Texte+"Mois"+<>va_TAB+"Jour"+<>va_TAB+"Nuit"+<>va_TAB+"Total"+<>va_TAB+"Jour"+<>va_TAB+"Nuit"+<>va_TAB+"Total"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=String:C10(td_DrMs{$ii})+<>va_TAB+String:C10(td_DrAmJ{$ii})+<>va_TAB+String:C10(td_DrAmN{$ii})+<>va_TAB+String:C10(td_DrAmT{$ii})+<>va_TAB+String:C10(td_DrOmJ{$ii})+<>va_TAB+String:C10(td_DrOmN{$ii})+<>va_TAB+String:C10(td_DrOmT{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; Char:C90(13))
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
			End if 
		End if 
		
		$vt_Texte:=<>va_CR+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
	CLOSE WINDOW:C154
End if 

