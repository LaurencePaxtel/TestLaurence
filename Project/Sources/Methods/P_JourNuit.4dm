//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : P_JourNuit
//{
//{          Vendrdi 26 novembre 2004 à 15:13:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_POINTER:C301($1)
C_POINTER:C301($2)

If (<>vb_ParamDisActivée) & (((<>vb_ParamDisJour) & (<>vb_ParamDisNuit=False:C215)) | ((<>vb_ParamDisJour=False:C215) & (<>vb_ParamDisNuit=True:C214)))
	$1->:=Num:C11(<>vb_ParamDisJour)
	$2->:=Num:C11(<>vb_ParamDisNuit)
Else 
	
	If (<>vb_CentreEXC)
		$1->:=1
		$2->:=0
	Else 
		
		If (Current time:C178()<=?20:00:00?)
			$1->:=1
			$2->:=0
		Else 
			$1->:=0
			$2->:=1
		End if 
		
	End if 
	
End if 