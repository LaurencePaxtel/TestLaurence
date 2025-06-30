//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : remyscanu
// Date et heure : 02/08/22, 14:22:57
// ----------------------------------------------------
// Méthode : outilsManageEquipement
// Description
// 
//
// Paramètres
// ----------------------------------------------------
var $1 : Integer
var $2 : Variant
var $3 : Variant

var $i_el : Integer
var $statut_o : Object

var $equipement_e : cs:C1710.EquipementEntity
var $equipement_es; $autreEquipement_es : cs:C1710.EquipementSelection

var $equipementBien_e : cs:C1710.EquipementBienEntity
var $equipementBien_es : cs:C1710.EquipementBienSelection


If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$refSocActive_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$refSocActive_t:=Storage:C1525.societeDetail.Ref_Structure
End if 


If (Value type:C1509(ref_soc_active)#Est une variable indéfinie:K8:13) && (ref_soc_active#"")
	$refSocActive_t:=ref_soc_active
End if 

Case of 
	: ($1=1)
		
		Case of 
			: ($2="Kit mobilier")
				outilsManageEquipement(10; $2; "Lit simple"; "Lit double"; "Lit bébé"; "Table à manger"; "Chaises"; "Matelas simple"; "Matelas double"; "Matelas bébé"; "Lit parapluie"; \
					"Lits superposés"; "Lits gigognes"; "Bureau"; "Table de chevet"; "Armoire"; "Commodes"; "Colonnes"; "Canapé fixe/angle"; "Canapé BZ"; "Canapé Clic Clac"; \
					"Fauteuil"; "Housse de canapé"; "Meuble TV"; "Table basse"; "Tabourets"; "Haut 1 porte"; "Haut 2 portes"; "Dessus de hotte"; "Bas 1 porte"; "Bas 2 portes"; \
					"Bas porte/tiroirs"; "Bas tiroirs"; "Sous vasque"; "Armoire à pharmacie")
			: ($2="Kit vaisselle")
				outilsManageEquipement(10; $2; "Assiettes"; "Verres"; "Fourchettes"; "Cuillères à soupe"; "Cuillères à café"; "Couteaux de cuisine"; "Couteaux de table"; "Bols"; "Mugs"; \
					"Tasses"; "Saladier"; "Poêle"; "Passoire"; "Faitout"; "Casseroles"; "Plat de présentation"; "Louche"; "Spatule"; "Econome"; "Ouvre boite"; "Cuillère de service"; "Ecumoire"; \
					"Planche à découper"; "Plat à four"; "Couvercle"; "Dessous de plat")
			: ($2="Kit linge")
				outilsManageEquipement(10; $2; "Alèse simple"; "Alèse double"; "Alèse bébé"; "Drap plat simple"; "Drap plat lit double"; "Drap housse lit simple"; "Drap housse bébé"; \
					"Drap housse lit double"; "Housse couette simple"; "Housse couette double"; "Couverture bébé"; "Gigoteuse"; "Taie"; "Oreillers"; "Coussins"; "Torchon"; \
					"Serviette petit format"; "Serviette grand format")
			: ($2="Kit entretien")
				outilsManageEquipement(10; $2; "Manche à balai"; "Embout classique"; "Embout brosse"; "Poubelle"; "Seau"; "Pelle/balayette"; "Lessive"; "Produit multi usage"; \
					"Produit vitres"; "Produit WC"; "Produit vaisselle"; "Serpillère"; "Eponge"; "Eponge magique"; "Brosse à WC"; "Panière à linge"; "Rideau de douche"; "Sac poubelle"; \
					"Pinces à linge"; "Lunette de toilette"; "Tapis de bain"; "Étendoir"; "Tapis")
			: ($2="Kit hygiène bébé")
				outilsManageEquipement(10; $2; "Lait bébé"; "Couches"; "Lingettes"; "Sérum physiologique"; "Tétines"; "Biberon"; "Gel lavant")
			: ($2="Kit électroménager")
				outilsManageEquipement(10; $2; "Frigo top"; "Frigo combiné congélateur"; "Cuisinière"; "Plaque chauffante 2 foyers"; "Plaque chauffante 3 foyers"; "Plaque chauffante 4 foyers"; \
					"Four"; "Micro-onde"; "Hotte"; "Lave-vaisselle"; "Lave-linge"; "Télévision"; "Box tv"; "Lampe")
		End case 
		
	: ($1=2)  // Création éventuelle de l'équipement pour le Kit X
		$equipement_e:=ds:C1482.Equipement.new()
		
		$equipement_e.Ref_Structure:=$refSocActive_t
		$equipement_e.EQU_Type:=$2
		$equipement_e.EQU_Nom:=$3
		$equipement_e.EQU_Quantite_Initiale:=1
		$equipement_e.save()
	: ($1=10)  // Vérification pour une équipement X du bien Y
		
		For ($i_el; 3; Count parameters:C259)
			$equipement_es:=ds:C1482.Equipement.query("EQU_Nom = :1 AND Ref_Structure = :2"; ${$i_el}; $refSocActive_t)
			
			If ($equipement_es.length=0)  // Si l'équipement n'existe pas déjà pour la structure connecté, alors on la créé à la volée
				outilsManageEquipement(2; $2; ${$i_el})
			End if 
			
		End for 
		
		$equipement_es:=ds:C1482.Equipement.query("EQU_Type = :1 AND Ref_Structure = :2"; $2; $refSocActive_t)
		
		For each ($equipement_e; $equipement_es)
			
			If ($equipement_e.AllEquipementBien.OneBien.query("ID = :1"; Num:C11(w_visiteur.bienID)).length=0)  // L'équipement pour le bien en modification n'a pas encore été ajouté au sein de celui-ci
				$equipementBien_e:=ds:C1482.EquipementBien.new()
				
				$equipementBien_e.bienID:=Num:C11(w_visiteur.bienID)
				$equipementBien_e.equipementID:=$equipement_e.ID
				$equipementBien_e.dateInstallation:=Current date:C33
				$equipementBien_e.quantite:=1
				$equipementBien_e.save()
			End if 
			
		End for each 
		
	: ($1=20)
		$equipementBien_e:=ds:C1482.EquipementBien.get($2.id)
		
		If ($equipementBien_e=Null:C1517) & ($2.bienID#Null:C1517)
			$equipementBien_es:=ds:C1482.EquipementBien.query("bienID = :1 AND equipementID = :2 AND dateInstallation >= :3"; Num:C11($2.bienID); Num:C11($2.ple_equ_id); Date:C102($2.ple_date_installation))
			
			If ($equipementBien_es.length>0)
				$equipementBien_e:=$equipementBien_es.first()
			Else 
				$equipementBien_e:=ds:C1482.EquipementBien.new()
				$equipementBien_e.bienID:=Num:C11($2.bienID)
				$equipementBien_e.equipementID:=Num:C11($2.ple_equ_id)
				$equipementBien_e.dateInstallation:=Date:C102($2.ple_date_installation)
			End if 
			
			$equipementBien_e.quantite:=Num:C11($2.ple_quantite)
			$statut_o:=$equipementBien_e.save()
			
		End if 
		
		If ($equipementBien_e#Null:C1517)  // On a bien trouvé l'enregistrement
			$equipement_es:=$equipementBien_e.OneBien.AllEquipementBien.OneEquipement.query("Ref_Structure = :1"; ref_soc_active)
			$autreEquipement_es:=$equipement_es.query("EQU_Type = :1 AND EQU_Nom = :2"; String:C10($2.ple_equ_type); String:C10($2.ple_equ_id))
			
			If ($autreEquipement_es.length=0)
				$3->:="Vrai"
				return 
			End if 
			
			If ($autreEquipement_es[0].ID#$equipementBien_e.OneEquipement.ID)  // L'utilisateur a changé l'équipement
				$autreEquipement_es:=$equipementBien_e.OneBien.AllEquipementBien.query("equipementID = :1"; $autreEquipement_es[0].ID)
				
				If ($autreEquipement_es.length=0)
					$equipementBien_e.drop()
					outilsManageEquipement(10; $2.ple_equ_type; $2.ple_equ_id)
					
					$3->:="Vrai"
				Else   // L'équipement a déjà été affecté à ce bien
					$3->:="Failed"
				End if 
				
			Else 
				$equipementBien_e.dateInstallation:=Date:C102($2.ple_date_installation)
				$equipementBien_e.quantite:=Num:C11($2.ple_quantite)
				$equipementBien_e.save()
			End if 
			
		End if 
		
End case 