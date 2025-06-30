//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 26-12-18, 10:19:16
// ----------------------------------------------------
// Method: Web_Save_Piece_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $0 : Integer
var $1 : Pointer
var $2 : Pointer
var $3 : Pointer
var $4 : Pointer
var $5 : Text
var $6 : Boolean

var $libelle; $Status; $month_year : Text
var $id; $id_piece; $id_table_origine; $mois_numero; $annee : Integer
var $montantTTCLigneAvantModif_r : Real
var $continu; $adresse_gere : Boolean
var $current_date : Date
var $table_piece; $table_ligne; $champ_origin; $champ_origin_table : Pointer
var $O_Output; $O_Data : Object

var champRef_p : Pointer

ARRAY TEXT:C222($tb_restricted; 0)

$table_piece:=$1
$table_ligne:=$2
$champ_origin:=$3
$champ_origin_table:=$4
$libelle:=$5
$adresse_gere:=$6

$O_Output:=New object:C1471
$continu:=True:C214
$id_table_origine:=Table:C252($table_piece)

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id_ligne"; Est un texte:K8:3))
$id_piece:=Num:C11(OB Get:C1224($O_Data; "id_piece"; Est un texte:K8:3))

EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table_ligne)+"]id")
READ WRITE:C146($table_ligne->)

If ($id#0)
	QUERY:C277($table_ligne->; champRef_p->=$id)
	
	If (Records in selection:C76($table_ligne->)=1)
		
		If (Locked:C147($table_ligne->))
			$continu:=False:C215
		End if 
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	CREATE RECORD:C68($table_ligne->)
	MultiSoc_Init_Structure($table_ligne)
	
	$id:=champRef_p->
	$champ_origin->:=$id_piece
	
	If ($champ_origin_table#Null:C1517)
		$champ_origin_table->:=$id_table_origine
	End if 
	
End if 

If ($continu)
	APPEND TO ARRAY:C911($tb_restricted; "id")
	
	If ($table_ligne=->[Factures_Lignes:87])
		READ WRITE:C146([Factures:86])
		
		QUERY:C277([Factures:86]; [Factures:86]ID:1=$id_piece)
		$montantTTCLigneAvantModif_r:=[Factures_Lignes:87]FACL_Montant_TTC:12
	End if 
	
	Web_AGL_Json_To_Record($table_ligne; ->$O_Data; ->$tb_restricted)
	SAVE RECORD:C53($table_ligne->)
	
	Case of 
		: ($table_ligne=->[Factures_Lignes:87])
			// Modifié par : Scanu Rémy (28/08/2024)
			// Il faut mettre à jour le solde du de la facture sur laquelle on ajoute et/ou modifie la ligne de la facture
			If ([Factures:86]FAC_Type_Piece:40="location") | ([Factures:86]FAC_Type_Piece:40="mixte")  // Mise à jour des factures suivantes
				outilsManageFacture(4; True:C214; $montantTTCLigneAvantModif_r)
			Else 
				outilsManageFacture(4; False:C215; $montantTTCLigneAvantModif_r)
			End if 
			
			QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Piece_ID:3=[Factures:86]ID:1)
			MultiSoc_Filter(->[Factures_Lignes:87])
			
			Web_Piece_Calcul_Pied_2(->[Factures:86]; ->[Factures_Lignes:87]; ->[Factures_Lignes:87]FACL_Piece_ID:3; "facture")
			SAVE RECORD:C53([Factures:86])
		: ($table_ligne=->[Inventaire_Pieces:96])
			Web_GL_Save_Inventaire([Inventaire_Pieces:96]ID:1)
		: ($table_ligne=->[Intervention_Lignes:109])
			//-----------------------------------------------------//
			// Mise à jour du stock
			//-----------------------------------------------------//
			
			If ([Intervention_Lignes:109]INTL_EQU_ID:4>0)
				
				If ([Intervention_Lignes:109]INTL_Operation:12="Changement")
					QUERY:C277([Intervention:108]; [Intervention:108]ID:1=[Intervention_Lignes:109]INTL_Piece_ID:3)
					MultiSoc_Filter(->[Intervention:108])
					
					STK_Stock_MAJ([Intervention_Lignes:109]ID:1; [Intervention_Lignes:109]INTL_EQU_ID:4; [Intervention_Lignes:109]INTL_Piece_ID:3; "sortie"; 1; True:C214; "Changement de l'équipement"; [Intervention:108]INT_LC_Nom:17; "L'intervention numéro "+[Intervention:108]INT_Numero:13+" du "+String:C10([Intervention:108]INT_Date_debut:5); ->[Intervention_Lignes:109])
				End if 
				
			End if 
			
		: ($table_piece=->[Intervention:108]) & ($table_ligne=->[Base_documentaire:90])
		: ($table_ligne=->[Charges:92])
			$month_year:=OB Get:C1224($O_Data; "cha_periode"; Est un texte:K8:3)
			$current_date:=Date:C102(String:C10("01")+"/"+$month_year)
			$mois_numero:=Month of:C24($current_date)
			$annee:=Year of:C25($current_date)
			
			[Charges:92]CHA_Mois:9:=$mois_numero
			[Charges:92]CHA_Annee:10:=$annee
			
			// Modifié par: Scanu Rémy - remy@connect-io.fr (17/02/2021)
			$month_year:=OB Get:C1224($O_Data; "cha_periode_fin"; Est un texte:K8:3)
			$current_date:=Date:C102(String:C10("01")+"/"+$month_year)
			$mois_numero:=Month of:C24($current_date)
			$annee:=Year of:C25($current_date)
			
			[Charges:92]CHA_Mois_Fin:12:=$mois_numero
			[Charges:92]CHA_Annee_Fin:13:=$annee
			SAVE RECORD:C53([Charges:92])
	End case 
	
	If ($adresse_gere)
		READ WRITE:C146([Adresses:53])
		
		QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=$id; *)
		QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=$id_table_origine)
		
		Case of 
			: (Records in selection:C76([Adresses:53])=1)
				
				If (Locked:C147([Adresses:53]))
					$continu:=False:C215
				End if 
				
			: (Records in selection:C76([Adresses:53])=0)
				CREATE RECORD:C68([Adresses:53])
				MultiSoc_Init_Structure(->[Adresses:53])
				
				[Adresses:53]AD_ID_Origine:34:=$id
				[Adresses:53]AD_ID_Table_Origine:35:=$id_table_origine
			Else 
				$continu:=False:C215
		End case 
		
		If ($continu)
			$O_Data:=OB Get:C1224($O_Data; "adresse"; Est un objet:K8:27)
			$O_Data:=OB Get:C1224($O_Data; "data"; Est un objet:K8:27)
			
			Web_AGL_Json_To_Record(->[Adresses:53]; ->$O_Data; ->$tb_restricted)
			SAVE RECORD:C53([Adresses:53])
		End if 
		
	End if 
	
	$status:="success"
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "status"; $status)
OB SET:C1220($O_Output; "id"; String:C10($id))

$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)