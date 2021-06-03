Notes de version
## [1.3.0](https://github.com/ColinMaudry/decp-table-schema-utils/compare/v1.2.0...v1.3.0) (2021-06-03)


### Features

* ne garder que les inscrits au SIRENE dans decp-titulaires ([f8c8bf4](https://github.com/ColinMaudry/decp-table-schema-utils/commit/f8c8bf4de76f5a11e89276f1e66db38912f8dcfe))
* remplacement de wget par curl ([541a4a1](https://github.com/ColinMaudry/decp-table-schema-utils/commit/541a4a16fb3a9ea2e5db203ce15fbbed8ec9981e))
* stop en cas d'erreur ([7181f2d](https://github.com/ColinMaudry/decp-table-schema-utils/commit/7181f2d54a7dab47df758d7f4dc741b323171d1b))
* stopper la génération de decp-titulaires en cas d'erreur ([7292fb1](https://github.com/ColinMaudry/decp-table-schema-utils/commit/7292fb1ad478f60e1c17148c8db1d44308493021))

## 1.1.0 (2021-05-23)

### Nouvelles fonctionnalités

* activation du debug, désactivation des facettes personnalisées ([2deb49a](https://github.com/ColinMaudry/decp-table-schema-utils/commit/2deb49aa00c64347f34a65ccb15282f8f5e42cd8))
* ajout d'icônes à côté des liens + adresse email de contact [#35](https://github.com/ColinMaudry/decp-table-schema-utils/issues/35) ([07b91a9](https://github.com/ColinMaudry/decp-table-schema-utils/commit/07b91a9ed945268369e4421a2212abeab4a109f7))
* ajout d'une page d'inscription et des mentions légales ([e7356cf](https://github.com/ColinMaudry/decp-table-schema-utils/commit/e7356cfe675b63d2235e63fe151ac082269fc4f0))
* ajout d'une table sans les titulaires closed [#38](https://github.com/ColinMaudry/decp-table-schema-utils/issues/38) ([3c7daff](https://github.com/ColinMaudry/decp-table-schema-utils/commit/3c7daffc3a7cd05daca3bfcfaf3ea4dbb1f33499))
* ajout de decp-sans-titulaires au script de publication ([f0d6294](https://github.com/ColinMaudry/decp-table-schema-utils/commit/f0d6294f763361553a6583da0007061d7e4c6930))
* ajout des données précédentes et concaténation (failing) ([cb006a1](https://github.com/ColinMaudry/decp-table-schema-utils/commit/cb006a161ea2cd96bd5d78f058af582f4a88b8d2))
* augmenter la taille du lien 'Explorer les données' ([b5bd13a](https://github.com/ColinMaudry/decp-table-schema-utils/commit/b5bd13abd853f073e596d063cbbded4654efd497))
* conversion des métadonnées datasette en yaml ([5312755](https://github.com/ColinMaudry/decp-table-schema-utils/commit/53127550124591de024a1c0a55ebbcfdda05c302))
* correction des formats de date ([959a807](https://github.com/ColinMaudry/decp-table-schema-utils/commit/959a807ef0bba0608d3664093404f448e4b0c309))
* correction et optimisation du script de génération du fichier titulaires ([043b194](https://github.com/ColinMaudry/decp-table-schema-utils/commit/043b1945ddb4d1cdf5560a387e5e69e43d714c82))
* détails des tables et documentation sur la page database ([9afc913](https://github.com/ColinMaudry/decp-table-schema-utils/commit/9afc913cde77c188bb62008b6568f4d2522d460a))
* enrichissement du fichier ds titulaires (cj) ([4e23423](https://github.com/ColinMaudry/decp-table-schema-utils/commit/4e2342325383fb70ff2d7ff665a5df8e2149959b))
* formulaire d'inscription à la lettre d'info ([6eb3a33](https://github.com/ColinMaudry/decp-table-schema-utils/commit/6eb3a337ab6b3f805bc908ba3d157ac855aef537))
* les code NAF sont cliquables et renvoient vers insee.fr ([82b3934](https://github.com/ColinMaudry/decp-table-schema-utils/commit/82b3934c0a505cdc5eb2296dbc366ee31ce7076e))
* masquer les colonnes longitude et latitude ([6ca0885](https://github.com/ColinMaudry/decp-table-schema-utils/commit/6ca0885d3f138d7dc1bab32f6cc7095e90e175c4))
* script de création de decp-titulaires ([a20e542](https://github.com/ColinMaudry/decp-table-schema-utils/commit/a20e542857ff374ebc4eb496a2faeb9b57b5336d))
* suppression des métadonnées json de datasette ([aeaf8ae](https://github.com/ColinMaudry/decp-table-schema-utils/commit/aeaf8ae62f62ba01f9d4e31dee76ceb7683dcfb2))
* téléchargement des données titulaires ([f3cc0b1](https://github.com/ColinMaudry/decp-table-schema-utils/commit/f3cc0b1ee10af7e0f489e5712ad7e0dfe156334b))

### Correctifs

* lien vers les mentions légales ([316f723](https://github.com/ColinMaudry/decp-table-schema-utils/commit/316f72315bee86056e496f3e48a09d23c5a06a32))
* liens de la page d'accueil, logs ([172bd34](https://github.com/ColinMaudry/decp-table-schema-utils/commit/172bd34776cef29e12f5e0e8fa9981b7516f25fc))
* **decp-titulaires:** correction dans les fusions de données et dans les listes de champs ([d4ee2f5](https://github.com/ColinMaudry/decp-table-schema-utils/commit/d4ee2f50b45f4b9cf8d9fea17b9cc40eacc15adc))
* cast les strings comme strings ([14c9e2b](https://github.com/ColinMaudry/decp-table-schema-utils/commit/14c9e2b34132ff51c781aa846ad4dadf91c35811))
* métadonnées plus succintes, traduction de 'powered by' ([2b31354](https://github.com/ColinMaudry/decp-table-schema-utils/commit/2b31354884c27cc4bbff462beaed256f2a4639e1))
* suppression de la colonne 'siret' de decp-titulaires ([7eed3e3](https://github.com/ColinMaudry/decp-table-schema-utils/commit/7eed3e314706f797f459042ad0ee9b37eb5eaba5))
