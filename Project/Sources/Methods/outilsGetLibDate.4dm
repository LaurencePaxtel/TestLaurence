//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 11/05/21, 15:47:00
// ----------------------------------------------------
// Méthode : outilsGetLibDate
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($0)

C_LONGINT:C283($1)
C_DATE:C307($2)

Case of 
	: ($1=1)
		
		Case of 
			: (Day number:C114($2)=Lundi:K10:13)
				$0:="Lundi"
			: (Day number:C114($2)=Mardi:K10:14)
				$0:="Mardi"
			: (Day number:C114($2)=Mercredi:K10:15)
				$0:="Mercredi"
			: (Day number:C114($2)=Jeudi:K10:16)
				$0:="Jeudi"
			: (Day number:C114($2)=Vendredi:K10:17)
				$0:="Vendredi"
			: (Day number:C114($2)=Samedi:K10:18)
				$0:="Samedi"
			: (Day number:C114($2)=Dimanche:K10:19)
				$0:="Dimanche"
		End case 
		
	: ($1=2)
		
		Case of 
			: (Month of:C24($2)=Janvier:K10:1)
				$0:="Janvier"
			: (Month of:C24($2)=Février:K10:2)
				$0:="Février"
			: (Month of:C24($2)=Mars:K10:3)
				$0:="Mars"
			: (Month of:C24($2)=Avril:K10:4)
				$0:="Avril"
			: (Month of:C24($2)=Mai:K10:5)
				$0:="Mai"
			: (Month of:C24($2)=Juin:K10:6)
				$0:="Juin"
			: (Month of:C24($2)=Juillet:K10:7)
				$0:="Juillet"
			: (Month of:C24($2)=Août:K10:8)
				$0:="Août"
			: (Month of:C24($2)=Septembre:K10:9)
				$0:="Septembre"
			: (Month of:C24($2)=Octobre:K10:10)
				$0:="Octobre"
			: (Month of:C24($2)=Novembre:K10:11)
				$0:="Novembre"
			: (Month of:C24($2)=Décembre:K10:12)
				$0:="Décembre"
			Else 
				$0:="Mois inconnu"
		End case 
		
End case 