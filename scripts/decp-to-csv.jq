.marches | map(
{
    id,
    uid,
    "acheteur.id": .acheteur.id,
    "acheteur.nom": .acheteur.nom,
    nature,
    objet,
    codeCPV,
    procedure,
    "lieuExecution.code": .lieuExecution.code,
    "lieuExecution.typeCode": .lieuExecution.typeCode,
    "lieuExecution.nom": .lieuExecution.nom,
    dureeMois,
    dateNotification,
    datePublicationDonnees,
    montant,
    formePrix
    }
) | (first | keys_unsorted) as $keys | map([to_entries[] | .value]) as $rows | $keys,$rows[] | @csv
