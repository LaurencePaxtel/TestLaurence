//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{          Procédure : Migration_Appliquer
//{          Mardi 25 octobre 2011 à 10:30
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_TIME:C306($1)
C_POINTER:C301($2)
C_LONGINT:C283($ii)
C_TEXT:C284($vt_Temp)

For ($ii; 1; Get last field number:C255($2))
	GET FIELD PROPERTIES:C258(Table:C252($2); $ii; vl_Type; vl_Long; vb_Index)
	$vb_OK:=True:C214
	Case of 
		: (vl_Type=Est un champ alpha:K8:1)
			$vt_Temp:=Field:C253(Table:C252($2); $ii)->
		: (vl_Type=Est un texte:K8:3)
			$vt_Temp:=Field:C253(Table:C252($2); $ii)->
			$vt_Temp:=Replace string:C233($vt_Temp; "≤"; "-")
			$vt_Temp:=Replace string:C233($vt_Temp; Char:C90(13); "≤")
		: (vl_Type=Est un numérique:K8:4)
			$vt_Temp:=String:C10(Field:C253(Table:C252($2); $ii)->)
		: (vl_Type=Est un entier:K8:5)
			$vt_Temp:=String:C10(Field:C253(Table:C252($2); $ii)->)
		: (vl_Type=Est un entier long:K8:6)
			$vt_Temp:=String:C10(Field:C253(Table:C252($2); $ii)->)
		: (vl_Type=Est une date:K8:7)
			$vt_Temp:=String:C10(Field:C253(Table:C252($2); $ii)->; Interne date court:K1:7)
		: (vl_Type=Est une heure:K8:8)
			$vt_Temp:=String:C10(Field:C253(Table:C252($2); $ii)->; h mn s:K7:1)
		: (vl_Type=Est un booléen:K8:9)
			$vt_Temp:=("O"*Num:C11(Field:C253(Table:C252($2); $ii)->))
			$vt_Temp:=$vt_Temp+("N"*Num:C11(Field:C253(Table:C252($2); $ii)->=False:C215))
		: (vl_Type=Est une image:K8:10)
			$vt_Temp:=""
			$vb_OK:=False:C215
		: (vl_Type=Est une sous table:K8:11)
			$vt_Temp:=""
			$vb_OK:=False:C215
		: (vl_Type=Est un BLOB:K8:12)
			$vt_Temp:=""
			$vb_OK:=False:C215
		Else 
			$vb_OK:=False:C215
	End case 
	If ($vb_OK)
		If ($ii=1)
			SEND PACKET:C103($1; $vt_Temp)
		Else 
			SEND PACKET:C103($1; Char:C90(9)+$vt_Temp)
		End if 
	End if 
	
End for 
SEND PACKET:C103($1; Char:C90(13))