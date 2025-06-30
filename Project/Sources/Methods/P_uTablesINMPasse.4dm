//%attributes = {}
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($ii)
Case of 
	: ($1=0)
		//Les Utilisateurs
		ARRAY TEXT:C222(ta_MPUserNom; 0)
		ARRAY LONGINT:C221(tl_MPUserRéf; 0)
		//Les Groupes
		ARRAY TEXT:C222(ta_MPGroupeNom; 0)
		ARRAY LONGINT:C221(tl_MPGroupeRéf; 0)
		GET USER LIST:C609(ta_MPUserNom; tl_MPUserRéf)
		GET GROUP LIST:C610(ta_MPGroupeNom; tl_MPGroupeRéf)
		
		
		
		//Dialogue Les Utilisateurs
		ARRAY TEXT:C222(ta_UserNom; 0)
		ARRAY LONGINT:C221(tl_UserRéf; 0)
		ARRAY INTEGER:C220(te_UserEtat; 0)
		//Dialogue Les Groupes
		ARRAY TEXT:C222(ta_GroupeNom; 0)
		ARRAY LONGINT:C221(tl_GroupeRéf; 0)
		
		COPY ARRAY:C226(ta_MPUserNom; ta_UserNom)
		COPY ARRAY:C226(tl_MPUserRéf; tl_UserRéf)
		
		COPY ARRAY:C226(ta_MPGroupeNom; ta_GroupeNom)
		COPY ARRAY:C226(tl_MPGroupeRéf; tl_GroupeRéf)
		
		ARRAY INTEGER:C220(te_UserEtat; Size of array:C274(ta_UserNom))
		
		
		For ($ii; 1; Size of array:C274(ta_UserNom))
			If (Is user deleted:C616(tl_UserRéf{$ii}))
				te_UserEtat{$ii}:=1
			Else 
				te_UserEtat{$ii}:=0
			End if 
		End for 
		vL_Nb_User:=Size of array:C274(ta_UserNom)
		vL_Nb_Groupe:=Size of array:C274(ta_GroupeNom)
		
		ta_UserNom:=0
		tl_UserRéf:=0
		te_UserEtat:=0
		ta_GroupeNom:=0
		tl_GroupeRéf:=0
		
	: ($1=1)
		ta_UserNom:=$2
		tl_UserRéf:=$2
		te_UserEtat:=$2
	: ($1=2)
		ta_GroupeNom:=$2
		tl_GroupeRéf:=$2
	: ($1=3)
		ta_UserNom:=$2
		tl_UserRéf:=$2
		te_UserEtat:=$2
		If (Size of array:C274(ta_UserNom)>0)
			If ($2>0)
				gError:=0
				ON ERR CALL:C155("i_Error")
				If (Is user deleted:C616(tl_UserRéf{tl_UserRéf}))
					ALERT:C41("L'utilisateur "+ta_UserNom{ta_UserNom}+" a déjà été supprimé !")
					//Dialogue Les Groupes
					ARRAY TEXT:C222(ta_GroupeNom; 0)
					ARRAY LONGINT:C221(tl_GroupeRéf; 0)
					ta_GroupeNom:=0
					tl_GroupeRéf:=0
				Else 
					GET USER PROPERTIES:C611(tl_UserRéf{tl_UserRéf}; va_UserNom; va_UserProc; va_UserMP; vl_UserNb; vd_UserDSate; tl_GroupeRéf)
					ARRAY TEXT:C222(ta_GroupeNom; Size of array:C274(tl_GroupeRéf))
					For ($ii; 1; Size of array:C274(ta_GroupeNom))
						tl_MPGroupeRéf:=Find in array:C230(tl_MPGroupeRéf; tl_GroupeRéf{$ii})
						If (tl_MPGroupeRéf>0)
							ta_GroupeNom{$ii}:=ta_MPGroupeNom{tl_MPGroupeRéf}
						Else 
							ta_GroupeNom{$ii}:="??"
						End if 
					End for 
				End if 
				ON ERR CALL:C155("")
			Else 
				GET GROUP LIST:C610(ta_MPGroupeNom; tl_MPGroupeRéf)
				COPY ARRAY:C226(ta_MPGroupeNom; ta_GroupeNom)
				COPY ARRAY:C226(tl_MPGroupeRéf; tl_GroupeRéf)
				ta_GroupeNom:=0
				tl_GroupeRéf:=0
			End if 
		End if 
		vL_Nb_User:=Size of array:C274(ta_UserNom)
		vL_Nb_Groupe:=Size of array:C274(ta_GroupeNom)
	: ($1=4)
		ta_GroupeNom:=$2
		tl_GroupeRéf:=$2
		If (Size of array:C274(ta_MPGroupeNom)>0)
			If ($2>0)
				gError:=0
				ON ERR CALL:C155("i_Error")
				GET GROUP PROPERTIES:C613(tl_GroupeRéf{tl_GroupeRéf}; va_GroupeNom; vl_GroupeRéf; tl_UserRéf)
				ARRAY TEXT:C222(ta_UserNom; Size of array:C274(tl_UserRéf))
				ARRAY INTEGER:C220(te_UserEtat; Size of array:C274(tl_UserRéf))
				For ($ii; 1; Size of array:C274(ta_UserNom))
					tl_MPUserRéf:=Find in array:C230(tl_MPUserRéf; tl_UserRéf{$ii})
					If (tl_MPUserRéf>0)
						ta_UserNom{$ii}:=ta_MPUserNom{tl_MPUserRéf}
					Else 
						ta_UserNom{$ii}:="??"
					End if 
				End for 
				For ($ii; 1; Size of array:C274(ta_UserNom))
					If (Is user deleted:C616(tl_UserRéf{$ii}))
						te_UserEtat{$ii}:=1
					Else 
						te_UserEtat{$ii}:=0
					End if 
				End for 
				ON ERR CALL:C155("")
			Else 
				GET USER LIST:C609(ta_MPUserNom; tl_MPUserRéf)
				COPY ARRAY:C226(ta_MPUserNom; ta_UserNom)
				COPY ARRAY:C226(tl_MPUserRéf; tl_UserRéf)
				ARRAY INTEGER:C220(te_UserEtat; Size of array:C274(ta_UserNom))
				For ($ii; 1; Size of array:C274(ta_UserNom))
					If (Is user deleted:C616(tl_UserRéf{$ii}))
						te_UserEtat{$ii}:=1
					Else 
						te_UserEtat{$ii}:=0
					End if 
				End for 
			End if 
			ta_UserNom:=0
			tl_UserRéf:=0
			te_UserEtat:=0
		End if 
		vL_Nb_User:=Size of array:C274(ta_UserNom)
		vL_Nb_Groupe:=Size of array:C274(ta_GroupeNom)
End case 