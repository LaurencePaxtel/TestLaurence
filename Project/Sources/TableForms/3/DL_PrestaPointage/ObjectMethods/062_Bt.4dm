// ----------------------------------------------------
// Nom utilisateur (OS) : Dev
// Date et heure : 13/07/21, 14:05:48
// ----------------------------------------------------
// Méthode : [DiaLogues].DL_PrestaPointage.062_Bt
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($param1_t; $param2_t)

<>vl_NoHHisto:=0

If (Macintosh control down:C544) | (Windows Ctrl down:C562)
	<>va_PointeCtrNom:=""
	<>va_PointeCtrCP:=""
	<>va_PointeCtrPlateF:=""
	
	<>vl_PointeCtrRéf:=0
	<>vl_PointeCtrMéd:=0
	
	<>vb_PointeCtrMéd:=False:C215
Else 
	
	// Modifié par : Scanu Rémy - remy@connect-io.fr (13/07/2021)
	If (Num:C11(Form:C1466.entree)=1)
		$param1_t:="H"
		$param2_t:="hébergement"
	Else 
		$param1_t:="P"
		$param2_t:="prestation"
	End if 
	
	If (F_HebergementPrestation($param1_t; $param2_t; !00-00-00!; ""))
		<>va_PointeCtrNom:=va_RH_Typ1
		<>va_PointeCtrCP:=va_RH_Typ2
		<>va_PointeCtrPlateF:=""
		
		<>vl_PointeCtrRéf:=vl_RH_RéfID
		<>vl_PointeCtrMéd:=Num:C11(<>vb_PointeCtrMéd=True:C214)
		
		<>vb_PointeCtrMéd:=vb_RH_Médic
	End if 
	
End if 