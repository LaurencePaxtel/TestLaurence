//Script b_VoirPrtL
If (Form event code:C388=Sur clic:K2:4)
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		StrAlerte(6; "Imprimer liste")
	Else 
		If (User in group:C338(Current user:C182; <>Groupe_Editeur) | User in group:C338(Current user:C182; <>Groupe_DEVELOP))
			
			//If (Macintosh control down) | (Windows Ctrl down)
			
			//SET AUTOMATIC RELATIONS(True;True)
			//FIRST RECORD([Maraude])
			//QR REPORT([Maraude];Char(1))
			//SET AUTOMATIC RELATIONS(False;False)
			
			//Else 
			
			//  //PAGE SETUP([HeberGement];"HG_PrtVeille")
			//SET AUTOMATIC RELATIONS(True;True)
			//FIRST RECORD([Maraude])
			//QR REPORT([Maraude];"Stat01")
			//SET AUTOMATIC RELATIONS(False;False)
			
			//End if 
			
			// 20/12/16
			// Générique en remplacement du code dans le bouton
			Open Quick report(->[Maraude:24])
		Else 
			StrAlerte(6; "Imprimer liste")
		End if 
	End if 
End if 

