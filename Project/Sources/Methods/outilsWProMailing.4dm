//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 18/11/21, 17:55:02
// ----------------------------------------------------
// Méthode : outilsWProMailing
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $imprimer_b : Boolean

outilsBibliothequeNumerique
$imprimer_b:=(Records in selection:C76([DOCWPRO:121])=1)

Case of 
	: (<>ref_soc_active="SSO")
		
		// Modifié par : Scanu Rémy (30/08/2023)
		// Impression possible uniquement si chef de famille
		$imprimer_b:=[HeberGement:5]HG_FamChef:103
		
		If ($imprimer_b=True:C214)
			
			Case of 
				: ([DOCWPRO:121]nom:3="Attestation hébergement@")  // Isolé ou famille
					$imprimer_b:=(([HeberGement:5]HG_Date:4=Current date:C33) | ([HeberGement:5]HG_Date:4=(Current date:C33-1))) & ([HeberGement:5]HG_Cloturée:67=True:C214)
				: ([DOCWPRO:121]nom:3="@maraude@")  // Maraude
					$imprimer_b:=([HeberGement:5]HG_FamGroupe:102="30@")
			End case 
			
		End if 
		
End case 

Case of 
	: ($imprimer_b=True:C214)
		outilsWProImprimer(True:C214; "simple"; ""; [DOCWPRO:121]fichier:4)
	: (Records in selection:C76([DOCWPRO:121])=1)
		ALERT:C41("Impossible d'imprimer le document "+[DOCWPRO:121]nom:3+" car cette personne n'est pas chef de famille !")
	Else 
		ALERT:C41("Aucun document trouvé, veuillez réessayer")
End case 