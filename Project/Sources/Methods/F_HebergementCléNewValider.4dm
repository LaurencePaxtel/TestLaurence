//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 22/06/22, 11:24:41
// ----------------------------------------------------
// Méthode : F_HebergementCléNewValider
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)

//••••NOUVELLE CLE & NOUVEL HEBERGEMENT••••
If (F_HébergéCtrlCréationSEUL)
	vb_ResGroupe:=False:C215
	vb_ResMulti:=False:C215
	
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>va_TDT_Clé)
	MultiSoc_Filter(->[HeBerge:4])
	
	vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
	
	If (vL_Nb_HB_F=1)
		va_NNN:=F_AfficheCléHébergé
		
		Rec_Hébergements1
		vl_NbHéberGements:=Records in selection:C76([HeberGement:5])
		
		If (F_HebergementNewValider(True:C214; False:C215))
			outilsManageHebergement(1)
		End if 
		
	Else 
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		va_NNN:=""
	End if 
	
	vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
	P_HébergementNotesBt(0)
	
	If (wresMulti=0)
		OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
	End if 
	
	$0:=True:C214
End if 