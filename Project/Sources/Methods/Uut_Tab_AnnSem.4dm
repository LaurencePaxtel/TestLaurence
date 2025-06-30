//%attributes = {}
//{==================================================}
//{ LOGICIEL : Samu Social de Paris	
//{ © DB Solutions
//{
//{          Procédure : Uut_Tab_AnnSem  
//{
//{          Dimanche 17 Novembre 1996 à 15:31:55
//{          Modifiée :
//{          Développement : GUEDJ Phulippe
//{==================================================}
C_DATE:C307($1)
ARRAY INTEGER:C220(te_Année; 3)
ARRAY INTEGER:C220(te_Semaine; 52)
For ($i; 1; 3)
	te_Année{1}:=Year of:C25($1)-1
	te_Année{2}:=Year of:C25($1)
	te_Année{3}:=Year of:C25($1)+1
End for 
te_Année:=2
te_Année{0}:=te_Année

For ($i; 1; 52)
	te_Semaine{$i}:=$i
End for 
te_Semaine:=Upg_NumSemaine($1)
te_Semaine{0}:=te_Semaine