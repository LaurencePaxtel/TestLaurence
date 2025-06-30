//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : P_DecoupeChemins
//{
//{          Mercredi 3 novembre 2010 à 11:00:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}

C_LONGINT:C283($1)
C_POINTER:C301($2)  //Variable texte
C_POINTER:C301($3)  //Variable tableau
C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii; $vl_Taille)
C_TEXT:C284($vt_Temp)

Case of 
	: ($1=1)
		
		$vb_OK:=False:C215
		$vt_Temp:=$2->
		If ($vt_Temp>"")
			Repeat 
				$vl_Taille:=Size of array:C274($3->)+1
				INSERT IN ARRAY:C227($3->; $vl_Taille)
				
				$ii:=Position:C15(Char:C90(13); $vt_Temp)
				If ($ii>0)
					$3->{$vl_Taille}:=Substring:C12($vt_Temp; 1; $ii-1)
					$vt_Temp:=Substring:C12($vt_Temp; $ii+1)
				Else 
					$3->{$vl_Taille}:=$vt_Temp
					$vt_Temp:=""
				End if 
				$vb_OK:=($vt_Temp="")
			Until ($vb_OK)
		Else 
			ARRAY TEXT:C222($3->; 0)
		End if 
		
	: ($1=2)
		$2->:=""
		If (Size of array:C274($3->)>0)
			For ($ii; 1; Size of array:C274($3->))
				$2->:=$2->+$3->{$ii}
				$2->:=$2->+(Char:C90(13)*Num:C11($ii<Size of array:C274($3->)))
			End for 
		End if 
		
		
End case 