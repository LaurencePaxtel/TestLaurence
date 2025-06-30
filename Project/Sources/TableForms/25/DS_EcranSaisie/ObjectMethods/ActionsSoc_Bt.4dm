
If (Is new record:C668([DossierSocial:25]))
	StrAlerte(51; "'Dossier social")
Else 
	vl_RefMrid:=0
	vl_RefMrid:=[DossierSocial:25]DS_HB_ID:10
	vl_RefDS:=0
	vl_RefDS:=[DossierSocial:25]DS_Référence:1
	
	READ WRITE:C146([DiaLogues:3])
	FORM SET INPUT:C55([DiaLogues:3]; "DL_DosActionSociale")
	$vl_Fenetre:=i_FenêtreNo(632; 312; 4; [DossierSocial:25]DS_Nom:12+" "+[DossierSocial:25]DS_Prénom:16+" : Actions sociales"; 3; "Quit_Simple")
	ADD RECORD:C56([DiaLogues:3]; *)
	UNLOAD RECORD:C212([DiaLogues:3])
	CLOSE WINDOW:C154($vl_Fenetre)
	READ ONLY:C145([DiaLogues:3])
	
End if 
