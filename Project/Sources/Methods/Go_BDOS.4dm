//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_Appel
//{          Vendredi 25 novembre 2011 à 17:54:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)
READ ONLY:C145(*)
C_BOOLEAN:C305($vb_OK)



$vb_OK:=F_BDOS_Tables("Initialiser"; ""; 0)
$vb_OK:=F_BDOS_Tables("Declarer"; "Tables"; 0)
$vb_OK:=P_DatesPlageEnCours(0; True:C214)
$vb_OK:=F_SIAO_Var_Page(0; 0)

C_BOOLEAN:C305(vb_OKFalse)


P_SIAO_VeilleColonne(0)

ARRAY TEXT:C222(<>ta_SIAOREC_EtCv; 0)
ARRAY INTEGER:C220(<>te_SIAOREC_EtCv; 0)
COPY ARRAY:C226(<>ta_SIAO_EtCiv; <>ta_SIAOREC_EtCv)
ARRAY INTEGER:C220(<>te_SIAOREC_EtCv; Size of array:C274(<>ta_SIAOREC_EtCv))
For ($ii; 1; Size of array:C274(<>ta_SIAOREC_EtCv))
	<>te_SIAOREC_EtCv{$ii}:=1
End for 

ARRAY TEXT:C222(<>ta_SIAOREC_Statut; 0)
ARRAY INTEGER:C220(<>te_SIAOREC_Statut; 0)
COPY ARRAY:C226(<>ta_SIAO_Etat; <>ta_SIAOREC_Statut)
ARRAY INTEGER:C220(<>te_SIAOREC_Statut; Size of array:C274(<>ta_SIAOREC_Statut))
For ($ii; 1; Size of array:C274(<>ta_SIAOREC_Statut))
	<>te_SIAOREC_Statut{$ii}:=1
End for 

ARRAY TEXT:C222(<>ta_SIAOREC_LogAct; 0)
ARRAY INTEGER:C220(<>te_SIAOREC_LogAct; 0)
COPY ARRAY:C226(<>ta_SIAO_LogActuel; <>ta_SIAOREC_LogAct)
ARRAY INTEGER:C220(<>te_SIAOREC_LogAct; Size of array:C274(<>ta_SIAOREC_LogAct))
For ($ii; 1; Size of array:C274(<>ta_SIAOREC_LogAct))
	<>te_SIAOREC_LogAct{$ii}:=1
End for 

ARRAY TEXT:C222(ta_xCritères; 2)
ARRAY INTEGER:C220(te_xCritères; Size of array:C274(ta_xCritères))
For ($ii; 1; Size of array:C274(ta_xCritères))
	te_xCritères{$ii}:=0
End for 
ta_xCritères{1}:="Etat civil"
ta_xCritères{2}:="Statut de la demande"
//ta_xCritères{3}:="Logement actuel"
ta_xCritères:=1
ta_xCritères{0}:=ta_xCritères{ta_xCritères}
C_LONGINT:C283(vL_NbFichesDossier; vL_NbFichesDosPers; vL_NbFichesEntrant; vL_NbFichesSortant; vL_NbFichesSIAOSeul)


READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_BDOS")
$vl_Fenetre:=i_FenêtreNo(1024; 675; 4; "BDOS"; 1; "Quit_Simple")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])

<>PR_BDOS:=0