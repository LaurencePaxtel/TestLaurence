ARRAY TEXT:C222(tb_libelle_profil; 0)
ARRAY LONGINT:C221(tb_id_profil; 0)

vb_Start:=False:C215
FORM SET INPUT:C55([IntervenantsProfils:31]; "IP_EcranSaisie")
FORM SET OUTPUT:C54([IntervenantsProfils:31]; "IP_Liste")

// Modifié par : Kevin HASSAL (01/11/2018)
// Pour le contrôle de validation :
// Le nom du profil doit être unique pour chaque entreprise 
ALL RECORDS:C47([IntervenantsProfils:31])
MultiSoc_Filter(->[IntervenantsProfils:31])

SELECTION TO ARRAY:C260([IntervenantsProfils:31]ID:4; tb_id_profil; [IntervenantsProfils:31]IP_Libéllé:3; tb_libelle_profil)
ADD RECORD:C56([IntervenantsProfils:31]; *)

If (OK=1)
	ADD TO SET:C119([IntervenantsProfils:31]; "E_Courant")
End if 

USE SET:C118("E_Courant")
ORDER BY:C49([IntervenantsProfils:31]; [IntervenantsProfils:31]IP_Libéllé:3; >)