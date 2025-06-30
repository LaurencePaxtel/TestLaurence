//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : Uut_NumerotePlus
//{
//{          Lundi 21 mai 2001 à 18:24
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}


//$1 soit un pointeur sur fichier ou un pointeur sur variable
//Renvoi un numéro de fiche

C_POINTER:C301($1)
C_LONGINT:C283($2)

C_TIME:C306($h)

C_LONGINT:C283($0)

If (Is a variable:C294($1))
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=$1->)
	MultiSoc_Filter(->[ReferenceUnique:2])
	$FileToCreat:=$1->
Else 
	QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256($1))
	MultiSoc_Filter(->[ReferenceUnique:2])
	$FileToCreat:=Table name:C256($1)
End if 

If (Records in selection:C76([ReferenceUnique:2])>=1)  //Ce n'est pas la première fiche
	READ WRITE:C146([ReferenceUnique:2])
	While (Locked:C147([ReferenceUnique:2]))
		$h:=Current time:C178(*)
		While ($h=Current time:C178(*))
		End while 
		LOAD RECORD:C52([ReferenceUnique:2])
	End while 
	$0:=[ReferenceUnique:2]RU_Numero:3+1
	[ReferenceUnique:2]RU_Numero:3:=[ReferenceUnique:2]RU_Numero:3+$2
	SAVE RECORD:C53([ReferenceUnique:2])
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
Else 
	CREATE RECORD:C68([ReferenceUnique:2])  //C'est la première fiche 
	MultiSoc_Init_Structure(->[ReferenceUnique:2])
	[ReferenceUnique:2]RU_Fichier:2:=$FileToCreat
	[ReferenceUnique:2]RU_Numero:3:=$2
	[ReferenceUnique:2]RU_ValeurApha:4:=""
	SAVE RECORD:C53([ReferenceUnique:2])
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
	$0:=1
End if 

