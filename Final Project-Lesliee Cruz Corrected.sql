-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ibalance
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ibalance` ;

-- -----------------------------------------------------
-- Schema ibalance
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ibalance` DEFAULT CHARACTER SET utf8 ;
USE `ibalance` ;

-- -----------------------------------------------------
-- Table `ibalance`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`category` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`category` (
  `category_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ibalance`.`day`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`day` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`day` (
  `day_id` INT NOT NULL,
  `day_of_the_week` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`day_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ibalance`.`step`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`step` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`step` (
  `step_id` INT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`step_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ibalance`.`status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`status` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`status` (
  `status_id` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`status_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ibalance`.`task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`task` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`task` (
  `task_id` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `category_id` INT NOT NULL,
  `step_id` INT NOT NULL,
  `status_id` INT NOT NULL,
  PRIMARY KEY (`task_id`),
  INDEX `fk_task_category1_idx` (`category_id` ASC) VISIBLE,
  INDEX `fk_task_step1_idx` (`step_id` ASC) VISIBLE,
  INDEX `fk_task_status1_idx` (`status_id` ASC) VISIBLE,
  CONSTRAINT `fk_task_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `ibalance`.`category` (`category_id`),
  CONSTRAINT `fk_task_step1`
    FOREIGN KEY (`step_id`)
    REFERENCES `ibalance`.`step` (`step_id`),
  CONSTRAINT `fk_task_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `ibalance`.`status` (`status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ibalance`.`day_has_task`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`day_has_task` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`day_has_task` (
  `day_id` INT NOT NULL,
  `task_id` INT NOT NULL,
  PRIMARY KEY (`day_id`, `task_id`),
  INDEX `fk_day_has_task_task1_idx` (`task_id` ASC) VISIBLE,
  INDEX `fk_day_has_task_day1_idx` (`day_id` ASC) VISIBLE,
  CONSTRAINT `fk_day_has_task_day1`
    FOREIGN KEY (`day_id`)
    REFERENCES `ibalance`.`day` (`day_id`),
  CONSTRAINT `fk_day_has_task_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `ibalance`.`task` (`task_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ibalance`.`todolist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`todolist` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`todolist` (
  `todolist_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`todolist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ibalance`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`user` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`user` (
  `user_id` INT NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ibalance`.`user_has_todolist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`user_has_todolist` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`user_has_todolist` (
  `user_id` INT NOT NULL,
  `todolist_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `todolist_id`),
  INDEX `fk_user_has_todolist_todolist1_idx` (`todolist_id` ASC) VISIBLE,
  INDEX `fk_user_has_todolist_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_todolist_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ibalance`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_todolist_todolist1`
    FOREIGN KEY (`todolist_id`)
    REFERENCES `ibalance`.`todolist` (`todolist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ibalance`.`category_has_todolist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibalance`.`category_has_todolist` ;

CREATE TABLE IF NOT EXISTS `ibalance`.`category_has_todolist` (
  `category_id` INT NOT NULL,
  `todolist_id` INT NOT NULL,
  PRIMARY KEY (`category_id`, `todolist_id`),
  INDEX `fk_category_has_todolist_todolist1_idx` (`todolist_id` ASC) VISIBLE,
  INDEX `fk_category_has_todolist_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_category_has_todolist_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `ibalance`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_category_has_todolist_todolist1`
    FOREIGN KEY (`todolist_id`)
    REFERENCES `ibalance`.`todolist` (`todolist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO user (user_id, username, email, first_name, last_name)
VALUES 
(1, 'Lessleya', 'lesliee.icc@gmail.com', 'Lesliee', 'Cruz'),
(2, 'Tony', 'icc@gmail.com', 'Tony', 'Cruz'),
(3, 'Chato', 'lieeic@gmail.com', 'Chato', 'Cruz');

INSERT INTO todolist(todolist_id, name)
VALUES 
(1, 'Morning'),
(2, 'Afternoon'),
(3, 'Night'),
(4, 'Completed'),
(5, 'Doing');

INSERT INTO user_has_todolist (user_id, todolist_id)
VALUES 
(1, '1'),
(1, '2'),
(1, '3'),
(1, '4'),
(1, '5'),
(2, '1'),
(2, '2'),
(2, '3'),
(2, '4'),
(2, '5'),
(3, '1'),
(3, '2'),
(3, '3'),
(3, '4'),
(3, '5');

INSERT INTO  category(category_id, title)
VALUES 
(1, 'Spiritual'),
(2, 'Intellectual'),
(3, 'Physical'),
(4, 'Social');

INSERT INTO category_has_todolist (category_id, todolist_id)
VALUES 
(1, '1'),
(1, '2'),
(1, '3'),
(1, '4'),
(2, '1'),
(2, '2'),
(2, '3'),
(2, '4'),
(3, '1'),
(3, '2'),
(3, '3'),
(3, '4');

INSERT INTO step(step_id, title)
VALUES 
(1, 'Read 15 min the book of mormon'),
(2, 'Work out 30 min '),
(3, 'Hang out with sara '),
(4, 'do CIT 225 homework ');


INSERT INTO  status(status_id, status)
VALUES 
(1, 'Completed'),
(2, 'In Progress'),
(3, 'Done');

INSERT INTO task(task_id, Title, Description, category_id, step_id, status_id)
VALUES 
(1, 'Be more spiritual', 'This will help me to be closer to God', 1, 1, 2),
(2, 'Finish Homework', 'I want to get good grades', 2, 2, 3),
(3, 'Make more friends', ' I need to make more freinds', 4, 3, 3),
(4, 'Get on shape', 'I can do it', 3, 4, 1);


INSERT INTO  day(day_id, day_of_the_week)
VALUES 
(1, 'Monday'),
(2, 'Tuesday'),
(3, 'Wednesday'),
(4, 'Thursday'),
(5, 'Friday'),
(6, 'Saturday'),
(7, 'Sunday');

INSERT day_has_task(day_id, task_id)
VALUES 
(1, '1'),
(1, '2'),
(2, '3'),
(3, '3'),
(4, '4'),
(4, '1'),
(5, '2'),
(5, '3'),
(6, '2'),
(7, '1');

SELECT *
from task












