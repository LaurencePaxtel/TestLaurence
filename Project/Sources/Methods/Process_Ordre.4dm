//%attributes = {}
//{==================================================}
//{          Procédure : Process_Ordre
//{
//{          Lundi 05 Janvier 1998 à 14:37:18
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  // Le no du proc
C_POINTER:C301($2)  // La super globale 1 (Ordre)
C_TEXT:C284($3)  // Le Contenu de la super globale 1
C_POINTER:C301($4)  // La super globale 2 (affichage)
C_TEXT:C284($5)  // Le Contenu de la super globale 2

$2->:=$3
$4->:=$5

POST OUTSIDE CALL:C329($1)