//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 06/12/18, 17:58:30
// ----------------------------------------------------
// Méthode : Maint_Get_Methodes_Exec_Serveur
// Description
// retuorne la liste des méthodes qui s'éxecutent coté serveur
//
// Paramètres
// ----------------------------------------------------
ARRAY TEXT:C222($tb_methodes; 0)
METHOD GET NAMES:C1166($tb_methodes)
C_OBJECT:C1216($object_attributes)
C_BOOLEAN:C305($executedOnServer; $publishedWeb; $publishedWsdl)

ARRAY TEXT:C222($tb_meth_exec_serveur; 0)
ARRAY TEXT:C222($tb_publishedWeb; 0)
ARRAY TEXT:C222($tb_publishedWsdl; 0)

For ($i; 1; Size of array:C274($tb_methodes))
	
	METHOD GET ATTRIBUTES:C1334($tb_methodes{$i}; $object_attributes)
	$executedOnServer:=OB Get:C1224($object_attributes; "executedOnServer"; Est un booléen:K8:9)
	$publishedWeb:=OB Get:C1224($object_attributes; "publishedWeb"; Est un booléen:K8:9)
	$publishedWsdl:=OB Get:C1224($object_attributes; "publishedWsdl"; Est un booléen:K8:9)
	
	If ($executedOnServer)
		APPEND TO ARRAY:C911($tb_meth_exec_serveur; $tb_methodes{$i})
	End if 
	
	If ($publishedWeb)
		APPEND TO ARRAY:C911($tb_publishedWeb; $tb_methodes{$i})
	End if 
	
	If ($publishedWsdl)
		APPEND TO ARRAY:C911($tb_publishedWsdl; $tb_methodes{$i})
	End if 
	
End for 

ALERT:C41("il existe "+String:C10(Size of array:C274($tb_meth_exec_serveur))+" méthodes qui s'exécutent côté serveur")
ALERT:C41("il existe "+String:C10(Size of array:C274($tb_publishedWeb))+" publiées en tant que web services")
ALERT:C41("il existe "+String:C10(Size of array:C274($tb_publishedWsdl))+" publiées en tant que Wsdl")