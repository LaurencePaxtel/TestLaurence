//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_CHRS
//{
//{          Lundi 6 février 2009 à 14:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($ii)

CONFIRM:C162("Exporter les statistiques CHRS en mode texte sur disque."+Char:C90(13)+"Confirmez-vous ?")
If (OK=1)
	i_Message("Export en cours …")
	C_TIME:C306($h_RefDoc)
	$h_RefDoc:=?00:00:00?
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$vt_Texte:="Statistiques CHRS du "+String:C10(vd_Date1; 4)
		$vt_Texte:=$vt_Texte+Char:C90(13)
		$vt_Texte:=$vt_Texte+""
		$vt_Texte:=$vt_Texte+Char:C90(13)
		$vt_Texte:=$vt_Texte+Char:C90(13)
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		vl_Tab1:=Size of array:C274(ta_ET_EtcivGroupe)
		If (vl_Tab1>0)
			$vt_Texte:="Hébergements"+Char:C90(9)+"Demande"+Char:C90(9)+"%Demande"+Char:C90(9)+"Distribués"+Char:C90(9)+"%Distribués"+Char:C90(9)+"En attente"+Char:C90(9)+"% En attente"
			$vt_Texte:=$vt_Texte+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_Tab1)
				$vt_Texte:=ta_ET_EtcivGroupe{$ii}+Char:C90(9)+String:C10(tl_ET_Dem{$ii})+Char:C90(9)+String:C10(tr_ET_DemPc{$ii})+Char:C90(9)+String:C10(tl_ET_Dis{$ii})+Char:C90(9)+String:C10(tr_ET_DisPc{$ii})+Char:C90(9)+String:C10(tl_ET_Med{$ii})+Char:C90(9)+String:C10(tr_ET_MedPc{$ii})
				$vt_Texte:=$vt_Texte+Char:C90(13)
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			End for 
			$vt_Texte:="TOTAUX"+Char:C90(9)+String:C10(vl_ET_Dem)+Char:C90(9)+String:C10(vr_ET_DemPc)+Char:C90(9)+String:C10(vl_ET_Dis)+Char:C90(9)+String:C10(vr_ET_DisPc)+Char:C90(9)+String:C10(vl_ET_Med)+Char:C90(9)+String:C10(vr_ET_MedPc)
			$vt_Texte:=$vt_Texte+Char:C90(13)+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		vl_Tab4:=Size of array:C274(ta_xTBSglt)
		If (vl_Tab4>0)
			$vt_Texte:="Signalement"+Char:C90(9)+"Nombre"  //+Caractere(9)+"Hébergements"+Caractere(9)+"Prestations"+Caractere(9)+"Total"
			$vt_Texte:=$vt_Texte+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_Tab4)
				If (tl_xNbSgltJ{$ii}>0)
					$vt_Texte:=ta_xTBSglt{$ii}+Char:C90(9)+String:C10(tl_xNbSgltJ{$ii})  //+Caractere(9)+Chaine(tl_xNbSgltJC{$ii})+Caractere(9)+Chaine(tl_xNbSgltN{$ii})+Ca
					$vt_Texte:=$vt_Texte+Char:C90(13)
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
				End if 
			End for 
			$vt_Texte:="TOTAUX"+Char:C90(9)+String:C10(vl_xNbSgltJ)  //+Caractere(9)+Chaine(vl_xNbSgltJC)+Caractere(9)+Chaine(vl_xNbSgltN)+Caractere(9)
			$vt_Texte:=$vt_Texte+Char:C90(13)+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		vl_Tab5:=Size of array:C274(ta_xTBPIdté)
		If (vl_Tab5>0)
			$vt_Texte:="Pièce d'identité"+Char:C90(9)+"Nombre"  //+Caractere(9)+"Hébergements"+Caractere(9)+"Prestations"+Caractere(9)+"Total"
			$vt_Texte:=$vt_Texte+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_Tab5)
				If (tl_xNbIdtéJ{$ii}>0)
					$vt_Texte:=ta_xTBPIdté{$ii}+Char:C90(9)+String:C10(tl_xNbIdtéJ{$ii})  //+Caractere(9)+Chaine(tl_xNbIdtéJC{$ii})+Caractere(9)+Chaine(tl_xNbIdtéN{$ii})+Ca
					$vt_Texte:=$vt_Texte+Char:C90(13)
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
				End if 
			End for 
			$vt_Texte:="TOTAUX"+Char:C90(9)+String:C10(vl_xNbIdtéJ)  //+Caractere(9)+Chaine(vl_xNbIdtéJC)+Caractere(9)+Chaine(vl_xNbIdtéN)+Caractere(9)
			$vt_Texte:=$vt_Texte+Char:C90(13)+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		
		//Centres
		vl_Tab2:=Size of array:C274(ta_LC_Centre)
		If (vl_Tab2>0)
			$vt_Texte:="C. Hébergement"+Char:C90(9)+"Disponible"+Char:C90(9)+"Distribué"+Char:C90(9)+"Taux d'occupation"
			$vt_Texte:=$vt_Texte+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_Tab2)
				If ((tl_LC_Total{$ii}+tl_LC_Dis{$ii}+tl_LC_Rest{$ii})>0)
					$vt_Texte:=ta_LC_Centre{$ii}+Char:C90(9)+String:C10(tl_LC_Dis{$ii})+Char:C90(9)+String:C10(tl_LC_Total{$ii})+Char:C90(9)+String:C10(tr_LC_TauxOccup{$ii})
					$vt_Texte:=$vt_Texte+Char:C90(13)
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
				End if 
			End for 
			$vt_Texte:="TOTAUX"+Char:C90(9)+String:C10(vl_LC_Dis)+Char:C90(9)+String:C10(vl_LC_Total)+Char:C90(9)+String:C10(vr_LC_TauxOccup)
			$vt_Texte:=$vt_Texte+Char:C90(13)+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		//Prestations
		vl_Tab3:=Size of array:C274(ta_LC_Presta)
		If (vl_Tab3>0)
			$vt_Texte:="Prestations"+Char:C90(9)+"Nombre"
			$vt_Texte:=$vt_Texte+Char:C90(13)+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			For ($ii; 1; vl_Tab3)
				If (tl_LC_PrestaNb{$ii}>0)
					$vt_Texte:=ta_LC_Presta{$ii}+Char:C90(9)+String:C10(tl_LC_PrestaNb{$ii})
					$vt_Texte:=$vt_Texte+Char:C90(13)
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
				End if 
			End for 
			$vt_Texte:="TOTAUX"+Char:C90(9)+String:C10(vl_LC_PrestaNb)
			$vt_Texte:=$vt_Texte+Char:C90(13)+Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
	CLOSE WINDOW:C154
End if 