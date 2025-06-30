//Script b_ResAct
var $va_ResAct_R : Text
Début_LienTable("Ressources actuelles 2"; ->$va_ResAct_R)
Tab_PopIn2(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{32}; ->$va_ResAct_R; -><>ta_TBResAct2; ->[HeberGement:5]HG_Ressources2:46; ->[HeberGement:5]HG_Ressource2_2:76; vPtrT1_Tri)
