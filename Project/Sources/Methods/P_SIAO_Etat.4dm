//%attributes = {}

C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_LONGINT:C283($ii)
C_BOOLEAN:C305($vb_Cas)
Case of 
	: ($1=1)
		$vb_Cas:=Not:C34($2)
		OBJECT SET VISIBLE:C603(*; "@_ico1"; $vb_Cas)
		OBJECT SET VISIBLE:C603(*; "Pop_@"; $vb_Cas)
		OBJECT SET VISIBLE:C603(*; "CentreCritere_@"; $vb_Cas)
		If ($vb_Cas)
			//  ACTIVER BOUTON(b_ValSIAO)
			OBJECT SET ENABLED:C1123(b_TransSIAO; True:C214)
		Else 
			//  INACTIVER BOUTON(b_ValSIAO)
			OBJECT SET ENABLED:C1123(b_TransSIAO; False:C215)
		End if 
		For ($ii; 1; Get last field number:C255(->[Dossier_SIAO:49]))
			OBJECT SET ENTERABLE:C238(Field:C253(Table:C252(->[Dossier_SIAO:49]); $ii)->; $vb_Cas)
		End for 
		
		
	: ($1=2)
		vt_TitreDocument:="zzz"
		vt_TitreDocument:=F_FichierSuffixe(vt_TitreDocument)
		
		If (F_SIAO_Fiche)
		End if 
		<>vt_SIAO_Transfert:="SIAO REGIONALES"+<>va_TAB+String:C10(vd_DateRéelle; Interne date court:K1:7)+<>va_TAB+String:C10(vd_HeureRéelle; h mn s:K7:1)+<>va_TAB+"-1"+<>va_CR
		<>vt_SIAO_Transfert:=<>vt_SIAO_Transfert+<>vt_SIAO_Texte
		<>vt_SIAO_Transfert:=<>vt_SIAO_Transfert+"SSPFINREGIONALSIAO"+<>va_TAB+<>va_CR
		
		
	: ($1=3)  //Fermeture
		$vb_Cas:=Not:C34($2)
		OBJECT SET VISIBLE:C603(*; "@_ico1"; $vb_Cas)
		OBJECT SET VISIBLE:C603(*; "Pop_@"; $vb_Cas)
		OBJECT SET VISIBLE:C603(*; "CentreCritere_@"; $vb_Cas)
		OBJECT SET ENABLED:C1123(b_AnnSIAO; False:C215)
		OBJECT SET ENABLED:C1123(b_TransSIAO; False:C215)
		For ($ii; 1; Get last field number:C255(->[Dossier_SIAO:49]))
			OBJECT SET ENTERABLE:C238(Field:C253(Table:C252(->[Dossier_SIAO:49]); $ii)->; $vb_Cas)
		End for 
		
End case 