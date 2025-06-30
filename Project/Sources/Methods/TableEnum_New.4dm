//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableEnum_New  
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

C_TEXT:C284($LibRech)
C_LONGINT:C283($NoOrdre; $Pos)
Case of 
	: ($1=2)
		$LibRech:=(Substring:C12($4->; 1; 6)*Num:C11($3->=1))+(Substring:C12($4->; 1; 10)*Num:C11($3->=2))+(Substring:C12($4->; 1; 14)*Num:C11($3->=3))+(Substring:C12($4->; 1; 18)*Num:C11($3->=4))
		$LibRech:=$LibRech+"@"
		QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=$LibRech)
		MultiSoc_Filter(->[TAbles:12])
		If (Records in selection:C76([TAbles:12])>0)
			ORDER BY:C49([TAbles:12]; [TAbles:12]TB_Code:5; <)
			//FIRST RECORD([TAbles])
			$Pos:=(7*Num:C11($3->=1))+(11*Num:C11($3->=2))+(15*Num:C11($3->=3))+(19*Num:C11($3->=4))
			$NoOrdre:=Num:C11(Substring:C12([TAbles:12]TB_TT_Niveau:4; $Pos; 3))+1
			$4->:=Substring:C12($4->; 1; $Pos-1)+String:C10($NoOrdre; "000")+Substring:C12($4->; $Pos+3; Length:C16($4->))
			$5->:=Substring:C12($4->; 1; 4)+Substring:C12($4->; 7; Length:C16($4->))
		End if 
		
		
	: ($1=3)
		
		$3->:=$3->+1
		
		$LibRech:=(Substring:C12($4->; 1; 6)*Num:C11($3->=1))+(Substring:C12($4->; 1; 10)*Num:C11($3->=2))+(Substring:C12($4->; 1; 14)*Num:C11($3->=3))+(Substring:C12($4->; 1; 18)*Num:C11($3->=4))
		$LibRech:=Substring:C12($LibRech; 1; 4)+String:C10($3->; "0")+Substring:C12($LibRech; 6)+"@"
		
		$Pos:=(7*Num:C11($3->=1))+(11*Num:C11($3->=2))+(15*Num:C11($3->=3))+(19*Num:C11($3->=4))
		$3->:=$3->-1
		$Pos1:=(7*Num:C11($3->=1))+(11*Num:C11($3->=2))+(15*Num:C11($3->=3))+(19*Num:C11($3->=4))
		$3->:=$3->+1
		
		QUERY:C277([TAbles:12]; [TAbles:12]TB_TT_Niveau:4=$LibRech)
		MultiSoc_Filter(->[TAbles:12])
		If (Records in selection:C76([TAbles:12])>0)
			ORDER BY:C49([TAbles:12]; [TAbles:12]TB_Code:5; <)
			//FIRST RECORD([TAbles])
			$NoOrdre:=Num:C11(Substring:C12([TAbles:12]TB_TT_Niveau:4; $Pos; 3))+1
		Else 
			$NoOrdre:=1
		End if 
		
		$4->:=Substring:C12($4->; 1; 4)+String:C10($3->; "0")+Substring:C12($4->; 6; $Pos-6)+String:C10($NoOrdre; "000")+Substring:C12($4->; $Pos+3)
		$5->:=Substring:C12($4->; 1; 4)+Substring:C12($4->; 7; Length:C16($4->))
End case 