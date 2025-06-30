//%attributes = {"shared":true}
/*------------------------------------------------------------------------------
Méthode : cuFingerOnButton

Change le curseur de la sourie en doigt au survol de l'objet.

Historique
12/04/22 - Grégory Fromain <gregory@connect-io.fr> - creation
------------------------------------------------------------------------------*/


If (Form event code:C388=On Mouse Move:K2:35)
	SET CURSOR:C469(9000)  // Pointeur clic
End if 