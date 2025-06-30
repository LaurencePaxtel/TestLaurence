/*------------------------------------------------------------------------------
Class : cs.LDAP

Class de gestion d'une connexion LDAP

------------------------------------------------------------------------------*/
Class constructor
	This:C1470.url:=""
	This:C1470.login:=""
	This:C1470.password:=""
	
	This:C1470.entryPoint:=""
	
	This:C1470.loginError:=True:C214
	
Function searchEmailInHostBase($tableHost_p : Pointer; $fieldTableHost_p : Pointer; $email_t : Text)->$entitySelection_o : Object
	var $tableName_t; $fieldName_t; $chaineAvantArobase_t; $chaineApresArobase_t : Text
	var $continue_b; $premiereChaineValide_b; $deuxiemeChaineValide_b : Boolean
	var $table_o; $enregistrement_o : Object
	
	$tableName_t:=Table name:C256($tableHost_p)
	$fieldName_t:=Field name:C257($fieldTableHost_p)
	
	$table_o:=ds:C1482[$tableName_t].query($fieldName_t+" = :1"; $email_t)
	$entitySelection_o:=ds:C1482[$tableName_t].newSelection()
	
	$chaineAvantArobase_t:=Substring:C12($email_t; 0; Position:C15(Char:C90(Arobase:K15:46); $email_t)-1)
	$chaineApresArobase_t:=Substring:C12($email_t; Position:C15(Char:C90(Arobase:K15:46); $email_t)+1; Length:C16($email_t))
	
	For each ($enregistrement_o; $table_o) Until ($continue_b=True:C214)
		$emailVerifAvantArobase_t:=Substring:C12($enregistrement_o[$fieldName_t]; 0; Position:C15("@"; $enregistrement_o[$fieldName_t])-1)
		
		If ($emailVerifAvantArobase_t=$chaineAvantArobase_t)
			$premiereChaineValide_b:=True:C214
		End if 
		
		$emailVerifApresArobase_t:=Substring:C12($enregistrement_o[$fieldName_t]; Position:C15(Char:C90(Arobase:K15:46); $enregistrement_o[$fieldName_t])+1; Length:C16($enregistrement_o[$fieldName_t]))
		
		If ($emailVerifApresArobase_t=$chaineApresArobase_t)
			$deuxiemeChaineValide_b:=True:C214
		End if 
		
		$continue_b:=($premiereChaineValide_b=True:C214) & ($deuxiemeChaineValide_b=True:C214)
		
		If ($continue_b=True:C214)
			$entitySelection_o.add($enregistrement_o)
		End if 
		
		outilsCleanVariable(->$premiereChaineValide_b; ->$deuxiemeChaineValide_b)
	End for each 
	
Function setLDAPInformation($url_t : Text; $login_t : Text; $password_t : Text)
	This:C1470.url:=$url_t
	This:C1470.login:=$login_t
	This:C1470.password:=$password_t
	
Function setLDAPEntryPoint($entryPoint_t : Text)
	This:C1470.entryPoint:=$entryPoint_t
	
Function connectionToServer($passwordDigest_el : Integer)
	var LDAPErrorLogin_b : Boolean
	
	ON ERR CALL:C155("outilsLDAPLoginCatchError")
	LDAPErrorLogin_b:=False:C215
	
	LDAP LOGIN:C1326(This:C1470.url; This:C1470.login; This:C1470.password; $passwordDigest_el)
	This:C1470.loginError:=LDAPErrorLogin_b
	
	ON ERR CALL:C155("")
	
Function searchInLDAPServer($filtre_t : Text; $attribut_c : Collection)->$result_c : Collection
	ARRAY TEXT:C222($attribut_at; 0)
	ARRAY BOOLEAN:C223($attribut_ab; 0)
	
	ARRAY OBJECT:C1221($entry_ao; 0)
	
	$result_c:=New collection:C1472
	
	If (This:C1470.loginError=False:C215) & (This:C1470.entryPoint#"")
		COLLECTION TO ARRAY:C1562($attribut_c; $attribut_at; "name"; $attribut_ab; "booleanValue")
		LDAP SEARCH ALL:C1329(This:C1470.entryPoint; $entry_ao; $filtre_t; LDAP tous niveaux:K83:3; $attribut_at; $attribut_ab)
		
		ARRAY TO COLLECTION:C1563($result_c; $entry_ao)
	End if 
	
Function disconnectionToServer()
	LDAP LOGOUT:C1327
	