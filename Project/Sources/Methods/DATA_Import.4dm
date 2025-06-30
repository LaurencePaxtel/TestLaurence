//%attributes = {}
// ----------------------------------------------------
// Developer: Kevin HASSAL
// Date and time: 04/10/19, 10:08:56
// ----------------------------------------------------
// Method: DATA_Import
// Description
// Cette méthode générique permet d'importer des données exportés
// depuis la version 6.7.4 de 4D, elle correspond au format
// de la méthode d'export de la version 6.7.4
// elle peut être utilisée pour les autres versions de 4D si le
// format du fichier txt d'import est respecté
//
// Format du fichier txt d'import
// Nom de la table
// Nom du champ ID
// Liste des champs
// Liste des entregistrements
// ----------------------------------------------------
C_TEXT:C284($ligne; $cr; $table_name)
C_LONGINT:C283($i; $fiches_traitees; $fiches_traitees; $N_nontraite; $vLength; $nb_fiches; $field_num; $current_last_id)
C_BOOLEAN:C305($vIndex; $vUnique; $vInvisible; $continu; $creerFicheHeberge_b)
C_POINTER:C301($table_ptr; $field_ptr; $ptr_table_DossierSocial; $ptr_table_Maraude; $ptr_hg_hb_id; $ptr_ds_hb_id; $ptr_mr_hb_id)

C_TEXT:C284(ref_soc_active)

$ptr_table_DossierSocial:=->[DossierSocial:25]
$ptr_table_Maraude:=->[Maraude:24]

$ptr_hg_hb_id:=->[HeberGement:5]HG_HB_ID:19
$ptr_ds_hb_id:=->[DossierSocial:25]DS_HB_ID:10
$ptr_mr_hb_id:=->[Maraude:24]MR_HB_ID:10

If (Count parameters:C259>0)
	ref_soc_active:=$1
Else 
	ref_soc_active:=<>ref_soc_active
End if 

$cr:=Char:C90(Retour chariot:K15:38)
$sep:=";"

READ ONLY:C145([Structures:79])
QUERY:C277([Structures:79]; [Structures:79]Ref_Structure:3=ref_soc_active)

If (Records in selection:C76([Structures:79])=1)
	$a:=Open document:C264(""; ""; Mode lecture:K24:5)
	
	If (ok=1)
		USE CHARACTER SET:C205("ISO-8859-1"; 1)
		
		//==================================================//
		// TABLE & CHAMP ID & Nombre des fiches
		//==================================================//
		RECEIVE PACKET:C104($a; $ligne; $cr)
		$table_name:=$ligne
		
		RECEIVE PACKET:C104($a; $ligne; $cr)
		$champ_id_name:=$ligne
		
		RECEIVE PACKET:C104($a; $ligne; $cr)
		$nb_fiches:=Num:C11($ligne)
		
		//==================================================//
		// LES CHAMPS
		//==================================================//
		RECEIVE PACKET:C104($a; $ligne; $cr)
		
		ARRAY TEXT:C222($tb_champs; 0)
		UTL_Decoupe_texte(->$ligne; ->$tb_champs; $sep)
		
		$nbr_colonnes:=Size of array:C274($tb_champs)
		
		//==================================================//
		EXECUTE FORMULA:C63("$table_ptr:=->["+$table_name+"]")
		EXECUTE FORMULA:C63("$field_ref_soc:=->["+$table_name+"]Ref_Structure")
		
		If (Read only state:C362($table_ptr->))
			READ WRITE:C146($table_ptr->)
		End if 
		
		CONFIRM:C162("Voulez vous vider la table ["+$table_name+"] de la structure "+[Structures:79]STRC_Nom:4+" ?"; "Ecraser"; "Compléter")
		
		If (ok=1)
			QUERY:C277($table_ptr->; $field_ref_soc->=ref_soc_active)
			DELETE SELECTION:C66($table_ptr->)
		End if 
		
		//==================================================//
		// LES ENREGISTREMENTS
		//==================================================//
		$progress_id:=Progress New
		
		Progress SET TITLE($progress_id; "Import des données..."; -1; "en cours d'exécution...")
		Progress SET BUTTON ENABLED($progress_id; True:C214)
		
		While (Length:C16($ligne)>10)
			RECEIVE PACKET:C104($a; $ligne; $cr)
			
			If (Length:C16($ligne)>10)
				ARRAY TEXT:C222($tb_donnees; 0)
				UTL_Decoupe_texte(->$ligne; ->$tb_donnees; $sep)
				
				If (Size of array:C274($tb_donnees)=$nbr_colonnes)
					$i:=$i+1
					
					Progress SET PROGRESS($progress_id; $i/$nb_fiches; "Import des enregistrements "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
					Progress SET MESSAGE($progress_id; [Structures:79]STRC_Nom:4+" : Import des enregistrements de la table ["+$table_name+"] "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
					
					$tb_donnees{1}:=Replace string:C233($tb_donnees{1}; "\n"; "")
					
					EXECUTE FORMULA:C63("$table_field_id:=->["+$table_name+"]"+$champ_id_name)
					EXECUTE FORMULA:C63("$table_field_import_tmp:=->["+$table_name+"]import_tmp")
					
					ALL RECORDS:C47($table_ptr->)
					$current_last_id:=Max:C3($table_field_id->)
					
					Case of 
						: ($table_ptr=->[HeBerge:4])
							QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=$tb_donnees{2})
						Else 
							QUERY:C277($table_ptr->; $table_field_id->=Num:C11($tb_donnees{1}))
					End case 
					
					MultiSoc_Filter($table_ptr)
					
					CLEAR VARIABLE:C89($continu)
					
					Case of 
						: (Records in selection:C76($table_ptr->)=0)
							CREATE RECORD:C68($table_ptr->)
							MultiSoc_Init_Structure($table_ptr)
							
							$continu:=True:C214
						: (Records in selection:C76($table_ptr->)=1)
							$continu:=True:C214
					End case 
					
					If ($continu)
						
						For ($j; 1; $nbr_colonnes)
							EXECUTE FORMULA:C63("$field_ptr:=->["+$table_name+"]"+$tb_champs{$j})
							$field_num:=Field:C253($field_ptr)
							
							If (Is field number valid:C1000($field_ptr; $field_num))
								GET FIELD PROPERTIES:C258($field_ptr; $type; $vLength; $vIndex; $vUnique; $vInvisible)
								
								Case of 
									: ($type=Est un champ alpha:K8:1)
										$field_ptr->:=$tb_donnees{$j}
									: ($type=Est un texte:K8:3)
										$field_ptr->:=$tb_donnees{$j}
									: ($type=Est un numérique:K8:4)
										$field_ptr->:=Num:C11($tb_donnees{$j})
									: ($type=Est un entier:K8:5)
										$field_ptr->:=Num:C11($tb_donnees{$j})
									: ($type=Est un entier long:K8:6)
										$field_ptr->:=Num:C11($tb_donnees{$j})
									: ($type=Est une date:K8:7)
										$field_ptr->:=Date:C102($tb_donnees{$j})
									: ($type=Est une heure:K8:8)
										$field_ptr->:=Time:C179($tb_donnees{$j})
									: ($type=Est un booléen:K8:9)
										$field_ptr->:=False:C215
										
										If ($tb_donnees{$j}="O")
											$field_ptr->:=True:C214
										End if 
										
									: ($type=Est une image:K8:10)
									: ($type=Est une sous table:K8:11)
									: ($type=Est un BLOB:K8:12)
									Else 
								End case 
								
							End if 
							
							// Modifié par : Scanu Rémy (05/10/2021)
							// On reset le champ [HeBerge]HB_ReferenceID et [HeBerge]HB_CléFam, [HeBerge]HB_ReferenceID qui a pu être attribué à un autre enregistrement de la base sur lequel on fait l'import car c'est un ID qui s'incrémente de 1 et pas un UUID
							Case of 
								: (Field name:C257($field_ptr)="HB_ReferenceID") & ($table_ptr=->[HeBerge:4])
									[HeBerge:4]HB_ReferenceID:1:=Uut_Numerote(->[HeBerge:4])
									[HeBerge:4]HB_CléFam:47:=""
								: (Field name:C257($field_ptr)="@FicheNuméro@")
									$field_ptr->:=ref_soc_active+"-"+String:C10($i)+"-"+$field_ptr->
							End case 
							
							Case of 
								: ($table_ptr=->[HeberGement:5])
									
									If ($field_ptr=$ptr_hg_hb_id)
										QUERY:C277([HeBerge:4]; [HeBerge:4]import_tmp:74=String:C10([HeberGement:5]HG_HB_ID:19))
										
										If (Records in selection:C76([HeBerge:4])=1)
											[HeberGement:5]HG_HB_ID:19:=[HeBerge:4]HB_ReferenceID:1
										End if 
										
									End if 
									
								: ($table_ptr=$ptr_table_DossierSocial)
									
									If ($field_ptr=$ptr_ds_hb_id)
										QUERY:C277([HeBerge:4]; [HeBerge:4]import_tmp:74=String:C10([DossierSocial:25]DS_HB_ID:10))
										
										// Modifié par : Scanu Rémy - remy@connect-io.fr (06/12/2021)
										If (Records in selection:C76([HeBerge:4])=1)
											[DossierSocial:25]DS_HB_ID:10:=[HeBerge:4]HB_ReferenceID:1
										Else 
											$creerFicheHeberge_b:=True:C214
										End if 
										
									End if 
									
								: ($table_ptr=$ptr_table_Maraude)
									
									If ($field_ptr=$ptr_mr_hb_id)
										QUERY:C277([HeBerge:4]; [HeBerge:4]import_tmp:74=String:C10([Maraude:24]MR_HB_ID:10))
										
										// Modifié par : Scanu Rémy - remy@connect-io.fr (06/12/2021)
										If (Records in selection:C76([HeBerge:4])=1)
											[Maraude:24]MR_HB_ID:10:=[HeBerge:4]HB_ReferenceID:1
										Else 
											$creerFicheHeberge_b:=True:C214
										End if 
										
									End if 
									
							End case 
							
						End for 
						
						$current_last_id:=$current_last_id+1
						$table_field_import_tmp->:=String:C10($table_field_id->)
						$table_field_id->:=$current_last_id
						
						$fiches_traitees:=$fiches_traitees+1
						
						// Modifié par : Scanu Rémy - remy@connect-io.fr (06/12/2021)
						If ($creerFicheHeberge_b=True:C214)
							
							Case of 
								: ($table_ptr=$ptr_table_DossierSocial)
									wUut_CléReconstruireDS
								: ($table_ptr=$ptr_table_Maraude)
									wUut_CléReconstruireMR
							End case 
							
						End if 
						
						CLEAR VARIABLE:C89($creerFicheHeberge_b)
						
						SAVE RECORD:C53($table_ptr->)
					End if 
					
				End if 
				
			Else 
				$N_nontraite:=$N_nontraite+1
			End if 
			
			If (Progress Stopped($progress_id)=True:C214)
				$ligne:=""
			End if 
			
		End while 
		
	End if 
	
	CLOSE DOCUMENT:C267($a)
	ALERT:C41("Nombre d'enregistrements importés avec succès : "+String:C10($fiches_traitees)+" , Lignes non traitées : "+String:C10($N_nontraite))
	
	Progress QUIT($progress_id)
Else 
	ALERT:C41("Erreur de choix de la structure")
End if 