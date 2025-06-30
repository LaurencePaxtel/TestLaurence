C_LONGINT:C283($vl_Event)
$vl_Event:=Form event code:C388
Case of 
	: ($vl_Event=Sur chargement:K2:1)
		[DiaLogues:3]DL_Date:2:=Current date:C33(*)
		[DiaLogues:3]DL_Date2:8:=Current date:C33(*)
		ve_Date_Cas:=0
		
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		
		<>ta_BDOS_FichierNom:=1
		<>tl_BDOS_FichierRang:=1
		<>ta_BDOS_FichierCode:=1
		<>ta_BDOS_FichierNom:=1
		<>tl_BDOS_FichierChamps:=1
		
		<>va_BDOS_FichierNom:=""
		<>va_BDOS_FichierTable:=""
		If (F_BDOS_Tables(<>ta_BDOS_FichierCode{<>ta_BDOS_FichierNom}; ""; 0))
		End if 
		<>va_BDOS_FichierNom:=F_BDOS_Fichier(<>ta_BDOS_FichierNom)
		<>va_BDOS_FichierTable:=<>ta_BDOS_FichierNom{<>ta_BDOS_FichierNom}
		vL_NbFichesEntrant:=0
		vL_NbFichesSortant:=0
		
		
		P_SIAO_BDOS_Find
		
	: ($vl_Event=Sur données modifiées:K2:15)
		
	: ($vl_Event=Sur clic:K2:4)
		
	: ($vl_Event=Sur double clic:K2:5)
		
		
		
	: ($vl_Event=Sur appel extérieur:K2:11)
		
End case 