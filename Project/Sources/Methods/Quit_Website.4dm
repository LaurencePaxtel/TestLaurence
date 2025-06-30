//%attributes = {}
//{==================================================}
//{ LOGICIEL : 
//{ © DBsolutions
//{
//{          Procédure : Quit_Website
//{
//{          Vendredi 26 juin 2009 à 14:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

CONFIRM:C162("Voulez-vous quitter la partie Website ?")
If (Ok=1)
	If (vh_ws_Période#<>vh_ws_Période) | (vt_ws_Répertoire#<>vt_ws_Répertoire) | (va_ws_NomDocument#<>va_ws_NomDocument) | (va_ws_Heures#<>va_ws_Heures)
		CONFIRM:C162("Voulez-vous enregistrer les paramètres modifiés ?")
		If (Ok=1)
			
			<>vd_ws_Date:=Current date:C33
			<>vh_ws_Période:=vh_ws_Période
			<>vt_ws_Répertoire:=vt_ws_Répertoire
			<>va_ws_NomDocument:=va_ws_NomDocument
			<>va_ws_Heures:=va_ws_Heures
			DébutInitWebsite(1)
		End if 
	End if 
	CANCEL:C270
End if 