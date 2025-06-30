//%attributes = {}
// ----------------------------------------------------
// Développeur : Kevin HASSAL
// Date et heure : 17/07/18, 14:55:30
// ----------------------------------------------------
// Méthode : NAV_Import_Menus
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $ligne; $cr : Text
var $fiches_traitees; $N_nontraite; $i; $nbr_colonnes : Integer
var $stop_b : Boolean
var $a : Time

ARRAY TEXT:C222($tb_donnees; 0)
ARRAY TEXT:C222($tb_données; 0)

$cr:=Char:C90(Retour chariot:K15:38)
$sep:=";"

If (Read only state:C362([NAV_Menus:77]))
	READ WRITE:C146([NAV_Menus:77])
End if 

QUERY:C277([NAV_Menus:77]; [NAV_Menus:77]Ref_Structure:5=<>ref_soc_active)

If (Records in selection:C76([NAV_Menus:77])>0)
	CONFIRM:C162("Souhaitez-vous vraiment remplacer le menu pré-existant ?"; "Oui"; "Non")
	
	If (OK=1)
		DELETE SELECTION:C66([NAV_Menus:77])
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
					
					CREATE RECORD:C68([NAV_Menus:77])
					MultiSoc_Init_Structure(->[NAV_Menus:77])
					
					// Modifié par : Scanu Rémy - remy@connect-io.fr (22/07/2022)
					// Aucun sens de mettre ça, car c'est un champ en incrémentation auto
					//[NAV_Menus]ID:=Num($tb_donnees{1})
					
					[NAV_Menus:77]NP_Menu_Libelle:2:=$tb_donnees{2}
					[NAV_Menus:77]NP_Menu_Texte:3:=$tb_donnees{3}
					[NAV_Menus:77]NP_Visible:4:=($tb_donnees{4}="vrai")
					
					SAVE RECORD:C53([NAV_Menus:77])
					$fiches_traitees:=$fiches_traitees+1
					
					GOTO XY:C161(2; 2)
					MESSAGE:C88(String:C10($fiches_traitees))
				Else 
					$N_nontraite:=$N_nontraite+1
				End if 
				
			End if 
			
		End while 
		
	End if 
	
	CLOSE DOCUMENT:C267($a)
	CLOSE WINDOW:C154
	
	UNLOAD RECORD:C212([NAV_Menus:77])
	ALERT:C41("Enregistrements créés : "+String:C10($fiches_traitees)+", Lignes non traitées : "+String:C10($N_nontraite))
End if 