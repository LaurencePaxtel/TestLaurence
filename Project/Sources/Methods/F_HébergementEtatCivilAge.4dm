//%attributes = {}
C_BOOLEAN:C305($0)
C_DATE:C307($1)
C_DATE:C307($2)

vd_HébergéAge:=$1
vd_HébergéDateDuJour:=$2
ve_HébergéAge:=Uut_HébergéAgePlus(->vd_HébergéAge; ->vd_HébergéDateDuJour)

$0:=True:C214