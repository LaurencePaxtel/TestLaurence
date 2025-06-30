//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_EMA
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
CONFIRM:C162("Exporter les statistiques en mode texte sur disque."+<>va_CR+"Confirmez-vous ?")
If (OK=1)
	i_Message("Export en cours …")
	C_TIME:C306($h_RefDoc)
	$h_RefDoc:=?00:00:00?
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$vt_Texte:="Statistiques du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)+" : "+String:C10(vl_NbJ)+" jour(s)"+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de fiches"+<>va_TAB+"Masculin"+<>va_TAB+"Féminin"+<>va_CR
		$vt_Texte:=$vt_Texte+String:C10(vl_NbHB)+<>va_TAB+String:C10(vl_NbHBm)+<>va_TAB+String:C10(vl_NbHBf)+<>va_CR+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de personnes"+<>va_TAB+"Masculin"+<>va_TAB+"Féminin"+<>va_CR
		$vt_Texte:=$vt_Texte+String:C10(vl_NbHBd)+<>va_TAB+String:C10(vl_NbHBdm)+<>va_TAB+String:C10(vl_NbHBdf)+<>va_CR+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		//Signalement
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{7})
		vl_TabSG:=Size of array:C274(<>ta_TBSglt)
		If (vl_TabSG>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{7}+<>va_CR
			$vt_Texte:=$vt_Texte+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			
			C_LONGINT:C283($ii)
			For ($ii; 1; vl_TabSG)
				$vt_Texte:=<>ta_TBSglt{$ii}+<>va_TAB+String:C10(t_SG_e{$ii})+<>va_TAB+String:C10(t_SG_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{7}+<>va_TAB+String:C10(vl_SG_e)+<>va_TAB+String:C10(vl_SG_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Emplacement
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{9})
		vl_TabPL:=Size of array:C274(<>ta_TBPorte)
		If (vl_TabPL>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{9}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabPL)
				$vt_Texte:=<>ta_TBPorte{$ii}+<>va_TAB+String:C10(t_PL_e{$ii})+<>va_TAB+String:C10(t_PL_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{9}+<>va_TAB+String:C10(vl_PL_e)+<>va_TAB+String:C10(vl_PL_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Arrondissement
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{11})
		vl_TabAR:=Size of array:C274(<>ta_TBArr)
		If (vl_TabAR>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{11}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabAR)
				$vt_Texte:=<>ta_TBArr{$ii}+<>va_TAB+String:C10(t_Ar_e{$ii})+<>va_TAB+String:C10(t_Ar_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{11}+<>va_TAB+String:C10(vl_Ar_e)+<>va_TAB+String:C10(vl_Ar_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Demande
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{14})
		vl_TabDm:=Size of array:C274(<>ta_MRDem)
		If (vl_TabDm>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{14}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabDm)
				$vt_Texte:=<>ta_MRDem{$ii}+<>va_TAB+String:C10(t_Dm_e{$ii})+<>va_TAB+String:C10(t_Dm_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{14}+<>va_TAB+String:C10(vl_Dm_e)+<>va_TAB+String:C10(vl_Dm_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Age
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{21})
		vl_TabAg:=Size of array:C274(<>ta_TBAge)
		If (vl_TabAg>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{21}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabAg)
				$vt_Texte:=<>ta_TBAge{$ii}+<>va_TAB+String:C10(t_Ag_e{$ii})+<>va_TAB+String:C10(t_Ag_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{21}+<>va_TAB+String:C10(vl_Ag_e)+<>va_TAB+String:C10(vl_Ag_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		
		//Debut rencontre
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{12})
		vl_TabHeur:=Size of array:C274(<>ts_Heures)
		If (vl_TabHeur>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{12}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabHeur)
				$vt_Texte:=String:C10(<>ts_Heures{$ii})+<>va_TAB+String:C10(t_Rd_e{$ii})+<>va_TAB+String:C10(t_Rd_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{12}+<>va_TAB+String:C10(vl_Rd_e)+<>va_TAB+String:C10(vl_Rd_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Debut rencontre
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{13})
		vl_TabHeur:=Size of array:C274(<>ts_Heures)
		If (vl_TabHeur>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{13}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabHeur)
				$vt_Texte:=String:C10(<>ts_Heures{$ii})+<>va_TAB+String:C10(t_Rf_e{$ii})+<>va_TAB+String:C10(t_Rf_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{13}+<>va_TAB+String:C10(vl_Rf_e)+<>va_TAB+String:C10(vl_Rf_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Durée rencontre
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{15})
		vl_TabDuré:=Size of array:C274(<>th_Rt)
		If (vl_TabDuré>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{15}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabDuré)
				$vt_Texte:=String:C10(<>th_Rt{$ii})+<>va_TAB+String:C10(t_Rt_e{$ii})+<>va_TAB+String:C10(t_Rt_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{15}+" =  "+String:C10(vh_Rt)+<>va_TAB+String:C10(vl_Rt_e)+<>va_TAB+String:C10(vl_Rt_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Etat général
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{23})
		vl_TabEtG:=Size of array:C274(<>ta_MReGé)
		If (vl_TabEtG>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{23}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabEtG)
				$vt_Texte:=<>ta_MReGé{$ii}+<>va_TAB+String:C10(t_EtG_e{$ii})+<>va_TAB+String:C10(t_EtG_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{23}+<>va_TAB+String:C10(vl_EtG_e)+<>va_TAB+String:C10(vl_EtG_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Etat cutané
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{24})
		vl_TabEtCu:=Size of array:C274(<>ta_MReCu)
		If (vl_TabEtCu>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{24}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabEtCu)
				$vt_Texte:=<>ta_MReCu{$ii}+<>va_TAB+String:C10(t_EtCu_e{$ii})+<>va_TAB+String:C10(t_EtCu_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{24}+<>va_TAB+String:C10(vl_EtCu_e)+<>va_TAB+String:C10(vl_EtCu_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Relation
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{25})
		vl_TabRel:=Size of array:C274(<>ta_MRrel)
		If (vl_TabRel>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{25}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabRel)
				$vt_Texte:=<>ta_MRrel{$ii}+<>va_TAB+String:C10(t_Rel_e{$ii})+<>va_TAB+String:C10(t_Rel_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{25}+<>va_TAB+String:C10(vl_Rel_e)+<>va_TAB+String:C10(vl_Rel_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Orient sociale
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{30})
		vl_TabOSc:=Size of array:C274(<>ta_OrSc)
		If (vl_TabOSc>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{30}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabOSc)
				$vt_Texte:=<>ta_OrSc{$ii}+<>va_TAB+String:C10(t_OSc_e{$ii})+<>va_TAB+String:C10(t_OSc_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{30}+<>va_TAB+String:C10(vl_OSc_e)+<>va_TAB+String:C10(vl_OSc_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		//Orient médicale
		i_MessageSeul("Export en cours  : "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{33})
		vl_TabOMd:=Size of array:C274(<>ta_OrMd)
		If (vl_TabOMd>0)
			$vt_Texte:=<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{33}+<>va_CR+<>va_TAB+"Effectif"+<>va_TAB+"Personnes"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_TabOMd)
				$vt_Texte:=<>ta_OrMd{$ii}+<>va_TAB+String:C10(t_OMd_e{$ii})+<>va_TAB+String:C10(t_OMd_p{$ii})+<>va_CR
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAL "+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{33}+<>va_TAB+String:C10(vl_OMd_e)+<>va_TAB+String:C10(vl_OMd_p)+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		
		//Notes
		
		If (sNbNote=1)
			i_MessageSeul("Export en cours  : Notes")
			$vt_Texte:="NOTES"+<>va_CR+vt_StTexte+<>va_CR+"FIN NOTES"+<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		//Fiches par personnes
		If (sNbOrHB=1)
			USE SET:C118("E_encours")
			SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
			If (Records in selection:C76([Maraude:24])>0)
				
			End if 
			SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			SEND PACKET:C103($h_RefDoc; <>va_CR)
			SEND PACKET:C103($h_RefDoc; <>va_CR)
		End if 
		
		USE SET:C118("E_encours")
		SEND PACKET:C103($h_RefDoc; <>va_CR)
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
	CLOSE WINDOW:C154
End if 