//Script b_VoirPrtL
If (Form event code:C388=Sur clic:K2:4)
	If (User in group:C338(Current user:C182; <>Groupe_Externe))
		StrAlerte(6; "Imprimer liste")
	Else 
		If (User in group:C338(Current user:C182; <>Groupe_Editeur))
			If (Macintosh control down:C544) | (Windows Ctrl down:C562)
				SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
				FIRST RECORD:C50([DossierSocial:25])
				QR REPORT:C197([DossierSocial:25]; Char:C90(1))
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			Else 
				_O_PAGE SETUP:C299([DossierSocial:25]; "DS_PrtListe")
				SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
				FIRST RECORD:C50([DossierSocial:25])
				QR REPORT:C197([DossierSocial:25]; "DossierSocial_1")
				SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
			End if 
			
		Else 
			StrAlerte(6; "Imprimer liste")
		End if 
	End if 
End if 

