//%attributes = {}
//Y a t il des dossiers SIAO aujourd'hui 
//si oui alore se positionner sur la 1 fiche d'ébargement concernée
//voir ce jour si il y a eu de fiches hébergement non clôturés et les envoyer
C_DATE:C307($1)
C_DATE:C307($2)
C_LONGINT:C283($ii; $vl_Jours; $vl_Cas)
C_BOOLEAN:C305($vb_OK; $vb_OKMessage)
$vb_OKMessage:=True:C214  //avec message de progression
C_TIME:C306($vh_RefDoc)

C_TEXT:C284(va_SepChamp; va_SepFICHE; $va_Dept)
va_SepChamp:=Char:C90(126)
va_SepFICHE:=Char:C90(13)

C_DATE:C307($vd_Date; vd_BDOSDate; vd_BDOSDate1; vd_BDOSDate2)
C_LONGINT:C283(vl_BDOSDossiers; vl_BDOSEntrants; vl_BDOSSortants; vl_BDOSJours; vl_BDOSHebergements)
ARRAY LONGINT:C221(tl_LesEntrees; 0)
ARRAY LONGINT:C221(tl_LesEntreesHB; 0)
ARRAY LONGINT:C221(tl_LesDejaEntrees; 0)
ARRAY LONGINT:C221(tl_LesSorties; 0)
ARRAY LONGINT:C221(tl_LesSortiesHB; 0)
ARRAY LONGINT:C221(tl_Les1entree; 0)
$vb_OK:=F_SIAO_BDOS_TabPRC("Declarer")



vd_BDOSDate1:=$1
vd_BDOSDate2:=$2

If ($1=$2)
	$vl_Jours:=1
Else 
	$vl_Jours:=$2-$1+1
End if 
$vd_Date:=$1

//••• 0 •••
vl_BDOSJours:=F_SIAO_BDOS("Jours"; ->vd_BDOSDate1; ->vd_BDOSDate2)
$vb_OK:=(vl_BDOSJours>0)
//••• 1 •••
If ($vb_OK)
	vl_BDOSDossiers:=F_SIAO_BDOS("SIAO"; ->vd_BDOSDate1; ->vd_BDOSDate2)
	vl_BDOSEntrants:=F_SIAO_BDOS("Entrants"; ->vd_BDOSDate1; ->vd_BDOSDate2; ->tl_LesEntrees; ->tl_LesEntreesHB)
	vl_BDOSSortants:=F_SIAO_BDOS("Sortants"; ->vd_BDOSDate1; ->vd_BDOSDate2; ->tl_LesSorties; ->tl_LesSortiesHB)
	vl_BDOSHebergements:=F_SIAO_BDOS("Hebergements"; ->vd_BDOSDate1; ->vd_BDOSDate2; ->tl_Les1entree)
	$vb_OK:=(vl_BDOSDossiers>0)
	$vb_OK:=$vb_OK | (vl_BDOSSortants>0)
	$vb_OK:=$vb_OK | (vl_BDOSEntrants>0)
	If ($vb_OK)
		$vb_OK:=(F_SIAO_BDOS("Confirmer"; ->vl_BDOSDossiers; ->vl_BDOSSortants; ->vl_BDOSEntrants)=1)
	Else 
		ALERT:C41("BDOS : aucune donnée à exporter.")
	End if 
End if 
//••• 2 •••
If ($vb_OK)
	<>vt_BDOS_DOSSIER:=Select folder:C670("Veuillez sélectioner le dossier destinataire des fichiers BDOS .")
	$vb_OK:=(OK=1)
End if 
//••• 3 •••
If ($vb_OK)
	i_Message("  Export BDOS  en cours ")
	$vd_Date:=vd_BDOSDate1
	For ($ii; 1; vl_BDOSJours)
		vd_BDOSDate:=$vd_Date
		vd_BDOSDate1:=$vd_Date
		vd_BDOSDate2:=$vd_Date
		vl_BDOSDossiers:=F_SIAO_BDOS("SIAO"; ->vd_BDOSDate1; ->vd_BDOSDate2)
		vl_BDOSEntrants:=F_SIAO_BDOS("Entrants"; ->vd_BDOSDate1; ->vd_BDOSDate2; ->tl_LesEntrees; ->tl_LesEntreesHB)
		vl_BDOSSortants:=F_SIAO_BDOS("Sortants"; ->vd_BDOSDate1; ->vd_BDOSDate2; ->tl_LesSorties; ->tl_LesSortiesHB)
		vl_BDOSHebergements:=F_SIAO_BDOS("Hebergements"; ->vd_BDOSDate1; ->vd_BDOSDate2; ->tl_Les1entree)
		
		$vb_OK:=(vl_BDOSDossiers>0)
		$vb_OK:=$vb_OK | (vl_BDOSSortants>0)
		If ($vb_OK)
			i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{1})
			//••• 3.1 ••• SIA
			<>va_BDOS_FichierNom:=F_BDOS_Fichier(1)
			$vb_OK:=F_SIAO_BDOS_exSIA(1; $vb_OKMessage)
			i_MessageSeul("  Export BDOS  en cours : "+<>ta_BDOS_FichierNom{2})
			//••• 3.2 ••• DMR
			If (vl_BDOSDossiers>0)
				<>va_BDOS_FichierNom:=F_BDOS_Fichier(2)
				$vb_OK:=F_SIAO_BDOS_exDMR(2; $vb_OKMessage; vd_BDOSDate1)
			End if 
			//••• 3.3••• DME
			If (vl_BDOSDossiers>0)
				<>va_BDOS_FichierNom:=F_BDOS_Fichier(3)
				$vb_OK:=F_SIAO_BDOS_exDME(3; $vb_OKMessage; vd_BDOSDate1)
			End if 
			//••• 3.4 ••• ORI
			If (vl_BDOSDossiers>0)
				<>va_BDOS_FichierNom:=F_BDOS_Fichier(4)
				$vb_OK:=F_SIAO_BDOS_exORI(4; $vb_OKMessage; vd_BDOSDate1)
			End if 
			
			//••• 3.5 ••• PRC
			<>va_BDOS_FichierNom:=F_BDOS_Fichier(5)
			$vb_OK:=F_SIAO_BDOS_exPRC(5; $vb_OKMessage; vd_BDOSDate1)
			
			//••• 3.6 ••• OFF
			<>va_BDOS_FichierNom:=F_BDOS_Fichier(6)
			$vb_OK:=F_SIAO_BDOS_exOFF(6; $vb_OKMessage; vd_BDOSDate1)
			
			//••• 3.7 ••• C : CPAXT77YYYYMMDD
			$vl_Cas:=Length:C16(<>va_T_Departement)
			Case of 
				: ($vl_Cas>2)
					$va_Dept:=Substring:C12(<>va_T_Departement; 1; 2)
				: ($vl_Cas<2)
					$va_Dept:=<>va_T_Departement+("X"*(2-Length:C16(<>va_T_Departement)))
				Else 
					$va_Dept:=<>va_T_Departement
			End case 
			
			<>va_BDOS_FichierNom:="CPAXT"+$va_Dept+String:C10(Year of:C25([DiaLogues:3]DL_Date:2); "0000")+String:C10(Month of:C24([DiaLogues:3]DL_Date:2); "00")+String:C10(Day of:C23([DiaLogues:3]DL_Date:2); "00")
			
			$vh_RefDoc:=Create document:C266(<>vt_BDOS_DOSSIER+<>va_BDOS_FichierNom)
			If (OK=1)
				USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
				
				<>vt_BDOS_VALEUR:=va_SepFICHE
				SEND PACKET:C103($vh_RefDoc; _O_Mac to Win:C463(<>vt_BDOS_VALEUR))
				
				USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
				CLOSE DOCUMENT:C267($vh_RefDoc)
			End if 
			
		End if 
		$vd_Date:=Add to date:C393($vd_Date; 0; 0; 1)
	End for 
	CLOSE WINDOW:C154
End if 
<>vt_BDOS_VALEUR:=""
P_SIAO_BDOS_Find