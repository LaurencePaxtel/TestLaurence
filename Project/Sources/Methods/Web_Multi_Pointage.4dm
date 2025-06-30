//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 30/10/2020, 11:37:48
// ----------------------------------------------------
// Method: Web_Multi_Pointage
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($ids_centres; $Status; txt_groupe; $msg; $hb_cle; $libGroupe_t)
C_LONGINT:C283($hb_id; $i; $nombre_fiches_crees; $quantite_el)
C_REAL:C285($montant_r)
C_BOOLEAN:C305($continu)
C_DATE:C307($dateCreation_d)
C_OBJECT:C1216($O_Output; $O_Data)
C_COLLECTION:C1488($ids_centresDetail_c)
C_DATE:C307(var_date_fiche)
C_TIME:C306(var_heure_fiche)
C_BOOLEAN:C305(vb_IDT_JN; var_saisie_differee)
ARRAY TEXT:C222($tb_centres; 0)

$O_Output:=New object:C1471
$continu:=True:C214
$status:="success"

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; "pla"; Est un objet:K8:27)

$ids_centresDetail_c:=New collection:C1472

$hb_id:=Num:C11(OB Get:C1224($O_Data; "hb_id"; Est un texte:K8:3))
$ids_centres:=OB Get:C1224($O_Data; "ids_centres"; Est un texte:K8:3)
$ids_centresDetail_c:=OB Get:C1224($O_Data; "ids_centresDetail"; Est une collection:K8:32)

$dateCreation_d:=Date:C102(OB Get:C1224($O_Data; "dateCreation"; Est un texte:K8:3))

txt_groupe:=OB Get:C1224($O_Data; "groupe"; Est un texte:K8:3)

READ ONLY:C145([LesCentres:9])
READ ONLY:C145([HeBerge:4])

If (txt_groupe="")
	$libGroupe_t:="groupe"
	
	Web_Champs_Ecran_Saisie(30112; "Fam Groupe")
	$libGroupe_t:=WEB_CHAMP_Titre
	
	
	$msg:="Vous devez sélectionner le "+$libGroupe_t
	$continu:=False:C215
End if 

If ($continu)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=$hb_id)
	MultiSoc_Filter(->[HeBerge:4])
	
	$hb_cle:=[HeBerge:4]HB_Clé:2
	var_saisie_differee:=False:C215
	
	// Modifié par : Scanu Rémy (04/10/2022)
	vb_IDT_JN:=True:C214  // prestation
	
	var_date_fiche:=$dateCreation_d
	var_heure_fiche:=Current time:C178(*)
	
	If (Records in selection:C76([HeBerge:4])=1)
		UTL_Cut_Text(->$ids_centres; ->$tb_centres; ";")
		
		If (Size of array:C274($tb_centres)>0)
			
			For ($i; 1; Size of array:C274($tb_centres))
				QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=Num:C11($tb_centres{$i}))
				MultiSoc_Filter(->[LesCentres:9])
				
				If (Records in selection:C76([LesCentres:9])=1)
					QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=[HeBerge:4]HB_ReferenceID:1)
					MultiSoc_Filter(->[HeberGement:5])
					
					If (Records in selection:C76([HeberGement:5])>0)
						
						// Modifié par : Scanu Rémy - remy@connect-io.fr (16/12/2022) et Re-modifié par : Scanu Rémy (23/08/2023)
						$quantite_el:=Num:C11($ids_centresDetail_c.query("idItem = :1"; $tb_centres{$i})[0].quantite)
						$montant_r:=Num:C11($ids_centresDetail_c.query("idItem = :1"; $tb_centres{$i})[0].montant)
						
						$msg:=HG_Pointage($hb_cle; [HeBerge:4]HB_ReferenceID:1; $quantite_el; $dateCreation_d; $montant_r)
						
						Case of 
							: ($msg="true")
								$nombre_fiches_crees:=$nombre_fiches_crees+1
							: ($msg="@Aucune fiche@") | ($msg="@vous devez@")
								$continu:=False:C215
						End case 
						
					Else 
						$msg:="Au moins une fiche pour cet hébergé doit exister dans la base de données."
						$continu:=False:C215
					End if 
					
				End if 
				
			End for 
			
		Else 
			$msg:="Vous devez choisir au moins une prestation"
			$continu:=False:C215
		End if 
		
	Else 
		$msg:="Vous devez choisir un hébergé"
		$continu:=False:C215
	End if 
	
End if 

Case of 
	: (Not:C34($continu))
		$status:="Failed"
	: ($nombre_fiches_crees>0)
		$msg:="Opération effectuée avec succès."
End case 

OB SET:C1220($O_Output; "status"; $status; "message"; $msg)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)