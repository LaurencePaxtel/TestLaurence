outilsHebergeLoadRecord
Rec_Hébergements1

QUERY SELECTION:C341([HeberGement:5];  & ; [HeberGement:5]HG_Nuit:2=True:C214)

ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_Date:4; <; *)
ORDER BY:C49([HeberGement:5]; [HeberGement:5]HG_HeureAppel:5; <)

OBJECT Get pointer:C1124(Objet nommé:K67:5; "Bouton radio")->:=0
OBJECT Get pointer:C1124(Objet nommé:K67:5; "Bouton radio2")->:=0
Form:C1466.changeTypeHebergement:=True:C214