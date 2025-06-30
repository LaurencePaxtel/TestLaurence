//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_Report_FullDuplexTitreB
//{
//{          Mardi 18 novembre 2008 à 11:36
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_BOOLEAN:C305($0)
$0:=False:C215
C_TEXT:C284($1)




<>vt_ConsoB_Document:=$1

<>va_ConsoB_FicheSiteCode:=Substring:C12(<>vt_ConsoB_Document; 1; 3)
<>va_ConsoB_FicheSite:=""

<>vd_ConsoB_FicheDate:=!00-00-00!
<>vd_ConsoB_FicheDate:=Date:C102(Substring:C12(<>vt_ConsoB_Document; 8; 2)+"/"+Substring:C12(<>vt_ConsoB_Document; 6; 2)+"/"+Substring:C12(<>vt_ConsoB_Document; 4; 2))
<>va_ConsoB_FicheJour:=Uppercase:C13(<>vt_ConsoB_Document[[15]])+("our"*Num:C11(<>vt_ConsoB_Document[[15]]="J"))+("uit"*Num:C11(<>vt_ConsoB_Document[[15]]="N"))

<>va_ConsoB_FicheNo:=Substring:C12(<>vt_ConsoB_Document; 16; 5)

<>va_ConsoB_FicheET:=Substring:C12(<>vt_ConsoB_Document; 22; 2)
If (Length:C16(<>va_ConsoB_FicheET)=2)
	
	If (<>va_ConsoB_FicheET[[1]]="H")
		If (<>va_ConsoB_FicheET[[2]]="P")
			<>va_ConsoB_FicheGenre:="Mineur masculin"
		Else 
			<>va_ConsoB_FicheGenre:="Homme"
		End if 
	Else 
		If (<>va_ConsoB_FicheET[[2]]="P")
			<>va_ConsoB_FicheGenre:="Mineur féminin"
		Else 
			<>va_ConsoB_FicheGenre:="Femme"
		End if 
	End if 
End if 
<>va_ConsoB_FicheAge:=Substring:C12(<>vt_ConsoB_Document; 24; 2)
$vl_Temp:=Num:C11(<>va_ConsoB_FicheAge)
Case of 
	: ($vl_Temp=0)
		<>va_ConsoB_FicheAge:="Nouveau né"
	: ($vl_Temp=1)
		<>va_ConsoB_FicheAge:="1 an"
	: ($vl_Temp>1)
		<>va_ConsoB_FicheAge:=String:C10($vl_Temp)+" ans"
End case 

$0:=True:C214