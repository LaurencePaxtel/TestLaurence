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
$0:=False:C215

C_BOOLEAN:C305($B_Creer)
$B_Creer:=False:C215

If (Substring:C12(va_IDT_Nom; 1; 2)="X0")
	Case of 
		: (va_IDT_Typ1<="")
			StrAlerte(30; "")
			//REFUSER
		: (vd_IDT_NéLe=!00-00-00!)
			StrAlerte(33; "")
		: ((Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)#"P") & (ve_IDT_Age<18))
			StrAlerte(34; "")
		: (Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)="P") & (ve_IDT_Age>=18)
			StrAlerte(35; "")
		Else 
			$B_Creer:=True:C214
	End case 
Else 
	
	Case of 
		: (va_IDT_Typ1<="")
			StrAlerte(30; "")  //REFUSER
		: (va_IDT_Nom<="")
			StrAlerte(31; "")  //REFUSER
		: (va_IDT_Pré="")
			StrAlerte(32; "")  //REFUSER
		: (vd_IDT_NéLe=!00-00-00!)
			StrAlerte(33; "")  //REFUSER
		: ((Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)#"P") & (ve_IDT_Age<18))
			StrAlerte(34; "")
		: (Substring:C12(va_IDT_Typ1; Length:C16(va_IDT_Typ1)-1; 1)="P") & (ve_IDT_Age>=18)
			StrAlerte(35; "")
		Else 
			$B_Creer:=True:C214
	End case 
End if 


If ($B_Creer)
	// BS 23/1/17
	// Je déplace ce code qui était 2 fois à l'dentique
	C_POINTER:C301($P_Phone)
	$P_Phone:=OBJECT Get pointer:C1124(Objet nommé:K67:5; "telephone")  // ajouté 20/01/2017
	
	x_IDTG_1:=rIDTG_1
	x_IDTG_2:=rIDTG_2
	$0:=True:C214
	P_HébergéCréer(->va_IDT_Nom; ->va_IDT_Pré; ->vd_IDT_NéLe; $P_Phone)  // ->vl_RéfU_HBB
	If (vb_NewEtC)
		$0:=True:C214
	End if 
End if 
