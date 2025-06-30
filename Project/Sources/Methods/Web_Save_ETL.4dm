//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 01-05-19, 08:33:10
// ----------------------------------------------------
// Method: Web_Save_ETL
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($table_ligne; $champ_origin)
C_TEXT:C284($Status)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu; $diversement)
C_LONGINT:C283($id; $id_piece)
C_LONGINT:C283($0)

$O_Output:=New object:C1471
$continu:=True:C214
$table_ligne:=->[ETL_Lignes:101]
$champ_origin:=->[ETL_Lignes:101]ELI_ETL_ID:2
$diversement:=False:C215

ARRAY TEXT:C222($tb_restricted; 0)
APPEND TO ARRAY:C911($tb_restricted; "id")

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "ligne"; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id_ligne"; Est un texte:K8:3))

$id_piece:=Num:C11(OB Get:C1224($O_Data; "id_piece"; Est un texte:K8:3))

//ETL ENTETE
$etl_id_location:=Num:C11(OB Get:C1224($O_Data; "etl_id_location"; Est un texte:K8:3))
$etl_type:=OB Get:C1224($O_Data; "etl_type"; Est un texte:K8:3)
$etl_date:=Date:C102(OB Get:C1224($O_Data; "etl_date"; Est un texte:K8:3))

//ETL LIGNES
$ipl_id:=Num:C11(OB Get:C1224($O_Data; "ipl_id"; Est un texte:K8:3))

READ ONLY:C145([Locations:84])
READ ONLY:C145([Inventaire_Pieces:96])
READ ONLY:C145([LesCentres:9])

QUERY:C277([Locations:84]; [Locations:84]ID:1=$etl_id_location)
QUERY:C277([Inventaire_Pieces:96]; [Inventaire_Pieces:96]INV_ID_Bien:18=[Locations:84]LOC_Bien_ID:5)
MultiSoc_Init_Structure(->[Inventaire_Pieces:96])
QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=[Locations:84]LOC_Bien_ID:5)
MultiSoc_Init_Structure(->[LesCentres:9])

READ WRITE:C146([Etat_des_lieux:97])
READ WRITE:C146([ETL_Lignes:101])


Case of 
	: ($etl_type="Entrée")
		
		QUERY:C277([Etat_des_lieux:97]; [Etat_des_lieux:97]ETL_ID_Location:9=$etl_id_location; *)
		QUERY:C277([Etat_des_lieux:97];  & ; [Etat_des_lieux:97]ETL_Type:2="Entrée")
		
	: ($etl_type="Sortie")
		
		QUERY:C277([Etat_des_lieux:97]; [Etat_des_lieux:97]ETL_ID_Location:9=$etl_id_location; *)
		QUERY:C277([Etat_des_lieux:97];  & ; [Etat_des_lieux:97]ETL_Type:2="Sortie")
		
	Else 
		$continu:=False:C215
End case 

If ($continu)
	
	//ETL PIECE
	
	Case of 
		: (Records in selection:C76([Etat_des_lieux:97])=0)
			
			CREATE RECORD:C68([Etat_des_lieux:97])
			Web_AGL_Json_To_Record(->[Etat_des_lieux:97]; ->$O_Data; ->$tb_restricted)
			MultiSoc_Init_Structure(->[Etat_des_lieux:97])
			[Etat_des_lieux:97]ETL_ID_Location:9:=$etl_id_location
			[Etat_des_lieux:97]ETL_Date:3:=$etl_date
			[Etat_des_lieux:97]ETL_Type:2:=$etl_type
			[Etat_des_lieux:97]CHA_Origine_Table_No:11:=Table:C252(->[Locations:84])
			[Etat_des_lieux:97]ETL_Bien_Type:27:=[Inventaire_Pieces:96]INV_Type:6
			[Etat_des_lieux:97]ETL_Surface:28:=[Inventaire_Pieces:96]INV_Surface:5
			[Etat_des_lieux:97]ETL_Pieces_Principales:29:=[Inventaire_Pieces:96]INV_Pieces_Principales:7
			[Etat_des_lieux:97]ETL_Bien_Adresse:30:=[LesCentres:9]LC_Adr1:24+" "+[LesCentres:9]LC_Adr2:25+" "+[LesCentres:9]LC_Adr3:26+[LesCentres:9]LC_Ville:28
			[Etat_des_lieux:97]ETL_Bailleur_Nom:31:=[Locations:84]LOC_Usager_Prenom_Nom:16
			[Etat_des_lieux:97]ETL_Bailleur_Adresse:32:=""
			[Etat_des_lieux:97]ETL_Ville_Signature:40:=[LesCentres:9]LC_Ville:28
			SAVE RECORD:C53([Etat_des_lieux:97])
			
			
			$id_piece:=[Etat_des_lieux:97]ID:1
			
		: (Records in selection:C76([Etat_des_lieux:97])=1)
			
			Web_AGL_Json_To_Record(->[Etat_des_lieux:97]; ->$O_Data; ->$tb_restricted)
			[Etat_des_lieux:97]ETL_Bien_Type:27:=[Inventaire_Pieces:96]INV_Type:6
			[Etat_des_lieux:97]ETL_Surface:28:=[Inventaire_Pieces:96]INV_Surface:5
			[Etat_des_lieux:97]ETL_Pieces_Principales:29:=[Inventaire_Pieces:96]INV_Pieces_Principales:7
			[Etat_des_lieux:97]ETL_Bien_Adresse:30:=[LesCentres:9]LC_Adr1:24+" "+[LesCentres:9]LC_Adr2:25+" "+[LesCentres:9]LC_Adr3:26+[LesCentres:9]LC_Ville:28
			[Etat_des_lieux:97]ETL_Bailleur_Nom:31:=[Locations:84]LOC_Usager_Prenom_Nom:16
			[Etat_des_lieux:97]ETL_Bailleur_Adresse:32:=""
			[Etat_des_lieux:97]ETL_Ville_Signature:40:=[LesCentres:9]LC_Ville:28
			SAVE RECORD:C53([Etat_des_lieux:97])
			$id_piece:=[Etat_des_lieux:97]ID:1
			
			//If (Locked([Etat_des_lieux]))
			//$continu:=False
			//End if 
			
		Else 
			$continu:=False:C215
	End case 
	
	
	//ETL LIGNES
	
	If ($continu)
		
		
		QUERY:C277([ETL_Lignes:101]; [ETL_Lignes:101]ELI_ETL_ID:2=[Etat_des_lieux:97]ID:1; *)
		QUERY:C277([ETL_Lignes:101];  & ; [ETL_Lignes:101]ELI_IPL_ID:3=$ipl_id)
		
		Case of 
			: (Records in selection:C76([ETL_Lignes:101])=0)
				
				CREATE RECORD:C68([ETL_Lignes:101])
				MultiSoc_Init_Structure(->[ETL_Lignes:101])
				$champ_origin->:=$id_piece
				[ETL_Lignes:101]ELI_IPL_ID:3:=Num:C11(OB Get:C1224($O_Data; "ipl_id"; Est un texte:K8:3))
				
			: (Records in selection:C76([ETL_Lignes:101])=1)
				
				If (Locked:C147($table_ligne->))
					$continu:=False:C215
				End if 
				
			Else 
				$continu:=False:C215
		End case 
		
	End if 
	
End if 

If ($continu)
	
	Web_AGL_Json_To_Record($table_ligne; ->$O_Data; ->$tb_restricted)
	
	SAVE RECORD:C53($table_ligne->)
	UNLOAD RECORD:C212($table_ligne->)
	
	$status:="success"
	
Else 
	$status:="Failed"
End if 

UNLOAD RECORD:C212([Etat_des_lieux:97])
UNLOAD RECORD:C212([ETL_Lignes:101])

READ ONLY:C145([Etat_des_lieux:97])
READ ONLY:C145([ETL_Lignes:101])

//OB SET($O_Output;"status";$status;"id";String($id))
OB SET:C1220($O_Output; "status"; $status)
OB SET:C1220($O_Output; "id"; String:C10($id))
$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)