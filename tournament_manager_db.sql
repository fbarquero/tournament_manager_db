SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tournament_manager_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tournament_manager_db` ;
CREATE SCHEMA IF NOT EXISTS `tournament_manager_db` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `tournament_manager_db` ;

-- -----------------------------------------------------
-- Table `tournament_manager_db`.`belt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tournament_manager_db`.`belt` ;

CREATE TABLE IF NOT EXISTS `tournament_manager_db`.`belt` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `description_UNIQUE` (`description` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tournament_manager_db`.`academy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tournament_manager_db`.`academy` ;

CREATE TABLE IF NOT EXISTS `tournament_manager_db`.`academy` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tournament_manager_db`.`weight_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tournament_manager_db`.`weight_category` ;

CREATE TABLE IF NOT EXISTS `tournament_manager_db`.`weight_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tournament_manager_db`.`age_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tournament_manager_db`.`age_category` ;

CREATE TABLE IF NOT EXISTS `tournament_manager_db`.`age_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tournament_manager_db`.`fighter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tournament_manager_db`.`fighter` ;

CREATE TABLE IF NOT EXISTS `tournament_manager_db`.`fighter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `gender` CHAR NOT NULL,
  `weight` DECIMAL(5,2) NOT NULL,
  `born_date` DATE NOT NULL,
  `elite` BIT NOT NULL,
  `belt_belt_id` INT NOT NULL,
  `academy_academy_id` INT NOT NULL,
  `weight_category_id` INT NOT NULL,
  `age_category_id` INT NOT NULL,
  PRIMARY KEY (`id`, `weight_category_id`, `age_category_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_fighter_belt1_idx` (`belt_belt_id` ASC),
  INDEX `fk_fighter_academy1_idx` (`academy_academy_id` ASC),
  INDEX `fk_fighter_weight_category1_idx` (`weight_category_id` ASC),
  INDEX `fk_fighter_age_category1_idx` (`age_category_id` ASC),
  CONSTRAINT `fk_fighter_belt1`
    FOREIGN KEY (`belt_belt_id`)
    REFERENCES `tournament_manager_db`.`belt` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fighter_academy1`
    FOREIGN KEY (`academy_academy_id`)
    REFERENCES `tournament_manager_db`.`academy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fighter_weight_category1`
    FOREIGN KEY (`weight_category_id`)
    REFERENCES `tournament_manager_db`.`weight_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fighter_age_category1`
    FOREIGN KEY (`age_category_id`)
    REFERENCES `tournament_manager_db`.`age_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tournament_manager_db`.`tournament`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tournament_manager_db`.`tournament` ;

CREATE TABLE IF NOT EXISTS `tournament_manager_db`.`tournament` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tournament_manager_db`.`bracket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tournament_manager_db`.`bracket` ;

CREATE TABLE IF NOT EXISTS `tournament_manager_db`.`bracket` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `json` TEXT NOT NULL,
  `weight` VARCHAR(4) NULL,
  `gender` CHAR NULL,
  `belt` VARCHAR(12) NULL,
  `tournament_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bracket_tournament1_idx` (`tournament_id` ASC),
  CONSTRAINT `fk_bracket_tournament1`
    FOREIGN KEY (`tournament_id`)
    REFERENCES `tournament_manager_db`.`tournament` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tournament_manager_db`.`tournament_fighter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tournament_manager_db`.`tournament_fighter` ;

CREATE TABLE IF NOT EXISTS `tournament_manager_db`.`tournament_fighter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tournament_tournament_id` INT NOT NULL,
  `fighter_fighter_id` INT NOT NULL,
  INDEX `fk_tournament_fighter_tournament_idx` (`tournament_tournament_id` ASC),
  INDEX `fk_tournament_fighter_fighter1_idx` (`fighter_fighter_id` ASC),
  PRIMARY KEY (`id`, `tournament_tournament_id`, `fighter_fighter_id`),
  CONSTRAINT `fk_tournament_fighter_tournament`
    FOREIGN KEY (`tournament_tournament_id`)
    REFERENCES `tournament_manager_db`.`tournament` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tournament_fighter_fighter1`
    FOREIGN KEY (`fighter_fighter_id`)
    REFERENCES `tournament_manager_db`.`fighter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
