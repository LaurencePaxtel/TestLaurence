//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script va_IDT_Pré  
//{
//{          Lundi 28 Juillet 1997 à 16:54:29
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
$ev:=Form event code:C388

Case of 
	: ($ev=Sur chargement:K2:1)
		va_FrappeClavierP:=""
	: ($ev=Sur données modifiées:K2:15)
		
		
		va_IDT_Pré:=Uppercase:C13(va_IDT_Pré)
		va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
		
		va_FrappeClavierP:=va_IDT_Pré
		
	: ($ev=Sur avant frappe clavier:K2:6)
		If (va_IDT_Nom>"")
			$Ascii:=Character code:C91(Keystroke:C390)
			If (($Ascii=Touche retour arrière:K12:29) | ($Ascii=ASCII DEL:K15:34))
				va_FrappeClavierP:=Substring:C12(va_FrappeClavierP; 1; Length:C16(va_FrappeClavierP)-1)
			Else 
				va_FrappeClavierP:=Insert string:C231(va_FrappeClavierP; Keystroke:C390; Length:C16(va_FrappeClavierP)+1)
			End if 
			If (va_FrappeClavierP="")
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_IDT_Nom+"@"))
			Else 
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_IDT_Nom+" "+va_FrappeClavierP+"@"))
			End if 
			vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
			ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
			//FIRST RECORD([HeBerge])
			REDUCE SELECTION:C351([RenseiGnements:20]; 0)
			vL_Nb_HG_F:=0
			va_Identité:=""
			vl_RéfU_HB:=0
		End if 
End case 