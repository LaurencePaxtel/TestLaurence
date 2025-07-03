//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 19/10/18, 08:30:33
// ----------------------------------------------------
// Méthode : Web_Connexion
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text
var $2 : Text
var $3 : Text
var $4 : Text
var $5 : Text
var $6 : Text

var $action_t : Text
var $societe_o; $statut_o : Object

var $intervenant_e : cs:C1710.INtervenantsEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

var w_userIp; w_message; w_userNom; w_structure; w_titre; w_userPreferences; TitrePages; w_cookie : Text
var w_userUID; error : Integer
var w_post; w_get; user_collaborateur; user_interlocuteur; w_connected; w_FirstAccess : Boolean

var $state_o; $return_o : Object

ARRAY TEXT:C222(w_variables; 0)
ARRAY TEXT:C222(w_valeurs; 0)

ARRAY TEXT:C222($tb_params_additional; 0)

If (Session:C1714.storage.intervenant=Null:C1517)
	Use (Session:C1714.storage)
		Session:C1714.storage.intervenant:=New shared object:C1526()
		Session:C1714.storage.societe:=New shared object:C1526()
	End use 
End if 


$societe_o:=New object:C1471

If ($1#"@.js") & ($1#"@jpg") & ($1#"@.png") & ($1#"@.css") & ($1#"@.map") & ($1#"@.txt") & ($1#"@.ico")
	000_Init
	
	w_url:=$1
	w_userIp:=$3
	w_HostIp:=$4
	
	READ ONLY:C145(*)
	
	w_connected:=False:C215
	UTL_Decoupe_texte(->w_url; ->$tb_params_additional; "/")
	Case of 
		: (w_url="/REST/@")
		Else 
			UTL_preprocess  // cookie;w_action;w_parametres;w_variables;w_valeurs;w_post;w_get
			
			If (w_cookie="")
				w_cookie:=String:C10(Random:C100)+String:C10(Random:C100)+String:C10(Random:C100)+"."+String:C10(Milliseconds:C459)
				UTL_cookieSet(w_cookie)
			Else 
				READ ONLY:C145([INtervenants:10])
				QUERY:C277([INtervenants:10]; [INtervenants:10]ID:16=Session:C1714.storage.intervenant.ID)
				
				
				If (Records in selection:C76([INtervenants:10])=1)
					w_connected:=True:C214
					user_collaborateur:=True:C214
					
					//Web_User_Get_privileges
					
					// Modifié par : Scanu Rémy (22/07/2024)
					// Création méthode générique pour initialiser des propriétés de l'objet w_visiteur et des variables
					outilsWebVisiteurInit(w_cookie)
					
					WebAGL_Init
					
					WebAGL_Gere_Structures(w_userUID)
					
					// Modifié par : Scanu Rémy (22/09/2023)
					// Ajout script et css DataTable pour la gestion des plateformes
					UTL_Add_Script("iw_datatable")
					Web_UTL_Add_CSS("iw_datatable")
				End if 
				
				UNLOAD RECORD:C212([INtervenants:10])
				
				If (Not:C34(Semaphore:C143(w_cookie; 60)))
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
					
					CLEAR SEMAPHORE:C144(w_cookie)
				Else 
					w_mess:="Erreur lors du traitement du formulaire"
				End if 
				
			End if 
			
			SOC_Get_Config
			WEB_MAIN_MENU_TOP
			
			If (Not:C34(w_connected))
				outilsWebPageConnexion
			Else 
				$action_t:=WEB_UTL_GET_PARAMS("action")
				
				If ($action_t="") && ($1="/")
					//WEB ENVOYER REDIRECTION HTTP("/INT?action=usager-list")
					WEB SEND HTTP REDIRECT:C659("/home")
					return 
				End if 
				
				If ($action_t#"get_json@")
					Web_Init
				End if 
				
				Case of 
					: (w_action="/session/centre")
						Web_JSON_Get_Centres_List("checkbox"; {titrePopup: "Prestations"; prestation: False:C215; plateforme: Session:C1714.storage.intervenant.Plateforme})
						
					: (w_action="/session/enumeration")
						WEB SEND TEXT:C677(JSON Stringify:C1217(Session:C1714.storage.enumeration; *))
						
					: (w_action="/session/intervenant")
						WEB SEND TEXT:C677(JSON Stringify:C1217(Session:C1714.storage.intervenant; *))
						
						
					: (w_action="/home")
						WEB SEND FILE:C619(Folder:C1567(fk dossier racine web:K87:15).file("usager/browser/index.html").platformPath)
						// Pointe vers le même fichier que http://localhost:8045/usager/page
						
					: (w_action="/statistiques/@")
						Case of 
							: (w_action="@page@")
								// Exemple de requete : http://localhost:8045/statistiques/page
								// Affichage de la page des statistiques.
								WEB SEND FILE:C619(Folder:C1567(fk dossier racine web:K87:15).file("statistique/browser/index.html").platformPath)
							: (w_action="@generer@")
								// Exemple de requete : http://localhost:8045/statistiques/generer?query={"filtreRecherche":{"HG_DateMin":"2024-01-01","HG_DateMax":"2024-12-31","HG_Nuit":false,"HG_Cloturée":true},"dataRetour":["HG_Date","HG_Nom","HG_Prénom","HG_DateNéLe","HG_FamClé","HG_FamChef","HG_Age","HG_EtatCivil"],"typeGraph":"Bar","statistiqueComptage":"personne","statistiqueFicheUnique":false,"statistiqueType":"tranches d’âges"}
								$return_o:=ds:C1482.HeberGement.statistiqueGenerer(JSON Parse:C1218(WEB_UTL_GET_PARAMS("query")))
								WEB SEND TEXT:C677(JSON Stringify:C1217($return_o))
								
							: (w_action="@delete@")
								// Exemple de requete : http://localhost:8045/statistiques/delete?ID=4
								$state_o:=ds:C1482.HebergementRechercheModele.delete(Num:C11(WEB_UTL_GET_PARAMS("ID")))
								WEB SEND TEXT:C677(JSON Stringify:C1217($state_o; *))
							: (w_action="@list@")
								// Exemple de requete : http://localhost:8045/statistiques/list
								$state_o:=ds:C1482.HebergementRechercheModele.list("statistique")
								WEB SEND TEXT:C677(JSON Stringify:C1217($state_o; *))
							: (w_action="@read@")
								// Exemple de requete : http://localhost:8045/statistiques/read?ID=4
								$state_o:=ds:C1482.HebergementRechercheModele.read(Num:C11(WEB_UTL_GET_PARAMS("ID")))
								WEB SEND TEXT:C677(JSON Stringify:C1217($state_o; *))
							: (w_action="@update@")
								// Exemple de requete : http://localhost:8045/statistiques/update?ID=4&statParam={"affichageNom":"état civil","filtreRecherche":{"HG_DateMin":"2024-06-01","HG_DateMax":"2024-11-26","HG_Cloturée":true,"HG_Nuit":true, "HG_CentreNom":["13LGV-HUDA-Accompagnement extérieur", "13LGV-HUDA-Concertation Partenaire"],"HG_EtatCivil":["Femme seule (FS)" , "Femme avec 1 enfant (FE)"]},"dataRetour":["HG_Date","HG_Nom","HG_Prénom","HG_DateNéLe","HG_FamClé","HG_EtatCivil","HG_FamGroupe"],"typeGraph":"Bar","statistiqueComptage":"personne","statistiqueType":"HG_FamGroupe","statistiqueFicheUnique":true}
								$state_o:=ds:C1482.HebergementRechercheModele.update(Num:C11(WEB_UTL_GET_PARAMS("ID")); JSON Parse:C1218(WEB_UTL_GET_PARAMS("statParam")))
								WEB SEND TEXT:C677(JSON Stringify:C1217($state_o; *))
						End case 
						
					: (w_action="/usager/@")
						Case of 
							: (w_action="@page@")
								// Exemple de requete : http://localhost:8045/usager/page
								// Affichage de la page des statistiques.
								WEB SEND FILE:C619(Folder:C1567(fk dossier racine web:K87:15).file("usager/browser/index.html").platformPath)
							: (w_action="@generer@")
								// Exemple de requete : http://localhost:8045/usager/generer?query={"filtreRecherche":{"HG_DateMin":"2024-01-01","HG_DateMax":"2024-12-31","HG_Nuit":false,"HG_Cloturée":true},"dataRetour":["HG_Date","HG_Nom","HG_Prénom","HG_DateNéLe","HG_FamClé","HG_FamChef","HG_Age","HG_EtatCivil"],"typeGraph":"Bar","statistiqueComptage":"personne","statistiqueFicheUnique":false,"statistiqueType":"tranches d’âges"}
								$return_o:=ds:C1482.HeberGement.listeUsager(JSON Parse:C1218(WEB_UTL_GET_PARAMS("query")))
								WEB SEND TEXT:C677(JSON Stringify:C1217($return_o))
								
							: (w_action="@delete@")
								// Exemple de requete : http://localhost:8045/usager/delete?ID=4
								$state_o:=ds:C1482.HebergementRechercheModele.delete(Num:C11(WEB_UTL_GET_PARAMS("ID")))
								WEB SEND TEXT:C677(JSON Stringify:C1217($state_o; *))
							: (w_action="@list@")
								// Exemple de requete : http://localhost:8045/usager/list
								$state_o:=ds:C1482.HebergementRechercheModele.list("usager")
								WEB SEND TEXT:C677(JSON Stringify:C1217($state_o; *))
							: (w_action="@read@")
								// Exemple de requete : http://localhost:8045/usager/read?ID=4
								$state_o:=ds:C1482.HebergementRechercheModele.read(Num:C11(WEB_UTL_GET_PARAMS("ID")))
								WEB SEND TEXT:C677(JSON Stringify:C1217($state_o; *))
							: (w_action="@update@")
								// Exemple de requete : http://localhost:8045/usager/update?ID=4&statParam={"affichageNom":"état civil","filtreRecherche":{"HG_DateMin":"2024-06-01","HG_DateMax":"2024-11-26","HG_Cloturée":true,"HG_Nuit":true, "HG_CentreNom":["13LGV-HUDA-Accompagnement extérieur", "13LGV-HUDA-Concertation Partenaire"],"HG_EtatCivil":["Femme seule (FS)" , "Femme avec 1 enfant (FE)"]},"dataRetour":["HG_Date","HG_Nom","HG_Prénom","HG_DateNéLe","HG_FamClé","HG_EtatCivil","HG_FamGroupe"],"typeGraph":"Bar","statistiqueComptage":"personne","statistiqueType":"HG_FamGroupe","statistiqueFicheUnique":true}
								$state_o:=ds:C1482.HebergementRechercheModele.update(Num:C11(WEB_UTL_GET_PARAMS("ID")); JSON Parse:C1218(WEB_UTL_GET_PARAMS("statParam")))
								WEB SEND TEXT:C677(JSON Stringify:C1217($state_o; *))
								
						End case 
						
						
					: (w_action="/login@")
						//WEB ENVOYER REDIRECTION HTTP("/INT?action=usager-list&login=true")
						WEB SEND HTTP REDIRECT:C659("/home&login=true")
					: (w_structure="")
						WebAGL_ChoixStructure
					: (w_action="/USR@")
						w_titre:="Planning"
						Web_USR_Controller
					: (w_action="/INT@")
						w_titre:="Liste des usagers"
						Web_Controller_Usager
					: (w_action="/GL@")
						w_titre:="Gestion immobilière"
						Web_Controller_GL
					: (w_action="/GB@")
						w_titre:=""
						Web_Controller_Global
					: (w_action="@get_json@")
						Web_Controller_Usager
					: (w_action="@getjson@")
					: (w_action="")
						
						If (w_connected)
							w_titre:=LANG_TXT_HOME
							HTML_NAME_MODULE:=LANG_TXT_HOME
							
							If (w_url="/deconnexion")
								$intervenant_es:=ds:C1482.INtervenants.query("IN_Cookie = :1"; w_cookie)
								
								If ($intervenant_es.length>0)
									$intervenant_e:=$intervenant_es.first()
									
									$intervenant_e.IN_Cookie:=""
									$statut_o:=$intervenant_e.save()
								End if 
								
								WEB SEND HTTP REDIRECT:C659("/home")
							End if 
							
							//WEB ENVOYER REDIRECTION HTTP("/INT?action=usager-list")
							WEB SEND HTTP REDIRECT:C659("/home")
						Else 
							WEB SEND HTTP REDIRECT:C659("/login")
						End if 
						
					: (w_action="/NAV")  // navigateur principal 
						// NAV_WEB_Controller
					: (w_action="/home@")
						
						If (w_connected)
							WEB_logout
						Else 
							WEB SEND HTTP REDIRECT:C659("/login")
						End if 
						
					: (w_action="/deconnexion")
						
						If (w_connected)
							WEB_logout
						Else 
							WEB SEND HTTP REDIRECT:C659("/login")
						End if 
						
					: (w_action="favicon.ico")
						WEB_UTL_page("favicon.ico")
					Else 
						ARRAY TEXT:C222(web_tabChamps; 0)
						ARRAY TEXT:C222(web_tabValeurs; 0)
						
						APPEND TO ARRAY:C911(web_tabChamps; "Proxy-Connection")
						APPEND TO ARRAY:C911(web_tabValeurs; "close")
						APPEND TO ARRAY:C911(web_tabChamps; "Cache-Control")
						APPEND TO ARRAY:C911(web_tabValeurs; "private, x-gzip-ok=\"\"")  // "no-cache"
						APPEND TO ARRAY:C911(web_tabChamps; "Expires")
						APPEND TO ARRAY:C911(web_tabValeurs; "Wed, 23 Aug 2017 00:00:00 GMT")
						APPEND TO ARRAY:C911(web_tabChamps; "X-STATUS")
						APPEND TO ARRAY:C911(web_tabValeurs; "404 Not Found")
						APPEND TO ARRAY:C911(web_tabChamps; "Server")
						APPEND TO ARRAY:C911(web_tabValeurs; "Microsoft-IIS/8")
						
						WEB SET HTTP HEADER:C660(web_tabChamps; web_tabValeurs)
						
						If (Position:C15("script"; w_url)#0)
							//UTL_Log("hacker XSS")
						End if 
						
						WEB_message("erreur"; "404: Document non trouvé : "+w_url)
				End case 
				
			End if 
			
	End case 
	
End if 
