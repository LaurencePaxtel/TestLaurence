C_TEXT:C284($T_JourNuit; $va_CléL)

If (Form event code:C388=Sur affichage corps:K2:22)
	OBJECT SET FONT STYLE:C166([LesCentres:9]LC_Nom:4; Num:C11([LesCentres:9]LC_Excuse:49))
	
	P_CentreCouleurNiveau(->[LesCentres:9]LC_Nom:4; [LesCentres:9]LC_Niveau:52)
	
	If ([LesCentres:9]LC_Fermé:53)
		[LesCentres:9]LC_Nom:4:="(< "+[LesCentres:9]LC_Nom:4+" >)"
	End if 
	
	C_LONGINT:C283(ve_Restant)
	
	If (<>ve_Si_ModeCHRS=1)
		ve_Restant:=0
		va_JN:=""
	Else 
		$T_JourNuit:=("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215))+("N"*Num:C11([HeberGement:5]HG_Nuit:2=True:C214))
		$va_CléL:=Uut_NumeroteLitsType(vd_DateRecherche; $T_JourNuit)+Uut_NumeroteLitsID([LesCentres:9]LC_RéférenceID:1)
		
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateTypeIDLC:10=$va_CléL)
		MultiSoc_Filter(->[CentresLits:16])
		ve_Restant:=[CentresLits:16]CL_Restant:7
		va_JN:=[CentresLits:16]CL_Type:8
	End if 
	
	OBJECT SET VISIBLE:C603(ve_Restant; Not:C34(<>ve_Si_ModeCHRS=1))
	
	If (Mod:C98(Selected record number:C246([LesCentres:9]); 2)=0)
		OBJECT SET RGB COLORS:C628(*; "Champ@"; "black"; "#DFEFFF")
		OBJECT SET RGB COLORS:C628(*; "Variable@"; "black"; "#DFEFFF")
		OBJECT SET RGB COLORS:C628(*; "Rectangle1"; "black"; "#DFEFFF")
	Else 
		OBJECT SET RGB COLORS:C628(*; "Champ@"; "black"; "white")
		OBJECT SET RGB COLORS:C628(*; "Variable@"; "black"; "white")
		OBJECT SET RGB COLORS:C628(*; "Rectangle1"; "black"; "white")
	End if 
	
End if 