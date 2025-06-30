//%attributes = {}
//vl_ii:=vl_ii+1

// Modified by: Kevin HASSAL (06/05/2020)
// Correction du bug de numérotation 

If ([HeberGement:5]HG_Nuit:2)
	[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("N"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
Else 
	[HeberGement:5]HG_FicheNuméro:3:=i_HébérgementNoFiche("J"; [HeberGement:5]HG_Date:4; Uut_Numerote115([HeberGement:5]HG_Date:4))
End if 

//[HeberGement]HG_FicheNuméro:=Substring([HeberGement]HG_FicheNuméro;1;9)+"-"+String(vl_ii;"000000")

//[HeberGement]HG_FicheNuméro:=Substring([HeberGement]HG_FicheNuméro;1;5)+"-"+String(vl_ii;"000000")  //modif 15/09/15 ES