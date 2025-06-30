//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_ReportPasse2a
//{
//{          Lundi 19 janvier 2004 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

READ WRITE:C146([HeberGement:5])
CREATE RECORD:C68([HeberGement:5])
MultiSoc_Init_Structure(->[HeberGement:5])
[HeberGement:5]HG_DateCreationFiche:149:=Current date:C33(*)
If (F_VariablesTransite(4; 3; False:C215; $1; $2; $3; $4))
End if 

//Le 6/5/2009
[HeberGement:5]HG_Signalement:12:="*Report"

[HeberGement:5]HG_ModifDateHeures:152:=F_DateHeureMinuteAlpha(Current date:C33(*); Current time:C178(*))  //19/7/2010

SAVE RECORD:C53([HeberGement:5])
UNLOAD RECORD:C212([HeberGement:5])
READ ONLY:C145([HeberGement:5])