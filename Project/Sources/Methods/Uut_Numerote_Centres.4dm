//%attributes = {}
//Procédure : Uut_Numerote_Centres
//Mercredi 29 Novembre 1995 23:03
//Philippe GUEDJ

//$1 soit un pointeur sur fichier ou un pointeur sur variable
//Renvoi un numéro de fiche

C_TIME:C306($h)
C_LONGINT:C283($0)
C_BOOLEAN:C305($multisoc_table_check)
$multisoc_table_check:=True:C214

$multisoc_table_check:=False:C215  //traitement spécifique pour la numérotation des fiches des centres

QUERY:C277([ReferenceUnique:2]; [ReferenceUnique:2]RU_Fichier:2=Table name:C256($1))
MultiSoc_Filter(->[ReferenceUnique:2]; $multisoc_table_check)
$FileToCreat:=Table name:C256($1)


If (Records in selection:C76([ReferenceUnique:2])>=1)  //Ce n'est pas la première fiche
	READ WRITE:C146([ReferenceUnique:2])
	While (Locked:C147([ReferenceUnique:2]))
		$h:=Current time:C178
		While ($h=Current time:C178)
			
		End while 
		LOAD RECORD:C52([ReferenceUnique:2])
	End while 
	[ReferenceUnique:2]RU_Numero:3:=[ReferenceUnique:2]RU_Numero:3+1
	$0:=[ReferenceUnique:2]RU_Numero:3
	SAVE RECORD:C53([ReferenceUnique:2])
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
Else 
	CREATE RECORD:C68([ReferenceUnique:2])  //C'est la première fiche 
	MultiSoc_Init_Structure(->[ReferenceUnique:2])
	[ReferenceUnique:2]RU_Fichier:2:=$FileToCreat
	[ReferenceUnique:2]RU_Numero:3:=<>vl_T_CentreCodeDebut
	[ReferenceUnique:2]RU_ValeurApha:4:=""
	SAVE RECORD:C53([ReferenceUnique:2])
	UNLOAD RECORD:C212([ReferenceUnique:2])
	READ ONLY:C145([ReferenceUnique:2])
	$0:=1
End if 