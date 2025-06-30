//%attributes = {}
//{=================================================================}
//{ DB.solutions : Solidarite
//{         Methode : P_SIAO_BDOS_Find
//{         lundi 7 novembre 2011 a 16:33:59
//{         Developpement : DBs / Acces 4D : ßPAXTEL_DBs
//{=================================================================}
ARRAY LONGINT:C221($tl_ID; 0)
$vb_OK:=False:C215
If ([DiaLogues:3]DL_Date:2>!00-00-00!)
	If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
		QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Date:2=[DiaLogues:3]DL_Date:2)
	Else 
		QUERY:C277([SIAO:50]; [SIAO:50]Si_Demande_Date:2>=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([SIAO:50];  & ; [SIAO:50]Si_Demande_Date:2<=[DiaLogues:3]DL_Date2:8)
	End if 
	MultiSoc_Filter(->[SIAO:50])
	$vb_OK:=True:C214
Else 
	REDUCE SELECTION:C351([SIAO:50]; 0)
End if 
vL_NbFiches:=Records in selection:C76([SIAO:50])
vL_NbFichesDossier:=vL_NbFiches
vL_NbFichesDosPers:=0
If (vL_NbFichesDossier>0)
	SELECTION TO ARRAY:C260([SIAO:50]Si_RéférenceID:1; $tl_ID)
	QUERY WITH ARRAY:C644([SIAO_Personnes:51]Sp_SIAO_ID:2; $tl_ID)
	vL_NbFichesDosPers:=Records in selection:C76([SIAO_Personnes:51])
End if 

ORDER BY:C49([SIAO:50]; [SIAO:50]Si_Demande_Date:2; <; *)
ORDER BY:C49([SIAO:50]; [SIAO:50]Si_Demande_Numero:3; >)




If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
Else 
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=[DiaLogues:3]DL_Date:2; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=[DiaLogues:3]DL_Date2:8; *)
End if 
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
//CHERCHER([HeberGement]; & ;[HeberGement]HG_NuitTOTAL>1;*)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitReste:95=0)
MultiSoc_Filter(->[HeberGement:5])
vL_NbFichesSortant:=Records in selection:C76([HeberGement:5])



If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
Else 
	QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=[DiaLogues:3]DL_Date:2; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=[DiaLogues:3]DL_Date2:8; *)
End if 
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)

MultiSoc_Filter(->[HeberGement:5])

vL_NbFichesEntrant:=Records in selection:C76([HeberGement:5])

If (7=8)
	If ([DiaLogues:3]DL_Date:2=[DiaLogues:3]DL_Date2:8)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4=[DiaLogues:3]DL_Date:2; *)
	Else 
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=[DiaLogues:3]DL_Date:2; *)
		QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=[DiaLogues:3]DL_Date2:8; *)
	End if 
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitenCours:92=1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_NuitTOTAL:93=1; *)
	QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_CentreNom:62=(<>va_T_CentreSIAOPrestation+"@"))
	
	MultiSoc_Filter(->[HeberGement:5])
	
	vL_NbFichesSIAOSeul:=Records in selection:C76([HeberGement:5])
End if 