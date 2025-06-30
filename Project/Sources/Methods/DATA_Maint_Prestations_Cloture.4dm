//%attributes = {}
// ----------------------------------------------------
// Developer : Kevin HASSAL
// Date and time : 06/03/2020, 15:19:34
// ----------------------------------------------------
// Method: DATA_Maint_Prestations_Cloture
// Description
// 
//
// Parameters
// ----------------------------------------------------

READ WRITE:C146([HeberGement:5])
QUERY:C277([HeberGement:5]; [HeberGement:5]Ref_Structure:169=<>ref_soc_active; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214; *)
QUERY:C277([HeberGement:5];  & ; [HeberGement:5]HG_Cloturée:67=False:C215)

APPLY TO SELECTION:C70([HeberGement:5]; [HeberGement:5]HG_Cloturée:67:=True:C214)

ALERT:C41("Opération effectuée avec succès")

