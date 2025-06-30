//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_SommeVeille
//{
//{          Jeudi 7 octobre 2010 à 10:23:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_DATE:C307($2)

C_DATE:C307(vd_Date1)
C_LONGINT:C283(vL_NbFiches; vl_TTcapacite; vl_TTattribue; vl_TTreste)
C_TEXT:C284(va_ValeurItem; 0)
C_BOOLEAN:C305($vb_OK)
vl_TTcapacite:=0
vl_TTattribue:=0
vl_TTreste:=0
SET MENU BAR:C67(1)
READ ONLY:C145(*)

READ WRITE:C146([DiaLogues:3])
READ WRITE:C146([Sommes:48])
vd_Date1:=$2
va_ValeurItem:=""
Case of 
	: ($1=(-><>PR_SomOrient1))
		//◊ta_RdsNomNew{◊vlSTR_Std-◊vlSTR}{48};->◊ta_TBOr1;->[HéberGement]HG_Orientation1)
		va_ValeurItem:="Orientation1"
		$vb_OK:=F_SommeVeille(va_ValeurItem; vd_Date1)
		
End case 


FORM SET INPUT:C55([DiaLogues:3]; "DL_SommeItem")
$vl_Fenetre:=i_FenêtreNo(485; 478; 4; "Suivi"; 22; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
UNLOAD RECORD:C212([Sommes:48])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
READ ONLY:C145([Sommes:48])



$1->:=0