//%attributes = {}
// Method [APPOINTMENTS][APPOINTMENTS] fait le matching entre la propriété autre critere et le champ de recherche 
// 
// #SYNTAX: $O_Object:=API_Match_autres_criteres 
// #PARAMETERS:
//     $1 Pointeur        : tableau objet : le matching

// #DATE CREATION: 12/03/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_POINTER:C301($1)

C_TEXT:C284($T_Proprety)
C_LONGINT:C283($i; $L_Indice; $L_Table; $L_Field; $l_size)
C_POINTER:C301($P_Output; $P_Field; $P_Array)

ARRAY TEXT:C222($rT_DummyArray; 0)
ARRAY TEXT:C222($rT_xCriteres; 0)

ARRAY TEXT:C222(<>ta_FMGrpX; 0)

$i:=1
$P_Output:=$1

// je remplis le tableau pour détecter un changement d'item

// Bidouille// #20180518-1
// 18/5/18
// j'ajoute cetten section car le tableau n'est pas initialisé comme les autres
COPY ARRAY:C226(<>ta_FMGrp; <>ta_FMGrpX)

INSERT IN ARRAY:C227(<>ta_FMGrpX; 1; 1)
<>ta_FMGrpX{1}:="Non Saisi"  //LPC 09/10/2023
// fin Bidouille

//DébutAccèsTable  // #20180518-1
//DébutDécTable
//DébutInitTable
DébutDécTableCritèreVeille(0)
DébutDécTableCritèreVeille(1)
DébutDécTableCritèreVeille(2)

COPY ARRAY:C226(ta_xCritères; $rT_xCriteres)  // pour pouvoir travailler sur un tableau local
$l_size:=Size of array:C274($rT_xCriteres)

ARRAY OBJECT:C1221($rO_Match; $l_size)

While ($i<$l_size)
	CLEAR VARIABLE:C89($P_Field)
	CLEAR VARIABLE:C89($T_Proprety)
	CLEAR VARIABLE:C89($L_Table)
	CLEAR VARIABLE:C89($L_Field)
	CLEAR VARIABLE:C89($P_Array)
	
	Case of 
		: ($i=1)
			$P_Field:=->[HeberGement:5]HG_EtatCivil:20
			$P_Array:=-><>ta_VeilEtCiv
		: ($i=2)
			$P_Field:=->[HeberGement:5]HG_FamGroupe:102
			$P_Array:=-><>ta_VeilGroupe
		: ($i=3)
			$P_Field:=->[HeberGement:5]HG_Permanencier:9
			$P_Array:=-><>ta_VeilPerma
		: ($i=4)
			$P_Field:=->[HeberGement:5]HG_Signalement:12
			$P_Array:=-><>ta_VeilSglt
		: ($i=5)
			$P_Field:=->[HeberGement:5]HG_AutreSolutio:88
			$P_Array:=-><>ta_VeilAutreSol
		: ($i=6)
			$P_Field:=->[HeberGement:5]HG_Orientation1:58
			$P_Array:=-><>ta_VeilOrient1
		: ($i=7)
			$P_Field:=->[HeberGement:5]HG_Orientation1Suite:59  //!!!
			$P_Array:=->$rT_DummyArray
		: ($i=8)
			$P_Field:=->[HeberGement:5]HG_AutreSolSuite:123  // !!!!!
			$P_Array:=->$rT_DummyArray
		: ($i=9)
			$P_Field:=->[HeberGement:5]HG_Orientation2:60
			$P_Array:=-><>ta_VeilOrient2
		: ($i=10)
			$P_Field:=->[HeberGement:5]HG_RupMajeur1:40
			$P_Array:=-><>ta_VeilRupMaj1
		: ($i=11)
			$P_Field:=->[HeberGement:5]HG_RupMajeur2:41
			$P_Array:=-><>ta_VeilRupMaj2
		: ($i=12)
			$P_Field:=->[HeberGement:5]HG_RupMajeur3:42
			$P_Array:=-><>ta_VeilRupMaj3
		: ($i=13)
			$P_Field:=->[HeberGement:5]HG_PiècesIdté1:31
			$P_Array:=-><>ta_Veilidt1
		: ($i=14)
			$P_Field:=->[HeberGement:5]HG_PiècesIdté2:32
			$P_Array:=-><>ta_Veilidt2
		: ($i=15)
			$P_Field:=->[HeberGement:5]HG_PiècesIdté3:33
			$P_Array:=-><>ta_Veilidt3
		: ($i=16)
			$P_Field:=->[HeberGement:5]HG_FamDistri5:116
			$P_Array:=-><>ta_VeilDistri5
		: ($i=17)
			$P_Field:=->[HeberGement:5]HG_Ressources1:45
			$P_Array:=-><>ta_VeilRess1
		: ($i=18)
			$P_Field:=->[HeberGement:5]HG_Ressources2:46
			$P_Array:=-><>ta_VeilRess2
		: ($i=19)
			$P_Field:=->[HeberGement:5]HG_Ressources3:47
			$P_Array:=-><>ta_VeilRess3
		: ($i=20)
			$P_Field:=->[HeberGement:5]HG_SuiviSocial1:49
			$P_Array:=-><>ta_VeilSSoc1
		: ($i=21)
			$P_Field:=->[HeberGement:5]HG_SuiviSocial2:50
			$P_Array:=-><>ta_VeilSSoc2
		: ($i=22)
			$P_Field:=->[HeberGement:5]HG_SuiviSocial3:51
			$P_Array:=-><>ta_VeilSSoc3
		: ($i=23)
			$P_Field:=->[HeberGement:5]HG_CouvSocial1:53
			$P_Array:=-><>ta_VeilCSoc1
		: ($i=24)
			$P_Field:=->[HeberGement:5]HG_CouvSocial2:54
			$P_Array:=-><>ta_VeilCSoc2
		: ($i=25)
			$P_Field:=->[HeberGement:5]HG_CouvSocial3:55
			$P_Array:=-><>ta_VeilCSoc3
		: ($i=26)
			$P_Field:=->[HeberGement:5]HG_NiveauEtude:43
			$P_Array:=-><>ta_VeilNivEt
		: ($i=27)
			$P_Field:=->[HeberGement:5]HG_TempsErrance:34
			$P_Array:=-><>ta_VeilTpsEr
		: ($i=28)
			$P_Field:=->[HeberGement:5]HG_Métro:16
			$P_Array:=-><>ta_VeilMetro
		: ($i=29)
			$P_Field:=->[HeberGement:5]HG_Gare:15
			$P_Array:=-><>ta_VeilGare
		: ($i=30)
			$P_Field:=->[HeberGement:5]HG_Plateforme:139
			$P_Array:=->$rT_DummyArray
		: ($i=31)
			$P_Field:=->[HeberGement:5]HG_DossierSIAO:164
			$P_Array:=->$rT_DummyArray
		: ($i=32)
			$P_Field:=->[HeberGement:5]HG_CentreARR:63
			$P_Array:=->$rT_DummyArray
		: ($i=33)
			$P_Field:=->[HeberGement:5]HG_FamCasSpéc:111
			$P_Array:=->$rT_DummyArray
		: ($i=34)
			// Modifié par : Scanu Rémy (10/08/2022)
			$P_Field:=->[HeberGement:5]HG_Régulateur:8
			$P_Array:=-><>ta_VeilRegulateur
		: ($i=35)
			// Modifié par : Scanu Rémy (10/08/2022)
			$P_Field:=->[HeberGement:5]HG_ReservationProvisoire:177
			$P_Array:=->$rT_DummyArray
		: ($i=36)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_Nationalité:25
			$P_Array:=-><>ta_Nationalite
		: ($i=37)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_AssistSocial:87
			$P_Array:=-><>ta_AssistanteSociale
		: ($i=38)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_CodePostal:14
			$P_Array:=-><>ta_CodePostal
		: ($i=39)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_Coordinateur:7
			$P_Array:=-><>ta_Coordinateur
		: ($i=40)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_DernierEmplo:37
			$P_Array:=-><>ta_DernierEmploi
		: ($i=41)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_DernierHéber:35
			$P_Array:=-><>ta_DernierHebergement
		: ($i=42)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_DuréSanEmplo:38
			$P_Array:=-><>ta_DureeSansEmploi
		: ($i=43)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_Genre:96
			$P_Array:=-><>ta_Genre
		: ($i=44)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_Lien:18
			$P_Array:=-><>ta_Lien
		: ($i=45)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_SituFamille:29
			$P_Array:=-><>ta_SituationFamille
		: ($i=46)
			// Modifié par : Scanu Rémy (28/12/2022)
			$P_Field:=->[HeberGement:5]HG_SituProfess:36
			$P_Array:=-><>ta_SituationProf
		Else 
			ASSERT:C1129(False:C215; "propriete inconnue")
	End case 
	
	$L_Table:=Table:C252($P_Field)
	$L_Field:=Field:C253($P_Field)
	
	$L_Indice:=$i
	$T_Proprety:=$rT_xCriteres{$i}
	
	$rO_Match{$i}:=New object:C1471("critere"; $T_Proprety; "indice"; $L_Indice; "table"; $L_Table; "field"; $L_Field)
	OB SET ARRAY:C1227($rO_Match{$i}; "values"; $P_Array->)
	
	$i:=$i+1
End while 

COPY ARRAY:C226($rO_Match; $P_Output->)

If (False:C215)
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_EtatCivil:20; -><>ta_VeilEtCiv; -><>te_VeilEtCiv)  //Etat civil  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_FamGroupe:102; -><>ta_VeilGroupe; -><>te_VeilGroupe)  //Groupe 
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Permanencier:9; -><>ta_VeilPerma; -><>te_VeilPerma)  //Permanencier
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Signalement:12; -><>ta_VeilSglt; -><>te_VeilSglt)  //Signalement  
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_AutreSolutio:88; -><>ta_VeilAutreSol; -><>te_VeilAutreSol)  //Autre solution 23/4/2004
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Orientation1:58; -><>ta_VeilOrient1; -><>te_VeilOrient1)  //Orientation1 26/7/2004 
	P_HébergementCritèresFindPlus(->[HeberGement:5]; ->[HeberGement:5]HG_Orientation1:58; -><>ta_VeilOrient1; -><>te_VeilOrient1)  //7/10/2010
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Orientation2:60; -><>ta_VeilOrient2; -><>te_VeilOrient2)  //Orientation2 26/7/2004 
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_RupMajeur1:40; -><>ta_VeilRupMaj1; -><>te_VeilRupMaj1)  //Ruptures majeures : 26/7/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_RupMajeur2:41; -><>ta_VeilRupMaj2; -><>te_VeilRupMaj2)  //Ruptures majeures2 : 26/7/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_RupMajeur3:42; -><>ta_VeilRupMaj3; -><>te_VeilRupMaj3)  //Ruptures majeures2 : 26/7/2004
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_PiècesIdté1:31; -><>ta_Veilidt1; -><>te_Veilidt1)  //Identité 1 : 25/10/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_PiècesIdté2:32; -><>ta_Veilidt2; -><>te_Veilidt2)  //Identité 2 : 25/10/2004
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_PiècesIdté3:33; -><>ta_Veilidt3; -><>te_Veilidt3)  //Identité 3 : 25/10/2004
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_FamDistri5:116; -><>ta_VeilDistri5; -><>te_VeilDistri5)  //Distribution 5 : 5/7/2007
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Ressources1:45; -><>ta_VeilRess1; -><>te_VeilRess1)  //Ressources : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Ressources2:46; -><>ta_VeilRess2; -><>te_VeilRess2)  //Ressources : 10/1/2008 
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Ressources3:47; -><>ta_VeilRess3; -><>te_VeilRess3)  //Ressources : 10/1/2008
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SuiviSocial1:49; -><>ta_VeilSSoc1; -><>te_VeilSSoc1)  //Suivi social : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SuiviSocial2:50; -><>ta_VeilSSoc2; -><>te_VeilSSoc2)  //Suivi social : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_SuiviSocial3:51; -><>ta_VeilSSoc3; -><>te_VeilSSoc3)  //Suivi social : 10/1/2008
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CouvSocial1:53; -><>ta_VeilCSoc1; -><>te_VeilCSoc1)  //Couverture sociale : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CouvSocial2:54; -><>ta_VeilCSoc2; -><>te_VeilCSoc2)  //Couverture sociale : 10/1/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_CouvSocial3:55; -><>ta_VeilCSoc3; -><>te_VeilCSoc3)  //Couverture sociale : 10/1/2008
	
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_NiveauEtude:43; -><>ta_VeilNivEt; -><>te_VeilNivEt)  //Niveau d'étude : 7/7/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_TempsErrance:34; -><>ta_VeilTpsEr; -><>te_VeilTpsEr)  //Temps d'errance : 7/7/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Métro:16; -><>ta_VeilMetro; -><>te_VeilMetro)  //Metro : 7/7/2008
	P_HébergementCritèresFind(->[HeberGement:5]; ->[HeberGement:5]HG_Gare:15; -><>ta_VeilGare; -><>te_VeilGare)  //Gare : 12/1/2009
End if 