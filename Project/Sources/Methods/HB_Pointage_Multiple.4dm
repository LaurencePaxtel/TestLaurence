//%attributes = {}
// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 16/10/19, 20:12:38
// ----------------------------------------------------
// Method: HB_Pointage_Multiple
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_TEXT:C284($hb_cle)
C_LONGINT:C283($i)
C_BOOLEAN:C305($mode_web; var_saisie_differee)

ARRAY LONGINT:C221($tb_hb_ids; 0)

If (Count parameters:C259>0)
	$mode_web:=$1
End if 

$hb_cle:=va_NNN
va_JourNuit:="N"

QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=va_NNN)
MultiSoc_Filter(->[HeBerge:4])

SELECTION TO ARRAY:C260([HeBerge:4]ID:65; $tb_hb_ids)

$progress_id:=Progress New

Progress SET TITLE($progress_id; "Pointage..."; -1; "en cours d'exécution...")
Progress SET BUTTON ENABLED($progress_id; True:C214)


For ($i; 1; Size of array:C274(tb_centre_choix))
	
	If (tb_centre_choix{$i}=True:C214)
		QUERY:C277([LesCentres:9]; [LesCentres:9]LC_RéférenceID:1=tb_centre_liste_id{$i})
		MultiSoc_Filter(->[LesCentres:9])
		
		If (Not:C34($mode_web))
			Progress SET PROGRESS($progress_id; $i/Size of array:C274(tb_centre_choix); "Pointage..."+String:C10($i)+" / "+String:C10(Size of array:C274(tb_centre_choix)); True:C214)
			Progress SET MESSAGE($progress_id; "Encours... "+[LesCentres:9]LC_Nom:4; True:C214)
		End if 
		
		// Modifié par : Scanu Rémy - remy@connect-io.fr (09/12/2022) et re-Modifié par Scanu Rémy (24/03/2023)
		HG_Pointage($hb_cle; 0; tb_centre_liste_quantite{$i}; dateCreationFiche_d; tb_centre_liste_montant{$i})
	End if 
	
	If (Progress Stopped($progress_id))
		$i:=Size of array:C274(tb_centre_choix)
	End if 
	
	
End for 

QUERY WITH ARRAY:C644([HeBerge:4]ID:65; $tb_hb_ids)

vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])

ORDER BY:C49([HeBerge:4]; [HeBerge:4]HB_Clé:2; >)
FIRST RECORD:C50([HeBerge:4])

REDUCE SELECTION:C351([HeberGement:5]; 0)

vL_Nb_HG_F:=0
va_NNN:=""

P_HébergementNotesBt(0)

//============================================//
// sélectionner le premier et affichier les
// fiches d'hébergement du premier hebergé
// de la liste
//============================================//
If ([HeBerge:4]HB_ReferenceID:1>0)
	va_NNN:=F_AfficheCléHébergé
	
	Rec_Hébergements1(->vL_Nb_HG_F)
	P_HébergementNotesBt(1)
Else 
	REDUCE SELECTION:C351([HeberGement:5]; 0)
	
	vL_Nb_HG_F:=0
	va_NNN:=""
	
	P_HébergementNotesBt(0)
End if 

Progress QUIT($progress_id)
