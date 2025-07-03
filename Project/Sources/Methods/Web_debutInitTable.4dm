//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Laurence
// Date et heure : 09/12/24, 16:20:32
// ----------------------------------------------------
// Méthode : Web_debutInitTable
// Description
// Héritage de la méthode DébutInitTable
//
// Paramètres
// ----------------------------------------------------

var $ii : Integer
var $itemCentreNom_o : Object
var $plateForme_t : Text

ARRAY TEXT:C222($notUseInWeb_at; 0)
If (Session:C1714.storage.intervenant.Plateforme#Null:C1517)
	$plateForme_t:=Session:C1714.storage.intervenant.Plateforme
Else 
	$plateForme_t:=Storage:C1525.intervenantsDetail.UserPlateforme
End if 

$itemCentreNom_o:=Web_JSON_Get_Centres_List("checkbox"; {titrePopup: "Prestations"; prestation: False:C215; plateforme: $plateForme_t})


$enumeration_o:={}
$enumeration_o.nom:="CentreNom"
$enumeration_o.item:=$itemCentreNom_o.list.extract("value")
$enumeration_o.champNumero:=62
$enumeration_o.champNom:=Field name:C257(Table:C252(->[HeberGement:5]); $enumeration_o.champNumero)
$enumeration_o.libelle:="Hébergement / prestation"

If (Session:C1714.storage#Null:C1517)
	// Gestion du storage de la session web
	Use (Session:C1714.storage.enumeration)
		Session:C1714.storage.enumeration.push(OB Copy:C1225($enumeration_o; ck shared:K85:29; Session:C1714.storage.enumeration))
	End use 
Else 
	
	If (Storage:C1525.enumeration=Null:C1517)
		Use (Storage:C1525)
			Storage:C1525.enumeration:=New shared collection:C1527()
		End use 
	End if 
	
	Use (Storage:C1525.enumeration)
		Storage:C1525.enumeration.push(OB Copy:C1225($enumeration_o; ck shared:K85:29; Storage:C1525.enumeration))
	End use 
End if 

//Coordinateurs
ARRAY TEXT:C222($item_at; 0)
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=2)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; $item_at)
SORT ARRAY:C229($item_at; >)
storageEnumerationInit("Coordinateur"; ->$item_at)

//Régulateurs
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=3)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; $item_at)
SORT ARRAY:C229($item_at; >)
storageEnumerationInit("Régulateur"; ->$item_at)

//Permanencier
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=4)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; $item_at)
SORT ARRAY:C229($item_at; >)
storageEnumerationInit("Permanencier"; ->$item_at)

// Assistance sociale
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Type:2=8)
MultiSoc_Filter(->[INtervenants:10])
SELECTION TO ARRAY:C260([INtervenants:10]IN_Login:3; $item_at)
SORT ARRAY:C229($item_at; >)
storageEnumerationInit("Assistante_sociale"; ->$item_at)

// Arrondissements
Début_LoadTables("Code postal"; ->$notUseInWeb_at)

// Metro
Début_LoadTables("Metro"; ->$notUseInWeb_at)

// Gares
Début_LoadTables("Gares"; ->$notUseInWeb_at)

// Places
Début_LoadTables("Places"; ->$notUseInWeb_at)

// Portes
Début_LoadTables("Portes"; ->$notUseInWeb_at)

// Maraude
Début_LoadTables("Maraude"; ->$notUseInWeb_at)

// Liens
Début_LoadTables("Liens"; ->$notUseInWeb_at)

// Lieu de naissance
Début_LoadTables("Lieu de naissance"; ->$notUseInWeb_at)

// Situation de famille
Début_LoadTables("Situation de famille"; ->$notUseInWeb_at)

// Temps d'errance
Début_LoadTables("Temps d'errance"; ->$notUseInWeb_at)

// Dernier hébergement
Début_LoadTables("Dernier hébergement"; ->$notUseInWeb_at)

// Situation professionnelle
Début_LoadTables("Situation professionnelle"; ->$notUseInWeb_at)

// Dernier emploi
Début_LoadTables("Dernier emploi"; ->$notUseInWeb_at)

// Durée du dernier emploi
Début_LoadTables("DUREE SANS EMPLOI"; ->$notUseInWeb_at)

// Niveau d'étude
Début_LoadTables("Niveau d'étude"; ->$notUseInWeb_at)

// Pièces Identité
Début_LoadTables("Pièces d'identité"; ->$notUseInWeb_at)

// Type Etat Civil
// Début_LoadTables (->◊va_EtCiv_L;->◊va_EtCiv_R;->◊ta_TBEtCiv)

QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4="008/1@")
MultiSoc_Filter(->[TAbles:12])
ORDER BY:C49([TAbles:12]; [TAbles:12]TB_Ordre:8; >)
SELECTION TO ARRAY:C260([TAbles:12]TB_Libellé:6; $item_at)
SORT ARRAY:C229($item_at; >)
storageEnumerationInit("Etat Civil"; ->$item_at)

//Nationalité
Début_LoadTables("Nationalité"; ->$notUseInWeb_at)

//Signalement
Début_LoadTables("Signalement"; ->$notUseInWeb_at)

//Ressources actuelles
Début_LoadTables("Ressources actuelles"; ->$notUseInWeb_at)

//Provenance
Début_LoadTables("Provenance"; ->$notUseInWeb_at)

//Plainte
Début_LoadTables("Plainte"; ->$notUseInWeb_at)

//Hospitalisation
Début_LoadTables("Hospitalisation"; ->$notUseInWeb_at)

//Traitement en cours
Début_LoadTables("Traitement en cours"; ->$notUseInWeb_at)

//Orientation 1
Début_LoadTables("Orientation 1"; ->$notUseInWeb_at)

//Orientation suite
Début_LoadTables("Orientation 1 suite"; ->$notUseInWeb_at)

//Autre solution suite
Début_LoadTables("Autre solution suite"; ->$notUseInWeb_at)

//Orientation 2 ou localisation
Début_LoadTables("Orientation2"; ->$notUseInWeb_at)

//Autre solution
Début_LoadTables("Autre solution"; ->$notUseInWeb_at)

//Dernier lieu d'hébergement
Début_LoadTables("Dernier lieu d'hébergement"; ->$notUseInWeb_at)

//#FM Groupe
Début_LoadTables("FM Groupe"; ->$notUseInWeb_at)

//#FM Composition famille
Début_LoadTables("FM Composition"; ->$notUseInWeb_at)

//#FM Nombre de personnes
Début_LoadTables("FM Nb personnes"; ->$notUseInWeb_at)

//# FM Nombre de jours
Début_LoadTables("FM Nb jours"; ->$notUseInWeb_at)

//# FM Nombre de chambres
Début_LoadTables("FM Nb chambres"; ->$notUseInWeb_at)

//# FM Cas spécifique
Début_LoadTables("FM Cas spécifique"; ->$notUseInWeb_at)

//# FM Distribution 1
Début_LoadTables("FM Distri1"; ->$notUseInWeb_at)

//# FM Distribution 2
Début_LoadTables("FM Distri2"; ->$notUseInWeb_at)

//# FM Distribution 3
Début_LoadTables("FM Distri3"; ->$notUseInWeb_at)

//# FM Distribution 4
Début_LoadTables("FM Distri4"; ->$notUseInWeb_at)

//# FM Distribution 5
Début_LoadTables("FM Distri5"; ->$notUseInWeb_at)

//05/01/2004
//#"Pièces d'identité 2"
Début_LoadTables("Pièces d'identité 2"; ->$notUseInWeb_at)

//#"Pièces d'identité 3"
Début_LoadTables("Pièces d'identité 3"; ->$notUseInWeb_at)

//Suivi social
Début_LoadTables("Suivi social"; ->$notUseInWeb_at)

//#"Suivi social 2"
Début_LoadTables("Suivi social 2"; ->$notUseInWeb_at)

//#"Suivi social 3"
Début_LoadTables("Suivi social 3"; ->$notUseInWeb_at)

//Couverture sociale
Début_LoadTables("Couverture sociale"; ->$notUseInWeb_at)

//#"Couverture sociale 2"
Début_LoadTables("Couverture sociale 2"; ->$notUseInWeb_at)

//#"Couverture sociale 3"
Début_LoadTables("Couverture sociale 3"; ->$notUseInWeb_at)

//Ruptures majeures
Début_LoadTables("Ruptures majeures"; ->$notUseInWeb_at)

//#"Ruptures majeures 2"
Début_LoadTables("Ruptures majeures 2"; ->$notUseInWeb_at)

//#"Ruptures majeures 3"
Début_LoadTables("Ruptures majeures 3"; ->$notUseInWeb_at)

//#"Ressources actuelles 2"
Début_LoadTables("Ressources actuelles 2"; ->$notUseInWeb_at)

//#"Ressources actuelles 3"
Début_LoadTables("Ressources actuelles 3"; ->$notUseInWeb_at)

//29/3/2007
//#"Liste d'URL"
Début_LoadTables("Liste d'URL"; ->$notUseInWeb_at)

//24/6/2008
//Liste des plateformes pour CHRS
Début_LoadTables("Liste des plateformes"; ->$notUseInWeb_at)

//Liste des Attestations
Début_LoadTables("Liste des Attestations"; ->$notUseInWeb_at)  // #REW20170428-1 ce n'est plus utilisé

//# Type document des locations
Début_LoadTables("Locations: types des documents"; ->$notUseInWeb_at)

//# Locations : Libellé des charges
Début_LoadTables("Locations: Charges"; ->$notUseInWeb_at)

// Locations: Sinistres
Début_LoadTables("Locations: Sinistres"; ->$notUseInWeb_at)

//# Modes des règlements
Début_LoadTables("Modes de règlements"; ->$notUseInWeb_at)

//# Banques
Début_LoadTables("Banques"; ->$notUseInWeb_at)

//# Locations : Type du bien
Début_LoadTables("Locations: Type du bien"; ->$notUseInWeb_at)

//# TVA
Début_LoadTables("TVA"; ->$notUseInWeb_at)

//# Dossiers en cours : Noms
Début_LoadTables("Dossiers en cours"; ->$notUseInWeb_at)

//# Dossiers en cours : Jours de rappel
Début_LoadTables("Nbre des jours de rappel"; ->$notUseInWeb_at)

//# Planning : Types RDV
Début_LoadTables("Planning: Types RDV"; ->$notUseInWeb_at)

//# Planning : Presence
Début_LoadTables("Planning: Présence"; ->$notUseInWeb_at)

//# Planning : Rappel
Début_LoadTables("Planning: Rappel"; ->$notUseInWeb_at)

//# Gestion immobilière : Types des équipements
Début_LoadTables("GI: Types des équipements"; ->$notUseInWeb_at)

//# Gestion immobilière : Garantie
Début_LoadTables("GI: Garantie"; ->$notUseInWeb_at)

//# Gestion immobilière : Quantité initiale
Début_LoadTables("GI: Quantité initiale"; ->$notUseInWeb_at)

//# Gestion immobilière : Types interventions
Début_LoadTables("GI: Types interventions"; ->$notUseInWeb_at)

//# Gestion immobilière : Prise en charge externe
Début_LoadTables("GI: Prise en charge externe"; ->$notUseInWeb_at)

// Gestion des participations : Années
Début_LoadTables("GP: Années"; ->$notUseInWeb_at)

// Emplacement
Début_LoadTables("Emplacement"; ->$notUseInWeb_at)

// Modifié par : LPC (31/01/2024)
// Categorie des centres
Début_LoadTables("Centre: Categorie"; ->$notUseInWeb_at)