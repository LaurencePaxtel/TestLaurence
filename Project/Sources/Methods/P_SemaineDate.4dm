//%attributes = {}
//{==================================================}
//{ LOGICIEL : Espace loisir DBs©
//{ © DBsolutions
//{         Méthode : P_SemaineDate
//{         Mardi 26 octobre 2010 à 10:10:00
//{         Développement : Jean-Guy Gabbay / Accès 4D : *DBsolutions
//{==================================================}
C_LONGINT:C283($1)
C_DATE:C307($2)
C_POINTER:C301($3)  //Date début
C_POINTER:C301($4)  //Date fin

C_DATE:C307($vd_Date)
Case of 
	: ($1=0)
		If ($2=!00-00-00!)
			va_DateMaJ:="Mise à jour le …"
			va_DateMaJNext:="Veuillez lancer une nouvelle recherche !"
		Else 
			va_DateMaJNext:="Dernière recherche le "+String:C10(Current date:C33; Interne date court:K1:7)+" à "+String:C10(Current time:C178; h mn:K7:2)
		End if 
		
		
	: ($1=1)
		P_SemaineDate(0; !00-00-00!; ->vd_Date1; ->vd_Date2)
		vd_P_DateJ:=$2
		ve_P_Année:=Year of:C25($2)
		
		If (Day number:C114(vd_P_DateJ)#2)
			Repeat 
				vd_P_DateJ:=vd_P_DateJ-1
			Until (Day number:C114(vd_P_DateJ)=2)
		End if 
		
		$3->:=vd_P_DateJ
		$4->:=vd_P_DateJ+6
		$vd_Date:=Current date:C33
		
		
		ve_Ps1:=i_Semaine(vd_P_DateJ)
		
		
		ve_TOC_L:=Day of:C23(vd_P_DateJ)
		ve_TOC_M:=Day of:C23(vd_P_DateJ+1)
		ve_TOC_Me:=Day of:C23(vd_P_DateJ+2)
		ve_TOC_J:=Day of:C23(vd_P_DateJ+3)
		ve_TOC_V:=Day of:C23(vd_P_DateJ+4)
		ve_TOC_S:=Day of:C23(vd_P_DateJ+5)
		ve_TOC_D:=Day of:C23(vd_P_DateJ+6)
		
		
	: ($1=2)  //semaine suivante
		If ($2=!00-00-00!)
			$vd_Date:=Current date:C33
		Else 
			$vd_Date:=Add to date:C393($2; 0; 0; 7)
		End if 
		P_SemaineDate(1; $vd_Date; ->vd_Date1; ->vd_Date2)
		
	: ($1=3)  //semaine précédente
		If ($2=!00-00-00!)
			$vd_Date:=Current date:C33
		Else 
			$vd_Date:=Add to date:C393($2; 0; 0; -7)
		End if 
		P_SemaineDate(1; $vd_Date; ->vd_Date1; ->vd_Date2)
		
End case 

