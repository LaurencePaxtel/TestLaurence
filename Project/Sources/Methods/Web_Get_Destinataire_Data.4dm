//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 04-02-19, 07:31:01
// ----------------------------------------------------
// Method: Web_Get_Destinataire_Data
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($data_label; $type_destinataire)
C_LONGINT:C283($id)
C_BOOLEAN:C305($continu)
C_POINTER:C301($table)
C_OBJECT:C1216($O_Output; $O_Data)

var champID_p : Pointer

ARRAY OBJECT:C1221($tb_result; 0)

$data_label:=$1
$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $data_label; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))
$type_destinataire:=OB Get:C1224($O_Data; "type_destinataire"; Est un texte:K8:3)

Case of 
	: ($type_destinataire="proprietaire")
		$table:=->[Proprietaires:83]
	: ($type_destinataire="locataire")
		$table:=->[HeBerge:4]
	: ($type_destinataire="centre")
		$table:=->[LesCentres:9]
	Else   //ERROR
		$continu:=False:C215
End case 

If ($continu)
	READ ONLY:C145($table->)
	
	If ($id#0)
		EXECUTE FORMULA:C63("champID_p:=->["+Table name:C256($table)+"]id")
		QUERY:C277($table->; champID_p->=$id)
		
		SET DATABASE PARAMETER:C642(Dates dans les objets:K37:73; Type chaine sans fuseau horaire:K37:86)
		$size:=Records in selection:C76($table->)
		
		ARRAY OBJECT:C1221($tb_result; $size)
		$i:=1
		
		While (Not:C34(End selection:C36($table->)))
			
			Case of 
				: ($type_destinataire="proprietaire")
					QUERY:C277([Banques:91]; [Banques:91]BQE_Origine_ID:17=[Proprietaires:83]ID:1; *)
					QUERY:C277([Banques:91];  & ; [Banques:91]BQE_Origine_No_Table:18=Table:C252(->[Proprietaires:83]))
				: ($type_destinataire="locataire")
					QUERY:C277([Banques:91]; [Banques:91]BQE_Origine_ID:17=[HeBerge:4]ID:65; *)
					QUERY:C277([Banques:91];  & ; [Banques:91]BQE_Origine_No_Table:18=Table:C252(->[HeBerge:4]))
				: ($type_destinataire="centre")
					QUERY:C277([Banques:91]; [Banques:91]BQE_Origine_ID:17=[LesCentres:9]ID:60; *)
					QUERY:C277([Banques:91];  & ; [Banques:91]BQE_Origine_No_Table:18=Table:C252(->[LesCentres:9]))
			End case 
			
			OB SET:C1220($tb_result{$i}; "id"; String:C10(champID_p->); "des_banque"; [Banques:91]BQE_Domiciliation:3)
			
			$i:=$i+1
			NEXT RECORD:C51($table->)
		End while 
		
	Else 
		$continu:=False:C215
	End if 
	
End if 

$JSON:=JSON Stringify array:C1228($tb_result)
WEB SEND TEXT:C677($JSON)