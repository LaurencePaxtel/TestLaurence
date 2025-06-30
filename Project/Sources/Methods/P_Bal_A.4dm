//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_BAL_A
//{
//{          Lundi 26 février 2007 à 18:34:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_BOOLEAN:C305($vb_OK)
C_TIME:C306($h_RefDoc; vh_Réf)
$h_RefDoc:=?00:00:00?

Case of 
	: ($1=-5)  //Initialisation en fonction des paramètres
		vt_RépTrans:=""
		vt_RépCentre:=""
		vt_RépCentreLu:=""
		
		
		Case of 
			: (<>va_T_QuelleBoiteLettres=<>va_T_LaBoiteLettres)  //BoîteAuxLettres
				//  ◊vt_T_CheminBoite  `Le 23/5/20012
				If (<>vt_T_CheminBoite>"")
					vt_RépTrans:=F_RépertoireCréer(<>vt_T_CheminBoite; 0)
					vt_RépCentre:=F_RépertoireCréer(vt_RépTrans+<>vt_T_DossierRep+Séparateur dossier:K24:12; 0)
					vt_RépCentreLu:=F_RépertoireCréer(vt_RépTrans+<>vt_T_DossierRep+"LU"+Séparateur dossier:K24:12; 1)
				End if 
			: (<>va_T_QuelleBoiteLettres=<>va_T_LaBoiteDalo)  //BoîteDalo
				If (<>vt_T_CheminRépDalo>"")
					vt_RépTrans:=F_RépertoireCréer(<>vt_T_CheminRépDalo; 0)
					vt_RépCentre:=vt_RépTrans
					vt_RépCentreLu:=F_RépertoireCréer(vt_RépTrans+"LU"+Séparateur dossier:K24:12; 1)
				End if 
		End case 
		vl_RépNombre:=0
		
	: ($1=-3)
		vt_CheminDuDocu:=vt_RépCentre+tt_TransDocuDisk{tt_TransDocu}
		
		
		vt_CheminDuDocuNew:=vt_RépCentreLu+tt_TransDocu{tt_TransDocu}+("_A"*Num:C11(te_TransDocuCas{tt_TransDocu}=1))+("_R"*Num:C11(te_TransDocuCas{tt_TransDocu}=-1))
		If (<>vb_CestUnMac)
			If (Test path name:C476(vt_CheminDuDocu)=Est un document:K24:1)
				//COPIER DOCUMENT(vt_CheminDuDocu;vt_CheminDuDocuNew)
				DELETE DOCUMENT:C159(vt_CheminDuDocu)
				tt_TransDocuDisk{tt_TransDocu}:=tt_TransDocu{tt_TransDocu}+("_A"*Num:C11(te_TransDocuCas{tt_TransDocu}=1))+("_R"*Num:C11(te_TransDocuCas{tt_TransDocu}=-1))
			End if 
		Else 
			If (Test path name:C476(vt_CheminDuDocu+".TXT")=Est un document:K24:1)
				//COPIER DOCUMENT(vt_CheminDuDocu+".TXT";vt_CheminDuDocuNew+".TXT")
				DELETE DOCUMENT:C159(vt_CheminDuDocu+".TXT")
				tt_TransDocuDisk{tt_TransDocu}:=tt_TransDocu{tt_TransDocu}+("_A"*Num:C11(te_TransDocuCas{tt_TransDocu}=1))+("_R"*Num:C11(te_TransDocuCas{tt_TransDocu}=-1))
			End if 
		End if 
		
		
	: ($1=-2)
		REDRAW:C174(ve_DocuStatut)
		If (Size of array:C274(tt_TransDocu)>0)
			If (tt_TransDocu>0)
				If (te_TransDocuCas{tt_TransDocu}=ve_DocuStatut)
				Else 
					te_TransDocuCas{tt_TransDocu}:=ve_DocuStatut
					P_Bal_A(-3)
				End if 
			End if 
		End if 
		
	: ($1=-1)  //Réfusé
		ve_DocuStatut:=-1
		P_Bal_A(-2)
		FORM GOTO PAGE:C247(1)
		
	: ($1=0)  //Pas lu
		If (Size of array:C274(tt_TransDocu)>0)
			If (tt_TransDocu>0)
				If (te_TransDocuCas{tt_TransDocu}=0)
				Else 
					vt_CheminDuDocu:=vt_RépCentreLu+tt_TransDocu{tt_TransDocu}+("_A"*Num:C11(te_TransDocuCas{tt_TransDocu}=1))+("_R"*Num:C11(te_TransDocuCas{tt_TransDocu}=-1))
					vt_CheminDuDocuNew:=vt_RépCentre+Substring:C12(tt_TransDocuDisk{tt_TransDocu}; 1; Length:C16(tt_TransDocuDisk{tt_TransDocu})-2)
					$vb_OK:=False:C215
					If (<>vb_CestUnMac)
						If (Test path name:C476(vt_CheminDuDocu)=Est un document:K24:1)
							//COPIER DOCUMENT(vt_CheminDuDocu;vt_CheminDuDocuNew)
							DELETE DOCUMENT:C159(vt_CheminDuDocu)
							$vb_OK:=True:C214
						End if 
					Else 
						If (Test path name:C476(vt_CheminDuDocu+".TXT")=Est un document:K24:1)
							//COPIER DOCUMENT(vt_CheminDuDocu+".TXT";vt_CheminDuDocuNew+".TXT")
							DELETE DOCUMENT:C159(vt_CheminDuDocu+".TXT")
							
							$vb_OK:=True:C214
						End if 
					End if 
					If ($vb_OK)
						ve_DocuStatut:=0
						te_TransDocuCas{tt_TransDocu}:=ve_DocuStatut
					End if 
				End if 
			End if 
		End if 
End case 