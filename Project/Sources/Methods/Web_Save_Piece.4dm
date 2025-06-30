//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 14:16:47
// ----------------------------------------------------
// Method: Web_Save_Piece
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer
var $2 : Text

var $libelle; $Status; $adr_proprietaire_tmp; $adr_locataire_tmp; $int_intervenants_ids : Text
var $id; $id_el : Integer
var $montant_regle : Real
var $continu : Boolean
var $table : Pointer
var $O_Output; $O_Data : Object

var $proprietaire_e : cs:C1710.ProprietairesEntity
var $heberge_e : cs:C1710.HeBergeEntity

var champRef_p : Pointer

ARRAY TEXT:C222($tb_restricted; 0)
ARRAY TEXT:C222($tab_ids_factures_regles; 0)
ARRAY TEXT:C222($tb_intervenant_ids; 0)

ARRAY LONGINT:C221($tb_ids_fac_regles; 0)

$table:=$1
$libelle:=$2

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]id")
READ WRITE:C146($table->)

If ($id#0)
	QUERY:C277($table->; champRef_p->=$id)
	
	If (Records in selection:C76($table->)=1)
		
		If (Locked:C147($table->))
			$continu:=False:C215
		End if 
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	CREATE RECORD:C68($table->)
	MultiSoc_Init_Structure($table)
	
	$id:=champRef_p->
End if 

If ($continu)
	APPEND TO ARRAY:C911($tb_restricted; "id")
	Web_AGL_Json_To_Record($table; ->$O_Data; ->$tb_restricted)
	
	Case of 
		: ($table=->[Factures:86])
			
			QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=[Factures:86]FAC_Bien_ID:28; *)
			QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252(->[LesCentres:9]))
			MultiSoc_Filter(->[Adresses:53])
			
			[Factures:86]FAC_Adresse_Proprietaire:59:=[Adresses:53]AD_Adresse1:16+" "+[Adresses:53]AD_Adresse2:17+" "+[Adresses:53]AD_Adresse3:18+" "+[Adresses:53]AD_Ville:20
			$adr_proprietaire_tmp:=Replace string:C233([Factures:86]FAC_Adresse_Proprietaire:59; " "; "")
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Factures:86]FAC_Locataire_ID:29)
			MultiSoc_Filter(->[HeBerge:4])
			
			
			QUERY:C277([Locations:84]; [Locations:84]LOC_HB_ID:3=[Factures:86]FAC_Locataire_ID:29)
			
			QUERY SELECTION:C341([Locations:84]; [Locations:84]LOC_Date_Sortie:10=!00-00-00!; *)
			QUERY SELECTION:C341([Locations:84];  | ; [Locations:84]LOC_Date_Sortie:10>=Current date:C33)
			MultiSoc_Filter(->[HeBerge:4])
			
			If (Records in selection:C76([Locations:84])#0)
				[Factures:86]FAC_Location_ID:39:=[Locations:84]ID:1
			End if 
			
			
			
			QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=[HeBerge:4]ID:65; *)
			QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252(->[HeBerge:4]))
			MultiSoc_Filter(->[Adresses:53])
			
			[Factures:86]FAC_Adresse_Locataire:60:=[Adresses:53]AD_Adresse1:16+" "+[Adresses:53]AD_Adresse2:17+" "+[Adresses:53]AD_Adresse3:18+" "+[Adresses:53]AD_Ville:20
			$adr_locataire_tmp:=Replace string:C233([Factures:86]FAC_Adresse_Locataire:60; " "; "")
			
			// Numérotation pièce : Facture définitive
			If (([Factures:86]FAC_Type:21="Définitive") & ([Factures:86]FAC_No_Piece:2=""))
				
				
				[Factures:86]FAC_No_Piece:2:="FAC/"+UTL_Numerotation_Piece(->[Factures:86]FAC_Date_Piece:3)
				[Factures:86]FAC_Cloture:10:=True:C214
				[Factures:86]FAC_Statut:16:="Clôturée"
			Else 
				[Factures:86]FAC_Statut:16:=""
			End if 
			
			If ([Factures:86]FAC_Type:21="")
				[Factures:86]FAC_Statut:16:="temp"
			End if 
			
			// Modifié par : Scanu Rémy (02/09/2021)
			outilsManageFacture(2)
			
			READ ONLY:C145([LesCentres:9])
			READ ONLY:C145([Proprietaires:83])
			
			QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Factures:86]FAC_Bien_ID:28)
			QUERY:C277([Proprietaires:83]; [Proprietaires:83]ID:1=[LesCentres:9]LC_GL_Proprietaire_ID:66)
			
			[Factures:86]FAC_Bien_Proprietaire_ID:35:=[Proprietaires:83]ID:1
			[Factures:86]FAC_Bien_Proprietaire_Nom:36:=""
			
			If ([Factures:86]FAC_Bien_Proprietaire_ID:35>0)
				[Factures:86]FAC_Bien_Proprietaire_Nom:36:=[Proprietaires:83]PRO_Nom:2+" "+[Proprietaires:83]PRO_Prenom:3
			End if 
			
			// Modifié par : Scanu Rémy (14/02/2024)
			[Factures:86]FAC_Destinataire_Nom:13:=""
			
			Case of 
				: ([Factures:86]FAC_Destinataire_Table_Origine:12=83)  // Propriétaire
					$proprietaire_e:=ds:C1482.Proprietaires.get([Factures:86]FAC_Destinataire_ID:11)
					
					If ($proprietaire_e#Null:C1517)
						[Factures:86]FAC_Destinataire_Nom:13:=$proprietaire_e.fullName()
					End if 
					
				: ([Factures:86]FAC_Destinataire_Table_Origine:12=4)  // Locataire (Hébergé)
					$heberge_e:=ds:C1482.HeBerge.get([Factures:86]FAC_Destinataire_ID:11)
					
					If ($heberge_e#Null:C1517)
						[Factures:86]FAC_Destinataire_Nom:13:=$heberge_e.fullName()
					End if 
					
			End case 
			
			// Modifié par : Scanu Rémy (05/06/2024)
			If ([Factures:86]FAC_Type_Piece:40="")
				[Factures:86]FAC_Type_Piece:40:="autre"
			End if 
			If ([Factures:86]FAC_Periode_Du:51=!00-00-00!) & ([Factures:86]FAC_Periode_Au:52=!00-00-00!)
				[Factures:86]FAC_Periode:32:=String:C10(Month of:C24([Factures:86]FAC_Date_Piece:3); "00")+"-"+String:C10(Year of:C25([Factures:86]FAC_Date_Piece:3))
				[Factures:86]FAC_Periode_Du:51:=Date:C102("01/"+String:C10(Month of:C24([Factures:86]FAC_Date_Piece:3))+"/"+String:C10(Year of:C25([Factures:86]FAC_Date_Piece:3)))
				[Factures:86]FAC_Periode_Au:52:=Add to date:C393([Factures:86]FAC_Periode_Du:51; 0; 1; -1)
				
			End if 
			
		: ($table=->[Reglements:93])
			$montant_regle:=[Reglements:93]REG_Montant:5
			
			//===============================================//
			// IMPUTATION FACTURES
			//===============================================//
			READ WRITE:C146([Factures:86])
			
			UTL_Decoupe_texte(->[Reglements:93]REG_Origine_IDS:21; ->$tab_ids_factures_regles; ";")
			outilsManageArray(1; ->$tab_ids_factures_regles; ->$tb_ids_fac_regles)
			
			QUERY WITH ARRAY:C644([Factures:86]ID:1; $tb_ids_fac_regles)
			
			If (Records in selection:C76([Factures:86])>1)
				// Modifié par : Scanu Rémy (01/07/2022)
				//TRIER([Factures]; [Factures]FAC_Annee; <; [Factures]FAC_Mois; <)
				ORDER BY:C49([Factures:86]; [Factures:86]FAC_Annee:34; >; [Factures:86]FAC_Mois:33; >)
				
				$id_el:=[Factures:86]ID:1
			End if 
			
			// Modifié par : Scanu Rémy - remy@connect-io.fr (13/10/2021)
			While (Not:C34(End selection:C36([Factures:86])))
				var $facture_e : cs:C1710.FacturesEntity
				$facture_e:=ds:C1482.Factures.get([Factures:86]ID:1)
				
				// Modifié par : remyscanu (28/08/2024)
				// On enlève la condition du solde réglé qui doit être strictement supérieur à 0
				If ($montant_regle>=$facture_e.FAC_Solde_Du_cal)  // Si le montant réglé paye tout
					
					// Modifié par : Scanu Rémy (26/09/2023)
					If (Selected record number:C246([Factures:86])<Records in selection:C76([Factures:86]))
						[Factures:86]FAC_Solde_Regle:26:=$facture_e.FAC_Net_A_Payer_cal
					Else 
						[Factures:86]FAC_Solde_Regle:26:=[Factures:86]FAC_Solde_Regle:26+$montant_regle
					End if 
					
					// Modifié par : Scanu Rémy (01/07/2022)
					If ([Factures:86]FAC_Solde_Regle:26=$facture_e.FAC_Net_A_Payer_cal)  // Facture réglée
						$montant_regle:=$montant_regle-$facture_e.FAC_Solde_Du_cal
					Else 
						$montant_regle:=$montant_regle-[Factures:86]FAC_Solde_Regle:26
					End if 
					
				Else 
					// Modifié par : Scanu Rémy - remy@connect-io.fr (14/04/2021)
					[Factures:86]FAC_Solde_Regle:26:=[Factures:86]FAC_Solde_Regle:26+$montant_regle
					CLEAR VARIABLE:C89($montant_regle)
				End if 
				
				outilsManageFacture(3)
				
				If ($facture_e.FAC_Solde_Du_cal<=0)
					[Factures:86]FAC_Statut:16:="Réglée"
				End if 
				
				SAVE RECORD:C53([Factures:86])
				
				If ($montant_regle=0)
					LAST RECORD:C200([Factures:86])
				End if 
				
				NEXT RECORD:C51([Factures:86])
			End while 
			
			//===========
			[Reglements:93]REG_No_Piece:3:="RC/"+UTL_Numerotation_Piece(->[Reglements:93]REG_Date_Piece:4)
			[Reglements:93]REG_Statut:12:=""
			
			[Reglements:93]REG_Origine_Table_No:19:=Table:C252(->[Factures:86])
		: ($table=->[Intervention:108])
			
			If ([Intervention:108]INT_Numero:13="")
				[Intervention:108]INT_Numero:13:="INT/"+UTL_Numerotation_Piece(->[Intervention:108]INT_Date_debut:5)
				[Intervention:108]INT_Statut:15:="Créee"
			End if 
			
			//=======================================//
			// Liste des intervenants 
			//=======================================//
			$int_intervenants_ids:=OB Get:C1224($O_Data; "int_intervenants_ids"; Est un texte:K8:3)
			UTL_Cut_Text(->$int_intervenants_ids; ->$tb_intervenant_ids; ",")
			
			READ WRITE:C146([GI_LK_Intervenants:112])
			
			QUERY:C277([GI_LK_Intervenants:112]; [GI_LK_Intervenants:112]GLK_Intervention_ID:3=[Intervention:108]ID:1)
			MultiSoc_Filter(->[GI_LK_Intervenants:112])
			
			DELETE SELECTION:C66([GI_LK_Intervenants:112])
			
			For ($i; 1; Size of array:C274($tb_intervenant_ids))
				QUERY:C277([GI_LK_Intervenants:112]; [GI_LK_Intervenants:112]GLK_Intervenant_ID:4=Num:C11($tb_intervenant_ids{$i}); *)
				QUERY:C277([GI_LK_Intervenants:112];  & ; [GI_LK_Intervenants:112]GLK_Intervention_ID:3=[Intervention:108]ID:1)
				
				Case of 
					: (Records in selection:C76([GI_LK_Intervenants:112])=0)
						CREATE RECORD:C68([GI_LK_Intervenants:112])
						MultiSoc_Init_Structure(->[GI_LK_Intervenants:112])
						
						[GI_LK_Intervenants:112]GLK_Intervention_ID:3:=[Intervention:108]ID:1
						[GI_LK_Intervenants:112]GLK_Intervenant_ID:4:=Num:C11($tb_intervenant_ids{$i})
						
						SAVE RECORD:C53([GI_LK_Intervenants:112])
					: (Records in selection:C76([GI_LK_Intervenants:112])=1)
					Else 
						$continu:=False:C215
				End case 
				
			End for 
			
			//=======================================//
	End case 
	
	If ($continu)
		SAVE RECORD:C53($table->)
	End if 
	
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)