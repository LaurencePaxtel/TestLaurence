//%attributes = {}

//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_HebergementNewTrans
//{
//{          Lundi 26 février 2007 à 11:35:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=False:C215

C_TIME:C306($h_RefDoc)
$h_RefDoc:=?00:00:00?
C_TEXT:C284(vt_NomFic; vt_texte)
C_TEXT:C284(vt_RépTrans; vt_RépCentre; vt_RépCentreLu; vt_RépDocu; vt_LeDocument)
C_LONGINT:C283($ii; $vl_Docu)
ARRAY TEXT:C222(tt_TransDocu; 0)
ARRAY INTEGER:C220(te_TransDocuCas; 0)
ARRAY TEXT:C222(ta_TransDocuTri; 0)

//◊vt_T_CheminRép:=[SOciété]SO_CheminRépertoire
//◊vt_T_DossierRep:=[SOciété]SO_RépertoireSite
//Existance du répértoire Trans

vt_RépTrans:=""
vt_RépCentre:=""
vt_RépCentreLu:=""

//Tester l'éxistance du répertoire
$vb_OK:=F_Répertoire(<>vt_T_CheminRép)
If ($vb_OK=False:C215)
	ALERT:C41("Veuillez vérifier le chemin d'accès du répertoire de transfert !")
Else 
	$vb_OK:=False:C215
	vt_RépTrans:=F_RépertoireCréer(<>vt_T_CheminRép; 0)
	vt_RépCentre:=F_RépertoireCréer(vt_RépTrans+<>vt_T_DossierRep+Séparateur dossier:K24:12; 0)
	If (vt_RépCentre>"")
		vt_RépCentreLu:=F_RépertoireCréer(vt_RépTrans+<>vt_T_DossierRep+"LU"+Séparateur dossier:K24:12; 1)
		If (vt_RépCentreLu>"")
			$vb_OK:=True:C214
		Else 
			ALERT:C41("Veuillez vérifier la présence du dossier des documents lus !")
		End if 
	Else 
		ALERT:C41("Veuillez vérifier le chemin d'accès du répertoire du site !")
	End if 
End if 


If ($vb_OK)
	DOCUMENT LIST:C474(vt_RépCentre; tt_TransDocu)
	$vl_Docu:=Size of array:C274(tt_TransDocu)
	//TO 07022615h54J15789 HS63
	If ($vl_Docu>0)
		ARRAY INTEGER:C220(te_TransDocuCas; $vl_Docu)
		ARRAY TEXT:C222(ta_TransDocuTri; $vl_Docu)
		For ($ii; 1; $vl_Docu)
			te_TransDocuCas{$ii}:=0
			ta_TransDocuTri{$ii}:=Substring:C12(tt_TransDocu{$ii}; 1; (Position:C15(ta_TransDocuTri{$ii}; "h")+2))
		End for 
		SORT ARRAY:C229(ta_TransDocuTri; tt_TransDocu; te_TransDocuCas; >)
		
		$vl_Fenetre:=i_FenêtreNo(456; 412; 5; $1; 3; "Boite aux lettres")
		DIALOG:C40([DiaLogues:3]; "DL_TablesTrans")
		CLOSE WINDOW:C154($vl_Fenetre)
		
		
		$0:=True:C214
	Else 
		ALERT:C41("Aucun document reçu !")
	End if 
End if 