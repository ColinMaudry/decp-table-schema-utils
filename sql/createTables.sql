CREATE TABLE `marches` (
  `uid` tinytext NOT NULL,
  `id` tinytext NOT NULL,
  `acheteur.id` tinytext NOT NULL,
  `nature` tinytext NOT NULL,
  `objet` text NOT NULL,
  `codeCPV` tinytext NOT NULL,
  `procedure` tinytext NOT NULL,
  `lieuExecution.code` tinytext NULL,
  `lieuExecution.typeCode` tinytext NULL,
  `lieuExecution.nom` tinytext NULL,
  `dureeMois` smallint(6) NULL,
  `dateNotification` date NULL,
  `datePublicationDonnees` date NULL,
  `montant` float NOT NULL,
  `formePrix` tinytext NULL,
  `objetModification` text NULL,
  `donneesActuelles` tinyint(1) NOT NULL,
  `anomalies` tinytext NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `decp`. ( `acheteur.id` TINYTEXT NOT NULL , `acheteur.nom` TINYTEXT NOT NULL ) ENGINE = InnoDB;

CREATE TABLE `decp`.`contrats` ( `uid` TINYTEXT NOT NULL , `id` TINYTEXT NOT NULL , `titulaire.id` TINYTEXT NOT NULL , `titulaire.typeIdentifiant` TINYTEXT NOT NULL , `titulaire.denominationSociale` TINYTEXT NOT NULL , `donneesActuelles` BOOLEAN NOT NULL ) ENGINE = InnoDB;
