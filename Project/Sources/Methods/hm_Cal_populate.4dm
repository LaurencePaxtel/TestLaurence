//%attributes = {}
// Method hm_Cal_populate  
// 
// 
// #SYNTAX: $L_Erreur:=hm_Cal_populate(param_1;->param_N) 
// #PARAMETERS:
//     None

// #DATE CREATION: 05/06/2017  #AUTHOR: Bertrand SOUBEYRAND info@soubeyrand-4d-developer.eu
// #DATE MODIFICATION: 00/00/0000
// #NOTE:

// #HEADER VERSION: 2

C_OBJECT:C1216($1; $O_Usagers)
$O_Usagers:=$1
C_OBJECT:C1216($2; $O_Permanenciers)
$O_Permanenciers:=$2
C_OBJECT:C1216($3; $O_Kram)
$O_Kram:=$3

C_POINTER:C301($P_Usagers_cle; $P_Usagers_nom; $P_Usagers_pk; $P_Permanenciers_nom; $P_Permanenciers_pk_invisible; $P_Date_end_export; $P_Date_start_export; $P_pop_filtre_export)
Cal_Get_PTR(->$P_Usagers_cle; ->$P_Usagers_nom; ->$P_Usagers_pk; ->$P_Permanenciers_nom; ->$P_Permanenciers_pk_invisible; ->$P_Date_end_export; ->$P_Date_start_export; ->$P_pop_filtre_export)

ARRAY LONGINT:C221($rL_PK; 0)
ARRAY TEXT:C222($rT_Usagers; 0)
ARRAY TEXT:C222($rT_Cle; 0)
OB GET ARRAY:C1229($O_Usagers; "pk"; $rL_PK)
OB GET ARRAY:C1229($O_Usagers; "nom"; $rT_Usagers)
OB GET ARRAY:C1229($O_Usagers; "cle"; $rT_Cle)

SORT ARRAY:C229($rT_Usagers; $rT_Cle; $rL_PK)
//%W-518.1
COPY ARRAY:C226($rL_PK; $P_Usagers_pk->)
COPY ARRAY:C226($rT_Usagers; $P_Usagers_nom->)
COPY ARRAY:C226($rT_Cle; $P_Usagers_cle->)
//%W+518.1

// visibilité des lignes usagers
C_LONGINT:C283($i; $L_Size)
$L_Size:=Size of array:C274($rT_Usagers)
ARRAY LONGINT:C221(rL_LB_LigneControle; $L_Size)
For ($i; 1; $L_Size)
	rL_LB_LigneControle{$i}:=0  //lk row is hidden
End for 

reu_display_count


// Permanenciers
ARRAY LONGINT:C221($rL_PK; 0)
ARRAY TEXT:C222($rT_Permanenciers; 0)

OB GET ARRAY:C1229($O_Permanenciers; "pk"; $rL_PK)
OB GET ARRAY:C1229($O_Permanenciers; "nom"; $rT_Permanenciers)

SORT ARRAY:C229($rT_Permanenciers; $rL_PK; >)
//%W-518.1
COPY ARRAY:C226($rT_Permanenciers; $P_Permanenciers_nom->)
COPY ARRAY:C226($rL_PK; $P_Permanenciers_pk_invisible->)
//%W+518.1



C_TEXT:C284($T_Current_user)
$T_Current_user:=Current user:C182


// selection du permanencier
C_LONGINT:C283($L_Pos; $L_ID_Current_user)
$L_ID_Current_user:=0
$L_Pos:=Find in array:C230($rT_Permanenciers; $T_Current_user)
If ($L_Pos>-1)
	$L_ID_Current_user:=$rL_PK{$L_Pos}
	$P_Permanenciers_nom->:=$L_Pos
End if 


C_LONGINT:C283($L_DroitAjouter; $L_DroitModifier; $L_DroitElargi)
$L_DroitAjouter:=Num:C11(User in group:C338($T_Current_user; <>Planning_1_Modif_C))
$L_DroitModifier:=Num:C11(User in group:C338($T_Current_user; <>Planning_1_Modif_C))
$L_DroitElargi:=Num:C11(User in group:C338($T_Current_user; <>Planning_1_Elargi_C))

hm_Cal_Droits("set"; ->$L_DroitAjouter; ->$L_DroitModifier; ->$L_DroitElargi)

// gestion de la zone
hm_Handle_zone("init_callback_set")
hm_Handle_zone("init_fontstyle")
hm_Handle_zone("init_commun_mois")
hm_Handle_zone("init_commun_jours")
hm_Handle_zone("init_CurrentTimeIndicator")
hm_Handle_zone("init_options")
hm_Handle_zone("init_users_add")
hm_Handle_zone("init_users_users/page")


hm_Handle_zone("init_style_mini")
hm_Handle_zone("init_nombre_minical")
hm_Handle_zone("init_display_weeknumber")

hm_Handle_zone("do_UpdateZone")


// export
C_LONGINT:C283($L_Filtre)
$L_Filtre:=OB Get:C1224($O_Kram; "filtre"; Est un entier long:K8:6)

$P_Date_start_export->:=OB Get:C1224($O_Kram; "date_start"; Est une date:K8:7)
$P_Date_end_export->:=OB Get:C1224($O_Kram; "date_end"; Est une date:K8:7)

VARIABLE TO VARIABLE:C635(Current process:C322; $P_pop_filtre_export->; $L_Filtre)
SELECT LIST ITEMS BY POSITION:C381($P_pop_filtre_export->; 1)


// EOM

