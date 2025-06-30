//%attributes = {"preemptive":"capable"}
/*------------------------------------------------------------------------------
Méthode : Web_HB_Pointage_Multiple

Pointage multiple sur le web
(Héritage de la méthode HB_Pointage_Multiple)

Historique
08/12/24 - Grégory Fromain <gregory@connect-io.fr> - Création
 ------------------------------------------------------------------------------*/

C_TEXT:C284($hb_cle)
C_LONGINT:C283($i)
C_BOOLEAN:C305(var_saisie_differee)
ARRAY LONGINT:C221($tb_hb_ids; 0)

$hb_cle:=va_NNN
va_JourNuit:="N"

QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=va_NNN)
MultiSoc_Filter(->[HeBerge:4])

SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $tb_hb_ids)

For ($i; 1; Size of array:C274(tb_centre_choix))
	
	If (tb_centre_choix{$i}=True:C214)
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tb_centre_liste_id{$i})
		MultiSoc_Filter(->[LesCentres:9])
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (09/12/2022) et re-Modifié par Scanu Rémy (24/03/2023)
		HG_Pointage($hb_cle; 0; tb_centre_liste_quantite{$i}; dateCreationFiche_d; tb_centre_liste_montant{$i})
	End if 
	
End for 
