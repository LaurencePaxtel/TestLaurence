//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 14-12-18, 16:44:23
// ----------------------------------------------------
// Method: Web_GL_Set_Heberge
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($type; $Status; $hb_cle; $hb_nom; $hb_prenom)
C_LONGINT:C283($id; $id_table_origine)
C_BOOLEAN:C305($continu)
C_DATE:C307($hb_datenele)
C_OBJECT:C1216($O_Output; $O_Data; $O_Data_addresse; $O_Data_Banque)

ARRAY TEXT:C222($tb_restricted; 0)

$type:=$1
$O_Output:=New object:C1471
$continu:=True:C214
$id_table_origine:=Table:C252(->[HeBerge:4])

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; "heberge"; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "hg_hb_id"; Est un texte:K8:3))

READ WRITE:C146([HeBerge:4])
READ WRITE:C146([Adresses:53])
READ WRITE:C146([Banques:91])

If ($id#0)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$id)
	MultiSoc_Filter(->[HeBerge:4])
	
	If (Records in selection:C76([HeBerge:4])=1)
		
		If (Locked:C147([HeBerge:4]))
			$continu:=False:C215
		End if 
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	$hb_nom:=Uppercase:C13(OB Get:C1224($O_Data; "hb_nom"; Est un texte:K8:3))
	$hb_prenom:=Uppercase:C13(OB Get:C1224($O_Data; "hb_prenom"; Est un texte:K8:3))
	$hb_datenele:=Date:C102(OB Get:C1224($O_Data; "hb_datenele"; Est un texte:K8:3))
	
	$hb_cle:=Uut_HébergéClé(->$hb_nom; ->$hb_prenom; ->$hb_datenele)
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$hb_cle)
	
	If (Records in selection:C76([HeBerge:4])=0)
		CREATE RECORD:C68([HeBerge:4])
		MultiSoc_Init_Structure(->[HeBerge:4])
		
		[HeBerge:4]HB_ReferenceID:1:=[HeberGement:5]HG_HB_ID:19
		[HeBerge:4]HB_Clé:2:=Uut_HébergéClé(->$hb_nom; ->$hb_prenom; ->$hb_datenele)
		[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
		[HeBerge:4]HB_FicheCrééele:46:=Current date:C33(*)
	Else 
		$continu:=False:C215
	End if 
	
End if 

If ($continu)
	APPEND TO ARRAY:C911($tb_restricted; "id")
	APPEND TO ARRAY:C911($tb_restricted; "hg_hb_id")
	
	Web_AGL_Json_To_Record(->[HeBerge:4]; ->$O_Data; ->$tb_restricted)
	
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
	
	If ([HeBerge:4]HB_Type_Locataire:70="locataire")
		[HeBerge:4]HB_Locataire:71:=True:C214
	End if 
	
	If ($continu)
		SAVE RECORD:C53([HeBerge:4])
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