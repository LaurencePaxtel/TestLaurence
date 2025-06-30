//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_HébergéCtrlCréation
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($B_Creer)
C_POINTER:C301($P_Phone)

If (Substring:C12(va_IDT_Nom; 1; 2)="X0")
	
	Case of 
		: (vd_IDT_NéLe=!00-00-00!)
			StrAlerte(33; "")
		: ((Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)#"M") & (Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)#"P") & (ve_IDT_Age<18))
			StrAlerte(34; "")
		Else 
			$B_Creer:=True:C214
	End case 
	
Else 
	
	Case of 
		: (va_IDT_Nom<="")
			StrAlerte(31; "")  //REFUSER
		: (va_IDT_Pré="")
			StrAlerte(32; "")  //REFUSER 
		: (vd_IDT_NéLe=!00-00-00!)
			StrAlerte(33; "")  //REFUSER
		Else 
			$B_Creer:=True:C214
	End case 
	
End if 

If ($B_Creer)
	$P_Phone:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "telephone")  // ajouté 20/01/2017
	
	x_IDTG_1:=rIDTG_1
	x_IDTG_2:=rIDTG_2
	
	P_HébergéCréer(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe; $P_Phone)  // ->vl_RéfU_HBB
End if 

$0:=$B_Creer