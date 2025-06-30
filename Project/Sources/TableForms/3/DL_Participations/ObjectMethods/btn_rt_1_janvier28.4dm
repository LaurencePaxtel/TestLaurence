var $type_t : Text

Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{81}; -><>ta_FMDis4; ->$type_t)
Form:C1466.participation[5].PAR_Ressource_4:=$type_t

Form:C1466.participation[5].PAR_Montant_4:=Num:C11(PAR_Gestion(->$type_t; False:C215))