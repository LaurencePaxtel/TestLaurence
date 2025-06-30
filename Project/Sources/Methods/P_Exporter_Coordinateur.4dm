//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_Coordinateur
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($vl_TailTab)

CONFIRM:C162("Exporter les statistiques en mode texte sur disque."+Char:C90(13)+"Confirmez-vous ?")
If (OK=1)
	i_Message("Export en cours …")
	C_TIME:C306($h_RefDoc)
	$h_RefDoc:=?00:00:00?
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$vt_Texte:="Statistiques du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)
		$vt_Texte:=$vt_Texte+<>va_CR
		$vt_Texte:=$vt_Texte+("Jour"*rJourNuit1)+(" et "*Num:C11((rJourNuit1=1) & (rJourNuit2=1)))+("Nuit"*rJourNuit2)
		$vt_Texte:=$vt_Texte+<>va_CR
		$vt_Texte:=$vt_Texte+<>va_TAB+"Disponible"+<>va_TAB+"Distribués"+<>va_TAB+"Restants"+<>va_TAB+"%"
		$vt_Texte:=$vt_Texte+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de lits"
		$vt_Texte:=$vt_Texte+<>va_TAB+String:C10(vl_lit_At)+<>va_TAB+String:C10(vl_lit_Dist)+<>va_TAB+String:C10(vl_lit_Rest)+<>va_TAB+String:C10(vr_lit_Pc)
		$vt_Texte:=$vt_Texte+<>va_CR+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		$vl_TailTab:=Size of array:C274(<>ta_TBEtCiv)
		If ($vl_TailTab>0)
			$vt_Texte:="Hébergements"+<>va_TAB+"Demande"+<>va_TAB+"%Demande"+<>va_TAB+"Distribués"+<>va_TAB+"%Distribués"+<>va_TAB+"Médicalisé"+<>va_TAB+"%Médicalisé"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			
			C_LONGINT:C283($ii)
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=<>ta_TBEtCiv{$ii}+<>va_TAB+String:C10(t_ET_Dem{$ii})+<>va_TAB+String:C10(t_ET_DemPc{$ii})+<>va_TAB+String:C10(t_ET_Dis{$ii})+<>va_TAB+String:C10(t_ET_DisPc{$ii})+<>va_TAB+String:C10(t_ET_Med{$ii})+<>va_TAB+String:C10(t_ET_MedPc{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_ET_Dem)+<>va_TAB+String:C10(vr_ET_DemPc)+<>va_TAB+String:C10(vl_ET_Dis)+<>va_TAB+String:C10(vr_ET_DisPc)+<>va_TAB+String:C10(vl_ET_Med)+<>va_TAB+String:C10(vr_ET_MedPc)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(<>ta_TBSglt)
		If ($vl_TailTab>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}+<>va_TAB+"Nombre"+<>va_TAB+"Pourcentage"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=<>ta_TBSglt{$ii}+<>va_TAB+String:C10(t_SG_Dem{$ii})+<>va_TAB+String:C10(t_SG_DemPc{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_SG_Dem)+<>va_TAB+String:C10(vr_SG_DemPc)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(ta_Centre)
		If ($vl_TailTab>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}+<>va_TAB+"HS"+<>va_TAB+"HC"+<>va_TAB+"HE"+<>va_TAB+"HF"+<>va_TAB+"FS"+<>va_TAB+"FC"+<>va_TAB+"FE"+<>va_TAB+"FF"+<>va_TAB+"EP"+<>va_TAB+"MI"+<>va_TAB+"TOTAL"+<>va_TAB+"Distribué"+<>va_TAB+"Restant"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				If ((t_CT_Total{$ii}+t_CT_Dis{$ii}+t_CT_Rest{$ii})>0)
					$vt_Texte:=ta_Centre{$ii}+<>va_TAB+String:C10(t_CT_SHom{$ii})+<>va_TAB+String:C10(t_CT_CHom{$ii})+<>va_TAB+String:C10(t_CT_EHom{$ii})+<>va_TAB+String:C10(t_CT_FHom{$ii})+<>va_TAB+String:C10(t_CT_SFem{$ii})+<>va_TAB+String:C10(t_CT_CFem{$ii})+<>va_TAB+String:C10(t_CT_EFem{$ii})+<>va_TAB+String:C10(t_CT_FFem{$ii})+<>va_TAB+String:C10(t_CT_PMin{$ii})+<>va_TAB+String:C10(t_CT_MMin{$ii})+<>va_TAB+String:C10(t_CT_Total{$ii})+<>va_TAB+String:C10(t_CT_Dis{$ii})+<>va_TAB+String:C10(t_CT_Rest{$ii})+<>va_CR
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_CT_SHom)+<>va_TAB+String:C10(vl_CT_CHom)+<>va_TAB+String:C10(vl_CT_EHom)+<>va_TAB+String:C10(vl_CT_FHom)+<>va_TAB+String:C10(vl_CT_SFem)+<>va_TAB+String:C10(vl_CT_CFem)+<>va_TAB+String:C10(vl_CT_EFem)+<>va_TAB+String:C10(vl_CT_FFem)+<>va_TAB+String:C10(vl_CT_PMin)+<>va_TAB+String:C10(vl_CT_MMin)+<>va_TAB+String:C10(vl_CT_Total)+<>va_TAB+String:C10(vl_CT_Dis)+<>va_TAB+String:C10(vl_CT_Rest)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(<>ta_TBOr1)
		If ($vl_TailTab>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{48}+<>va_TAB+"TOTAL"+<>va_TAB+"Pourcentage"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=<>ta_TBOr1{$ii}+<>va_TAB+String:C10(t_OR1_Total{$ii})+<>va_TAB+String:C10(t_OR1_Pc{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_OR1_Tot)+<>va_TAB+String:C10(vr_OR1_Pc)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(<>ta_TBOr2)
		If ($vl_TailTab>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{49}+<>va_TAB+"TOTAL"+<>va_TAB+"Pourcentage"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=<>ta_TBOr2{$ii}+<>va_TAB+String:C10(t_OR2_Total{$ii})+<>va_TAB+String:C10(t_OR2_Pc{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_OR2_Tot)+<>va_TAB+String:C10(vr_OR2_Pc)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(<>ta_AtS)
		If ($vl_TailTab>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}+<>va_TAB+"TOTAL"+<>va_TAB+"Pourcentage"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=<>ta_AtS{$ii}+<>va_TAB+String:C10(t_AtS_Total{$ii})+<>va_TAB+String:C10(t_AtS_Pc{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_AtS_Tot)+<>va_TAB+String:C10(vr_AtS_Pc)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(<>ta_TBMaraud)
		If ($vl_TailTab>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{19}+<>va_TAB+"TOTAL"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=<>ta_TBMaraud{$ii}+<>va_TAB+String:C10(t_TBMarTot{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_Mar_Tot)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(ta_DemP)
		If ($vl_TailTab>0)
			$vt_Texte:="Demande de prestations"+<>va_TAB+"Nombre"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=ta_DemP{$ii}+<>va_TAB+String:C10(tl_DemPt{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_DP_Dem)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(ta_AdUtil)
		If ($vl_TailTab>0)
			$vt_Texte:="Adresses utiles"+<>va_TAB+"Nombre"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=ta_AdUtil{$ii}+<>va_TAB+String:C10(tl_AdUPt{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_AU_Dem)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(ta_SitPar)
		If ($vl_TailTab>0)
			$vt_Texte:="Situations particulières"+<>va_TAB+"Nombre"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=ta_SitPar{$ii}+<>va_TAB+String:C10(tl_SitPt{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_SP_Dem)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		$vl_TailTab:=Size of array:C274(ta_PrestDem)
		If ($vl_TailTab>0)
			$vt_Texte:="Appels"+<>va_TAB+"Nombre"+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=ta_PrestDem{$ii}+<>va_TAB+String:C10(t_Prest{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+<>va_TAB+String:C10(vl_Prest)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
	CLOSE WINDOW:C154
End if 