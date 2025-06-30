//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Conso_RG_Message
//{
//{          Lundi 31 janvier 2011 à 11:10
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_BOOLEAN:C305($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

READ WRITE:C146([Messagerie:34])
CREATE RECORD:C68([Messagerie:34])

MultiSoc_Init_Structure(->[Messagerie:34])

[Messagerie:34]MS_RéférenceID:1:=Uut_Numerote(->[Messagerie:34])
[Messagerie:34]MS_Groupe:5:="115"

If ($1)
	[Messagerie:34]MS_User:4:=-1
	[Messagerie:34]MS_Catégorie:6:="Consolidation régionale"
	[Messagerie:34]MS_Date:2:=Current date:C33(*)
	[Messagerie:34]MS_Heure:3:=Current time:C178(*)
Else 
	[Messagerie:34]MS_User:4:=<>vl_UserRéfU
	[Messagerie:34]MS_Catégorie:6:="Consolidation régionale Poste"
	[Messagerie:34]MS_Date:2:=Current date:C33
	[Messagerie:34]MS_Heure:3:=Current time:C178
End if 

[Messagerie:34]MS_Catégorie:6:=[Messagerie:34]MS_Catégorie:6+" "+$2
[Messagerie:34]MS_Texte:7:=$3
[Messagerie:34]MS_Texte:7:=[Messagerie:34]MS_Texte:7+Char:C90(13)+$4
SAVE RECORD:C53([Messagerie:34])

UNLOAD RECORD:C212([Messagerie:34])
READ ONLY:C145([Messagerie:34])