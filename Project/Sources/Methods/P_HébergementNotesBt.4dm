//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_HébergementNotesBt
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)

C_LONGINT:C283($L_Selecteur)

$L_Selecteur:=$1

Case of   // #20180511-2
	: ($L_Selecteur=0) | ($L_Selecteur=1)
		OBJECT SET ENABLED:C1123(b_VoirNotes; ($L_Selecteur=1))
		OBJECT SET ENABLED:C1123(b_VoirActs; ($L_Selecteur=1))
		OBJECT SET ENABLED:C1123(b_VoirSP; ($L_Selecteur=1))
		OBJECT SET ENABLED:C1123(b_VoirHG; ($L_Selecteur=1))
		OBJECT SET ENABLED:C1123(b_VoirActsF; ($L_Selecteur=1))
		OBJECT SET ENABLED:C1123(b_SIAO; ($L_Selecteur=1))
		OBJECT SET ENABLED:C1123(*; "button_filebrowser"; ($L_Selecteur=1))  // #20180511-1
	Else 
		ASSERT:C1129(False:C215; "Situation non attendue danns la méthode P_HébergementNotesBt")
End case 