//%attributes = {}
C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2)

C_TEXT:C284($va_Type)
C_DATE:C307($vd_Date)


Case of 
	: ($1="Site")
		If (Length:C16($2->)>=3)
			$0:=$2->
		Else 
			$0:=$2->+(" "*(3-Length:C16($2->)))
		End if 
		
	: ($1="Departement")
		If (Length:C16($2->)>=2)
			$0:=Substring:C12($2->; 1; 2)
		Else 
			$0:=$2->+("X"*(2-Length:C16($2->)))
		End if 
		
	: ($1="ReferenceID")
		$0:=String:C10($2->; "0000000000")
		
	: ($1="DATESIAO")
		//$0:="YYYY-MM-DD HH:MI:SS"
		If ($2->>!00-00-00!)
			$0:=String:C10(Year of:C25($2->); "0000")
			$0:=$0+"-"+String:C10(Month of:C24($2->); "00")
			$0:=$0+"-"+String:C10(Day of:C23($2->); "00")
			$0:=$0+" "+"00:00:00"
		Else 
			$0:=""
		End if 
		
	: ($1="DateSIAOSortie")
		If ($3->>0)
			$vd_Date:=Add to date:C393($2->; 0; 0; $3->)
		Else 
			$vd_Date:=$2->
		End if 
		//$0:="YYYY-MM-DD HH:MI:SS"
		
		If ($vd_Date>!00-00-00!)
			$0:=String:C10(Year of:C25($vd_Date); "0000")
			$0:=$0+"-"+String:C10(Month of:C24($vd_Date); "00")
			$0:=$0+"-"+String:C10(Day of:C23($vd_Date); "00")
			$0:=$0+" "+"00:00:00"
		Else 
			$0:=""
		End if 
		
	: ($1="BoolSIAO")
		$0:=String:C10(Num:C11($2->); "0")
		
		
	: ($1="TypeSIAO")
		$0:=("Urgence"*Num:C11($2->=False:C215))+("Insertion"*Num:C11($2->=True:C214))
		
	: ($1="TypeCentre")
		If (Substring:C12($2->; 1; 3)="115")
			$0:="Urgence"
		Else 
			$va_Type:=Substring:C12($2->; 1; 2)
			
			Case of 
				: ($va_Type="00")
					$0:="Urgence"
				: ($va_Type="01")
					$0:="Stabilisation"
				: ($va_Type="02")
					$0:="Insertion"
				: ((Num:C11($va_Type)>=3) & (Num:C11($va_Type)<=39))
					$0:="Logement"
				Else 
					$0:="Pas d hebergement"
			End case 
		End if 
		
	: ($1="BoolAlphaSIAO")
		If ($2->)
			$0:="t"
		Else 
			$0:="f"
		End if 
		
	: ($1="TypeAdmission")
		If ($2->="115")
			$0:="t"
		Else 
			$0:="f"
		End if 
		
	: ($1="BoolReferent")
		If ($2->>"")
			$0:="t"
		Else 
			$0:="f"
		End if 
		
		
		
		
End case 