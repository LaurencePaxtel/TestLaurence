//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script DP_Libellé  
//{
//{          Lundi 28 Juillet 1997 à 17:08:36
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

$ev:=Form event code:C388

Case of 
	: ($ev=Sur chargement:K2:1)
		va_FrappeClavier:=""
	: ($ev=Sur données modifiées:K2:15)
		
		If (Substring:C12([DePart:1]DP_Libelle:6; 1; 1)=" ")
			While (Substring:C12([DePart:1]DP_Libelle:6; 1; 1)=" ")
				[DePart:1]DP_Libelle:6:=Substring:C12([DePart:1]DP_Libelle:6; 2)
			End while 
		End if 
		[DePart:1]DP_Libelle:6:=Uppercase:C13([DePart:1]DP_Libelle:6)
		If ([DePart:1]DP_Libelle:6>"")
			Repeat 
				If (Character code:C91([DePart:1]DP_Libelle:6[[1]])<=32)
					[DePart:1]DP_Libelle:6:=Substring:C12([DePart:1]DP_Libelle:6; 2)
				End if 
			Until (Character code:C91([DePart:1]DP_Libelle:6[[1]])>32)
		End if 
		va_IDT_Clé:=[DePart:1]DP_Libelle:6
		
		va_FrappeClavier:=[DePart:1]DP_Libelle:6
		
	: ($ev=Sur avant frappe clavier:K2:6)
		$Ascii:=Character code:C91(Keystroke:C390)
		If (($Ascii=Touche retour arrière:K12:29) | ($Ascii=ASCII DEL:K15:34))
			va_FrappeClavier:=Substring:C12(va_FrappeClavier; 1; Length:C16(va_FrappeClavier)-1)
		Else 
			va_FrappeClavier:=Insert string:C231(va_FrappeClavier; Keystroke:C390; Length:C16(va_FrappeClavier)+1)
		End if 
		If (va_FrappeClavier="")
			REDUCE SELECTION:C351([HeBerge:4]; 0)
		Else 
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_FrappeClavier+"@"))
			MultiSoc_Filter(->[HeBerge:4])
		End if 
		vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
		ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
		FIRST RECORD:C50([HeBerge:4])
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		vL_Nb_HG_F:=0
		va_Nb_HG_F:=""
		REDUCE SELECTION:C351([DossierPsycho:28]; 0)
		vL_Nb_MR_F:=0
		va_Nb_MR_F:=""
		K_BoutonDossierDem(False:C215)
		K_BoutonDossierDos(False:C215)
End case 