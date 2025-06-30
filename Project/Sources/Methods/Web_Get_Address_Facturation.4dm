//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 22-12-18, 08:21:47
// ----------------------------------------------------
// Method: Web_Get_Address_Facturation
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_POINTER:C301($table; $1; $id_origine; $2; $id_table_origine; $3; $table_origine)
C_TEXT:C284($data_label; $4; $T_JSON)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id; $id_bien; $id_locataire)

$table:=$1
$id_origine:=$2
$id_table_origine:=$3
$data_label:=$4

$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$id_bien:=Num:C11(OB Get:C1224($O_Data; "id_bien"; Est un texte:K8:3))
$id_locataire:=Num:C11(OB Get:C1224($O_Data; "id_locataire"; Est un texte:K8:3))

READ ONLY:C145($table->)

READ ONLY:C145([HeBerge:4])
QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=$id_locataire)

If (Records in selection:C76([HeBerge:4])=1)
	
	Case of 
		: ([HeBerge:4]HB_FAC_Destation:72="Propriétaire")
			$table_origine:=->[Proprietaires:83]
			QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=$id_bien)
			$id:=[LesCentres:9]LC_GL_Proprietaire_ID:66
			
		: ([HeBerge:4]HB_FAC_Destation:72="Locataire")
			$table_origine:=->[HeBerge:4]
			$id:=$id_locataire
			
		Else 
			$table_origine:=->[LesCentres:9]
			$id:=$id_bien
	End case 
	
	
End if 

If ($id#0)
	
	QUERY:C277($table->; $id_origine->=$id; *)
	QUERY:C277($table->;  & ; $id_table_origine->=Table:C252($table_origine))
	
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