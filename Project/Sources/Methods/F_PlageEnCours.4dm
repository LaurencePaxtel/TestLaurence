//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Fonction : F_PlageEnCours
//{
//{          Marrdi 22 avril 200! à 15:08:00
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)  //Période
C_LONGINT:C283($2)  //Actuelle =0; suivant=1; précédent-1
C_POINTER:C301($3)
C_POINTER:C301($4)

C_LONGINT:C283($ve_Mois)

$0:=True:C214

Case of 
	: ($1=0)  //"Aujourd'hui"
		
		Case of 
			: ($2=0)
				$3->:=Current date:C33
				$4->:=$3->
			: ($2=1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$3->:=Add to date:C393($3->; 0; 0; 1)
				$4->:=$3->
				
			: ($2=-1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$3->:=Add to date:C393($3->; 0; 0; -1)
				$4->:=$3->
		End case 
		
	: ($1=1)  //Semaine en cours"
		
		Case of 
			: ($2=0)
				$3->:=Current date:C33
				
				If (Day number:C114($3->)=Lundi:K10:13)
				Else 
					
					Repeat 
						$3->:=Add to date:C393($3->; 0; 0; -1)
					Until (Day number:C114($3->)=Lundi:K10:13)
					
				End if 
				
				$4->:=Add to date:C393($3->; 0; 0; 6)
				
			: ($2=1)
				
				If (Day number:C114($3->)=Lundi:K10:13)
				Else 
					
					Repeat 
						$3->:=Add to date:C393($3->; 0; 0; -1)
					Until (Day number:C114($3->)=Lundi:K10:13)
					
				End if 
				$3->:=Add to date:C393($3->; 0; 0; 7)
				$4->:=Add to date:C393($3->; 0; 0; 6)
				
			: ($2=-1)
				
				If (Day number:C114($3->)=Lundi:K10:13)
				Else 
					
					Repeat 
						$3->:=Add to date:C393($3->; 0; 0; -1)
					Until (Day number:C114($3->)=Lundi:K10:13)
					
				End if 
				
				$4->:=Add to date:C393($3->; 0; 0; -1)
				$3->:=Add to date:C393($3->; 0; 0; -7)
				
		End case 
		
	: ($1=2)  //Quinzaine en cours"
		
		Case of 
			: ($2=0)
				$3->:=Current date:C33
				
				If (Day number:C114($3->)=Lundi:K10:13)
				Else 
					
					Repeat 
						$3->:=Add to date:C393($3->; 0; 0; -1)
					Until (Day number:C114($3->)=Lundi:K10:13)
					
				End if 
				
				$4->:=Add to date:C393($3->; 0; 0; 13)
				
			: ($2=1)
				
				If (Day number:C114($3->)=Lundi:K10:13)
				Else 
					
					Repeat 
						$3->:=Add to date:C393($3->; 0; 0; -1)
					Until (Day number:C114($3->)=Lundi:K10:13)
					
				End if 
				
				$4->:=Add to date:C393($3->; 0; 0; 13)
				
				$3->:=Add to date:C393($3->; 0; 0; 14)
				$4->:=Add to date:C393($4->; 0; 0; 14)
				
			: ($2=-1)
				
				If (Day number:C114($3->)=Lundi:K10:13)
				Else 
					
					Repeat 
						$3->:=Add to date:C393($3->; 0; 0; -1)
					Until (Day number:C114($3->)=Lundi:K10:13)
					
				End if 
				
				$4->:=Add to date:C393($3->; 0; 0; 13)
				
				$3->:=Add to date:C393($3->; 0; 0; -14)
				$4->:=Add to date:C393($4->; 0; 0; -14)
		End case 
		
	: ($1=4)  //"Mois en cours"
		
		Case of 
			: ($2=0)
				$3->:=Date:C102("1/"+String:C10(Month of:C24(Current date:C33))+"/"+String:C10(Year of:C25(Current date:C33)))
				$4->:=Add to date:C393($3->; 0; 1; -1)
				
			: ($2=1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$3->:=Date:C102("1/"+String:C10(Month of:C24($3->))+"/"+String:C10(Year of:C25($3->)))
				$3->:=Add to date:C393($3->; 0; 1; 0)
				$4->:=Add to date:C393($3->; 0; 1; -1)
				
			: ($2=-1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$3->:=Date:C102("1/"+String:C10(Month of:C24($3->))+"/"+String:C10(Year of:C25($3->)))
				$3->:=Add to date:C393($3->; 0; -1; 0)
				$4->:=Add to date:C393($3->; 0; 1; -1)
		End case 
		
	: ($1=13)  //"Trimestre en cours"
		
		Case of 
			: ($2=0)
				$ve_Mois:=Month of:C24(Current date:C33)
				
				Case of 
					: ($ve_Mois>=1) & ($ve_Mois<=3)
						$ve_Mois:=1
					: ($ve_Mois>=4) & ($ve_Mois<=6)
						$ve_Mois:=4
					: ($ve_Mois>=7) & ($ve_Mois<=9)
						$ve_Mois:=7
					: ($ve_Mois>=10) & ($ve_Mois<=12)
						$ve_Mois:=10
				End case 
				
				$3->:=Date:C102("1/"+String:C10($ve_Mois)+"/"+String:C10(Year of:C25(Current date:C33)))
				$4->:=Add to date:C393($3->; 0; 3; -1)
			: ($2=1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$ve_Mois:=Month of:C24($3->)
				
				Case of 
					: ($ve_Mois>=1) & ($ve_Mois<=3)
						$ve_Mois:=1
					: ($ve_Mois>=4) & ($ve_Mois<=6)
						$ve_Mois:=4
					: ($ve_Mois>=7) & ($ve_Mois<=9)
						$ve_Mois:=7
					: ($ve_Mois>=10) & ($ve_Mois<=12)
						$ve_Mois:=10
				End case 
				
				$3->:=Date:C102("1/"+String:C10($ve_Mois)+"/"+String:C10(Year of:C25($3->)))
				
				$3->:=Add to date:C393($3->; 0; 3; 0)
				$4->:=Add to date:C393($3->; 0; 3; -1)
				
			: ($2=-1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$ve_Mois:=Month of:C24($3->)
				
				Case of 
					: ($ve_Mois>=1) & ($ve_Mois<=3)
						$ve_Mois:=1
					: ($ve_Mois>=4) & ($ve_Mois<=6)
						$ve_Mois:=4
					: ($ve_Mois>=7) & ($ve_Mois<=9)
						$ve_Mois:=7
					: ($ve_Mois>=10) & ($ve_Mois<=12)
						$ve_Mois:=10
				End case 
				
				$3->:=Date:C102("1/"+String:C10($ve_Mois)+"/"+String:C10(Year of:C25($3->)))
				$4->:=Add to date:C393($3->; 0; 3; -1)
				
				$3->:=Add to date:C393($3->; 0; -3; 0)
				$4->:=Add to date:C393($3->; 0; 3; -1)
		End case 
		
	: ($1=16)  //"Semestre en cours"
		
		Case of 
			: ($2=0)
				$ve_Mois:=Month of:C24(Current date:C33)
				
				Case of 
					: ($ve_Mois>=1) & ($ve_Mois<=6)
						$ve_Mois:=1
					: ($ve_Mois>=7) & ($ve_Mois<=12)
						$ve_Mois:=7
				End case 
				
				$3->:=Date:C102("1/"+String:C10($ve_Mois)+"/"+String:C10(Year of:C25(Current date:C33)))
				$4->:=Add to date:C393($3->; 0; 6; -1)
				
			: ($2=1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$ve_Mois:=Month of:C24($3->)
				
				Case of 
					: ($ve_Mois>=1) & ($ve_Mois<=6)
						$ve_Mois:=1
					: ($ve_Mois>=7) & ($ve_Mois<=12)
						$ve_Mois:=7
				End case 
				
				$3->:=Date:C102("1/"+String:C10($ve_Mois)+"/"+String:C10(Year of:C25($3->)))
				
				$3->:=Add to date:C393($3->; 0; 6; 0)
				$4->:=Add to date:C393($3->; 0; 6; -1)
			: ($2=-1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$ve_Mois:=Month of:C24($3->)
				
				Case of 
					: ($ve_Mois>=1) & ($ve_Mois<=6)
						$ve_Mois:=1
					: ($ve_Mois>=7) & ($ve_Mois<=12)
						$ve_Mois:=7
				End case 
				
				$3->:=Date:C102("1/"+String:C10($ve_Mois)+"/"+String:C10(Year of:C25($3->)))
				
				$3->:=Add to date:C393($3->; 0; -6; 0)
				$4->:=Add to date:C393($3->; 0; 6; -1)
		End case 
		
	: ($1=12)  //"Année en cours"
		
		Case of 
			: ($2=0)
				$ve_Mois:=Year of:C25(Current date:C33)
				
				$3->:=Date:C102("1/1/"+String:C10($ve_Mois; "0000"))
				$4->:=Date:C102("31/12/"+String:C10($ve_Mois; "0000"))
				
			: ($2=1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$ve_Mois:=Year of:C25($3->)
				$ve_Mois:=$ve_Mois+1
				
				$3->:=Date:C102("1/1/"+String:C10($ve_Mois; "0000"))
				$4->:=Date:C102("31/12/"+String:C10($ve_Mois; "0000"))
			: ($2=-1)
				
				If ($3->=!00-00-00!)
					$3->:=Current date:C33
				End if 
				
				$ve_Mois:=Year of:C25($3->)
				$ve_Mois:=$ve_Mois-1
				
				$3->:=Date:C102("1/1/"+String:C10($ve_Mois; "0000"))
				$4->:=Date:C102("31/12/"+String:C10($ve_Mois; "0000"))
		End case 
		
	: ($1=13)  //"RAZ"
		$3->:=!00-00-00!
		$4->:=!00-00-00!
	: ($1=20)  //"RAZ"
		$3->:=!00-00-00!
		$4->:=!00-00-00!
End case 