//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TableSTR
//{
//{          Vendredi 17 Aôut 2001 à 15:53
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)
Case of 
	: ($1=0)
		ARRAY TEXT:C222(ta_STR; $2)
		ARRAY LONGINT:C221(tl_STRno; $2)
		ARRAY TEXT:C222(ta_STRtitre; $2)
		ta_STR:=0
		tl_STRno:=0
		ta_STRtitre:=0
		ARRAY INTEGER:C220(tl_STRrang; $2)
		ARRAY TEXT:C222(ta_STRlibellé; $2)
		tl_STRrang:=0
		ta_STRlibellé:=0
		
		C_LONGINT:C283(vl_STRrang)
		C_TEXT:C284(va_STRlibellé)
		vl_STRrang:=0
		va_STRlibellé:=""
	: ($1=1)
		ta_STR:=$2
		tl_STRno:=$2
		ta_STRtitre:=$2
		ta_STR{0}:=ta_STR{ta_STR}
		tl_STRno{0}:=tl_STRno{tl_STRno}
		ta_STRtitre{0}:=ta_STRtitre{ta_STRtitre}
		
	: ($1=2)
		tl_STRrang:=$2
		ta_STRlibellé:=$2
		tl_STRrang{0}:=tl_STRrang{tl_STRrang}
		ta_STRlibellé{0}:=ta_STRlibellé{ta_STRlibellé}
		If ($2>0)
			vl_STRrang:=tl_STRrang{$2}
			va_STRlibellé:=ta_STRlibellé{$2}
		Else 
			vl_STRrang:=0
			va_STRlibellé:=""
		End if 
	: ($1=3)
		
		// STRING LIST TO ARRAY(30002;ta_STR)
		
		// #BS Migration v15 30/05/16
		// Remplacement de la commande obsolète
		// STRING LIST TO ARRAY par xliff_STRING_LIST_TO_ARRAY
		ARRAY TEXT:C222(ta_STR; 0)
		xliff_STRING_LIST_TO_ARRAY_(30002; ->ta_STR)
		
		
		
		$ii:=Size of array:C274(ta_STR)
		ARRAY LONGINT:C221(tl_STRno; $ii)
		ARRAY TEXT:C222(ta_STRtitre; $ii)
		For ($ii; 1; Size of array:C274(ta_STR))
			tl_STRno{$ii}:=Num:C11(Substring:C12(ta_STR{$ii}; 1; 5))
			ta_STRtitre{$ii}:=Substring:C12(ta_STR{$ii}; 6)
		End for 
		
		
	: ($1=4)
		
		// STRING LIST TO ARRAY(tl_STRno{tl_STRno};ta_STRlibellé)
		
		
		// #BS Migration v15 30/05/16
		// Remplacement de la commande obsolète
		// STRING LIST TO ARRAY par xliff_STRING_LIST_TO_ARRAY
		ARRAY TEXT:C222(ta_STRlibellé; 0)
		xliff_STRING_LIST_TO_ARRAY_(tl_STRno{tl_STRno}; ->ta_STRlibellé)
		
		
		
		$ii:=Size of array:C274(ta_STRlibellé)
		ARRAY INTEGER:C220(tl_STRrang; $ii)
		For ($ii; 1; Size of array:C274(ta_STRlibellé))
			tl_STRrang{$ii}:=$ii
		End for 
		
		
	: ($1=5)
		Case of 
			: ($2=1)
				SORT ARRAY:C229(tl_STRrang; ta_STRlibellé; >)
			: ($2=2)
				SORT ARRAY:C229(ta_STRlibellé; tl_STRrang; >)
		End case 
		
	: ($1=6)
		If (i_Confirmer(ta_STR{0}+Char:C90(13)+"Enregistrer les modifications des libellés ?"))
			i_Message("Enregistrements en cours…")
			SORT ARRAY:C229(tl_STRrang; ta_STRlibellé; >)
			
			// _o_ARRAY TO STRING LIST(ta_STRlibellé;tl_STRno{tl_STRno})
			
			// #BS Migration v15 30/05/16
			// Remplacement de la commande obsolète
			// _o_ARRAY TO STRING LIST par xliff_ARRAY_TO_XLIFF
			xliff_ARRAY_TO_XLIFF_(->ta_STRlibellé; tl_STRno{tl_STRno})
			
			//====================================================//
			// Modified by: Kevin HASSAL (12/10/2020)
			//  Gestion Multi-Sociétés : Gestion des fichiers XLIFF par structure
			//====================================================//
			xliff_ARRAY_TO_XLIFF_(->ta_STRlibellé; (tl_STRno{tl_STRno}*1000)+<>ID_Societe_Active)
			
			CLOSE WINDOW:C154
		End if 
	: ($1=7)
		$ii:=Size of array:C274(tl_STRrang)+1
		INSERT IN ARRAY:C227(tl_STRrang; $ii)
		INSERT IN ARRAY:C227(ta_STRlibellé; $ii)
		tl_STRrang:=$ii
		ta_STRlibellé:=$ii
		ta_STRlibellé{0}:=ta_STRlibellé{ta_STRlibellé}
		vl_STRrang:=$ii
		tl_STRrang{tl_STRrang}:=vl_STRrang
		tl_STRrang{0}:=tl_STRrang{tl_STRrang}
		va_STRlibellé:=""
		
	: ($1=8)
		If ($2>0)
			DELETE FROM ARRAY:C228(tl_STRrang; $2; 1)
			DELETE FROM ARRAY:C228(ta_STRlibellé; $2; 1)
		End if 
		If ($2>Size of array:C274(tl_STRrang))
			$2:=Size of array:C274(tl_STRrang)
		End if 
		If (Size of array:C274(ta_STRlibellé)>0)
			tl_STRrang:=$2
			ta_STRlibellé:=$2
			tl_STRrang{0}:=tl_STRrang{tl_STRrang}
			ta_STRlibellé{0}:=ta_STRlibellé{ta_STRlibellé}
			vl_STRrang:=tl_STRrang{0}
			va_STRlibellé:=ta_STRlibellé{0}
		Else 
			tl_STRrang:=0
			ta_STRlibellé:=0
			tl_STRrang{0}:=tl_STRrang{tl_STRrang}
			ta_STRlibellé{0}:=ta_STRlibellé{ta_STRlibellé}
			vl_STRrang:=0
			va_STRlibellé:=""
		End if 
		
End case 