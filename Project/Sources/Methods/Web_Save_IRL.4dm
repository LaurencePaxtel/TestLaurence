//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 17-12-18, 00:04:35
// ----------------------------------------------------
// Method: Web_Save_IRL
// Description
// 
//
// Parameters
// ----------------------------------------------------
var $1 : Pointer
var $2 : Text

var $libelle; $Status : Text
var $id : Integer
var $continu : Boolean
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

EXECUTE FORMULA:C63("champRef_p:=->["+Table name:C256($table)+"]id")
READ WRITE:C146($table->)

If ($id#0)
	
	// Clé : "année + trimestre"
	// Vérification pour éviter d'avoir des valeurs dupliquées
	QUERY:C277([IRL_CONFIG:85]; [IRL_CONFIG:85]IRC_Annee:4=Num:C11(OB Get:C1224($O_Data; "irc_annee"; Est un texte:K8:3)); *)
	QUERY:C277([IRL_CONFIG:85];  & ; [IRL_CONFIG:85]IRC_Trimestre:3=Num:C11(OB Get:C1224($O_Data; "irc_trimestre"; Est un texte:K8:3)); *)
	
	QUERY:C277($table->;  & ; champRef_p->#$id)
	MultiSoc_Filter(->[IRL_CONFIG:85])
	
	If (Records in selection:C76($table->)=0)
		QUERY:C277($table->; champRef_p->=$id)
		MultiSoc_Filter(->[IRL_CONFIG:85])
		
		
		If (Records in selection:C76($table->)=1)
			
			If (Locked:C147($table->))
				$continu:=False:C215
			End if 
			
		Else 
			$continu:=False:C215
		End if 
		
	Else 
		$continu:=False:C215
	End if 
	
Else 
	
	// Clé : "année + trimestre"
	// Vérification pour éviter d'avoir des valeurs dupliquées
	QUERY:C277([IRL_CONFIG:85]; [IRL_CONFIG:85]IRC_Annee:4=Num:C11(OB Get:C1224($O_Data; "irc_annee"; Est un texte:K8:3)); *)
	QUERY:C277([IRL_CONFIG:85];  & ; [IRL_CONFIG:85]IRC_Trimestre:3=Num:C11(OB Get:C1224($O_Data; "irc_trimestre"; Est un texte:K8:3)))
	MultiSoc_Filter(->[IRL_CONFIG:85])
	
	If (Records in selection:C76([IRL_CONFIG:85])=0)
		CREATE RECORD:C68($table->)
		MultiSoc_Init_Structure($table)
		$id:=champRef_p->
	Else 
		$continu:=False:C215
	End if 
	
End if 

If ($continu)
	APPEND TO ARRAY:C911($tb_restricted; "id")
	
	Web_AGL_Json_To_Record($table; ->$O_Data; ->$tb_restricted)
	SAVE RECORD:C53($table->)
Else 
	$status:="Failed"
End if 

OB SET:C1220($O_Output; "Status"; $status)
$T_Json:=JSON Stringify:C1217($O_Output)

WEB SEND TEXT:C677($T_Json)