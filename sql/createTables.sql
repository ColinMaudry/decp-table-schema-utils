SET time_zone = "+02:00";

CREATE DATABASE IF NOT EXISTS `decp` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `decp`;


CREATE TABLE `decp`.`acheteurs` ( `acheteur.id` TINYTEXT NOT NULL , `acheteur.nom` TINYTEXT NOT NULL ) ENGINE = InnoDB;

CREATE TABLE `decp`.`titulaires` ( `titulaire.id` TINYTEXT NOT NULL , `titulaire.denominationSociale` TINYTEXT NOT NULL, `titulaire.typeIdentifiant` TINYTEXT NOT NULL ) ENGINE = InnoDB;


CREATE TABLE `decp`.`contrats` ( `uid` TINYTEXT NOT NULL , `titulaire.id` TINYTEXT NOT NULL, `donneesActuelles` BOOLEAN NOT NULL ) ENGINE = InnoDB;


CREATE TABLE `decp`.`marches` (
  `uid` tinytext NOT NULL,
  `id` tinytext NULL,
  `acheteur.id` tinytext NULL,
  `nature` tinytext NULL,
  `objet` text NULL,
  `codeCPV` tinytext NULL,
  `procedure` tinytext NULL,
  `lieuExecution.code` tinytext NULL,
  `lieuExecution.typeCode` tinytext NULL,
  `lieuExecution.nom` tinytext NULL,
  `dureeMois` mediumint(6) NULL,
  `dateNotification` date NULL,
  `datePublicationDonnees` date NULL,
  `montant` float NULL,
  `formePrix` tinytext NULL,
  `objetModification` text NULL,
  `donneesActuelles` BOOLEAN NOT NULL,
  `anomalies` tinytext NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
