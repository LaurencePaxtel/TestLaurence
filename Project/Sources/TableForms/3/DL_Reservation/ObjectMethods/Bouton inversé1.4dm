var $centre_t : Text

ARRAY TEXT:C222($centre_at; 0)

F_HebergementCible(2; <>vb_T_ModeCHRS; "H"; False:C215; "@"; 0)

ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Niveau:52; >; *)
ORDER BY:C49([LesCentres:9]; [LesCentres:9]LC_Nom:4; >)
SELECTION TO ARRAY:C260([LesCentres:9]LC_Nom:4; $centre_at)

Tab_PopIn1(<>ta_RdsNomNew{<>vlSTR_Std-<>vlSTR}{51}; ->$centre_at; ->$centre_t)
Form:C1466.centre:=$centre_t