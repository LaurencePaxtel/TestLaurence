//Script b_ResAct
var $va_ResAct_R : Text
Début_LienTable("Ressources actuelles 3"; ->$va_ResAct_R)
Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{33}; ->$va_ResAct_R; -><>ta_TBResAct3; ->[HeberGement:5]HG_Ressources3:47; ->[HeberGement:5]HG_Ressource3_2:77; vPtrT1_Tri)
