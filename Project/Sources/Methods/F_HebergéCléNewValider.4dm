//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 22/06/22, 11:29:59
// ----------------------------------------------------
// Méthode : F_HebergéCléNewValider
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)

C_LONGINT:C283($ii)

If (F_HébergéCtrlCréationSEUL)
	QUERY:C277([HeBerge:4]; [HeBerge:4]HB_Clé:2=<>va_TDT_Clé)
	MultiSoc_Filter(->[HeBerge:4])
	
	vL_Nb_HB_F:=Records in selection:C76([HeBerge:4])
	
	If (vL_Nb_HB_F=1)
		$ii:=[HeBerge:4]HB_ReferenceID:1
		va_NNN:=F_AfficheCléHébergé
		
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=$ii)
		MultiSoc_Filter(->[HeberGement:5])
		
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
		ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)
		
		UNLOAD RECORD:C212([HeberGement:5])
	Else 
		REDUCE SELECTION:C351([HeberGement:5]; 0)
		va_NNN:=""
	End if 
	
	MultiSoc_Filter(->[HeberGement:5])
	
	vL_Nb_HG_F:=Records in selection:C76([HeberGement:5])
	P_HébergementNotesBt(0)
	
	If (wresMulti=0)
		OBJECT SET ENABLED:C1123(b_ValHBnew; False:C215)
	End if 
	
	$0:=True:C214
End if 