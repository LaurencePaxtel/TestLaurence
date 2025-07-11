
var $updateEtatCivilFusion_b : Boolean
var $position_i : Integer
var $heberge_e : cs:C1710.HeBergeEntity

// Mise à jour automatique du genre depuis l'état civil
$position_i:=Position("("; [HeberGement:5]HG_EtatCivil:36)
[HeberGement:5]HG_Genre:96:=False

If ($position_i>0)
       If (Substring([HeberGement:5]HG_EtatCivil:36; $position_i+1; 1)="F")
               [HeberGement:5]HG_Genre:96:=True
       End if
End if

$heberge_e:=ds:C1482.HeBerge.get([HeberGement:5]HG_HB_ID:19)
If ($heberge_e#Null)
       $heberge_e.HG_Genre:=[HeberGement:5]HG_Genre:96
       $heberge_e.save()
End if


Case of 
	: (Trigger event:C369=Sur sauvegarde nouvel enreg:K3:1)
		
		If ([HeberGement:5]HG_Reporté:94="")
			outilsManageAlerteDirection([HeberGement:5]HG_HB_ID:19; [HeberGement:5]HG_CentreNom:62; [HeberGement:5]HG_Date:4)
		End if 
		
		// Modifié par : Scanu Rémy (02/01/2023) et Re-modifié par Scanu Rémy (25/04/2023)
		[HeberGement:5]HG_DatePremierContact:178:=ds:C1482.HeberGement.getDatePremierContact([HeberGement:5]HG_HB_ID:19; [HeberGement:5]HG_Nuit:2; [HeberGement:5]HG_Date:4)
		
		// Modifié par : Scanu Rémy (04/03/2024)
		If ([HeberGement:5]HG_HeureAppel:5=?00:00:00?)
			[HeberGement:5]HG_HeureAppel:5:=Current time:C178
		End if 
		
		// Modifié par : Scanu Rémy (29/09/2023)
		// Ajout du champ HG_EtatCivilFusion
		$updateEtatCivilFusion_b:=True:C214
		
		// Mise en commentaire par GF car n'est pas activé dans les cases à coché de la table.
		//: (Événement trigger=Sur sauvegarde enregistrement)
		//$updateEtatCivilFusion_b:=(Ancien([HeberGement]HG_EtatCivil)#[HeberGement]HG_EtatCivil)
End case 

// Modifié par : Scanu Rémy (20/01/2023)
// Mise en commentaire par GF car n'est pas activé dans les cases à coché de la table.
/*
Si (Événement trigger#Sur suppression enregistrement)
$hebergement_es:=ds.HeberGement.query("HG_FicheNuméro = :1 AND ID # :2"; [HeberGement]HG_FicheNuméro; [HeberGement]ID)

Tant que ($hebergement_es.length>0)
$numFiche_t:=i_HébérgementNoFiche(Choisir([HeberGement]HG_Nuit; "N"; "J"); [HeberGement]HG_Date; Uut_Numerote115([HeberGement]HG_Date))
$hebergement_es:=ds.HeberGement.query("HG_FicheNuméro = :1"; $numFiche_t)
Fin tant que 

Si ($numFiche_t#[HeberGement]HG_FicheNuméro) & ($numFiche_t#"")
[HeberGement]HG_FicheNuméro:=$numFiche_t
Fin de si 

Fin de si 
*/
If ($updateEtatCivilFusion_b=True:C214)
/*
$heberge_es:=ds.HeBerge.query("HB_ReferenceID = :1"; [HeberGement]HG_HB_ID)
	
Si ($heberge_es.length=1)
$heberge_e:=$heberge_es.first()
outilsPaxtelRetroactif(10; $heberge_e; Faux)
Fin de si 
*/
End if 