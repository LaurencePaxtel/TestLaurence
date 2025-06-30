//%attributes = {"preemptive":"capable"}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_CL_LitsDispoAffecter
//{
//{          Lundi 18 juin 2001 à 11:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TEXT:C284($0)  // #BS_MIGRATION
C_DATE:C307($1; $D_HebergementHG_Date)  // #20170628-1
C_LONGINT:C283($2; $L_HebergementHG_LC_ID)  // #20170628-1
C_LONGINT:C283($3)
C_TEXT:C284($4; $T_Type_Jour_Nuit)  // #20170628-1
C_LONGINT:C283($5)
C_LONGINT:C283($6)  //SI REMPLACANT À ENLEVER OU AJOUTER OU RIEN

C_BOOLEAN:C305($vb_SToP)

$D_HebergementHG_Date:=$1
$L_HebergementHG_LC_ID:=$2

$T_Type_Jour_Nuit:=$4

READ WRITE:C146([CentresLits:16])

QUERY:C277([CentresLits:16]; [CentresLits:16]CL_LC_ID_date:1=Uut_NumeroteLits($D_HebergementHG_Date; $L_HebergementHG_LC_ID))
MultiSoc_Filter(->[CentresLits:16])

If (Records in selection:C76([CentresLits:16])>0)
	QUERY SELECTION:C341([CentresLits:16]; [CentresLits:16]CL_Type:8=$T_Type_Jour_Nuit)
	
	If (Records in selection:C76([CentresLits:16])=1)
		
		If ($5=0)
			
			Repeat 
				LOAD RECORD:C52([CentresLits:16])
			Until (Not:C34(Locked:C147([CentresLits:16])))
			
			If ([CentresLits:16]CL_Restant:7>=$3)
				[CentresLits:16]CL_Remplacants:28:=[CentresLits:16]CL_Remplacants:28+$6
				[CentresLits:16]CL_Distribué:6:=[CentresLits:16]CL_Distribué:6+$3  // #20170705-1 plus bas on sort cette ligne du SI on ne la pas fait ici ??
				[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_Restant:7-$3
				
				SAVE RECORD:C53([CentresLits:16])
			Else 
				$0:="Le centre : "+[HeberGement:5]HG_CentreNom:62+" n'a plus de lit disponible."
			End if 
			
			UNLOAD RECORD:C212([CentresLits:16])
		Else 
			
			If ([CentresLits:16]CL_LC_ID:2=1269)
				TRACE:C157
			End if 
			
			Repeat 
				LOAD RECORD:C52([CentresLits:16])
				//i_Message("Veuillez patienter !")
				
				If (Locked:C147([CentresLits:16]))
					//i_MessageSeul("Veuillez patienter !")
				Else 
					
					If ([CentresLits:16]CL_Restant:7>=$3)
						[CentresLits:16]CL_Remplacants:28:=[CentresLits:16]CL_Remplacants:28+$6
						[CentresLits:16]CL_Restant:7:=[CentresLits:16]CL_Restant:7-$3  // [CentresLits]CL_Restant
					Else 
						$0:="Le centre : "+[HeberGement:5]HG_CentreNom:62+" n'a plus de lit disponible."
					End if 
					
					// #20170705-1 les deux lignes qui suivent ont été sorties du If ([CentresLits]CL_Restant>=$3)
					[CentresLits:16]CL_Distribué:6:=[CentresLits:16]CL_Distribué:6+$3
					SAVE RECORD:C53([CentresLits:16])
					
					UNLOAD RECORD:C212([CentresLits:16])
					
					$vb_SToP:=True:C214
				End if 
				
				//FERMER FENÊTRE
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