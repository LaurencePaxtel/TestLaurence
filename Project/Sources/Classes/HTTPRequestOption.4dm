/*------------------------------------------------------------------------------
Class : HTTPRequestOption

------------------------------------------------------------------------------*/

Class constructor($method_t : Text; $header_o : Object; $body_v : Variant)
/*------------------------------------------------------------------------------
Fonction : HTTPRequest.constructor
	
Génération de l'instance pour utiliser compléter la commmande 4D.HTTPRequest 
	
Historique
04/07/23 - Rémy Scanu <remy@connect-io.fr> - Création
------------------------------------------------------------------------------*/
	
	This:C1470.method:=$method_t
	This:C1470.headers:=$header_o
	This:C1470.body:=$body_v
	
Function onResponse($request_hr : 4D:C1709.HTTPRequest; $event_o : Object)
	//Méthode onResponse, si vous souhaitez traiter la requête de manière asynchrone
	
Function onError($request_hr : 4D:C1709.HTTPRequest; $event_o : Object)
	//Méthode onError, si vous souhaitez traiter la requête de manière asynchrone