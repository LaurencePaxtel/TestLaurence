var $centreHebergement_t : Text
var $modif_b : Boolean

ARRAY TEXT:C222($centreHebergementDistinct_at; 0)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		COLLECTION TO ARRAY:C1562(Form:C1466.centreHebergementDistinct_c; $centreHebergementDistinct_at)
		
		$centreHebergement_t:=String:C10(Form:C1466.centreHebergement)
		Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}; ->$centreHebergementDistinct_at; ->$centreHebergement_t; True:C214)
		
		$modif_b:=(String:C10(Form:C1466.centreHebergement)#$centreHebergement_t)
		
		If ($modif_b=True:C214)
			Form:C1466.centreHebergement:=$centreHebergement_t
			//GÉNÉRER APPEL EXTÉRIEUR(Numéro du process courant)
		End if 
		
	: (Form event code:C388=Sur survol:K2:35)
		SET CURSOR:C469(9000)
End case 