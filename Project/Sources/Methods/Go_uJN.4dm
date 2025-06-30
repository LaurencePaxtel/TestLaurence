//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : Go_uJN
//{
//{          Vendredi 5 novembre 2004 à 18:50:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
READ ONLY:C145(*)
SET MENU BAR:C67(1)

C_BOOLEAN:C305(vb_Show)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 
C_TEXT:C284(va_TxtTemp)
C_LONGINT:C283(rJourNuit1; rJourNuit2; w1; w2; s1; s2)



$ii:=42
ARRAY TEXT:C222(ta_LesIndices; $ii)
ARRAY INTEGER:C220(te_LesIndices; $ii)

te_LesIndices{1}:=<>ve_M_Demande
ta_LesIndices{1}:="Demande de prestations"


te_LesIndices{2}:=<>ve_M_Adresses
ta_LesIndices{2}:="Adresses utiles"

te_LesIndices{3}:=<>ve_M_Situations
ta_LesIndices{3}:="Situations particulières"

te_LesIndices{4}:=<>ve_M_Associations
ta_LesIndices{4}:="Associations"

te_LesIndices{5}:=<>ve_M_Centres
ta_LesIndices{5}:="Centres d'hébergement"

te_LesIndices{6}:=<>ve_M_Disponibilités
ta_LesIndices{6}:="Disponibilités"

te_LesIndices{7}:=<>ve_M_Options
ta_LesIndices{7}:="Option Veille"

te_LesIndices{8}:=<>ve_M_Transmission
ta_LesIndices{8}:="Transmission"

te_LesIndices{9}:=<>ve_M_Différée
ta_LesIndices{9}:="Saisie différée"

te_LesIndices{10}:=<>ve_M_Prolongation
ta_LesIndices{10}:="Prolongation"

te_LesIndices{11}:=<>ve_M_Utilitaires
ta_LesIndices{11}:="Utilitaires"

te_LesIndices{12}:=<>ve_M_LocRec
ta_LesIndices{12}:="Recherche"

te_LesIndices{13}:=<>ve_M_LocFic
ta_LesIndices{13}:="Fiche n°"

te_LesIndices{14}:=<>ve_M_HbJour
ta_LesIndices{14}:="Jour héb."

te_LesIndices{15}:=<>ve_M_HbNuit
ta_LesIndices{15}:="Nuit héb."

te_LesIndices{16}:=<>ve_M_TélJour
ta_LesIndices{16}:="Jour Tél."

te_LesIndices{17}:=<>ve_M_TélNuit
ta_LesIndices{17}:="Nuit Tél."

te_LesIndices{18}:=<>ve_M_Items
ta_LesIndices{18}:="Items"

te_LesIndices{19}:=<>ve_M_Fusion
ta_LesIndices{19}:="Fusion"

te_LesIndices{20}:=<>ve_M_Veil115
ta_LesIndices{20}:="115"

te_LesIndices{21}:=<>ve_M_VeilMaraude
ta_LesIndices{21}:="Maraude"

te_LesIndices{22}:=<>ve_M_MarJour
ta_LesIndices{22}:="Jour Mar."

te_LesIndices{23}:=<>ve_M_MarNuit
ta_LesIndices{23}:="Nuit Mar."

te_LesIndices{24}:=<>ve_M_Etats
ta_LesIndices{24}:="Etats"

te_LesIndices{25}:=<>ve_M_Prestations
ta_LesIndices{25}:="Prestations"

te_LesIndices{26}:=<>ve_M_Accueil
ta_LesIndices{26}:="P. Acceuil"

te_LesIndices{27}:=<>ve_M_Liste
ta_LesIndices{27}:="Liste"

te_LesIndices{28}:=<>ve_M_Report
ta_LesIndices{28}:="Report"

te_LesIndices{29}:=<>ve_M_Santé
ta_LesIndices{29}:="Santé"

te_LesIndices{30}:=<>ve_MT_Localisation
ta_LesIndices{30}:="  "+xliff_Txt_Get_Indexed_String_(30004; 51)  //Get indexed string

te_LesIndices{31}:=<>ve_MT_Hébergement
ta_LesIndices{31}:="  "+xliff_Txt_Get_Indexed_String_(30004; 52)


te_LesIndices{32}:=<>ve_MT_Télécopie
ta_LesIndices{32}:="  "+xliff_Txt_Get_Indexed_String_(30004; 53)

te_LesIndices{33}:=<>ve_MT_Transfert
ta_LesIndices{33}:="  "+xliff_Txt_Get_Indexed_String_(30004; 54)

te_LesIndices{34}:=<>ve_MT_Veille
ta_LesIndices{34}:="  "+xliff_Txt_Get_Indexed_String_(30004; 55)

te_LesIndices{35}:=<>ve_MT_Maraude
ta_LesIndices{35}:="  "+xliff_Txt_Get_Indexed_String_(30004; 56)

te_LesIndices{36}:=<>ve_MT_Social
ta_LesIndices{36}:="  "+xliff_Txt_Get_Indexed_String_(30004; 57)

te_LesIndices{37}:=<>ve_MT_Stats
ta_LesIndices{37}:="  "+xliff_Txt_Get_Indexed_String_(30004; 58)

te_LesIndices{38}:=<>ve_MT_Dossier
ta_LesIndices{38}:="  "+xliff_Txt_Get_Indexed_String_(30004; 59)

te_LesIndices{39}:=<>ve_M_SiaoDossier
ta_LesIndices{39}:="SIAO Dossier"

te_LesIndices{40}:=<>ve_M_SiaoVeil
ta_LesIndices{40}:="SIAO Veille"


te_LesIndices{41}:=<>ve_M_AnonymeStat
ta_LesIndices{41}:="Anonymes Stats"

te_LesIndices{42}:=<>ve_M_AnonymeExport
ta_LesIndices{42}:="Anonymes Exports"


va_Titre:="Paramètres de disponibilité"
$vl_Fenetre:=i_FenêtreNo(466; 447; 16; va_Titre; 3; "Quit_Simple")
DIALOG:C40([DiaLogues:3]; "DL_ParamDispo")

CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_JN:=0
If (vb_Show)
	Général_Show
End if 