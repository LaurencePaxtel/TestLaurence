//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 22/10/18, 22:33:16
// ----------------------------------------------------
// Méthode : Web_Log_Connection
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)

C_TEXT:C284($ref_entreprise; $type_action; $ref_fiche; $infoplus)
C_LONGINT:C283($ref_user; $offset)
C_BOOLEAN:C305($condition2_b)

$ref_user:=$1
$ref_entreprise:=$2
$type_action:=$3

If (Count parameters:C259>3)
	$ref_fiche:=$4
End if 

If (Count parameters:C259>4)
	$infoplus:=$5
End if 

If (Read only state:C362([Preferences:81]))
	READ WRITE:C146([Preferences:81])
End if 

// Recherche de la fiche de stockage des log et création si elle n'existe pas
QUERY:C277([Preferences:81]; [Preferences:81]PREF_UID_user:7=$ref_user; *)
QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Info_plus_1:8="Log"; *)
QUERY:C277([Preferences:81];  & ; [Preferences:81]Ref_Structure:10=$ref_entreprise)

If (Records in selection:C76([Preferences:81])>0)
	
	If (Is nil pointer:C315(<>Preference_info_Blob)=False:C215)
		$condition2_b:=(BLOB size:C605(<>Preference_info_Blob->)>0)
	End if 
	
End if 


Case of 
	: (Records in selection:C76([Preferences:81])=0)  // Création si elle n'existe pas
		CREATE RECORD:C68([Preferences:81])
		[Preferences:81]PREF_UID_user:7:=$ref_user
		[Preferences:81]PREF_Info_plus_1:8:="Log"
		[Preferences:81]Ref_Structure:10:=$ref_entreprise
	: ($condition2_b=True:C214)  // Si le blob est non vide on charge les tableaux de log
		BLOB TO VARIABLE:C533(<>Preference_info_Blob->; <>USR_LOG_Date_de_connection; $offset)
		BLOB TO VARIABLE:C533(<>Preference_info_Blob->; <>USR_LOG_heure_de_connection; $offset)
		BLOB TO VARIABLE:C533(<>Preference_info_Blob->; <>USR_LOG_Action; $offset)
		BLOB TO VARIABLE:C533(<>Preference_info_Blob->; <>USR_LOG_ref_fiche; $offset)
		BLOB TO VARIABLE:C533(<>Preference_info_Blob->; <>USR_LOG_Infoplus; $offset)
	Else   // Si le blob est vide on cré les tableaux avec une taille a zero
		ARRAY TEXT:C222(<>USR_LOG_Action; 0)
		ARRAY TEXT:C222(<>USR_LOG_ref_fiche; 0)
		ARRAY TEXT:C222(<>USR_LOG_Infoplus; 0)
		
		ARRAY LONGINT:C221(<>USR_LOG_heure_de_connection; 0)
		
		ARRAY DATE:C224(<>USR_LOG_Date_de_connection; 0)
End case 

// On insere la ligne de Log
INSERT IN ARRAY:C227(<>USR_LOG_Date_de_connection; 0; 1)
INSERT IN ARRAY:C227(<>USR_LOG_heure_de_connection; 0; 1)
INSERT IN ARRAY:C227(<>USR_LOG_Action; 0; 1)
INSERT IN ARRAY:C227(<>USR_LOG_ref_fiche; 0; 1)
INSERT IN ARRAY:C227(<>USR_LOG_Infoplus; 0; 1)

// Limite de la longueur des logs en fonction de la veleur de la variable <>Longueur_Log qui est initialisée dans 000_Initiallisation
If (Size of array:C274(<>USR_LOG_Date_de_connection)><>Longueur_Log) & (<>Longueur_Log>0)
	ARRAY TEXT:C222(<>USR_LOG_Action; <>Longueur_Log)
	ARRAY TEXT:C222(<>USR_LOG_ref_fiche; <>Longueur_Log)
	ARRAY TEXT:C222(<>USR_LOG_Infoplus; <>Longueur_Log)
	
	ARRAY LONGINT:C221(<>USR_LOG_heure_de_connection; <>Longueur_Log)
	
	ARRAY DATE:C224(<>USR_LOG_Date_de_connection; <>Longueur_Log)
End if 

// Remplissage de la ligne de log
<>USR_LOG_Action{1}:=$type_action
<>USR_LOG_ref_fiche{1}:=$ref_fiche
<>USR_LOG_Infoplus{1}:=$infoplus

<>USR_LOG_heure_de_connection{1}:=(Current time:C178(*)+0)

<>USR_LOG_Date_de_connection{1}:=Current date:C33(*)

// Stockage du log
VARIABLE TO BLOB:C532(<>USR_LOG_Date_de_connection; [Preferences:81]PREF_Informations:11)
VARIABLE TO BLOB:C532(<>USR_LOG_heure_de_connection; [Preferences:81]PREF_Informations:11; *)
VARIABLE TO BLOB:C532(<>USR_LOG_Action; [Preferences:81]PREF_Informations:11; *)
VARIABLE TO BLOB:C532(<>USR_LOG_ref_fiche; [Preferences:81]PREF_Informations:11; *)
VARIABLE TO BLOB:C532(<>USR_LOG_Infoplus; [Preferences:81]PREF_Informations:11; *)

SAVE RECORD:C53([Preferences:81])
UNLOAD RECORD:C212([Preferences:81])

READ ONLY:C145([Preferences:81])