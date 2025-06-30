var $T_Message; $typeFiche_t; $nom_t : Text
var $vl_EventFF; $ii; $L_G_sub_demandeur_1; $L_H_sub_demandeur_1; $L_D_sub_demandeur_1; $L_B_sub_demandeur_1; \
$L_G_sub_groupe; $LH_sub_groupe; $LD_sub_groupe; $L_B_sub_groupe; $LG_sub_heberge_fiches; $LH_sub_heberge_fiches; $LD_sub_heberge_fiches; $LB_sub_heberge_fiches : Integer
var $vb_OK; $vb_OK2 : Boolean
var va_IDT_Nom : Text
var va_IDT_Pré : Text
var vd_IDT_NéLe : Date
var $heberge_e : cs:C1710.HeBergeEntity


var $centre_e : cs:C1710.LesCentresEntity

$vl_EventFF:=Form event code:C388

Case of 
	: ($vl_EventFF=Sur chargement:K2:1)
		var dateCreationFiche_d : Date
		
		OBJECT SET VISIBLE:C603(*; "BoiteLettres"; <>vb_T_BoiteLettres)
		OBJECT SET VISIBLE:C603(*; "BoiteDalo"; <>vb_T_BoiteDalo)
		
		SOC_Get_Config
		
		If (Not:C34(SO_DOS_Encours_Activer))
			OBJECT SET VISIBLE:C603(*; "@dossiers_encours@"; False:C215)
		End if 
		
		<>ta_Cohabitation:=0
		
		If (Size of array:C274(<>ta_Cohabitation)>0)
			<>ta_Cohabitation:=1
		End if 
		
		If (x_IDTG_1=x_IDTG_2)
			x_IDTG_1:=1
			x_IDTG_2:=0
		End if 
		
		rIDTG_1:=x_IDTG_1
		rIDTG_2:=x_IDTG_2
		va_IDT_Clé:=Uut_HébergéClé(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe)
		va_IDT_CléFam:=""
		vl_SourisX:=0
		vl_SourisY:=0
		vl_SourisBt:=0
		va_FrappeClavier:=""
		va_FrappeClavierP:=""
		va_FrappeClavierD:=""
		ve_NbHGi:=0
		va_NNN:=""
		wresMulti:=0
		
		ARRAY LONGINT:C221(<>tl_FamilleID; 0)
		ARRAY TEXT:C222(<>ta_FamilleClé; 0)
		ARRAY TEXT:C222(<>ta_FamilleEtCv; 0)
		
		<>va_RéserveAction:=""
		OBJECT SET ENABLED:C1123(b_InFam; (wresMulti=1))
		
		vb_PasseR:=False:C215
		P_HébergementNotesBt(0)
		
		OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
		
		OBJECT SET VISIBLE:C603(*; "LibresMulti"; False:C215)
		OBJECT SET VISIBLE:C603(*; "LibresUn"; True:C214)
		
		OBJECT SET TITLE:C194(b_InFam; ("Cacher les rés. multiples"*Num:C11(<>PR_HébergementMul>0))+("Montrer les rés. multiples"*Num:C11(<>PR_HébergementMul=0)))
		
		va_GPmembres:="Membres du groupe"
		va_GPLib:=""
		va_GPLibel:=""
		va_GPLibel:="Groupe "+("Nuit"*Num:C11(va_JourNuit="N"))+("Jour"*Num:C11(va_JourNuit="J"))
		va_GPmembres:=F_HébergementGroupeTitre("")
		
		OBJECT SET VISIBLE:C603(*; "Bt_RésaM@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "VSM_@"; False:C215)
		OBJECT SET VISIBLE:C603(*; "CRYP_BT"; <>vb_T_Cryptage)
		
/*Si (va_JourNuit="N") & (<>vb_T_ModeCHRS=Vrai)
OBJET FIXER TITRE(b_CérerHgé; "Clé + Prestation")
OBJET FIXER TITRE(b_ValHBnew; "Prestation")
Sinon 
OBJET FIXER TITRE(b_CérerHgé; "Clé + Hébergement")
OBJET FIXER TITRE(b_ValHBnew; "Hébergement")
Fin de si */
		
		If (<>vb_T_ModeCHRS)
			wSansFiltre:=1
		Else 
			wSansFiltre:=0
		End if 
		
		OBJECT SET VISIBLE:C603(wSansFiltre; User in group:C338(Current user:C182; <>Groupe_SansFiltre))
		
		// Modifié par : Scanu Rémy (25/07/2022)
		OBJECT SET VISIBLE:C603(*; "Pop-up/Liste déroulante1"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		// Bouton "Nouveau demandeur + Hébergement"
		OBJECT SET VISIBLE:C603(*; "Image34"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Bouton1"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		// Bouton "Nouveau Hébergement"
		OBJECT SET VISIBLE:C603(*; "Image31"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Bouton 3D3"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		// Bouton "Pointage Hébergement"
		OBJECT SET VISIBLE:C603(*; "Image32"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Pointage_Bt1"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		// Bouton radio "Hébergement" et "Hébergement + Prestation"
		OBJECT SET VISIBLE:C603(*; "Bouton radio"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Bouton radio2"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		// Listbox "Groupes"
		OBJECT SET VISIBLE:C603(*; "sub_groupe"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		OBJECT SET VISIBLE:C603(*; "Rectangle rond4"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Image65"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Texte3"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Variable3"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Image47"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Gpe_Ladd"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Image48"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Gpe_Lmod"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Image49"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Gpe_Lsup"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		OBJECT SET VISIBLE:C603(*; "Rectangle rond6"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Variable14"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Variable15"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		// Listbox "Membre groupe"
		OBJECT SET VISIBLE:C603(*; "LB"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		OBJECT SET VISIBLE:C603(*; "Rectangle rond7"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Rectangle31"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Texte28"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Gpe_HBaddclic"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Variable12"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		OBJECT SET VISIBLE:C603(*; "Rectangle rond5"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Image66"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Texte4"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Image1"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Gpe_Mmod"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Image2"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Gpe_Msup"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Image51"; User in group:C338(Current user:C182; <>Groupe_Jour))
		OBJECT SET VISIBLE:C603(*; "Gpe_HBaddGpe"; User in group:C338(Current user:C182; <>Groupe_Jour))
		
		// Modifié par : Scanu Rémy (02/01/2023)
		CLEAR VARIABLE:C89(dateCreationFiche_d)
		
		// Modifié par : Scanu Rémy (03/05/2023)
		OBJECT SET VISIBLE:C603(*; "Bouton10"; User in group:C338(Current user:C182; "RetroactiviteCible"))
		OBJECT SET VISIBLE:C603(*; "Bouton11"; (Current user:C182="apaxtel"))
		
		// Modifié par : Scanu Rémy (09/06/2023)
		OBJECT SET VISIBLE:C603(*; "Bouton12"; (Current user:C182="apaxtel"))
		
		// Modifié par : Scanu Rémy (22/06/2023)
		OBJECT SET VISIBLE:C603(*; "Bouton13"; (Current user:C182="apaxtel"))
		
		// Modifié par : Scanu Rémy (25/07/2024)
		OBJECT SET VISIBLE:C603(*; "Bouton4"; (Current user:C182="apaxtel"))
		
		SET TIMER:C645(-1)
	: ($vl_EventFF=Sur clic:K2:4)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		
		// Modifié par : Rémy Scanu (22/06/2022)
		OBJECT GET COORDINATES:C663(*; "sub_demandeur_1"; $L_G_sub_demandeur_1; $L_H_sub_demandeur_1; $L_D_sub_demandeur_1; $L_B_sub_demandeur_1)  // #20180430-4
		OBJECT GET COORDINATES:C663(*; "sub_groupe"; $L_G_sub_groupe; $LH_sub_groupe; $LD_sub_groupe; $L_B_sub_groupe)  // #20180430-4
		OBJECT GET COORDINATES:C663(*; "sub_heberge_fiches"; $LG_sub_heberge_fiches; $LH_sub_heberge_fiches; $LD_sub_heberge_fiches; $LB_sub_heberge_fiches)  // #20180430-4
		
		Case of 
			: ((vl_SourisX>=$L_G_sub_demandeur_1) & (vl_SourisX<=$L_D_sub_demandeur_1)) & ((vl_SourisY>=$L_H_sub_demandeur_1) & (vl_SourisY<=$L_B_sub_demandeur_1))  // L'utilisateur a cliqué sur le sous-formulaire des hébergés
				outilsHebergeLoadRecord
				
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "Bouton radio")->:=0
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "Bouton radio1")->:=0
				OBJECT Get pointer:C1124(Objet nommé:K67:5; "Bouton radio2")->:=0
				
				P_HébergementHBClic([HeBerge:4]HB_ReferenceID:1; 1)
				
				If (Read only state:C362([HeberGement:5])=True:C214)
					READ WRITE:C146([HeberGement:5])
				End if 
				
			: ((vl_SourisX>=ve_Cdr2L) & (vl_SourisX<=ve_Cdr2R)) & ((vl_SourisY>=ve_Cdr2T) & (vl_SourisY<=ve_Cdr2B))
			: ((vl_SourisX>=$L_G_sub_groupe) & (vl_SourisX<=$LD_sub_groupe)) & ((vl_SourisY>=$LH_sub_groupe) & (vl_SourisY<=$L_B_sub_groupe))  // L'utilisateur a cliqué sur le sous-formulaire des groupes
				P_HébergementGPClic([GrouPe:36]GP_ReferenceID:1; 1)
			: ((vl_SourisX>=ve_Cdr4L) & (vl_SourisX<=ve_Cdr4R)) & ((vl_SourisY>=ve_Cdr4T) & (vl_SourisY<=ve_Cdr4B))
		End case 
		
		// Modified by: Kevin HASSAL (06/07/2020)
		// Pour la gestion des participations
		If ([HeBerge:4]HB_FAC_Mode_Facturation:80="Participations")
			OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; False:C215)
			OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*; "pic_btn_P_noir"; True:C214)
			OBJECT SET VISIBLE:C603(*; "pic_btn_P_bleu"; False:C215)
		End if 
		
		If (Records in set:C195("$heberge_ebl")>0)
			
			If (Bool:C1537(Form:C1466.changeTypeHebergement)=False:C215)
				
				Case of 
					: ((vl_SourisX>=$LG_sub_heberge_fiches) & (vl_SourisX<=$LD_sub_heberge_fiches)) & ((vl_SourisY>=$LH_sub_heberge_fiches) & (vl_SourisY<=$LB_sub_heberge_fiches))  // L'utilisateur a cliqué sur le sous-formulaire des hébergements
					Else 
						Rec_Hébergements1
				End case 
				
			End if 
			
		Else 
			UNLOAD RECORD:C212([HeberGement:5])
			REDUCE SELECTION:C351([HeberGement:5]; 0)
		End if 
		
		OB REMOVE:C1226(Form:C1466; "changeTypeHebergement")
	: ($vl_EventFF=Sur double clic:K2:5)
		GET MOUSE:C468(vl_SourisX; vl_SourisY; vl_SourisBt)
		OBJECT GET COORDINATES:C663(*; "sub_heberge_fiches"; $LG_sub_heberge_fiches; $LH_sub_heberge_fiches; $LD_sub_heberge_fiches; $LB_sub_heberge_fiches)  // #20180430-4
		
		Case of 
			: ((vl_SourisX>=$LG_sub_heberge_fiches) & (vl_SourisX<=$LD_sub_heberge_fiches)) & ((vl_SourisY>=$LH_sub_heberge_fiches) & (vl_SourisY<=$LB_sub_heberge_fiches))  // L'utilisateur a cliqué sur le sous-formulaire des hébergements
				$vb_OK2:=True:C214
				
				If ([HeberGement:5]HG_ReferenceID:1>0)
					
					If (<>vb_T_ModeCHRS)
						$vb_OK2:=([HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
					End if 
					
				End if 
				
				// Modifié par : Scanu Rémy (16/02/2024)
				If ($vb_OK2=True:C214)
					outilsOrdaSearchSimple(->[LesCentres:9]; ->[LesCentres:9]LC_Nom:4; [HeberGement:5]HG_CentreNom:62; ->$centre_e; "first")
					
					If ($centre_e#Null:C1517)
						
						If ($centre_e.LC_Sante=True:C214)
							$vb_OK2:=User in group:C338(Current user:C182; "Santé")
						End if 
						
					End if 
					
				End if 
				
				If ($vb_OK2=False:C215)
					StrAlerte(6; "")
				Else 
					$typeFiche_t:=Substring:C12([HeberGement:5]HG_FicheNuméro:3; 5; 1)
					P_HébergementProfil($typeFiche_t; "")
					
					MODIFY RECORD:C57([HeberGement:5])
				End if 
				
			: ((vl_SourisX>=ve_Cdr1L) & (vl_SourisX<=ve_Cdr1R)) & ((vl_SourisY>=ve_Cdr1T) & (vl_SourisY<=ve_Cdr1B))  // L'utilisateur a cliqué sur le sous-formulaire des hébergés
				P_HébergementHBClic([HeBerge:4]HB_ReferenceID:1; 2)
			: ((vl_SourisX>=ve_Cdr2L) & (vl_SourisX<=ve_Cdr2R)) & ((vl_SourisY>=ve_Cdr2T) & (vl_SourisY<=ve_Cdr2B))  // Liste des situations
				
				If ([HeberGement:5]HG_ReferenceID:1>0)
					
					If (<>vb_T_ModeCHRS)
						$vb_OK2:=([HeberGement:5]HG_Plateforme:139=(Substring:C12(<>va_UserPlateforme; 1; 4)+"@"))
					Else 
						$vb_OK2:=True:C214
					End if 
					
					If ($vb_OK2)
						$vaUn:=(("N"*Num:C11([HeberGement:5]HG_Nuit:2))+("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215)))
						$vb_OK:=False:C215
						
						If (Size of array:C274(<>ta_InPerm)>0)
							
							For ($ii; 1; Size of array:C274(<>ta_InPerm))
								
								If (<>ta_InPerm{$ii}=[HeberGement:5]HG_Permanencier:9)
									$vb_OK:=True:C214
								End if 
								
							End for 
							
						End if 
						
						If (<>vb_UserLOFT)
							
							If ($vaUn="N") & ($vb_OK)
								Process_Go7(-><>PR_HébergementR; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "G"; [HeberGement:5]HG_FicheNuméro:3)
							Else 
								StrAlerte(27; "")
							End if 
							
						Else 
							Process_Go7(-><>PR_HébergementR; "Go_HébergementR"; "FicheSignal"; 64; $vaUn; "G"; [HeberGement:5]HG_FicheNuméro:3)
						End if 
						
					Else 
						StrAlerte(6; "")
					End if 
					
				End if 
				
			: ((vl_SourisX>=ve_Cdr3L) & (vl_SourisX<=ve_Cdr3R)) & ((vl_SourisY>=ve_Cdr3T) & (vl_SourisY<=ve_Cdr3B))  // L'utilisateur a cliqué sur le sous-formulaire des groupes  
				P_HébergementGPClic([GrouPe:36]GP_ReferenceID:1; 2)
			: ((vl_SourisX>=ve_Cdr4L) & (vl_SourisX<=ve_Cdr4R)) & ((vl_SourisY>=ve_Cdr4T) & (vl_SourisY<=ve_Cdr4B))  // Liste des membres
		End case 
		
	: ($vl_EventFF=Sur appel extérieur:K2:11)
		
		Case of 
			: (<>va_Trans_Cle>"")
				va_IDT_Nom:=<>va_Trans_Nom
				va_IDT_Pré:=<>va_Trans_Prenom
				vd_IDT_NéLe:=<>vd_Trans_Nele
				ve_IDT_Age:=Uut_HébergéAge(->vd_IDT_NéLe)
				va_IDT_Typ1:=<>va_Trans_EtCv
				
				REDUCE SELECTION:C351([HeBerge:4]; 0)
				P_HébergementHBClic(0; 1)
				
				QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>va_Trans_Cle)
				
				If (Records in selection:C76([HeBerge:4])=1)
					P_HébergementHBClic([HeBerge:4]HB_ReferenceID:1; 1)
				End if 
				
				va_IDT_TypTrans:=<>va_Trans_EtCv
				<>va_Trans_Cle:=""
			: (<>va_RéserveAction="")
				OBJECT SET TITLE:C194(b_InFam; ("Cacher les rés. multiples"*0)+("Montrer les rés. multiples"*1))
		End case 
		
		// Modifié par : Scanu Rémy (23/02/2023)
		// Duplication d'une fiche demandée depuis le formulaire [HeberGement]HG_EcranSaisie_B
		If (Bool:C1537(Form:C1466.dupliquerFiche)=True:C214)
			va_JourNuit:=Form:C1466.dupliquerFicheType
			
			Repeat 
				Tab_PopIn1n("Type"; -><>ta_TBEtCiv; ->va_IDT_Typ1)
				
				If (<>vb_EtatCivilAge)
					
					If (va_IDT_Typ1="Enfant@")
						ve_HébergéAge:=10
					End if 
					
					$vb_OK:=F_HébergementEtatCivil(va_IDT_Typ1; ve_HébergéAge)
				Else 
					$vb_OK:=True:C214
				End if 
				
			Until ($vb_OK)
			
			If (va_IDT_Typ1#"")
				$heberge_e:=ds:C1482.HeBerge.get(Form:C1466.dupliquerFicheHBID)
				
				If ($heberge_e#Null:C1517)
					vd_IDT_NéLe:=$heberge_e.HB_DateNéLe
					
					$nom_t:=$heberge_e.HB_Nom
					$nom_t:=Replace string:C233($nom_t; " Compagnon"; "")
					$nom_t:=Replace string:C233($nom_t; " Compagne"; "")
					$nom_t:=Replace string:C233($nom_t; " Enfant"; "")
					
					Case of 
						: (va_IDT_Typ1="Enfant@")
							va_IDT_Nom:=$nom_t+" Enfant"
							vd_IDT_NéLe:=Add to date:C393(Current date:C33; -10; 0; 0)
						: (va_IDT_Typ1="F@")
							va_IDT_Nom:=$nom_t+" Compagne"
						: (va_IDT_Typ1="H@")
							va_IDT_Nom:=$nom_t+" Compagnon"
					End case 
					
					va_IDT_Pré:=$heberge_e.HB_Prénom
					
					F_HebergementCléNewValider
				End if 
				
			End if 
			
		End if 
		
	: ($vl_EventFF=Sur minuteur:K2:25)
		SET TIMER:C645(0)
		Handle bandeau Heberge(False:C215)
		OBJECT SET VISIBLE:C603(*; "bandeau"; False:C215)
		
		If (OBJECT Get visible:C1075(*; "bandeau"))
			C_BOOLEAN:C305(var_saisie_differee)
			
			var_saisie_differee:=True:C214
			$T_Message:="Attention la saisie différée est active, vous êtes sur le point de créer une fiche à la date : "+String:C10(<>vd_SD_Jour)\
				+", si vous souhaitez revenir à la date d'aujourd'hui, veuillez quitter la saisie différée."
			
			OBJECT SET TITLE:C194(*; "bandeau"; $T_Message)
		End if 
		
	: ($vl_EventFF=Sur menu sélectionné:K2:14)
		// Modifié par : Scanu Rémy - remy@connect-io.fr (22/06/2021)
		// Ajout d'un menu pour accéder à la barre d'appel sans que l'utilisateur ait besoin de redémarrer le programme
		i_MenuChoisi
End case 