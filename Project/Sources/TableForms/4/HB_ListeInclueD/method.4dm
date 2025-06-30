var $intervenantID_el : Integer
var $statut_o : Object

var $hebergement_es : cs:C1710.HeberGementSelection
var $heberge_e : cs:C1710.HeBergeEntity
var $intervenant_es : cs:C1710.INtervenantsSelection

ARRAY LONGINT:C221($id_ai; 0)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		var vt_Pastille; cleLien_t : Text
		var vl_NbHGi; ve_NbSP : Integer
		var vl_NbSii : Real
	: (Form event code:C388=Sur affichage corps:K2:22)
		ve_NbSP:=Num:C11([HeBerge:4]HB_Status:18)
		vl_NbSii:=F_SiaoEnCours([HeBerge:4]HB_ReferenceID:1)
		
		// Modifié par : Scanu Rémy (13/03/2023)
		// Affichage de la clé de lien en cours et non plus celle affecté à l'initialisation de l'hébergé
		CLEAR VARIABLE:C89(cleLien_t)
		OBJECT SET FONT STYLE:C166(cleLien_t; Normal:K14:1)
		
		If (Records in selection:C76([HeBerge:4])>0) & ([HeBerge:4]ID:65#0)
			$heberge_e:=ds:C1482.HeBerge.get([HeBerge:4]ID:65)
			
			cleLien_t:=$heberge_e.HB_CléFam
			$hebergement_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID.orderBy("HG_Date desc, HG_HeureAppel desc")
			
			If ($hebergement_es.length>0)
				cleLien_t:=$hebergement_es[0].HG_FamClé
				
				If ($hebergement_es[0].HG_FamChef=True:C214)
					OBJECT SET FONT STYLE:C166(cleLien_t; Gras:K14:2)
				End if 
				
			Else 
				OBJECT SET FONT STYLE:C166(cleLien_t; Gras:K14:2)
			End if 
			
		End if 
		
		// Modifié par : Scanu Rémy (29/09/2022) et Re-Modifié par Scanu Rémy (27/10/2022)
		OBJECT SET VISIBLE:C603(*; "pastilleAlerteDirection@"; (Records in selection:C76([HeBerge:4])>0) & (User in group:C338(Current user:C182; "AlerteDirection")=True:C214))
		OBJECT SET VISIBLE:C603(*; "pastilleAlerteDirection"; ([HeBerge:4]ID:65#0))
		
		OBJECT SET ENABLED:C1123(vt_Pastille; (Records in selection:C76([HeBerge:4])>0) & (User in group:C338(Current user:C182; "AlerteDirection")=True:C214))
		
		If (Records in selection:C76([HeBerge:4])>0) & ([HeBerge:4]ID:65#0) & (OBJECT Get visible:C1075(*; "pastilleAlerteDirection@")=True:C214)
			
			If ($heberge_e.HB_AlerteDirection=Null:C1517)
				$numSelectionEnCours_el:=Selected record number:C246([HeBerge:4])
				SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $id_ai)
				
				UNLOAD RECORD:C212([HeBerge:4])
				
				$heberge_e.reload()
				$heberge_e.HB_AlerteDirection:=New object:C1471("activer"; False:C215; "userID"; 0)
				$statut_o:=$heberge_e.save()
				
				QUERY WITH ARRAY:C644([HeBerge:4]ID:65; $id_ai)
				GOTO SELECTED RECORD:C245([HeBerge:4]; $numSelectionEnCours_el)
			End if 
			
			OBJECT SET RGB COLORS:C628(vt_Pastille; "transparent"; "transparent")
			
			If (User in group:C338(Current user:C182; "AlerteDirection")=True:C214)
				OBJECT SET BORDER STYLE:C1262(*; "pastilleAlerteDirection@"; Bordure Normal:K42:28)
				
				If ($heberge_e.HB_AlerteDirection.activer=True:C214)
					OBJECT SET BORDER STYLE:C1262(*; "pastilleAlerteDirection@"; Bordure Aucune:K42:27)
					OBJECT SET RGB COLORS:C628(vt_Pastille; "transparent"; "#FADA5E")
					$intervenant_es:=ds:C1482.INtervenants.query("IN_Login = :1"; <>User_Actif_Login)
					
					If ($intervenant_es.length=1)
						
						If ($heberge_e.HB_AlerteDirection.userID=$intervenant_es.first().ID)
							OBJECT SET RGB COLORS:C628(vt_Pastille; "transparent"; "green")
						End if 
						
					End if 
					
				End if 
				
			End if 
			
		End if 
		
	: (Form event code:C388=Sur clic:K2:4)
		outilsHebergeLoadRecord
		
		If ([HeBerge:4]ID:65#0)
			$heberge_e:=ds:C1482.HeBerge.get([HeBerge:4]ID:65)
			$intervenant_es:=ds:C1482.INtervenants.query("IN_Login = :1"; <>User_Actif_Login)
			
			If ($intervenant_es.length=1)
				$intervenantID_el:=$intervenant_es.first().ID
			End if 
			
			If (Bool:C1537(Form:C1466.alerteDirectionClic)=True:C214)
				
				Case of 
					: (Bool:C1537($heberge_e.HB_AlerteDirection.activer)=False:C215)
						CONFIRM:C162("Souhaitez-vous vraiment mettre en place une « Alerte direction » pour l'hébergé "+[HeBerge:4]HB_Nom:3+" "+[HeBerge:4]HB_Prénom:4; "Oui"; "Non")
						
						If (OK=1)
							$intervenant_es:=ds:C1482.INtervenants.query("IN_Login = :1"; <>User_Actif_Login)
							
							If ($intervenant_es.length=1)
								$heberge_e.HB_AlerteDirection.activer:=True:C214
								$heberge_e.HB_AlerteDirection.userID:=$intervenant_es.first().ID
								$statut_o:=$heberge_e.save()
							Else 
								ALERT:C41("L'intervenant "+<>User_Actif_Login+" n'a pas pu être trouvé dans la base de données, veuillez vous rapprocher de votre service informatique.")
							End if 
							
						End if 
						
					: (Num:C11($heberge_e.HB_AlerteDirection.userID)#$intervenantID_el)
						ALERT:C41("Une « Alerte direction » a été placé par un autre utilisateur, vous ne pouvez pas intervenir dessus.")
					Else 
						CONFIRM:C162("Souhaitez-vous vraiment retirer « l' Alerte direction » pour l'hébergé "+$heberge_e.HB_Nom+" "+$heberge_e.HB_Prénom; "Oui"; "Non")
						
						If (OK=1)
							$heberge_e.HB_AlerteDirection:=New object:C1471("activer"; False:C215; "userID"; 0)
							$statut_o:=$heberge_e.save()
						End if 
						
				End case 
				
				OB REMOVE:C1226(Form:C1466; "alerteDirectionClic")
			End if 
			
		End if 
		
End case 