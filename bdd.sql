-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema projetBDD
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema projetBDD
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projetBDD` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `projetBDD` ;

-- -----------------------------------------------------
-- Table `projetBDD`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetBDD`.`client` (
  `nom` VARCHAR(45) NOT NULL,
  `prenom` VARCHAR(45) NOT NULL,
  `tel` INT(10) NULL,
  `adresse` VARCHAR(45) NOT NULL,
  `mdp` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nom`, `prenom`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetBDD`.`circuit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetBDD`.`circuit` (
  `idcircuit` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idcircuit`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetBDD`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetBDD`.`reservation` (
  `idreservation` INT NOT NULL AUTO_INCREMENT,
  `circuit_idcircuit` INT NOT NULL,
  `client_nom` VARCHAR(45) NOT NULL,
  `client_prenom` VARCHAR(45) NOT NULL,
  `prix` INT NOT NULL,
  `etat` ENUM('confirme', 'paye') NOT NULL,
  PRIMARY KEY (`idreservation`),
  INDEX `fk_reservation_client1_idx` (`client_nom` ASC, `client_prenom` ASC),
  INDEX `fk_reservation_circuit1_idx` (`circuit_idcircuit` ASC),
  CONSTRAINT `fk_reservation_client1`
    FOREIGN KEY (`client_nom` , `client_prenom`)
    REFERENCES `projetBDD`.`client` (`nom` , `prenom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_circuit1`
    FOREIGN KEY (`circuit_idcircuit`)
    REFERENCES `projetBDD`.`circuit` (`idcircuit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetBDD`.`ville`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetBDD`.`ville` (
  `nom` VARCHAR(45) NOT NULL,
  `pays` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nom`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetBDD`.`deplacement journalier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetBDD`.`deplacement journalier` (
  `circuit_idcircuit` INT NOT NULL,
  `iddj` INT NOT NULL,
  `heuredepart` INT NULL,
  `heure arrivee` INT NULL,
  `villedepart` VARCHAR(45) NOT NULL,
  `villearrivee` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`circuit_idcircuit`, `iddj`),
  INDEX `fk_deplacement journalier_circuit1_idx` (`circuit_idcircuit` ASC),
  INDEX `fk_deplacement journalier_ville1_idx` (`villedepart` ASC),
  INDEX `fk_deplacement journalier_ville2_idx` (`villearrivee` ASC),
  CONSTRAINT `fk_deplacement journalier_circuit1`
    FOREIGN KEY (`circuit_idcircuit`)
    REFERENCES `projetBDD`.`circuit` (`idcircuit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deplacement journalier_ville1`
    FOREIGN KEY (`villedepart`)
    REFERENCES `projetBDD`.`ville` (`nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deplacement journalier_ville2`
    FOREIGN KEY (`villearrivee`)
    REFERENCES `projetBDD`.`ville` (`nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `projetBDD`.`hotel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `projetBDD`.`hotel` (
  `nomhotel` VARCHAR(45) NOT NULL,
  `ville_nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`nomhotel`, `ville_nom`),
  INDEX `fk_hotel_ville1_idx` (`ville_nom` ASC),
  CONSTRAINT `fk_hotel_ville1`
    FOREIGN KEY (`ville_nom`)
    REFERENCES `projetBDD`.`ville` (`nom`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
