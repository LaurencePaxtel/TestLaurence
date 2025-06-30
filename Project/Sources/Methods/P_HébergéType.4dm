//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure P_HébergéType  
//{
//{          Lundi 28 Juillet 1997 à 16:54:12
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)

va_IDT_TypTrans:=va_IDT_Typ1
$vb_OK:=F_HébergementEtatCivilAge(vd_IDT_NéLe; $1)

Tab_PopIn1("Type"; -><>ta_TBEtCiv; ->va_IDT_Typ1)
If (va_IDT_Typ1>"")
	P_EtatCivil("Sexe_rIDTG_1"; va_IDT_Typ1)
	
	x_IDTG_1:=rIDTG_1
	x_IDTG_2:=rIDTG_2
	If (Substring:C12(va_IDT_Nom; 1; 2)="X0")  // Les inconnus commencent par X0
		Uut_HébergéAgeInconnu(Current date:C33(*))
	End if 
	
	$vb_OK:=F_HébergementEtatCivil(va_IDT_Typ1; ve_HébergéAge)
	If ($vb_OK=False:C215)
		va_IDT_Typ1:=va_IDT_TypTrans
	End if 
End if 
