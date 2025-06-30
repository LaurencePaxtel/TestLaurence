var $keyLinkFam_t : Text

$keyLinkFam_t:=<>va_T_Site+String:C10(outilsHebergeGenKeyLinkFam(False:C215; False:C215; 0))
SET TEXT TO PASTEBOARD:C523($keyLinkFam_t)

ALERT:C41("Une nouvelle clé de lien de famille vient d'être générer : "+$keyLinkFam_t+", elle a été copiée dans le presse-papier")