//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_SommeVeilleAppel
//{
//{          Jeudi 7 octobre 2010 à 10:23:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215

C_DATE:C307($1)
C_TEXT:C284($2)


[DiaLogues:3]DL_Date:2:=$1
[DiaLogues:3]DL_Date2:8:=$1
[DiaLogues:3]DL_LibelAutre:5:=""
[DiaLogues:3]DL_Libellé:3:=""
[DiaLogues:3]DL_LibelPlus:6:=""
[DiaLogues:3]DL_LibelléN:9:=""
[DiaLogues:3]DL_LibelléG:10:=""



r1:=1
r2:=0
r3:=0
r4:=0
r5:=0
r6:=0
r7:=0
r8:=0
sOr1:=0
tLocal:=0
rDernièreF:=0

fFicheNuit:=0

If (<>vb_T_ModeCHRS=True:C214)
	rJourNuit1:=1  //Jour
	rJourNuit2:=0  //Nuit
	JourNuit1:=1  //Jour
	JourNuit2:=0  //Nuit
	
	wSansFiltre:=1
Else 
	rJourNuit1:=1  //Jour
	rJourNuit2:=0  //Nuit
	JourNuit1:=1  //Jour
	JourNuit2:=0  //Nuit
	
	wSansFiltre:=0
End if 



rReports:=1
rDoublons:=0
vl_SourisX:=0
vl_SourisY:=0
vl_SourisBt:=0
DébutDécTableCritèreVeille(4)

For ($ii; 1; Size of array:C274(<>ta_VeilOrient1))
	If (<>ta_VeilOrient1{$ii}=$2)  //($2+"@"))  `
		<>te_VeilOrient1{$ii}:=1
	Else 
		<>te_VeilOrient1{$ii}:=0
	End if 
End for 



P_HébergementVeilleFind
OBJECT SET ENABLED:C1123(b_RecNomClé; False:C215)

