C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(*; "Masque_CritCentre"; <>vb_T_CentreCritMasquer)
		If (Character code:C91(va_CritèreAlpha)=Character code:C91("@"))
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4=va_CritèreAlpha; *)
		Else 
			QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4=("@"+va_CritèreAlpha+"@"); *)
		End if 
		
		QUERY:C277([LesCentres:9];  & [LesCentres:9]LC_Prestation:55=False:C215)
		
		ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
		FIRST RECORD:C50([LesCentres:9])
		PREVIOUS RECORD:C110([LesCentres:9])
		vl_SourisXb:=0
		vl_SourisYb:=0
		vl_SourisBtb:=0
	: ($vl_Event=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisXb; vl_SourisYb; vl_SourisBtb)
		If ((vl_SourisXb>7) & (vl_SourisXb<725)) & ((vl_SourisYb>106) & (vl_SourisYb<503))
			vb_RecHéb:=F_CentreSelection([LesCentres:9]LC_RéférenceID:1; 0)
		End if 
End case 