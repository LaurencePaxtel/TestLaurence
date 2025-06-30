//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/03/20, 11:40:04
// ----------------------------------------------------
// Method: DOE_Get_Data
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($difference)
C_BOOLEAN:C305($utiliser_les_filtres; $continu)

C_TEXT:C284(filtre_nom_dossier; filtre_num_dossier; filtre_nom_heberge)
C_DATE:C307(filtre_date)

If (Count parameters:C259>0)
	$utiliser_les_filtres:=$1
End if 

ARRAY TEXT:C222(tb_de_cle; 0)
ARRAY TEXT:C222(tb_de_dos_nom; 0)
ARRAY TEXT:C222(tb_de_dos_num; 0)
ARRAY DATE:C224(tb_de_date_du; 0)
ARRAY DATE:C224(tb_de_date_au; 0)
ARRAY LONGINT:C221(tb_de_fin; 0)
ARRAY LONGINT:C221(tb_de_reste; 0)

READ ONLY:C145([Dossiers_Encours:102])

If ($utiliser_les_filtres)
	
	QUERY:C277([Dossiers_Encours:102]; [Dossiers_Encours:102]Ref_Structure:9=<>ref_soc_active; *)
	QUERY:C277([Dossiers_Encours:102];  & ; [Dossiers_Encours:102]DOS_Nom:3="@"+filtre_nom_dossier+"@"; *)
	QUERY:C277([Dossiers_Encours:102];  & ; [Dossiers_Encours:102]DOS_Numero:4="@"+filtre_num_dossier+"@")
	
	If (filtre_date#!00-00-00!)
		QUERY SELECTION:C341([Dossiers_Encours:102];  & ; [Dossiers_Encours:102]DOS_Date_Au:6=filtre_date)
	End if 
	
Else 
	QUERY:C277([Dossiers_Encours:102]; [Dossiers_Encours:102]Ref_Structure:9=<>ref_soc_active)
End if 


ORDER BY:C49([Dossiers_Encours:102]; [Dossiers_Encours:102]DOS_Date_Au:6; <)


While (Not:C34(End selection:C36([Dossiers_Encours:102])))
	
	$continu:=False:C215
	$difference:=[Dossiers_Encours:102]DOS_Date_Au:6-Current date:C33(*)
	
	If ($utiliser_les_filtres)
		
		$continu:=True:C214
		
		If (filtre_nom_heberge#"")
			
			$continu:=False:C215
			
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Dossiers_Encours:102]DOS_HB_ReferenceID:2; *)
			QUERY:C277([HeBerge:4];  & ; [HeBerge:4]HB_Nom:3="@"+filtre_nom_heberge+"@")
			MultiSoc_Filter(->[HeBerge:4])
			
			If (Records in selection:C76([HeBerge:4])=1)
				$continu:=True:C214
			End if 
			
		End if 
		
		
		If (filtre_date#!00-00-00!)
			$continu:=False:C215
			If (($difference<=[Dossiers_Encours:102]DOS_Rappel_Jours:7) & ($difference>0))
				$continu:=True:C214
			End if 
		End if 
		
	Else 
		If (($difference<=[Dossiers_Encours:102]DOS_Rappel_Jours:7) & ($difference>0))
			$continu:=True:C214
		End if 
	End if 
	
	If ($continu)
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Dossiers_Encours:102]DOS_HB_ReferenceID:2)
		MultiSoc_Filter(->[HeBerge:4])
		
		APPEND TO ARRAY:C911(tb_de_cle; [HeBerge:4]HB_Clé:2)
		APPEND TO ARRAY:C911(tb_de_dos_nom; [Dossiers_Encours:102]DOS_Nom:3)
		APPEND TO ARRAY:C911(tb_de_dos_num; [Dossiers_Encours:102]DOS_Numero:4)
		APPEND TO ARRAY:C911(tb_de_date_du; [Dossiers_Encours:102]DOS_Date_Du:5)
		APPEND TO ARRAY:C911(tb_de_date_au; [Dossiers_Encours:102]DOS_Date_Au:6)
		APPEND TO ARRAY:C911(tb_de_fin; [Dossiers_Encours:102]DOS_Rappel_Jours:7)
		APPEND TO ARRAY:C911(tb_de_reste; $difference)
	End if 
	
	NEXT RECORD:C51([Dossiers_Encours:102])
End while 

If (Not:C34($utiliser_les_filtres))
	
	If (Size of array:C274(tb_de_dos_num)=0)
		CANCEL:C270
	End if 
	
End if 