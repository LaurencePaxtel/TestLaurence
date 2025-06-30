//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 08/12/18, 20:55:46
// ----------------------------------------------------
// Méthode : Web_GL_Set_Proprietaire
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($1; $type; $Status)
C_OBJECT:C1216($O_Output; $O_Data; $O_Data_addresse; $O_Data_Banque)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id; $id_table_origine)

$type:=$1
$O_Output:=New object:C1471
$continu:=True:C214
$id_table_origine:=Table:C252(->[Proprietaires:83])

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "proprietaire"; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

READ WRITE:C146([Proprietaires:83])
READ WRITE:C146([Adresses:53])
READ WRITE:C146([Banques:91])

If ($id#0)
	
	QUERY:C277([Proprietaires:83]; [Proprietaires:83]ID:1=$id)
	
	If (Records in selection:C76([Proprietaires:83])=1)
		If (Locked:C147([Proprietaires:83]))
			$continu:=False:C215
		End if 
	Else 
		$continu:=False:C215
	End if 
	
Else 
	CREATE RECORD:C68([Proprietaires:83])
	MultiSoc_Init_Structure(->[Proprietaires:83])
	$id:=[Proprietaires:83]ID:1
End if 

If ($continu)
	
	ARRAY TEXT:C222($tb_restricted; 0)
	APPEND TO ARRAY:C911($tb_restricted; "id")
	
	Web_AGL_Json_To_Record(->[Proprietaires:83]; ->$O_Data; ->$tb_restricted)
	
	[Proprietaires:83]PRO_Nom:2:=Uppercase:C13([Proprietaires:83]PRO_Nom:2)
	[Proprietaires:83]PRO_Prenom:3:=Uppercase:C13([Proprietaires:83]PRO_Prenom:3)
	
	//==============================================================================//
	// ADRESSE
	//==============================================================================//
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
		$O_Data_addresse:=OB Get:C1224($O_Data; "adresse"; Est un objet:K8:27)
		$O_Data_addresse:=OB Get:C1224($O_Data_addresse; "data"; Est un objet:K8:27)
		Web_AGL_Json_To_Record(->[Adresses:53]; ->$O_Data_addresse; ->$tb_restricted)
	End if 
	
	//==============================================================================//
	// COORDONNEES BANCAIRES
	//==============================================================================//
	
	QUERY:C277([Banques:91]; [Banques:91]BQE_Origine_ID:17=$id; *)
	QUERY:C277([Banques:91];  & ; [Banques:91]BQE_Origine_No_Table:18=$id_table_origine)
	
	Case of 
		: (Records in selection:C76([Banques:91])=1)
			
			If (Locked:C147([Banques:91]))
				$continu:=False:C215
			End if 
			
		: (Records in selection:C76([Banques:91])=0)
			
			CREATE RECORD:C68([Banques:91])
			MultiSoc_Init_Structure(->[Banques:91])
			[Banques:91]BQE_Origine_ID:17:=$id
			[Banques:91]BQE_Origine_No_Table:18:=$id_table_origine
			
		Else 
			$continu:=False:C215
	End case 
	
	If ($continu)
		$O_Data_Banque:=OB Get:C1224($O_Data; "coordonnees_bancaires"; Est un objet:K8:27)
		$O_Data_Banque:=OB Get:C1224($O_Data_Banque; "data"; Est un objet:K8:27)
		Web_AGL_Json_To_Record(->[Banques:91]; ->$O_Data_Banque; ->$tb_restricted)
	End if 
	
	If ($continu)
		SAVE RECORD:C53([Proprietaires:83])
		SAVE RECORD:C53([Adresses:53])
		SAVE RECORD:C53([Banques:91])
		$status:="Success"
	Else 
		$status:="Failed"
	End if 
	
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)