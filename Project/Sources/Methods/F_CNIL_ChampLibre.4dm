//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Fonction : F_CNIL_ChampLibre
//{          Vendredi 29 juillet 2011 à 11:37
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($vl_Fenetre)
C_TEXT:C284(vt_CNILtitre)
C_TEXT:C284(vt_CNIL)

Case of 
	: ($1=0)
		$0:=True:C214
		
	: ($1=1)
		vt_CNILtitre:="ATTENTION : conditions de saisie des champs libres."
		vt_CNILtitre:="AVERTISSEMENT sur la saisie des champs textes."
		vt_CNIL:=<>vt_CNIL_ChampLibre+<>va_CR+<>va_CR+"Voulez-vous continuer ?"
		$vl_Fenetre:=Open window:C153((<>vl_EcranL/2)-(470/2); 120; (<>vl_EcranL/2)+(470/2); 120+283; 5; "CNIL")
		DIALOG:C40([DiaLogues:3]; "DL_CNIL")
		CLOSE WINDOW:C154($vl_Fenetre)
		$0:=(OK=1)
End case 