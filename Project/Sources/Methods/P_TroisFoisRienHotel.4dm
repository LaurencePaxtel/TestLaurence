//%attributes = {}
//P_TroisFoisRienHotels
C_DATE:C307($1)

C_LONGINT:C283($ii; $jj)
C_BOOLEAN:C305($vb_OK)
C_DATE:C307($vd_DateDuJour)
C_TIME:C306($h_RefDoc)
C_TEXT:C284($vt_Texte)
C_LONGINT:C283($vl_Total)
$h_RefDoc:=?00:00:00?

$vd_DateDuJour:=$1
$vt_Texte:=""
$vl_Total:=0

C_DATE:C307($vd_DateDuDebut; $vd_DateDeFin)
$vd_DateDeFin:=$1
$vd_DateDuDebut:=Add to date:C393($vd_DateDeFin; 0; -6; 0)

C_BOOLEAN:C305($B_Continue)
$B_Continue:=i_Confirmer("Nombre de personnes hébergées en hôtel depuis…")

C_OBJECT:C1216($O_Objet)
If (True:C214)
	OB SET:C1220($O_Objet; "$vd_DateDuJour"; $vd_DateDuJour)
	OB SET:C1220($O_Objet; "$B_Continue"; $B_Continue)
	OB SET:C1220($O_Objet; "$vd_DateDuDebut"; $vd_DateDuDebut)
	OB SET:C1220($O_Objet; "$vd_DateDeFin"; $vd_DateDeFin)
	OB SET:C1220($O_Objet; "$vb_OK"; $vb_OK)
	
	ARRAY TEXT:C222(ta_MoisColEtatCivil; 0)
	ARRAY DATE:C224(td_DateAfficheDebut; 0)
	ARRAY DATE:C224(td_DateAfficheFin; 0)
	ARRAY INTEGER:C220(te_MoisDateIndices; 0)
	ARRAY LONGINT:C221(tl_MoisColEtatCivil; 0)
	ARRAY LONGINT:C221(tl_MoisDateJours; 0)
	ARRAY LONGINT:C221(tl_MoisDateJoursPlus; 0)
	ARRAY LONGINT:C221(tl_MoisDatePersonnes; 0)
	ARRAY LONGINT:C221(tl_MoisPersonnes; 0)
	ARRAY LONGINT:C221(tl_MoisPersonnesHB; 0)
	ARRAY LONGINT:C221(tl_MoisPersonnesJ; 0)
	ARRAY LONGINT:C221(tl_MoisPersonnesSel; 0)
	//OB SET ARRAY($O_Objet;"ta_MoisColEtatCivil";ta_MoisColEtatCivil)
	//OB SET ARRAY($O_Objet;"td_DateAfficheDebut";td_DateAfficheDebut)
	//OB SET ARRAY($O_Objet;"td_DateAfficheFin";td_DateAfficheFin)
	//OB SET ARRAY($O_Objet;"te_MoisDateIndices";te_MoisDateIndices)
	//OB SET ARRAY($O_Objet;"tl_MoisColEtatCivil";tl_MoisColEtatCivil)
	//OB SET ARRAY($O_Objet;"tl_MoisDateJours";tl_MoisDateJours)
	//OB SET ARRAY($O_Objet;"tl_MoisDateJoursPlus";tl_MoisDateJoursPlus)
	//OB SET ARRAY($O_Objet;"tl_MoisDatePersonnes";tl_MoisDatePersonnes)
	//OB SET ARRAY($O_Objet;"tl_MoisPersonnes";tl_MoisPersonnes)
	//OB SET ARRAY($O_Objet;"tl_MoisPersonnesHB";tl_MoisPersonnesHB)
	//OB SET ARRAY($O_Objet;"tl_MoisPersonnesJ";tl_MoisPersonnesJ)
	//OB SET ARRAY($O_Objet;"tl_MoisPersonnesSel";tl_MoisPersonnesSel)
End if 

// Modifié par : Kevin HASSAL (06/12/2018)
// On passe la valeur de la variable <>ref_soc_active
// pour les méhodes qui s'exécutent côté serveur

P_TroisFoisRienHotel_serveur(->$O_Objet; <>ref_soc_active)

If (True:C214)
	OB GET ARRAY:C1229($O_Objet; "ta_MoisColEtatCivil"; ta_MoisColEtatCivil)
	OB GET ARRAY:C1229($O_Objet; "td_DateAfficheDebut"; td_DateAfficheDebut)
	OB GET ARRAY:C1229($O_Objet; "td_DateAfficheFin"; td_DateAfficheFin)
	OB GET ARRAY:C1229($O_Objet; "te_MoisDateIndices"; te_MoisDateIndices)
	OB GET ARRAY:C1229($O_Objet; "tl_MoisColEtatCivil"; tl_MoisColEtatCivil)
	OB GET ARRAY:C1229($O_Objet; "tl_MoisDateJours"; tl_MoisDateJours)
	OB GET ARRAY:C1229($O_Objet; "tl_MoisDateJoursPlus"; tl_MoisDateJoursPlus)
	OB GET ARRAY:C1229($O_Objet; "tl_MoisDatePersonnes"; tl_MoisDatePersonnes)
	OB GET ARRAY:C1229($O_Objet; "tl_MoisPersonnes"; tl_MoisPersonnes)
	OB GET ARRAY:C1229($O_Objet; "tl_MoisPersonnesHB"; tl_MoisPersonnesHB)
	OB GET ARRAY:C1229($O_Objet; "tl_MoisPersonnesJ"; tl_MoisPersonnesJ)
	OB GET ARRAY:C1229($O_Objet; "tl_MoisPersonnesSel"; tl_MoisPersonnesSel)
End if 


If ($vb_OK)
	
	$h_RefDoc:=Create document:C266("")
	If (OK=1)
		$vt_Texte:="Nombre de personnes hébergées en hôtel pour les 6 derniers mois jusqu'au "+String:C10($1)+<>va_CR
		$vt_Texte:=$vt_Texte+"Période"+<>va_TAB
		$vt_Texte:=$vt_Texte+"au "+String:C10(td_DateAfficheFin{1})+" - "+"Moins d'un mois"+<>va_TAB
		$vt_Texte:=$vt_Texte+"au "+String:C10(td_DateAfficheFin{2})+" - "+"De un à deux mois"+<>va_TAB
		$vt_Texte:=$vt_Texte+"au "+String:C10(td_DateAfficheFin{3})+" - "+"De deux à trois mois"+<>va_TAB
		$vt_Texte:=$vt_Texte+"au "+String:C10(td_DateAfficheFin{4})+" - "+"De trois à quatre mois"+<>va_TAB
		$vt_Texte:=$vt_Texte+"au "+String:C10(td_DateAfficheFin{5})+" - "+"De quatre à cimq mois"+<>va_TAB
		$vt_Texte:=$vt_Texte+"au "+String:C10(td_DateAfficheFin{6})+" - "+"6 mois et plus"+<>va_TAB
		$vt_Texte:=$vt_Texte+"TOTAL"+<>va_CR
		
		
		USE CHARACTER SET:C205(<>T_Filtre_ISO8859_1_C; 0)  // Filtre export. BS Migration v15
		SEND PACKET:C103($h_RefDoc; $vt_Texte)
		
		$vt_Texte:="Nombre de personnes différentes"+<>va_TAB
		$vt_Texte:=$vt_Texte+String:C10(tl_MoisDatePersonnes{1})+<>va_TAB
		$vt_Texte:=$vt_Texte+String:C10(tl_MoisDatePersonnes{2})+<>va_TAB
		$vt_Texte:=$vt_Texte+String:C10(tl_MoisDatePersonnes{3})+<>va_TAB
		$vt_Texte:=$vt_Texte+String:C10(tl_MoisDatePersonnes{4})+<>va_TAB
		$vt_Texte:=$vt_Texte+String:C10(tl_MoisDatePersonnes{5})+<>va_TAB
		$vt_Texte:=$vt_Texte+String:C10(tl_MoisDatePersonnes{6})+<>va_TAB
		$vt_Texte:=$vt_Texte+String:C10($vl_Total)+<>va_CR
		
		SEND PACKET:C103($h_RefDoc; $vt_Texte)
		
		$vl_Total:=0
		$vt_Texte:=<>va_CR+<>va_CR+"Etat civil"+<>va_CR
		For ($ii; 1; 4)
			$vt_Texte:=$vt_Texte+ta_MoisColEtatCivil{$ii}+<>va_TAB+String:C10(tl_MoisColEtatCivil{$ii})+<>va_CR
			$vl_Total:=$vl_Total+tl_MoisColEtatCivil{$ii}
		End for 
		$vt_Texte:=$vt_Texte+"Total"+<>va_TAB+String:C10($vl_Total)+<>va_CR+<>va_CR
		
		SEND PACKET:C103($h_RefDoc; $vt_Texte)
		
		i_Message("Liste des personnes …")
		QUERY WITH ARRAY:C644([HeberGement:5]HG_ReferenceID:1; tl_MoisPersonnesHB)
		If (Records in selection:C76([HeberGement:5])>0)
			
			$vt_Texte:="Liste des personnes"+<>va_CR
			$vt_Texte:=$vt_Texte+"#"+<>va_TAB
			$vt_Texte:=$vt_Texte+"Clé"+<>va_TAB
			$vt_Texte:=$vt_Texte+"Etat civil"+<>va_TAB
			$vt_Texte:=$vt_Texte+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{31}+<>va_TAB
			$vt_Texte:=$vt_Texte+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{34}+<>va_TAB
			$vt_Texte:=$vt_Texte+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{9}+<>va_TAB
			$vt_Texte:=$vt_Texte+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{13}+<>va_TAB
			$vt_Texte:=$vt_Texte+<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{7}+<>va_CR
			
			SEND PACKET:C103($h_RefDoc; $vt_Texte)
			
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_EtatCivil:20; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_EtatCivil:20; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Nom:21; >; *)
			ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Prénom:22; >)
			//FIRST RECORD([HeberGement])
			
			$jj:=Records in selection:C76([HeberGement:5])
			$ii:=0
			Repeat 
				$ii:=$ii+1
				i_MessageSeul("Liste des personnes …"+String:C10($jj)+"/"+String:C10($ii))
				$vt_Texte:=String:C10($ii)+<>va_TAB+[HeberGement:5]HG_Nom:21+" "+[HeberGement:5]HG_Prénom:22+" "+String:C10([HeberGement:5]HG_DateNéLe:24)+<>va_TAB+[HeberGement:5]HG_EtatCivil:20+<>va_TAB
				$vt_Texte:=$vt_Texte+[HeberGement:5]HG_Ressources1:45+<>va_TAB+[HeberGement:5]HG_SuiviSocial1:49+<>va_TAB+[HeberGement:5]HG_Métro:16+<>va_TAB+[HeberGement:5]HG_SituFamille:29+<>va_TAB+[HeberGement:5]HG_CodePostal:14+<>va_CR
				
				SEND PACKET:C103($h_RefDoc; $vt_Texte)
				
				NEXT RECORD:C51([HeberGement:5])
			Until (End selection:C36([HeberGement:5]))
		End if 
		CLOSE WINDOW:C154
		
		USE CHARACTER SET:C205(*; 0)  // Reset filtre export. BS Migration v15
		CLOSE DOCUMENT:C267($h_RefDoc)
	End if 
	
	
End if 