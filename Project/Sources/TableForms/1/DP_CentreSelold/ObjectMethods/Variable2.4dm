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
C_LONGINT:C283($ev)

$ev:=Form event code:C388

Case of 
	: ($ev=Sur chargement:K2:1)
		va_FrappeClavier:=""
	: ($ev=Sur après frappe clavier:K2:26)
		va_FrappeClavier:=Get edited text:C655
		
		If (va_FrappeClavier="")
			REDUCE SELECTION:C351([LesCentres:9]; 0)
		Else 
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4=("@"+va_FrappeClavier+"@"))
		End if 
		
		MultiSoc_Filter(->[LesCentres:9])
		
		vL_NbFichesCL:=Records in selection:C76([LesCentres:9])
		
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		FIRST RECORD:C50([LesCentres:9])
	: ($ev=Sur données modifiées:K2:15)
		
		If (Substring:C12(va_CtrLib; 1; 1)=" ")
			
			While (Substring:C12(va_CtrLib; 1; 1)=" ")
				va_CtrLib:=Substring:C12(va_CtrLib; 2)
			End while 
			
		End if 
		
		If (va_CtrLib>"")
			
			Repeat 
				
				If (Character code:C91(va_CtrLib[[1]])<=32)
					va_CtrLib:=Substring:C12(va_CtrLib; 2)
				End if 
				
			Until (Character code:C91(va_CtrLib[[1]])>32)
			
		End if 
		
		va_FrappeClavier:=va_CtrLib
End case 