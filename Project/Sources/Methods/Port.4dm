//%attributes = {}
// La méthode Port creates and read a setup file for 4D server 
// It allows the admin to modify listening settings
//
// #SYNTAX: $L_Erreur:=Port (->$B_Restart;->$T_Text_error)
// #PARAMETERS:
//     $0 Long            : code d'erreur. 1 = OK
//     $1 Pointeur        : Booleen Vrai le port à été changé
//     $2 Pointeur        : Texte message d'erreur

// #DATE CREATION: 25/10/2014  #AUTHOR: Bertrand SOUBEYRAND soub@soub.org
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_LONGINT:C283($0)  //  Erreur
C_POINTER:C301($1)  // booleen restart
C_POINTER:C301($2)  // text message

C_TEXT:C284($T_Message; $T_Path; $T_Json; $T_info)
C_LONGINT:C283($L_Port_CS; $L_Port_SQL; $L_Port_DB4D; $L_MyError; $L_Port_CS_current; $L_Port_SQL_current)
C_BOOLEAN:C305($B_Restart)
C_TIME:C306($H_Doc)
C_POINTER:C301($P_Restart; $P_Message)
C_OBJECT:C1216($O_Port_ecoute)

$P_Restart:=$1
$P_Message:=$2

$T_Path:=Get 4D folder:C485(Dossier Resources courant:K5:16; *)+"Parametrage port ecoute.txt"

$L_MyError:=1

If (Test path name:C476($T_Path)#Est un document:K24:1)
	$H_Doc:=Create document:C266($T_Path)
	
	If (OK=1)
		CLOSE DOCUMENT:C267($H_Doc)
		
		$L_Port_SQL:=Get database parameter:C643(Numéro de port Serveur SQL:K37:74)  // à partir de 4D v15
		$L_Port_CS:=Get database parameter:C643(Numéro du port client serveur:K37:35)
		$L_Port_DB4D:=$L_Port_CS+1
		
		OB SET:C1220($O_Port_ecoute; "sql server port id"; $L_Port_SQL)  // SQL Server: 19812 by default
		OB SET:C1220($O_Port_ecoute; "client server port id"; $L_Port_CS)  // Application Server: 19813 by default.
		OB SET:C1220($O_Port_ecoute; "db4d"; $L_Port_DB4D)  // DB4D Server(database server): 19814 by default . This port number cannot be modified directly
		OB SET:C1220($O_Port_ecoute; "info"; "DB4D is only for info")  // DB4D Server(database server): 19814 by default . This port number cannot be modified directly
		
		$T_Json:=JSON Stringify:C1217($O_Port_ecoute; *)
		TEXT TO DOCUMENT:C1237($T_Path; $T_Json)
		
		CLEAR VARIABLE:C89($O_Port_ecoute)
	End if 
	
End if 

Case of 
	: (Test path name:C476($T_Path)#Est un document:K24:1)
		$L_MyError:=-1
	Else 
		$T_Json:=Document to text:C1236($T_Path)
		$O_Port_ecoute:=JSON Parse:C1218($T_Json)
		
		$L_Port_SQL:=OB Get:C1224($O_Port_ecoute; "sql server port id")  // SQL Server: 19812 by default
		$L_Port_CS:=OB Get:C1224($O_Port_ecoute; "client server port id")  // Application Server: 19813 by default.
		
		$L_Port_CS_current:=Get database parameter:C643(Numéro du port client serveur:K37:35)
		$L_Port_SQL_current:=Get database parameter:C643(Numéro de port Serveur SQL:K37:74)
		
		If ($L_Port_CS_current#$L_Port_CS) | ($L_Port_SQL_current#$L_Port_SQL)
			SET DATABASE PARAMETER:C642(Numéro du port client serveur:K37:35; $L_Port_CS)
			SET DATABASE PARAMETER:C642(Numéro de port Serveur SQL:K37:74; $L_Port_SQL)
			
			$T_info:="Ports ID have been updated. Client/server: "+String:C10($L_Port_CS)+" and SQL "+String:C10($L_Port_SQL)+"\rServer needs to restart"
			$B_Restart:=True:C214
		Else 
			$T_info:="Ports ID remain unchanged"
		End if 
		
End case 

Case of 
	: ($L_MyError=-1)
		$T_Message:="Setup file unavailable"
	Else 
		$T_Message:=$T_info
End case 

$P_Restart->:=$B_Restart
$P_Message->:=$T_Message

$0:=$L_MyError