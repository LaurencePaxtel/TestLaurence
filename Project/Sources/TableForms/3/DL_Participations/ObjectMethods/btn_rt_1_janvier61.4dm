var $type_t : Text

Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{79}; -><>ta_FMDis2; ->$type_t)
Form:C1466.participation[10].PAR_Ressource_2:=$type_t

Form:C1466.participation[10].PAR_Montant_2:=Num:C11(PAR_Gestion(->$type_t; False:C215))