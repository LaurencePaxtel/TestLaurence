//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 02/01/20, 14:27:15
// ----------------------------------------------------
// Method: FAC_Get_Records
// Description
// Mode de facturations : Prestations
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284(txt_filtre_nom; txt_filtre_usager; txt_filtre_designation; txt_filtre_financeur)
C_LONGINT:C283($i; $compteur_fiches)
C_BOOLEAN:C305(var_bool_facture; var_bool_regle; Chk_facture; $continu_hg_fac)
C_DATE:C307(txt_filtre_date1; txt_filtre_date2; txt_filtre_pe_du; txt_filtre_pe_au)

C_OBJECT:C1216($table_o; $autreTable_o)

ARRAY TEXT:C222(tb_cle; 0)
ARRAY LONGINT:C221(tb_hg_reference_id; 0)
ARRAY TEXT:C222(tb_etat_civil; 0)
ARRAY DATE:C224(tb_date; 0)
ARRAY TEXT:C222(tb_designation; 0)
ARRAY BOOLEAN:C223(tb_facture_bool; 0)
ARRAY TEXT:C222(tb_facture_num; 0)
ARRAY LONGINT:C221(tb_id; 0)
ARRAY LONGINT:C221(tb_hb_reference_id; 0)
ARRAY LONGINT:C221(tb_centre_id; 0)
ARRAY TEXT:C222(tb_liste_financeur; 0)
ARRAY BOOLEAN:C223(tb_liste_choix; 0)

READ ONLY:C145([HeberGement:5])
READ ONLY:C145([Factures:86])
READ ONLY:C145([Factures_Lignes:87])
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([HeBerge:4])

$compteur_fiches:=0

$progress_id:=Progress New
Progress SET TITLE($progress_id; "Recherche..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; True:C214)

QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Date:4>=txt_filtre_date1; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=txt_filtre_date2; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=False:C215; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=True:C214)

// Modifié par : Scanu Rémy - remy@connect-io.fr (07/05/2021)
// Recherche sur [HeBerge]HB_Clé pour coller à la colonne "Clé" affichée et non plus [HeberGement]HG_Nom  
//CHERCHER([HeberGement]; & ;[HeberGement]HG_Nom="@"+txt_filtre_nom+"@")
$table_o:=Create entity selection:C1512([HeberGement:5])

$autreTable_o:=$table_o.HG_HB_ID_1_HB_ReferenceID.query("HB_Clé = :1"; "@"+txt_filtre_nom+"@").HB_ReferenceID_1_HG_HB_ID
$table_o:=$table_o.and($autreTable_o)

USE ENTITY SELECTION:C1513($table_o)
LOAD RECORD:C52([HeberGement:5])

If (txt_filtre_financeur#"")
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_FamGroupe:102="@"+txt_filtre_financeur+"@")
End if 

If (Not:C34(Chk_tous))
	QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Facture:172=Chk_facture)
End if 

If (txt_filtre_designation#"")
	QUERY:C277([LesCentres:9]; [LesCentres:9]LC_Nom:4=txt_filtre_designation+"@")
	MultiSoc_Filter(->[LesCentres:9])
	
	ARRAY LONGINT:C221($tb_lc_ids; 0)
	SELECTION TO ARRAY:C260([LesCentres:9]LC_RéférenceID:1; $tb_lc_ids)
	QUERY SELECTION WITH ARRAY:C1050([HeberGement:5]HG_LC_ID:61; $tb_lc_ids)
End if 

MultiSoc_Filter(->[HeberGement:5])

$i:=0
$total_records:=Records in selection:C76([HeberGement:5])

While (Not:C34(End selection:C36([HeberGement:5])))
	$i:=$i+1
	$continu_hg_fac:=True:C214
	
	Progress SET PROGRESS($progress_id; $i/$total_records; "Recherche..."+String:C10($i)+" / "+String:C10($total_records); True:C214)
	Progress SET MESSAGE($progress_id; "Encours... "+[HeberGement:5]HG_CentreNom:62; True:C214)
	
	//***************************************************************************************************************//
	// Prise en charge
	//***************************************************************************************************************//
	If (txt_filtre_financeur#"")
		QUERY:C277([Financeurs:117]; [Financeurs:117]FIN_Code:4=txt_filtre_financeur)
		MultiSoc_Filter(->[Financeurs:117])
		
		If (Records in selection:C76([Financeurs:117])=1)
			$continu_hg_fac:=False:C215
			
			QUERY:C277([Prise_en_Charge:118]; [Prise_en_Charge:118]PE_Financeur_ID:3=[Financeurs:117]ID:1; *)
			QUERY:C277([Prise_en_Charge:118];  & ; [Prise_en_Charge:118]PE_HB_ID:4=[HeberGement:5]HG_HB_ID:19; *)
			QUERY:C277([Prise_en_Charge:118];  & ; [Prise_en_Charge:118]PE_Date_du:5<=[HeberGement:5]HG_Date:4; *)
			QUERY:C277([Prise_en_Charge:118];  & ; [Prise_en_Charge:118]PE_Date_au:6>=[HeberGement:5]HG_Date:4)
			
			MultiSoc_Filter(->[Prise_en_Charge:118])
			
			If (Records in selection:C76([Prise_en_Charge:118])>0)
				$continu_hg_fac:=True:C214
			End if 
			
		End if 
		
	End if 
	
	If ($continu_hg_fac)
		$compteur_fiches:=$compteur_fiches+1
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
		MultiSoc_Filter(->[LesCentres:9])
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
		MultiSoc_Filter(->[HeBerge:4])
		
		If (([HeBerge:4]HB_FAC_Mode_Facturation:80="Prestations") | ([HeBerge:4]HB_FAC_Mode_Facturation:80=""))
			REDUCE SELECTION:C351([Factures:86]; 0)
			REDUCE SELECTION:C351([Factures_Lignes:87]; 0)
			
			QUERY:C277([Factures_Lignes:87]; [Factures_Lignes:87]FACL_Service_Ids:30="@"+String:C10([HeberGement:5]HG_ReferenceID:1)+"@")
			MultiSoc_Filter(->[Factures_Lignes:87])
			
			If (Records in selection:C76([Factures_Lignes:87])>0)
				QUERY:C277([Factures:86]; [Factures:86]ID:1=[Factures_Lignes:87]FACL_Piece_ID:3)
				MultiSoc_Filter(->[Factures:86])
			End if 
			
			APPEND TO ARRAY:C911(tb_cle; [HeBerge:4]HB_Clé:2)  //**************************
			APPEND TO ARRAY:C911(tb_etat_civil; [HeberGement:5]HG_EtatCivil:20)
			APPEND TO ARRAY:C911(tb_date; [HeberGement:5]HG_Date:4)
			APPEND TO ARRAY:C911(tb_designation; [LesCentres:9]LC_Nom:4)  //[HeberGement]HG_CentreNom)
			APPEND TO ARRAY:C911(tb_facture_bool; [HeberGement:5]HG_Facture:172)
			APPEND TO ARRAY:C911(tb_facture_num; [Factures:86]FAC_No_Piece:2)  //**************************
			APPEND TO ARRAY:C911(tb_id; [HeberGement:5]ID:168)
			APPEND TO ARRAY:C911(tb_hg_reference_id; [HeberGement:5]HG_ReferenceID:1)
			APPEND TO ARRAY:C911(tb_hb_reference_id; [HeberGement:5]HG_HB_ID:19)  //**************************
			APPEND TO ARRAY:C911(tb_centre_id; [HeberGement:5]HG_LC_ID:61)
			APPEND TO ARRAY:C911(tb_liste_financeur; [HeberGement:5]HG_FamGroupe:102)
			APPEND TO ARRAY:C911(tb_liste_choix; False:C215)
		End if 
		
		If (Progress Stopped($progress_id))
			LAST RECORD:C200([HeberGement:5])
		End if 
		
	End if 
	
	NEXT RECORD:C51([HeberGement:5])
End while 

txt_titre_fenetre_hgl:="Liste des fiches d'hébergements : "+String:C10($compteur_fiches)

Progress QUIT($progress_id)