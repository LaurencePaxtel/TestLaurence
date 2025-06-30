//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : F_ChampObligatoire
//{
//{          Dimanche 19 aôut 2001 à 19:15
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_LONGINT:C283($ii; $ij)
C_BOOLEAN:C305($vb_OK)

C_LONGINT:C283(ve_Type; vl_Long)
C_BOOLEAN:C305(vb_Index)

$0:=True:C214
$ij:=Size of array:C274(<>te_RdsRub{$1})

Repeat 
	$ii:=$ii+1
	
	If (<>te_RdsRub{$1}{$ii}>0)
		
		If (<>tb_RdsObli{$1}{$ii})
			CLEAR VARIABLE:C89($vb_OK)
			GET FIELD PROPERTIES:C258(Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii}); ve_Type; vl_Long; vb_Index)
			
			Case of 
				: (ve_Type=Est un champ alpha:K8:1)
					
					If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>"")
						$vb_OK:=True:C214
					End if 
					
				: (ve_Type=Est un texte:K8:3)
					
					If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>"")
						$vb_OK:=True:C214
					End if 
					
				: (ve_Type=Est un numérique:K8:4)
					
					If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>0)
						$vb_OK:=True:C214
					End if 
					
				: (ve_Type=Est un entier:K8:5)
					
					If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>0)
						$vb_OK:=True:C214
					End if 
					
				: (ve_Type=Est un entier long:K8:6)
					
					If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>0)
						$vb_OK:=True:C214
					End if 
					
				: (ve_Type=Est une date:K8:7)
					
					If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>!00-00-00!)
						$vb_OK:=True:C214
					End if 
					
				: (ve_Type=Est une heure:K8:8)
					
					If (Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->>?00:00:00?)
						$vb_OK:=True:C214
					End if 
					
				: (ve_Type=Est un booléen:K8:9)
					$vb_OK:=True:C214
				: (ve_Type=Est une image:K8:10)
					$vb_OK:=True:C214
				: (ve_Type=Est une sous table:K8:11)
					_O_ALL SUBRECORDS:C109(Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->)
					$vb_OK:=(_O_Records in subselection:C7(Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->)>0)
				: (ve_Type=Est un BLOB:K8:12)
					$vb_OK:=True:C214
			End case 
			
			$0:=$vb_OK
			
			If ($vb_OK=False:C215)
				ALERT:C41(<>ta_RdsAlert{$1}{$ii})
			End if 
			
		End if 
		
	End if 
	
Until ($ii=$ij) | ($0=False:C215)