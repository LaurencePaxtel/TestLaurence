// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 15/09/18, 05:42:11
// ----------------------------------------------------
// Méthode : Login_utilisateur
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $user_o : Object

var $loginMemo_e : cs:C1710.LoginMemoEntity
var $loginMemo_es : cs:C1710.LoginMemoSelection

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var try; Memo_login : Integer
		
		The_PW:=""
		The_Login:=""
		
		try:=0
		Memo_login:=0
		
		// Modifié par : Scanu Rémy (17/07/2023)
		// Sauvegarde du login par nom de machine / nom de session et plus par nom de machine uniquement
		$user_o:=Get system info:C1571
		$loginMemo_es:=ds:C1482.LoginMemo.query("machine = :1 AND session = :2"; $user_o.machineName; $user_o.accountName)
		
		If ($loginMemo_es.length>0)
			$loginMemo_e:=$loginMemo_es.first()
			
			The_Login:=$loginMemo_e.login
			Memo_login:=1
		End if 
		
		outilsStructureSearchWithLogin(The_Login)
		OBJECT SET FONT:C164(The_PW; "%password")
		
		If (The_Login#"")
			GOTO OBJECT:C206(The_PW)
		End if 
		
End case 