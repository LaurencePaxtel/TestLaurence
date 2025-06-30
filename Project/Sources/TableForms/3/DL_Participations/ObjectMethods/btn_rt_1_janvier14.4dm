var $type_t : Text

Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{78}; -><>ta_FMDis1; ->$type_t)
Form:C1466.participation[2].PAR_Ressource_5:=$type_t

Form:C1466.participation[2].PAR_Montant_5:=Num:C11(PAR_Gestion(->$type_t; False:C215))