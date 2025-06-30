//%attributes = {}

If ([HeberGement:5]HG_FamCompo:105>"")
	$veDeuxPoint:=0
	$va_Compo:=""
	$veNbPers:=0
	$vbNbPers:=False:C215
	$veNbPersE:=0
	$veNbPersA:=0
	$veNbPersM:=0
	$veNb:=0
	$veDeuxPoint:=Position:C15(":"; [HeberGement:5]HG_FamCompo:105)
	If ($veDeuxPoint>0)
		$va_Compo:=Substring:C12([HeberGement:5]HG_FamCompo:105; $veDeuxPoint+1)
		$va_Rang1:=""
		$va_Rang2:=""
		$va_Rang3:=""
		$va_Rang4:=""
		$va_Rang5:=""
		If ($va_Compo>"")
			$veDeuxPoint:=Position:C15("+"; $va_Compo)
			If ($veDeuxPoint>0)
				$va_Rang1:=Substring:C12($va_Compo; 1; $veDeuxPoint-1)
				$va_Compo:=Substring:C12($va_Compo; $veDeuxPoint+1)
			Else 
				$va_Rang1:=$va_Compo
				$va_Compo:=""
			End if 
		End if 
		If ($va_Compo>"")
			$veDeuxPoint:=Position:C15("+"; $va_Compo)
			If ($veDeuxPoint>0)
				$va_Rang2:=Substring:C12($va_Compo; 1; $veDeuxPoint-1)
				$va_Compo:=Substring:C12($va_Compo; $veDeuxPoint+1)
			Else 
				$va_Rang2:=$va_Compo
				$va_Compo:=""
			End if 
		End if 
		If ($va_Compo>"")
			$veDeuxPoint:=Position:C15("+"; $va_Compo)
			If ($veDeuxPoint>0)
				$va_Rang3:=Substring:C12($va_Compo; 1; $veDeuxPoint-1)
				$va_Compo:=Substring:C12($va_Compo; $veDeuxPoint+1)
			Else 
				$va_Rang3:=$va_Compo
				$va_Compo:=""
			End if 
		End if 
		If ($va_Compo>"")
			$veDeuxPoint:=Position:C15("+"; $va_Compo)
			If ($veDeuxPoint>0)
				$va_Rang4:=Substring:C12($va_Compo; 1; $veDeuxPoint-1)
				$va_Compo:=Substring:C12($va_Compo; $veDeuxPoint+1)
			Else 
				$va_Rang4:=$va_Compo
				$va_Compo:=""
			End if 
		End if 
		If ($va_Compo>"")
			$veDeuxPoint:=Position:C15("+"; $va_Compo)
			If ($veDeuxPoint>0)
				$va_Rang5:=Substring:C12($va_Compo; 1; $veDeuxPoint-1)
				$va_Compo:=Substring:C12($va_Compo; $veDeuxPoint+1)
			Else 
				$va_Rang5:=$va_Compo
				$va_Compo:=""
			End if 
		End if 
		
		[HeberGement:5]HG_FamCompoVar:117:="H0F0B0e00E00p0P0"
		
		If ($va_Rang1>"")
			Case of 
				: ($va_Rang1="H")
					[HeberGement:5]HG_FamCompoVar:117:="H1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 3)
					$veNbPers:=$veNbPers+1
				: ($va_Rang1="F")
					[HeberGement:5]HG_FamCompoVar:117:="H0F1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 5)
					$veNbPers:=$veNbPers+1
				: ($va_Rang1="Fenceinte")
					[HeberGement:5]HG_FamCompoVar:117:="H0F0B1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 7)
					$veNbPers:=$veNbPers+1
			End case 
		End if 
		
		If ($va_Rang2>"")
			$veNb:=Num:C11(Substring:C12($va_Rang2; 1; 1))
			If ($veNb>0)
				If (Substring:C12($va_Rang2; Length:C16($va_Rang2)-3)="Plus")
					$vbNbPers:=True:C214
				End if 
				$va_Compo:=Substring:C12($va_Rang2; 2; 1)
				Case of 
					: ($va_Compo="E")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 6)+"e"+String:C10($veNb; "00")+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 10)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersE:=1
						End if 
					: ($va_Compo="M")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 12)+"p"+String:C10($veNb)+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 15)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersM:=1
						End if 
					: ($va_Compo="A")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 14)+"P"+String:C10($veNb)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersA:=1
						End if 
				End case 
				
			Else 
				Case of 
					: ($va_Rang2="F")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 2)+"F1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 5)
						$veNbPers:=$veNbPers+1
					: ($va_Rang2="Fenceinte")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 4)+"B1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 7)
						$veNbPers:=$veNbPers+1
				End case 
			End if 
		End if 
		$vbNbPers:=False:C215
		
		
		If ($va_Rang3>"")
			$veNb:=Num:C11(Substring:C12($va_Rang3; 1; 1))
			If ($veNb>0)
				If (Substring:C12($va_Rang3; Length:C16($va_Rang3)-3)="Plus")
					$vbNbPers:=True:C214
				End if 
				$va_Compo:=Substring:C12($va_Rang3; 2; 1)
				Case of 
					: ($va_Compo="E")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 6)+"e"+String:C10($veNb; "00")+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 10)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersE:=1
						End if 
					: ($va_Compo="M")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 12)+"p"+String:C10($veNb)+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 15)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersM:=1
						End if 
					: ($va_Compo="A")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 14)+"P"+String:C10($veNb)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersA:=1
						End if 
				End case 
				
			Else 
				Case of 
					: ($va_Rang3="F")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 2)+"F1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 5)
						$veNbPers:=$veNbPers+1
					: ($va_Rang3="Fenceinte")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 4)+"B1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 7)
						$veNbPers:=$veNbPers+1
				End case 
			End if 
		End if 
		$vbNbPers:=False:C215
		
		
		If ($va_Rang4>"")
			$veNb:=Num:C11(Substring:C12($va_Rang4; 1; 1))
			If ($veNb>0)
				If (Substring:C12($va_Rang4; Length:C16($va_Rang4)-3)="Plus")
					$vbNbPers:=True:C214
				End if 
				$va_Compo:=Substring:C12($va_Rang4; 2; 1)
				Case of 
					: ($va_Compo="E")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 6)+"e"+String:C10($veNb; "00")+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 10)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersE:=1
						End if 
					: ($va_Compo="M")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 12)+"p"+String:C10($veNb)+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 15)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersM:=1
						End if 
					: ($va_Compo="A")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 14)+"P"+String:C10($veNb)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersA:=1
						End if 
				End case 
				
			Else 
				Case of 
					: ($va_Rang4="F")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 2)+"F1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 5)
						$veNbPers:=$veNbPers+1
					: ($va_Rang4="Fenceinte")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 4)+"B1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 7)
						$veNbPers:=$veNbPers+1
				End case 
			End if 
		End if 
		$vbNbPers:=False:C215
		
		
		
		
		If ($va_Rang5>"")
			$veNb:=Num:C11(Substring:C12($va_Rang5; 1; 1))
			If ($veNb>0)
				If (Substring:C12($va_Rang5; Length:C16($va_Rang5)-3)="Plus")
					$vbNbPers:=True:C214
				End if 
				$va_Compo:=Substring:C12($va_Rang5; 2; 1)
				Case of 
					: ($va_Compo="E")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 6)+"e"+String:C10($veNb; "00")+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 10)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersE:=1
						End if 
					: ($va_Compo="M")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 12)+"p"+String:C10($veNb)+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 15)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersM:=1
						End if 
					: ($va_Compo="A")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 14)+"P"+String:C10($veNb)
						$veNbPers:=$veNbPers+$veNb
						If ($vbNbPers)
							$veNbPersA:=1
						End if 
				End case 
				
			Else 
				Case of 
					: ($va_Rang5="F")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 2)+"F1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 5)
						$veNbPers:=$veNbPers+1
					: ($va_Rang5="Fenceinte")
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 4)+"B1"+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 7)
						$veNbPers:=$veNbPers+1
				End case 
			End if 
		End if 
		$vbNbPers:=False:C215
		If (($veNbPersM+$veNbPersA+$veNbPersE)>0)
			If ([HeberGement:5]HG_FamNbPers:106>$veNbPers)
				//[HéberGement]HG_FamCompoVar:="H0F0B0e00E00p0P0"
				Case of 
					: ($veNbPersE>0)
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 7)+String:C10(([HeberGement:5]HG_FamNbPers:106-$veNbPers+Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 8; 2))); "00")+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 10)
					: ($veNbPers M>0)
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 13)+String:C10(([HeberGement:5]HG_FamNbPers:106-$veNbPers+Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 14; 1))); "0")+Substring:C12([HeberGement:5]HG_FamCompoVar:117; 15)
					: ($veNbPers>0)
						[HeberGement:5]HG_FamCompoVar:117:=Substring:C12([HeberGement:5]HG_FamCompoVar:117; 1; 15)+String:C10(([HeberGement:5]HG_FamNbPers:106-$veNbPers+Num:C11(Substring:C12([HeberGement:5]HG_FamCompoVar:117; 16; 1))); "0")
				End case 
				
			End if 
		End if 
		P_HG_Famille(5)
	End if   // Si ($veDeuxPoint>0)
End if   //Si ([HéberGement]HG_FamCompo>"")