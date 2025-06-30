//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{
//{          Procédure : F_SIAO_Var_SsTotal
//{
//{          Mardi 18 janvier 2011 à 13:54
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_POINTER:C301($4)
C_LONGINT:C283($5)
C_BOOLEAN:C305($vb_OK)
C_TEXT:C284($va_Theme; $va_SousTheme)
$va_Theme:=ta_SIAO_PageTitre{5}  //"RESSOURCES"

Case of 
	: ($1=0)
		
		C_REAL:C285(vr_Ss_TOTAL_RSAnnuel; vr_Ss_TOTAL_DTAnnuel; vr_Ss_TOTAL_Disponible; vr_Ss_TOTAL_DisponibleMois; vr_Ss_TOTAL_Txdeffort)
		
		C_LONGINT:C283(vl_Ss_RS_Reference1)
		C_LONGINT:C283(vl_Ss_RS_SIAO_ID1)
		C_LONGINT:C283(vl_Ss_RS_SIAO_Personne_ID1)
		C_TEXT:C284(va_Ss_RS_Famille1; va_Ss_RS_Theme1; va_Ss_RS_SousTheme1)
		C_LONGINT:C283(vl_Ss_RS_Rang1)
		C_TEXT:C284(va_Ss_RS_Intitulé1)
		C_REAL:C285(vr_Ss_RS_Montant1)
		C_DATE:C307(vd_Ss_RS_Debut1; vd_Ss_RS_Fin1)
		
		
		
	: ($1=1)
		vr_Ss_TOTAL_RSAnnuel:=0
		vr_Ss_TOTAL_DTAnnuel:=0
		vr_Ss_TOTAL_Disponible:=0
		vr_Ss_TOTAL_DisponibleMois:=0
		
	: ($1=2)
		
		
		
	: ($1=3)
		$vb_OK:=F_SIAO_Var_SsTotal(1; 0; 0; <>vp_SIAO_PointeurVide; 0)
		
		
		For ($kk; 1; Size of array:C274(ta_SP_Nom))
			$va_Theme:=ta_SIAO_PageTitre{5}  //"RESSOURCES"
			$va_SousTheme:="A"
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=tl_SP_Reference{$kk}; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$va_SousTheme)
			If (Records in selection:C76([SIAO_Situations:52])>0)
				vr_Ss_TOTAL_RSAnnuel:=vr_Ss_TOTAL_RSAnnuel+Sum:C1([SIAO_Situations:52]Ss_Montant:26)
			End if 
			
			$va_Theme:=ta_SIAO_PageTitre{6}  //"ENDETTEMENT"
			$va_SousTheme:="A"
			QUERY:C277([SIAO_Situations:52]; [SIAO_Situations:52]Ss_SIAO_Personne_ID:3=tl_SP_Reference{$kk}; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SIAO_ID:2=$3; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_Theme:5=$va_Theme; *)
			QUERY:C277([SIAO_Situations:52];  & ; [SIAO_Situations:52]Ss_SousTheme:6=$va_SousTheme)
			If (Records in selection:C76([SIAO_Situations:52])>0)
				vr_Ss_TOTAL_DTAnnuel:=vr_Ss_TOTAL_DTAnnuel+Sum:C1([SIAO_Situations:52]Ss_Montant:26)
			End if 
		End for 
		
		vr_Ss_TOTAL_RSAnnuel:=vr_Ss_TOTAL_RSAnnuel*12
		vr_Ss_TOTAL_DTAnnuel:=vr_Ss_TOTAL_DTAnnuel*12
		vr_Ss_TOTAL_Disponible:=vr_Ss_TOTAL_RSAnnuel-vr_Ss_TOTAL_DTAnnuel
		vr_Ss_TOTAL_DisponibleMois:=Round:C94(vr_Ss_TOTAL_Disponible/12; 2)
		$0:=True:C214
		
		vr_Ss_TOTAL_Txdeffort:=vr_Ss_DT_Montant1*100/Round:C94(vr_Ss_TOTAL_RSAnnuel/12; 2)
		
	: ($1=10)
		
		
End case 