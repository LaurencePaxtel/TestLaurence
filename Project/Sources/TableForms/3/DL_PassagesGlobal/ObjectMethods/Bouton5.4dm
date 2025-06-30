var $modif_b : Boolean
var $etatCivil_t : Text

ARRAY TEXT:C222($etatCivilDistinct_at; 0)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		COLLECTION TO ARRAY:C1562(Form:C1466.etatCivilDistinct_c; $etatCivilDistinct_at)
		
		$etatCivil_t:=String:C10(Form:C1466.etatCivil)
		Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{40}; ->$etatCivilDistinct_at; ->$etatCivil_t; True:C214)
		
		$modif_b:=(String:C10(Form:C1466.etatCivil)#$etatCivil_t)
		
		If ($modif_b=True:C214)
			Form:C1466.etatCivil:=$etatCivil_t
			//GÉNÉRER APPEL EXTÉRIEUR(Numéro du process courant)
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 