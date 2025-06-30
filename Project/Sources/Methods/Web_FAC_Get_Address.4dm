//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 21-02-19, 15:27:31
// ----------------------------------------------------
// Method: Web_FAC_Get_Address
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($1; $id_bien; $2; $id_locataire; $id)
C_TEXT:C284($0; $result)
C_POINTER:C301($table_origine)

$id_bien:=$1
$id_locataire:=$2
$result:=""

QUERY:C277([LesCentres:9]; [LesCentres:9]ID:60=$id_bien)
MultiSoc_Filter(->[LesCentres:9])
QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=$id_locataire)
MultiSoc_Filter(->[HeBerge:4])

If (Records in selection:C76([HeBerge:4])=1)
	
	Case of 
		: ([HeBerge:4]HB_FAC_Destation:72="Propriétaire")
			$table_origine:=->[Proprietaires:83]
			$id:=[LesCentres:9]LC_GL_Proprietaire_ID:66
			
		: ([HeBerge:4]HB_FAC_Destation:72="Locataire")
			$table_origine:=->[HeBerge:4]
			$id:=[HeBerge:4]HB_ReferenceID:1  //[Locations]LOC_HB_ID
			
		Else 
			$table_origine:=->[LesCentres:9]
			$id:=[LesCentres:9]ID:60
	End case 
	
	
End if 

If ($id#0)
	
	QUERY:C277([Adresses:53]; [Adresses:53]AD_ID_Origine:34=$id; *)
	QUERY:C277([Adresses:53];  & ; [Adresses:53]AD_ID_Table_Origine:35=Table:C252($table_origine))
	
	If (Records in selection:C76([Adresses:53])=1)
		$result:=[Adresses:53]AD_Adresse1:16+" "+[Adresses:53]AD_Adresse2:17+" "+[Adresses:53]AD_Adresse3:18+" "+[Adresses:53]AD_Code_postal:19+" "+[Adresses:53]AD_Ville:20
	End if 
	
End if 

$0:=$result