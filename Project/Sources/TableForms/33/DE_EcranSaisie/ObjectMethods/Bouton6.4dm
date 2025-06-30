vd_DSP_D1_1:=!00-00-00!
vd_DSP_D2_1:=!00-00-00!
vd_DSP_D3_1:=!00-00-00!
vd_DSP_D4_1:=!00-00-00!
vd_DSP_D5_1:=!00-00-00!
vd_DSP_D6_1:=!00-00-00!
vd_DSP_D7_1:=!00-00-00!

va_DSP_D1_1:=""
va_DSP_D2_1:=""
va_DSP_D3_1:=""
va_DSP_D4_1:=""
va_DSP_D5_1:=""
va_DSP_D6_1:=""
va_DSP_D7_1:=""

C_TEXT:C284(va_DateEtHeure)
If ([DossierSante:33]DE_SoinsDébut:124=!00-00-00!)
	StrAlerte(59; "")
Else 
	va_LeNoFeuille:=""
	ve_LeNoFeuille:=0
	$vd_DateDeb:=!00-00-00!
	$vd_DateFin:=!00-00-00!
	$vd_DateDeb:=[DossierSante:33]DE_SoinsDébut:124
	$vd_DateFin:=[DossierSante:33]DE_SoinsFin:125
	
	//Calcul du premier jour de la semaine : Lundi
	If (Day number:C114($vd_DateDeb)#2)
		Repeat 
			$vd_DateDeb:=$vd_DateDeb-1
		Until (Day number:C114($vd_DateDeb)=2)
	End if 
	vd_DSP_D1_1:=$vd_DateDeb
	vd_DSP_D2_1:=$vd_DateDeb+1
	vd_DSP_D3_1:=$vd_DateDeb+2
	vd_DSP_D4_1:=$vd_DateDeb+3
	vd_DSP_D5_1:=$vd_DateDeb+4
	vd_DSP_D6_1:=$vd_DateDeb+5
	vd_DSP_D7_1:=$vd_DateDeb+6
	va_DSP_D1_1:="LU "+String:C10(Day of:C23(vd_DSP_D1_1))+"/"+String:C10(Month of:C24(vd_DSP_D1_1))
	va_DSP_D2_1:="MA "+String:C10(Day of:C23(vd_DSP_D2_1))+"/"+String:C10(Month of:C24(vd_DSP_D2_1); "00")
	va_DSP_D3_1:="ME "+String:C10(Day of:C23(vd_DSP_D3_1))+"/"+String:C10(Month of:C24(vd_DSP_D3_1); "00")
	va_DSP_D4_1:="JE "+String:C10(Day of:C23(vd_DSP_D4_1))+"/"+String:C10(Month of:C24(vd_DSP_D4_1); "00")
	va_DSP_D5_1:="VE "+String:C10(Day of:C23(vd_DSP_D5_1))+"/"+String:C10(Month of:C24(vd_DSP_D5_1); "00")
	va_DSP_D6_1:="SA "+String:C10(Day of:C23(vd_DSP_D6_1))+"/"+String:C10(Month of:C24(vd_DSP_D6_1); "00")
	va_DSP_D7_1:="DI "+String:C10(Day of:C23(vd_DSP_D7_1))+"/"+String:C10(Month of:C24(vd_DSP_D7_1); "00")
	If ([DossierSante:33]DE_SoinsFin:125>!00-00-00!) & ([DossierSante:33]DE_SoinsFin:125>=[DossierSante:33]DE_SoinsDébut:124)
		//Calcul du premier jour de la semaine : Lundi
		If (Day number:C114($vd_DateFin)#1)
			Repeat 
				$vd_DateFin:=$vd_DateFin+1
			Until (Day number:C114($vd_DateFin)=1)
		End if 
		ve_LeNoFeuille:=$vd_DateFin-$vd_DateDeb+1
		ve_LeNoFeuille:=ve_LeNoFeuille/7
		
		_O_PAGE SETUP:C299([DossierSante:33]; "DE_ListePrescription")
		PRINT SETTINGS:C106
		If (OK=1)
			<>va_T_02:=[DossierSante:33]DE_Centre:11
			va_DateEtHeure:="le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)
			FORM SET OUTPUT:C54([DossierSante:33]; "DE_ListePrescription")
			FORM SET INPUT:C55([DossierSante:33]; "DE_ListePrescription")
			For ($ii; 1; ve_LeNoFeuille)
				va_LeNoFeuille:=String:C10($ii)
				If ($ii>1)
					$vd_DateDeb:=$vd_DateDeb+7
					vd_DSP_D1_1:=$vd_DateDeb
					vd_DSP_D2_1:=$vd_DateDeb+1
					vd_DSP_D3_1:=$vd_DateDeb+2
					vd_DSP_D4_1:=$vd_DateDeb+3
					vd_DSP_D5_1:=$vd_DateDeb+4
					vd_DSP_D6_1:=$vd_DateDeb+5
					vd_DSP_D7_1:=$vd_DateDeb+6
					va_DSP_D1_1:="LU "+String:C10(Day of:C23(vd_DSP_D1_1))+"/"+String:C10(Month of:C24(vd_DSP_D1_1); "00")
					va_DSP_D2_1:="MA "+String:C10(Day of:C23(vd_DSP_D2_1))+"/"+String:C10(Month of:C24(vd_DSP_D2_1); "00")
					va_DSP_D3_1:="ME "+String:C10(Day of:C23(vd_DSP_D3_1))+"/"+String:C10(Month of:C24(vd_DSP_D3_1); "00")
					va_DSP_D4_1:="JE "+String:C10(Day of:C23(vd_DSP_D4_1))+"/"+String:C10(Month of:C24(vd_DSP_D4_1); "00")
					va_DSP_D5_1:="VE "+String:C10(Day of:C23(vd_DSP_D5_1))+"/"+String:C10(Month of:C24(vd_DSP_D5_1); "00")
					va_DSP_D6_1:="SA "+String:C10(Day of:C23(vd_DSP_D6_1))+"/"+String:C10(Month of:C24(vd_DSP_D6_1); "00")
					va_DSP_D7_1:="DI "+String:C10(Day of:C23(vd_DSP_D7_1))+"/"+String:C10(Month of:C24(vd_DSP_D7_1); "00")
				End if 
				If (vd_DSP_D1_1<[DossierSante:33]DE_SoinsDébut:124)
					va_DSP_D1_1:="LU"
				End if 
				If (vd_DSP_D2_1<[DossierSante:33]DE_SoinsDébut:124)
					va_DSP_D2_1:="MA"
				End if 
				If (vd_DSP_D3_1<[DossierSante:33]DE_SoinsDébut:124)
					va_DSP_D3_1:="ME"
				End if 
				If (vd_DSP_D4_1<[DossierSante:33]DE_SoinsDébut:124)
					va_DSP_D4_1:="JE"
				End if 
				If (vd_DSP_D5_1<[DossierSante:33]DE_SoinsDébut:124)
					va_DSP_D5_1:="VE"
				End if 
				If (vd_DSP_D6_1<[DossierSante:33]DE_SoinsDébut:124)
					va_DSP_D6_1:="SA"
				End if 
				
				
				If (vd_DSP_D7_1<[DossierSante:33]DE_SoinsDébut:124)
					va_DSP_D7_1:="DI"
				End if 
				
				If (vd_DSP_D1_1>[DossierSante:33]DE_SoinsFin:125)
					va_DSP_D1_1:="LU"
				End if 
				If (vd_DSP_D2_1>[DossierSante:33]DE_SoinsFin:125)
					va_DSP_D2_1:="MA"
				End if 
				If (vd_DSP_D3_1>[DossierSante:33]DE_SoinsFin:125)
					va_DSP_D3_1:="ME"
				End if 
				If (vd_DSP_D4_1>[DossierSante:33]DE_SoinsFin:125)
					va_DSP_D4_1:="JE"
				End if 
				If (vd_DSP_D5_1>[DossierSante:33]DE_SoinsFin:125)
					va_DSP_D5_1:="VE"
				End if 
				If (vd_DSP_D6_1>[DossierSante:33]DE_SoinsFin:125)
					va_DSP_D6_1:="SA"
				End if 
				If (vd_DSP_D7_1>[DossierSante:33]DE_SoinsFin:125)
					va_DSP_D7_1:="DI"
				End if 
				PRINT RECORD:C71([DossierSante:33]; *)
			End for 
		End if 
	End if 
	If ([DossierSante:33]DE_SoinsFin:125=!00-00-00!)
		va_LeNoFeuille:=Request:C163("Quel n° de feuille (semaine) ?"; "0")
		If (OK=1) & (Num:C11(va_LeNoFeuille)>0)
			ve_LeNoFeuille:=Num:C11(va_LeNoFeuille)
			If (ve_LeNoFeuille=1)
			Else 
				$vd_DateDeb:=$vd_DateDeb+(7*(ve_LeNoFeuille-1))
				vd_DSP_D1_1:=$vd_DateDeb
				vd_DSP_D2_1:=$vd_DateDeb+1
				vd_DSP_D3_1:=$vd_DateDeb+2
				vd_DSP_D4_1:=$vd_DateDeb+3
				vd_DSP_D5_1:=$vd_DateDeb+4
				vd_DSP_D6_1:=$vd_DateDeb+5
				vd_DSP_D7_1:=$vd_DateDeb+6
				va_DSP_D1_1:="LU "+String:C10(Day of:C23(vd_DSP_D1_1))+"/"+String:C10(Month of:C24(vd_DSP_D1_1); "00")
				va_DSP_D2_1:="MA "+String:C10(Day of:C23(vd_DSP_D2_1))+"/"+String:C10(Month of:C24(vd_DSP_D2_1); "00")
				va_DSP_D3_1:="ME "+String:C10(Day of:C23(vd_DSP_D3_1))+"/"+String:C10(Month of:C24(vd_DSP_D3_1); "00")
				va_DSP_D4_1:="JE "+String:C10(Day of:C23(vd_DSP_D4_1))+"/"+String:C10(Month of:C24(vd_DSP_D4_1); "00")
				va_DSP_D5_1:="VE "+String:C10(Day of:C23(vd_DSP_D5_1))+"/"+String:C10(Month of:C24(vd_DSP_D5_1); "00")
				va_DSP_D6_1:="SA "+String:C10(Day of:C23(vd_DSP_D6_1))+"/"+String:C10(Month of:C24(vd_DSP_D6_1); "00")
				va_DSP_D7_1:="DI "+String:C10(Day of:C23(vd_DSP_D7_1))+"/"+String:C10(Month of:C24(vd_DSP_D7_1); "00")
			End if 
			If (vd_DSP_D1_1<[DossierSante:33]DE_SoinsDébut:124)
				va_DSP_D1_1:="LU"
			End if 
			If (vd_DSP_D2_1<[DossierSante:33]DE_SoinsDébut:124)
				va_DSP_D2_1:="MA"
			End if 
			If (vd_DSP_D3_1<[DossierSante:33]DE_SoinsDébut:124)
				va_DSP_D3_1:="ME"
			End if 
			If (vd_DSP_D4_1<[DossierSante:33]DE_SoinsDébut:124)
				va_DSP_D4_1:="JE"
			End if 
			If (vd_DSP_D5_1<[DossierSante:33]DE_SoinsDébut:124)
				va_DSP_D5_1:="VE"
			End if 
			If (vd_DSP_D6_1<[DossierSante:33]DE_SoinsDébut:124)
				va_DSP_D6_1:="SA"
			End if 
			If (vd_DSP_D7_1<[DossierSante:33]DE_SoinsDébut:124)
				va_DSP_D7_1:="DI"
			End if 
			
			
			_O_PAGE SETUP:C299([DossierSante:33]; "DE_ListePrescription")
			PRINT SETTINGS:C106
			If (OK=1)
				<>va_T_02:=[DossierSante:33]DE_Centre:11
				va_DateEtHeure:="le "+String:C10(Current date:C33)+" à "+String:C10(Current time:C178)
				FORM SET OUTPUT:C54([DossierSante:33]; "DE_ListePrescription")
				FORM SET INPUT:C55([DossierSante:33]; "DE_ListePrescription")
				PRINT RECORD:C71([DossierSante:33]; *)
			End if 
		End if 
	End if 
End if 