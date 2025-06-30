//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_DosSocialVeille
//{
//{          Vendredi 3 mars 2006 à 13:25
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
READ ONLY:C145(*)

C_BOOLEAN:C305(vb_passe1)
C_BOOLEAN:C305(vb_TuQuitte)
C_LONGINT:C283(vL_Nb_HB_F)
C_LONGINT:C283(vL_Nb_HG_F)
C_TEXT:C284(va_Nb_HG_F)
C_TIME:C306(vh_Clic1)
C_TIME:C306(vh_Clic2)
vL_Nb_HB_F:=0
vL_Nb_HG_F:=0
vb_passe1:=False:C215
ve_NbMar:=0

C_LONGINT:C283(vL_NbFiches; $ii)
vL_NbFiches:=0
C_TEXT:C284(va_Titre)
C_TEXT:C284(va_LibelléMRs)

C_BOOLEAN:C305(vb_MRferme)

DébutDécTableCritèreVeilDS(1)

//AUTRES CRITERES
ARRAY TEXT:C222(ta_xCritères; 18)
ARRAY INTEGER:C220(te_xCritères; Size of array:C274(ta_xCritères))
For ($ii; 1; Size of array:C274(ta_xCritères))
	te_xCritères{$ii}:=0
End for 
ta_xCritères{1}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{4}  //Etat civil
ta_xCritères{2}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{18}  //nationalité
ta_xCritères{3}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9}  //Lieu de naissance= lieu né ou
ta_xCritères{4}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{10}  //Langue
ta_xCritères{5}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{11}  //Provenance=dernier hébergement
ta_xCritères{6}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{21}  //Personne majeu = haute garonne depuis
ta_xCritères{7}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{25}  //Temps d'errance
ta_xCritères{8}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{27}  //Problématique = compagnie
ta_xCritères{9}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{26}  //Probléme de santé = connaissance
ta_xCritères{10}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{38}  //papier d'identité 1
ta_xCritères{11}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{42}  //papier d'identité 2
ta_xCritères{12}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{12}  //Motif = connu SSP
ta_xCritères{13}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{50}  //Couverture so 1
ta_xCritères{14}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{52}  //Couverture so 2
ta_xCritères{15}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{54}  //Couverture so 3
ta_xCritères{16}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{58}  //Ressource 1
ta_xCritères{17}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{60}  //Ressource 2
ta_xCritères{18}:=<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{62}  //Ressource 3

ta_xCritères:=1
ta_xCritères{0}:=ta_xCritères{ta_xCritères}





V_HG_Dec(0)
V_HG_Dec(1)

If (F_VariablesTransite(0; 1; False:C215))
End if 
If (F_VariablesTransite(1; 1; False:C215))
End if 
P_VarDS(0)

ARRAY TEXT:C222(ta_MRLib; 10)
ARRAY TEXT:C222(ta_MRCode; 10)
ta_MRLib{1}:="Papiers d'identité"
ta_MRLib{2}:="Couverture sociale"
ta_MRLib{3}:="Ressources"
ta_MRLib{4}:="Régime"
ta_MRLib{5}:="Suivi social"
ta_MRLib{6}:="Orientation sociale"
ta_MRLib{7}:="Aide"
ta_MRLib{8}:="Prolongation dans le centre"
ta_MRLib{9}:="-"
ta_MRLib{10}:="Tous"

ta_MRCode{1}:="Identité"
ta_MRCode{2}:="Couverture"
ta_MRCode{3}:="Ressources"
ta_MRCode{4}:="Régime"
ta_MRCode{5}:="Suivi"
ta_MRCode{6}:="Orientation"
ta_MRCode{7}:="Aide"
ta_MRCode{8}:="Prolongation"
ta_MRCode{9}:="-"
ta_MRCode{10}:="@"

C_TEXT:C284(va_HGRPré)
C_DATE:C307(va_HGRNé)
va_HGRPré:=""
va_HGRNé:=!00-00-00!
vb_TuQuitte:=False:C215
C_LONGINT:C283(vL_RéfHBOld)
C_LONGINT:C283(vL_RéfHBNew)
C_TEXT:C284(vt_Texte)
C_TEXT:C284(va_MRsexe)

ARRAY TEXT:C222(ta_Page; 4)
ta_Page{1}:="Dossier social"
ta_Page{2}:="Sortie"
ta_Page{3}:="Enfants"
ta_Page{4}:="Référents"
ta_Page:=1

C_TEXT:C284(va_QuelDossier)
va_QuelDossier:="DS"

C_TEXT:C284($T_Window_titre)
$T_Window_titre:="Veille sociale"

//••• TABLEAU •••
//Etat civil
//TABLEAU ALPHA(45;ta_xEtCiv;0)
//COPIER TABLEAU(◊ta_TBEtCiv;ta_xEtCiv)
//TABLEAU ENTIER(te_xEtCiv;Taille tableau(ta_xEtCiv))
//Boucle ($ii;1;Taille tableau(ta_xEtCiv))
// te_xEtCiv{$ii}:=1
//Fin de boucle 


DébutDécTableCritèreDS(1)

//AUTRES CRITERES
ARRAY TEXT:C222(ta_xCritères; 14)
ARRAY INTEGER:C220(te_xCritères; Size of array:C274(ta_xCritères))
For ($ii; 1; Size of array:C274(ta_xCritères))
	te_xCritères{$ii}:=0
End for 
ta_xCritères{1}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{4}
ta_xCritères{2}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{18}
ta_xCritères{3}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{21}
ta_xCritères{4}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{12}
ta_xCritères{5}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{27}
ta_xCritères{6}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{42}
ta_xCritères{7}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{38}
ta_xCritères{8}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{46}
ta_xCritères{9}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{58}
ta_xCritères{10}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{25}
ta_xCritères{11}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{9}
ta_xCritères{12}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{10}
ta_xCritères{13}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{11}
ta_xCritères{14}:=<>ta_RdsNomNew{<>vlSTR_DS-<>vlSTR}{50}

ta_xCritères:=1
ta_xCritères{0}:=ta_xCritères{ta_xCritères}


P_DosSocialVeilleSort(0)

READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_DosSocialVeille")
va_Titre:="Veille dossier social"
//$vl_Fenetre:=i_FenêtreNo (786;508;4;va_Titre;1;"Quit_Show")
$vl_Fenetre:=FEN_OpenFormWindow(->[DiaLogues:3]; "DP_DosScialVeille"; Form fenêtre standard:K39:10; $T_Window_titre)  //lpc plein écran 12/10/2018
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])


POST OUTSIDE CALL:C329(<>PR_HBNotesV)
<>PR_DosSocialVeille:=0
If (vb_Show)
	Général_Show
End if 