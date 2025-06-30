//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DBsolutions/Paxtel
//{
//{          Procédure : TabFusion
//{
//{          Mercredi 29 janvier 20031 à 12:11
//{          Modifiée :
//{          Développement : GABBAY Jean-Guy
//{==================================================}
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($ii; $ij)
Case of 
	: ($1=0)
		ARRAY LONGINT:C221(tl_Fu_Référence; $2)
		ARRAY TEXT:C222(ta_FU_Clé; $2)
		ARRAY TEXT:C222(ta_FU_Nom; $2)
		ARRAY TEXT:C222(ta_FU_Prénom; $2)
		ARRAY DATE:C224(td_FU_Néle; $2)
		ARRAY BOOLEAN:C223(tb_FU_Sexe; $2)
		ARRAY BOOLEAN:C223(tb_FU_Statut; $2)
		ARRAY LONGINT:C221(tl_Fu_Nb; $2)
		
		C_LONGINT:C283(vL_Nb_HB_Fu)
		vL_Nb_HB_Fu:=$2
		
		tl_Fu_Référence:=$2
		ta_FU_Clé:=$2
		ta_FU_Nom:=$2
		ta_FU_Prénom:=$2
		td_FU_Néle:=$2
		tb_FU_Sexe:=$2
		tb_FU_Statut:=$2
		tl_Fu_Nb:=$2
		
		tl_Fu_Référence{0}:=tl_Fu_Référence{tl_Fu_Référence}
		ta_FU_Clé{0}:=ta_FU_Clé{ta_FU_Clé}
		ta_FU_Nom{0}:=ta_FU_Nom{ta_FU_Nom}
		ta_FU_Prénom{0}:=ta_FU_Prénom{ta_FU_Prénom}
		td_FU_Néle{0}:=td_FU_Néle{td_FU_Néle}
		tb_FU_Sexe{0}:=tb_FU_Sexe{tb_FU_Sexe}
		tb_FU_Statut{0}:=tb_FU_Statut{tb_FU_Statut}
		tl_Fu_Nb{0}:=tl_Fu_Nb{tl_Fu_Nb}
		
		
	: ($1=1)
		tl_Fu_Référence:=$2
		ta_FU_Clé:=$2
		ta_FU_Nom:=$2
		ta_FU_Prénom:=$2
		td_FU_Néle:=$2
		tb_FU_Sexe:=$2
		tb_FU_Statut:=$2
		tl_Fu_Nb:=$2
		
		tl_Fu_Référence{0}:=tl_Fu_Référence{tl_Fu_Référence}
		ta_FU_Clé{0}:=ta_FU_Clé{ta_FU_Clé}
		ta_FU_Nom{0}:=ta_FU_Nom{ta_FU_Nom}
		ta_FU_Prénom{0}:=ta_FU_Prénom{ta_FU_Prénom}
		td_FU_Néle{0}:=td_FU_Néle{td_FU_Néle}
		tb_FU_Sexe{0}:=tb_FU_Sexe{tb_FU_Sexe}
		tb_FU_Statut{0}:=tb_FU_Statut{tb_FU_Statut}
		tl_Fu_Nb{0}:=tl_Fu_Nb{tl_Fu_Nb}
		
		
		
	: ($1=2)
		
		$ii:=Size of array:C274(tl_Fu_Référence)+1
		vL_Nb_HB_Fu:=$ii
		INSERT IN ARRAY:C227(tl_Fu_Référence; $ii)
		INSERT IN ARRAY:C227(ta_FU_Clé; $ii)
		INSERT IN ARRAY:C227(ta_FU_Nom; $ii)
		INSERT IN ARRAY:C227(ta_FU_Prénom; $ii)
		INSERT IN ARRAY:C227(td_FU_Néle; $ii)
		INSERT IN ARRAY:C227(tb_FU_Sexe; $ii)
		INSERT IN ARRAY:C227(tb_FU_Statut; $ii)
		INSERT IN ARRAY:C227(tl_Fu_Nb; $ii)
		
		tl_Fu_Référence{$ii}:=[HeBerge:4]HB_ReferenceID:1
		ta_FU_Clé{$ii}:=[HeBerge:4]HB_Clé:2
		ta_FU_Nom{$ii}:=[HeBerge:4]HB_Nom:3
		ta_FU_Prénom{$ii}:=[HeBerge:4]HB_Prénom:4
		td_FU_Néle{$ii}:=[HeBerge:4]HB_DateNéLe:5
		tb_FU_Sexe{$ii}:=[HeBerge:4]HG_Genre:39
		tb_FU_Statut{$ii}:=[HeBerge:4]HB_Status:18
		tl_Fu_Nb{$ii}:=0
		
		SET QUERY DESTINATION:C396(Vers variable:K19:4; $ij)
		QUERY:C277([HeberGement:5]; [HeberGement:5]HG_HB_ID:19=tl_Fu_Référence{$ii})
		tl_Fu_Nb{$ii}:=$ij
		SET QUERY DESTINATION:C396(Vers sélection courante:K19:1)
		
		SORT ARRAY:C229(ta_FU_Clé; tl_Fu_Référence; ta_FU_Nom; ta_FU_Prénom; td_FU_Néle; tb_FU_Sexe; tb_FU_Statut; tl_Fu_Nb; >)
		$Pos:=Find in array:C230(ta_FU_Clé; [HeBerge:4]HB_Clé:2)
		If ($Pos>0)
		Else 
			$Pos:=0
		End if 
		Tab_Fusion(1; $Pos; 0)
	: ($1=3)
		
		DELETE FROM ARRAY:C228(tl_Fu_Référence; $2; 1)
		DELETE FROM ARRAY:C228(ta_FU_Clé; $2; 1)
		DELETE FROM ARRAY:C228(ta_FU_Nom; $2; 1)
		DELETE FROM ARRAY:C228(ta_FU_Prénom; $2; 1)
		DELETE FROM ARRAY:C228(td_FU_Néle; $2; 1)
		DELETE FROM ARRAY:C228(tb_FU_Sexe; $2; 1)
		DELETE FROM ARRAY:C228(tb_FU_Statut; $2; 1)
		DELETE FROM ARRAY:C228(tl_Fu_Nb; $2; 1)
		
		$ii:=Size of array:C274(tl_Fu_Référence)
		If ($ii>0)
			Case of 
				: ($2=1)
					$ii:=1
				: ($2>1) & ($2<$ii)
					$ii:=$2
			End case 
		End if 
		Tab_Fusion(1; $ii; 0)
		vL_Nb_HB_Fu:=$ii
		
	: ($1=4)
		vl_IDT_RéfU:=tl_Fu_Référence{$2}
		va_IDT_Old:=ta_FU_Clé{$2}
		va_IDT_Nom:=ta_FU_Nom{$2}
		va_IDT_Pré:=ta_FU_Prénom{$2}
		vd_IDT_NéLe:=td_FU_Néle{$2}
		vl_IDT_Stat:=Num:C11(tb_FU_Statut{$2}=True:C214)
	: ($1=5)
		tl_Fu_Référence{$2}:=vl_IDT_RéfU
		ta_FU_Clé{$2}:=va_IDT_Clé
		ta_FU_Nom{$2}:=va_IDT_Nom
		ta_FU_Prénom{$2}:=va_IDT_Pré
		td_FU_Néle{$2}:=vd_IDT_NéLe
		tb_FU_Statut{$2}:=(vl_IDT_Stat=1)
		
		
End case 