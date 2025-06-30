//%attributes = {}
//{==================================================}
//{ LOGICIEL : SSP
//{ © DBsolutions
//{          Procédure : F_FichiersNbExportes
//{          Lundi 5 mai 2011 à 12:00
//{          Modifiée : 
//{          Développement : GABBAY Jean-Guy
//{==================================================}


C_BOOLEAN:C305($0)
$0:=False:C215
C_POINTER:C301($1)  //Le tableau

C_BOOLEAN:C305($vb_OK)
C_LONGINT:C283($ii)


If (Size of array:C274($1->)>0)
	//NE CONSERVER QUE CE QUI EST UNE FICHE D HÉBERGEMENT
	$ii:=1
	
	Repeat 
		//AH 09022508h15J01810 FS49.TXT            
		//•(x1) Longueur 25 caractères
		
		
		// BS 09-05-16
		// La structure des fichiers à importer a évolué
		// Certains fichiers ont 1 caractère supplémentaire
		//  La numérotation de la fiche a 1 digit de plus
		C_LONGINT:C283($L_Length)
		$L_Length:=Length:C16($1->{$ii})
		
		If (Substring:C12($1->{$ii}; $L_Length-3; 4)=".TXT")
			$vb_OK:=($L_Length=29) | ($L_Length=30)
		Else 
			$vb_OK:=($L_Length=25) | ($L_Length=26)
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
			$vb_OK:=(($1->{$ii}[[22]]="H") | ($1->{$ii}[[23]]="H") | ($1->{$ii}[[22]]="F") | ($1->{$ii}[[23]]="F"))  // BS 090516 : 1  caractère de plus dans le nom du fichier
		End if 
		
		If ($vb_OK)
			$ii:=$ii+1
		Else 
			DELETE FROM ARRAY:C228($1->; $ii; 1)
		End if 
		$vb_OK:=($ii>Size of array:C274($1->))
	Until ($vb_OK)
End if 

$0:=(Size of array:C274($1->)>0)