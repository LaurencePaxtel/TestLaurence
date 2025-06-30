//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 22/04/22, 14:47:08
// ----------------------------------------------------
// Méthode : F_HebergementNouveau
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_BOOLEAN:C305($0)

C_LONGINT:C283($vl_Fenetre)
C_BOOLEAN:C305($nouveauFormulaire_b)

C_LONGINT:C283(ve_Cdr1T; ve_Cdr1L; ve_Cdr1B; ve_Cdr1R; ve_Cdr2T; ve_Cdr2L; ve_Cdr2B; ve_Cdr2R; ve_Cdr3T; ve_Cdr3L; ve_Cdr3B; ve_Cdr3R; \
ve_Cdr4T; ve_Cdr4L; ve_Cdr4B; ve_Cdr4R; ve_Cdr5T; ve_Cdr5L; ve_Cdr5B; ve_Cdr5R)

vb_PasseR:=False:C215
$nouveauFormulaire_b:=(va_JourNuit="JN")

If ($nouveauFormulaire_b=False:C215)
	//Liste des demandeurs      
	ve_Cdr1L:=260
	ve_Cdr1T:=59
	ve_Cdr1R:=764
	ve_Cdr1B:=198
	
	//Liste des situations
	ve_Cdr2L:=6
	ve_Cdr2T:=257
	ve_Cdr2R:=764
	ve_Cdr2B:=325
	
	//Liste des situations Page 2
	ve_Cdr5L:=6
	ve_Cdr5T:=264
	ve_Cdr5R:=764
	ve_Cdr5B:=502
	
	//Liste des Groupes
	ve_Cdr3L:=6
	ve_Cdr3T:=285
	ve_Cdr3R:=267
	ve_Cdr3B:=502
	
	//Liste des Membres
	ve_Cdr4L:=290
	ve_Cdr4T:=382
	ve_Cdr4R:=764
	ve_Cdr4B:=502
Else 
	//Liste des demandeurs      
	ve_Cdr1L:=11
	ve_Cdr1T:=290
	ve_Cdr1R:=991
	ve_Cdr1B:=461
	
	//Liste des situations
	ve_Cdr2L:=6
	ve_Cdr2T:=257
	ve_Cdr2R:=764
	ve_Cdr2B:=325
	
	//Liste des situations Page 2
	ve_Cdr5L:=6
	ve_Cdr5T:=264
	ve_Cdr5R:=764
	ve_Cdr5B:=502
	
	//Liste des Groupes
	ve_Cdr3L:=6
	ve_Cdr3T:=285
	ve_Cdr3R:=267
	ve_Cdr3B:=502
	
	//Liste des Membres
	ve_Cdr4L:=10
	ve_Cdr4T:=863
	ve_Cdr4R:=444
	ve_Cdr4B:=993
End if 

P_Tab_GP(-1; 0)

If (True:C214) | (<>vb_GpeOui) & (User in group:C338(Current user:C182; <>Groupe_SaisieGroupes))  // #20180423-1
	
	If (va_JourNuit="JN")
		FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementGpe")
		$vl_Fenetre:=FEN_OpenFormWindow(->[DiaLogues:3]; "DL_HébergementGpe"; Form fenêtre standard:K39:10; "Demandeurs")  //lpc 08122017 plein écran
	Else 
		FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementGpeOld")
		$vl_Fenetre:=FEN_OpenFormWindow(->[DiaLogues:3]; "DL_HébergementGpeOld"; Form fenêtre standard:K39:10; "Nouvel Hébergement")  //lpc 08122017 plein écran
	End if 
	
Else 
	FORM SET INPUT:C55([DiaLogues:3]; "DL_HébergementNouveau")
	$vl_Fenetre:=FEN_OpenFormWindow(->[DiaLogues:3]; "DL_HébergementNouveau"; Form fenêtre standard:K39:10; "Nouvel Hébergement")  //lpc 08122017 plein écran
End if 

MAXIMIZE WINDOW:C453
ADD RECORD:C56([DiaLogues:3])  //lpc 14122017 ascenceur

CLOSE WINDOW:C154
$0:=vb_PasseR