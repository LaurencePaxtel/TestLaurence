//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 17/07/18, 14:55:30
// ----------------------------------------------------
// Méthode : NAV_Import_Sous_Menus
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $ligne; $cr : Text
var $fiches_traitees; $N_nontraite; $i; $nbr_colonnes : Integer
var $stop_b : Boolean
var $a : Time

var $navMenu_es : cs:C1710.NAV_MenusSelection

ARRAY TEXT:C222($tb_donnees; 0)
ARRAY TEXT:C222($tb_données; 0)

$cr:=Char:C90(Retour chariot:K15:38)
$sep:=";"

If (Read only state:C362([NAV_Sous_Menus:78]))
	READ WRITE:C146([NAV_Sous_Menus:78])
End if 

QUERY:C277([NAV_Sous_Menus:78]; [NAV_Sous_Menus:78]Ref_Structure:10=<>ref_soc_active)

If (Records in selection:C76([NAV_Sous_Menus:78])>0)
	CONFIRM:C162("Souhaitez-vous vraiment remplacer les sous-menus pré-existant ?"; "Oui"; "Non")
	
	If (OK=1)
		DELETE SELECTION:C66([NAV_Sous_Menus:78])
	End if 
	
	$stop_b:=(OK=0)
End if 

If ($stop_b=False:C215)
	$a:=Open document:C264(""; ""; Mode lecture:K24:5)
	
	If (ok=1)
		USE CHARACTER SET:C205("UTF-8"; 1)
		RECEIVE PACKET:C104($a; $ligne; $cr)
		
		UTL_Cut_Text(->$ligne; ->$tb_données; $sep)
		$nbr_colonnes:=Size of array:C274($tb_données)
		
		While (Length:C16($ligne)>10)
			RECEIVE PACKET:C104($a; $ligne; $cr)
			
			If (Length:C16($ligne)>10)
				GOTO XY:C161(2; 2)
				MESSAGE:C88(String:C10($fiches_traitees))
				
				CLEAR VARIABLE:C89($tb_donnees)
				UTL_Cut_Text(->$ligne; ->$tb_donnees; $sep)
				
				If (Size of array:C274($tb_donnees)=$nbr_colonnes)
					$i:=$i+1
					$tb_donnees{1}:=Replace string:C233($tb_donnees{1}; "\n"; "")
					
					$navMenu_es:=ds:C1482.NAV_Menus.query("NP_Menu_Libelle = :1"; $tb_donnees{2})
					outilsOrdaSearchByRefStctre(->$navMenu_es)
					
					If ($navMenu_es.length=1)
						CREATE RECORD:C68([NAV_Sous_Menus:78])
						MultiSoc_Init_Structure(->[NAV_Sous_Menus:78])
						
						// Modifié par : Scanu Rémy - remy@connect-io.fr (22/07/2022)
						// Aucun sens de mettre ça, car c'est un champ en incrémentation auto
						//[NAV_Sous_Menus]ID:=Num($tb_donnees{1})
						[NAV_Menus:77]NP_Menu_Libelle:2:=$tb_donnees{2}
						
						// Modifié par : Scanu Rémy - remy@connect-io.fr (22/07/2022)
						// Aucun sens de mettre ça, car [NAV_Sous_Menus]ID est en incrémentation auto et on ne peut pas savoir à l'avance l'id du menu X
						//[NAV_Sous_Menus]NS_ID_Menu:=Num($tb_donnees{2})
						[NAV_Sous_Menus:78]NS_ID_Menu:2:=$navMenu_es.first().ID
						
						[NAV_Sous_Menus:78]NS_Menu_Libelle:3:=$tb_donnees{3}
						[NAV_Sous_Menus:78]NS_Menu_Texte:4:=$tb_donnees{4}
						[NAV_Sous_Menus:78]NS_Menu_Formulaire:5:=$tb_donnees{5}
						[NAV_Sous_Menus:78]NS_Visible:6:=($tb_donnees{6}="vrai")
						[NAV_Sous_Menus:78]NS_Ordre:7:=Num:C11($tb_donnees{7})
						[NAV_Sous_Menus:78]NS_Menu_Table:8:=Num:C11($tb_donnees{8})
						
						[NAV_Sous_Menus:78]NS_Methode_Lancement:9:=$tb_donnees{9}
						SAVE RECORD:C53([NAV_Sous_Menus:78])
						
						$fiches_traitees:=$fiches_traitees+1
						
						GOTO XY:C161(2; 2)
						MESSAGE:C88(String:C10($fiches_traitees))
					Else 
						$N_nontraite:=$N_nontraite+1
					End if 
					
				Else 
					$N_nontraite:=$N_nontraite+1
				End if 
				
			End if 
			
		End while 
		
	End if 
	
	CLOSE DOCUMENT:C267($a)
	CLOSE WINDOW:C154
	
	UNLOAD RECORD:C212([NAV_Sous_Menus:78])
	ALERT:C41("Enregistrements créés : "+String:C10($fiches_traitees)+", Lignes non traitées : "+String:C10($N_nontraite))
End if 