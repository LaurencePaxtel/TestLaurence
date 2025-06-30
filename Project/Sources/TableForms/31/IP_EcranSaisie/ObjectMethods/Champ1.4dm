Case of 
	: (Form event code:C388=Sur données modifiées:K2:15)
		
		C_LONGINT:C283($pos)
		
		$pos:=Find in array:C230(tb_libelle_profil; [IntervenantsProfils:31]IP_Libéllé:3)
		
		If ($pos>0)
			[IntervenantsProfils:31]IP_Libéllé:3:=""
			ALERT:C41("Erreur! ce profil existe déja")
		End if 
		
End case 