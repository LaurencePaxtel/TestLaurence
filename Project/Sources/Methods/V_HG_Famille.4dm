//%attributes = {}
//[HéberGement]HG_FamCompoVar
//[HéberGement]HG_FamCompo
//[HéberGement]HG_FamNbPers
//ve_FamH       : Homme
//ve_FamF       : Femme
//ve_FamFe     : Femme enceinte
//ve_FamEMi   : Enfant mineur
//ve_FamEMa  : Enfant majeur
//ve_FamPMi  : Parent mineur
//ve_FamPMa  : Parent majeur
C_LONGINT:C283($1)

Case of 
	: ($1=-1)
		C_LONGINT:C283(ve_FamH; ve_FamF; ve_FamFe; ve_FamEMi; ve_FamEMa; ve_FamPMi; ve_FamPMa)
		
		ve_FamH:=0
		ve_FamF:=0
		ve_FamFe:=0
		ve_FamEMi:=0
		ve_FamEMa:=0
		ve_FamPMi:=0
		ve_FamPMa:=0
	: ($1=0)
		ve_FamH:=0
		ve_FamF:=0
		ve_FamFe:=0
		ve_FamEMi:=0
		ve_FamEMa:=0
		ve_FamPMi:=0
		ve_FamPMa:=0
	: ($1=1)
		[HeberGement:5]HG_FamCompoVar:117:=""
		[HeberGement:5]HG_FamCompoVar:117:="H"+String:C10(ve_FamH)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"F"+String:C10(ve_FamF)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"B"+String:C10(ve_FamFe)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"e"+String:C10(ve_FamEMi; "00")
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"E"+String:C10(ve_FamEMa; "00")
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"p"+String:C10(ve_FamPMi)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"P"+String:C10(ve_FamPMa)
	: ($1=2)
		
		If ([HeberGement:5]HG_FamCompoVar:117>"")
			ve_FamH:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 2; 1))
			ve_FamF:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 4; 1))
			ve_FamFe:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 6; 1))
			ve_FamEMi:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 8; 2))
			ve_FamEMa:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 11; 2))
			ve_FamPMi:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 14; 1))
			ve_FamPMa:=Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 16; 1))
		Else 
			ve_FamH:=0
			ve_FamF:=0
			ve_FamFe:=0
			ve_FamEMi:=0
			ve_FamEMa:=0
			ve_FamPMi:=0
			ve_FamPMa:=0
		End if 
		
		[HeberGement:5]HG_FamNbPers:106:=ve_FamH+ve_FamF+ve_FamFe+ve_FamEMi+ve_FamEMa+ve_FamPMi+ve_FamPMa
	: ($1=3)
		
		If ([HeberGement:5]HG_FamCompoVar:117>"")
			[HeberGement:5]HG_FamCompo:105:=""
			
			If (Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 2; 1))>0)
				[HeberGement:5]HG_FamCompo:105:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 2; 1)+"H"
			End if 
			
			If (Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 4; 1))>0)
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				[HeberGement:5]HG_FamCompo:105:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 4; 1)+"F"
			End if 
			
			If (Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 6; 1))>0)
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				[HeberGement:5]HG_FamCompo:105:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 6; 1)+"Fe"
			End if 
			
			If (Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 8; 2))>0)
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				[HeberGement:5]HG_FamCompo:105:=String:C10(Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 8; 2)))+"Em"
			End if 
			
			If (Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 11; 2))>0)
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				[HeberGement:5]HG_FamCompo:105:=String:C10(Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 11; 2)))+"EM"
			End if 
			
			If (Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 14; 1))>0)
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				[HeberGement:5]HG_FamCompo:105:=String:C10(Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 14; 1)))+"Pm"
			End if 
			
			If (Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 16; 1))>0)
				
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				
				[HeberGement:5]HG_FamCompo:105:=String:C10(Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 16; 1)))+"PM"
			End if 
			
		Else 
			[HeberGement:5]HG_FamCompoVar:117:="H0F0B0e00E00p0P0"
		End if 
		
	: ($1=4)
		[HeberGement:5]HG_FamCompoVar:117:=""
		[HeberGement:5]HG_FamCompoVar:117:="H"+String:C10(ve_FamH)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"F"+String:C10(ve_FamF)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"B"+String:C10(ve_FamFe)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"e"+String:C10(ve_FamEMi; "00")
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"E"+String:C10(ve_FamEMa; "00")
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"p"+String:C10(ve_FamPMi)
		[HeberGement:5]HG_FamCompoVar:117:=[HeberGement:5]HG_FamCompoVar:117+"P"+String:C10(ve_FamPMa)
		
		[HeberGement:5]HG_FamNbPers:106:=ve_FamH+ve_FamF+ve_FamFe+ve_FamEMi+ve_FamEMa+ve_FamPMi+ve_FamPMa
		
		[HeberGement:5]HG_FamCompo:105:=""
		
		If (ve_FamH>0)
			[HeberGement:5]HG_FamCompo:105:=String:C10(ve_FamH)+"H"
		End if 
		
		If (ve_FamF>0)
			If ([HeberGement:5]HG_FamCompo:105>"")
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
			End if 
			[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+String:C10(ve_FamF)+"F"
		End if 
		
		If (ve_FamFe>0)
			If ([HeberGement:5]HG_FamCompo:105>"")
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
			End if 
			[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+String:C10(ve_FamFe)+"Fe"
		End if 
		
		If (ve_FamEMi>0)
			If ([HeberGement:5]HG_FamCompo:105>"")
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
			End if 
			[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+String:C10(ve_FamEMi)+"Em"
		End if 
		
		If (ve_FamEMa>0)
			If ([HeberGement:5]HG_FamCompo:105>"")
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
			End if 
			[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+String:C10(ve_FamEMa)+"EM"
		End if 
		
		If (ve_FamPMi>0)
			If ([HeberGement:5]HG_FamCompo:105>"")
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
			End if 
			[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+String:C10(ve_FamPMi)+"Pm"
		End if 
		
		If (ve_FamPMa>0)
			If ([HeberGement:5]HG_FamCompo:105>"")
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
			End if 
			[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+String:C10(ve_FamPMa)+"PM"
		End if 
		
	: ($1=5)
		
		If ([HeberGement:5]HG_FamCompoVar:117>"")
			[HeberGement:5]HG_FamCompo:105:=""
			
			If ([HeberGement:5]HG_FamCompoVar:117[[2]]#"0")
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompoVar:117[[2]]+"H"
			End if 
			
			If ([HeberGement:5]HG_FamCompoVar:117[[4]]="0")
				
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+[HeberGement:5]HG_FamCompoVar:117[[4]]+"F"
			End if 
			
			If ([HeberGement:5]HG_FamCompoVar:117[[6]]="0")
				
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+[HeberGement:5]HG_FamCompoVar:117[[6]]+"Fe"
			End if 
			
			If (Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 8; 2))>0)
				
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+String:C10(Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 8; 2)))+"Em"
			End if 
			
			If (Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 11; 2))>0)
				
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+String:C10(Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 11; 2)))+"EM"
			End if 
			
			If (Num:C11([HeberGement:5]HG_FamCompoVar:117[[14]])>0)
				
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+[HeberGement:5]HG_FamCompoVar:117[[14]]+"Pm"
			End if 
			
			If (Num:C11([HeberGement:5]HG_FamCompoVar:117[[16]])>0)
				
				If ([HeberGement:5]HG_FamCompo:105>"")
					[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+"+"
				End if 
				
				[HeberGement:5]HG_FamCompo:105:=[HeberGement:5]HG_FamCompo:105+[HeberGement:5]HG_FamCompoVar:117[[16]]+"PM"
			End if 
			
		End if 
		
End case 