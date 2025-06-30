Case of 
	: (Form event code:C388=Sur clic:K2:4)
		SET DATABASE PARAMETER:C642(Numéro du port client serveur:K37:35; Round:C94(Num:C11(Form:C1466.portNumber4D); 0))
		SET DATABASE PARAMETER:C642(Numéro du port:K37:15; Round:C94(Num:C11(Form:C1466.portNumberWeb); 0))
		
		ALERT:C41("Le Serveur 4D va redémarrer")
		RESTART 4D:C1292
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 