//%attributes = {"publishedWeb":true}
// ----------------------------------------------------
// User name (OS): Administrator
// Date and time: 21/12/20, 17:37:15
// ----------------------------------------------------
// Method: Web_Manage_Modele_Observation
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($1)

C_TEXT:C284($action_t; $nomModele_t; $contenuModele_t; $path_t; $content_t)
C_LONGINT:C283($userID_el)
C_OBJECT:C1216($retour_o)

$action_t:=Web_Form_Get_Post_Value("action")
$userID_el:=Num:C11(Web_Form_Get_Post_Value("intervenantID"))

$nomModele_t:=Web_Form_Get_Post_Value("nomModele")
$contenuModele_t:=Web_Form_Get_Post_Value("contenuModele")

$retour_o:=New object:C1471("etat"; False:C215; "messageErreur"; ""; "modeleContenue"; "")

If ($userID_el>0)
	$path_t:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"customContent"+Séparateur dossier:K24:12+String:C10($userID_el)+Séparateur dossier:K24:12+"observation"+Séparateur dossier:K24:12+"modele"+Séparateur dossier:K24:12
	
	If (Test path name:C476($path_t)=Est un dossier:K24:2)
		
		If ($action_t="obtenirContenu")
			
			If (Test path name:C476($path_t+$nomModele_t+".html")=Est un document:K24:1)
				$content_t:=Document to text:C1236($path_t+$nomModele_t+".html"; "UTF-8"; Document inchangé:K24:18)
				
				$retour_o.etat:=True:C214
				$retour_o.modeleContenue:=$content_t
			Else 
				$retour_o.messageErreur:="Le modèle sélectionné n'a pas pu être retrouver sur le serveur, merci de contacter le service informatique."
			End if 
			
		End if 
		
		If ($action_t="sauvegarder")
			TEXT TO DOCUMENT:C1237($path_t+$nomModele_t+".html"; $contenuModele_t; "UTF-8"; Document inchangé:K24:18)
			
			If (Test path name:C476($path_t+$nomModele_t+".html")=Est un document:K24:1)
				$retour_o.etat:=True:C214
			Else 
				$retour_o.messageErreur:="Le modèle n'a pas pu être sauvegarder sur le serveur, merci de contacter le service informatique."
			End if 
			
		End if 
		
		If ($action_t="supprimer")
			
			If (Test path name:C476($path_t+$nomModele_t+".html")=Est un document:K24:1)
				DELETE DOCUMENT:C159($path_t+$nomModele_t+".html")
				
				$retour_o.etat:=True:C214
			Else 
				$retour_o.messageErreur:="Le modèle n'a pas pu être retrouver sur le serveur, merci de contacter le service informatique."
			End if 
			
		End if 
		
	Else 
		$retour_o.messageErreur:="Le chemin des modèles d'observation n'est pas défini sur le serveur, merci de contacter le service informatique."
	End if 
	
Else 
	$retour_o.messageErreur:="Votre ID n'a pas pu être retrouver dans la base de donnée, merci de contacter le service informatique."
End if 

WEB SEND TEXT:C677(JSON Stringify:C1217($retour_o))