//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 26/06/2020, 16:39:33
// ----------------------------------------------------
// Method: PAR_Chargement
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Real

var $i_el; $moisDebut_el; $moisFin_el; $moisSelect_el; $pos_el : Integer
var $date_d : Date

var ptrResType1_p; ptrResType2_p; ptrResType3_p; ptrResType4_p; ptrResType5_p; ptrResType6_p; ptrResType7_p; \
ptrResType8_p; ptrMontant1_p; ptrMontant2_p; ptrMontant3_p; ptrMontant4_p; ptrMontant5_p; \
ptrMontant6_p; ptrMontant7_p; ptrMontant8_p; ptrMontantT_p; ptrTaux_p; ptrMontantF_p : Pointer

var $hebergement_es : cs:C1710.HeberGementSelection

var $participation_e : cs:C1710.ParticipationsEntity
var $participation_es : cs:C1710.ParticipationsSelection

$moisDebut_el:=1
$moisFin_el:=12

// Modifié par : Scanu Rémy (22/12/2022)
Form:C1466.extra:=New object:C1471
Form:C1466.apl:=New object:C1471("total"; 0)

Form:C1466.referent:=""
Form:C1466.coordinateur:=""
Form:C1466.personneMenage:=1
Form:C1466.forceEnvoi:=False:C215

For ($i_el; $moisDebut_el; $moisFin_el)
	$date_d:=Date:C102("01/"+String:C10($i_el; "00")+"/"+String:C10(Year of:C25(Current date:C33)))
	
	// Modifié par : Scanu Rémy (18/04/2023)
	// Ajout en dur des extras
	Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))]:=New object:C1471("detail"; New collection:C1472)
	
	Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))].detail.push(New object:C1471("libelle"; "Eau"; "montant"; 0))
	Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))].detail.push(New object:C1471("libelle"; "Electricite"; "montant"; 0))
	Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))].detail.push(New object:C1471("libelle"; "Gaz"; "montant"; 0))
	Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))].detail.push(New object:C1471("libelle"; "Internet"; "montant"; 0))
	Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))].detail.push(New object:C1471("libelle"; "Téléphone"; "montant"; 0))
	Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))].detail.push(New object:C1471("libelle"; "Autre"; "montant"; 0))
	
	Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))]:=New object:C1471("montantEnvisage"; 0; "dateReception"; !00-00-00!; "montantRecu"; 0; "solde"; 0)
End for 

If (Count parameters:C259>0)
	$moisSelect_el:=$1
	
	If ($moisSelect_el>0)
		$moisDebut_el:=$moisSelect_el
		$moisFin_el:=$moisSelect_el
	End if 
	
End if 

For ($i_el; $moisDebut_el; $moisFin_el)
	$date_d:=Date:C102("01/"+String:C10($i_el; "00")+"/"+String:C10(Year of:C25(Current date:C33)))
	
	// Modifié par : Scanu Rémy (21/12/2022)
	// Utilisation d'un méthode générique
	outilsVariableDeclareByProg(Est un texte:K8:3; True:C214; "res_type_"+String:C10($i_el)+"_1"; "res_type_"+String:C10($i_el)+"_2"; \
		"res_type_"+String:C10($i_el)+"_3"; "res_type_"+String:C10($i_el)+"_4"; "res_type_"+String:C10($i_el)+"_5"; \
		"res_type_"+String:C10($i_el)+"_6"; "res_type_"+String:C10($i_el)+"_7"; "res_type_"+String:C10($i_el)+"_8"; "par_taux_"+String:C10($i_el))
	
	outilsVariableDeclareByProg(Est un numérique:K8:4; True:C214; "p_montant_"+String:C10($i_el)+"_1"; "p_montant_"+String:C10($i_el)+"_2"; \
		"p_montant_"+String:C10($i_el)+"_3"; "p_montant_"+String:C10($i_el)+"_4"; "p_montant_"+String:C10($i_el)+"_5"; \
		"p_montant_"+String:C10($i_el)+"_6"; "p_montant_"+String:C10($i_el)+"_7"; "p_montant_"+String:C10($i_el)+"_8"; \
		"p_montant_t_"+String:C10($i_el); "p_montant_f_"+String:C10($i_el))
	
	//====================================================//
	// Initialisation des variables
	//====================================================//
	
	// Modifié par : Scanu Rémy (07/04/2023)
	// En mode compilé, on ne peut pas utiliser des variables locales avec la commande EXÉCUTER FORMULE
	$variable_c:=New collection:C1472
	
	For ($j_el; 1; 8)
		$variable_c.push(New object:C1471(\
			"name"; "ptrResType"+String:C10($j_el)+"_p"; "value"; "->res_type_"+String:C10($i_el)+"_"+String:C10($j_el)))
		$variable_c.push(New object:C1471(\
			"name"; "ptrMontant"+String:C10($j_el)+"_p"; "value"; "->p_montant_"+String:C10($i_el)+"_"+String:C10($j_el)))
	End for 
	
	outilsVariableAffectValueByProg($variable_c)
	
	EXECUTE FORMULA:C63("ptrMontantT_p:=->p_montant_t_"+String:C10($i_el))
	EXECUTE FORMULA:C63("ptrTaux_p:=->par_taux_"+String:C10($i_el))
	EXECUTE FORMULA:C63("ptrMontantF_p:=->p_montant_f_"+String:C10($i_el))
	
	ptrTaux_p->:="0%"
	
	$participation_e:=ds:C1482.Participations.searchAndCreateRecordIfDontExist(PAR_HB_ReferenceID; par_selected_year; $i_el; <>ref_soc_active)
	
	ptrResType1_p->:=$participation_e.PAR_Ressource_1
	ptrResType2_p->:=$participation_e.PAR_Ressource_2
	ptrResType3_p->:=$participation_e.PAR_Ressource_3
	ptrResType4_p->:=$participation_e.PAR_Ressource_4
	ptrResType5_p->:=$participation_e.PAR_Ressource_5
	ptrResType6_p->:=$participation_e.PAR_Ressource_6
	ptrResType7_p->:=$participation_e.PAR_Ressource_7
	ptrResType8_p->:=$participation_e.PAR_Ressource_8
	
	ptrMontant1_p->:=$participation_e.PAR_Montant_1
	ptrMontant2_p->:=$participation_e.PAR_Montant_2
	ptrMontant3_p->:=$participation_e.PAR_Montant_3
	ptrMontant4_p->:=$participation_e.PAR_Montant_4
	ptrMontant5_p->:=$participation_e.PAR_Montant_5
	ptrMontant6_p->:=$participation_e.PAR_Montant_6
	ptrMontant7_p->:=$participation_e.PAR_Montant_7
	ptrMontant8_p->:=$participation_e.PAR_Montant_8
	
	ptrMontantT_p->:=$participation_e.PAR_Montant_Total
	ptrTaux_p->:=String:C10($participation_e.PAR_Taux)+"%"
	ptrMontantF_p->:=$participation_e.PAR_Montant_Participation
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (06/05/2021)
	If ($participation_e.PAR_Menage#"") & (Size of array:C274(enumList_at)#0)
		$pos_el:=Find in array:C230(enumList_at; $participation_e.PAR_Menage)
		
		If ($pos_el>0)
			enumList_at:=$pos_el
			
			enumList_at{0}:=$participation_e.PAR_Menage
			enumList_at{enumList_at}:=$participation_e.AR_Menage
			
			Form:C1466.personneMenage:=Num:C11($participation_e.PAR_Menage)
		End if 
		
	End if 
	
	// Modifié par : Scanu Rémy (22/12/2022) et Re-modifié par Scanu Rémy (17/04/2023)
	// Ajout des champs Extra & APL
	If ($participation_e.PAR_Extra#Null:C1517)
		Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))]:=OB Copy:C1225($participation_e.PAR_Extra)
	End if 
	
	Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].montantEnvisage:=$participation_e.PAR_APL_Attente
	Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].dateReception:=$participation_e.PAR_APL_Date
	Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].montantRecu:=$participation_e.PAR_APL_Recu
	Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].solde:=$participation_e.PAR_APL_Solde
	
	Form:C1466.apl.total:=Form:C1466.apl.total+$participation_e.PAR_APL_Solde
	
	If (Form:C1466.referent="")
		Form:C1466.referent:=$participation_e.PAR_Referent
	End if 
	
	If (Form:C1466.coordinateur="")
		Form:C1466.coordinateur:=$participation_e.PAR_Coordinateur
	End if 
	
End for 

If (String:C10(Form:C1466.referent)="") | (String:C10(Form:C1466.coordinateur)="")
	$hebergement_es:=ds:C1482.HeberGement.query("HG_HB_ID = :1 AND HG_Cloturée = :2"; PAR_HB_ReferenceID; True:C214)
	outilsOrdaSearchByRefStctre(->$hebergement_es)
	
	$hebergement_es:=$hebergement_es.orderBy("HG_Date asc, HG_HeureAppel asc")
	
	If ($hebergement_es.length>0)
		
		If (Form:C1466.referent="")
			Form:C1466.referent:=$hebergement_es[0].HG_Permanencier
		End if 
		
		If (Form:C1466.coordinateur="")
			Form:C1466.coordinateur:=$hebergement_es[0].HG_Coordinateur
		End if 
		
	End if 
	
End if 

If (Num:C11(Form:C1466.personneMenage)=0)
	Form:C1466.personneMenage:=1
End if 

$participation_es:=ds:C1482.Participations.query("PAR_HB_ID = :1 AND PAR_Annee = :2 AND PAR_participationWebID = 0"; PAR_HB_ReferenceID; par_selected_year)
outilsOrdaSearchByRefStctre(->$participation_es)

$participation_es:=$participation_es.orderBy("PAR_Annee asc, PAR_Mois asc")
Form:C1466.participation:=$participation_es.toCollection()

POST OUTSIDE CALL:C329(Current process:C322)