//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 07/04/20, 07:33:30
// ----------------------------------------------------
// Method: Web_PLA_HG_Create
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($ids_centres; $Status; txt_groupe; $msg)
C_OBJECT:C1216($O_Output; $O_Data)
C_BOOLEAN:C305($continu)
C_LONGINT:C283($id_event; $i; $nombre_fiches_crees)

$O_Output:=New object:C1471
$continu:=True:C214
$status:="success"
$msg:=""
$nombre_fiches_crees:=0

$O_Data:=Web_AGL_Get_Post_Json_Data

$O_Data:=OB Get:C1224($O_Data; "pla"; Est un objet:K8:27)

$id_event:=Num:C11(OB Get:C1224($O_Data; "id_event"; Est un texte:K8:3))
$ids_centres:=OB Get:C1224($O_Data; "ids_centres"; Est un texte:K8:3)
txt_groupe:=OB Get:C1224($O_Data; "groupe"; Est un texte:K8:3)

READ ONLY:C145([Events:103])
READ ONLY:C145([LesCentres:9])
READ ONLY:C145([HeBerge:4])

QUERY:C277([Events:103]; [Events:103]ID:1=$id_event)
MultiSoc_Filter(->[Events:103])

If (txt_groupe="")
	$msg:="Vous devez sélectionner le groupe"
	$continu:=False:C215
End if 

If ($continu)
	
	If (Records in selection:C76([Events:103])=1)
		
		C_BOOLEAN:C305(vb_IDT_JN; var_saisie_differee)
		C_DATE:C307(var_date_fiche)
		C_TIME:C306(var_heure_fiche)
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[Events:103]EVE_HB_ID:14)
		MultiSoc_Filter(->[HeBerge:4])
		
		$hb_cle:=[HeBerge:4]HB_Clé:2
		var_saisie_differee:=False:C215
		vb_IDT_JN:=True:C214  // prestation
		var_date_fiche:=[Events:103]EVE_Date_Du:5
		var_heure_fiche:=[Events:103]EVE_Heure_Du:7
		
		If (Records in selection:C76([HeBerge:4])=1)
			
			ARRAY TEXT:C222($tb_centres; 0)
			
			UTL_Cut_Text(->$ids_centres; ->$tb_centres; ";")
			
			If (Size of array:C274($tb_centres)>0)
				
				For ($i; 1; Size of array:C274($tb_centres))
					
					QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=Num:C11($tb_centres{$i}))
					MultiSoc_Filter(->[LesCentres:9])
					
					If (Records in selection:C76([LesCentres:9])=1)
						
						QUERY:C277([HeberGement:5]; [HeberGement:5]HG_Origine_ID:175=[Events:103]ID:1; *)
						QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_LC_ID:61=[LesCentres:9]LC_RéférenceID:1)
						MultiSoc_Filter(->[HeberGement:5])
						
						If (Records in selection:C76([HeberGement:5])=0)
							$msg:=HG_Pointage($hb_cle; [Events:103]ID:1)
							If ($msg="true")
								$nombre_fiches_crees:=$nombre_fiches_crees+1
							End if 
							If (($msg="@Aucune fiche@") | (($msg="@vous devez@")))
								$continu:=False:C215
							End if 
						Else 
							$msg:="La fiche d'hébergement est déja éxistante."
							$continu:=False:C215
						End if 
						
						
					End if 
					
				End for 
				
			Else 
				$msg:="Vous devez choisir le(s) centre(s) d'hébergement(s)"
				$continu:=False:C215
			End if 
			
		Else 
			$msg:="Vous devez choisir un hébergé"
			$continu:=False:C215
		End if 
		
		
		
	Else 
		$msg:="Vous devez choisir un événement"
		$continu:=False:C215
	End if 
	
End if 

If (Not:C34($continu))
	$status:="Failed"
Else 
	If ($nombre_fiches_crees>0)
		$msg:="Opération effectuée avec succès."  //+String($nombre_fiches_crees)+" fiches d'hébergmenets ont été crées."
	End if 
End if 

OB SET:C1220($O_Output; "status"; $status; "message"; $msg)
$T_Json:=JSON Stringify:C1217($O_Output)
WEB SEND TEXT:C677($T_Json)