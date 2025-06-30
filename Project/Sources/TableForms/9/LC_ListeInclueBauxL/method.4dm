If (Form event code:C388=Sur affichage corps:K2:22)
	ve_Restant:=0
	OBJECT SET FONT STYLE:C166([LesCentres:9]LC_Nom:4; Num:C11([LesCentres:9]LC_Excuse:49))
	P_CentreCouleurNiveau(->[LesCentres:9]LC_Nom:4; [LesCentres:9]LC_Niveau:52)
	
	
	If ([LesCentres:9]LC_Fermé:53)
		[LesCentres:9]LC_Nom:4:="(< "+[LesCentres:9]LC_Nom:4+" >)"
	End if 
	If (<>ve_Si_ModeCHRS=1)
		ve_Restant:=0
		va_JN:=""
		
		OBJECT SET VISIBLE:C603(ve_Restant; False:C215)
	Else 
		$JN:=("J"*Num:C11([HeberGement:5]HG_Nuit:2=False:C215))+("N"*Num:C11([HeberGement:5]HG_Nuit:2=True:C214))  //abandonné le 01/08/2012
		$JN:="J"
		$va_CléL:=Uut_NumeroteLitsType(vd_DateRecherche; $JN)+Uut_NumeroteLitsID([LesCentres:9]LC_RéférenceID:1)
		QUERY:C277([CentresLits:16]; [CentresLits:16]CL_DateTypeIDLC:10=$va_CléL)
		MultiSoc_Filter(->[CentresLits:16])
		ve_Restant:=[CentresLits:16]CL_Restant:7
		va_JN:=[CentresLits:16]CL_Type:8
		
		OBJECT SET VISIBLE:C603(ve_Restant; True:C214)
	End if 
	
	
End if 

