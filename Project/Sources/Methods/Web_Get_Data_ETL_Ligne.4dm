//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 14-05-19, 06:17:42
// ----------------------------------------------------
// Method: Web_Get_Data_ETL_Ligne
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_TEXT:C284($data_label; $T_JSON; $libelle_id; $etl_type)
C_LONGINT:C283($etl_id; $ipl_id)
C_BOOLEAN:C305($continu)
C_POINTER:C301($table)
C_OBJECT:C1216($O_Output; $O_Data)


$table:=$1
$data_label:=$2

$O_Output:=New object:C1471
$continu:=True:C214
$libelle_id:="id"

If (Count parameters:C259>2)
	$libelle_id:=$3
End if 

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$etl_id:=Num:C11(OB Get:C1224($O_Data; "etl_id"; Est un texte:K8:3))
$ipl_id:=Num:C11(OB Get:C1224($O_Data; "ipl_id"; Est un texte:K8:3))

$etl_type:=OB Get:C1224($O_Data; "etl_type"; Est un texte:K8:3)

READ ONLY:C145($table->)
READ ONLY:C145([Etat_des_lieux:97])

If ($etl_id#0) & ($ipl_id#0)
	
	If ($etl_type="")
		QUERY:C277([ETL_Lignes:101]; [ETL_Lignes:101]ELI_ETL_ID:2=$etl_id; *)
		QUERY:C277([ETL_Lignes:101];  & ; [ETL_Lignes:101]ELI_IPL_ID:3=$ipl_id)
	Else 
		QUERY:C277([Etat_des_lieux:97]; [Etat_des_lieux:97]ETL_ID_Location:9=$etl_id; *)
		QUERY:C277([Etat_des_lieux:97];  & ; [Etat_des_lieux:97]ETL_Type:2=$etl_type)
		
		QUERY:C277([ETL_Lignes:101]; [ETL_Lignes:101]ELI_ETL_ID:2=[Etat_des_lieux:97]ID:1; *)
		QUERY:C277([ETL_Lignes:101];  & ; [ETL_Lignes:101]ELI_IPL_ID:3=$ipl_id)
	End if 
	
	If (Records in selection:C76($table->)=1)
		SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
		$T_JSON:=Selection to JSON:C1234($table->; SelectionJson_template($table))
	Else 
		$continu:=False:C215
	End if 
	
Else 
	$continu:=False:C215
End if 

WEB SEND TEXT:C677($T_Json)