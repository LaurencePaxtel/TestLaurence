//%attributes = {}
//{==================================================}
//{          Procédure : i_Semaine
//{
//{          
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_DATE:C307($1)
C_LONGINT:C283($0)

C_DATE:C307($DateRéf; $DateTemp)
C_LONGINT:C283($ve_anné; $ve_NbJ; $ve_Sem1)

C_REAL:C285($vr_Sem)

$ve_anné:=Year of:C25($1)
$DateRéf:=Date:C102("01/01/"+String:C10($ve_anné))
$DateTemp:=$DateRéf

If (Day number:C114($DateTemp)#2)
	While (Day number:C114($DateTemp)#2)
		$DateTemp:=$DateTemp+1
	End while 
End if 

$ve_NbJ:=($1-$DateTemp)+1

If ($ve_NbJ<7)
	$ve_NbJ:=7
End if 

$vr_Sem:=$ve_NbJ/7
$ve_Sem1:=Int:C8($vr_Sem)

If (Dec:C9($vr_Sem)>0)
	$ve_Sem1:=$ve_Sem1+1
End if 

$0:=$ve_Sem1