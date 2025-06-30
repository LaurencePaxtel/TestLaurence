//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_Direction2
//{
//{          Vendredi 25 Juin 2004 à 14:53:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($vl_TailTab; $ii; $jj; $kk)

ARRAY LONGINT:C221($tl_PopCT_DateJ; 0; 0)
ARRAY LONGINT:C221($tl_PopCT_DateN; 0; 0)
ARRAY LONGINT:C221($tl_PopCT_DateT; 0; 0)

C_LONGINT:C283($ve_NbCol)
C_TEXT:C284($vt_Temp)

CONFIRM:C162("Exporter les statistiques en mode texte sur disque."+Char:C90(13)+"Confirmez-vous ?")
If (OK=1)
	i_Message("Export en cours …")
	C_TIME:C306($h_RefDoc)
	C_TEXT:C284($vt_Temp)
	C_LONGINT:C283($ve_NbCol)
	$vt_Temp:=""
	$h_RefDoc:=?00:00:00?
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$vt_Texte:="Statistiques du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)+<>va_CR
		
		If (Size of array:C274(ta_xGroupe)>0)
			$oo:=0
			For ($kk; 1; Size of array:C274(ta_xGroupe))
				If (te_xGroupe{$kk}=1)
					$oo:=$oo+1
				End if 
			End for 
			If (($oo>0) & ($oo<Size of array:C274(ta_xGroupe)))
				$vt_Texte:=$vt_Texte+"Groupes : "+<>va_TAB
				For ($kk; 1; Size of array:C274(ta_xGroupe))
					If (te_xGroupe{$kk}=1)
						$vt_Texte:=$vt_Texte+ta_xGroupe{$ii}
					End if 
				End for 
			Else 
				$vt_Texte:=$vt_Texte+"Tous les groupes"
			End if 
			$vt_Texte:=$vt_Texte+<>va_CR
		End if 
		
		$vt_Texte:=$vt_Texte+"Nombre de demandes"+<>va_TAB+String:C10(<>tl_PopCT_DrTDem{0})+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de demandes pour un nombre de personnes"+<>va_TAB+String:C10(<>tl_PopCT_DrTPers{0})+<>va_CR
		
		$vt_Texte:=$vt_Texte+"Nombre d'hébergements"+<>va_TAB+String:C10(<>tl_PopCT_DrTHg{0})+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre d'hébergements pour un nombre de personne"+<>va_TAB+String:C10(<>tl_PopCT_DrTHgé{0})+<>va_CR+<>va_CR
		
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		
		//Tableau du Nombre d'orientations par personne
		$vt_Texte:=""
		$vl_TailTab:=Size of array:C274(<>tl_PopCT_OrT{0})
		If ($vl_TailTab>0)
			$vt_Texte:="Nombre d'orientations par personne"+<>va_CR
			$vt_Texte:=$vt_Texte+<>va_TAB+"Nombre de personnes"+<>va_TAB+"Nombre d'orientations"+<>va_CR
			For ($ii; 1; $vl_TailTab)
				$vt_Texte:=$vt_Texte+<>va_TAB+String:C10(<>tl_PopCT_OrNb{0}{$ii})+<>va_TAB+String:C10(<>tl_PopCT_OrT{0}{$ii})+<>va_CR
			End for 
			$vt_Texte:=$vt_Texte+<>va_CR
		End if 
		$vt_Texte:=$vt_Texte+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		//Fin 1
		
		//Les titres
		$vt_Texte:=""
		$vl_TailTab:=Size of array:C274(<>ta_PopCT_Centre)
		If ($vl_TailTab>0)
			$ve_NbCol:=(1*Num:C11((e1=1) | (e2=1) | (e4=1)))+(2*Num:C11((e3=1)))+(3*Num:C11((e5=1)))
			$vt_Temp:="J"
			$vt_Texte:="Centre"
			Case of 
				: ($ve_NbCol=1)
					$vt_Temp:=("J"*Num:C11(e1=1))+("N"*Num:C11(e2=1))+("T"*Num:C11(e4=1))
					For ($ii; 1; Size of array:C274(<>td_PopCT_Date))
						$vt_Texte:=$vt_Texte+<>va_TAB+String:C10(<>td_PopCT_Date{$ii}; Interne date court:K1:7)
					End for 
					$vt_Texte:=$vt_Texte+<>va_TAB+"TT"
				: ($ve_NbCol=2)
					$vt_Temp:="J"+<>va_TAB+"N"
					For ($ii; 1; Size of array:C274(<>td_PopCT_Date))
						$vt_Texte:=$vt_Texte+<>va_TAB+String:C10(<>td_PopCT_Date{$ii}; Interne date court:K1:7)+<>va_TAB+String:C10(<>td_PopCT_Date{$ii}; Interne date court:K1:7)
					End for 
					$vt_Texte:=$vt_Texte+<>va_TAB+"TT J"+<>va_TAB+"TT N"
				: ($ve_NbCol=3)
					$vt_Temp:="J"+<>va_TAB+"N"+<>va_TAB+"T"
					For ($ii; 1; Size of array:C274(<>td_PopCT_Date))
						$vt_Texte:=$vt_Texte+<>va_TAB+String:C10(<>td_PopCT_Date{$ii}; Interne date court:K1:7)+<>va_TAB+String:C10(<>td_PopCT_Date{$ii}; Interne date court:K1:7)+<>va_TAB+String:C10(<>td_PopCT_Date{$ii}; Interne date court:K1:7)
					End for 
					$vt_Texte:=$vt_Texte+<>va_TAB+"TT J"+<>va_TAB+"TT N"+<>va_TAB+"TT T"
			End case 
			$vt_Texte:=$vt_Texte+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
			
			$vt_Texte:=""
			For ($ii; 1; Size of array:C274(<>td_PopCT_Date))
				$vt_Texte:=$vt_Texte+<>va_TAB+$vt_Temp
			End for 
			$vt_Texte:=$vt_Texte+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		//Les lignes Centre
		$vt_Texte:=""
		$vl_TailTab:=Size of array:C274(<>ta_PopCT_Centre)
		If ($vl_TailTab>0)
			For ($ii; 1; Size of array:C274(<>ta_PopCT_Centre))
				$vt_Texte:=$vt_Texte+<>ta_PopCT_Centre{$ii}+<>va_TAB
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
				
				If (Size of array:C274(<>td_PopCT_DrDt{$ii})>0)
					
					$vl_TJ:=0
					$vl_TN:=0
					$vl_TT:=0
					$kk:=Size of array:C274(<>td_PopCT_Date)
					ARRAY LONGINT:C221($tl_PopCT_DateJ; $kk; 1)
					ARRAY LONGINT:C221($tl_PopCT_DateN; $kk; 1)
					ARRAY LONGINT:C221($tl_PopCT_DateT; $kk; 1)
					For ($jj; 1; $kk)
						$tl_PopCT_DateJ{$jj}{1}:=0
						$tl_PopCT_DateN{$jj}{1}:=0
						$tl_PopCT_DateT{$jj}{1}:=0
					End for 
					
					For ($jj; 1; Size of array:C274(<>td_PopCT_DrDt{$ii}))
						$kk:=Find in array:C230(<>td_PopCT_Date; <>td_PopCT_DrDt{$ii}{$jj})
						If ($kk>0)
							$tl_PopCT_DateJ{$kk}{1}:=<>tl_PopCT_DrOjJ{$ii}{$jj}
							$tl_PopCT_DateN{$kk}{1}:=<>tl_PopCT_DrOjN{$ii}{$jj}
							$tl_PopCT_DateT{$kk}{1}:=<>tl_PopCT_DrOjT{$ii}{$jj}
							
							$vl_TJ:=$vl_TJ+<>tl_PopCT_DrOjJ{$ii}{$jj}
							$vl_TN:=$vl_TN+<>tl_PopCT_DrOjN{$ii}{$jj}
							$vl_TT:=$vl_TT+<>tl_PopCT_DrOjT{$ii}{$jj}
						End if 
					End for 
					$vt_Texte:=""
					For ($jj; 1; Size of array:C274(<>td_PopCT_Date))
						Case of 
							: (e1=1)
								$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateJ{$jj}{1})+<>va_TAB
							: (e2=1)
								$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateN{$jj}{1})+<>va_TAB
							: (e3=1)
								$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateJ{$jj}{1})+<>va_TAB+String:C10($tl_PopCT_DateN{$jj}{1})+<>va_TAB
							: (e4=1)
								$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateT{$jj}{1})+<>va_TAB
							: (e5=1)
								$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateJ{$jj}{1})+<>va_TAB+String:C10($tl_PopCT_DateN{$jj}{1})+<>va_TAB+String:C10($tl_PopCT_DateT{$jj}{1})+<>va_TAB
						End case 
					End for 
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; $vt_Texte)
					Else 
						SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
					End if 
					$vt_Texte:=""
					Case of 
						: (e1=1)
							$vt_Texte:=$vt_Texte+String:C10($vl_TJ)+<>va_TAB
						: (e2=1)
							$vt_Texte:=$vt_Texte+String:C10($vl_TN)+<>va_TAB
						: (e3=1)
							$vt_Texte:=$vt_Texte+String:C10($vl_TJ)+<>va_TAB+String:C10($vl_TN)+<>va_TAB
						: (e4=1)
							$vt_Texte:=$vt_Texte+String:C10($vl_TT)+<>va_TAB
						: (e5=1)
							$vt_Texte:=$vt_Texte+String:C10($vl_TJ)+<>va_TAB+String:C10($vl_TN)+<>va_TAB+String:C10($vl_TT)+<>va_TAB
					End case 
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
			End for 
			
			
			$vt_Texte:=<>va_CR+"TOTAUX"+<>va_TAB
			$vl_TJ:=0
			$vl_TN:=0
			$vl_TT:=0
			$kk:=Size of array:C274(<>td_PopCT_Date)
			ARRAY LONGINT:C221($tl_PopCT_DateJ; $kk; 1)
			ARRAY LONGINT:C221($tl_PopCT_DateN; $kk; 1)
			ARRAY LONGINT:C221($tl_PopCT_DateT; $kk; 1)
			For ($jj; 1; $kk)
				$tl_PopCT_DateJ{$kk}{1}:=0
				$tl_PopCT_DateN{$kk}{1}:=0
				$tl_PopCT_DateT{$kk}{1}:=0
			End for 
			For ($jj; 1; Size of array:C274(<>td_PopCT_DrDt{0}))
				$kk:=Find in array:C230(<>td_PopCT_Date; <>td_PopCT_DrDt{0}{$jj})
				If ($kk>0)
					$tl_PopCT_DateJ{$kk}{1}:=<>tl_PopCT_DrOjJ{0}{$jj}
					$tl_PopCT_DateN{$kk}{1}:=<>tl_PopCT_DrOjN{0}{$jj}
					$tl_PopCT_DateT{$kk}{1}:=<>tl_PopCT_DrOjT{0}{$jj}
					
					$vl_TJ:=$vl_TJ+<>tl_PopCT_DrOjJ{0}{$jj}
					$vl_TN:=$vl_TN+<>tl_PopCT_DrOjN{0}{$jj}
					$vl_TT:=$vl_TT+<>tl_PopCT_DrOjT{0}{$jj}
				End if 
			End for 
			
			For ($jj; 1; Size of array:C274(<>td_PopCT_Date))
				Case of 
					: (e1=1)
						$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateJ{$jj}{1})+<>va_TAB
					: (e2=1)
						$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateN{$jj}{1})+<>va_TAB
					: (e3=1)
						$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateJ{$jj}{1})+<>va_TAB+String:C10($tl_PopCT_DateN{$jj}{1})+<>va_TAB
					: (e4=1)
						$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateT{$jj}{1})+<>va_TAB
					: (e5=1)
						$vt_Texte:=$vt_Texte+String:C10($tl_PopCT_DateJ{$jj}{1})+<>va_TAB+String:C10($tl_PopCT_DateN{$jj}{1})+<>va_TAB+String:C10($tl_PopCT_DateT{$jj}{1})+<>va_TAB
				End case 
			End for 
			
			Case of 
				: (e1=1)
					$vt_Texte:=$vt_Texte+String:C10($vl_TJ)+<>va_TAB
				: (e2=1)
					$vt_Texte:=$vt_Texte+String:C10($vl_TN)+<>va_TAB
				: (e3=1)
					$vt_Texte:=$vt_Texte+String:C10($vl_TJ)+<>va_TAB+String:C10($vl_TN)+<>va_TAB
				: (e4=1)
					$vt_Texte:=$vt_Texte+String:C10($vl_TT)+<>va_TAB
				: (e5=1)
					$vt_Texte:=$vt_Texte+String:C10($vl_TJ)+<>va_TAB+String:C10($vl_TN)+<>va_TAB+String:C10($vl_TT)+<>va_TAB
			End case 
			$vt_Texte:=$vt_Texte+<>va_CR
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		
		//Fin  Fin
		
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
