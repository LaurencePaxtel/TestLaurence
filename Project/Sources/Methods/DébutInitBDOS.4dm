//%attributes = {}
C_LONGINT:C283(<>vl_Migrer_Fichier)
<>vl_Migrer_Fichier:=48

ARRAY TEXT:C222(<>tt_Migrer_Fichier; <>vl_Migrer_Fichier)
ARRAY POINTER:C280(<>tp_Migrer_Table; <>vl_Migrer_Fichier)

<>tt_Migrer_Fichier{1}:="01DEPART"
<>tp_Migrer_Table{1}:=->[DePart:1]

<>tt_Migrer_Fichier{2}:="02SOCIETE"
<>tp_Migrer_Table{2}:=->[SOciete:18]

<>tt_Migrer_Fichier{3}:="03REFUNIQUE"
<>tp_Migrer_Table{3}:=->[ReferenceUnique:2]

<>tt_Migrer_Fichier{4}:="04ENUM"
<>tp_Migrer_Table{4}:=->[TypesTables:11]

<>tt_Migrer_Fichier{5}:="05ENUMVALEUR"
<>tp_Migrer_Table{5}:=->[TAbles:12]

<>tt_Migrer_Fichier{6}:="06CHAMPECRAN"
<>tp_Migrer_Table{6}:=->[LesRubriques:21]

<>tt_Migrer_Fichier{7}:="07UserProfils"
<>tp_Migrer_Table{7}:=->[IntervenantsProfils:31]

<>tt_Migrer_Fichier{8}:="08UserGroupes"
<>tp_Migrer_Table{8}:=->[IntervenantsGroupes:32]

<>tt_Migrer_Fichier{9}:="09UserPERSONNES"
<>tp_Migrer_Table{9}:=->[INtervenants:10]

<>tt_Migrer_Fichier{10}:="10GIP"
<>tp_Migrer_Table{10}:=->[GIP:13]

<>tt_Migrer_Fichier{11}:="11ASSOCIATIONS"
<>tp_Migrer_Table{11}:=->[Assocs:14]

<>tt_Migrer_Fichier{12}:="12APPELS"
<>tp_Migrer_Table{12}:=->[APpels:19]

<>tt_Migrer_Fichier{13}:="13MEMO"
<>tp_Migrer_Table{13}:=->[MemO:30]

<>tt_Migrer_Fichier{14}:="14MESSAGERIE"
<>tp_Migrer_Table{14}:=->[Messagerie:34]

<>tt_Migrer_Fichier{15}:="15RAPPORT"
<>tp_Migrer_Table{15}:=->[Rapport:35]

<>tt_Migrer_Fichier{16}:="16CENTRES"
<>tp_Migrer_Table{16}:=->[LesCentres:9]

<>tt_Migrer_Fichier{17}:="17CENTRESDISPO"
<>tp_Migrer_Table{17}:=->[CentresLits:16]

<>tt_Migrer_Fichier{18}:="18TRANCHES"
<>tp_Migrer_Table{18}:=->[LesTranches:47]

<>tt_Migrer_Fichier{19}:="19TRANCHESAGE"
<>tp_Migrer_Table{19}:=->[TrancheAge:40]

<>tt_Migrer_Fichier{20}:="20PRESANTATION"
<>tp_Migrer_Table{20}:=->[PreSentation:44]

<>tt_Migrer_Fichier{21}:="21PRESANTDATA"
<>tp_Migrer_Table{21}:=->[PresentationData:45]

<>tt_Migrer_Fichier{22}:="22ITEMGPE"
<>tp_Migrer_Table{22}:=->[ItemGroupe:43]

<>tt_Migrer_Fichier{23}:="23SHOW"
<>tp_Migrer_Table{23}:=->[ShowAutreS:46]

<>tt_Migrer_Fichier{24}:="24SOMME"
<>tp_Migrer_Table{24}:=->[Sommes:48]

<>tt_Migrer_Fichier{25}:="25TABLEFUSE"
<>tp_Migrer_Table{25}:=->[TableFusions:42]

<>tt_Migrer_Fichier{26}:="26PERSONNECLE"
<>tp_Migrer_Table{26}:=->[HeBerge:4]

<>tt_Migrer_Fichier{27}:="27PERSONNEGROUPE"
<>tp_Migrer_Table{27}:=->[GrouPe:36]

<>tt_Migrer_Fichier{28}:="28PERSONNEGROUPELIEN"
<>tp_Migrer_Table{28}:=->[GroupeHeberges:37]

<>tt_Migrer_Fichier{29}:="29GROUPEPROLONGATION"
<>tp_Migrer_Table{29}:=->[Prolongation:38]

<>tt_Migrer_Fichier{30}:="30PERSSERVI"
<>tp_Migrer_Table{30}:=->[HeBerge_Servi:41]

<>tt_Migrer_Fichier{31}:="31HEBERGEMENT"
<>tp_Migrer_Table{31}:=->[HeberGement:5]

<>tt_Migrer_Fichier{32}:="32HEBERGEMENTLIE"
<>tp_Migrer_Table{32}:=->[HebergementLie:15]

<>tt_Migrer_Fichier{33}:="33MARAUDE"
<>tp_Migrer_Table{33}:=->[Maraude:24]

<>tt_Migrer_Fichier{34}:="34OBJET"
<>tp_Migrer_Table{34}:=->[Objets:56]

<>tt_Migrer_Fichier{35}:="35OBJETPLAN"
<>tp_Migrer_Table{35}:=->[Objets_Planification:57]

<>tt_Migrer_Fichier{36}:="36DosSocial"
<>tp_Migrer_Table{36}:=->[DossierSocial:25]

<>tt_Migrer_Fichier{37}:="37DosMedical"
<>tp_Migrer_Table{37}:=->[DossierMedical:29]

<>tt_Migrer_Fichier{38}:="38DosInfirmier"
<>tp_Migrer_Table{38}:=->[DossierInfirmie:27]

<>tt_Migrer_Fichier{39}:="39DosPsycho"
<>tp_Migrer_Table{39}:=->[DossierPsycho:28]

<>tt_Migrer_Fichier{40}:="40DosSante"
<>tp_Migrer_Table{40}:=->[DossierSante:33]

<>tt_Migrer_Fichier{41}:="41ActionSocial"
<>tp_Migrer_Table{41}:=->[ActionSociale:26]

<>tt_Migrer_Fichier{42}:="42SIAOACCUEIL"
<>tp_Migrer_Table{42}:=->[SIAO_SiteReference:54]

<>tt_Migrer_Fichier{43}:="43SIAOREFERENT"
<>tp_Migrer_Table{43}:=->[SIAO_SiteReference:54]

<>tt_Migrer_Fichier{44}:="44SIAOADOSSIER"
<>tp_Migrer_Table{44}:=->[SIAO:50]

<>tt_Migrer_Fichier{45}:="45SIAOPERSONNE"
<>tp_Migrer_Table{45}:=->[SIAO_Personnes:51]

<>tt_Migrer_Fichier{46}:="46SIAOSITUATIONS"
<>tp_Migrer_Table{46}:=->[SIAO_Situations:52]




<>tt_Migrer_Fichier{47}:="47SIAODIVERS"
<>tp_Migrer_Table{47}:=->[SIAO_Divers:58]

<>tt_Migrer_Fichier{48}:="48SIAOADRESSES"
<>tp_Migrer_Table{48}:=->[Adresses:53]