//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_Prestation_RefsTableau
//{          Vendredi 29 avril 2011 à 15:30
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)

C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)

Case of 
	: ($1=0)
		ARRAY LONGINT:C221(tl_Presta_Réf_HG; $2)
	: ($1=1)
		$vb_OK:=<>vb_T_ModeCHRS & <>vb_T_Prestations
		
		If ($vb_OK)
			$ii:=Size of array:C274(tl_Presta_Réf_HG)+1
			
			INSERT IN ARRAY:C227(tl_Presta_Réf_HG; $ii)
			tl_Presta_Réf_HG{$ii}:=$2
		End if 
		
End case 

$0:=True:C214