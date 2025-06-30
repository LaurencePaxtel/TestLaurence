//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_Exporter_DSEtude
//{
//{          Mardi 24 mai 2005 à 15:22:00
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii)
C_TIME:C306($h_RefDoc)
C_TEXT:C284($va_Lib)
C_TEXT:C284($vt_Texte)
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
		
		$vt_Texte:="Statistiques Dossier social étude du "+String:C10(vd_Date1; 4)+" au "+String:C10(vd_Date2; 4)
		$vt_Texte:=$vt_Texte+Char:C90(13)
		$vt_Texte:=$vt_Texte+Char:C90(13)
		$vt_Texte:=$vt_Texte+"Statut : "+("Avec les inconnus"*u1)+("Sans les inconnus"*u2)
		$vt_Texte:=$vt_Texte+Char:C90(13)
		$vt_Texte:=$vt_Texte+Char:C90(13)
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
				$vt_Texte:="Etat civil : tous"+Char:C90(13)+Char:C90(13)
				
			Else 
				$vt_Texte:="Etat civil : "
				If (<>vb_CestUnMac)
					SEND PACKET:C103($h_RefDoc; $vt_Texte)
				Else 
					SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
				End if 
				
				For ($kk; 1; Size of array:C274(ta_FuseEtCiv))
					If (te_FuseEtCivCheck{$kk}=1)
						$vt_Texte:=Char:C90(9)
						$vt_Texte:=$vt_Texte+ta_FuseEtCiv{$kk}
						$vt_Texte:=$vt_Texte+Char:C90(13)
						If (<>vb_CestUnMac)
							SEND PACKET:C103($h_RefDoc; $vt_Texte)
						Else 
							SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
						End if 
					End if 
				End for 
			End if 
			$vt_Texte:=Char:C90(13)
			If (<>vb_CestUnMac)
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
			Else 
				SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
			End if 
		End if 
		$vt_Texte:=Char:C90(13)
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463($vt_Texte))
		End if 
		
		//Demandes et personnes et personnes différentes
		$vt_Texte:="Nombre de demandes"
		$vt_Texte:=$vt_Texte+Char:C90(9)+String:C10(vl_NbHB)
		$vt_Texte:=$vt_Texte+Char:C90(13)
		
		$vt_Texte:=$vt_Texte+"Nombre de personnes"
		$vt_Texte:=$vt_Texte+Char:C90(9)+String:C10(vl_NbHBd)
		$vt_Texte:=$vt_Texte+Char:C90(13)
		
		$vt_Texte:=$vt_Texte+Char:C90(13)
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
		If ((sNatio=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{18}; -><>ta_TBNatio; ->te_NbNatio; ->tl_NbNatio)
		End if 
		If ((sNeOu=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{9}; -><>ta_TBLieuNé; ->te_TBLieuNé; ->tl_TBLieuNé)
		End if 
		If ((sLangue=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{10}; -><>ta_Lgs; ->te_Lgs; ->tl_Lgs)
		End if 
		If ((sDerHb=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{11}; -><>ta_DerLH; ->te_DerLH; ->tl_DerLH)
		End if 
		If ((sCoSSp=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{12}; -><>ta_MRCssp; ->te_MRCssp; ->tl_MRCssp)
		End if 
		If ((sMatri=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{14}; -><>ta_TBSitFam; ->te_TBSitFam; ->tl_TBSitFam)
		End if 
		If (7=8)
			If ((sEnfant=1) & (<>vb_StopEven=False:C215))
				P_Envoyer($h_RefDoc; $va_Lib+"Enfant"; -><>ta_TBEnfant; -><>te_TBEnfant; -><>tl_TBEnfant)
			End if 
		End if 
		If ((sPersMaj=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{21}; -><>ta_MRMpro; ->te_MRMpro; ->tl_MRMpro)
		End if 
		If ((sTpsErr=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{25}; -><>ta_TBTpsErr; ->te_TBTpsErr; ->tl_TBTpsErr)
		End if 
		If ((sDerSSP=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{29}; -><>ta_MRPssp; ->te_MRPssp; ->tl_MRPssp)
		End if 
		If ((sAss=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{3}; -><>ta_InAsSoc; ->te_InAsSoc; ->tl_InAsSoc)
		End if 
		If ((sEnCh=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{19}; -><>ta_MRPch; ->te_MRPch; ->tl_MRPch)
		End if 
		If ((sRefus=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{20}; -><>ta_MRrefu; ->te_MRrefu; ->tl_MRrefu)
		End if 
		If ((sConn=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{26}; -><>ta_MRQui; ->te_MRQui; ->tl_MRQui)
		End if 
		If ((sComp=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{27}; -><>ta_DScomp; ->te_DScomp; ->tl_DScomp)
		End if 
		
		If ((sPap=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{37}; -><>ta_Papier; -><>te_Papier; -><>tl_Papier)
		End if 
		If ((sPap_1=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{38}; -><>ta_DSidté; ->te_DSidté; ->tl_DSidté)
		End if 
		
		If ((sRegime=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{41}; -><>ta_Régime; -><>te_Régime; -><>tl_Régime)
		End if 
		If ((sRegime_1=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{42}; -><>ta_DSrég; -><>te_Suivi; -><>tl_Suivi)
		End if 
		If ((sSuivi=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{45}; -><>ta_Suivi; -><>te_Suivi; -><>tl_Suivi)
		End if 
		If ((sSuivi_1=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{46}; -><>ta_DSsuivi; ->te_DSsuivi; ->tl_DSsuivi)
		End if 
		
		If ((sCouv=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{49}; -><>ta_Couverture; -><>te_Couverture; -><>tl_Couverture)
		End if 
		If ((sCouv_1=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{50}; -><>ta_DScs; ->te_DScs; ->tl_DScs)
		End if 
		
		If ((sRess=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{57}; -><>ta_Ressource; -><>te_Ressource; -><>tl_Ressource)
		End if 
		If ((sRess_1=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{58}; -><>ta_MRrs; ->te_MRrs; ->tl_MRrs)
		End if 
		
		If ((sSor=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{65}; -><>ta_Sortie; -><>te_Sortie; -><>tl_Sortie)
		End if 
		If ((sSor_1=1) & (<>vb_StopEven=False:C215))
			P_Envoyer($h_RefDoc; $va_Lib+<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{66}; -><>ta_MRSctr; ->te_MRSctr; ->tl_MRSctr)
		End if 
		
		If (<>vb_CestUnMac)
			SEND PACKET:C103($h_RefDoc; Char:C90(13))
		Else 
			SEND PACKET:C103($h_RefDoc; _O_Mac to Win:C463(Char:C90(13)))
		End if 
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
End if 