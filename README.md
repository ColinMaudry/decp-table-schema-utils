# DECP Table Schema

Schéma [Table Schema](https://specs.frictionlessdata.io/table-schema/) pour les Données Essentielles de la Commande Publique et scripts de conversion.

Ce schéma vise à remplacer le [schéma SCDL](https://scdl.opendatafrance.net/docs/schemas/marches-publics.html) développé par OpenDataFrance pour la publication des données de marchés publics en supprimant le support des modifications de marché. L'objectif de ce schéma est donc de publier, pour chaque marché, les données actuelles, et non l'historique, facilitant ainsi l'exploitation des données.

Par exemple, si un marché est initialement attribué pour un montant de 100 000 euros, puis son montant est modifié et est réévalué à 120 000 euros, seule cette dernière valeur est censée apparaître dans les données publiées dans ce format.

Pour le support de l'historique, il faut se tourner vers [les schémas réglementaires JSON et XML](https://www.data.gouv.fr/fr/datasets/referentiel-de-donnees-marches-publics/).

[Valider des données DECP CSV avec Validata](https://go.validata.fr/table-schema?schema_url=https%3A%2F%2Fgithub.com%2FColinMaudry%2Fdecp-table-schema%2Fraw%2Fmain%2Fschema.json)
