//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 13/11/19, 08:32:36
// ----------------------------------------------------
// Method: MAINT_Import_Cles
// Description
// 
//
// Parameters
// ----------------------------------------------------

C_LONGINT:C283($compteur_hb; $compteur_ds; $nb_fiches; $i)

$compteur_hb:=0
$i:=0

//==============================//
// Hebergement
//==============================//

READ WRITE:C146([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]Ref_Structure:169=<>ref_soc_active)

$nb_fiches:=Records in selection:C76([HeberGement:5])

$progress_id:=Progress New
Progress SET TITLE($progress_id; "Traitement des clés primaires..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; True:C214)

While (Not:C34(End selection:C36([HeberGement:5])))
	
	$i:=$i+1
	
	Progress SET PROGRESS($progress_id; $i/$nb_fiches; "Traitement des clés primaires de la table [HeberGement]  "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
	Progress SET MESSAGE($progress_id; "Traitement des clés primaires de la table [HeberGement]  "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
	
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]import_tmp:74=String:C10([HeberGement:5]HG_HB_ID:19))
	MultiSoc_Filter(->[HeBerge:4])
	If (Records in selection:C76([HeBerge:4])=1)
		[HeberGement:5]HG_HB_ID:19:=[HeBerge:4]HB_ReferenceID:1
		$compteur_hb:=$compteur_hb+1
	End if 
	
	SAVE RECORD:C53([HeberGement:5])
	NEXT RECORD:C51([HeberGement:5])
End while 

Progress QUIT($progress_id)

//==============================//
// Hebergement
//==============================//
READ WRITE:C146([DossierSocial:25])
QUERY:C277([DossierSocial:25]; [DossierSocial:25]Ref_Structure:78=<>ref_soc_active)

$nb_fiches:=Records in selection:C76([DossierSocial:25])
$i:=0

$progress_id:=Progress New
Progress SET TITLE($progress_id; "Traitement des clés primaires..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; True:C214)

While (Not:C34(End selection:C36([DossierSocial:25])))
	
	$i:=$i+1
	
	Progress SET PROGRESS($progress_id; $i/$nb_fiches; "Traitement des clés primaires "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
	Progress SET MESSAGE($progress_id; "La table [DossierSocial] "+String:C10($i)+" / "+String:C10($nb_fiches); True:C214)
	
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]import_tmp:74=String:C10([DossierSocial:25]DS_HB_ID:10))
	MultiSoc_Filter(->[HeBerge:4])
	If (Records in selection:C76([HeBerge:4])=1)
		[DossierSocial:25]DS_HB_ID:10:=[HeBerge:4]HB_ReferenceID:1
		$compteur_ds:=$compteur_ds+1
	End if 
	
	SAVE RECORD:C53([DossierSocial:25])
	NEXT RECORD:C51([DossierSocial:25])
End while 

Progress QUIT($progress_id)

ALERT:C41("Traitement des clés effectué avec succès, hebergements : "+String:C10($compteur_hb)+" , dossiersocial "+String:C10($compteur_hb))