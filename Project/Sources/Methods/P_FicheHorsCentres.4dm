//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Scanu Rémy
// Date et heure : 23/08/22, 17:35:54
// ----------------------------------------------------
// Méthode : P_FicheHorsCentres
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii; $ij)
C_BOOLEAN:C305($vb_OK)

If ($2>0)
	$vb_OK:=($2>=<>vl_T_CentreCodeDebut)
	$vb_OK:=$vb_OK & ($2<=<>vl_T_CentreCodeFin)
	
	$vb_OK:=Not:C34($vb_OK)
End if 

If ($vb_OK)
	$ij:=Size of array:C274(<>te_RdsRub{$1})
	
	For ($ii; 1; $ij)
		
		If (<>te_RdsRub{$1}{$ii}>0)
			
			If (<>tb_RdsVis{$1}{$ii}=True:C214)
				$va_Ico:=String:C10(<>te_RdsRub{$1}{$ii}; "000")+"_ico2"
				OBJECT SET VISIBLE:C603(*; $va_Ico; False:C215)
				
				$va_Ico:=String:C10(<>te_RdsRub{$1}{$ii}; "000")+"_ico1"
				OBJECT SET VISIBLE:C603(*; $va_Ico; False:C215)
				
				$va_Ico:=String:C10(<>te_RdsRub{$1}{$ii}; "000")+"_Bt@"
				OBJECT SET VISIBLE:C603(*; $va_Ico; False:C215)
				
				OBJECT SET ENTERABLE:C238(Field:C253(<>te_RdsFic{$1}{$ii}; <>te_RdsRub{$1}{$ii})->; False:C215)
			End if 
			
		End if 
		
	End for 
	
	OBJECT SET ENABLED:C1123(b_Val; False:C215)
	OBJECT SET VISIBLE:C603(*; "103_Bt1"; True:C214)
	OBJECT SET VISIBLE:C603(*; "103_Bt2"; True:C214)
	OBJECT SET ENABLED:C1123(x1; False:C215)
	OBJECT SET ENABLED:C1123(x2; False:C215)
	OBJECT SET ENTERABLE:C238(va_CtrLib; False:C215)
End if 