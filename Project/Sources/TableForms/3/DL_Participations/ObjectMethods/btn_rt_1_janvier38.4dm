var $taux_t : Text

Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{82}; -><>ta_FMDis5; ->$taux_t)
PAR_Calcul(->$taux_t; 8)

Form:C1466.participation[7].PAR_Taux:=Num:C11($taux_t)