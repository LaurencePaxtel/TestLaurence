//%attributes = {}
C_BOOLEAN:C305($vb_OK)  //15/2/2010
$vb_OK:=[HeberGement:5]HG_FamChef:103  //15/2/2010
$vb_OK:=True:C214  //15/2/2010

//CHOIX SAISISSABLE([HéberGement]HG_FamCompo;$vb_OK)
OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamNbPers:106; $vb_OK)
OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamNbJour:107; $vb_OK)
OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamNbChambre:108; $vb_OK)
OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamPrixJour:109; $vb_OK)
OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamTotal:110; $vb_OK)
OBJECT SET ENTERABLE:C238([HeberGement:5]HG_FamNoDeBon:136; $vb_OK)

OBJECT SET ENTERABLE:C238(ve_FamH; $vb_OK)
OBJECT SET ENTERABLE:C238(ve_FamF; $vb_OK)
OBJECT SET ENTERABLE:C238(ve_FamFe; $vb_OK)
OBJECT SET ENTERABLE:C238(ve_FamEMi; $vb_OK)
OBJECT SET ENTERABLE:C238(ve_FamEMa; $vb_OK)
OBJECT SET ENTERABLE:C238(ve_FamPMi; $vb_OK)
OBJECT SET ENTERABLE:C238(ve_FamPMa; $vb_OK)
If ($vb_OK=False:C215)
	ve_FamH:=0
	ve_FamF:=0
	ve_FamFe:=0
	ve_FamEMi:=0
	ve_FamEMa:=0
	ve_FamPMi:=0
	ve_FamPMa:=0
End if 