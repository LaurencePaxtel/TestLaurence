//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 02/11/23, 14:35:20
// ----------------------------------------------------
// Méthode : outilsManageSynchroAppMobile
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer  // Point d'entrée
var $2 : Variant  // ID de la société OU Signal
var $3 : Variant  // Ref structure
var $4 : Variant  // Message

var $property_t; $refStructure_t : Text
var $index_el : Integer
var $stopSave_b : Boolean
var $configuration_o : Object
var $columnLabel_c; $data_c; $property_c; $collection_c : Collection

var $societe_e : cs:C1710.SOcieteEntity
var $societe_es : cs:C1710.SOcieteSelection

var $form_cs : cs:C1710.FormManage

Case of 
	: ($1=1)  // Initialisation des workers formulaire/import-export de synchronisation avec l'application mobile, lancer depuis _cmaGestionCronos - Nouveau process pas permanent
		$societe_es:=ds:C1482.SOciete.all().orderBy("Ref_Structure asc")
		
		For each ($societe_e; $societe_es)
			
			If ($societe_e.SO_SynchroApplicationMobile=Null:C1517)
				$societe_e.SO_SynchroApplicationMobile:=New object:C1471("nbMinute"; 10; "lastTimeStampImport"; 0; "lastTimeStampExport"; 0; "activer"; False:C215)
				$statut_o:=$societe_e.save()
			End if 
			
		End for each 
		
		$signal_o:=New signal:C1641("Initialisation de la fenêtre des logs App mobile/Paxtel")
		CALL WORKER:C1389("formSynchroAppMobile_w"; "outilsManageSynchroAppMobile"; 2; $signal_o)
		
		$signal_b:=$signal_o.wait(120)  // Sécurité si l'affichage du formulaire prend plus de 2 minutes
		
		CALL WORKER:C1389("synchroAppMobile_w"; "outilsManageSynchroAppMobile"; 10)
	: ($1=2)  // Apparition du formulaire qui gère les appels entre l'application mobile et le logiciel - Worker permanent tant que le formulaire reste à l'écran
		$form_cs:=cs:C1710.FormManage.new()
		
		$societe_es:=ds:C1482.SOciete.all()
		$societe_es:=$societe_es.orderBy("Ref_Structure asc")
		
		outilsCollectionInit(->$columnLabel_c; ->$data_c)
		
		// Création des data
		$data_c.push(New object:C1471)
		
		// Création des colonnes
		For each ($societe_e; $societe_es)
			$collection_c:=$columnLabel_c.query("titre = :1"; $societe_e.Ref_Structure)
			
			If ($collection_c.length=0)
				$columnLabel_c.push(New object:C1471("titre"; $societe_e.Ref_Structure; "text-align"; 3))
				$data_c[0]["log"+$societe_e.Ref_Structure]:="Initialisation de la connexion entre Paxtel et l'application mobile"
			End if 
			
		End for each 
		
		// Pour coller à l'ordre alphabétique des propriétés d'objet je suis obligé de faire ça
		$columnLabel_c:=$columnLabel_c.orderBy("titre")
		
		$configuration_o:=New object:C1471(\
			"column"; $columnLabel_c; \
			"data"; $data_c; \
			"title"; "Information"; \
			"subTitle"; "Dans cette fenêtre vous pourrez voir les échanges entre le logiciel Paxtel et l'application mobile"; \
			"textButtonValidation"; "Fermer"; \
			"signal"; $2; \
			"saveInStorageWindowsRef"; New object:C1471("property"; "synchroAppMobileWindows"); \
			"columnRules"; New object:C1471(\
			"columnWidth"; 400; \
			"fixedColumn"; New collection:C1472))
		
		$position_t:="center"
		outilsCreateWindowsForm("FormListeGenerique"; ->$position_t; $configuration_o)
		
		KILL WORKER:C1390("formSynchroAppMobile_w")
	: ($1=10)  // Synchro entre l'application mobile et le logiciel Paxtel - Worker permanent
/*
Tant que (Vrai)
$societe_es:=ds.SOciete.all().orderBy("Ref_Structure asc")
		
Pour chaque ($societe_e; $societe_es)
$societe_e.reload()
		
		
Si (Bool($societe_e.SO_SynchroApplicationMobile.activer)=Vrai)
TRACE
Si ($societe_e.SO_SynchroApplicationMobile.lastTimeStampExport<outilsTimeStamp(Date du jour(*); Heure courante(*)))
$stopSave_b:=$societe_e.synchroAppMobileExportData()
		
Si ($stopSave_b=Faux)
$societe_e.SO_SynchroApplicationMobile.lastTimeStampExport:=outilsTimeStamp(Date du jour(*); Heure courante(*))+(60*$societe_e.SO_SynchroApplicationMobile.nbMinute)
Fin de si 
TRACE
Fin de si 
		
Si ($societe_e.SO_SynchroApplicationMobile.lastTimeStampImport<outilsTimeStamp(Date du jour(*); Heure courante(*)))
$societe_e.synchroAppMobileImportData()
		
$societe_e.SO_SynchroApplicationMobile.lastTimeStampImport:=outilsTimeStamp(Date du jour(*); Heure courante(*))+(60*$societe_e.SO_SynchroApplicationMobile.nbMinute)
$statut_o:=$societe_e.save()
Fin de si 
		
$statut_o:=$societe_e.save()
Fin de si 
		
		
EFFACER VARIABLE($stopSave_b)
ENDORMIR PROCESS(Numéro du process courant; 60)
Fin de chaque 
		
ENDORMIR PROCESS(Numéro du process courant; 600)
Fin tant que 
*/
	: ($1=99)  // Gestion des messages qu'on envoit au worker initialisé dans le formulaire du point d'entrée 2
		
		For each ($log_o; Form:C1466.data) Until ($stop_b=True:C214)
			$index_el:=Form:C1466.data.indexOf($log_o)
			$stop_b:=(Form:C1466.data[$index_el]["log"+$3]="")  // Si toutes les cellules de la colonne qui est destiné à la structure $3 ne sont pas remplis on prend la première d'entre elles
		End for each 
		
		If ($stop_b=True:C214)  // Il y a au moins une cellule de la colonne de la structure $3 qui n'est pas rempli
			Form:C1466.data[$index_el]["log"+$3]:=$4
		Else   // Toutes les cellules de la colonne de la structure $3 sont remplis, on rajoute une ligne dans la listBox
			$property_c:=OB Keys:C1719(Form:C1466.data[((Form:C1466.data.length)-1)])
			Form:C1466.data.push(New object:C1471)
			
			For each ($property_t; $property_c)
				Form:C1466.data[((Form:C1466.data.length)-1)][$property_t]:=""
				$refStructure_t:=Replace string:C233($property_t; "log"; "")
				
				If ($refStructure_t=$3)
					Form:C1466.data[((Form:C1466.data.length)-1)][$property_t]:=$4
				End if 
				
			End for each 
			
		End if 
		
		$2.trigger()
End case 