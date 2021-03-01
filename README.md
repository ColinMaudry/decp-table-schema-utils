# DECP Table Schema

Schéma [Table Schema](https://specs.frictionlessdata.io/table-schema/) pour les Données Essentielles de la Commande Publique et scripts de conversion.

Ce schéma vise à remplacer le [schéma SCDL](https://scdl.opendatafrance.net/docs/schemas/marches-publics.html) développé par OpenDataFrance pour la publication des données de marchés publics en améliorant le support des modifications de marché. L'objectif de ce schéma est donc de publier, pour chaque marché, à la fois les données actuelles et les données historiques, en mettant en valeur les données actuelles pour faciliter l'exploitation des données.

Par exemple, si un marché est initialement attribué pour un montant de 100 000 euros, puis son montant est modifié et est réévalué à 120 000 euros, seule la dernière version (à 120 000 euros) aura `donneesActuelles` = `1`.

Les [données exemples](https://github.com/ColinMaudry/decp-table-schema/tree/main/exemples) représentent un marché public attribué à deux attributaires. Le marché voit ensuite sa durée modifiée.

[Valider des données DECP Table Schema avec Validata](https://go.validata.fr/table-schema?schema_url=https%3A%2F%2Fgithub.com%2FColinMaudry%2Fdecp-table-schema%2Fraw%2Fmain%2Fschema.json)
