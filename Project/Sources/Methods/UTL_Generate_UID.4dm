//%attributes = {}
// ----------------------------------------------------
// Nom utilisateur (OS) : Kevin HASSAL
// Date et heure : 20/10/18, 00:10:28
// ----------------------------------------------------
// Méthode : UTL_Generate_UID
// Description
// 
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($FT6_A; $FT7_A; $FT5_A; $ref; $0)
$FT6_A:=String:C10(Current date:C33(*); Interne date court:K1:7)
If (Length:C16($FT6_A)=7)
	$FT6_A:="0"+$FT6_A
End if 
$FT7_A:=String:C10(Current time:C178(*); h mn s:K7:1)
$FT5_A:=""
For ($i; 1; 5)
	$FT5_A:=$FT5_A+Char:C90(Mod:C98((Random:C100+Milliseconds:C459); 26)+65)
End for 
$ref:=$FT6_A[[1]]+$FT6_A[[2]]+$FT6_A[[4]]+$FT6_A[[5]]+$FT6_A[[9]]+$FT6_A[[10]]+$FT7_A[[1]]+$FT7_A[[2]]+$FT7_A[[4]]+$FT7_A[[5]]+$FT7_A[[7]]+$FT7_A[[8]]+$FT5_A
$0:=$ref


$ref:=String:C10(Current date:C33(*); Interne date court:K1:7)+String:C10(Current time:C178)+String:C10(Milliseconds:C459)+String:C10(Random:C100)

$ref:=Replace string:C233($ref; "/"; "")
$ref:=Replace string:C233($ref; ":"; "")

$0:=$ref
