//%attributes = {"preemptive":"capable"}
/*------------------------------------------------------------------------------
Méthode : Web_HG_StatutClôture
LOGICIEL : Samu Social de Paris

Reprise de la méthode Web_HG_StatutClôturé optimisé pour etre thread safe.

Historique
06/12/24 - Grégory Fromain <gregory@connect-io.fr> - Création
------------------------------------------------------------------------------*/


C_LONGINT:C283($kk)
C_BOOLEAN:C305($vb_OK; $continue_b)

// Modifié par : Scanu Rémy (07/02/2024)
// Levé de l'interdiction de cloturer la fiche si celle-ci est inconnue

// Modifié par : Scanu Rémy (20/10/2022)
// Simplification du code
$continue_b:=([HeberGement:5]HG_Cloturée:67=False:C215)

If ($continue_b=False:C215)
	
	If ([HeberGement:5]HG_LC_ID:61<=0)
		w_visiteur.notificationError:="Le champs Nom du logement ou Prestation est vide ou non reconnu, vous devez le (re)sélectionner sur la liste avant de valider la fiche!"
		[HeberGement:5]HG_Cloturée:67:=False:C215
	Else 
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=[HeberGement:5]HG_LC_ID:61)
		MultiSoc_Filter(->[LesCentres:9])
		
		If (Records in selection:C76([LesCentres:9])=1)
			
			Case of 
				: (Value type:C1509(w_visiteur)#Est une variable indéfinie:K8:13) && (w_visiteur#Null:C1517)
					
					
				: ([LesCentres:9]LC_Répertoire:54=Session:C1714.storage.societe.site)
					$vb_OK:=True:C214
				Else 
					ALERT:C41("Vous ne pouvez pas clôturer dans ce centre !")
					[HeberGement:5]HG_Cloturée:67:=False:C215
			End case 
			
		Else 
			[HeberGement:5]HG_Cloturée:67:=False:C215
		End if 
		
		//Si ($vb_OK)
		//// 09/02/2004 : ouverture SP au cas ou il y a clôture
		//CHERCHER([HeBerge]; [HeBerge]HB_ReferenceID=[HeberGement]HG_HB_ID)
		//MultiSoc_Filter(->[HeBerge])
		
		//Si (Enregistrements trouvés([HeBerge])=1)
		//$kk:=Num([HeBerge]HB_Cas1)+Num([HeBerge]HB_Cas2)+Num([HeBerge]HB_Cas3)+Num([HeBerge]HB_Cas4)+Num([HeBerge]HB_Cas5)
		//$kk:=$kk+Num([HeBerge]HB_Cas6)+Num([HeBerge]HB_Cas7)+Num([HeBerge]HB_Cas8)+Num([HeBerge]HB_Cas9)+Num([HeBerge]HB_Cas10)
		//Fin de si 
		//$continue_b:=Vrai
		//Fin de si 
		
	End if 
	
End if 

If ($continue_b=True:C214)
	P_BoolHeureCommute(->[HeberGement:5]HG_Cloturée:67; ->[HeberGement:5]HG_CloturéeHeur:86)
	
	Case of 
		: ([HeberGement:5]HG_Cloturée:67=True:C214)
			[HeberGement:5]HG_EnAttente:64:=False:C215
		: ([HeberGement:5]HG_Transmis:65=False:C215) & ([HeberGement:5]HG_Cloturée:67=False:C215)
			[HeberGement:5]HG_EnAttente:64:=True:C214
	End case 
	
End if 