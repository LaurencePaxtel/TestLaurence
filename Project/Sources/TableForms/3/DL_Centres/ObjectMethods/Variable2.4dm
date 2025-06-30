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
C_LONGINT:C283($L_Event; $L_Erreur)

$L_Event:=Form event code:C388

Case of 
	: ($L_Event=Sur chargement:K2:1)
		
		// Modifié par : Scanu Rémy (20/10/2022)
		If (Value type:C1509(va_CtrLib)=Est une variable indéfinie:K8:13)
			va_CtrLib:=""
		End if 
		
	: ($L_Event=Sur après frappe clavier:K2:26) | ($L_Event=Sur données modifiées:K2:15)
		
		If ($L_Event=Sur après frappe clavier:K2:26)
			va_CtrLib:=Get edited text:C655
		End if 
		
		If (Length:C16(va_CtrLib)=0)
			REDUCE SELECTION:C351([LesCentres:9]; 0)
		Else 
			$L_Erreur:=CentreLits_Handle_query("chercher")
		End if 
		
End case 