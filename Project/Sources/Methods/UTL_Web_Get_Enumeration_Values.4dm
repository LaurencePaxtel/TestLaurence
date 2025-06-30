//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 19-05-02, 23:25:41
// ----------------------------------------------------
// Method: UTL_Web_Get_Enumeration_Values
// Description
// Méthode Web 
//
// Parameters
// $1 : Le nom de l'énumération
// ----------------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)

C_TEXT:C284($T_Selecteur)
C_POINTER:C301($P_Param; $P_Output)

var $0 : Collection

$T_Selecteur:=$1
$P_Param:=$2

CLEAR VARIABLE:C89($P_Output)

return Session:C1714.storage.enumeration.query("nom = :1"; $T_Selecteur)[0].item

/*
Au cas ou 
: ($T_Selecteur="Etat Civil")
return Session.storage.enumeration.Etat_Civil.item
: ($T_Selecteur="Genre")
return Session.storage.enumeration.Genre.item
: ($T_Selecteur="Permanencier")
return Session.storage.enumeration.Permanencier.item
: ($T_Selecteur="Code postal")  //Arrondissements
return Session.storage.enumeration.Code_postal.item
: ($T_Selecteur="Metro")  //Metro
return Session.storage.enumeration.Metro.item
: ($T_Selecteur="Gares")  //Gares
return Session.storage.enumeration.Gares.item
: ($T_Selecteur="Emplacement")  // Emplacement
return Session.storage.enumeration.Emplacement.item
: ($T_Selecteur="Assistante sociale")  // Assistance sociale
return Session.storage.enumeration.Assistante_sociale.item
: ($T_Selecteur="Maraude")  //Maraude
return Session.storage.enumeration.Maraude.item
: ($T_Selecteur="Liens")  //Liens
return Session.storage.enumeration.Liens.item
: ($T_Selecteur="Lieu de naissance")  //Lieu de naissance
return Session.storage.enumeration.Lieu_de_naissance.item
: ($T_Selecteur="Situation de famille")  //Situation de famille
return Session.storage.enumeration.Situation_de_famille.item
: ($T_Selecteur="Temps d'Errance") | ($T_Selecteur="Temps d'errance")  //Temps d'Errance
return Session.storage.enumeration.Temps_d_errance.item
: ($T_Selecteur="Dernier hébergement")  //Dernier hébergement
return Session.storage.enumeration.Dernier_hébergement.item
: ($T_Selecteur="Situation professionnelle")  //Situation professionnelle
return Session.storage.enumeration.Situation_professionnelle.item
: ($T_Selecteur="Dernier emploi")  //Dernier emploi
return Session.storage.enumeration.Dernier_emploi.item
: ($T_Selecteur="Durée du dernier emploi")  //Durée du dernier emploi
return Session.storage.enumeration.Durée_du_dernier_emploi.item
: ($T_Selecteur="Niveau d'étude")  //Niveau d'étude
return Session.storage.enumeration.Niveau_d_étude.item
: ($T_Selecteur="Pièces d'identité")  //Pièces Identité
return Session.storage.enumeration.Pièces_d_identité.item
: ($T_Selecteur="Nationalité")  //Nationalité
return Session.storage.enumeration.Nationalité.item
: ($T_Selecteur="Signalement")  //Signalement
return Session.storage.enumeration.Signalement.item
: ($T_Selecteur="Ressources actuelles")  //Ressources actuelles
return Session.storage.enumeration.Ressources_actuelles.item
: ($T_Selecteur="Suivi social")  //Suivi social
return Session.storage.enumeration.Suivi_social.item
: ($T_Selecteur="Couverture sociale")  //Couverture sociale
return Session.storage.enumeration.Couverture_sociale.item
: ($T_Selecteur="Ruptures majeures")  //Ruptures majeures
return Session.storage.enumeration.Ruptures_majeures.item
: ($T_Selecteur="Provenance")  //Provenance
return Session.storage.enumeration.Provenance.item
: ($T_Selecteur="Orientation 1")  //Orientation 1
return Session.storage.enumeration.Orientation_1.item
: ($T_Selecteur="Orientation 1 suite")  //Orientation suite
return Session.storage.enumeration.Orientation_1_suite.item
: ($T_Selecteur="Autre solution suite")  //Autre solution suite
return Session.storage.enumeration.Autre_solution_suite.item
: ($T_Selecteur="Orientation2")  //Orientation 2 ou localisation
return Session.storage.enumeration.Orientation_2.item
: ($T_Selecteur="Autre solution")  //Autre solution
return Session.storage.enumeration.Autre_solution.item
: ($T_Selecteur="Appels")  //Appels
return Session.storage.enumeration.Appels.item
: ($T_Selecteur="Dernier lieu d'hébergement")  //Dernier lieu d'hébergement
return Session.storage.enumeration.Dernier_lieu_d_hébergement.item
: ($T_Selecteur="FM Groupe")  //#FM Groupe
//$P_Output:=Web_Get_Variable_Process(-><>ta_FMGrp)
return Session.storage.enumeration.FM_Groupe.item

: ($T_Selecteur="FM Composition")  //#FM Composition famille
return Session.storage.enumeration.FM_Composition.item

: ($T_Selecteur="FM Nb personnes")  //#FM Nombre de personnes
return Session.storage.enumeration.FM_Nb_personnes.item

: ($T_Selecteur="FM Nb jours")  //# FM Nombre de jours
return Session.storage.enumeration.FM_Nb_jours.item
: ($T_Selecteur="FM Nb chambres")  //# FM Nombre de chambres
return Session.storage.enumeration.FM_Nb_chambres.item
: ($T_Selecteur="FM Cas spécifique")  //# FM Cas spécifique
return Session.storage.enumeration.FM_Cas_spécifique.item
: ($T_Selecteur="FM Distri1")  //# FM Distribution 1
return Session.storage.enumeration.FM_Distri1.item
: ($T_Selecteur="FM Distri2")  //# FM Distribution 2
return Session.storage.enumeration.FM_Distri2.item
: ($T_Selecteur="FM Distri3")  //# FM Distribution 3
return Session.storage.enumeration.FM_Distri3.item
: ($T_Selecteur="FM Distri4")  //# FM Distribution 4
return Session.storage.enumeration.FM_Distri4.item
: ($T_Selecteur="FM Distri5")  //# FM Distribution 5
return Session.storage.enumeration.FM_Distri5.item

: ($T_Selecteur="Pièces d'identité 2")  //#"Pièces d'identité 2"
return Session.storage.enumeration.Pièces_d_identité_2.item
: ($T_Selecteur="Pièces d'identité 3")  //#"Pièces d'identité 3"
return Session.storage.enumeration.Pièces_d_identité_3.item
: ($T_Selecteur="Suivi social")  //#"Suivi social"
return Session.storage.enumeration.Suivi_social.item
: ($T_Selecteur="Suivi social 2")  //#"Suivi social 2"
return Session.storage.enumeration.Suivi_social_2.item
: ($T_Selecteur="Suivi social 3")  //#"Suivi social 3"
return Session.storage.enumeration.Suivi_social_3.item
: ($T_Selecteur="Couverture sociale 2")  //#"Couverture sociale 2"
return Session.storage.enumeration.Couverture_sociale_2.item
: ($T_Selecteur="Couverture sociale 3")  //#"Couverture sociale 3"
return Session.storage.enumeration.Couverture_sociale_3.item
: ($T_Selecteur="Ruptures majeures 2")  //#"Ruptures majeures 2"
return Session.storage.enumeration.Ruptures_majeures_2.item
: ($T_Selecteur="Ruptures majeures 3")  //#"Ruptures majeures 3"
return Session.storage.enumeration.Ruptures_majeures_3.item
: ($T_Selecteur="Ressources actuelles 2")  //#"Ressources actuelles 2"
return Session.storage.enumeration.Ressources_actuelles_2.item
: ($T_Selecteur="Ressources actuelles 3")  //#"Ressources actuelles 3"
return Session.storage.enumeration.Ressources_actuelles_3.item
: ($T_Selecteur="Liste d'URL")  //#"Liste d'URL"
return Session.storage.enumeration.Liste_d_URL.item
: ($T_Selecteur="Liste des plateformes")  //Liste des plateformes pour CHRS
return Session.storage.enumeration.Liste_des_plateformes.item
: ($T_Selecteur="Liste des Attestations")  //Liste des Attestations         // #REW20170428-1 ce n'est plus utilisé
return Session.storage.enumeration.Liste_des_Attestations.item
: ($T_Selecteur="HG DosSIAO")  //# HG_DossierSIAO
return Session.storage.enumeration.HG_DosSIAO.item
: ($T_Selecteur="Locations: types des documents")  //# Locations : Type document des locations
return Session.storage.enumeration.Locations_types_des_documents.item
: ($T_Selecteur="Locations: Sinistres")  //# Locations : Libellés des sinistres/travaux
return Session.storage.enumeration.Locations_Sinistres.item
: ($T_Selecteur="Locations: Charges")  //# Locations : Libellé des charges
return Session.storage.enumeration.Locations_Charges.item
: ($T_Selecteur="Modes de règlements")  //# Modes de règlements
return Session.storage.enumeration.Modes_de_règlements.item
: ($T_Selecteur="Banques")  //# Banques
return Session.storage.enumeration.Banques.item
: ($T_Selecteur="Locations: Type du bien")  //# Locations : Type du bien
return Session.storage.enumeration.Locations_Type_du_bien.item
: ($T_Selecteur="TVA")  //# TVA
return Session.storage.enumeration.TVA.item
: ($T_Selecteur="Planning: Types RDV")  //#Planning: Types RDV
return Session.storage.enumeration.Planning_Types_RDV.item
: ($T_Selecteur="Planning: Présence")  //#Planning: Presence
return Session.storage.enumeration.Planning_Présence.item
: ($T_Selecteur="Planning: Rappel")  //#Planning: Rappel
return Session.storage.enumeration.Planning_Rappel.item
: ($T_Selecteur="GI: Types des équipements")  // Gestion immobilière : Types des équipements
return Session.storage.enumeration.GI_Types_des_équipements.item
: ($T_Selecteur="GI: Garantie")  // Gestion immobilière : Garantie
return Session.storage.enumeration.GI_Garantie.item
: ($T_Selecteur="GI: Quantité initiale")  // Gestion imobilière : Quantité initiale
return Session.storage.enumeration.GI_Quantité_initiale.item
: ($T_Selecteur="GI: Types interventions")  // Gestion immobilière : Types interventions
return Session.storage.enumeration.GI_Types_interventions.item
: ($T_Selecteur="GI: Prise en charge externe")  // Gestion immobilière : Prise en charge externe
return Session.storage.enumeration.GI_Prise_en_charge_externe.item
Sinon 
ASSERT(Faux; "liste inconnue")
Fin de cas 
*/
COPY ARRAY:C226($P_Output->; $P_Param->)