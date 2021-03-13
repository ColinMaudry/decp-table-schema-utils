def addAnomaly(anomaly):
if (.anomalies) then
    .anomalies += [anomaly] else
    . += { "anomalies": [anomaly] }
end
;

{
    "marches": [
        .marches[]

        | if ((.id | not) or (.id | length) == 0) then
                addAnomaly(".id marché manquant ou null")
            else
            . end
        # => 18 marchés au 7 mars

        | if (._type == "Marché" and ((.acheteur.id | not) or ((.acheteur.id | length) <= 8)) ) then
                addAnomaly(".id acheteur manquant, trop court ou null")
            else
            . end
        # => 77 marchés au 7 mars

        | if (._type == "Marché" and ( .acheteur.id as $acheteurId | [.titulaires[]?.id] | index($acheteurId)) ) then
                addAnomaly(".id acheteur et un titulaire identiques")
            else
            . end
        # => 88 marchés au 7 mars

        | if (._type == "Marché" and ((.montant | not) or (.montant < 0))) then
                addAnomaly(".montant manquant ou négatif")
            else
            . end
        # => 0 marchés au 7 mars

        | if (._type == "Marché" and (.codeCPV | not)) then
                addAnomaly(".codeCPV manquant")
            else
            . end
        # => 499 marchés au 7 mars

        | if (._type == "Marché" and ((.titulaires | not) or (.titulaires | length == 0))) then
                addAnomaly(".titulaires manquant ou vide")
            else
            . end
        # => 262 marchés au 7 mars

        | if ((.dureeMois | not) or (.dureeMois <= 0)) then
                addAnomaly(".dureeMois manquant ou égal à zéro")
            else
            . end
        # => 19 marchés au 7 mars

        | if ((.dureeMois) and (.dureeMois > 1200)) then
                addAnomaly(".dureeMois a une valeur supérieure à 100 ans (1200)")
            else
            . end

        # 958 marchés ont une de ces anomalies au 7 mars 2021
    ]
}
