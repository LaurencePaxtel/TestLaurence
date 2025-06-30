//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_Etude
//{
//{          Mercredi 19 Juillet 2001 à 14:02:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
C_TEXT:C284(va_StatCartouche; va_StatCartouche1; va_StatCartouche2; va_StatCartouche3; va_StatCartouche4)
C_TEXT:C284(va_Virgule)
va_Virgule:=","
C_DATE:C307($vd_Date)
C_TIME:C306($vh_Heure)

If (<>vb_StopEven=False:C215)
	$Position:=0
	$ii:=0
	
	ARRAY TEXT:C222(<>ta_TBEtCiv; 0)
	ARRAY LONGINT:C221(<>te_NbEtCiv; 0)
	ARRAY LONGINT:C221(<>tl_NbEtCiv; 0)
	ARRAY INTEGER:C220(<>te_DivEtCiv; 0)
	If (Size of array:C274(ta_FilexEtCiv)>0)
		For ($ii; 1; Size of array:C274(ta_FilexEtCiv))
			$Position:=Find in array:C230(<>ta_TBEtCiv; ta_FileEtCiv{$ii})
			If ($Position<=0)
				$Position:=Size of array:C274(<>ta_TBEtCiv)+1
				INSERT IN ARRAY:C227(<>ta_TBEtCiv; $Position)
				INSERT IN ARRAY:C227(<>te_NbEtCiv; $Position)
				INSERT IN ARRAY:C227(<>tl_NbEtCiv; $Position)
				INSERT IN ARRAY:C227(<>te_DivEtCiv; $Position)
				<>ta_TBEtCiv{$Position}:=ta_FileEtCiv{$ii}
				<>te_NbEtCiv{$Position}:=0
				<>tl_NbEtCiv{$Position}:=0
				<>te_DivEtCiv{$Position}:=te_FileEtCivDiv{$ii}
			End if 
			<>te_NbEtCiv{$Position}:=<>te_NbEtCiv{$Position}+te_FileEtCivNb{$ii}
			<>tl_NbEtCiv{$Position}:=<>tl_NbEtCiv{$Position}+tl_FileEtCivNb{$ii}
		End for 
		For ($ii; 1; Size of array:C274(<>ta_TBEtCiv))
			If (<>te_DivEtCiv{$ii}>1)
				<>te_NbEtCiv{$ii}:=<>te_NbEtCiv{$ii}\<>te_DivEtCiv{$ii}
				<>tl_NbEtCiv{$ii}:=<>tl_NbEtCiv{$ii}\<>te_DivEtCiv{$ii}
			End if 
		End for 
	End if 
	vl_Tab1:=Size of array:C274(<>ta_TBEtCiv)
	
	
	
	C_LONGINT:C283($ii)
	C_TIME:C306($h_RefDoc)
	$h_RefDoc:=?00:00:00?
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$vd_Date:=Current date:C33
		$vh_Heure:=Current time:C178
		va_StatCartouche1:="Statistiques Etude"
		va_StatCartouche2:=String:C10(Year of:C25($vd_Date); "0000")+String:C10(Month of:C24($vd_Date); "00")+String:C10(Day of:C23($vd_Date); "00")
		va_StatCartouche3:=String:C10(($vh_Heure\3600); "00")
		va_StatCartouche3:=va_StatCartouche3+String:C10((($vh_Heure\60)%60); "00")
		va_StatCartouche3:=va_StatCartouche3+String:C10(($vh_Heure%60); "00")
		va_StatCartouche4:="Du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)
		
		$vt_Texte:="Statut : "+("Clôturés"*w1)+("Tous"*w2)+("Non clôturés"*w3)+"   "+("Avec les inconnus"*u1)+("Sans les inconnus"*u2)
		
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+$vt_Texte+Char:C90(34)+va_Virgule+Char:C90(34)+"Statut"+Char:C90(34)+va_Virgule+"0"+va_Virgule+"0"+<>va_CR)
		Else 
			SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463($vt_Texte)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Statut")+Char:C90(34)+va_Virgule+_O_Mac to Win:C463("0")+va_Virgule+_O_Mac to Win:C463("0"+<>va_CR))
		End if 
		
		If (Size of array:C274(ta_xGroupe)>0)
			$oo:=0
			For ($kk; 1; Size of array:C274(ta_xGroupe))
				If (te_xGroupe{$kk}=1)
					$oo:=$oo+1
				End if 
			End for 
			If (($oo=0) | ($oo>=Size of array:C274(ta_xGroupe)))
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+"Groupes"+Char:C90(34)+va_Virgule+Char:C90(34)+"tous"+Char:C90(34)+va_Virgule+"0"+va_Virgule+"0"+<>va_CR)
				Else 
					SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Groupes")+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("tous")+Char:C90(34)+va_Virgule+_O_Mac to Win:C463("0")+va_Virgule+_O_Mac to Win:C463("0"+<>va_CR))
				End if 
			Else 
				For ($kk; 1; Size of array:C274(ta_xGroupe))
					If (te_xGroupe{$kk}=1)
						If (<>vb_CestUnMac)
							SEND PACKET:C103($h_RefDoc; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+"Groupes"+Char:C90(34)+va_Virgule+Char:C90(34)+ta_xGroupe{$kk}+Char:C90(34)+va_Virgule+"0"+va_Virgule+"0"+<>va_CR)
						Else 
							SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Groupes")+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(ta_xGroupe{$kk})+Char:C90(34)+va_Virgule+_O_Mac to Win:C463("0")+va_Virgule+_O_Mac to Win:C463("0"+<>va_CR))
						End if 
					End if 
				End for 
			End if 
		End if 
		
		If (Size of array:C274(ta_FuseEtCiv)>0)
			$oo:=0
			For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
				If (te_FuseEtCivCheck{$kk}=1)
					$oo:=$oo+1
				End if 
			End for 
			If (($oo=0) | ($oo>=Size of array:C274(ta_FuseEtCiv)))
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+"Etat civil"+Char:C90(34)+va_Virgule+Char:C90(34)+"tous"+Char:C90(34)+va_Virgule+"0"+va_Virgule+"0"+<>va_CR)
				Else 
					SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Etat civil")+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("tous")+Char:C90(34)+va_Virgule+_O_Mac to Win:C463("0")+va_Virgule+_O_Mac to Win:C463("0"+<>va_CR))
				End if 
			Else 
				For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
					If (te_FuseEtCivCheck{$kk}=1)
						If (<>vb_CestUnMac)
							SEND PACKET:C103($h_RefDoc; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+"Etat civil"+Char:C90(34)+va_Virgule+Char:C90(34)+ta_FuseEtCiv{$kk}+Char:C90(34)+va_Virgule+"0"+va_Virgule+"0"+<>va_CR)
						Else 
							SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Etat civil")+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(ta_FuseEtCiv{$kk})+Char:C90(34)+va_Virgule+_O_Mac to Win:C463("0")+va_Virgule+_O_Mac to Win:C463("0"+<>va_CR))
						End if 
					End if 
				End for 
			End if 
		End if 
		
		
		If (Size of array:C274(ta_xCentre)>0)
			$oo:=0
			For ($kk; 1; Size of array:C274(ta_xCentre))
				If (te_xCentre{$kk}=1)
					$oo:=$oo+1
				End if 
			End for 
			If (($oo=0) | ($oo>=Size of array:C274(ta_xCentre)))
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+"Centres"+Char:C90(34)+va_Virgule+Char:C90(34)+"tous"+Char:C90(34)+va_Virgule+"0"+va_Virgule+"0"+<>va_CR)
				Else 
					SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Centres")+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("tous")+Char:C90(34)+va_Virgule+_O_Mac to Win:C463("0")+va_Virgule+_O_Mac to Win:C463("0"+<>va_CR))
				End if 
			Else 
				$vt_Texte:="Centres : "
				For ($kk; 1; Size of array:C274(ta_xCentre))
					If (te_xCentre{$kk}=1)
						If (<>vb_CestUnMac)
							SEND PACKET:C103($h_RefDoc; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+"Centres"+Char:C90(34)+va_Virgule+Char:C90(34)+ta_xCentre{$kk}+Char:C90(34)+va_Virgule+"0"+va_Virgule+"0"+<>va_CR)
						Else 
							SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Centres")+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(ta_xCentre{$kk})+Char:C90(34)+va_Virgule+_O_Mac to Win:C463("0")+va_Virgule+_O_Mac to Win:C463("0"+<>va_CR))
						End if 
					End if 
				End for 
			End if 
		End if 
		
		
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+"Cumul"+Char:C90(34)+va_Virgule+Char:C90(34)+"Demandes/Personnes"+Char:C90(34)+va_Virgule+String:C10(vl_NbHB)+va_Virgule+String:C10(vl_NbHBd)+<>va_CR)
		Else 
			SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Cumul")+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Demandes/Personnes")+Char:C90(34)+va_Virgule+_O_Mac to Win:C463(String:C10(vl_NbHB))+va_Virgule+_O_Mac to Win:C463(String:C10(vl_NbHBd)+<>va_CR))
		End if 
		
		If (sSexe=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par Sexe"; -><>ta_TBGenre; -><>te_NbGenre; -><>tl_TBGenre)
			End if 
		End if 
		
		If (sEtCv=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{40}; -><>ta_TBEtCiv; -><>te_NbEtCiv; -><>tl_NbEtCiv)
			End if 
		End if 
		
		If (sAge=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par Classe d'âge"; -><>ta_TBAge; -><>te_NbAge; -><>tl_NbAge)
			End if 
		End if 
		
		If (sHeure=1)
			If (<>vb_StopEven=False:C215)
				For ($ii; 1; Size of array:C274(<>ts_Heures))
					If (<>vb_CestUnMac)
						SEND PACKET:C103($h_RefDoc; Char:C90(34)+va_StatCartouche1+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche2+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche3+Char:C90(34)+va_Virgule+Char:C90(34)+va_StatCartouche4+Char:C90(34)+va_Virgule+Char:C90(34)+"Répartition par Heure d'appel"+Char:C90(34)+va_Virgule+Char:C90(34)+"Heure d'appel-Heure de clôture"+" "+String:C10(<>ts_Heures{$ii})+Char:C90(34)+va_Virgule+String:C10(<>te_NbHatt{$ii})+va_Virgule+String:C10(<>te_NbHClo{$ii})+<>va_CR)
					Else 
						SEND PACKET:C103($h_RefDoc; Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche1)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche2)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche3)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463(va_StatCartouche4)+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Répartition par Heure d'appel")+Char:C90(34)+va_Virgule+Char:C90(34)+_O_Mac to Win:C463("Heure d'appel-Heure de clôture"+" "+String:C10(<>ts_Heures{$ii}))+Char:C90(34)+va_Virgule+_O_Mac to Win:C463(String:C10(<>te_NbHatt{$ii}))+va_Virgule+_O_Mac to Win:C463(String:C10(<>te_NbHClo{$ii})+<>va_CR))
					End if 
				End for 
			End if 
		End if 
		
		If (sSignal=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{5}; -><>ta_TBSglt; -><>te_NbSglt; -><>tl_NbSglt)
			End if 
		End if 
		
		If (sSitFam=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{13}; -><>ta_TBSitFam; -><>te_NbSitF; -><>tl_NbSitF)
			End if 
		End if 
		
		
		If (sNation=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12}; -><>ta_National; -><>te_NbNatio; -><>tl_NbNatio)
			End if 
		End if 
		
		If (sMéd=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{42}; -><>ta_TBMéd; -><>te_NbMéd; -><>tl_NbMéd)
			End if 
		End if 
		
		If (sErrance=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{14}; -><>ta_TBTpsErr; -><>te_NbErr; -><>tl_NbErr)
			End if 
		End if 
		
		If (sRess=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{31}; -><>ta_TBResAct; -><>te_NbRes; -><>tl_NbRes)
			End if 
		End if 
		
		If (sSuivi=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{34}; -><>ta_TBSuiSoc; -><>te_NbSui; -><>tl_NbSui)
			End if 
		End if 
		
		If (sCouv=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{37}; -><>ta_TBCouSoc; -><>te_NbCou; -><>tl_NbCou)
			End if 
		End if 
		
		If (sOR1=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{48}; -><>ta_TBOr1; -><>te_NbOr1; -><>tl_NbOr1)
			End if 
		End if 
		
		If (sOR2=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{49}; -><>ta_TBOr2; -><>te_NbOr2; -><>tl_NbOr2)
			End if 
		End if 
		
		If (sAutre=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}; -><>ta_AtS; -><>te_NbAtS; -><>tl_NbAtS)
			End if 
		End if 
		
		
		
		If (sGare=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{8}; -><>ta_TBGare; -><>te_NbGare; -><>tl_NbGare)
			End if 
		End if 
		
		If (sVille=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9}; -><>ta_TBMetro; -><>te_NbMetro; -><>tl_NbMetro)
			End if 
		End if 
		
		If (sRupt=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{28}; -><>ta_TBRupMaj; -><>te_TBRupMaj; -><>tl_TBRupMajo)
			End if 
		End if 
		
		
		If (sCP=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7}; -><>ta_TBArr; -><>te_NbArr; -><>tl_NbArr)
			End if 
		End if 
		
		
		If (sDerJob=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{17}; -><>ta_TBDerJob; -><>te_TBDerJob; -><>tl_TBDerJob)
			End if 
		End if 
		
		If (sSitPro=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{16}; -><>ta_TBSitPro; -><>te_TBSitPro; -><>tl_TBSitPro)
			End if 
		End if 
		
		If (sDerHg=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{15}; -><>ta_TBDerHéb; -><>te_TBDerHéb; -><>tl_TBDerHéb)
			End if 
		End if 
		
		If (sLien=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{11}; -><>ta_TBLien; -><>te_TBLien; -><>tl_TBLien)
			End if 
		End if 
		
		If (sPIdté=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25}; -><>ta_TBPIdté; -><>te_TBPIdté; -><>tl_TBPIdté)
			End if 
		End if 
		
		If (sNivEtude=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{41}; -><>ta_TBNivEtu; -><>te_TBNivEtu; -><>tl_TBNivEtu)
			End if 
		End if 
		
		If (sCasSpec=1)
			If (<>vb_StopEven=False:C215)
				P_ExportTroisTablesWind($h_RefDoc; "Répartition par "+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{83}; -><>ta_FMCaS; -><>te_FMCaS; -><>tl_FMCaS)
			End if 
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
End if 
