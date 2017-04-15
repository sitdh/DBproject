-- MySQL Script generated by MySQL Workbench
-- Sun Apr 16 00:23:11 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`activity` (
  `aid` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `start_date` DATE NULL DEFAULT NULL,
  `duration` SMALLINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`aid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`faculty` (
  `fid` CHAR(2) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `name_th` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `name_en` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  PRIMARY KEY (`fid`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`department` (
  `did` INT(11) NOT NULL AUTO_INCREMENT,
  `name_th` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `name_en` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `fid` CHAR(2) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  PRIMARY KEY (`did`),
  INDEX `FK_department_faculty_idx` (`fid` ASC),
  CONSTRAINT `FK_department_faculty`
    FOREIGN KEY (`fid`)
    REFERENCES `mydb`.`faculty` (`fid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`major`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`major` (
  `mid` INT(11) NOT NULL AUTO_INCREMENT,
  `name_en` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `name_th` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `did` INT(11) NOT NULL,
  `required_lang` INT(3) NOT NULL,
  `required_approve` INT(3) NOT NULL,
  PRIMARY KEY (`mid`),
  INDEX `fk_major_department_idx` (`did` ASC),
  CONSTRAINT `fk_major_department`
    FOREIGN KEY (`did`)
    REFERENCES `mydb`.`department` (`did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `sid` CHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `fname_th` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `fname_en` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `lname_th` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `lname_en` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `initial_name` VARCHAR(20) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `address_en` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `address_th` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `ent_year` SMALLINT(4) NOT NULL,
  `behav_score` SMALLINT(3) NOT NULL,
  `mid` INT(11) NOT NULL,
  PRIMARY KEY (`sid`),
  INDEX `fk_major_idx` (`mid` ASC),
  CONSTRAINT `fk_major`
    FOREIGN KEY (`mid`)
    REFERENCES `mydb`.`major` (`mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`student_activity_awarded`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student_activity_awarded` (
  `sid` CHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `aid` INT(11) NOT NULL,
  `award` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NULL DEFAULT NULL,
  PRIMARY KEY (`sid`, `aid`),
  INDEX `fk_student_activity_awarded_activity_idx` (`aid` ASC),
  CONSTRAINT `fk_student_activity_awarded_activity`
    FOREIGN KEY (`aid`)
    REFERENCES `mydb`.`activity` (`aid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_activity_awarded_student`
    FOREIGN KEY (`sid`)
    REFERENCES `mydb`.`student` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`student_activity_join`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student_activity_join` (
  `sid` CHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  `aid` INT(11) NOT NULL,
  PRIMARY KEY (`sid`, `aid`),
  INDEX `fk_student_activity_activity_idx` (`aid` ASC),
  CONSTRAINT `fk_student_activity_join_activity`
    FOREIGN KEY (`aid`)
    REFERENCES `mydb`.`activity` (`aid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_student_activity_join_student`
    FOREIGN KEY (`sid`)
    REFERENCES `mydb`.`student` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`absent_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`absent_record` (
  `arid` INT NOT NULL AUTO_INCREMENT,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` TEXT(1000) NULL,
  PRIMARY KEY (`arid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`absent_record_has_student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`absent_record_has_student` (
  `absent_record_arid` INT NOT NULL,
  `student_sid` CHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  PRIMARY KEY (`absent_record_arid`, `student_sid`),
  INDEX `fk_absent_record_has_student_student1_idx` (`student_sid` ASC),
  INDEX `fk_absent_record_has_student_absent_record1_idx` (`absent_record_arid` ASC),
  CONSTRAINT `fk_absent_record_has_student_absent_record1`
    FOREIGN KEY (`absent_record_arid`)
    REFERENCES `mydb`.`absent_record` (`arid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_absent_record_has_student_student1`
    FOREIGN KEY (`student_sid`)
    REFERENCES `mydb`.`student` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`course` (
  `course_no` CHAR(7) NOT NULL,
  `name_en` VARCHAR(100) NOT NULL,
  `name_th` VARCHAR(100) NOT NULL,
  `shortname` VARCHAR(50) NULL,
  `credit` SMALLINT(2) NULL,
  `subcredit_1` SMALLINT(2) NULL,
  `subcredit_2` SMALLINT(2) NULL,
  `subcredit_3` SMALLINT(2) NULL,
  `special_type` ENUM('1', '2', '3', '4', '5') NULL,
  `did` INT NOT NULL,
  PRIMARY KEY (`course_no`),
  INDEX `fk_course_department_idx` (`did` ASC),
  CONSTRAINT `fk_course_department`
    FOREIGN KEY (`did`)
    REFERENCES `mydb`.`department` (`did`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course_prerequisite`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`course_prerequisite` (
  `course_no` CHAR(7) NOT NULL,
  `pre_course_no` CHAR(7) NOT NULL,
  PRIMARY KEY (`pre_course_no`, `course_no`),
  INDEX `fk_course_has_course_course2_idx` (`pre_course_no` ASC),
  INDEX `fk_course_has_course_course1_idx` (`course_no` ASC),
  CONSTRAINT `fk_course_has_course_course1`
    FOREIGN KEY (`course_no`)
    REFERENCES `mydb`.`course` (`course_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_has_course_course2`
    FOREIGN KEY (`pre_course_no`)
    REFERENCES `mydb`.`course` (`course_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`major_course_required`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`major_course_required` (
  `mid` INT NOT NULL,
  `course_no` CHAR(7) NOT NULL,
  PRIMARY KEY (`mid`, `course_no`),
  INDEX `fk_major_has_course_course1_idx` (`course_no` ASC),
  INDEX `fk_major_has_course_major1_idx` (`mid` ASC),
  CONSTRAINT `fk_major_has_course_major1`
    FOREIGN KEY (`mid`)
    REFERENCES `mydb`.`major` (`mid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_major_has_course_course1`
    FOREIGN KEY (`course_no`)
    REFERENCES `mydb`.`course` (`course_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_unicode_ci;


-- -----------------------------------------------------
-- Table `mydb`.`student_semester_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student_semester_info` (
  `sid` CHAR(10) NOT NULL,
  `semester` TINYINT(1) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`sid`, `semester`, `year`),
  CONSTRAINT `fk_student_semester_info_student1`
    FOREIGN KEY (`sid`)
    REFERENCES `mydb`.`student` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`enrollment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`enrollment` (
  `eid` INT NOT NULL AUTO_INCREMENT,
  `created_time` DATETIME NULL,
  `grade` VARCHAR(2) NULL,
  `edited_time` DATETIME NULL,
  `course_no` CHAR(7) NOT NULL,
  `student_semester_info_sid` CHAR(10) NOT NULL,
  `student_semester_info_semester` TINYINT(1) NOT NULL,
  `student_semester_info_year` YEAR NOT NULL,
  PRIMARY KEY (`eid`),
  INDEX `fk_enrollment_course1_idx` (`course_no` ASC),
  INDEX `fk_enrollment_student_semester_info1_idx` (`student_semester_info_sid` ASC, `student_semester_info_semester` ASC, `student_semester_info_year` ASC),
  CONSTRAINT `fk_enrollment_course1`
    FOREIGN KEY (`course_no`)
    REFERENCES `mydb`.`course` (`course_no`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrollment_student_semester_info1`
    FOREIGN KEY (`student_semester_info_sid` , `student_semester_info_semester` , `student_semester_info_year`)
    REFERENCES `mydb`.`student_semester_info` (`sid` , `semester` , `year`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` VARCHAR(30) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `display_name` VARCHAR(200) NOT NULL,
  `type` ENUM('A', 'M') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_student_advice`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_student_advice` (
  `user_id` VARCHAR(30) NOT NULL,
  `student_sid` CHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_unicode_ci' NOT NULL,
  PRIMARY KEY (`user_id`, `student_sid`),
  INDEX `fk_user_has_student_student1_idx` (`student_sid` ASC),
  INDEX `fk_user_has_student_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_student_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_student_student1`
    FOREIGN KEY (`student_sid`)
    REFERENCES `mydb`.`student` (`sid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;