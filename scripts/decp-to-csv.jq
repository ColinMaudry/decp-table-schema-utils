[.marches[] | select(._type == "Marché" and (.titulaires | length) > 0)] | map(
. as $m |
 .titulaires? | map (
    {
        "id": $m.id,
        "uid": $m.uid,
        "acheteur.id": $m.acheteur.id,
        "acheteur.nom": $m.acheteur.nom,
        "nature": $m.nature,
        "objet": $m.objet,
        "codeCPV": $m.codeCPV,
        "procedure": $m.procedure,
        "lieuExecution.code": $m.lieuExecution.code,
        "lieuExecution.typeCode": $m.lieuExecution.typeCode,
        "lieuExecution.nom": $m.lieuExecution.nom,
        "dureeMois": $m.dureeMois,
        "dateNotification": $m.dateNotification,
        "datePublicationDonnees": $m.datePublicationDonnees,
        "montant": $m.montant,
        "formePrix": $m.formePrix,
        "titulaire.id": .id,
        "titulaire.typeIdentifiant": .typeIdentifiant,
        "titulaire.denominationSociale": .denominationSociale
    }
)|
map (
    [to_entries[] | .value]) | .[]
) | .[] | @csv
