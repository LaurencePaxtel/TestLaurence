//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_TypeLibellé
//{
//{          Mardi 18 novembre 2008 à 12:38:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
$0:=""
C_LONGINT:C283($1)


Case of 
	: ($1=Est un champ alpha:K8:1)
		$0:="Alpha"
	: ($1=Est un texte:K8:3)
		$0:="Texte"
	: ($1=Est un numérique:K8:4)
		$0:="Réél"
	: ($1=Est un entier:K8:5)
		$0:="Entier"
	: ($1=Est un entier long:K8:6)
		$0:="Long"
	: ($1=Est une date:K8:7)
		$0:="Date"
	: ($1=Est une heure:K8:8)
		$0:="Heure"
	: ($1=Est un booléen:K8:9)
		$0:="Booleen"
	: (ve_Type=Est une image:K8:10)
		$0:="Image"
	: ($1=Est une sous table:K8:11)
		$0:="Sous table"
	: ($1=Est un BLOB:K8:12)
		$0:="Blob"
End case 