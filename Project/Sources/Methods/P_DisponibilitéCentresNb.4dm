//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure:  P_DisponibilitéCentresNb
//{
//{          Lundi 20 décembre 2004 à 17:27:55
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)  //quel cas
C_LONGINT:C283($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
$3->:=0
$4->:=0


ARRAY BOOLEAN:C223(<>tb_D_NuitJour; 0)
ARRAY LONGINT:C221(<>tl_D_HGréf; 0)

C_LONGINT:C283($ii; $jj)

Case of 
	: ($1=1)
		
		QUERY SELECTION:C341([HeberGement:5]; [HeberGement:5]HG_LC_ID:61=$2)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_Nuit:2; <>tb_D_NuitJour)
		$jj:=Size of array:C274(<>tb_D_NuitJour)
		For ($ii; 1; $jj)
			If (<>tb_D_NuitJour{$ii})
				$4->:=$4->+1
			Else 
				$3->:=$3->+1
			End if 
		End for 
		
	: ($1=2)
		SELECTION TO ARRAY:C260([HeberGement:5]HG_ReferenceID:1; <>tl_D_HGréf; [HeberGement:5]HG_Nuit:2; <>tb_D_NuitJour)
		$jj:=Size of array:C274(<>tl_D_HGréf)
		For ($ii; 1; $jj)
			$Position:=Find in array:C230(tl_PR_HGréf; <>tl_D_HGréf{$ii})
			If ($Position>0)
				If (tl_PR_Centre{$Position}=$2)
					If (<>tb_D_NuitJour{$ii})
						$4->:=$4->+1
					Else 
						$3->:=$3->+1
					End if 
				End if 
			End if 
		End for 
		
End case 