//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 27/06/2020, 16:30:41
// ----------------------------------------------------
// Method: PAR_Dupliquer
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Integer
var $2 : Boolean

var $i_el; $j_el; $moisDebut_el : Integer
var $date_d : Date
var $variable_c : Collection

var resType1_t; resType2_t; resType3_t; resType4_t; resType5_t; resType6_t; resType7_t; resType8_t : Text
var montant1_r; montant2_r; montant3_r; montant4_r; montant5_r; montant6_r; montant7_r; montant8_r; montantT_r; tauxP_r; montantF_r : Real

var ptrResType1_p; ptrResType2_p; ptrResType3_p; ptrResType4_p; ptrResType5_p; ptrResType6_p; ptrResType7_p; \
ptrResType8_p; ptrMontant1_p; ptrMontant2_p; ptrMontant3_p; ptrMontant4_p; ptrMontant5_p; \
ptrMontant6_p; ptrMontant7_p; ptrMontant8_p; ptrMontantT_p; ptrTaux_p; ptrMontantF_p : Pointer

// Modifié par : Scanu Rémy (18/01/2022)
If ($1<12)
	$moisDebut_el:=$1
Else 
	par_selected_year:=par_selected_year+1
End if 

If ($2=True:C214)
	
	For ($i_el; $moisDebut_el; 11)
		PAR_Dupliquer($i_el; False:C215)
	End for 
	
Else 
	READ WRITE:C146([Participations:116])
	
	QUERY:C277([Participations:116]; [Participations:116]PAR_HB_ID:2=PAR_HB_ReferenceID; *)
	QUERY:C277([Participations:116];  & ; [Participations:116]PAR_Mois:4=$moisDebut_el+1; *)
	QUERY:C277([Participations:116];  & ; [Participations:116]PAR_Annee:3=par_selected_year)
	MultiSoc_Filter(->[Participations:116])
	
	If (Records in selection:C76([Participations:116])=0)
		CREATE RECORD:C68([Participations:116])
		MultiSoc_Init_Structure(->[Participations:116])
		
		[Participations:116]PAR_HB_ID:2:=PAR_HB_ReferenceID
		[Participations:116]PAR_Mois:4:=$moisDebut_el+1
		[Participations:116]PAR_Annee:3:=par_selected_year
	End if 
	
	//------//
	If ($1=12)
		$moisDebut_el:=$1
	End if 
	
	// Modifié par : Scanu Rémy (07/04/2023)
	// En mode compilé, on ne peut pas utiliser des variables locales avec la commande EXÉCUTER FORMULE
	$variable_c:=New collection:C1472
	
	For ($j_el; 1; 8)
		$variable_c.push(New object:C1471(\
			"name"; "[Participations]PAR_Ressource_"+String:C10($j_el); "value"; "Form.participation["+String:C10($moisDebut_el-1)+"].PAR_Ressource_"+String:C10($j_el)))
		$variable_c.push(New object:C1471(\
			"name"; "[Participations]PAR_Montant_"+String:C10($j_el); "value"; "Form.participation["+String:C10($moisDebut_el-1)+"].PAR_Montant_"+String:C10($j_el)))
	End for 
	
	outilsVariableAffectValueByProg($variable_c)
	
	[Participations:116]PAR_Montant_Total:16:=Form:C1466.participation[$moisDebut_el-1].PAR_Montant_Total
	[Participations:116]PAR_Taux:15:=Num:C11(Form:C1466.participation[$moisDebut_el-1].PAR_Taux)
	[Participations:116]PAR_Montant_Participation:18:=Form:C1466.participation[$moisDebut_el-1].PAR_Montant_Participation
	
	// Modifié par : Scanu Rémy (22/12/2022) et Re-modifié par Scanu Rémy (17/04/2023)
	// Ajout des champs Extra & APL
	$date_d:=Date:C102("01/"+String:C10($moisDebut_el; "00")+"/"+String:C10(par_selected_year))
	
	[Participations:116]PAR_Extra:35:=OB Copy:C1225(Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))])
	
	[Participations:116]PAR_APL_Attente:20:=Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].montantEnvisage
	[Participations:116]PAR_APL_Date:23:=Add to date:C393(Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].dateReception; 0; 1; 0)
	[Participations:116]PAR_APL_Recu:22:=Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].montantRecu
	[Participations:116]PAR_APL_Solde:24:=Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].solde
	SAVE RECORD:C53([Participations:116])
	
	//----------------------------------------------------------------//
	// Chargement 
	//----------------------------------------------------------------//
	If ($1<12)
		$date_d:=Date:C102("01/"+String:C10($moisDebut_el+1; "00")+"/"+String:C10(par_selected_year))
		
		// Modifié par : Scanu Rémy (07/04/2023)
		// En mode compilé, on ne peut pas utiliser des variables locales avec la commande EXÉCUTER FORMULE
		$variable_c:=New collection:C1472
		
		For ($j_el; 1; 8)
			$variable_c.push(New object:C1471(\
				"name"; "Form.participation["+String:C10($moisDebut_el)+"].PAR_Ressource_"+String:C10($j_el); "value"; "[Participations]PAR_Ressource_"+String:C10($j_el)))
			$variable_c.push(New object:C1471(\
				"name"; "Form.participation["+String:C10($moisDebut_el)+"].PAR_Montant_"+String:C10($j_el); "value"; "[Participations]PAR_Montant_"+String:C10($j_el)))
		End for 
		
		outilsVariableAffectValueByProg($variable_c)
		
		Form:C1466.participation[$moisDebut_el].PAR_Montant_Total:=[Participations:116]PAR_Montant_Total:16
		Form:C1466.participation[$moisDebut_el].PAR_Taux:=[Participations:116]PAR_Taux:15
		Form:C1466.participation[$moisDebut_el].PAR_Montant_Participation:=[Participations:116]PAR_Montant_Participation:18
		
		// Modifié par : Scanu Rémy (22/12/2022) et Re-modifié par Scanu Rémy (17/04/2023)
		// Ajout des champs Extra & APL
		Form:C1466.extra[Lowercase:C14(outilsGetLibDate(2; $date_d))]:=OB Copy:C1225([Participations:116]PAR_Extra:35)
		
		Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].montantEnvisage:=[Participations:116]PAR_APL_Attente:20
		Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].dateReception:=[Participations:116]PAR_APL_Date:23
		Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].montantRecu:=[Participations:116]PAR_APL_Recu:22
		Form:C1466.apl[Lowercase:C14(outilsGetLibDate(2; $date_d))].solde:=[Participations:116]PAR_APL_Solde:24
	End if 
	
	UNLOAD RECORD:C212([Participations:116])
End if 

// Modifié par : Scanu Rémy (18/01/2022)
If ($moisDebut_el=12)
	par_selected_year:=par_selected_year-1
End if 