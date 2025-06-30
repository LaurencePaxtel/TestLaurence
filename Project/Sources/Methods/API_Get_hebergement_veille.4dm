//%attributes = {"preemptive":"capable"}
// Method API_Get_hebergement_veille  
// 
// 
// #SYNTAX: $L_Erreur:=API_Get_hebergement_veille($O_Data;output) 
// #PARAMETERS:
//     $0 Long            : error code. 1 = OK
//     $1 Object          :

// #DATE CREATION: 09/03/2018  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2
C_LONGINT:C283($0)
C_OBJECT:C1216($1)
C_POINTER:C301($2)

C_TEXT:C284($filtre; $T_Phone; $T_Nom; $T_Lien_famcle; $ref_centres_ids; $T_Message; $T_Critere_Requete; $T_Critere_Matching)
C_LONGINT:C283($L_MyError; $i; $j; $L_Table; $L_Field; $L_Trouve)
C_BOOLEAN:C305($B_Trouve; $B_Valid_Field_number; $edit_b)
C_DATE:C307($D_Date_debut; $D_Date_fin; $D_Date_debut_premier_contact; $D_Date_fin_premier_contact)
C_POINTER:C301($P_Output; $P_Field)
C_OBJECT:C1216($O_Data; $O_Autres_criteres; $table_o; $autreTable_o)
C_COLLECTION:C1488($autreCriteres_c)

var $centre_e : cs:C1710.LesCentresEntity

ARRAY TEXT:C222($tb_centres_ids; 0)
ARRAY TEXT:C222($rT_Criteres_requete; 0)
ARRAY TEXT:C222($rT_Criteres_requete_liste; 0)

ARRAY TEXT:C222($rT_Distinct_cle; 0)
ARRAY TEXT:C222($rT_Distinct_FamCle; 0)

ARRAY LONGINT:C221($rL_ID; 0)
ARRAY LONGINT:C221($rL_referenceid; 0)

ARRAY OBJECT:C1221($rO_Match; 0)
ARRAY OBJECT:C1221($rO_Selection; 0)  // en cas d'erreur je retourne toujours un tableau vide

$L_MyError:=1

$O_Data:=$1
$P_Output:=$2

// Modified by: Kevin HASSAL (10-04-2019)
$ref_centres_ids:=OB Get:C1224($O_Data; "centre_referenceid"; Est un texte:K8:3)
UTL_Decoupe_texte(->$ref_centres_ids; ->$tb_centres_ids; ";")

For ($i; 1; Size of array:C274($tb_centres_ids))
	APPEND TO ARRAY:C911($rL_referenceid; Num:C11($tb_centres_ids{$i}))
End for 

$D_Date_debut:=Date:C102(OB Get:C1224($O_Data; "date_debut"; Est un texte:K8:3))  // début de période
$D_Date_fin:=Date:C102(OB Get:C1224($O_Data; "date_fin"; Est un texte:K8:3))  // fin de période 
$D_Date_debut_premier_contact:=Date:C102(OB Get:C1224($O_Data; "date_debut_premier_contact"; Est un texte:K8:3))  // début de période
$D_Date_fin_premier_contact:=Date:C102(OB Get:C1224($O_Data; "date_fin_premier_contact"; Est un texte:K8:3))  // fin de période 

$T_Phone:=OB Get:C1224($O_Data; "phone"; Est un texte:K8:3)
$T_Nom:=OB Get:C1224($O_Data; "nom"; Est un texte:K8:3)
$T_Lien_famcle:=OB Get:C1224($O_Data; "lien_famcle"; Est un texte:K8:3)
$autreCriteres_c:=OB Get:C1224($O_Data; "autres_criteres"; Est une collection:K8:32)  // critere1 + valeurs du tableau , critere2 + valeurs du tableau

If ($autreCriteres_c=Null:C1517)
	$autreCriteres_c:=New collection:C1472
End if 

// Modified by: Kevin HASSAL (24/10/2019)
// Ajout des filtres : Jour, Prestations et Jour+Nuit
$filtre:=OB Get:C1224($O_Data; "filtre"; Est un texte:K8:3)

//APPEND TO ARRAY($rL_referenceid;773)
Case of 
	: ($D_Date_debut=!00-00-00!)  //(Date_valide($D_Date_debut; ->$T_Message)#1)
		$L_MyError:=-3
	: ($D_Date_fin=!00-00-00!)  //(Date_valide($D_Date_fin; ->$T_Message)#1)
		$L_MyError:=-4
	: ($D_Date_debut>$D_Date_fin)
		$L_MyError:=-5
	Else 
		
		If (Size of array:C274($rL_referenceid)>=1)
			QUERY WITH ARRAY:C644([HeberGement:5]HG_LC_ID:61; $rL_referenceid)  // On cherche un ou des centres
		Else 
			ALL RECORDS:C47([HeberGement:5])  // sinon tous les centres
			MultiSoc_Filter(->[HeberGement:5])
		End if 
		
		If ($T_Nom#"")
			QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Nom:21=$T_Nom; *)
		End if 
		
		If ($T_Lien_famcle#"")
			QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_FamClé:104=$T_Lien_famcle; *)
		End if 
		
		// Entre deux dates
		If ($D_Date_debut_premier_contact#!00-00-00!) | ($D_Date_fin_premier_contact#!00-00-00!)
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_DatePremierContact:178>=$D_Date_debut_premier_contact; *)
			QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_DatePremierContact:178<=$D_Date_fin_premier_contact)
		Else 
			QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Date:4>=$D_Date_debut; *)
			QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Date:4<=$D_Date_fin)
		End if 
		
		If ($filtre#"")
			
			Case of 
				: ($filtre="jour")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=False:C215)
				: ($filtre="nuit")
					QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Nuit:2=True:C214)
				Else 
					// rien
			End case 
			
		End if 
		
		// les telephones ne sont qu'au niveau de l'individu
		//$T_Phone:=4DCAR_Trim($T_Phone)
		
		If ($T_Phone#"")
			RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
			MultiSoc_Filter(->[HeBerge:4])
			
			QUERY SELECTION:C341([HeBerge:4]; [HeBerge:4]HB_Telephone:66=$T_Phone)  // on a une sélection d'individus
			
			SELECTION TO ARRAY:C260([HeBerge:4]HB_ReferenceID:1; $rL_ID)
			QUERY SELECTION WITH ARRAY:C1050([HeberGement:5]HG_HB_ID:19; $rL_ID)
			
			MultiSoc_Filter(->[HeberGement:5])
		End if 
		
		// Autres critères
		// ###########################
		// 1- Je fais une correspondance entre le libellé du popup et le champ de recherche par tableau
		
		// je suis obliger de créer un ensemble car la sélection va être modifiée
		CREATE SET:C116([HeberGement:5]; "$hebergement")
		// GF- 12/12/24 : Ne semble plus être utilisé...
		//API_Match_autres_criteres(->$rO_Match)
		
		USE SET:C118("$hebergement")
		CLEAR SET:C117("$hebergement")
		
		// Modifié par : Scanu Rémy (30/06/2023)
		// 2- les criteres demandés par la requete. Avec ces critère j'irai chercher les tableaux
		For each ($O_Autres_criteres; $autreCriteres_c)
			OB GET PROPERTY NAMES:C1232($O_Autres_criteres; $rT_Criteres_requete)
			
			For ($i; 1; Size of array:C274($rT_Criteres_requete))
				
				If ($L_MyError=1)  // la récupération du champs cible n'a pas posé de problème
					$T_Critere_Requete:=$rT_Criteres_requete{$i}
					$T_Critere_Matching:="blabla"
					
					// 3- Récupération du champs cible
					$j:=1
					While ($j<=Size of array:C274($rO_Match)) & ($B_Trouve=False:C215)
						// ce code fait en 16R5 pourra être repris
						// en utilisant les collections de 4Dv17
						$T_Critere_Matching:=OB Get:C1224($rO_Match{$j}; "critere"; Est un texte:K8:3)
						
						If ($T_Critere_Matching=$T_Critere_Requete)
							$L_Table:=OB Get:C1224($rO_Match{$j}; "table"; Est un entier long:K8:6)
							$L_Field:=OB Get:C1224($rO_Match{$j}; "field"; Est un entier long:K8:6)
							$P_Field:=Field:C253($L_Table; $L_Field)  // j'ai trouvé le champs dans lequel chercher
							
							$B_Trouve:=True:C214
							$B_Valid_Field_number:=Is field number valid:C1000($L_Table; $L_Field)
						End if 
						
						$j:=$j+1
					End while 
					
					Case of 
						: (Not:C34($B_Trouve))
							$L_MyError:=-6
						: (Not:C34($B_Valid_Field_number))
							$L_MyError:=-7
						Else 
							OB GET ARRAY:C1229($O_Autres_criteres; $T_Critere_Requete; $rT_Criteres_requete_liste)  // les autres criteres demandés par la requete
							
							If (Size of array:C274($rT_Criteres_requete_liste)>=1)
								QUERY SELECTION WITH ARRAY:C1050($P_Field->; $rT_Criteres_requete_liste)
							End if 
							
					End case 
					
				End if 
				
			End for 
			
			CLEAR VARIABLE:C89($B_Trouve)
		End for each 
		
		// Modifié par : Scanu Rémy (26/09/2023)
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_Plateforme:139=(Substring:C12(va_UserPlateforme; 1; 4)+"@"))
		
		// Modifié par : Scanu Rémy (15/02/2022)
		If (String:C10($O_Data.ficheUnique)="true")
			$table_o:=Create entity selection:C1512([HeberGement:5])
			$table_o:=$table_o.orderBy("HG_HB_ID asc, HG_Date desc")
			
			$autreTable_o:=outilsOrdaExtractSingleField("HG_HB_ID"; $table_o)
			
			USE ENTITY SELECTION:C1513($autreTable_o)
			LOAD RECORD:C52([HeberGement:5])
		End if 
		
		$L_Trouve:=Records in selection:C76([HeberGement:5])
		
		// Modifié par : Scanu Rémy (20/12/2023)
		RELATE ONE SELECTION:C349([HeberGement:5]; [HeBerge:4])
		MultiSoc_Filter(->[HeBerge:4])
		
		DISTINCT VALUES:C339([HeBerge:4]HB_Clé:2; $rT_Distinct_cle)  // Nombre de personne unique
		DISTINCT VALUES:C339([HeberGement:5]HG_FamClé:104; $rT_Distinct_FamCle)  // Nombre de ménage
		
		ARRAY OBJECT:C1221($rO_Selection; $L_Trouve)
		
		For ($i; 1; $L_Trouve)
			//CHARGER SUR LIEN([HeberGement]HG_HB_ID)  // on a un hebergé
			QUERY:C277([HeBerge:4]; [HeBerge:4]HB_ReferenceID:1=[HeberGement:5]HG_HB_ID:19)
			
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_FicheNuméro:3); [HeberGement:5]HG_FicheNuméro:3)
			
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_Date:4); [HeberGement:5]HG_Date:4)
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeBerge:4]HB_Clé:2); [HeBerge:4]HB_Clé:2)
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_Lien:18); [HeberGement:5]HG_Lien:18)
			
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_FamChef:103); [HeberGement:5]HG_FamChef:103)
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_FamClé:104); [HeberGement:5]HG_FamClé:104)
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_NuitenCours:92); [HeberGement:5]HG_NuitenCours:92)
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_NuitTOTAL:93); [HeberGement:5]HG_NuitTOTAL:93)
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_Reporté:94); [HeberGement:5]HG_Reporté:94)
			
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_EtatCivil:20); [HeberGement:5]HG_EtatCivil:20)
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeBerge:4]HB_Telephone:66); [HeBerge:4]HB_Telephone:66)
			
			OB SET:C1220($rO_Selection{$i}; "orientation"; [HeberGement:5]HG_AutreSolutio:88+" "+[HeberGement:5]HG_AutreSolSuite:123)
			OB SET:C1220($rO_Selection{$i}; "prestation"; [HeberGement:5]HG_CentreNom:62)
			OB SET:C1220($rO_Selection{$i}; "rapport_reste"; String:C10([HeberGement:5]HG_NuitenCours:92)+"/"+String:C10([HeberGement:5]HG_NuitTOTAL:93))
			
			OB SET:C1220($rO_Selection{$i}; FieldName_to_property(->[HeberGement:5]HG_Cloturée:67); [HeberGement:5]HG_Cloturée:67)
			
			OB SET:C1220($rO_Selection{$i}; "refId"; [HeberGement:5]HG_HB_ID:19)
			OB SET:C1220($rO_Selection{$i}; "ID"; [HeberGement:5]ID:168)
			
			// Modifié par : Scanu Rémy (03/07/2023) et Re-modifié par : Scanu Rémy (15/02/2024)
			// Finalement on affiche les autres fiches hébergements, mais on autorise d'ouvrir uniquement celles liées à la plateforme de l'utilisateur connecté
			// Si c'est une prestation qui est affiché qui a le booléen [LesCentres]LC_Sante = Vrai, mais que l'utilisateur n'appartient pas au groupe Santé il ne peut ni la voir, ni la modifier
			$edit_b:=([HeberGement:5]HG_Plateforme:139=(Substring:C12(w_visiteur.User_Plateforme; 1; 4)+"@"))
			outilsOrdaSearchSimple(->[LesCentres:9]; ->[LesCentres:9]LC_Nom:4; [HeberGement:5]HG_CentreNom:62; ->$centre_e; "first")
			
			If ($centre_e#Null:C1517)
				
				If ($centre_e.LC_Sante=True:C214)
					$edit_b:=outilsManagePrivilege(1; "Santé"; w_userUID)
					
					If ($edit_b=False:C215)
						OB SET:C1220($rO_Selection{$i}; "prestation"; "XXX")
					End if 
					
				End if 
				
			End if 
			
			OB SET:C1220($rO_Selection{$i}; "edit"; $edit_b)
			OB SET:C1220($rO_Selection{$i}; "autresolution"; [HeberGement:5]HG_AutreSolutio:88)
			
/*
$heberge_e:=ds.HeBerge.get([HeBerge]ID)
			
If ($heberge_e#Null)
OB SET($rO_Selection{$i}; "isFamChief"; $heberge_e.isFamChief())
End if 
*/
			
			NEXT RECORD:C51([HeberGement:5])
		End for 
		
		UNLOAD RECORD:C212([HeBerge:4])
		UNLOAD RECORD:C212([HeberGement:5])
End case 

Case of 
	: ($L_MyError=-3)
		$T_Message:="La date de départ n'est pas valide"
	: ($L_MyError=-4)
		$T_Message:="La date de fin n'est pas valide"
	: ($L_MyError=-5)
		$T_Message:="La date de fin est antérieure à celle de début"
	: ($L_MyError=-6)
		$T_Message:="Le champs pour la recherche autres critères n'a pas été défini. Erreur dev."
	: ($L_MyError=-7)
		$T_Message:="Le champs pour la recherche autres critères n'est pas valide. Erreur dev."
	Else 
		$T_Message:="OK"
End case 

OB SET ARRAY:C1227($P_Output->; "hebergement_veille"; $rO_Selection)
OB SET:C1220($P_Output->; "message"; $T_Message)

// Modifié par : Scanu Rémy (20/12/2023)
OB SET:C1220($P_Output->; "nbPersonne"; String:C10(Size of array:C274($rT_Distinct_cle))+" personne"+Choose:C955(Size of array:C274($rT_Distinct_cle)>1; "s"; ""))
OB SET:C1220($P_Output->; "nbMenage"; String:C10(Size of array:C274($rT_Distinct_FamCle))+" ménage"+Choose:C955(Size of array:C274($rT_Distinct_FamCle)>1; "s"; ""))

$0:=$L_MyError