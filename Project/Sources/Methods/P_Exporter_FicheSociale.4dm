//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_FicheSociale
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
		
		$vt_Texte:="Statistiques fiches sociales du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)+" : "+String:C10(vl_NbJ)+" jour(s)"+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de fiches"+<>va_TAB+"Masculin"+<>va_TAB+"Féminin"+<>va_CR
		$vt_Texte:=$vt_Texte+String:C10(vl_NbHB)+<>va_TAB+String:C10(vl_NbHBm)+<>va_TAB+String:C10(vl_NbHBf)+<>va_CR+<>va_CR
		
		$vt_Texte:=$vt_Texte+"Nombre de personnes"+<>va_TAB+"Masculin"+<>va_TAB+"Féminin"+<>va_CR
		$vt_Texte:=$vt_Texte+String:C10(vl_NbHBd)+<>va_TAB+String:C10(vl_NbHBdm)+<>va_TAB+String:C10(vl_NbHBdf)+<>va_CR+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		//Prise en charge EMA
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRPch; ->vl_MRPch; ->vl_MRPch_e; ->vl_MRPch_p; ->t_MRPch_e; ->t_MRPch_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{35})
		
		
		//Dernier lieu d'hébergement
		P_Exporter_StatType2($h_RefDoc; -><>ta_DerLH; ->vl_DerLH; ->vl_DerLH_e; ->vl_MRPch_p; ->t_DerLH_e; ->t_DerLH_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{37})
		
		//Personne chez qui aller
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRQui; ->vl_MRQui; ->vl_MRQui_e; ->vl_MRQui_p; ->t_MRQui_e; ->t_MRQui_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{43})
		
		//Motif de refus
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRrefu; ->vl_MRrefu; ->vl_MRrefu_e; ->vl_MRrefu_p; ->t_MRrefu_e; ->t_MRrefu_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{36})
		
		//Quel mode
		P_Exporter_StatType2($h_RefDoc; -><>ta_Qmod; ->vl_Qmod; ->vl_Qmod_e; ->vl_Qmod_p; ->t_Qmod_e; ->t_Qmod_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{40})
		
		//Temps d'errance
		P_Exporter_StatType2($h_RefDoc; -><>ta_TBTpsErr; ->vl_ter; ->vl_ter_e; ->vl_ter_p; ->t_ter_e; ->t_ter_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{42})
		
		//Compagnie actuelle
		P_Exporter_StatType2($h_RefDoc; -><>ta_CpAct; ->vl_CpAct; ->vl_CpAct_e; ->vl_CpAct_p; ->t_CpAct_e; ->t_CpAct_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{44})
		
		//Quel papier
		P_Exporter_StatType2($h_RefDoc; -><>ta_TBPIdté; ->vl_Idté; ->vl_Idté_e; ->vl_Idté_p; ->t_Idté_e; ->t_Idté_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{56})
		
		//Quel régime
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRrg; ->vl_MRrg; ->vl_MRrg_e; ->vl_MRrg_p; ->t_MRrg_e; ->t_MRrg_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{68})
		
		//Quel suivi
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRss; ->vl_MRss; ->vl_MRss_e; ->vl_MRss_p; ->t_MRss_e; ->t_MRss_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{72})
		
		//Quelle couverture 1
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRcs; ->vl_Rcs1; ->vl_Rcs1_e; ->vl_Rcs1_p; ->t_Rcs1_e; ->t_Rcs1_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{48})
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRcs; ->vl_Rcs2; ->vl_Rcs2_e; ->vl_Rcs2_p; ->t_Rcs2_e; ->t_Rcs2_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{50})
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRcs; ->vl_Rcs3; ->vl_Rcs3_e; ->vl_Rcs3_p; ->t_Rcs3_e; ->t_Rcs3_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{51})
		
		//Quelle ressources 1
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRrs; ->vl_Rrs1; ->vl_Rrs1_e; ->vl_Rrs1_p; ->t_Rrs1_e; ->t_Rrs1_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{60})
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRrs; ->vl_Rrs2; ->vl_Rrs2_e; ->vl_Rrs2_p; ->t_Rrs2_e; ->t_Rrs2_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{62})
		P_Exporter_StatType2($h_RefDoc; -><>ta_MRrs; ->vl_Rrs3; ->vl_Rrs3_e; ->vl_Rrs3_p; ->t_Rrs3_e; ->t_Rrs3_p; <>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{64})
		
		
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
			$vt_Texte:=<>va_CR+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		USE SET:C118("E_encours")
		
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