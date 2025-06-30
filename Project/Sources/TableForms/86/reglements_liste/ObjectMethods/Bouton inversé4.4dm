// ----------------------------------------------------
// User name (OS): Kevin HASSAL
// Date and time: 25/02/20, 21:17:25
// ----------------------------------------------------
// Method: [Factures].reglements_liste.Bouton inversé4
// Description
// 
//
// Parameters
// ----------------------------------------------------
C_DATE:C307($dateDu_d; $dateAu_d)

Case of 
	: (Form event code:C388=Sur clic:K2:4)
		$dateDu_d:=Form:C1466.dateDu
		$dateAu_d:=Form:C1466.dateAu
		
		If (F_PlageEnCours(ve_Date_Cas; 1; ->$dateDu_d; ->$dateAu_d))
			Form:C1466.dateDu:=$dateDu_d
			Form:C1466.dateAu:=$dateAu_d
			
			REG_Get_Liste
		End if 
		
End case 