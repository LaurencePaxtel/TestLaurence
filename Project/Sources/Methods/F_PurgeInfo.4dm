//%attributes = {}
C_TEXT:C284($0)
$0:=""

C_LONGINT:C283($1)
C_TEXT:C284($2)
If ($2="Purge")
	Case of 
		: ($1=1)  //Suppression des fiches d'hébergement
			$0:="Suppression de toutes les fiches :"
			$0:=$0+<>va_CR+"     -  Hébergés"
			$0:=$0+<>va_CR+"     -  Hébergements"
			$0:=$0+<>va_CR+"Mise à zéro des : "
			$0:=$0+<>va_CR+"     -  Lits distribués"
			$0:=$0+<>va_CR+"     -  N° d'hébergements ([DéPart]DP_NumHeberg:=0)"
			$0:=$0+<>va_CR+"Mise à jour des : "
			$0:=$0+<>va_CR+"     -  Lits restants:=Lits dispo Total"
			
		: ($1=2)  //Suppression de fiches entre deux dates
			$0:="Suppression des fiches entre deux dates d'hébergement:"
			$0:=$0+<>va_CR+"     -  Hébergés"
			$0:=$0+<>va_CR+"     -  Hébergements"
			$0:=$0+<>va_CR+"Mise à zéro des fiches entre deux dates: "
			$0:=$0+<>va_CR+"     -  Lits distribués"
			$0:=$0+<>va_CR+"Mise à jour des fiches entre deux dates : "
			$0:=$0+<>va_CR+"     -  Lits restants:=Lits dispo Total"
			
			
		: ($1=3)  //Suppression de fiches entre deux N°
			$0:="Suppression des fiches entre deux N° de fiches hébérgements:"
			$0:=$0+<>va_CR+"     -  Hébergements"
			$0:=$0+<>va_CR+"Mise à zéro des fiches entre deux dates: "
			$0:=$0+<>va_CR+"     -  Lits distribués"
			$0:=$0+<>va_CR+"Mise à jour des fiches entre deux dates : "
			$0:=$0+<>va_CR+"     -  Lits restants:=Lits dispo Total"
			
		: ($1=4)  //Supprimer les hébergements par C.P.
			$0:="Suppression des fiches hébérgements pour un code postal:"
			$0:=$0+<>va_CR+"     -  Hébergements"
			
		: ($1=5)  //Supprimer une fiche d'hébergement
			$0:="Suppression d'une fiche hébérgement par n° de fiche:"
			$0:=$0+<>va_CR+"     -  Hébergements"
			$0:=$0+<>va_CR+"Mise à jour de la fiche lit : "
			$0:=$0+<>va_CR+"     -  [CentresLits]CL_Distribué"
			$0:=$0+<>va_CR+"     -  [CentresLits]CL_Restant"
			
		: ($1=6)  //Suppression des fiches des lits attribués entre deux dates
			$0:="Suppression des fiches des lits attribués entre deux dates:"
			$0:=$0+<>va_CR+"     -  [CentresLits]"
			
		: ($1=7)  //Suppression des clés sans hébergement
			$0:="Suppression des Hébérgés sans fiche d'hébergement:"
			$0:=$0+<>va_CR+"     -  [HéBergé]"
			
		: ($1=8)  //Supprimer Prestations entre deux dates
			$0:="Suppression des fiches Prestations entre deux dates:"
			$0:=$0+<>va_CR+"     -  [RenseiGnements]"
			
		: ($1=9)  //Changer sexe
			$0:="Affectation du sexe en fonction de l'état civil (Changer sexe) :"
			$0:=$0+<>va_CR+"     -  [HéBergé]HG_Genre"
			$0:=$0+<>va_CR+"     -  [HéberGement]HG_Genre"
			
		: ($1=10)  //Màj clé et hébgnt
			$0:="Mise à jour de l'état civil Hébérgements (Màj clé et hébgnt) :"
			$0:=$0+<>va_CR+"en fonction de l'hébérgé ([HéBergé]) et sur toutes les fiches"
			$0:=$0+<>va_CR+"     -  [HéberGement]HG_Nom"
			$0:=$0+<>va_CR+"     -  [HéberGement]HG_Prénom"
			$0:=$0+<>va_CR+"     -  [HéberGement]HG_DateNéLe"
			$0:=$0+<>va_CR+"     -  [HéberGement]HG_Genre"
			$0:=$0+<>va_CR+"     -  [HéberGement]HG_Age"
			
		: ($1=11)  //Màj Réf (report)
			$0:="Modification des compteurs pour réactiver les reports (Màj Réf (report)) :"
			$0:=$0+<>va_CR+"     -  [RéférenceUnique]RU_Numero"
			$0:=$0+<>va_CR+"     -  Le fichier de numérotation des hébergements est multiple"
			
		: ($1=12)  //Lien Hébérgé
			$0:="Visualisation de la validité du lien Hébérgé et Hébergement (Lien Hébérgé) :"
			$0:=$0+<>va_CR+"     -  Liste de visualisation des hébergements"
			
		: ($1=13)  //Màj n° à n°
			$0:="Mise à jour n° à n°  problème apparu avec AMAMRI AHMED (Màj n° à n°) :"
			$0:=$0+<>va_CR+"     -  Saisir la référence de l'Hébérgé ([HéBergé]HB_RéférenceID) à rechercher "
			$0:=$0+<>va_CR+"     -  Saisir la référence de l'Hébérgé ([HéBergé]HB_RéférenceID à appliquer"
			$0:=$0+" en fait un hébérgé ayant 2 fiches hébérgés donc des hébérgements rattachées"+" à chacune des fiches hébérgé"
			
		: ($1=14)  //MàJ Durée 
			$0:="Mise à jour du champ Durée"+" de la rencontre de la maraude (MàJ Durée) :"
			$0:=$0+<>va_CR+"     -  [Maraude]MR_DuréRencontr "
			$0:=$0+<>va_CR+"     -  la raison est un bug dans la première livraison de la maraude"
			
		: ($1=15)  //Tables
			$0:="Mise à jour des références pour les énumération (Tables) :"
			$0:=$0+<>va_CR+"     -  Dans le nom saisir un libellé ou un n°  pour la recherche"
			$0:=$0+<>va_CR+"     -  Dans nouveau saisir le bon libellé ou le bon n° suivant"+" le document papier"
			$0:=$0+<>va_CR+"     -  [TypesTables]TT_RéférenceID "
			$0:=$0+<>va_CR+"     -  [TypesTables]TT_Libellé "
			
	End case 
End if 