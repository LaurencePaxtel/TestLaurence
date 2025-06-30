//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : Go_OccupationWeek
//{          Lundi 25 octobre 2010 à 18:16
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_DATE:C307($2)

C_TEXT:C284($vt_Texte)
C_LONGINT:C283($ii; $vl_Fenetre)
C_BOOLEAN:C305($vb_OK)

C_TEXT:C284(va_Titre; va_DateMaJ; va_DateMaJNext)
C_LONGINT:C283(ve_CasOccupation; ve_Ps1; vl_ii; vl_Rafraichir; vl_FixerMinuteur; vl_TOC_Capacité; vl_TOC_Hébergés_L; vl_TOC_Hébergés_M; vl_TOC_Hébergés_Me; vl_TOC_Hébergés_J; vl_TOC_Hébergés_V; vl_TOC_Hébergés_S; \
vl_TOC_Hébergés_D; ve_TOC_L; ve_TOC_M; ve_TOC_Me; ve_TOC_J; ve_TOC_V; ve_TOC_S; ve_TOC_D)
C_DATE:C307(vd_Date1; vd_Date2; vd_P_DateJ; vd_P_DateJf)
C_TIME:C306(vh_FixerMinuteur)

ve_CasOccupation:=$1

ve_TOC_L:=0
ve_TOC_M:=0
ve_TOC_Me:=0
ve_TOC_J:=0
ve_TOC_V:=0
ve_TOC_S:=0
ve_TOC_D:=0

MESSAGES OFF:C175

If ($1=0)
	READ ONLY:C145(*)
	SET MENU BAR:C67(1)
	
	vd_Date1:=Current date:C33
Else 
	vd_Date1:=$2
End if 

va_DateMaJ:="Mise à jour le …"

P_OccupationTabWeek(0)

If ($1=0)
	va_Titre:="Occupation hebdomadaire"
	
	$vl_Fenetre:=i_FenêtreNo(876; 608; 4; va_Titre; 1; "Quit_Simple")
	DIALOG:C40([DiaLogues:3]; "DL_OccupationWeek")
	
	CLOSE WINDOW:C154($vl_Fenetre)
Else 
	vl_Rafraichir:=0
	
	P_SemaineDate(1; vd_Date1; ->vd_Date1; ->vd_Date2)
	P_TauxOccupationWeek(1)
	
	If (Size of array:C274(tl_Occ_CentreRéférence)>0)
		$vt_Texte:="Semaine du "+String:C10(vd_Date1; Interne date court:K1:7)+" au "+String:C10(vd_Date2; Interne date court:K1:7)+<>va_CR
		$vt_Texte:=$vt_Texte+"Code"+<>va_Tab+"Nom"
		$vt_Texte:=$vt_Texte+<>va_Tab+"Capacité"
		$vt_Texte:=$vt_Texte+<>va_Tab+"Lundi "+String:C10(Day of:C23(vd_Date1))
		$vt_Texte:=$vt_Texte+<>va_Tab+"Mardi "+String:C10(Day of:C23(Add to date:C393(vd_Date1; 0; 0; 1)))
		$vt_Texte:=$vt_Texte+<>va_Tab+"Mercredi "+String:C10(Day of:C23(Add to date:C393(vd_Date1; 0; 0; 2)))
		$vt_Texte:=$vt_Texte+<>va_Tab+"Jeudi "+String:C10(Day of:C23(Add to date:C393(vd_Date1; 0; 0; 3)))
		$vt_Texte:=$vt_Texte+<>va_Tab+"Vendredi "+String:C10(Day of:C23(Add to date:C393(vd_Date1; 0; 0; 4)))
		$vt_Texte:=$vt_Texte+<>va_Tab+"Samedi "+String:C10(Day of:C23(Add to date:C393(vd_Date1; 0; 0; 5)))
		$vt_Texte:=$vt_Texte+<>va_Tab+"Dimanche "+String:C10(Day of:C23(Add to date:C393(vd_Date1; 0; 0; 6)))
		$vt_Texte:=$vt_Texte+<>va_CR
		
		For ($ii; 1; Size of array:C274(tl_Occ_CentreRéférence))
			
			If (ta_Occ_CentreRepertoire{$ii}#"115")
				$vt_Texte:=$vt_Texte+ta_Occ_CentreRepertoire{$ii}+<>va_Tab+ta_Occ_CentreNom{$ii}
				$vt_Texte:=$vt_Texte+<>va_Tab+String:C10(tl_Occ_CentreCapacité{$ii}; "### ### ##0;;")
				$vt_Texte:=$vt_Texte+<>va_Tab+String:C10(tl_Occ_CentreUtilisé_L{$ii}; "### ### ##0;;")
				$vt_Texte:=$vt_Texte+<>va_Tab+String:C10(tl_Occ_CentreUtilisé_M{$ii}; "### ### ##0;;")
				$vt_Texte:=$vt_Texte+<>va_Tab+String:C10(tl_Occ_CentreUtilisé_Me{$ii}; "### ### ##0;;")
				$vt_Texte:=$vt_Texte+<>va_Tab+String:C10(tl_Occ_CentreUtilisé_J{$ii}; "### ### ##0;;")
				$vt_Texte:=$vt_Texte+<>va_Tab+String:C10(tl_Occ_CentreUtilisé_V{$ii}; "### ### ##0;;")
				$vt_Texte:=$vt_Texte+<>va_Tab+String:C10(tl_Occ_CentreUtilisé_S{$ii}; "### ### ##0;;")
				$vt_Texte:=$vt_Texte+<>va_Tab+String:C10(tl_Occ_CentreUtilisé_D{$ii}; "### ### ##0;;")
				$vt_Texte:=$vt_Texte+<>va_CR
			End if 
			
		End for 
		
	End if 
	
	If (True:C214)
		$vb_OK:=F_MailTauxEnvoyer($vt_Texte)
	End if 
	
End if 

P_OccupationTabWeek(0)

If ($1=0)
	<>PR_OccupationWeek:=0
End if 