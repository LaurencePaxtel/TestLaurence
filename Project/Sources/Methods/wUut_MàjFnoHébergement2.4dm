//%attributes = {}
vl_ii:=vl_ii+1

[HeberGement:5]HG_FicheNuméro:3:=Substring:C12([HeberGement:5]HG_FicheNuméro:3; 1; 9)+"x"+String:C10(vl_ii; "000000")

//[HeberGement]HG_FicheNuméro:=Substring([HeberGement]HG_FicheNuméro;1;5)+"x"+String(vl_ii;"000000")  //modif 15/09/15 ES