//%attributes = {}
// Method reu_Lire_participants créé une sélection d'usager pour un rendez-vous 
//  
// #SYNTAX: $L_Erreur:=reu_Lire_participants($L_ID_appointment) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Long            : ID rendez-vous

// #DATE CREATION: 09/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_LONGINT:C283($1; $L_ID_appointment)
$L_ID_appointment:=$1

QUERY:C277([HeBerge:4]; [APPOINT_REUNION:74]Ref_Appointment:2=$L_ID_appointment)
MultiSoc_Filter(->[HeBerge:4])

//QUERY([APPOINT_REUNION];[APPOINT_REUNION]Ref_Appointment=$L_ID_appointment)
//RELATE ONE SELECTION([APPOINT_REUNION];[HeBerge])



