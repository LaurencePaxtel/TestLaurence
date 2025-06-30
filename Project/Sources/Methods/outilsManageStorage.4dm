//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 05/04/23, 16:50:21
// ----------------------------------------------------
// Méthode : outilsManageStorage
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Text

var $i_el; $j_el : Integer
var $image_i : Picture
var $blob_b : Blob
var $image_o; $dossier_o; $fichier_o; $info_o; $enregistrement_o : Object

Case of 
	: ($1="structure")  // Fixer le détail de la structure
		
		Use (Storage:C1525)
			Storage:C1525.structureDetail:=New shared collection:C1527
		End use 
		
		For ($i_el; 1; Get last table number:C254)
			
			If (Is table number valid:C999($i_el)=True:C214)
				$info_o:=New object:C1471("table"; Table name:C256($i_el); "champ"; New collection:C1472)
				
				For ($j_el; 1; Get last field number:C255($i_el))
					
					If (Is field number valid:C1000($i_el; $j_el)=True:C214)
						$info_o.champ.push(Field name:C257($i_el; $j_el))
					End if 
					
				End for 
				
				Use (Storage:C1525.structureDetail)
					Storage:C1525.structureDetail.push(OB Copy:C1225($info_o; ck shared:K85:29; Storage:C1525.structureDetail))
				End use 
				
			End if 
			
		End for 
		
	: ($1="image")  // Fixer les images
		$image_o:=New object:C1471()
		$dossier_o:=Folder:C1567(Get 4D folder:C485(Dossier Resources courant:K5:16)+"Images"+Séparateur dossier:K24:12+"cio"+Séparateur dossier:K24:12; fk chemin plateforme:K87:2)
		
		Use (Storage:C1525)
			Storage:C1525.image:=New shared object:C1526
		End use 
		
		For each ($fichier_o; $dossier_o.files(fk ignorer invisibles:K87:22))
			$blob_b:=$fichier_o.getContent()
			
			BLOB TO PICTURE:C682($blob_b; $image_i)
			
			Use (Storage:C1525.image)
				Storage:C1525.image[$fichier_o.name]:=$image_i
			End use 
			
		End for each 
		
	: ($1="societe")  // Fixer le détail de la societe
		
		If (Records in selection:C76([SOciete:18])>0)
			
			Use (Storage:C1525)
				Storage:C1525.societeDetail:=New shared object:C1526
				
				Use (Storage:C1525.societeDetail)
					Storage:C1525.societeDetail.nom:=[SOciete:18]SO_Libel01:3
					
					Storage:C1525.societeDetail.direction:=New shared object:C1526(\
						"civilite"; [SOciete:18]SO_Direction:128.civilite; \
						"nom"; [SOciete:18]SO_Direction:128.nom; \
						"prenom"; [SOciete:18]SO_Direction:128.prenom)
					
					Storage:C1525.societeDetail.telephone:=[SOciete:18]SO_Telephone:115
					Storage:C1525.societeDetail.email:=[SOciete:18]SO_Email:116
					
					Storage:C1525.societeDetail.adresse:=[SOciete:18]SO_Libel02:4
					Storage:C1525.societeDetail.adresseComplement:=[SOciete:18]SO_Libel03:5
					
					Storage:C1525.societeDetail.codePostal:=[SOciete:18]SO_CodePostal:75
					Storage:C1525.societeDetail.ville:=[SOciete:18]SO_Ville:76
					Storage:C1525.societeDetail.site:=[SOciete:18]SO_Site:8
					Storage:C1525.societeDetail.rechercheUsagerManuel:=[SOciete:18]SO_RechercheUsagerManuel:137
					Storage:C1525.societeDetail.participationWeb:=[SOciete:18]SO_ParticipationWeb:142
					Storage:C1525.societeDetail.codeCentre:=[SOciete:18]SO_CodeCentre:23
					Storage:C1525.societeDetail.ModeCHRS:=[SOciete:18]SO_ModeCHRS:17
					outilsOrdaSearchSimple("Structures"; "Ref_Structure"; [SOciete:18]Ref_Structure:97; ->$enregistrement_o; "first")
					
					If ($enregistrement_o#Null:C1517)
						$image_i:=$enregistrement_o.STRC_Logo
					End if 
					
					Storage:C1525.societeDetail.logo:=$image_i
					Storage:C1525.societeDetail.signatureElectronique:=[SOciete:18]SO_SignatureElectronique:130
					Storage:C1525.societeDetail.Ref_Structure:=[SOciete:18]Ref_Structure:97
				End use 
				
			End use 
			
		End if 
		
	: ($1="intervenant") && (Records in selection:C76([INtervenants:10])>0)  // Fixer le détail de l'intervenant
		Use (Storage:C1525)
			Storage:C1525.intervenantsDetail:=New shared object:C1526
		End use 
		
		Use (Storage:C1525.intervenantsDetail)
			Storage:C1525.intervenantsDetail.ProfUser:=Substring:C12(<>ta_Types{[INtervenants:10]IN_Type:2}; 5)  // equivant <>va_ProfUser
			Storage:C1525.intervenantsDetail.User:=[INtervenants:10]IN_Prénom:5+" "+[INtervenants:10]IN_Nom:4  // equivant <>va_User
			Storage:C1525.intervenantsDetail.UserCourant:=[INtervenants:10]IN_Login:3  // equivant <>va_UserCourant
			Storage:C1525.intervenantsDetail.UserRéfU:=[INtervenants:10]IN_RéférenceID:1  // equivant <>vl_UserRéfU
			Storage:C1525.intervenantsDetail.UserLogRéfU:=[INtervenants:10]IN_RéfUser:11  // equivant <>vl_UserLogRéfU
			Storage:C1525.intervenantsDetail.UserLOFT:=[INtervenants:10]IN_LOFT:10  // equivant <>vb_UserLOFT
			Storage:C1525.intervenantsDetail.UserPointage:=[INtervenants:10]IN_Pointage:14  // equivant <>vb_UserPointage
			
			Storage:C1525.intervenantsDetail.UserMessagerie:=[INtervenants:10]IN_Messagerie:12  // equivant <>vb_UserMessagerie
			Storage:C1525.intervenantsDetail.UserPlateforme:=[INtervenants:10]IN_Plateforme:13  // equivant <>va_UserPlateforme
			
			Storage:C1525.intervenantsDetail.Privileges:=New shared collection:C1527()
		End use 
		
		Use (Storage:C1525.intervenantsDetail.Privileges)
			Storage:C1525.intervenantsDetail.Privileges:=ds:C1482.INtervenants.get([INtervenants:10]ID:16).AllIntervenantPrivilege.OnePrivilege.toCollection("nom").copy(ck shared:K85:29; Storage:C1525.intervenantsDetail.Privileges)
		End use 
		
	: ($1="duplication")  // Duplication
		Use (Storage:C1525)
			Storage:C1525.duplication:=New shared object:C1526
		End use 
		
	: ($1="numerotation")
		Use (Storage:C1525)
			Storage:C1525.numerotation:=New shared object:C1526
		End use 
		Use (Storage:C1525.numerotation)
			Storage:C1525.numerotation.vaCPT_115:=""
		End use 
		
End case 
