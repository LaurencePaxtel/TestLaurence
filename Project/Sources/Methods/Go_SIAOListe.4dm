//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Go_SIAO
//{          Lundi 29 novembre 2010 à 18:26
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}



READ ONLY:C145(*)

SET MENU BAR:C67(1)
C_LONGINT:C283($vl_Fenetre; $i; $j)
C_BOOLEAN:C305(vb_Show; $vb_OK)
vb_Show:=False:C215
If (vb_Show)
	Général_Hide
End if 

C_TEXT:C284(va_Titre; va_Page)
C_LONGINT:C283(vL_NbFiches)
C_BOOLEAN:C305(vb_Sel_CleUnique)
C_LONGINT:C283(vl_Sel_CleUnique; vL_Nb_HG_F; vl_NbHGi; vL_Nb_SI_F; vl_NbHGs; ve_NbSP)

C_LONGINT:C283(rAn1; rAn2; trans1; trans2; Dem1; Dem2; Dem3; Ferm1)
C_LONGINT:C283(vl_SIAO_RefAttestation)
vl_SIAO_RefAttestation:=0
vL_NbFiches:=0  //Enregistrements trouves([SIAO]))
va_Titre:="Veille Aides Sociales"
//••• DATE DE SÉLECTION
$vb_OK:=P_DatesPlageEnCours(0; True:C214)

V_IDT_Déc(0)
$vb_OK:=F_SIAO_Var_Page(0; 0)

$vb_OK:=F_SIAO_Var_Attestation(0; 0)

//••• TRI
P_SIAO_Sort(0)

C_LONGINT:C283(vl_CleUnique_ID)
C_TEXT:C284(va_TitreETCV)
C_TEXT:C284(va_TitreCasReserve; va_TitreCasANNUL; va_TitreDemande)
va_TitreETCV:=""
va_TitreCasANNUL:=""
va_TitreCasReserve:=""
va_TitreProposition:=""
va_TitreDemande:=""

//RECHERCHE PAR AGE
C_LONGINT:C283(ve_RecAge; ve_RecAgeDebut; ve_RecAgeFin)
C_DATE:C307(vd_RecAge; vd_RecAgeDebut; vd_RecAgeFin)
ve_RecAge:=0
ve_RecAgeDebut:=0
ve_RecAgeFin:=0
vd_RecAge:=Current date:C33
vd_RecAgeDebut:=!00-00-00!
vd_RecAgeFin:=!00-00-00!

P_SIAO_VeilleColonne(0)

C_LONGINT:C283(<>LH_ListeSIAOinfo)
<>LH_ListeSIAOinfo:=New list:C375

//SITUATION FAMILIALE
//   Demandeur
//   Conjoint
//   Enfants
//SITUATION PROFESSIONNELLE
//  Emploi
//     Demandeur
//     Conjoint
//  Emandeur d'emploi inscrit
//     Demandeur
//     Conjoint
//  Retraire
//     Demandeur
//     Conjoint
//  Sans Activité
//     Demandeur
//     Conjoint
//RESSOURCES DE LA FAMILLE
//  Revenus
//     Demandeur
//     Conjoint
//RENSEIGNEMENTS ADMINISTRATIFS
//  Numéros
//     Demandeur
//     Conjoint
//  Demandes
//     Demandeur
//     Conjoint

//ENDETTEMENTS
//  Demandeur endetté
//  Les endettements
//     Famille
//     Demandeur
//     Conjoint
//  Dossier de surendettement

//SITUATION AU REGARD DES DISPOSITIFS D'AIDE AU LOGEMEMENT
//  Demande
//  Accord
//SITUATION AU REGARD DU LOGEMEMENT OU DE L'HEBERGEMENT
//MOTIF de la DEMANDE DE LA PERSONNE


// "Etat civil"
// "Référent"
// "Statut de la demande"
// "SIAO compétent"
// "Site d'accueil"
//                ajouté 21/12/16
// "Lieu d’origine"
// "Nationalité"
// "Cas spécifique"
// "Logement souhaité 1"
// "Logement souhaité 2"
// "Logement souhaité 3"
// "Logement adapté"
// "Type d’accompagnement souhaite 1"
// "Type d’accompagnement souhaite 2"
// "Type d’accompagnement souhaite 3"
// "Situation professionnelle 1"
// "Situation professionnelle 2"
// "Sans situation professionnelle"
// "Moyen de locomotion"
// "Ressources 1"
// "Logement ou hébergement actuel 1"
// "Motif de la demande 1"
// "Motif de la demande 2"
// "Proposition d’orientation du SIAO 1"
// "Proposition d’orientation du SIAO 2"
// "Proposition d’orientation du SIAO 3"


// "Etat civil"
//ARRAY TEXT(<>ta_SIAOREC_EtCv;0)
//ARRAY INTEGER(<>te_SIAOREC_EtCv;0)
//COPY ARRAY(<>ta_SIAO_EtCiv;<>ta_SIAOREC_EtCv)
//ARRAY INTEGER(<>te_SIAOREC_EtCv;Size of array(<>ta_SIAOREC_EtCv))
//For ($i;1;Size of array(<>ta_SIAOREC_EtCv))
//<>te_SIAOREC_EtCv{$i}:=1
//End for 

//ARRAY TEXT(<>ta_SIAOREC_Statut;0)
//ARRAY INTEGER(<>te_SIAOREC_Statut;0)
//COPY ARRAY(<>ta_SIAO_Etat;<>ta_SIAOREC_Statut)
//ARRAY INTEGER(<>te_SIAOREC_Statut;Size of array(<>ta_SIAOREC_Statut))
//For ($i;1;Size of array(<>ta_SIAOREC_Statut))
//<>te_SIAOREC_Statut{$i}:=1
//End for 



// "SIAO compétent"
//ARRAY TEXT(<>ta_SIAOREC_Competent;0)
//ARRAY INTEGER(<>te_SIAOREC_Competent;0)
//COPY ARRAY(<>ta_SIAO_Competent;<>ta_SIAOREC_Competent)
//ARRAY INTEGER(<>te_SIAOREC_Competent;Size of array(<>ta_SIAOREC_Competent))
//For ($i;1;Size of array(<>ta_SIAOREC_Competent))
//<>te_SIAOREC_Competent{$i}:=1
//End for 

// accueil
//ARRAY TEXT(<>ta_SIAOREC_SitAccueil;0)
//ARRAY INTEGER(<>te_SIAOREC_SitAccueil;0)
//ARRAY LONGINT(<>tl_SIAOREC_SitAccueil;0)

//ALL RECORDS([SIAO_SiteAccueil])
//ORDER BY([SIAO_SiteAccueil];[SIAO_SiteAccueil]Sr_NomPrénom)
//SELECTION TO ARRAY([SIAO_SiteAccueil]Sr_RéférenceID;<>tl_SIAOREC_SitAccueil;[SIAO_SiteAccueil]Sr_NomPrénom;<>ta_SIAOREC_SitAccueil)

//ARRAY INTEGER(<>te_SIAOREC_SitAccueil;Size of array(<>ta_SIAOREC_SitAccueil))
//For ($i;1;Size of array(<>ta_SIAOREC_SitAccueil))
//<>te_SIAOREC_SitAccueil{$i}:=1
//End for 



// "Référent"
//ARRAY TEXT(<>ta_SIAOREC_Referent;0)
//ARRAY TEXT(<>ta_SIAOREC_ReferentBis;0)
//ARRAY INTEGER(<>te_SIAOREC_Referent;0)
//COPY ARRAY(<>ta_InPerm;<>ta_SIAOREC_Referent)

//ALL RECORDS([SIAO])
//ORDER BY([SIAO];[SIAO]Si_ReferentPermanencier;>)
//DISTINCT VALUES([SIAO]Si_ReferentPermanencier;<>ta_SIAOREC_ReferentBis)

//If (Size of array(<>ta_SIAOREC_ReferentBis)>0)

//For ($i;1;Size of array(<>ta_SIAOREC_ReferentBis))
//$L_Pos:=Find in array(<>ta_SIAOREC_Referent;<>ta_SIAOREC_ReferentBis{$i})
//If ($L_Pos<=0)
//$j:=Size of array(<>ta_SIAOREC_Referent)+1
//INSERT IN ARRAY(<>ta_SIAOREC_Referent;$j;1)
//<>ta_SIAOREC_Referent{$j}:=<>ta_SIAOREC_ReferentBis{$i}
//End if 
//End for 

//SORT ARRAY(<>ta_SIAOREC_Referent;>)
//End if 


//ARRAY INTEGER(<>te_SIAOREC_Referent;Size of array(<>ta_SIAOREC_Referent))
//For ($i;1;Size of array(<>ta_SIAOREC_Referent))
//<>te_SIAOREC_Referent{$i}:=1
//End for 


// 30/12/16 je ne sais pas à quoi ça sert
//ARRAY TEXT(<>ta_SIAOREC_LogAct;0)
//ARRAY INTEGER(<>te_SIAOREC_LogAct;0)
//COPY ARRAY(<>ta_SIAO_LogActuel;<>ta_SIAOREC_LogAct)
//ARRAY INTEGER(<>te_SIAOREC_LogAct;Size of array(<>ta_SIAOREC_LogAct))
//For ($i;1;Size of array(<>ta_SIAOREC_LogAct))
//<>te_SIAOREC_LogAct{$i}:=1
//End for 




ARRAY TEXT:C222(ta_xCritères; 26)
ta_xCritères{1}:="Etat civil"
ta_xCritères{2}:="Référent"
ta_xCritères{3}:="Statut de la demande"
ta_xCritères{4}:="SIAO compétent"
ta_xCritères{5}:="Site d'accueil"
// ajouté 21/12/16
ta_xCritères{6}:="Lieu d’origine"
ta_xCritères{7}:="Nationalité"
ta_xCritères{8}:="Cas spécifique"
ta_xCritères{9}:="Logement souhaité 1"
ta_xCritères{10}:="Logement souhaité 2"
ta_xCritères{11}:="Logement souhaité 3"
ta_xCritères{12}:="Logement adapté"
ta_xCritères{13}:="Type d’accompagnement souhaite 1"
ta_xCritères{14}:="Type d’accompagnement souhaite 2"
ta_xCritères{15}:="Type d’accompagnement souhaite 3"
ta_xCritères{16}:="Situation professionnelle 1"
ta_xCritères{17}:="Situation professionnelle 2"
ta_xCritères{18}:="Sans situation professionnelle"
ta_xCritères{19}:="Moyen de locomotion"  // a faire après infos
ta_xCritères{20}:="Ressources 1"  // a faire après infos
ta_xCritères{21}:="Logement ou hébergement actuel 1"
ta_xCritères{22}:="Motif de la demande 1"
ta_xCritères{23}:="Motif de la demande 2"
ta_xCritères{24}:="Proposition d’orientation du SIAO 1"
ta_xCritères{25}:="Proposition d’orientation du SIAO 2"
ta_xCritères{26}:="Proposition d’orientation du SIAO 3"

C_LONGINT:C283($L_Size)
$L_Size:=Size of array:C274(ta_xCritères)
ARRAY INTEGER:C220(te_xCritères; $L_Size)
For ($i; 1; $L_Size)
	te_xCritères{$i}:=0
End for 

For ($i; 1; $L_Size)
	
	C_POINTER:C301($P_Tableau_source; $P_Tableau_cible_A; $P_Tableau_cible_E)
	
	CLEAR VARIABLE:C89($P_Tableau_source)
	CLEAR VARIABLE:C89($P_Tableau_cible_A)
	CLEAR VARIABLE:C89($P_Tableau_cible_E)
	
	C_BOOLEAN:C305($B_Copy)
	$B_Copy:=True:C214
	Case of 
		: ($i=1)  // Etat civil
			
			ARRAY TEXT:C222(<>ta_SIAOREC_EtCv; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_EtCv; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_SIAO_EtCiv
			$P_Tableau_cible_A:=-><>ta_SIAOREC_EtCv
			$P_Tableau_cible_E:=-><>te_SIAOREC_EtCv
			
		: ($i=2)  // Référent
			$B_Copy:=False:C215
			
			ARRAY TEXT:C222(<>ta_SIAOREC_Referent; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_Referent; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_InPerm
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Referent
			$P_Tableau_cible_E:=-><>te_SIAOREC_Referent
			
			COPY ARRAY:C226($P_Tableau_source->; $P_Tableau_cible_A->)
			
			// Mise à jour des référents dans le tableau cible seul
			ARRAY TEXT:C222(<>ta_SIAOREC_ReferentBis; 0)
			ALL RECORDS:C47([SIAO:50])
			MultiSoc_Filter(->[SIAO:50])
			DISTINCT VALUES:C339([SIAO:50]Si_ReferentPermanencier:44; <>ta_SIAOREC_ReferentBis)
			
			For ($j; 1; Size of array:C274(<>ta_SIAOREC_ReferentBis))
				
				C_TEXT:C284($T_Referent)
				$T_Referent:=<>ta_SIAOREC_ReferentBis{$j}  // BS corrigé 5/4/17 $j au lieu $i
				If (Find in array:C230($P_Tableau_cible_A->; $T_Referent)=-1)
					APPEND TO ARRAY:C911($P_Tableau_cible_A->; $T_Referent)
				End if 
			End for 
			SORT ARRAY:C229($P_Tableau_cible_A->; >)
			
		: ($i=3)  // Statut de la demande
			
			ARRAY TEXT:C222(<>ta_SIAOREC_Statut; 0)
			ARRAY INTEGER:C220(<>te_SIAOREC_Statut; 0)
			
			$P_Tableau_source:=-><>ta_SIAO_Etat
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Statut
			$P_Tableau_cible_E:=-><>te_SIAOREC_Statut
			
		: ($i=4)  // SIAO compétent
			
			ARRAY TEXT:C222(<>ta_SIAOREC_Competent; 0)
			ARRAY INTEGER:C220(<>te_SIAOREC_Competent; 0)
			
			$P_Tableau_source:=-><>ta_SIAO_Competent
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Competent
			$P_Tableau_cible_E:=-><>te_SIAOREC_Competent
			
		: ($i=5)  // Site accueil
			$B_Copy:=False:C215
			
			ARRAY TEXT:C222(<>ta_SIAOREC_SitAccueil; 0)
			ARRAY INTEGER:C220(<>te_SIAOREC_SitAccueil; 0)
			
			// $P_Tableau_source:=->
			$P_Tableau_cible_A:=-><>ta_SIAOREC_SitAccueil
			$P_Tableau_cible_E:=-><>te_SIAOREC_SitAccueil
			
			ALL RECORDS:C47([SIAO_SiteAccueil:55])
			MultiSoc_Filter(->[SIAO_SiteAccueil:55])
			ARRAY LONGINT:C221(<>tl_SIAOREC_SitAccueil; 0)
			SELECTION TO ARRAY:C260([SIAO_SiteAccueil:55]Sr_RéférenceID:1; <>tl_SIAOREC_SitAccueil; [SIAO_SiteAccueil:55]Sr_NomPrénom:12; <>ta_SIAOREC_SitAccueil)
			SORT ARRAY:C229(<>ta_SIAOREC_SitAccueil; <>tl_SIAOREC_SitAccueil; >)
			REDUCE SELECTION:C351([SIAO_SiteAccueil:55]; 0)
			
		: ($i=6)  // Lieu d’origine
			
			ARRAY TEXT:C222(<>ta_SIAOREC_NeLeLieu; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_NeLeLieu; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_SIAO_NeLeLieu
			$P_Tableau_cible_A:=-><>ta_SIAOREC_NeLeLieu
			$P_Tableau_cible_E:=-><>te_SIAOREC_NeLeLieu
			
		: ($i=7)  // Nationalité
			
			ARRAY TEXT:C222(<>ta_SIAOREC_Nationalite; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_Nationalite; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_SIAO_Nationalite
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Nationalite
			$P_Tableau_cible_E:=-><>te_SIAOREC_Nationalite
			
		: ($i=8)  // cas spécifique
			
			ARRAY TEXT:C222(<>ta_SIAOREC_CasSpec; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_CasSpec; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_SIAO_CasSpec
			$P_Tableau_cible_A:=-><>ta_SIAOREC_CasSpec
			$P_Tableau_cible_E:=-><>te_SIAOREC_CasSpec
			
		: ($i=9) | ($i=10) | ($i=11)  // Logement souhaité 
			
			$P_Tableau_source:=-><>ta_SIAO_Orienter
			Case of 
				: ($i=9)
					ARRAY TEXT:C222(<>ta_SIAOREC_Orienter1; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_Orienter1; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter1
					$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter1
				: ($i=10)
					ARRAY TEXT:C222(<>ta_SIAOREC_Orienter2; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_Orienter2; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter2
					$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter2
				: ($i=11)
					ARRAY TEXT:C222(<>ta_SIAOREC_Orienter3; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_Orienter3; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter3
					$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter3
				Else 
					TRACE:C157
			End case 
			
		: ($i=12)  // Logement adapté
			
			ARRAY TEXT:C222(<>ta_SIAOREC_LogAdapte; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_LogAdapte; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_SIAO_LogAdapte
			$P_Tableau_cible_A:=-><>ta_SIAOREC_LogAdapte
			$P_Tableau_cible_E:=-><>te_SIAOREC_LogAdapte
			
		: ($i=13) | ($i=14) | ($i=15)  // Type d’accompagnement souhaite 1, 2, 3
			
			$P_Tableau_source:=-><>ta_SIAO_TypeAccS
			Case of 
				: ($i=13)
					ARRAY TEXT:C222(<>ta_SIAOREC_TypeAccS1; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_TypeAccS1; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_TypeAccS1
					$P_Tableau_cible_E:=-><>te_SIAOREC_TypeAccS1
				: ($i=14)
					ARRAY TEXT:C222(<>ta_SIAOREC_TypeAccS2; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_TypeAccS2; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_TypeAccS2
					$P_Tableau_cible_E:=-><>te_SIAOREC_TypeAccS2
				: ($i=15)
					ARRAY TEXT:C222(<>ta_SIAOREC_TypeAccS3; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_TypeAccS3; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_TypeAccS3
					$P_Tableau_cible_E:=-><>te_SIAOREC_TypeAccS3
				Else 
					TRACE:C157
			End case 
			
		: ($i=16) | ($i=17)  // Situation professionnelle 1 #[SIAO_Situations]
			
			$P_Tableau_source:=-><>ta_SIAO_SitProf
			Case of 
				: ($i=16)
					ARRAY TEXT:C222(<>ta_SIAOREC_SitProf1; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_SitProf1; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_SitProf1
					$P_Tableau_cible_E:=-><>te_SIAOREC_SitProf1
				: ($i=17)
					ARRAY TEXT:C222(<>ta_SIAOREC_SitProf2; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_SitProf2; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_SitProf2
					$P_Tableau_cible_E:=-><>te_SIAOREC_SitProf2
				Else 
					TRACE:C157
			End case 
			
		: ($i=18)  // Sans situation professionnel
			
			ARRAY TEXT:C222(<>ta_SIAOREC_SanSitProf; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_SanSitProf; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_SIAO_SanSitProf
			$P_Tableau_cible_A:=-><>ta_SIAOREC_SanSitProf
			$P_Tableau_cible_E:=-><>te_SIAOREC_SanSitProf
			
			
		: ($i=19)  // Moyen de locomotion
			
			ARRAY TEXT:C222(<>ta_SIAOREC_Locomotion; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_Locomotion; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_SIAO_Locomotion
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Locomotion
			$P_Tableau_cible_E:=-><>te_SIAOREC_Locomotion
			
		: ($i=20)  // Ressources 1
			
			ARRAY TEXT:C222(<>ta_SIAOREC_Ressource; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_Ressource; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_SIAO_Ressource
			$P_Tableau_cible_A:=-><>ta_SIAOREC_Ressource
			$P_Tableau_cible_E:=-><>te_SIAOREC_Ressource
		: ($i=21)  // Logement ou hébergement actuel 1
			ARRAY TEXT:C222(<>ta_SIAOREC_LogActuel; 0)  // cible A
			ARRAY INTEGER:C220(<>te_SIAOREC_LogActuel; 0)  // cible E
			
			$P_Tableau_source:=-><>ta_SIAO_LogActuel
			$P_Tableau_cible_A:=-><>ta_SIAOREC_LogActuel
			$P_Tableau_cible_E:=-><>te_SIAOREC_LogActuel
			
		: ($i=22) | ($i=23)  // Motif de la demande 1
			
			$P_Tableau_source:=-><>ta_SIAO_MotifDem
			Case of 
				: ($i=22)
					ARRAY TEXT:C222(<>ta_SIAOREC_MotifDem1; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_MotifDem1; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_MotifDem1
					$P_Tableau_cible_E:=-><>te_SIAOREC_MotifDem1
				: ($i=23)
					ARRAY TEXT:C222(<>ta_SIAOREC_MotifDem2; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_MotifDem2; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_MotifDem2
					$P_Tableau_cible_E:=-><>te_SIAOREC_MotifDem2
				Else 
					TRACE:C157
			End case 
			
		: ($i=24) | ($i=25) | ($i=26)
			
			$P_Tableau_source:=-><>ta_SIAO_Orienter
			Case of 
				: ($i=24)
					ARRAY TEXT:C222(<>ta_SIAOREC_Orienter_SIAO1; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_Orienter_SIAO1; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter_SIAO1
					$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter_SIAO1
				: ($i=25)
					ARRAY TEXT:C222(<>ta_SIAOREC_Orienter_SIAO2; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_Orienter_SIAO2; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter_SIAO2
					$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter_SIAO2
				: ($i=26)
					ARRAY TEXT:C222(<>ta_SIAOREC_Orienter_SIAO3; 0)  // cible A
					ARRAY INTEGER:C220(<>te_SIAOREC_Orienter_SIAO3; 0)  // cible E
					$P_Tableau_cible_A:=-><>ta_SIAOREC_Orienter_SIAO3
					$P_Tableau_cible_E:=-><>te_SIAOREC_Orienter_SIAO3
				Else 
					TRACE:C157
			End case 
		Else 
			TRACE:C157
	End case 
	
	If (Not:C34(Is nil pointer:C315($P_Tableau_cible_E)))
		
		If ($B_Copy)
			COPY ARRAY:C226($P_Tableau_source->; $P_Tableau_cible_A->)
		End if 
		
		ARRAY INTEGER:C220($P_Tableau_cible_E->; Size of array:C274($P_Tableau_cible_A->))
		For ($j; 1; Size of array:C274($P_Tableau_cible_E->))
			$P_Tableau_cible_E->{$j}:=1
		End for 
	End if 
End for 




//ta_xCritères{3}:="Logement actuel"
ta_xCritères:=1
ta_xCritères{0}:=ta_xCritères{ta_xCritères}

P_SIAO_Find
READ WRITE:C146([DiaLogues:3])
FORM SET INPUT:C55([DiaLogues:3]; "DL_SIAO")
$vl_Fenetre:=i_FenêtreNo(1024; 675; 4; va_Titre; 1; "Quit_Show")
ADD RECORD:C56([DiaLogues:3])  //lpc 08122017 ascenceur
UNLOAD RECORD:C212([DiaLogues:3])
CLOSE WINDOW:C154($vl_Fenetre)
READ ONLY:C145([DiaLogues:3])
<>PR_SIAOListe:=0
If (vb_Show)
	Général_Show
End if 