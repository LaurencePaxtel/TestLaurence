//%attributes = {}
// La méthode Update gère le numéro de version de l'application ainsi que les diverses MAJ du fichier de données.
// La méthode est a exécuter dans les méthodes base:
//    - sur demarrage du serveur
//    - sur demarrage du client (pour lire la version sur le serveur)
//    - sur demarrage (d'un 4D mono)
//
// #SYNTAX: Update 
// #PARAMETERS:
//     Aucun
//
// #DATE CREATION: 02/07/2014  #AUTHOR: Bertrand SOUBEYRAND soub@soub.org
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_TEXT:C284($T_File; $T_Text_Error; $T_Message)
C_LONGINT:C283($L_MyError; $L_Build_data; $L_Max)
C_REAL:C285($L_Old)

Case of 
	: (Application type:C494=4D Server:K5:6) | (Application type:C494=4D mode local:K5:1) | (Application type:C494=4D Volume Desktop:K5:2)
		C_TEXT:C284(<>T_VersionDB__C)  // #Fix20170424-4
		C_LONGINT:C283(<>L_Build_number_C)  // #Fix20170424-4
		
		<>L_Build_number_C:=2138  // c'est le numéro utilisé pour mettre à jour le data
		<>T_VersionDB__C:="Version 2.0 Build "+String:C10(<>L_Build_number_C)+" 17/01/2024"
		
		$L_MyError:=1
		$T_File:="LOG_Version_update.txt"
		
		// Met à jour le data du client en fonction de la built de la structure
		// Si le client a plusieurs built de retard, toutes les mises à jour sont exécutées successivement
		If (Records in table:C83([BUILT:72])=0)
			CREATE RECORD:C68([BUILT:72])
			MultiSoc_Init_Structure(->[BUILT:72])
			
			[BUILT:72]Built_number_I:2:=999
			[BUILT:72]Date_update_D:3:=Current date:C33
			SAVE RECORD:C53([BUILT:72])
			
			UNLOAD RECORD:C212([BUILT:72])
		End if 
		
		ALL RECORDS:C47([BUILT:72])
		MultiSoc_Filter(->[BUILT:72])
		
		$L_Build_data:=[BUILT:72]Built_number_I:2
		
		If ($L_Build_data><>L_Build_number_C)
			$L_Build_data:=<>L_Build_number_C
			
			[BUILT:72]Built_number_I:2:=$L_Build_data
			SAVE RECORD:C53([BUILT:72])
		End if 
		
		If ($L_Build_data#<>L_Build_number_C)
			READ WRITE:C146([BUILT:72])
			
			Case of 
				: (4DREC_Load_Record(->[BUILT:72]; ->$T_Text_Error)#1)
					$L_MyError:=-1
				Else 
					
					While ($L_Build_data#<>L_Build_number_C)
						$L_Build_data:=$L_Build_data+1
						
						Case of 
							: ($L_Build_data=1008)
								ALL RECORDS:C47([TablesDemande:17])
								MultiSoc_Filter(->[TablesDemande:17])
								
								$L_Max:=Max:C3([TablesDemande:17]ID:5)+1
								
								SET DATABASE PARAMETER:C642([TablesDemande:17]; Numéro automatique table:K37:31; $L_Max)
								REDUCE SELECTION:C351([TablesDemande:17]; 0)
							: ($L_Build_data=1030)
								ALL RECORDS:C47([TypesTables:11])  // #Fix20170504-2
								MultiSoc_Filter(->[TypesTables:11])
								
								$L_Max:=Max:C3([TypesTables:11]ID:5)+1
								
								SET DATABASE PARAMETER:C642([TypesTables:11]; Numéro automatique table:K37:31; $L_Max)
								REDUCE SELECTION:C351([TypesTables:11]; 0)
							: ($L_Build_data=1034)
								ALL RECORDS:C47([DePart:1])  // #Fix20170517-2
								MultiSoc_Filter(->[DePart:1])
								
								$L_Max:=Max:C3([DePart:1]ID:9)+1
								$L_Old:=Get database parameter:C643([DePart:1]; Numéro automatique table:K37:31)
								
								SET DATABASE PARAMETER:C642([DePart:1]; Numéro automatique table:K37:31; $L_Max)
								REDUCE SELECTION:C351([DePart:1]; 0)
						End case 
						
						[BUILT:72]Built_number_I:2:=$L_Build_data
						SAVE RECORD:C53([BUILT:72])
					End while 
					
					READ ONLY:C145([BUILT:72])
			End case 
			
		End if 
		
		UNLOAD RECORD:C212([BUILT:72])
		
		Case of 
			: ($L_MyError=-1)
				$T_Message:="L'enregistrement de "+Table name:C256(->[BUILT:72])+" est verrouillé"
			Else 
				$T_Message:="OK"
		End case 
		
		Log_mensuel(True:C214; $T_Message; $T_File)
	Else   //  4D Remote Mode
		GET PROCESS VARIABLE:C371(-1; <>L_Build_number_C; <>L_Build_number_C)
		GET PROCESS VARIABLE:C371(-1; <>T_VersionDB__C; <>T_VersionDB__C)
End case 