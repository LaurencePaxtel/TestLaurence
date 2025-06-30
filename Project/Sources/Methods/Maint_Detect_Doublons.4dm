//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 28/08/18, 19:00:07
// ----------------------------------------------------
// Méthode : Maint_Detect_Doublons
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_POINTER:C301($table; $primary_key)
C_LONGINT:C283($i; $id_previous; $fiches_traitees; $nb_doublons)
C_TEXT:C284(var_nombre_tables)

var_nombre_tables:=""
$fiches_traitees:=0


ARRAY POINTER:C280(tb_tables; 0)
ARRAY POINTER:C280(tb_champ_uid; 0)
ARRAY BOOLEAN:C223(tb_doublons_exist; 0)
ARRAY TEXT:C222(tb_table_name; 0)
ARRAY LONGINT:C221(tb_nombre_doublons; 0)
ARRAY TEXT:C222(tb_method_spec; 0)
ARRAY POINTER:C280(tb_field_save; 0)

ARRAY POINTER:C280(tb_table_pointer; 0)
ARRAY TEXT:C222(tab_table_name; 0)
ARRAY LONGINT:C221(tab_primary_key; 0)

//  // Liste des tables
//APPEND TO ARRAY(tb_tables;->[DePart])
//APPEND TO ARRAY(tb_champ_uid;->[DePart]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"DePart")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[ReferenceUnique])
//APPEND TO ARRAY(tb_champ_uid;->[ReferenceUnique]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"ReferenceUnique")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[DiaLogues])
//APPEND TO ARRAY(tb_champ_uid;->[DiaLogues]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"DiaLogues")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[HeBerge])
//APPEND TO ARRAY(tb_champ_uid;->[HeBerge]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"HeBerge")
//APPEND TO ARRAY(tb_nombre_doublons;0)

APPEND TO ARRAY:C911(tb_tables; ->[HeberGement:5])
APPEND TO ARRAY:C911(tb_champ_uid; ->[HeberGement:5]HG_ReferenceID:1)
APPEND TO ARRAY:C911(tb_doublons_exist; False:C215)
APPEND TO ARRAY:C911(tb_table_name; "HeberGement")
APPEND TO ARRAY:C911(tb_nombre_doublons; 0)
APPEND TO ARRAY:C911(tb_method_spec; "Uut_Numerote")
APPEND TO ARRAY:C911(tb_field_save; ->[HeberGement:5]HG_ReferenceID_Sauve:170)

//APPEND TO ARRAY(tb_tables;->[LesCentres])
//APPEND TO ARRAY(tb_champ_uid;->[LesCentres]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"LesCentres")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[INtervenants])
//APPEND TO ARRAY(tb_champ_uid;->[INtervenants]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"INtervenants")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[TypesTables])
//APPEND TO ARRAY(tb_champ_uid;->[TypesTables]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"TypesTables")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[TAbles])
//APPEND TO ARRAY(tb_champ_uid;->[TAbles]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"TAbles")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[GIP])
//APPEND TO ARRAY(tb_champ_uid;->[GIP]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"GIP")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[CentresLits])
//APPEND TO ARRAY(tb_champ_uid;->[CentresLits]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"CentresLits")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[TablesDemande])
//APPEND TO ARRAY(tb_champ_uid;->[TablesDemande]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"TablesDemande")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[APpels])
//APPEND TO ARRAY(tb_champ_uid;->[APpels]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"APpels")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[RenseiGnements])
//APPEND TO ARRAY(tb_champ_uid;->[RenseiGnements]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"RenseiGnements")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[LesRubriques])
//APPEND TO ARRAY(tb_champ_uid;->[LesRubriques]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"LesRubriques")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[Maraude])
//APPEND TO ARRAY(tb_champ_uid;->[Maraude]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"Maraude")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[DossierSocial])
//APPEND TO ARRAY(tb_champ_uid;->[DossierSocial]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"DossierSocial")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[ActionSociale])
//APPEND TO ARRAY(tb_champ_uid;->[ActionSociale]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"ActionSociale")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[DossierInfirmie])
//APPEND TO ARRAY(tb_champ_uid;->[DossierInfirmie]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"DossierInfirmie")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[DossierMedical])
//APPEND TO ARRAY(tb_champ_uid;->[DossierMedical]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"DossierMedical")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[MemO])
//APPEND TO ARRAY(tb_champ_uid;->[MemO]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"MemO")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[IntervenantsProfils])
//APPEND TO ARRAY(tb_champ_uid;->[IntervenantsProfils]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"IntervenantsProfils")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[IntervenantsGroupes])
//APPEND TO ARRAY(tb_champ_uid;->[IntervenantsGroupes]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"IntervenantsGroupes")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[Messagerie])
//APPEND TO ARRAY(tb_champ_uid;->[Messagerie]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"Messagerie")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[Rapport])
//APPEND TO ARRAY(tb_champ_uid;->[Rapport]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"Rapport")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[Prolongation])
//APPEND TO ARRAY(tb_champ_uid;->[Prolongation]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"Prolongation")
//APPEND TO ARRAY(tb_nombre_doublons;0)

//APPEND TO ARRAY(tb_tables;->[TableFusions])
//APPEND TO ARRAY(tb_champ_uid;->[TableFusions]ID)
//APPEND TO ARRAY(tb_doublons_exist;False)
//APPEND TO ARRAY(tb_table_name;"TableFusions")
//APPEND TO ARRAY(tb_nombre_doublons;0)

UTL_Fenetre(500; 250; 0; "Détection des doublons encours...")


For ($i; 1; Size of array:C274(tb_tables))
	
	GOTO XY:C161(2; 2)
	MESSAGE:C88("Table "+tb_table_name{$i})
	
	$table:=tb_tables{$i}
	$primary_key:=tb_champ_uid{$i}
	
	READ ONLY:C145($table->)
	ALL RECORDS:C47($table->)
	//QUERY($table->;$primary_key->=0)
	
	//QUERY([HeberGement];[HeberGement]HG_ReferenceID#0)
	
	ORDER BY:C49($table->; $primary_key->; >)
	
	$nb_doublons:=0
	$id_previous:=0
	
	//CREATE EMPTY SET($table->;"selection")
	
	While (Not:C34(End selection:C36($table->)))
		
		$fiches_traitees:=$fiches_traitees+1
		
		GOTO XY:C161(2; 2)
		MESSAGE:C88("Table : "+tb_table_name{$i}+Char:C90(Retour chariot:K15:38))
		GOTO XY:C161(2; 3)
		MESSAGE:C88("Fiches traitées : "+String:C10($fiches_traitees)+Char:C90(Retour chariot:K15:38))
		GOTO XY:C161(2; 4)
		MESSAGE:C88("Total des fiches à traiter : "+String:C10(Records in selection:C76($table->)))
		GOTO XY:C161(2; 5)
		MESSAGE:C88("Progression : "+String:C10(Round:C94(($fiches_traitees*100)/Records in selection:C76($table->); 0))+"%")
		
		If ($primary_key->=$id_previous)
			
			//ADD TO SET($table->;"selection")
			tb_doublons_exist{$i}:=True:C214
			
			APPEND TO ARRAY:C911(tb_table_pointer; $table)
			APPEND TO ARRAY:C911(tab_table_name; Table name:C256($table))
			APPEND TO ARRAY:C911(tab_primary_key; $primary_key->)
			
			$nb_doublons:=$nb_doublons+1
		End if 
		
		$id_previous:=$primary_key->
		
		NEXT RECORD:C51($table->)
	End while 
	
	
	
	//USE SET("selection")
	
	//$fiches_traitees:=0
	
	//While (Not(End selection($table->)))
	
	//$fiches_traitees:=$fiches_traitees+1
	//GOTO XY(2;5)
	//MESSAGE("Traitement encours : "+String($fiches_traitees)+Char(Carriage return))
	
	//APPEND TO ARRAY(tb_table_pointer;$table)
	//APPEND TO ARRAY(tab_table_name;Table name($table))
	//APPEND TO ARRAY(tab_primary_key;$primary_key->)
	
	//NEXT RECORD($table->)
	//End while 
	
	//CLEAR SET("selection")
	
	
	tb_doublons_exist{$i}:=True:C214
	tb_nombre_doublons{$i}:=$nb_doublons
	
	
End for 

var_nombre_tables:=String:C10(Size of array:C274(tb_tables))

CLOSE WINDOW:C154
