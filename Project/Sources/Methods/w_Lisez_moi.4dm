//%attributes = {}
// Method w_Lisez_moi  


// data SIAO 92
C_TEXT:C284($T_Path)
$T_Path:=System folder:C487(Bureau:K41:16)+"Debug_JSON_Paxtel"+Séparateur dossier:K24:12
If (Test path name:C476($T_Path)#Est un dossier:K24:2)
	CREATE FOLDER:C475($T_Path)
End if 

C_OBJECT:C1216($O_Output)
C_TEXT:C284($T_JSON)
C_TIME:C306($H_Doc)

// Créer une sélection d'individus en cherchant par le nom
// - retourne un objet contenant un tableau d'objet
// comme dans le formulaire [DiaLogues];"DL_HébergementGroupe"
$O_Output:=w_Get_Individus_par_nom("jab@")
$T_JSON:=JSON Stringify:C1217($O_Output; *)
$H_Doc:=Create document:C266($T_Path+"individus_par_nom.json")
If (OK=1)
	SEND PACKET:C103($H_Doc; $T_JSON)
	CLOSE DOCUMENT:C267($H_Doc)
End if 


// On a sélectionné un individu
// On veut la liste de ses hebergements
// comme dans le formulaire [DiaLogues];"DL_HébergementGroupe"
$O_Output:=w_Get_hebergements_individu(205436)  // [HeBerge]HB_ReferenceID
$T_JSON:=JSON Stringify:C1217($O_Output; *)
$H_Doc:=Create document:C266($T_Path+"hebergements_individu.json")
If (OK=1)
	SEND PACKET:C103($H_Doc; $T_JSON)
	CLOSE DOCUMENT:C267($H_Doc)
End if 

// On veut voir l'hebergement d'un individu
// comme dans le formulaire [DiaLogues];"DL_HébergementGroupe"
$O_Output:=w_Get_hebergement_detail(7311402)  //[HeberGement]HG_ReferenceID
$T_JSON:=JSON Stringify:C1217($O_Output; *)
$H_Doc:=Create document:C266($T_Path+"hebergement_detail.json")
If (OK=1)
	SEND PACKET:C103($H_Doc; $T_JSON)
	CLOSE DOCUMENT:C267($H_Doc)
End if 



// On veut voir des hebergements entre deux dates
// L'objet contient le tableau des heberegement et le tableau des hebergés
$O_Output:=w_Get_hebergement_parDate(!2016-01-01!; !2016-01-01!)
$T_JSON:=JSON Stringify:C1217($O_Output; *)
$H_Doc:=Create document:C266($T_Path+"hebergements_parDate.json")
If (OK=1)
	SEND PACKET:C103($H_Doc; $T_JSON)
	CLOSE DOCUMENT:C267($H_Doc)
End if 


BEEP:C151
BEEP:C151
ABORT:C156

// On a modifié un hébergement. 
$L_Erreur:=w_Set_hebergement_detail("JSON dela page web")
