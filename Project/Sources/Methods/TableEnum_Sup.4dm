//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableEnum_Sup
//{
//{          Mercredi 29 Octobre 1997 à 12:47:45
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)  //Le cas dans lequel on se trouve
C_POINTER:C301($2)  //Ptr variable TT_RéférenceID
C_POINTER:C301($3)  //Ptr variable TB_Niveau
C_POINTER:C301($4)  //Ptr variable TB_TT_Niveau
C_POINTER:C301($5)  //Ptr variable TB_Code

C_LONGINT:C283($ii)
C_LONGINT:C283($ij)
$ij:=$3->+1
For ($ii; $1; $ij; -1)
	
	$LibRech:=(Substring:C12($4->; 1; 6)*Num:C11($ii=1))+(Substring:C12($4->; 1; 10)*Num:C11($ii=2))+(Substring:C12($4->; 1; 14)*Num:C11($ii=3))+(Substring:C12($4->; 1; 18)*Num:C11($ii=4))
	$LibRech:=Substring:C12($LibRech; 1; 4)+String:C10($ii; "0")+Substring:C12($LibRech; 6)+"@"
	QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=$LibRech)
	MultiSoc_Filter(->[TAbles:12])
	If (Records in selection:C76([TAbles:12])>0)
		DELETE SELECTION:C66([TAbles:12])
	End if 
	
End for 