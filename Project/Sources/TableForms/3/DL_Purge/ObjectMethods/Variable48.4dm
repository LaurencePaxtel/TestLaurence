
READ ONLY:C145([HeberGement:5])
FORM SET INPUT:C55([HeberGement:5]; "VIDE")
FORM SET OUTPUT:C54([HeberGement:5]; "HG_ListeLien")
SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
ALL RECORDS:C47([HeberGement:5])
MultiSoc_Filter(->[HeberGement:5])

$vl_Fenetre:=i_FenêtreNo(786; 508; 4; "Liste des liens des demandeurs hébergés"; 1; "Quit_Simple")
DISPLAY SELECTION:C59([HeberGement:5]; *)
CLOSE WINDOW:C154($vl_Fenetre)

SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)