//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_Report_FullDuplexTitre
//{          Mardi 14 novembre 2008 à 12:46
//{          Modifiée : 14 novembre 2008 à 12:46
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
C_TEXT:C284($1)


<>vt_Conso_CeminDossier:=""
<>vt_Conso_Dossier:=""
<>vt_Conso_Document:=""

<>va_Conso_FicheSiteCode:=""
<>va_Conso_FicheSite:=""

<>vd_Conso_FicheDate:=!00-00-00!
<>va_Conso_FicheJour:=""
<>va_Conso_FicheNo:=""
<>va_Conso_FicheET:=""
<>va_Conso_FicheGenre:=""
<>va_Conso_FicheAge:=""

If ((Length:C16($1)=25) | (Length:C16($1)=29))
	<>vt_Conso_Document:=$1
	
	<>va_Conso_FicheSiteCode:=Substring:C12(<>vt_Conso_Document; 1; 3)
	<>va_Conso_FicheSite:=""
	
	<>vd_Conso_FicheDate:=!00-00-00!
	<>vd_Conso_FicheDate:=Date:C102(Substring:C12(<>vt_Conso_Document; 8; 2)+"/"+Substring:C12(<>vt_Conso_Document; 6; 2)+"/"+Substring:C12(<>vt_Conso_Document; 4; 2))
	<>va_Conso_FicheJour:=Uppercase:C13(<>vt_Conso_Document[[15]])+("our"*Num:C11(<>vt_Conso_Document[[15]]="J"))+("uit"*Num:C11(<>vt_Conso_Document[[15]]="N"))
	
	<>va_Conso_FicheNo:=Substring:C12(<>vt_Conso_Document; 16; 5)
	
	<>va_Conso_FicheET:=Substring:C12(<>vt_Conso_Document; 22; 2)
	If (Length:C16(<>va_Conso_FicheET)=2)
		
		If (<>va_Conso_FicheET[[1]]="H")
			If (<>va_Conso_FicheET[[2]]="P")
				<>va_Conso_FicheGenre:="Mineur masculin"
			Else 
				<>va_Conso_FicheGenre:="Homme"
			End if 
		Else 
			If (<>va_Conso_FicheET[[2]]="P")
				<>va_Conso_FicheGenre:="Mineur féminin"
			Else 
				<>va_Conso_FicheGenre:="Femme"
			End if 
		End if 
	End if 
	<>va_Conso_FicheAge:=Substring:C12(<>vt_Conso_Document; 24; 2)
	$vl_Temp:=Num:C11(<>va_Conso_FicheAge)
	Case of 
		: ($vl_Temp=0)
			<>va_Conso_FicheAge:="Nouveau né"
		: ($vl_Temp=1)
			<>va_Conso_FicheAge:="1 an"
		: ($vl_Temp>1)
			<>va_Conso_FicheAge:=String:C10($vl_Temp)+" ans"
	End case 
End if 