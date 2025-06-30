//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25-12-18, 17:13:26
// ----------------------------------------------------
// Method: Web_Save_Location
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer
var $2 : Text

var $libelle; $Status : Text
var $id; $loc_bien_id : Integer
var $continu : Boolean
var $loc_date_entree; $loc_date_sortie : Date
var $table : Pointer
var $O_Output; $O_Data : Object

var champRef_p : Pointer

ARRAY TEXT:C222($tb_restricted; 0)

$table:=$1
$libelle:=$2
$O_Output:=New object:C1471
$continu:=True:C214

$O_Data:=Web_AGL_Get_Post_Json_Data
$O_Data:=OB Get:C1224($O_Data; $libelle; Est un objet:K8:27)

$id:=Num:C11(OB Get:C1224($O_Data; "id"; Est un texte:K8:3))

//====================================================================================
// Il ne faut pas permettre la création de plusieurs locations pendant la même durée.
//====================================================================================
$loc_date_entree:=Date:C102(OB Get:C1224($O_Data; "loc_date_entree"; Est un texte:K8:3))
$loc_date_sortie:=Date:C102(OB Get:C1224($O_Data; "loc_date_sortie"; Est un texte:K8:3))

$loc_bien_id:=Num:C11(OB Get:C1224($O_Data; "loc_bien_id"; Est un texte:K8:3))

If (Web_GL_Location_Is_Overlap($loc_date_entree; $loc_date_sortie; $loc_bien_id; $id))
	$continu:=False:C215
	$status:="Failed"
	
	$O_Output.notificationError:="Il y a déjà une location qui est comprise entre le "+String:C10($loc_date_entree)+" et le "+String:C10($loc_date_sortie)+\
		" pour le bien « "+$O_Data.loc_bien_nom+" »"
End if 

If ($continu)
	EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]id")
	READ WRITE:C146($table->)
	
	If ($id#0)
		QUERY:C277($table->; champRef_p->=$id)
		
		If (Records in selection:C76($table->)=1)
			
			If (Locked:C147($table->))
				$continu:=False:C215
				$O_Output.notificationError:="L'enregistrement dans 4D de la location « "+String:C10($id)+" » est verrouillé"
			End if 
			
		Else 
			$continu:=False:C215
			$O_Output.notificationError:="L'enregistrement dans 4D de la location « "+String:C10($id)+" » n'a pas pu être trouvé"
		End if 
		
	Else 
		CREATE RECORD:C68($table->)
		MultiSoc_Init_Structure($table)
		
		[Locations:84]LOC_Intervenant_ID:18:=w_userUID
		$id:=champRef_p->
	End if 
	
	If ($continu)
		APPEND TO ARRAY:C911($tb_restricted; "id")
		Web_AGL_Json_To_Record($table; ->$O_Data; ->$tb_restricted)
		
		If (([Locations:84]LOC_Date_Entree:9#!00-00-00!) & ([Locations:84]LOC_Date_Sortie:10#!00-00-00!))
			
			If ([Locations:84]LOC_Date_Entree:9<=[Locations:84]LOC_Date_Sortie:10)
				[Locations:84]LOC_Nombre_Jours:15:=[Locations:84]LOC_Date_Sortie:10-[Locations:84]LOC_Date_Entree:9
			Else 
				$continu:=False:C215
				$status:="Failed"
				
				$O_Output.notificationError:="La date d'entrée ne peut pas être supérieur à la date de fin pour la location du bien « "+$O_Data.loc_bien_nom+" »"
			End if 
			
		End if 
		
		[Locations:84]LOC_Statut:17:=""
		
		// Modifié par : Scanu Rémy (05/05/2021)
		// Modification du champ LOC_Qualification
		[Locations:84]LOC_Qualification:21:=OB Get:C1224($O_Data; "loc_statut"; Est un texte:K8:3)
		
		READ ONLY:C145([HeBerge:4])
		QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Locations:84]LOC_HB_ID:3)
		
		If (Records in selection:C76([HeBerge:4])=1)
			[Locations:84]LOC_Usager_Prenom_Nom:16:=[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4
			//[Locations]LOC_Titre:=[Locations]LOC_Usager_Prenom_Nom+" / "+[Locations]LOC_Bien_Nom+" / "+Replace string(String([Locations]LOC_Date);"-";"/")
			[Locations:84]LOC_Titre:14:="Loyer"
		Else 
			[Locations:84]LOC_Titre:14:=""
			[Locations:84]LOC_Usager_Prenom_Nom:16:=""
			
			$status:="Failed"
			$continu:=False:C215
			
			$O_Output.notificationError:="L'enregistrement dans 4D de l'hébergé « "+String:C10([Locations:84]LOC_HB_ID:3)+" » n'a pas pu être trouvé"
		End if 
		
		If ([HeBerge:4]HB_Locataire:71=False:C215) | ([HeBerge:4]HB_Type_Locataire:70#"locataire")
			READ WRITE:C146([HeBerge:4])
			QUERY:C277([HeBerge:4]; [HeBerge:4]ID:65=[Locations:84]LOC_HB_ID:3)
			
			[HeBerge:4]HB_Locataire:71:=True:C214
			[HeBerge:4]HB_Type_Locataire:70:="locataire"
			SAVE RECORD:C53([HeBerge:4])
		End if 
		
		If ($continu)
			SAVE RECORD:C53($table->)
		End if 
		
	Else 
		$status:="Failed"
	End if 
	
End if 

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)