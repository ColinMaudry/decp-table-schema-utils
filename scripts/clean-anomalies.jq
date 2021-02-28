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
                addAnomaly(".id du marché manquant ou null")
            else
            . end
        | if (._type == "Marché" and ((.acheteur.id | not) or ((.acheteur.id | length) <= 8)) ) then
                addAnomaly(".id de l'acheteur manquant, trop court ou null")
            else
            . end
        | if (._type == "Marché" and ((.montant | not) or (.montant < 0))) then
                addAnomaly(".montant manquant ou négatif")
            else
            . end
        | if (._type == "Marché" and ((.titulaires | not) or (.titulaires | length == 0))) then
                addAnomaly(".titulaires manquant ou vide")
            else
            . end
        | if ((.dureeMois | not) or (.dureeMois <= 0)) then
                addAnomaly(".dureeMois manquant ou égal à zéro")
            else
            . end
    ]
}
