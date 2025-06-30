//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 17/09/18, 17:48:01
// ----------------------------------------------------
// Méthode : NAV_Generate_Menus
// Description
// 
//
// Paramètres
// ----------------------------------------------------

READ ONLY:C145([NAV_Menus:77])
QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]Ref_Structure:5=<>ref_soc_active)

$ID_societeCourante_i:=ds:C1482.Structures.query("Ref_Structure IS :1"; <>ref_soc_active).first().STRC_Societe_ID

If (($ID_societeCourante_i#[Structures:79]STRC_Societe_ID:6) & (Records in selection:C76([NAV_Menus:77])=0))
	
	C_LONGINT:C283($ID_Menu; $fiches_traitees; $fiches_traitees_SM; $i; $j)
	
	$fiches_traitees:=0
	$fiches_traitees_SM:=0
	
	READ WRITE:C146([NAV_Menus:77])
	READ WRITE:C146([NAV_Sous_Menus:78])
	
	//QUERY([NAV_Menus];[NAV_Menus]Ref_Structure="TSE")
	//QUERY([NAV_Sous_Menus];[NAV_Sous_Menus]Ref_Structure="TSE")
	//DELETE SELECTION([NAV_Menus])
	//DELETE SELECTION([NAV_Sous_Menus])
	
	QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]Ref_Structure:5=[Structures:79]STRC_Initiales:2)
	
	ARRAY LONGINT:C221($tb_uids; 0)
	SELECTION TO ARRAY:C260([NAV_Menus:77]ID:1; $tb_uids)
	
	For ($i; 1; Size of array:C274($tb_uids))
		
		QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]ID:1=$tb_uids{$i})
		
		DUPLICATE RECORD:C225([NAV_Menus:77])
		[NAV_Menus:77]Ref_Structure:5:=""
		MultiSoc_Init_Structure(->[NAV_Menus:77])
		SAVE RECORD:C53([NAV_Menus:77])
		
		$ID_Menu:=[NAV_Menus:77]ID:1
		
		QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]NS_ID_Menu:2=$tb_uids{$i}; *)
		QUERY:C277([NAV_Sous_Menus:78];  & ; [NAV_Sous_Menus:78]Ref_Structure:10=[Structures:79]STRC_Initiales:2)
		
		ARRAY LONGINT:C221($tb_uids_sm; 0)
		SELECTION TO ARRAY:C260([NAV_Sous_Menus:78]ID:1; $tb_uids_sm)
		
		For ($j; 1; Size of array:C274($tb_uids_sm))
			
			QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]ID:1=$tb_uids_sm{$j})
			
			DUPLICATE RECORD:C225([NAV_Sous_Menus:78])
			[NAV_Sous_Menus:78]Ref_Structure:10:=""
			MultiSoc_Init_Structure(->[NAV_Sous_Menus:78])
			[NAV_Sous_Menus:78]NS_ID_Menu:2:=$ID_Menu
			SAVE RECORD:C53([NAV_Sous_Menus:78])
			
			$fiches_traitees_SM:=$fiches_traitees_SM+1
			
		End for 
		
		
		$fiches_traitees:=$fiches_traitees+1
		
	End for 
	
	QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]Ref_Structure:5=<>ref_soc_active)
	
	ALERT:C41("Menus créés : "+String:C10($fiches_traitees)+" - Sous Menus créés : "+String:C10($fiches_traitees_SM))
	
Else 
	ALERT:C41("Les menus existent déja")
End if 





// // ----------------------------------------------------
//  // Nom utilisateur (OS) : Kevin HASSAL
//  // Date et heure : 17/09/18, 17:48:01
//  // ----------------------------------------------------
//  // Méthode : NAV_Generate_Menus
//  // Description
//  // 
//  //
//  // Paramètres
//  // ----------------------------------------------------

//LECTURE SEULEMENT([NAV_Menus])
//CHERCHER([NAV_Menus];[NAV_Menus]Ref_Structure=<>ref_soc_active)

//Si ((<>ref_soc_active#"PAX") & (Enregistrements trouvés([NAV_Menus])=0))

//C_ENTIER LONG($ID_Menu;$fiches_traitees;$fiches_traitees_SM;$i;$j)

//$fiches_traitees:=0
//$fiches_traitees_SM:=0

//LECTURE ÉCRITURE([NAV_Menus])
//LECTURE ÉCRITURE([NAV_Sous_Menus])

//  //QUERY([NAV_Menus];[NAV_Menus]Ref_Structure="TSE")
//  //QUERY([NAV_Sous_Menus];[NAV_Sous_Menus]Ref_Structure="TSE")
//  //DELETE SELECTION([NAV_Menus])
//  //DELETE SELECTION([NAV_Sous_Menus])

//CHERCHER([NAV_Menus];[NAV_Menus]Ref_Structure="PAX")

//TABLEAU ENTIER LONG($tb_uids;0)
//SÉLECTION VERS TABLEAU([NAV_Menus]ID;$tb_uids)

//Boucle ($i;1;Taille tableau($tb_uids))

//CHERCHER([NAV_Menus];[NAV_Menus]ID=$tb_uids{$i})

//DUPLIQUER ENREGISTREMENT([NAV_Menus])
//[NAV_Menus]Ref_Structure:=""
//MultiSoc_Init_Structure (->[NAV_Menus])
//STOCKER ENREGISTREMENT([NAV_Menus])

//$ID_Menu:=[NAV_Menus]ID

//CHERCHER([NAV_Sous_Menus];[NAV_Sous_Menus]NS_ID_Menu=$tb_uids{$i};*)
//CHERCHER([NAV_Sous_Menus]; & ;[NAV_Sous_Menus]Ref_Structure="PAX")

//TABLEAU ENTIER LONG($tb_uids_sm;0)
//SÉLECTION VERS TABLEAU([NAV_Sous_Menus]ID;$tb_uids_sm)

//Boucle ($j;1;Taille tableau($tb_uids_sm))

//CHERCHER([NAV_Sous_Menus];[NAV_Sous_Menus]ID=$tb_uids_sm{$j})

//DUPLIQUER ENREGISTREMENT([NAV_Sous_Menus])
//[NAV_Sous_Menus]Ref_Structure:=""
//MultiSoc_Init_Structure (->[NAV_Sous_Menus])
//[NAV_Sous_Menus]NS_ID_Menu:=$ID_Menu
//STOCKER ENREGISTREMENT([NAV_Sous_Menus])

//$fiches_traitees_SM:=$fiches_traitees_SM+1

//Fin de boucle 


//$fiches_traitees:=$fiches_traitees+1

//Fin de boucle 

//CHERCHER([NAV_Menus];[NAV_Menus]Ref_Structure=<>ref_soc_active)

//ALERTE("Menus créés : "+Chaîne($fiches_traitees)+" - Sous Menus créés : "+Chaîne($fiches_traitees_SM))

//Sinon 
//ALERTE("Les menus existent déja")
//Fin de si 