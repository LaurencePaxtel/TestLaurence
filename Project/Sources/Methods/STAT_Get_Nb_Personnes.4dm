//%attributes = {}
// ----------------------------------------------------
// LOGICIEL : Samu Social de Paris
// © DBsolutions/Paxtel
// Développeur : Kevin HASSAL
// Date and time: 09/08/19, 16:23:49
// ----------------------------------------------------
// Method: STAT_Get_Nb_Personnes
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $0 : Integer
var $heberge_es : cs:C1710.HeBergeSelection
var $hebergement_es : cs:C1710.HeberGementSelection


// Modifié par : Scanu Rémy (22/02/2024)
// Code plus moderne
$hebergement_es:=Create entity selection:C1512([HeberGement:5])
$heberge_es:=$hebergement_es.HG_HB_ID_1_HB_ReferenceID

USE ENTITY SELECTION:C1513($heberge_es)
LOAD RECORD:C52([HeBerge:4])

/*
VALEURS DISTINCTES([HeberGement]HG_HB_ID; $tb_hb_ref_id)
CHERCHER PAR TABLEAU([HeBerge]HB_ReferenceID; $tb_hb_ref_id)
*/

// Modifié par : Scanu Rémy (18/02/2022)
// Prise en compte particulière pour la rechercher sur l'Etat Civil (on attend finalement...)
If (Is a variable:C294(->parametre_o)=True:C214)
	
	If (parametre_o.heberge#Null:C1517)
		//$table_o:=Créer Entity Selection([HeBerge])
		//$autreTable_o:=ds.HeBerge.newSelection()
		
		//Pour chaque ($enregistrement_o;$table_o)
		//$position_el:=parametre_o.heberge.indexOf($enregistrement_o.HB_ReferenceID)
		
		//Si($position_el=-1)
		//parametre_o.heberge.push($enregistrement_o.HB_ReferenceID)
		//$autreTable_o.add($enregistrement_o)
		//Fin de si
		
		//Fin de chaque 
		
		//UTILISER ENTITY SELECTION($autreTable_o)
		//CHARGER ENREGISTREMENT([HeBerge])
	End if 
	
End if 

$0:=Records in selection:C76([HeBerge:4])