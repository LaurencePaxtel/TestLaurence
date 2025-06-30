//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Script va_CtrLib  
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
		
		If (Character code:C91(va_CritèreAlpha)=Character code:C91("@"))
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4=va_CritèreAlpha; *)
		Else 
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4=("@"+va_CritèreAlpha+"@"); *)
		End if 
		
		QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_Prestation:55=False:C215)
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		FIRST RECORD:C50([LesCentres:9])
		
	: ($ev=Sur avant frappe clavier:K2:6)
		
		$Ascii:=Character code:C91(Keystroke:C390)
		If (($Ascii=Touche retour arrière:K12:29) | ($Ascii=ASCII DEL:K15:34))
			va_FrappeClavier:=Substring:C12(va_FrappeClavier; 1; Length:C16(va_FrappeClavier)-1)
		Else 
			va_FrappeClavier:=Insert string:C231(va_FrappeClavier; Keystroke:C390; Length:C16(va_FrappeClavier)+1)
		End if 
		If (va_FrappeClavier="")
			REDUCE SELECTION:C351([LesCentres:9]; 0)
		Else 
			va_CritèreAlpha:=va_FrappeClavier
			If (va_CritèreAlpha>"")
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4=("@"+va_CritèreAlpha+"@"); *)
				QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_Prestation:55=False:C215)
				ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
			End if 
		End if 
		FIRST RECORD:C50([LesCentres:9])
End case 