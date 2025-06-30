//%attributes = {"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Laurence et Grég
// Date et heure : 18/10/24, 11:36:19
// ----------------------------------------------------
// Méthode : web_F_LienDeFamille
// Description
// 
//
// Paramètres
// ----------------------------------------------------

var $0 : Text
var $1 : Text

var $i_el : Integer

var $cleFamTemporaire_e : cs:C1710.CleFamTemporaireEntity
var $cleFamTemporaire_es : cs:C1710.CleFamTemporaireSelection
var $structure_t : Text
If (Session:C1714.storage.intervenant.Ref_Structure#Null:C1517)
	$structure_t:=Session:C1714.storage.intervenant.Ref_Structure
Else 
	$structure_t:=Storage:C1525.societeDetail.Ref_Structure
End if 

Case of 
	: ($1="Nouveau")
		
		Case of 
			: (Value type:C1509(w_visiteur)#Est une variable indéfinie:K8:13) && (w_visiteur#Null:C1517)
				
				Repeat 
					$0:=[HeBerge:4]Ref_Structure:67+String:C10(outilsHebergeGenKeyLinkFam(False:C215; True:C214; $i_el))
					outilsOrdaSearchSimple(->[CleFamTemporaire:137]; ->[CleFamTemporaire:137]cle:2; $0; ->$cleFamTemporaire_es)
					
					If ($cleFamTemporaire_es.length=0)
						$cleFamTemporaire_e:=ds:C1482.CleFamTemporaire.new()
						
						$cleFamTemporaire_e.date:=Current date:C33(*)
						$cleFamTemporaire_e.heure:=Current time:C178(*)
						$cleFamTemporaire_e.intervenantID:=w_userUID
						$cleFamTemporaire_e.cle:=$0
						$statut_o:=$cleFamTemporaire_e.save()
					Else 
						$i_el+=1
					End if 
					
				Until ($cleFamTemporaire_es.length=0)
				
			Else 
				$0:=$structure_t+String:C10(outilsHebergeGenKeyLinkFam(False:C215; False:C215; 0))
		End case 
		
End case 