//%attributes = {}
// ======================================================================
// Methode projet : Web_Facturation_Auto
// 
// ----------------------------------------------------------------------

If (False:C215)  // Historique
	// 22/02/19 Kevin HASSAL - Création
	// 18/12/20 remy@connect-io.fr - Non prise en compte location dont le montant est égal à 0
	// 24/02/21 remy@connect-io.fr - Ajout du bordage de date pour les charges
	// 29/07/21 remy@connect-io.fr - Ajout du solde due du dernier mois facturé précédemment
	// 22/09/21 remy@connect-io.fr - Correction bug facturation auto pour le premier facturé si la date d'entrée est supérieur au 01 du mois facturé, ça ne marchait pas
	// 06/10/21 remy@connect-io.fr - Correction bug mauvaise prise en compte des dates pour la facture générée
	// 01/12/21 remy@connect-io.fr - Correction bug factures avec montant TTC négatif car APL n'était pas proratisé
End if 

If (True:C214)  // Déclarations
	C_TEXT:C284($Status; $adr_facturation; $month_year; $separation_charges; $txt_adresse_proprietaire; $txt_adresse_locataire)
	C_LONGINT:C283($mois_numero; $fac_genere_count; $nbre_jours_du_mois; $i_el; $annee)
	C_REAL:C285($total_charges)
	C_BOOLEAN:C305($continu_location; $continu_charge)
	C_DATE:C307($current_date)
	C_POINTER:C301($table_origine; $table_origine)
	C_OBJECT:C1216($O_Output; $O_Data)
	
	ARRAY TEXT:C222($tableau_at; 0)
	
	ARRAY LONGINT:C221($factureLigne_ai; 0)
	ARRAY LONGINT:C221($tableau_ai; 0)
End if 

$O_Output:=New object:C1471

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; "facturation"; Est un objet:K8:27)

$month_year:=OB Get:C1224($O_Data; "fac_auto_mois"; Est un texte:K8:3)
$separation_charges:=OB Get:C1224($O_Data; "separation_charges"; Est un texte:K8:3)

READ ONLY:C145([HeBerge:4])
READ ONLY:C145([LesCentres:9])

$status:="Failed"

ALL RECORDS:C47([Locations:84])
MultiSoc_Filter(->[Locations:84])

$current_date:=Date:C102(String:C10("01")+"/"+Replace string:C233($month_year; "-"; "/"))
$mois_numero:=Month of:C24($current_date)
$annee:=Year of:C25($current_date)

// Modifié par : Scanu Rémy (26/08/2021)
// Ajout la possibilité de filtré par location
If ($O_Data.locationSelected#Null:C1517)
	JSON PARSE ARRAY:C1219($O_Data.locationSelected; $tableau_at)
	
	For ($i_el; 1; Size of array:C274($tableau_at))
		APPEND TO ARRAY:C911($tableau_ai; Num:C11($tableau_at{$i_el}))
	End for 
	
	// Modifié par : Scanu Rémy (22/07/2024)
	// On ne prend en compte que la sélection que s'il y a au moins un élément sélectionné
	If (Size of array:C274($tableau_ai)>0)
		QUERY SELECTION WITH ARRAY:C1050([Locations:84]ID:1; $tableau_ai)
	End if 
	
End if 

$O_Output.location:=New collection:C1472

While (Not:C34(End selection:C36([Locations:84])))
	$O_Output.location.push(New object:C1471(\
		"id"; [Locations:84]ID:1; \
		"bien"; [Locations:84]LOC_Bien_Nom:12; \
		"locataire"; [Locations:84]LOC_Usager_Prenom_Nom:16))
	
	// Modifié par: remy@connect-io.fr (18/12/2020) et Re modifié par: remy@connect-io.fr (22/09/2021) et Re-re modifié par: remy@connect-io.fr (06/10/2021)
	If ((([Locations:84]LOC_Date_Entree:9>=$current_date) & (Month of:C24([Locations:84]LOC_Date_Entree:9)=Month of:C24($current_date)) & (Year of:C25([Locations:84]LOC_Date_Entree:9)=Year of:C25($current_date))) | \
		(($current_date>[Locations:84]LOC_Date_Entree:9) & ($current_date<=[Locations:84]LOC_Date_Sortie:10)) | \
		([Locations:84]LOC_Date_Sortie:10=!00-00-00!))
		//=========================================================//
		// Pièce
		//=========================================================//
		$adr_facturation:=Web_FAC_Get_Address([Locations:84]LOC_Bien_ID:5; [Locations:84]LOC_HB_ID:3)
		
		//Adresse Proprietaire
		QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=[Locations:84]LOC_Bien_ID:5; *)
		QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252(->[LesCentres:9]))
		MultiSoc_Filter(->[Adresses:53])
		
		$txt_adresse_proprietaire:=[Adresses:53]AD_Adresse1:16+" "+[Adresses:53]AD_Adresse2:17+" "+[Adresses:53]AD_Adresse3:18+" "+[Adresses:53]AD_Ville:20
		
		//Adresse Locataire
		QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Locations:84]LOC_HB_ID:3)
		MultiSoc_Filter(->[HeBerge:4])
		
		QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=[HeBerge:4]ID:65; *)
		QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252(->[HeBerge:4]))
		MultiSoc_Filter(->[Adresses:53])
		
		$txt_adresse_locataire:=[Adresses:53]AD_Adresse1:16+" "+[Adresses:53]AD_Adresse2:17+" "+[Adresses:53]AD_Adresse3:18+" "+[Adresses:53]AD_Ville:20
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Locations:84]LOC_Bien_ID:5)
		MultiSoc_Filter(->[LesCentres:9])
		
		QUERY:C277([Proprietaires:83]; [Proprietaires:83]ID:1=[LesCentres:9]LC_GL_Proprietaire_ID:66)
		MultiSoc_Filter(->[Proprietaires:83])
		
		// Modifié par : Scanu Rémy (05/04/2023)
		START TRANSACTION:C239
		
		CREATE RECORD:C68([Factures:86])
		MultiSoc_Init_Structure(->[Factures:86])
		
		[Factures:86]FAC_Intervenant_ID:27:=w_userUID
		[Factures:86]FAC_Date_Piece:3:=Current date:C33(*)
		[Factures:86]FAC_Date_Echeance:20:=Add to date:C393(Current date:C33(*); 0; 0; 10)
		[Factures:86]FAC_Bien_ID:28:=[Locations:84]LOC_Bien_ID:5
		[Factures:86]FAC_Bien_Nom:30:=[Locations:84]LOC_Bien_Nom:12
		[Factures:86]FAC_Locataire_Nom:31:=[Locations:84]LOC_Usager_Prenom_Nom:16
		[Factures:86]FAC_Locataire_ID:29:=[Locations:84]LOC_HB_ID:3
		[Factures:86]FAC_Bien_Proprietaire_ID:35:=[Proprietaires:83]ID:1
		[Factures:86]FAC_Bien_Proprietaire_Nom:36:=[Proprietaires:83]PRO_Nom:2+" "+[Proprietaires:83]PRO_Prenom:3
		[Factures:86]FAC_Type:21:="Provisoire"
		
		// Modifié par : Scanu Rémy (22/03/2024)
		// Par défaut on met le locataire en destinataire
/*
[Factures]FAC_Destifac_locataire_nomnataire_Type:=[HeBerge]HB_FAC_Destation
		
Au cas ou 
: ([Factures]FAC_Destinataire_Type="Propriétaire")
[Factures]FAC_Destinataire_Nom:=[Factures]FAC_Bien_Proprietaire_Nom
: ([Factures]FAC_Destinataire_Type="Locataire")
[Factures]FAC_Destinataire_Nom:=[Locations]LOC_Usager_Prenom_Nom
Sinon 
[Factures]FAC_Destinataire_Nom:=[Locations]LOC_Bien_Nom
Fin de cas 
*/
		
		[Factures:86]FAC_Destinataire_Type:50:="Locataire"
		[Factures:86]FAC_Destinataire_Nom:13:=[Locations:84]LOC_Usager_Prenom_Nom:16
		[Factures:86]FAC_Destinataire_ID:11:=[Factures:86]FAC_Locataire_ID:29
		
		[Factures:86]FAC_Adresse_Facturation:14:=$adr_facturation
		[Factures:86]FAC_Adresse_Proprietaire:59:=$txt_adresse_proprietaire
		[Factures:86]FAC_Adresse_Locataire:60:=$txt_adresse_locataire
		[Factures:86]FAC_Mode_Reglement:22:="Espèce"
		
		If ([Factures:86]FAC_Type:21="Définitive") & ([Factures:86]FAC_No_Piece:2="")
			[Factures:86]FAC_No_Piece:2:="FAC/"+UTL_Numerotation_Piece(->[Factures:86]FAC_Date_Piece:3)
			[Factures:86]FAC_Cloture:10:=True:C214
			[Factures:86]FAC_Statut:16:="Clôturée"
		End if 
		
		[Factures:86]FAC_Periode:32:=$month_year
		
		// Modifié par : Scanu Rémy (02/09/2021) & Modifié par : Scanu Rémy (22/09/2021)
		// Ajout des champs [Factures]FAC_Periode_Du & [Factures]FAC_Periode_Au  && Ajout du calcul au prorata si le mois facturé est le premier mois de facturation
		If ($mois_numero=Month of:C24([Locations:84]LOC_Date_Entree:9)) & ($annee=Year of:C25([Locations:84]LOC_Date_Entree:9))
			[Factures:86]FAC_Periode_Du:51:=[Locations:84]LOC_Date_Entree:9
		Else 
			[Factures:86]FAC_Periode_Du:51:=Date:C102("01/"+Replace string:C233($month_year; "-"; "/"))
		End if 
		
		If (outilsDernierDuMois([Factures:86]FAC_Periode_Du:51)>[Locations:84]LOC_Date_Sortie:10)
			[Factures:86]FAC_Periode_Au:52:=[Locations:84]LOC_Date_Sortie:10
		Else 
			[Factures:86]FAC_Periode_Au:52:=outilsDernierDuMois([Factures:86]FAC_Periode_Du:51)
		End if 
		
		[Factures:86]FAC_Mois:33:=$mois_numero
		[Factures:86]FAC_Annee:34:=Year of:C25($current_date)
		
		// Ajouté selon les spécifications du 09/09/2020
		[Factures:86]FAC_LOC_Date_Entree:58:=[Locations:84]LOC_Date_Entree:9
		[Factures:86]FAC_Caution:57:=[Locations:84]LOC_Garantie_Montant:11
		
		[Factures:86]FAC_Location_ID:39:=[Locations:84]ID:1
		
		// Modifié par: remy@connect-io.fr (06/10/2021) Et Re-Modifié par Scanu Rémy (22/07/2024)
		//$nbre_jours_du_mois:=UTL_Get_Nbre_Jous_Mois([Factures]FAC_Periode_Du)
		
		$nbre_jours_du_mois:=outilsDateGetNbDayInMonth([Factures:86]FAC_Periode_Du:51)
		
		//=========================================================//
		// Location
		//=========================================================//
		QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Mois:23=$mois_numero; *)
		QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Annee:24=$annee; *)
		QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Service_ID:4=[Locations:84]ID:1; *)
		QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Type_Ligne:26="location"; *)
		QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Statut:17#"Annulée")
		
		Case of 
			: (Records in selection:C76([Factures_Lignes:87])=0)
				CREATE RECORD:C68([Factures_Lignes:87])
				MultiSoc_Init_Structure(->[Factures_Lignes:87])
				
				[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
				[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
				[Factures_Lignes:87]FACL_Service_ID:4:=[Locations:84]ID:1
				[Factures_Lignes:87]FACL_Mois:23:=$mois_numero
				[Factures_Lignes:87]FACL_Annee:24:=$annee
				[Factures_Lignes:87]FACL_Titre:6:=[Locations:84]LOC_Titre:14
				
				[Factures_Lignes:87]FACL_Libelle:5:="Loyer"
				
				// Modifié par: remy@connect-io.fr (06/10/2021)
				[Factures_Lignes:87]FACL_Date_Du:21:=[Factures:86]FAC_Periode_Du:51
				[Factures_Lignes:87]FACL_Date_Au:22:=[Factures:86]FAC_Periode_Au:52
				
				[Factures_Lignes:87]FACL_Quantite:18:=([Factures_Lignes:87]FACL_Date_Au:22-[Factures_Lignes:87]FACL_Date_Du:21)+1
				
				[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[Locations:84]LOC_Montant_Revise:7/$nbre_jours_du_mois
				[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
				[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
				
				[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
				[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
				
				[Factures_Lignes:87]FACL_Type_Ligne:26:="location"
				
				SAVE RECORD:C53([Factures_Lignes:87])
				UNLOAD RECORD:C212([Factures_Lignes:87])
				
				//=====================================================//
				$continu_location:=True:C214
			: ($O_Output.location[$O_Output.location.length-1].notificationError=Null:C1517)
				$O_Output.location[$O_Output.location.length-1].notificationError:=String:C10(Records in selection:C76([Factures_Lignes:87]))+" enregistrement(s) dans la table [Factures_Lignes] (id = "+String:C10([Factures_Lignes:87]ID:1)+") de loyer pour la période "+$month_year+" a été trouvé dans la base de donnée"
		End case 
		
		///===================================================//
		// APL
		//=====================================================//
		
		// pour les APL on a besoin des informations du mois précédent, pour chercher les régul APL du mois précédent.
		
		QUERY:C277([LocationsAPL:111]; [LocationsAPL:111]locationID:1=[Locations:84]ID:1)
		
		QUERY SELECTION:C341([LocationsAPL:111]; [LocationsAPL:111]month:8=Month of:C24($current_date-1); *)
		QUERY SELECTION:C341([LocationsAPL:111];  & ; [LocationsAPL:111]year:7=Year of:C25($current_date-1))
		
		If (Records in selection:C76([LocationsAPL:111])>0)
			CREATE RECORD:C68([Factures_Lignes:87])
			MultiSoc_Init_Structure(->[Factures_Lignes:87])
			
			[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
			[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
			[Factures_Lignes:87]FACL_Service_ID:4:=[Locations:84]ID:1
			[Factures_Lignes:87]FACL_Mois:23:=$mois_numero
			[Factures_Lignes:87]FACL_Annee:24:=$annee
			[Factures_Lignes:87]FACL_Titre:6:="APL régularisation"
			[Factures_Lignes:87]FACL_Libelle:5:="APL régularisation"
			
			[Factures_Lignes:87]FACL_Date_Du:21:=[Factures:86]FAC_Periode_Du:51
			[Factures_Lignes:87]FACL_Date_Au:22:=[Factures:86]FAC_Periode_Au:52
			
			[Factures_Lignes:87]FACL_Quantite:18:=1
			
			[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[LocationsAPL:111]pending:6-[LocationsAPL:111]receive:3
			[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=[LocationsAPL:111]pending:6-[LocationsAPL:111]receive:3
			[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=[LocationsAPL:111]pending:6-[LocationsAPL:111]receive:3
			[Factures_Lignes:87]FACL_Montant_HT:9:=[LocationsAPL:111]pending:6-[LocationsAPL:111]receive:3
			
			[Factures_Lignes:87]FACL_Montant_TTC:12:=[LocationsAPL:111]pending:6-[LocationsAPL:111]receive:3
			[Factures_Lignes:87]FACL_Type_Ligne:26:="apl"
			
			SAVE RECORD:C53([Factures_Lignes:87])
		End if 
		
		[Factures:86]FAC_Total_APL:54:=-[Factures_Lignes:87]FACL_Montant_TTC:12
		
		
		// pour les APL on a besoin des informations du mois en cours, pour récupérer les APL du mois en cours.
		
		QUERY:C277([LocationsAPL:111]; [LocationsAPL:111]locationID:1=[Locations:84]ID:1)
		
		QUERY SELECTION:C341([LocationsAPL:111]; [LocationsAPL:111]month:8=Month of:C24($current_date); *)
		QUERY SELECTION:C341([LocationsAPL:111];  & ; [LocationsAPL:111]year:7=Year of:C25($current_date))
		
		If (Records in selection:C76([LocationsAPL:111])>0)
			CREATE RECORD:C68([Factures_Lignes:87])
			MultiSoc_Init_Structure(->[Factures_Lignes:87])
			
			[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
			[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
			[Factures_Lignes:87]FACL_Service_ID:4:=[Locations:84]ID:1
			[Factures_Lignes:87]FACL_Mois:23:=$mois_numero
			[Factures_Lignes:87]FACL_Annee:24:=$annee
			[Factures_Lignes:87]FACL_Titre:6:="APL"
			[Factures_Lignes:87]FACL_Libelle:5:="APL"
			
			[Factures_Lignes:87]FACL_Date_Du:21:=[Factures:86]FAC_Periode_Du:51
			[Factures_Lignes:87]FACL_Date_Au:22:=[Factures:86]FAC_Periode_Au:52
			
			[Factures_Lignes:87]FACL_Quantite:18:=1
			
			[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=-[LocationsAPL:111]pending:6
			[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=-[LocationsAPL:111]pending:6
			[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=-[LocationsAPL:111]pending:6
			[Factures_Lignes:87]FACL_Montant_HT:9:=-[LocationsAPL:111]pending:6
			
			[Factures_Lignes:87]FACL_Montant_TTC:12:=-[LocationsAPL:111]pending:6
			[Factures_Lignes:87]FACL_Type_Ligne:26:="apl"
			
			SAVE RECORD:C53([Factures_Lignes:87])
		End if 
		
		[Factures:86]FAC_Total_APL:54+=[Factures_Lignes:87]FACL_Montant_TTC:12
		
		//=========================================================//
		// Charges
		//=========================================================//
		QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Mois:23=$mois_numero; *)
		QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Annee:24=$annee; *)
		QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Service_ID:4=[Locations:84]ID:1; *)
		QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Type_Ligne:26="charge"; *)
		QUERY:C277([Factures_Lignes:87];  & ; [Factures_Lignes:87]FACL_Statut:17#"Annulée")
		
		Case of 
			: (Records in selection:C76([Factures_Lignes:87])=0)
				READ ONLY:C145([Charges:92])
				
				QUERY:C277([Charges:92]; [Charges:92]CHA_Origine_ID:6=[Locations:84]ID:1; *)
				QUERY:C277([Charges:92];  & ; [Charges:92]CHA_Libelle:3#"APL"; *)
				QUERY:C277([Charges:92];  & ; [Charges:92]CHA_Annee:10<=$annee; *)
				QUERY:C277([Charges:92];  & ; [Charges:92]CHA_Annee_Fin:13>=$annee)
				
				QUERY SELECTION:C341([Charges:92]; [Charges:92]CHA_Mois:9<=$mois_numero)
				QUERY SELECTION:C341([Charges:92]; [Charges:92]CHA_Mois_Fin:12>=$mois_numero)
				
				If ($separation_charges="true") & (Records in selection:C76([Charges:92])>0) & ($continu_location)
					// Calcul pied de la facture des locations
					QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
					MultiSoc_Filter(->[Factures_Lignes:87])
					
					[Factures:86]FAC_Type_Piece:40:="location"
					
					Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
					SAVE RECORD:C53([Factures:86])
					
					$continu_location:=False:C215
					$fac_genere_count:=$fac_genere_count+1
					
					// création de la facture des charges
					DUPLICATE RECORD:C225([Factures:86])
					
					[Factures:86]FAC_No_Piece:2:=""
					[Factures:86]FAC_Statut:16:=""
					[Factures:86]FAC_Type_Piece:40:="charge"
					[Factures:86]FAC_Caution:57:=0
					[Factures:86]FAC_Loyer_Residuel:56:=0
				End if 
				
				CLEAR VARIABLE:C89($total_charges)
				$continu_charge:=(Records in selection:C76([Charges:92])>0)
				
				While (Not:C34(End selection:C36([Charges:92])))
					CREATE RECORD:C68([Factures_Lignes:87])
					MultiSoc_Init_Structure(->[Factures_Lignes:87])
					
					[Factures_Lignes:87]FACL_Piece_ID:3:=[Factures:86]ID:1
					[Factures_Lignes:87]FACL_Origine_Table_No:20:=Table:C252(->[Factures:86])
					[Factures_Lignes:87]FACL_Service_ID:4:=[Locations:84]ID:1
					[Factures_Lignes:87]FACL_Mois:23:=$mois_numero
					[Factures_Lignes:87]FACL_Annee:24:=$annee
					[Factures_Lignes:87]FACL_Titre:6:=[Charges:92]CHA_Libelle:3
					[Factures_Lignes:87]FACL_Libelle:5:=[Charges:92]CHA_Libelle:3
					
					[Factures_Lignes:87]FACL_Date_Du:21:=[Factures:86]FAC_Periode_Du:51
					[Factures_Lignes:87]FACL_Date_Au:22:=[Factures:86]FAC_Periode_Au:52
					
					// Modifié par : Scanu Rémy (22/02/2024)
					[Factures_Lignes:87]FACL_Quantite:18:=([Factures_Lignes:87]FACL_Date_Au:22-[Factures_Lignes:87]FACL_Date_Du:21)+1
					
					[Factures_Lignes:87]FACL_Prix_Unit_HT:8:=[Charges:92]CHA_Montant:5/$nbre_jours_du_mois
					
					[Factures_Lignes:87]FACL_Prix_Unit_Net:15:=([Factures_Lignes:87]FACL_Prix_Unit_HT:8-([Factures_Lignes:87]FACL_Prix_Unit_HT:8*([Factures_Lignes:87]FACL_Remise_Taux:13/100)))
					[Factures_Lignes:87]FACL_Montant_HT:9:=[Factures_Lignes:87]FACL_Quantite:18*[Factures_Lignes:87]FACL_Prix_Unit_Net:15
					
					[Factures_Lignes:87]FACL_Prix_Unit_TTC:16:=([Factures_Lignes:87]FACL_Prix_Unit_Net:15*((100+[Factures_Lignes:87]FACL_Taux_TVA:10)/100))
					[Factures_Lignes:87]FACL_Montant_TTC:12:=([Factures_Lignes:87]FACL_Montant_HT:9+[Factures_Lignes:87]FACL_Montant_TVA:11)
					
					[Factures_Lignes:87]FACL_Type_Ligne:26:="charge"
					$total_charges:=$total_charges+[Factures_Lignes:87]FACL_Montant_TTC:12
					
					SAVE RECORD:C53([Factures_Lignes:87])
					UNLOAD RECORD:C212([Factures_Lignes:87])
					
					NEXT RECORD:C51([Charges:92])
				End while 
				
				[Factures:86]FAC_Total_Charges:53:=$total_charges
				[Factures:86]FAC_Total_Charges_APL:55:=$total_charges+[Factures:86]FAC_Total_APL:54
			: ($O_Output.location[$O_Output.location.length-1].notificationError=Null:C1517)
				SELECTION TO ARRAY:C260([Factures_Lignes:87]ID:1; $factureLigne_ai)
				$O_Output.location[$O_Output.location.length-1].notificationError:=String:C10(Records in selection:C76([Factures_Lignes:87]))+" enregistrement(s) dans la table [Factures_Lignes] (id = "+JSON Stringify array:C1228($factureLigne_ai)+") de charges pour la période "+$month_year+" ont été trouvés dans la base de donnée"
		End case 
		
		//=========================================================//
		// Pied 
		//=========================================================//
		If (($continu_location=True:C214) | ($continu_charge=True:C214)) & ($O_Output.location[$O_Output.location.length-1].notificationError=Null:C1517)
			
			Case of 
				: (($continu_location=True:C214) & ($continu_charge=False:C215))
					[Factures:86]FAC_Type_Piece:40:="location"
				: (($continu_location=False:C215) & ($continu_charge=True:C214))
					[Factures:86]FAC_Type_Piece:40:="charge"
				Else 
					[Factures:86]FAC_Type_Piece:40:="mixte"
			End case 
			
			QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
			MultiSoc_Filter(->[Factures_Lignes:87])
			
			Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
			
			// Modifié par : Scanu Rémy (29/07/2021)
			outilsManageFacture(1)
			SAVE RECORD:C53([Factures:86])
			
			$fac_genere_count:=$fac_genere_count+1
			$status:="Success"
		End if 
		
		// Modifié par : Scanu Rémy (05/04/2023)
		// Si pas d'erreur, on valide la transaction de la création de la [Factures] et des [Factures_Lignes]
		If ($O_Output.location[$O_Output.location.length-1].notificationError=Null:C1517)
			VALIDATE TRANSACTION:C240
		Else 
			CANCEL TRANSACTION:C241
		End if 
		
	Else 
		$O_Output.location[$O_Output.location.length-1].notificationError:="La période de location est en dehors de la période sélectionnée"
	End if 
	
	outilsCleanVariable(->$continu_charge; ->$continu_location; ->$factureLigne_ai)
	NEXT RECORD:C51([Locations:84])
End while 

OB SET:C1220($O_Output; "Status"; $fac_genere_count)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)