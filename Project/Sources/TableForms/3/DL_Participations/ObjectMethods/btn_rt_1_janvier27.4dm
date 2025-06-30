var $type_t : Text

Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{80}; -><>ta_FMDis3; ->$type_t)
Form:C1466.participation[5].PAR_Ressource_3:=$type_t

Form:C1466.participation[5].PAR_Montant_3:=Num:C11(PAR_Gestion(->$type_t; False:C215))