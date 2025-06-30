// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 22/09/2020, 08:17:39
// ----------------------------------------------------
// Method: [DiaLogues].DL_HébergementVeille_b.The_List_box
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_LONGINT:C283($0)

C_TEXT:C284($nom_pref_liste_box)
C_LONGINT:C283($colonne; $ligne; $i; $avant; $apres; $index_el)
C_DATE:C307($dateFirst_d; $dateLast_d)
C_POINTER:C301($ptr_liste_box_courante; $file_Ptr; $ptr_colonne)
C_BLOB:C604($blob)
C_OBJECT:C1216($entity_es; $form_o)
C_COLLECTION:C1488($varChamp_c)

var $hebergement_e : cs:C1710.HeberGementEntity
var $hebergement_es; $hebergementB_es; $hebergementTri_es : cs:C1710.HeberGementSelection

var $heberge_e : cs:C1710.HeBergeEntity
var $heberge_es; $hebergeB_es : cs:C1710.HeBergeSelection

var $participation_e : cs:C1710.ParticipationsEntity
var $participation_es : cs:C1710.ParticipationsSelection

var $centre_e : cs:C1710.LesCentresEntity

$ptr_liste_box_courante:=->The_List_box
$file_Ptr:=->[HeberGement:5]
$nom_pref_liste_box:="Hébergements"
the_ptr_file_liste_box_courante:=$file_ptr

LISTBOX GET CELL POSITION:C971($ptr_liste_box_courante->; $colonne; $ligne; $ptr_colonne)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		C_LONGINT:C283(r9)
		
		LB_Liste_Init
		
		LB_Load_liste_des_Modeles
		LB_Load_Liste
		LB_Load_Array_To_Memory($file_Ptr; $ptr_liste_box_courante)
		
		LISTBOX SET ROWS HEIGHT:C835($ptr_liste_box_courante->; 30)
		LISTBOX SET HEADERS HEIGHT:C1143($ptr_liste_box_courante->; 30)
		
		OBJECT SET VERTICAL ALIGNMENT:C1187($ptr_liste_box_courante->; Aligné au centre:K42:3)
	: (Form event code:C388=Sur après tri:K2:28)
	: (Form event code:C388=Sur clic entête:K2:40)
		$form_o:=FORM Event:C1606
		$hebergementTri_es:=ds:C1482.HeberGement.newSelection(dk keep ordered:K85:11)
		
		Case of 
			: (Contextual click:C713)
				LB_Manage_Header_Clic($ptr_liste_box_courante; False:C215; $file_Ptr)
			Else 
				
				If ($form_o.headerName="PARMontantParticipation") | ($form_o.headerName="HBFACModeFacturation")
					LOAD RECORD:C52([HeberGement:5])
					
					// On détermine dans quel ordre on effectue le tri
					If (Form:C1466.clicEnteteSpecifique[$form_o.headerName]="") | (Form:C1466.clicEnteteSpecifique[$form_o.headerName]="desc")
						Form:C1466.clicEnteteSpecifique[$form_o.headerName]:="asc"
					Else 
						Form:C1466.clicEnteteSpecifique[$form_o.headerName]:="desc"
					End if 
					
					$hebergement_es:=Create entity selection:C1512([HeberGement:5])
					
					If ($form_o.headerName="HBFACModeFacturation")
						$heberge_es:=$hebergement_es.HG_HB_ID_1_HB_ReferenceID.orderBy("HB_FAC_Mode_Facturation "+Form:C1466.clicEnteteSpecifique[$form_o.headerName])
					Else 
						$heberge_es:=$hebergement_es.HG_HB_ID_1_HB_ReferenceID
						$hebergeB_es:=ds:C1482.HeBerge.newSelection(dk keep ordered:K85:11)
						
						$participation_es:=outilsOrdaSearch($heberge_es; "HB_ReferenceID"; "Participations"; "PAR_HB_ID")
						
						// On extrait les participations dans la bonne tranche de date
						$dateFirst_d:=$hebergement_es.orderBy("HG_Date asc").first().HG_Date
						$dateLast_d:=$hebergement_es.orderBy("HG_Date desc").first().HG_Date
						
						$participation_es:=$participation_es.query("PAR_Annee >= :1 AND PAR_Annee <= :2"; Year of:C25($dateFirst_d); Year of:C25($dateLast_d))
						
						If (Year of:C25($dateFirst_d)=Year of:C25($dateLast_d))
							$participation_es:=$participation_es.query("PAR_Mois >= :1 AND PAR_Mois <= :2"; Month of:C24($dateFirst_d); Month of:C24($dateLast_d))
						End if 
						
						$participation_es:=$participation_es.orderBy("PAR_Montant_Participation "+Form:C1466.clicEnteteSpecifique[$form_o.headerName])
						
						For each ($participation_e; $participation_es)
							outilsOrdaSearchSimple(->[HeBerge:4]; ->[HeBerge:4]HB_ReferenceID:1; $participation_e.PAR_HB_ID; ->$heberge_e; "first")
							
							If ($heberge_e#Null:C1517) & ($heberge_e.indexOf($hebergeB_es)=-1)
								$hebergeB_es.add($heberge_e)
							End if 
							
						End for each 
						
						// La méthode outilsOrdaSearch ne conserve pas le tri dommage que je n'y ai pas pensé...
						//$hebergeB_es:=outilsOrdaSearch($participation_es; "PAR_HB_ID"; "HeBerge"; "HB_ReferenceID")
						
						For each ($heberge_e; $heberge_es)
							
							If ($heberge_e.indexOf($hebergeB_es)=-1)  // L'hébergé n'a aucune participation
								
								If (Form:C1466.clicEnteteSpecifique[$form_o.headerName]="asc")  // On tri le montant par ordre croissant
									outilsOrdaManage(1; ->$hebergeB_es; $heberge_e; 0)
								Else 
									outilsOrdaManage(1; ->$hebergeB_es; $heberge_e; -1)
								End if 
								
							End if 
							
						End for each 
						
						$heberge_es:=$hebergeB_es.copy()
					End if 
					
					For each ($heberge_e; $heberge_es)
						$hebergementB_es:=$heberge_e.HB_ReferenceID_1_HG_HB_ID
						$hebergementB_es:=$hebergement_es.and($hebergementB_es)
						
						For each ($hebergement_e; $hebergementB_es)
							$hebergementTri_es.add($hebergement_e)
						End for each 
						
					End for each 
					
					USE ENTITY SELECTION:C1513($hebergementTri_es)
					LOAD RECORD:C52([HeberGement:5])
					
					$0:=-1
				End if 
				
		End case 
		
	: (Form event code:C388=Sur double clic:K2:5)
	: (Form event code:C388=Sur clic:K2:4)
	: (Form event code:C388=Sur redimensionnement colonne:K2:31)
		
		For ($i; 1; Size of array:C274(TE_Largeur_colonne))
			$argh:=Get pointer:C304(TA_nom_var_entete{$i})
			TE_Largeur_colonne{$i}:=LISTBOX Get column width:C834($argh->)
		End for 
		
		$blob:=LB_tableau_LB_vers_BLOB
		
		LB_store_LB($blob)
		LB_Store_tableau_en_memoire($ptr_liste_box_courante)
	: (Form event code:C388=Sur déplacement colonne:K2:30)
		LISTBOX MOVED COLUMN NUMBER:C844(The_List_box; $avant; $apres)
		
		LB_Move_Column(->TA_titre_colonne; $avant; $apres)
		LB_Move_Column(->TT_contenu_colonne; $avant; $apres)
		LB_Move_Column(->TE_Largeur_colonne; $avant; $apres)
		LB_Move_Column(->TT_Type_donnee_colonne; $avant; $apres)
		LB_Move_Column(->TA_nom_var_entete; $avant; $apres)
		LB_Move_Column(->TA_entete; $avant; $apres)
		
		LB_Move_Column(->TE_Alignement_colonne; $avant; $apres)
		LB_Move_Column(->TE_Style_colonne; $avant; $apres)
		LB_Move_Column(->TT_Police_colonne; $avant; $apres)
		LB_Move_Column(->TE_couleur_fond_colonne; $avant; $apres)
		LB_Move_Column(->TE_couleur_police_colonne; $avant; $apres)
		LB_Move_Column(->TT_formatage_colonne; $avant; $apres)
		
		LB_Move_Column(->TE_Alignement_entete; $avant; $apres)
		LB_Move_Column(->TE_Style_entete; $avant; $apres)
		LB_Move_Column(->TT_Police_entete; $avant; $apres)
		LB_Move_Column(->TE_couleur_fond_entete; $avant; $apres)
		LB_Move_Column(->TE_couleur_police_entete; $avant; $apres)
		LB_Move_Column(->TE_taille_police; $avant; $apres)
		
		$blob:=LB_tableau_LB_vers_BLOB
		
		LB_store_LB($blob)
		LB_Store_tableau_en_memoire($ptr_liste_box_courante)
	: (Form event code:C388=Sur affichage corps:K2:22)
		READ ONLY:C145([HeBerge:4])
		READ ONLY:C145([LesCentres:9])
		READ ONLY:C145([Participations:116])
		
		QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
		MultiSoc_Filter(->[HeBerge:4])
		
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
		MultiSoc_Filter(->[LesCentres:9])
		
		// Modifié par : Scanu Rémy (23/08/2023)
		QUERY:C277([Participations:116]; [Participations:116]PAR_HB_ID:2=[HeBerge:4]HB_ReferenceID:1)
		MultiSoc_Filter(->[Participations:116])
		
		QUERY SELECTION:C341([Participations:116]; [Participations:116]PAR_Annee:3=Year of:C25([HeberGement:5]HG_Date:4); *)
		QUERY SELECTION:C341([Participations:116];  & ; [Participations:116]PAR_Mois:4=Month of:C24([HeberGement:5]HG_Date:4))
		
		// Modifié par : Scanu Rémy (07/11/2022)
		If (Form:C1466.footerVar#Null:C1517)
			
			// Modifié par : Scanu Rémy (22/02/2023) et re-modifié par Scanu Rémy (05/04/2023)
			If (Form:C1466.footerVar.length>0)
				$varChamp_c:=Form:C1466.footerVar.extract("varChamp")
				
				For each ($varChamp_t; $varChamp_c)
					$index_el:=$varChamp_c.indexOf($varChamp_t)
					$entity_es:=Formula from string:C1601("Créer Entity Selection:C1512(["+Form:C1466.footerVar[$index_el].varTable+"])").call()
					
					Formula from string:C1601(Form:C1466.footerVar[$index_el].varName+":="+String:C10($entity_es.sum($varChamp_t))).call()
				End for each 
				
			End if 
			
		End if 
		
		outilsOrdaSearchSimple(->[LesCentres:9]; ->[LesCentres:9]LC_Nom:4; [HeberGement:5]HG_CentreNom:62; ->$centre_e; "first")
		
		If ($centre_e#Null:C1517)
			
			If ($centre_e.LC_Sante=True:C214)
				
				If (User in group:C338(Current user:C182; "Santé")=False:C215)
					[HeberGement:5]HG_CentreNom:62:="XXX"
				End if 
				
			End if 
			
		End if 
		
End case 