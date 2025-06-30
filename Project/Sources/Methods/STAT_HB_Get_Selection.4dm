//%attributes = {}
// ----------------------------------------------------
// LOGICIEL : Samu Social de Paris
// © DBsolutions/Paxtel
// Développeur : Kevin HASSAL
// Date and time: 14/08/19, 16:13:31
// ----------------------------------------------------
// Method: STAT_HB_Get_Selection
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Integer
var $2 : Integer

var $champ_t; $valueToSearch_t : Text
var $selecteur; $compteur; $L_SizeTrancheAge; $cas; $pos_el : Integer
var $reset_b : Boolean
var $champ; $P_ve_p1; $P_ve_p2; $P_ve_p3 : Pointer
var $champ_c; $etatCivil_c : Collection

var $tableFusion_es : cs:C1710.TableFusionsSelection
var $hebergement_es; $hebergementB_es : cs:C1710.HeberGementSelection

$selecteur:=$1
$compteur:=$2

Case of 
	: ($selecteur=1)
		$P_ve_p1:=->tp_Rub1
		$P_ve_p2:=->te_Rub1
		$P_ve_p3:=->ta_it1
	: ($selecteur=2)
		$P_ve_p1:=->tp_Rub2
		$P_ve_p2:=->te_Rub2
		$P_ve_p3:=->ta_it2
	: ($selecteur=3)
		$P_ve_p1:=->tp_Rub3
		$P_ve_p2:=->te_Rub3
		$P_ve_p3:=->ta_it3
	: ($selecteur=4)
		$P_ve_p1:=->tp_Rub4
		$P_ve_p2:=->te_Rub4
		$P_ve_p3:=->ta_it4
	Else 
		ASSERT:C1129(False:C215; "problème de sélecteur")
End case 

$cas:=$P_ve_p2->{0}

$champ:=$P_ve_p1->{0}
$champ_t:=Field name:C257($champ)

// Modifié par : Scanu Rémy - remy@connect-io.fr (29/05/2021)
// Ajout d'une astuce pour bien prendre en compte les champs de type booléen
If (Is a variable:C294(->parametre_o)=True:C214)
	
	Case of 
		: (Num:C11(parametre_o.selecteurPrecedent)<$selecteur)
			$reset_b:=True:C214
		: ($selecteur=1) & (parametre_o.selecteurPrecedent#$selecteur)
			$reset_b:=True:C214
	End case 
	
	If ($reset_b=True:C214)
		parametre_o.champPrecedent:=New collection:C1472
		parametre_o.selecteurPrecedent:=$selecteur
	End if 
	
	// Modifié par : Scanu Rémy (18/02/2022)
	// Prise en compte particulière pour la rechercher sur l'Etat Civil
	If ($champ_t="HG_EtatCivil")
		
		If (parametre_o.heberge=Null:C1517)
			parametre_o.heberge:=New collection:C1472
		End if 
		
	End if 
	
End if 

//UTILISER ENSEMBLE("E_encours")

// Modifié par : Scanu Rémy (13/04/2023)
// Modernisation du code
$hebergement_es:=Create entity selection:C1512([HeberGement:5])
$hebergementB_es:=$hebergement_es.copy()

$champ_c:=$hebergement_es.toCollection($champ_t)
$valueToSearch_t:=$P_ve_p3->{$compteur}

Case of 
	: ($cas=0)
		
		Case of 
			: ($champ_t="HG_EtatCivilFusion")  // Modifié par : Scanu Rémy - remy@connect-io.fr (29/09/2023)
				$tableFusion_es:=ds:C1482.TableFusions.query("TF_RéférenceTable = :1 AND TF_Diviseur > :2 AND TF_Libellé = :3"; "EtaCv"; 0; $valueToSearch_t)
				outilsOrdaSearchByRefStctre(->$tableFusion_es)
				
				$etatCivil_c:=$tableFusion_es.toCollection("TF_LibelléOrigine").extract("TF_LibelléOrigine")
				$hebergementB_es:=$hebergementB_es.query("HG_EtatCivil in :1"; $etatCivil_c)
			: ($valueToSearch_t#"Sans valeur")  // Modifié par : Scanu Rémy - remy@connect-io.fr (02/07/2021)
				$hebergementB_es:=$hebergementB_es.query($champ_t+" = :1"; $valueToSearch_t)
			Else 
				$hebergementB_es:=$hebergementB_es.query($champ_t+" = :1 OR "+$champ_t+" = :2"; ""; "NR")
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (13/07/2021)
				$pos_el:=Find in array:C230($P_ve_p3->; "NR")
				
				If ($pos_el#-1)  // Il y a un item dans la X° liste qui comporte la valeur NR, il faut donc enlever ce résultat des enregistrements trouvés
					$hebergementB_es:=$hebergementB_es.query($champ_t+" # :1"; "NR")
				End if 
		End case 
		
	: ($cas=1)  // Boolean
		
		// Modifié par : Scanu Rémy (14/04/2023)
		// Cas particulier pour HG_Genre
		Case of 
			: ($champ_t="HG_genre")
				
				If (Is a variable:C294(->parametre_o)=True:C214)
					
					Case of 
						: ($valueToSearch_t="Sans valeur")
							$hebergementB_es:=ds:C1482.HeberGement.newSelection()
						: (parametre_o.HG_GenrePrecedent=Null:C1517)  // On recherche en premier les hommes
							$hebergementB_es:=$hebergementB_es.query($champ_t+" = :1"; False:C215)
							parametre_o.HG_GenrePrecedent:="Homme"
						Else   // On recherche les femmes
							$hebergementB_es:=$hebergementB_es.query($champ_t+" = :1"; True:C214)
							OB REMOVE:C1226(parametre_o; "HG_GenrePrecedent")
					End case 
					
				End if 
				
			: (Is a variable:C294(->parametre_o)=True:C214)
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (13/07/2021)
				Case of 
					: ($valueToSearch_t="Sans valeur")
						$hebergementB_es:=ds:C1482.HeberGement.newSelection()
					: (Bool:C1537(parametre_o.boolSuivant)=False:C215)
						$hebergementB_es:=$hebergementB_es.query($champ_t+" = :1"; False:C215)
						parametre_o.boolSuivant:=True:C214
					Else 
						$hebergementB_es:=$hebergementB_es.query($champ_t+" = :1"; True:C214)
						parametre_o.boolSuivant:=False:C215
				End case 
				
			Else 
				$hebergementB_es:=$hebergementB_es.query($champ_t+" = :1"; False:C215)
		End case 
		
	: ($cas=2)  // Tranche age
		$L_SizeTrancheAge:=Size of array:C274(<>te_TrancheAge)
		// Compteur = 1 on teste 3-18   
		// Compteur = 2 on teste 19-24
		// Compteur = 3 on teste 25-29
		// Compteur = 4 on teste 30-39
		// Compteur = 5 on teste 40-49
		// Compteur = 6 on teste 50-59
		// Compteur = 7 on teste 60-69
		// Compteur = 8 on teste +69
		// Compteur = 9 on teste ?
		
		// Modifié par : Scanu Rémy (13/04/2023)
		
		Case of 
			: ($valueToSearch_t="Sans valeur")
				$hebergementB_es:=ds:C1482.HeberGement.newSelection()
			: ($compteur<=Size of array:C274(<>te_TrancheAge))
				
				// Modifié par : Scanu Rémy - remy@connect-io.fr (02/07/2021)
				Case of 
					: ($compteur=1)
						$hebergementB_es:=$hebergementB_es.query("HG_Age < :1"; <>te_TrancheAge{$compteur})
					: ($compteur>=2) & ($compteur<=8)
						
						If ($compteur>=$L_SizeTrancheAge)
							$hebergementB_es:=$hebergementB_es.query("HG_Age >= :1"; <>te_TrancheAge{$compteur})
						Else 
							$hebergementB_es:=$hebergementB_es.query("HG_Age >= :1 AND HG_Age < :2"; <>te_TrancheAge{$compteur-1}; <>te_TrancheAge{$compteur})
						End if 
						
					: ($compteur=9)
						$hebergementB_es:=$hebergementB_es.query("HG_Age >= :1"; <>te_TrancheAge{$compteur})
					Else 
						$hebergementB_es:=ds:C1482.HeberGement.newSelection()
				End case 
				
		End case 
		
End case 

If (Is a variable:C294(->parametre_o)=True:C214)
	parametre_o.champPrecedent.push($champ_t)
End if 

USE ENTITY SELECTION:C1513($hebergementB_es)
LOAD RECORD:C52([HeberGement:5])

// Modifié par : Scanu Rémy (06/03/2024)
If (Value type:C1509(sansChangementSituation_b)#Est une variable indéfinie:K8:13)
	
	If (sansChangementSituation_b=True:C214)
		$hebergement_es:=Create entity selection:C1512([HeberGement:5])
		$hebergementB_es:=$hebergement_es.getSituationUnique()
		
		USE ENTITY SELECTION:C1513($hebergementB_es)
		LOAD RECORD:C52([HeberGement:5])
	End if 
	
End if 