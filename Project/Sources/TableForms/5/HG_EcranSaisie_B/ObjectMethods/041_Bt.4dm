//Script b_RupMaj
var $va_RupMaj_R : Text
Début_LienTable("Ruptures majeures 2"; ->$va_RupMaj_R)
Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{29}; ->$va_RupMaj_R; -><>ta_TBRupMaj2; ->[HeberGement:5]HG_RupMajeur2:41; ->[HeberGement:5]HG_RupMajeur2_2:73; vPtrT1_Tri)
