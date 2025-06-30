//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script va_IDT_Nom  
//{
//{          Lundi 28 Juillet 1997 à 16:54:03
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

$ev:=Form event code:C388

Case of 
	: ($ev=Sur chargement:K2:1)
		va_FrappeClavier:=""
	: ($ev=Sur données modifiées:K2:15)
		If (Substring:C12(va_HGRNom; 1; 1)=" ")
			While (Substring:C12(va_HGRNom; 1; 1)=" ")
				va_HGRNom:=Substring:C12(va_HGRNom; 2)
			End while 
		End if 
		va_HGRNom:=Uppercase:C13(va_HGRNom)
		If (va_HGRNom>"")
			Repeat 
				If (Character code:C91(va_HGRNom[[1]])<=32)
					va_HGRNom:=Substring:C12(va_HGRNom; 2)
				End if 
			Until (Character code:C91(va_HGRNom[[1]])>32)
		End if 
		va_HGRNom:=Uut_HébergéClé(->va_HGRNom; ->va_HGRPré; ->vd_HGRNé)
		
		va_FrappeClavier:=va_HGRNom
		
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
		va_NNN:=""
		P_HébergementNotesBt(0)
		OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
End case 