//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_MaraudeEtude
//{
//{          Mardi 10 mai 2005 à 14:13:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($ii)
C_TIME:C306($h_RefDoc)
C_TEXT:C284($va_Lib)
$va_Lib:="Répartition par "
If (<>vb_StopEven=False:C215)
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
	
	$h_RefDoc:=?00:00:00?
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		
		$vt_Texte:="Statistiques Maraude étude du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)+<>va_CR+<>va_CR
		$vt_Texte:=$vt_Texte+"Statut : "+("Avec les inconnus"*u1)+("Sans les inconnus"*u2)+<>va_CR+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		//Etat civil
		If (Size of array:C274(ta_FuseEtCiv)>0)
			$oo:=0
			For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
				If (te_FuseEtCivCheck{$kk}=1)
					$oo:=$oo+1
				End if 
			End for 
			If (($oo=0) | ($oo>=Size of array:C274(ta_FuseEtCiv)))
				vt_Texte:="Etat civil : tous"+<>va_CR+<>va_CR
			Else 
				vt_Texte:="Etat civil : "
				For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
					If (te_FuseEtCivCheck{$kk}=1)
						$vt_Texte:=$vt_Texte+<>va_TAB+ta_FuseEtCiv{$kk}+<>va_CR
					End if 
				End for 
			End if 
			$vt_Texte:=$vt_Texte+<>va_CR
		End if 
		$vt_Texte:=$vt_Texte+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		//Demandes et personnes et personnes différentes
		$vt_Texte:="Nombre de demandes"+<>va_TAB+String:C10(vl_NbHB)+<>va_CR
		$vt_Texte:=$vt_Texte+"Nombre de personnes"+<>va_TAB+String:C10(vl_NbHBd)+<>va_CR+<>va_CR
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		//Les ITEMS
		If ((sSexe=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+"Sexe"; -><>ta_TBGenre; -><>te_NbGenre; -><>tl_TBGenre)
		End if 
		If ((sEtCv=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+"Etat civil"; -><>ta_TBEtCiv; -><>te_NbEtCiv; -><>tl_NbEtCiv)
		End if 
		If ((sAge=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+"Classe d'âge"; -><>ta_TBAge; -><>te_NbAge; -><>tl_NbAge)
		End if 
		
		If ((sNeOu=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{22}; -><>ta_TBLieuNé; ->te_TBLieuNé; ->tl_TBLieuNé)
		End if 
		If ((sSignal=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{7}; -><>ta_MRsg; ->te_MRsg; ->tl_MRsg)
		End if 
		If ((sEmplace=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{9}; -><>ta_TBPorte; ->te_TBPorte; ->tl_TBPorte)
		End if 
		If ((sCP=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{11}; -><>ta_TBArr; ->te_TBArr; ->tl_TBArr)
		End if 
		If ((sDem=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{14}; -><>ta_MRDem; ->te_MRDem; ->tl_MRDem)
		End if 
		If ((sQuar=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+"Quartier"; -><>ta_MRqua; ->te_MRqua; ->tl_MRqua)
		End if 
		
		If ((sEgene=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{23}; -><>ta_MReGé; ->te_MReGé; ->tl_MReGé)
		End if 
		If ((sEcut=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{24}; -><>ta_MReCu; ->te_MReCu; ->tl_MReCu)
		End if 
		If ((sRel=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{25}; -><>ta_MRrel; ->te_MRrel; ->tl_MRrel)
		End if 
		If ((sHy=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+"Hygiène"; -><>ta_MRhyg; ->te_MRhyg; ->tl_MRhyg)
		End if 
		If ((sHan=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+"Handicap"; -><>ta_MRhan; ->te_MRhan; ->tl_MRhan)
		End if 
		If ((sLangue=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{26}; -><>ta_Lgs; ->te_Lgs; ->tl_Lgs)
		End if 
		If ((sORsoc=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{30}; -><>ta_OrSc; ->te_OrSc; ->tl_OrSc)
		End if 
		If ((sORmed=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{33}; -><>ta_OrMd; ->te_OrMd; ->tl_OrMd)
		End if 
		If ((sDerHb=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{37}; -><>ta_DerLH; ->te_DerLH; ->tl_DerLH)
		End if 
		If ((sDemHb=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+"Demande d'hébergement"; -><>ta_MRdemHb; -><>te_MRdemHb; -><>tl_MRdemHb)
		End if 
		If ((sPers=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{43}; -><>ta_MRQui; ->te_MRQui; ->tl_MRQui)
		End if 
		If ((sMotif=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{36}; -><>ta_MRrefu; ->te_MRrefu; ->tl_MRrefu)
		End if 
		If ((sMode=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{40}; -><>ta_Qmod; ->te_Qmod; ->tl_Qmod)
		End if 
		
		If ((sTemps=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{42}; -><>ta_TBTpsErr; ->te_TBTpsErr; ->tl_TBTpsErr)
		End if 
		If ((sComp=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{44}; -><>ta_DScomp; ->te_DScomp; ->tl_DScomp)
		End if 
		If ((sCouv=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{48}; -><>ta_DScs; ->te_DScs; ->tl_DScs)
		End if 
		If ((sRess=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{60}; -><>ta_MRrs; ->te_MRrs; ->tl_MRrs)
		End if 
		If ((sPap=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{56}; -><>ta_DSidté; ->te_DSidté; ->tl_DSidté)
		End if 
		If ((sRegime=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{68}; -><>ta_DSrég; ->te_DSrég; ->tl_DSrég)
		End if 
		If (sSuivi=1)
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_MR-<>vlSTR}{72}; -><>ta_DSsuivi; ->te_DSsuivi; ->tl_DSsuivi)
		End if 
		
		
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; <>va_CR)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(<>va_CR))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
End if 
