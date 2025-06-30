//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_CL_LitsDispAffecterA
//{
//{          Lundi 19 janvier 2004 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)
C_DATE:C307($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)  //SI REMPLACANT À ENLEVER OU AJOUTER OU RIEN

C_BOOLEAN:C305($vb_SToP)

READ WRITE:C146([CentresLits:16])
QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID_date:1=Uut_NumeroteLits($1; $2))

If (Records in selection:C76([CentresLits:16])>0)
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_Type:8=$4)
	MultiSoc_Filter(->[CentresLits:16])
	
	If (Records in selection:C76([CentresLits:16])=1)
		
		If ($5=0)
			
			Repeat 
				LOAD RECORD:C52([CentresLits:16])
			Until (Not:C34(Locked:C147([CentresLits:16])))
			
			If ([CentresLits:16]CL_Restant:7>0)
				[CentresLits:16]CL_Remplacants:28:=[CentresLits:16]CL_Remplacants:28+$6
				[CentresLits:16]CL_Distribué:6:=[CentresLits:16]CL_Distribué:6+$3
				[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_Restant:7-$3  // [CentresLits]CL_Restant
				SAVE RECORD:C53([CentresLits:16])
			Else 
				$0:="Le centre : "+[HeberGement:5]HG_CentreNom:62+" n'a plus de lit disponible."
			End if 
			
			UNLOAD RECORD:C212([CentresLits:16])
		Else 
			
			Repeat 
				LOAD RECORD:C52([CentresLits:16])
				
				If (Locked:C147([CentresLits:16])=False:C215)
					
					If ([CentresLits:16]CL_Restant:7>0)
						[CentresLits:16]CL_Remplacants:28:=[CentresLits:16]CL_Remplacants:28+$6
						[CentresLits:16]CL_Distribué:6:=[CentresLits:16]CL_Distribué:6+$3
						[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_Restant:7-$3  // [CentresLits]CL_Restant
						SAVE RECORD:C53([CentresLits:16])
					Else 
						$0:="Le centre : "+[HeberGement:5]HG_CentreNom:62+" n'a plus de lit disponible."
					End if 
					
					UNLOAD RECORD:C212([CentresLits:16])
					$vb_SToP:=True:C214
				End if 
				
			Until ($vb_SToP)
			
		End if 
		
		UNLOAD RECORD:C212([CentresLits:16])
	Else 
		$0:="La disponibilité pour le centre : "+[HeberGement:5]HG_CentreNom:62+" n'existe pas, veuillez contacter la hotline."
	End if 
	
Else 
	$0:="La disponibilité pour le centre : "+[HeberGement:5]HG_CentreNom:62+" n'existe pas, veuillez contacter la hotline."
End if 

UNLOAD RECORD:C212([CentresLits:16])
READ ONLY:C145([CentresLits:16])