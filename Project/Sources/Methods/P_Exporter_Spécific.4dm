//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_Spécific
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($vl_TailTab; $ii; $kk; $oo)
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
		
		$vt_Texte:="Statistiques 'SP' du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)
		$vt_Texte:=$vt_Texte+Char:C90(13)
		
		Case of 
			: (rJourNuit1=1) & (rJourNuit2=1)
				$vt_Texte:=$vt_Texte+"Jour et Nuit"
			: (rJourNuit1=1) & (rJourNuit2=0)
				$vt_Texte:=$vt_Texte+"Jour"
			: (rJourNuit1=0) & (rJourNuit2=1)
				$vt_Texte:=$vt_Texte+"Nuit"
		End case 
		
		$vt_Texte:=$vt_Texte+Char:C90(9)
		$vt_Texte:=$vt_Texte+("Avec report"*Num:C11(rReport=1))+("Sans Report"*Num:C11(rReport=0))
		$vt_Texte:=$vt_Texte+Char:C90(13)
		$vt_Texte:=$vt_Texte+"Statut : "+("Clôturés"*w1)+("Tous"*w2)+"   "+("Avec les inconnus"*u1)+("Sans les inconnus"*u2)
		$vt_Texte:=$vt_Texte+Char:C90(13)+Char:C90(13)
		
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		If (Size of array:C274(ta_xCentre)>0)
			$oo:=0
			For ($kk; 1; Size of array:C274(ta_xCentre))
				If (te_xCentre{$kk}=1)
					$oo:=$oo+1
				End if 
			End for 
			If (($oo=0) | ($oo>=Size of array:C274(ta_xCentre)))
				$vt_Texte:="Centres : tous"+Char:C90(13)+Char:C90(13)
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
			Else 
				$vt_Texte:="Centres : "
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
				For ($kk; 1; Size of array:C274(ta_xCentre))
					If (te_xCentre{$kk}=1)
						$vt_Texte:=Char:C90(9)+ta_xCentre{$kk}+Char:C90(13)
						If (<>vb_CestUnMac)
							SEND PACKET:C103($h_RefDoc; $vt_Texte)
						Else 
							SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
						End if 
					End if 
				End for 
			End if 
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
		
		If (w1=1)  //Que les fiches cloturées
			$vt_Texte:="Demandes approuvées"
		Else 
			$vt_Texte:="Toutes les demandes"
		End if 
		$vt_Texte:=$vt_Texte+Char:C90(9)+String:C10(vl_NbHB)+Char:C90(13)
		$vt_Texte:=$vt_Texte+"Nombre de personnes"+Char:C90(9)+String:C10(vl_NbHBd)+Char:C90(13)
		$vt_Texte:=$vt_Texte+Char:C90(13)
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
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
				$vt_Texte:=Uppercase:C13(ta_Rub1{0})+Char:C90(13)+Char:C90(13)
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
				
				For ($ii; 1; $vl_TailTab)
					If (te_Sel1{$ii}=1)
						$vt_Texte:=ta_iT1{$ii}+Char:C90(9)+String:C10(tl_Nb1{$ii})+Char:C90(9)+String:C10(tl_Nb1_1{$ii})+Char:C90(13)
						If (<>vb_CestUnMac)
							SEND PACKET:C103($h_RefDoc; $vt_Texte)
						Else 
							SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
						End if 
						
					End if 
				End for 
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; Char:C90(13))
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
				End if 
			End if 
		End if 
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		If ($vb_OK1)
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
					$vt_Texte:=Uppercase:C13(ta_Rub2{0})+Char:C90(13)+Char:C90(13)
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
					
					For ($ii; 1; $vl_TailTab)
						If (te_Sel2{$ii}=1)
							$vt_Texte:=ta_iT2{$ii}+Char:C90(9)+String:C10(tl_Nb2{$ii})+Char:C90(9)+String:C10(tl_Nb2_2{$ii})+Char:C90(13)
							If (<>vb_CestUnMac)
								SEND PACKET:C103($h_RefDoc; $vt_Texte)
							Else 
								SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
							End if 
						End if 
					End for 
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; Char:C90(13))
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
					End if 
				End if 
			End if 
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; Char:C90(13))
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
			End if 
		End if 
		
		If ($vb_OK2)
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
					$vt_Texte:=Uppercase:C13(ta_Rub3{0})+Char:C90(13)+Char:C90(13)
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
					
					For ($ii; 1; $vl_TailTab)
						If (te_Sel3{$ii}=1)
							$vt_Texte:=ta_iT3{$ii}+Char:C90(9)+String:C10(tl_Nb3{$ii})+Char:C90(9)+String:C10(tl_Nb3_3{$ii})+Char:C90(13)
							If (<>vb_CestUnMac)
								SEND PACKET:C103($h_RefDoc; $vt_Texte)
							Else 
								SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
							End if 
						End if 
					End for 
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; Char:C90(13))
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
					End if 
				End if 
			End if 
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; Char:C90(13))
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
			End if 
		End if 
		
		If ($vb_OK3)
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
					$vt_Texte:=Uppercase:C13(ta_Rub4{0})+Char:C90(13)+Char:C90(13)
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
					
					For ($ii; 1; $vl_TailTab)
						If (te_Sel4{$ii}=1)
							$vt_Texte:=ta_iT4{$ii}+Char:C90(9)+String:C10(tl_Nb4{$ii})+Char:C90(9)+String:C10(tl_Nb4_4{$ii})+Char:C90(13)
							If (<>vb_CestUnMac)
								SEND PACKET:C103($h_RefDoc; $vt_Texte)
							Else 
								SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
							End if 
						End if 
					End for 
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; Char:C90(13))
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
					End if 
				End if 
			End if 
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
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
	CLOSE WINDOW:C154
End if 
