//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_RG_LesDocuments
//{          Lundi 15 novembre 2010 à 15:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
$0:=False:C215
C_POINTER:C301($1)
C_BOOLEAN:C305($vb_OK)

C_LONGINT:C283($ii)

//NE CONSERVER QUE CE QUI EST UNE FICHE D HÉBERGEMENT          
If (Size of array:C274($1->)>0)
	$ii:=1
	
	Repeat 
		//•(x1) Longueur 25 caractères
		If (Substring:C12($1->{$ii}; Length:C16($1->{$ii})-3; 4)=".TXT")
			$vb_OK:=(Length:C16($1->{$ii})=29)
		Else 
			$vb_OK:=(Length:C16($1->{$ii})=25)
		End if 
		//•(x2) Année               
		If ($vb_OK)
			$vb_OK:=(Num:C11($1->{$ii}[[4]])>=0) & (Num:C11($1->{$ii}[[4]])<=9)
			$vb_OK:=$vb_OK & ((Num:C11(Substring:C12($1->{$ii}; 4; 2))>0) & (Num:C11(Substring:C12($1->{$ii}; 4; 2))<=99))
		End if 
		//•(x3) Mois               
		If ($vb_OK)
			$vb_OK:=((Num:C11(Substring:C12($1->{$ii}; 6; 2))>0) & (Num:C11(Substring:C12($1->{$ii}; 6; 2))<=12))
		End if 
		//•(x4) Jour              
		If ($vb_OK)
			$vb_OK:=((Num:C11(Substring:C12($1->{$ii}; 8; 2))>0) & (Num:C11(Substring:C12($1->{$ii}; 8; 2))<=31))
		End if 
		//•(x5) h          
		If ($vb_OK)
			$vb_OK:=($1->{$ii}[[12]]="h")
		End if 
		//•(x6) Jour   ou Nuit                 
		If ($vb_OK)
			$vb_OK:=(($1->{$ii}[[15]]="J") | ($1->{$ii}[[15]]="N"))
		End if 
		//•(x7) Homme   ou Femme             
		If ($vb_OK)
			$vb_OK:=(($1->{$ii}[[22]]="H") | ($1->{$ii}[[22]]="F"))
		End if 
		
		If ($vb_OK)
			$ii:=$ii+1
		Else 
			DELETE FROM ARRAY:C228($1->; $ii; 1)
		End if 
		$vb_OK:=($ii>Size of array:C274($1->))
	Until ($vb_OK)
	$0:=(Size of array:C274($1->)>0)
End if 