//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 20/09/22, 16:09:18
// ----------------------------------------------------
// Méthode : outilsWebOpenPlanning
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)

C_TEXT:C284($ip_address; $port_web)
C_TEXT:C284(w_cookie)

var $structure_e : cs:C1710.StructuresEntity

READ WRITE:C146([INtervenants:10])
QUERY:C277([INtervenants:10]; [INtervenants:10]IN_Login:3=<>User_Actif_Login)

SOC_Get_Config
$ip_address:=UTL_Get_Server_Info("ip")

If (SO_Serveur_IP#"")
	$ip_address:=SO_Serveur_IP
End if 

If (SO_Serveur_Port_Web#"")
	$port_web:=SO_Serveur_Port_Web
End if 

If (Records in selection:C76([INtervenants:10])=1)
	
	If ([INtervenants:10]IN_Cookie:18="")
		w_cookie:=String:C10(Random:C100)+String:C10(Random:C100)+String:C10(Random:C100)+"."+String:C10(Milliseconds:C459)
		
		[INtervenants:10]IN_Cookie:18:=w_cookie
		SAVE RECORD:C53([INtervenants:10])
	Else 
		w_cookie:=[INtervenants:10]IN_Cookie:18
	End if 
	
	READ WRITE:C146([Preferences:81])
	
	QUERY:C277([Preferences:81]; [Preferences:81]PREF_Type:2="session"; *)
	QUERY:C277([Preferences:81];  & ; [Preferences:81]PREF_Value_1:3=w_cookie)
	
	If (Records in selection:C76([Preferences:81])=0)
		CREATE RECORD:C68([Preferences:81])
		[Preferences:81]PREF_Type:2:="session"
		[Preferences:81]PREF_Value_1:3:=w_cookie
		[Preferences:81]PREF_Value_2:4:=String:C10((Random:C100)%9000+1000)
		SAVE RECORD:C53([Preferences:81])
		UNLOAD RECORD:C212([Preferences:81])
	End if 
	
	UNLOAD RECORD:C212([INtervenants:10])
	UNLOAD RECORD:C212([Preferences:81])
	
	READ ONLY:C145([INtervenants:10])
	READ ONLY:C145([Preferences:81])
	
	If (Count parameters:C259=1)
		OPEN URL:C673("http://"+$ip_address+"/USR?action=planning&strc="+<>user_uid_entreprise+"&hebergeReferenceID="+String:C10($1)+"&session="+w_cookie)
	Else 
		OPEN URL:C673("http://"+$ip_address+"/USR?action=planning&strc="+<>user_uid_entreprise+"&session="+w_cookie)
	End if 
	
Else 
	$structure_e:=ds:C1482.Structures.get(<>user_uid_entreprise)
	CONFIRM:C162("L'intervenant(e) avec le login "+<>User_Actif_Login+" n' a pas pu être trouvé(e) dans la base de donnée."+Char:C90(Retour à la ligne:K15:40)+"Voulez-vous ouvrir le planning de la structure "+$structure_e.STRC_Nom+" ?"; "Oui"; "Non")
	
	If (OK=1)
		OPEN URL:C673("http://"+$ip_address+"/USR?action=planning&strc="+<>user_uid_entreprise)
	End if 
	
End if 