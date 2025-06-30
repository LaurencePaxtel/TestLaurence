//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction :  F_UnDossierTypeSupprimer
//{
//{          Mercredi 18 juillet 2001 à 10:08:57
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_POINTER:C301($1)
C_POINTER:C301($2)
C_TEXT:C284($3)
READ WRITE:C146($1->)
If (i_NonVerrou($1))
	If ($3="DS")  //Pour Dossier social
		READ WRITE:C146([ActionSociale:26])
		QUERY:C277([ActionSociale:26]; [ActionSociale:26]AA_DS_ID:12=$2->)
		MultiSoc_Filter(->[ActionSociale:26])
		If (Records in selection:C76([ActionSociale:26])>0)
			DELETE SELECTION:C66([ActionSociale:26])
		End if 
		READ ONLY:C145([ActionSociale:26])
	End if 
	DELETE RECORD:C58($1->)
	UNLOAD RECORD:C212($1->)
	$0:=True:C214
End if 
READ ONLY:C145($1->)