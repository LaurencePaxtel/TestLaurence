//Script b_RupMaj
//Script b_RupMaj
var $va_RupMaj_R : Text
Début_LienTable("Ruptures majeures 3"; ->$va_RupMaj_R)
Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{30}; ->$va_RupMaj_R; -><>ta_TBRupMaj3; ->[HeberGement:5]HG_RupMajeur3:42; ->[HeberGement:5]HG_RupMajeur3_2:74; vPtrT1_Tri)
