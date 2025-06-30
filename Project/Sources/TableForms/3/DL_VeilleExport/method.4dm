C_LONGINT:C283($vl_event)
$vl_event:=Form event code:C388
Case of 
	: ($vl_event=Sur chargement:K2:1)
		If (User in group:C338(Current user:C182; <>Groupe_VeilleExportStat))
			e1:=0
			e2:=0
			e3:=1
			e4:=0
			e5:=0
		Else 
			e1:=1
			e2:=0
			e3:=0
			e4:=0
			e5:=0
			OBJECT SET ENABLED:C1123(e3; False:C215)
		End if 
End case 

//C_BOOLEEN($vb_OK)
//Si (Appartient au groupe(Utilisateur courant;◊Groupe_VeilleExportStat))
//e1:=0
//e2:=0
//e3:=1
//e4:=0
//`e5:=0
//Sinon 
//e1:=1
//e2:=0
//e3:=0
//e4:=0
//e5:=0
//INACTIVER BOUTON(e3)
//$vb_OK:=([DiaLogues]DL_Date>!00/00/00!) & ([DiaLogues]DL_Date2>!00/00/00!) & ([D
//va_VeilleExpStatLib:=("Le sélection ne doit porter que sur une seule jounée !"*N
//Si ($vb_OK=Faux)
//INACTIVER BOUTON(b_ValExpStat)
//va_VeilleExpStatLib:="Le sélection ne doit porter que sur une seule journée !"
//Fin de si 
//CHERCHER([HeberGement];[HeberGement]HG_Date>=[DiaLogues]DL_Date;*)
//CHERCHER([HeberGement]; & [HeberGement]HG_Date<=[DiaLogues]DL_Date2;*)



