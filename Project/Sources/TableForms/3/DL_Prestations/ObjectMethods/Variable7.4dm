//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script vd_IDT_NéLe  
//{
//{          Lundi 28 Juillet 1997 à 16:54:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
$ev:=Form event code:C388

Case of 
	: ($ev=Sur chargement:K2:1)
		va_FrappeClavierD:=""
	: ($ev=Sur données modifiées:K2:15)
		
		
		va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
		ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
		va_FrappeClavierD:=(String:C10(vd_IDT_NéLe; 4)*(Num:C11((vd_IDT_NéLe)>!00-00-00!)))
		
	: ($ev=Sur avant frappe clavier:K2:6)
		If (va_IDT_Nom>"") & (va_IDT_Pré>"")
			$Ascii:=Character code:C91(Keystroke:C390)
			If (($Ascii=Touche retour arrière:K12:29) | ($Ascii=ASCII DEL:K15:34))
				va_FrappeClavierD:=Substring:C12(va_FrappeClavierD; 1; Length:C16(va_FrappeClavierD)-1)
			Else 
				va_FrappeClavierD:=Insert string:C231(va_FrappeClavierD; Keystroke:C390; Length:C16(va_FrappeClavierD)+1)
			End if 
			If (va_FrappeClavierD="")
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_IDT_Nom+" "+va_IDT_Pré+"@"))
			Else 
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=(va_IDT_Nom+" "+va_IDT_Pré+" "+va_FrappeClavierD+"@"))
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