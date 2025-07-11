Class extends Entity



Function get HG_Mois() : Text
/*------------------------------------------------------------------------------
Champ calculé : Hebergement.HG_Mois
	
Retourne le mois du champ HG_Date
	
Historiques
11/12/24 - gregory@connect-io.fr - Création
	
------------------------------------------------------------------------------*/
	
	return Substring:C12(String:C10(This:C1470.HG_Date); 4)
	
Function query HG_Mois($event : Object)->$result : Object
/*------------------------------------------------------------------------------
Query : Hebergement.HG_Mois
	
Recherche les hebergements en fonction du mois.
	
Historique
11/12/24 - gregory@connect-io.fr - Création
------------------------------------------------------------------------------*/
	
	var $firstName_t; $lastName_t; $query_t : Text
	var $parameters_c : Collection
	
	$dateMin:=Date:C102("01/"+$event.value)
	$dateMax:=Add to date:C393($dateMin; 0; 1; -1)
	
	$parameters_c:=New collection:C1472($dateMin; $dateMax)  // mois en chiffre
	
	$query_t:="HG_Date >= :1 and HG_Date <= :2"
	
	$result:=New object:C1471("query"; $query_t; "parameters"; $parameters_c)
	
	
	
Function getTsModif()
	var $date_t; $heure_t : Text
	
	If (Length:C16(This:C1470.HG_ModifDateHeures)=13)  // AAAAMMJJHR:MN
		$date_t:=Substring:C12(This:C1470.HG_ModifDateHeures; 1; 8)
		$heure_t:=Substring:C12(This:C1470.HG_ModifDateHeures; 9)+":00"  // On rajoute les secondes car non stocké
		
		$date_t:=Substring:C12($date_t; 7; 2)+"/"+Substring:C12($date_t; 5; 2)+"/"+Substring:C12($date_t; 1; 4)
	Else 
		$date_t:=String:C10(This:C1470.HG_Date)
		$heure_t:=String:C10(This:C1470.HG_HeureAppel)
	End if 
	
	If (Date:C102($date_t)#!00-00-00!)
		This:C1470.HG_TimeStamp:=outilsTimeStamp(Date:C102($date_t); Time:C179($heure_t))
	End if 
	
Function saveEntity($entree_el : Integer)

       // Mise à jour automatique du genre en fonction de l'état civil
       C_LONGINT:C283($vl_Position)

       This:C1470.HG_Genre:=False:C215
       $vl_Position:=Position:C15("("; This:C1470.HG_EtatCivil)

       If ($vl_Position>0)
               If (Substring:C12(This:C1470.HG_EtatCivil; $vl_Position+1; 1)="F")
                       This:C1470.HG_Genre:=True:C214
               End if
       End if

       // Synchronise la fiche HeBerge liée si elle existe
       var $heberge_e : cs:C1710.HeBergeEntity
       $heberge_e:=This:C1470.HG_HB_ID_1_HB_ReferenceID

       If ($heberge_e#Null:C1517)
               $heberge_e.HG_Genre:=This:C1470.HG_Genre
               $heberge_e.save()
       End if

       Case of
               : ($1=1)  // Import données application mobile depuis la fonction synchroAppMobileImportData()
                       This:C1470.importApplicationMobile:=True:C214
       End case
	
	
Function FixBugNumeroFiche()
	
	If (This:C1470.HG_FicheNuméro="-@")
		This:C1470.HG_FicheNuméro:=This:C1470.Ref_Structure+This:C1470.HG_FicheNuméro
		This:C1470.save()
	End if 