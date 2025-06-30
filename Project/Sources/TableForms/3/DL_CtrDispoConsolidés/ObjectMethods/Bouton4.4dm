//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Rec_CentreLitsConso
//{
//{          Vendrdi 26 novembre 2004 à 17:10:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($ii)

For ($ii; 1; Size of array:C274(<>ta_Niveau))
	<>te_Niveau{$ii}:=0
End for 
<>te_Niveau{1}:=1
Rec_CentreLitsConso
vL_NbFichesConso:=Records in selection:C76([CentresLits:16])
If (vL_NbFichesConso>0)
	i_Message("Traitement en cours …")
	Rec_CentreLitsConsoStat([DiaLogues:3]DL_Date:2)
	CLOSE WINDOW:C154
End if 
For ($ii; 1; Size of array:C274(<>ta_Niveau))
	<>te_Niveau{$ii}:=1
End for 
Rec_CentreLitsConso

P_SommeLit(3)
REDRAW:C174([CentresLits:16])
FIRST RECORD:C50([CentresLits:16])
PREVIOUS RECORD:C110([CentresLits:16])
