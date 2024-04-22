-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema movie_production_companies
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema movie_production_companies
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `movie_production_companies` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `movie_production_companies` ;

-- -----------------------------------------------------
-- Table `movie_production_companies`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`country` (
  `code` CHAR(2) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `isd_code` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `name_UNIQUE` ON `movie_production_companies`.`country` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`city` (
  `id` INT NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `country_code` CHAR(2) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `country_code_fk`
    FOREIGN KEY (`country_code`)
    REFERENCES `movie_production_companies`.`country` (`code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `city_country_idx` ON `movie_production_companies`.`city` (`country_code` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`kind_of_organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`kind_of_organization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `name_UNIQUE` ON `movie_production_companies`.`kind_of_organization` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`registration_body`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`registration_body` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `country_code` CHAR(2) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `reg_country_fk`
    FOREIGN KEY (`country_code`)
    REFERENCES `movie_production_companies`.`country` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 12
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `name_UNIQUE` ON `movie_production_companies`.`registration_body` (`name` ASC) VISIBLE;

CREATE INDEX `reg_country_fk_idx` ON `movie_production_companies`.`registration_body` (`country_code` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`company` (
  `id` VARCHAR(144) NOT NULL,
  `name` VARCHAR(144) NOT NULL,
  `address` VARCHAR(115) NOT NULL,
  `zip_code` INT NOT NULL,
  `city_id` INT NOT NULL,
  `country_code` CHAR(2) NOT NULL,
  `kind_of_organization_id` INT NOT NULL,
  `total_asset` DECIMAL(10,2) NOT NULL,
  `total_liability` DECIMAL(10,2) NOT NULL,
  `registration_body_id` INT NOT NULL,
  `registration_date` DATE NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `city_id_fk`
    FOREIGN KEY (`city_id`)
    REFERENCES `movie_production_companies`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `company_country_code_fk`
    FOREIGN KEY (`country_code`)
    REFERENCES `movie_production_companies`.`country` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `kind_of_organization_fk`
    FOREIGN KEY (`kind_of_organization_id`)
    REFERENCES `movie_production_companies`.`kind_of_organization` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `registration_body_fk`
    FOREIGN KEY (`registration_body_id`)
    REFERENCES `movie_production_companies`.`registration_body` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `id_UNIQUE` ON `movie_production_companies`.`company` (`id` ASC) VISIBLE;

CREATE UNIQUE INDEX `company_name_UNIQUE` ON `movie_production_companies`.`company` (`name` ASC) VISIBLE;

CREATE INDEX `country_id_idx` ON `movie_production_companies`.`company` (`country_code` ASC) VISIBLE;

CREATE INDEX `kind_of_organization_fk_idx` ON `movie_production_companies`.`company` (`kind_of_organization_id` ASC) VISIBLE;

CREATE INDEX `regulatory_body_fk_idx` ON `movie_production_companies`.`company` (`registration_body_id` ASC) VISIBLE;

CREATE INDEX `company_fk_city_idx` ON `movie_production_companies`.`company` (`city_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`employee` (
  `id` VARCHAR(144) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `company_id` VARCHAR(144) NOT NULL,
  `employee_role` VARCHAR(75) NOT NULL,
  `date_started` DATE NOT NULL,
  `email_address` VARCHAR(115) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `employee_company_fk`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `email_address_UNIQUE` ON `movie_production_companies`.`employee` (`email_address` ASC) VISIBLE;

CREATE INDEX `company_fk_idx` ON `movie_production_companies`.`employee` (`company_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `role_name_index` ON `movie_production_companies`.`role` (`name` ASC, `id` ASC) VISIBLE;

CREATE UNIQUE INDEX `name_UNIQUE` ON `movie_production_companies`.`role` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`crew` (
  `sn` INT NOT NULL AUTO_INCREMENT,
  `crew_id` VARCHAR(144) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`sn`),
  CONSTRAINT `crew_id_fk`
    FOREIGN KEY (`crew_id`)
    REFERENCES `movie_production_companies`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `crew_role_id_fk`
    FOREIGN KEY (`role_id`)
    REFERENCES `movie_production_companies`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `employee_fk_idx` ON `movie_production_companies`.`crew` (`crew_id` ASC) VISIBLE;

CREATE INDEX `role_fk_idx` ON `movie_production_companies`.`crew` (`role_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`film` (
  `movie_code` VARCHAR(115) NOT NULL,
  `title` VARCHAR(115) NOT NULL,
  `release_year` YEAR NOT NULL,
  `first_released` DATE NOT NULL,
  PRIMARY KEY (`movie_code`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `title_UNIQUE` ON `movie_production_companies`.`film` (`title` ASC) VISIBLE;

CREATE INDEX `movie_code_index` ON `movie_production_companies`.`film` (`movie_code` ASC) INVISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`crew_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`crew_info` (
  `crew_id` VARCHAR(144) NOT NULL,
  `movie_code` VARCHAR(115) NOT NULL,
  `role_id` INT NOT NULL,
  `hourly_rate` DECIMAL(10,2) NULL DEFAULT NULL,
  `daily_bonus` DECIMAL(10,2) NULL DEFAULT NULL,
  `scene_bonus` DECIMAL(10,2) NULL DEFAULT NULL,
  `completion_bonus` DECIMAL(10,2) NULL DEFAULT NULL,
  `contractual_incentive` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`crew_id`, `movie_code`, `role_id`),
  CONSTRAINT `crew_id_info_fk`
    FOREIGN KEY (`crew_id`)
    REFERENCES `movie_production_companies`.`crew` (`crew_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `movie_code_fk`
    FOREIGN KEY (`movie_code`)
    REFERENCES `movie_production_companies`.`film` (`movie_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `role_id_fk`
    FOREIGN KEY (`role_id`)
    REFERENCES `movie_production_companies`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `movie_code_fk_idx` ON `movie_production_companies`.`crew_info` (`movie_code` ASC) VISIBLE;

CREATE INDEX `role_fk_idx` ON `movie_production_companies`.`crew_info` (`role_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(115) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb3;

CREATE UNIQUE INDEX `name_UNIQUE` ON `movie_production_companies`.`department` (`name` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`department_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`department_address` (
  `department_id` INT NOT NULL,
  `company_id` VARCHAR(144) NOT NULL,
  `building` VARCHAR(144) NOT NULL,
  `address` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`department_id`, `company_id`),
  CONSTRAINT `fk_department_has_companies_companies1`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`),
  CONSTRAINT `fk_department_has_companies_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `movie_production_companies`.`department` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_department_has_companies_companies1_idx` ON `movie_production_companies`.`department_address` (`company_id` ASC) VISIBLE;

CREATE INDEX `fk_department_has_companies_department1_idx` ON `movie_production_companies`.`department_address` (`department_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`grant_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`grant_request` (
  `id` VARCHAR(24) NOT NULL,
  `title` VARCHAR(199) NOT NULL,
  `funding_organization` VARCHAR(135) NOT NULL,
  `maximum_monetary_value` DECIMAL(10,2) NOT NULL,
  `desired_amount` DECIMAL(10,2) NOT NULL,
  `application_date` DATE NOT NULL,
  `deadline` DATE NOT NULL,
  `outcome` ENUM('Approved', 'Denied', 'Pending') NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`phone_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`phone_number` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` VARCHAR(144) NOT NULL,
  `phone` VARCHAR(35) NOT NULL,
  `description` VARCHAR(45) NOT NULL DEFAULT 'Home',
  PRIMARY KEY (`id`),
  CONSTRAINT `employee_fk`
    FOREIGN KEY (`employee_id`)
    REFERENCES `movie_production_companies`.`employee` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 40
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `employee_fk_idx` ON `movie_production_companies`.`phone_number` (`employee_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`shareholder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`shareholder` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `country_code` CHAR(2) NOT NULL,
  `place_of_birth` VARCHAR(75) NOT NULL,
  `mother's_maiden_name` VARCHAR(45) NOT NULL,
  `father's_first_name` VARCHAR(45) NOT NULL,
  `personal_telephone` VARCHAR(25) NOT NULL,
  `national_insurance_number` VARCHAR(30) NOT NULL,
  `passport_number` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `nation_fk_for_shareholders`
    FOREIGN KEY (`country_code`)
    REFERENCES `movie_production_companies`.`country` (`code`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `nation_fk_idx` ON `movie_production_companies`.`shareholder` (`country_code` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`staff` (
  `sn` INT NOT NULL AUTO_INCREMENT,
  `staff_id` VARCHAR(144) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`sn`),
  CONSTRAINT `staff_id_fk`
    FOREIGN KEY (`staff_id`)
    REFERENCES `movie_production_companies`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `staff_department_id_fk`
    FOREIGN KEY (`department_id`)
    REFERENCES `movie_production_companies`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 19
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `employee_fk_idx` ON `movie_production_companies`.`staff` (`staff_id` ASC) VISIBLE;

CREATE INDEX `department_fk_idx` ON `movie_production_companies`.`staff` (`department_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`staff_salary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`staff_salary` (
  `sn` INT NOT NULL AUTO_INCREMENT,
  `staff_id` VARCHAR(144) NOT NULL,
  `working_hours` ENUM('Full-time', 'Part-time') NOT NULL,
  `job_level` ENUM('Entry', 'Mid', 'Senior', 'Executive') NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`sn`),
  CONSTRAINT `staff_salary_id_fk`
    FOREIGN KEY (`staff_id`)
    REFERENCES `movie_production_companies`.`staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `staff_salary_fk_idx` ON `movie_production_companies`.`staff_salary` (`staff_id` ASC) VISIBLE;

CREATE UNIQUE INDEX `staff_id_UNIQUE` ON `movie_production_companies`.`staff_salary` (`staff_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`company_grant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`company_grant` (
  `company_id` VARCHAR(144) NOT NULL,
  `grant_request_id` VARCHAR(24) NOT NULL,
  PRIMARY KEY (`company_id`, `grant_request_id`),
  CONSTRAINT `fk_company_has_grant_request_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_has_grant_request_grant_request1`
    FOREIGN KEY (`grant_request_id`)
    REFERENCES `movie_production_companies`.`grant_request` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_company_has_grant_request_grant_request1_idx` ON `movie_production_companies`.`company_grant` (`grant_request_id` ASC) VISIBLE;

CREATE INDEX `fk_company_has_grant_request_company1_idx` ON `movie_production_companies`.`company_grant` (`company_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`activity_log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`activity_log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_type` VARCHAR(45) NOT NULL,
  `table_name` VARCHAR(45) NOT NULL,
  `key_attribute` VARCHAR(95) NOT NULL,
  `event_description` VARCHAR(212) NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `event_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`company_shareholder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`company_shareholder` (
  `company_id` VARCHAR(144) NOT NULL,
  `shareholder_id` INT NOT NULL,
  PRIMARY KEY (`company_id`, `shareholder_id`),
  CONSTRAINT `fk_company_has_shareholder_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_has_shareholder_shareholder1`
    FOREIGN KEY (`shareholder_id`)
    REFERENCES `movie_production_companies`.`shareholder` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_company_has_shareholder_shareholder1_idx` ON `movie_production_companies`.`company_shareholder` (`shareholder_id` ASC) VISIBLE;

CREATE INDEX `fk_company_has_shareholder_company1_idx` ON `movie_production_companies`.`company_shareholder` (`company_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`company_film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`company_film` (
  `company_id` VARCHAR(144) NOT NULL,
  `film_movie_code` VARCHAR(115) NOT NULL,
  PRIMARY KEY (`company_id`, `film_movie_code`),
  CONSTRAINT `fk_company_has_film_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_company_has_film_film1`
    FOREIGN KEY (`film_movie_code`)
    REFERENCES `movie_production_companies`.`film` (`movie_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

CREATE INDEX `fk_company_has_film_film1_idx` ON `movie_production_companies`.`company_film` (`film_movie_code` ASC) VISIBLE;

CREATE INDEX `fk_company_has_film_company1_idx` ON `movie_production_companies`.`company_film` (`company_id` ASC) VISIBLE;

USE `movie_production_companies` ;

-- -----------------------------------------------------
-- Placeholder table for view `movie_production_companies`.`company_info_full`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`company_info_full` (`company_name` INT, `address` INT, `city` INT, `zip_code` INT, `country` INT, `organization_type` INT, `registration_body` INT, `number_of_employees` INT, `net_value` INT);

-- -----------------------------------------------------
-- Placeholder table for view `movie_production_companies`.`employee_info_full`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`employee_info_full` (`id` INT, `first_name` INT, `middle_name` INT, `last_name` INT, `gender` INT, `date_of_birth` INT, `company` INT, `employee_role` INT, `division` INT, `date_started` INT, `email_address` INT, `phones` INT, `descriptions` INT);

-- -----------------------------------------------------
-- Placeholder table for view `movie_production_companies`.`payroll`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`payroll` (`staff_id` INT, `first_name` INT, `middle_name` INT, `last_name` INT, `company` INT, `department` INT, `job_level` INT, `working_hours` INT, `salary` INT);

-- -----------------------------------------------------
-- procedure add_company
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_company`(IN new_company_name VARCHAR(199), IN address_name VARCHAR(199), IN city_name VARCHAR(75), 
								IN zipcode INT, IN country_name VARCHAR(199), IN organization_kind VARCHAR(199), IN asset DECIMAL(10, 2),
								IN liability DECIMAL(10, 2), IN country_of_registration VARCHAR(100), IN registration_date DATE)
BEGIN
	INSERT INTO company(name, address, city_id, 
						zip_code, country_code, kind_of_organization_id, 
						total_asset, total_liability, 
                        registration_body_id, registration_date)
	VALUES( 
			new_company_name, address_name, 
            (SELECT id FROM city WHERE city.name = city_name), zipcode,
			(SELECT code FROM country WHERE country.name = country_name), 
			(SELECT id FROM kind_of_organization WHERE name = organization_kind),
            asset, liability, 
            (SELECT r.id FROM registration_body r, country c WHERE r.country_code = c.code AND c.name = country_of_registration), 
            registration_date);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_company_department_address
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_company_department_address`(IN dept_name VARCHAR(75), IN company_name VARCHAR(75), 
													IN building_name VARCHAR(75), IN addy VARCHAR(75))
BEGIN
	INSERT INTO all_departments_addresses (department_id, company_id, building, address)
    VALUES (
    (SELECT id FROM department WHERE name = dept_name),
    (SELECT id FROM company WHERE name = company_name), 
    building_name, addy);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_department_address
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_department_address`(IN dept_name VARCHAR(75), IN company_name VARCHAR(75), 
													IN building_name VARCHAR(75), IN addy VARCHAR(75))
BEGIN
	INSERT INTO department_address(department_id, company_id, building, address)
    VALUES (
    (SELECT id FROM department WHERE name = dept_name),
    (SELECT id FROM company WHERE name = company_name), 
    building_name, addy);
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_employee
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_employee`(
    IN firstname VARCHAR(45),
    IN middlename VARCHAR(45),
    IN lastname VARCHAR(45),
    IN DOB DATE,
    IN company_name VARCHAR(144),
    IN company_role ENUM('Director', 'Actor', 'Producer', 'Human Resources', 'Marketing and Finance', 'Public Relations', 'Asset Management', 'Legal Affairs', 'IT', 'Casting', 'Post-Production Services', 'Locations and Facilities', 'Research and Development'),
    IN commencement_date DATE,
    IN email VARCHAR(115)
)
BEGIN
    INSERT INTO employee (
        first_name,
        middle_name,
        last_name,
        date_of_birth,
        company_id,
        employee_role,
        date_started,
        email_address
    )
    VALUES (
        firstname,
        middlename,
        lastname,
        DOB,
        (SELECT id FROM company WHERE name = company_name),
        company_role,
        commencement_date,
        email
    );

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_film
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_film`(
    IN new_title VARCHAR(115),
    IN production_company VARCHAR(144),
    IN new_release_year YEAR,
    IN new_first_released DATE
)
BEGIN
    INSERT INTO film (
        title,
        company_id,
        release_year,
        first_released
    )
    VALUES (
        new_movie_code,
        new_title,
        (SELECT id FROM company WHERE name = production_company),
        new_release_year,
        new_first_released
    );

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_grant_request
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_grant_request`(
    IN grant_title VARCHAR(199),
    IN funding_agency VARCHAR(135),
    IN max_monetary_value DECIMAL(10,2),
    IN new_desired_amount DECIMAL(10,2),
    IN new_application_date DATE,
    IN new_deadline DATE,
    IN `outcome (optional)` VARCHAR(45)
)
BEGIN
    INSERT INTO grant_request (
        title,
        funding_organization,
        maximum_monetary_value,
        desired_amount,
        application_date,
        deadline,
        outcome
    )
    VALUES (
        grant_title,
        funding_agency,
        max_monetary_value,
        new_desired_amount,
        new_application_date,
        new_deadline,
        `outcome (optional)`
    );

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_shareholder
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_shareholder`(
    IN new_first_name VARCHAR(50),
    IN new_last_name VARCHAR(50),
    IN company_name VARCHAR(24),
    IN nationality CHAR(3),
    IN new_place_of_birth VARCHAR(75),
    IN new_mothers_maiden_name VARCHAR(45),
    IN new_fathers_first_name VARCHAR(45),
    IN new_personal_telephone VARCHAR(25),
    IN new_national_insurance_number VARCHAR(30),
    IN new_passport_number VARCHAR(25)
)
BEGIN
    INSERT INTO shareholder (
        first_name,
        last_name,
        company_id,
        country_code,
        place_of_birth,
        `mother's_maiden_name`,
        `father's_first_name`,
        personal_telephone,
        national_insurance_number,
        passport_number
    )
    VALUES (
        new_first_name,
        new_last_name,
        (SELECT id FROM company WHERE name = company_name),
        (SELECT code FROM country WHERE name = nationality),
        new_place_of_birth,
        new_mothers_maiden_name,
        new_fathers_first_name,
        new_personal_telephone,
        new_national_insurance_number,
        new_passport_number
    );

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure call_company
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `call_company`(IN company_name VARCHAR(199))
BEGIN
	SELECT * FROM company WHERE name = company_name;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure call_employee
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `call_employee`(IN email VARCHAR(75))
BEGIN
	SELECT e.id, e.first_name, e.middle_name, 
		e.last_name, e.date_of_birth, e.employee_role, 
        e.date_started, e.email_address, p.phone, p.description
FROM employee e, phone_number p 
WHERE e.id = p.employee_id AND e.email_address = email;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure call_film
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `call_film`(IN film_name VARCHAR(122))
BEGIN
	SELECT * FROM film WHERE title = film_name;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure call_shareholder
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `call_shareholder`(IN shareholder_fn VARCHAR(50), IN shareholder_ln VARCHAR(50))
BEGIN
	SELECT * FROM shareholder s WHERE s.first_name = shareholder_fn AND s.last_name = shareholder_ln;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_company_record
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_company_record`(
    IN company_name VARCHAR(144)
)
BEGIN
    DECLARE company_id_to_delete VARCHAR(144);
    
    -- Get the company_id based on the company name
    SELECT id INTO company_id_to_delete 
    FROM `movie_production_companies`.`company`
    WHERE `name` = company_name;
    
    IF company_id_to_delete IS NOT NULL THEN
        -- Delete from the related tables with cascading delete
        DELETE FROM `movie_production_companies`.`shareholder`
        WHERE `company_id` = company_id_to_delete;

        DELETE FROM `movie_production_companies`.`employee`
        WHERE `company_id` = company_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`film`
        WHERE `company_id` = company_id_to_delete;
        
         DELETE FROM `movie_production_companies`.`company_grant`
        WHERE `company_id` = company_id_to_delete;
        
         DELETE FROM `movie_production_companies`.`department_address`
        WHERE `company_id` = company_id_to_delete;

        -- Delete the company itself
        DELETE FROM `movie_production_companies`.`company`
        WHERE `id` = company_id_to_delete;
        
        SELECT 'Company and related records deleted successfully.' AS result;
    ELSE
        SELECT 'Company not found.' AS result;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_employee_by_email
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_employee_by_email`(
    IN email VARCHAR(115)
)
BEGIN
    DECLARE employee_id_to_delete VARCHAR(144);
    
    -- Get the employee_id based on the email address
    SELECT id INTO employee_id_to_delete FROM `movie_production_companies`.`employee`
    WHERE `email_address` = email;
    
    IF employee_id_to_delete IS NOT NULL THEN
        DELETE FROM `movie_production_companies`.`crew`
        WHERE `crew_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`staff`
        WHERE `staff_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`staff_salary`
        WHERE `staff_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`crew_info`
        WHERE `crew_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`phone_number`
        WHERE `employee_id` = employee_id_to_delete;

        -- Delete the employee itself
        DELETE FROM `movie_production_companies`.`employee`
        WHERE `id` = employee_id_to_delete;
        
        SELECT 'Employee and related records deleted successfully.' AS result;
    ELSE
        SELECT 'Employee not found.' AS result;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_employee_record
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_employee_record`(
    IN email VARCHAR(115)
)
BEGIN
    DECLARE employee_id_to_delete VARCHAR(144);
    
    -- Get the employee_id based on the email address
    SELECT id INTO employee_id_to_delete FROM `movie_production_companies`.`employee`
    WHERE `email_address` = email;
    
    IF employee_id_to_delete IS NOT NULL THEN
        DELETE FROM `movie_production_companies`.`crew`
        WHERE `employee_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`staff`
        WHERE `employee_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`staff_salary`
        WHERE `employee_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`crew_info`
        WHERE `employee_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`phone_number`
        WHERE `employee_id` = employee_id_to_delete;

        -- Delete the employee itself
        DELETE FROM `movie_production_companies`.`employee`
        WHERE `id` = employee_id_to_delete;
        
        SELECT 'Employee and related records deleted successfully.' AS result;
    ELSE
        SELECT 'Employee not found.' AS result;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_shareholder_by_name
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_shareholder_by_name`(
    IN firstname VARCHAR(50),
    IN lastname VARCHAR(50)
)
BEGIN
    DECLARE shareholder_id_to_delete INT;

    -- Get the shareholder_id based on the first and last names
SELECT id
INTO shareholder_id_to_delete 
FROM `movie_production_companies`.`shareholder`
WHERE
    `first_name` = firstname
        AND `last_name` = lastname;

    IF shareholder_id_to_delete IS NOT NULL THEN
        -- Delete the shareholder
        DELETE FROM `movie_production_companies`.`shareholder`
        WHERE `id` = shareholder_id_to_delete;

SELECT 'Shareholder deleted successfully.' AS result;
    ELSE
        SELECT 'Shareholder not found.' AS result;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_employees_by_company
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_employees_by_company`(IN company_name VARCHAR(255))
BEGIN
    SELECT 
        e.first_name,
        e.middle_name,
        e.last_name,
        e.division
    FROM 
        employee e
    JOIN 
        company c ON e.company_id = c.id
    WHERE 
        c.name = company_name;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_films_by_company
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_films_by_company`(company_name VARCHAR(200))
BEGIN
	SELECT film.title AS movie, film.release_year
    FROM film
    JOIN company ON company.id = film.company_id
    WHERE company.name = company_name;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_grant_details
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_grant_details`(heading VARCHAR(200))
BEGIN
	SELECT application_date, desired_amount, outcome
    FROM grant_request
    WHERE title = heading;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_shareholders_by_company
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_shareholders_by_company`(company_name VARCHAR(200))
BEGIN
	SELECT 
		s.first_name, 
        s.last_name, 
        s.country_code AS nationality, 
        s.place_of_birth
    FROM shareholder s
    JOIN company ON company.id = s.company_id
    JOIN country ON country.code = s.country_code
    WHERE company.name = company_name;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_grant_status
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` 
PROCEDURE `update_grant_status`(IN grant_title VARCHAR(199), IN status ENUM('Approved', 'Denied', 'Pending'))
BEGIN
	UPDATE grant_request
	SET outcome = status 
	WHERE grant_request.title = grant_title;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_film_by_title
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_film_by_title`(
    IN current_movie_title VARCHAR(115),
    IN new_title VARCHAR(115),
    IN new_company_name VARCHAR(144),
    IN new_release_year YEAR,
    IN new_first_released DATE
)
BEGIN
    DECLARE movie_code_param VARCHAR(115);

    -- Get the movie code based on the provided movie title
    SELECT `movie_code` INTO movie_code_param
    FROM `movie_production_companies`.`film`
    WHERE `title` = current_movie_title;

    -- Update film information based on movie code
    UPDATE `movie_production_companies`.`film`
    SET
        `title` = COALESCE(new_title, `title`),
        `company_id` = COALESCE((SELECT id FROM company WHERE name = new_company_name), `company_id`),
        `release_year` = COALESCE(new_release_year, `release_year`),
        `first_released` = IFNULL(new_first_released, `first_released`)
    WHERE
        `movie_code` = movie_code_param;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure activity_log_auto
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `activity_log_auto`(
    IN log_type VARCHAR(50),
    IN entity VARCHAR(50),
    IN key_column VARCHAR(114),
    IN log_description VARCHAR(200)
)
BEGIN
    INSERT INTO activity_log (event_type, table_name, key_attribute, event_description, user)
    VALUES (log_type, entity, key_column, log_description, CURRENT_USER());
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure activity_filter
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `activity_filter`(
	IN eventType VARCHAR(50),
    IN tableName VARCHAR(50)
)
BEGIN
    IF eventType IS NOT NULL AND tableName IS NULL THEN
        SELECT id, table_name, key_attribute, event_description, user, event_timestamp
        FROM activity_log
        WHERE event_type = eventType;
    
    ELSEIF tableName IS NOT NULL AND eventType IS NULL THEN
        SELECT id, event_type, key_attribute, event_description, user, event_timestamp
        FROM activity_log
        WHERE table_name = tableName;
    
    ELSEIF tableName IS NOT NULL AND eventType IS NOT NULL THEN
        SELECT id, key_attribute, event_description, user, event_timestamp
        FROM activity_log
        WHERE event_type = eventType AND table_name = tableName;
    
    ELSE
        SELECT * FROM activity_log;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- View `movie_production_companies`.`company_info_full`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_production_companies`.`company_info_full`;
USE `movie_production_companies`;
CREATE  OR REPLACE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `company_info_full` AS
    SELECT 
        `c`.`name` AS `company_name`,
        `c`.`address` AS `address`,
        `city`.`name` AS `city`,
        `c`.`zip_code` AS `zip_code`,
        `country`.`name` AS `country`,
        `k`.`name` AS `organization_type`,
        `r`.`name` AS `registration_body`,
        (SELECT 
                COUNT(0)
            FROM
                `employee`
            WHERE
                (`employee`.`company_id` = `c`.`id`)) AS `number_of_employees`,
        (`c`.`total_asset` - `c`.`total_liability`) AS `net_value`
    FROM
        ((((`company` `c`
        JOIN `city` ON ((`c`.`city_id` = `city`.`id`)))
        JOIN `country` ON ((`c`.`country_code` = `country`.`code`)))
        JOIN `kind_of_organization` `k` ON ((`c`.`kind_of_organization_id` = `k`.`id`)))
        JOIN `registration_body` `r` ON ((`c`.`registration_body_id` = `r`.`id`)));

-- -----------------------------------------------------
-- View `movie_production_companies`.`employee_info_full`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_production_companies`.`employee_info_full`;
USE `movie_production_companies`;
CREATE  OR REPLACE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `employee_info_full` AS
    SELECT 
        `e`.`id` AS `id`,
        `e`.`first_name` AS `first_name`,
        `e`.`middle_name` AS `middle_name`,
        `e`.`last_name` AS `last_name`,
        `e`.`gender` AS `gender`,
        `e`.`date_of_birth` AS `date_of_birth`,
        `c`.`name` AS `company`,
        `e`.`employee_role` AS `employee_role`,
        (CASE
            WHEN
                `e`.`employee_role` IN (SELECT 
                        `role`.`name`
                    FROM
                        `role`)
            THEN
                'Crew'
            WHEN
                `e`.`employee_role` IN (SELECT 
                        `department`.`name`
                    FROM
                        `department`)
            THEN
                'Staff'
        END) AS `division`,
        `e`.`date_started` AS `date_started`,
        `e`.`email_address` AS `email_address`,
        GROUP_CONCAT(DISTINCT `p`.`phone` ORDER BY `p`.`phone` ASC SEPARATOR ', ') AS `phones`,
        GROUP_CONCAT(DISTINCT `p`.`description` ORDER BY `p`.`description` ASC SEPARATOR ', ') AS `descriptions`
    FROM
        `employee` `e`
        JOIN `phone_number` `p` ON `e`.`id` = `p`.`employee_id`
        JOIN `company` `c` ON `e`.`company_id` = `c`.`id`
    GROUP BY
        `e`.`id`,
        `e`.`first_name`,
        `e`.`middle_name`,
        `e`.`last_name`,
        `e`.`gender`,
        `e`.`date_of_birth`,
        `c`.`name`,
        `e`.`employee_role`,
        `e`.`date_started`,
        `e`.`email_address`;

-- -----------------------------------------------------
-- View `movie_production_companies`.`payroll`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_production_companies`.`payroll`;
USE `movie_production_companies`;
CREATE  OR REPLACE VIEW `payroll` AS
SELECT 
        `ss`.`staff_id` AS `staff_id`,
        `e`.`first_name` AS `first_name`,
        `e`.`middle_name` AS `middle_name`,
        `e`.`last_name` AS `last_name`,
        `c`.`name` AS `company`,
        `d`.`name` AS `department`,
        `ss`.`job_level` AS `job_level`,
        `ss`.`working_hours` AS `working_hours`,
        `ss`.`salary` AS `salary`
    FROM
        ((((`staff_salary` `ss`
        JOIN `staff` `s` ON ((`ss`.`staff_id` = `s`.`staff_id`)))
        JOIN `employee` `e` ON ((`s`.`staff_id` = `e`.`id`)))
        JOIN `department` `d` ON ((`s`.`department_id` = `d`.`id`)))
        JOIN `company` `c` ON ((`e`.`company_id` = `c`.`id`)))
    ORDER BY `e`.`first_name` , `e`.`last_name`;
USE `movie_production_companies`;

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `company_id_generator` BEFORE INSERT ON `company` FOR EACH ROW BEGIN

    DECLARE trimmed_company_name VARCHAR(128);
    DECLARE space_count INT;
    DECLARE name_length INT;
    
    SET trimmed_company_name = TRIM(NEW.name);
    SET space_count = LENGTH(trimmed_company_name) - LENGTH(REPLACE(trimmed_company_name, " ", ""));
	SET name_length = LENGTH(trimmed_company_name);
    SET @random_number = FLOOR(100000 + RAND() * 900000);
    
    IF name_length < 3 THEN
		-- If the company name is less than 3 characters, pad it with 'X's
		SET @generated_letters = UPPER(CONCAT(trimmed_company_name, REPEAT('X', 3 - name_length)));
		SET NEW.id = CONCAT(NEW.country_code, "-", @generated_letters, "-", @random_number);
	END IF;

    CASE space_count
        WHEN 0 THEN
            SET @generated_letters = UPPER(SUBSTRING(trimmed_company_name FROM 1 FOR 3));
            SET NEW.id = CONCAT(NEW.country_code, "-", @generated_letters, "-", @random_number);

        WHEN 1 THEN 
            SET @first_word = SUBSTRING_INDEX(trimmed_company_name, " ", 1);
            SET @first_word_first_letter = SUBSTRING(@first_word FROM 1 FOR 1);
            SET @second_word = REPLACE(trimmed_company_name, CONCAT(@first_word, " "), "");
            SET @second_word_first_two_letters = SUBSTRING(@second_word FROM 1 FOR 2);
            SET @generated_letters = UPPER(CONCAT(@first_word_first_letter, @second_word_first_two_letters));
            SET NEW.id = CONCAT(NEW.country_code, "-", @generated_letters, "-", @random_number);
        ELSE 
            SET @first_word = SUBSTRING_INDEX(trimmed_company_name, " ", 1);
            SET @first_word_first_letter = SUBSTRING(@first_word FROM 1 FOR 1);
            SET @second_word = REPLACE(trimmed_company_name, CONCAT(@first_word, " "), "");
            SET @second_word_first_letter = SUBSTRING(@second_word FROM 1 FOR 1);
            SET @third_word = REPLACE(trimmed_company_name, CONCAT(SUBSTRING_INDEX(trimmed_company_name, " ", 2), " "), "");
            SET @third_word_first_letter = SUBSTRING(@third_word FROM 1 FOR 1);
            SET @generated_letters = UPPER(CONCAT(@first_word_first_letter, @second_word_first_letter, @third_word_first_letter));
            SET NEW.id = CONCAT(NEW.country_code, "-", @generated_letters, "-", @random_number);
        END CASE;
        
	-- Ensure @generated_letters is at least 3 characters long
        IF LENGTH(@generated_letters) < 3 THEN
            SET @generated_letters = CONCAT(@generated_letters, REPEAT('X', 3 - LENGTH(@generated_letters)));
            SET NEW.id = CONCAT(NEW.country_code, "-", @generated_letters, "-", @random_number);
        END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `city_in_country` 
BEFORE INSERT ON `company` 
FOR EACH ROW 
BEGIN
	IF NEW.city_id IS NOT NULL THEN
    	SET NEW.country_code = (SELECT code FROM country, city 
			    WHERE country.code = city.country_code 
                            AND city.id = NEW.city_id);
	END IF;
END$$

USE `movie_production_companies`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `movie_production_companies`.`reg_body_of_country`
BEFORE INSERT ON `movie_production_companies`.`company`
FOR EACH ROW
BEGIN
	IF NEW.city_id IS NOT NULL THEN
    SET NEW.registration_body_id = (SELECT r.id 
									FROM registration_body r, country n, city c 
									WHERE c.country_code = n.code
									AND r.country_code = n.code
									AND c.id = NEW.city_id);
	END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `log_company_insert` 
AFTER INSERT ON `company` 
FOR EACH ROW 
BEGIN
	CALL `activity_log_auto`('INSERT', 'Company', NEW.name, CONCAT('New row added with ID: ', NEW.id));
END$$

USE `movie_production_companies`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `movie_production_companies`.`delete_company_records`
BEFORE DELETE ON `movie_production_companies`.`company`
FOR EACH ROW
BEGIN
    DECLARE company_id_to_delete VARCHAR(144);
    
    SET company_id_to_delete = OLD.id;

	DELETE FROM `movie_production_companies`.`shareholder`
	WHERE `company_id` = company_id_to_delete;

	DELETE FROM `movie_production_companies`.`employee`
	WHERE `company_id` = company_id_to_delete;
	
	DELETE FROM `movie_production_companies`.`film`
	WHERE `company_id` = company_id_to_delete;
	
	 DELETE FROM `movie_production_companies`.`company_grant`
	WHERE `company_id` = company_id_to_delete;
	
	 DELETE FROM `movie_production_companies`.`department_address`
	WHERE `company_id` = company_id_to_delete;
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `log_company_delete` 
AFTER DELETE ON `company` 
FOR EACH ROW 
BEGIN
	CALL `activity_log_auto`('DELETE', 'Company', OLD.name, CONCAT('Deleted Row with ID: ', OLD.id));
END$$

USE `movie_production_companies`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `movie_production_companies`.`employee_id_generator`
BEFORE INSERT ON `movie_production_companies`.`employee`
FOR EACH ROW
BEGIN
	DECLARE role_id INT;
    DECLARE department_id INT;
    
    SELECT id INTO role_id FROM role WHERE name = NEW.employee_role;
    SELECT id INTO department_id FROM department WHERE name = NEW.employee_role;    
    
	IF NEW.employee_role IN (SELECT name FROM movie_production_companies.`role`) THEN
    SET NEW.id = CONCAT(
		'CR-', FLOOR(10000000 + RAND() * 90000000), '-', 
        LEFT(NEW.first_name, 1), 
        LEFT(NEW.middle_name, 1),
        LEFT(NEW.last_name, 1),
        role_id
        );
	ELSEIF NEW.employee_role IN (SELECT name FROM movie_production_companies.`department`) THEN
    SET NEW.id = CONCAT(
		'ST-', FLOOR(10000000 + RAND() * 90000000), '-', 
        LEFT(NEW.first_name, 1), 
        LEFT(NEW.middle_name, 1),
        LEFT(NEW.last_name, 1),
        department_id
		);
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `employee_email_generator` 
BEFORE INSERT ON `employee` 
FOR EACH ROW 
BEGIN
DECLARE domain VARCHAR(114);
DECLARE extension VARCHAR(5);
    
    SELECT LOWER(replace(name, ' ', '')) INTO domain FROM company WHERE id = NEW.company_id;
    SELECT ELT(FLOOR(1 + RAND() * 4), '.com', '.org', '.co', '.net') INTO extension;
    
    IF NEW.employee_role IS NOT NULL THEN
    SET NEW.email_address = CONCAT(
    LOWER(NEW.first_name),
    LOWER(NEW.last_name),
    FLOOR(100000 + RAND() * 900),
    LOWER(LEFT(NEW.middle_name, 2)),
    RIGHT(NEW.date_of_birth, 1),
    '@',
    domain, extension
    );
    END IF;
END$$

USE `movie_production_companies`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `movie_production_companies`.`check_employee_role`
BEFORE INSERT ON `movie_production_companies`.`employee`
FOR EACH ROW
BEGIN
    DECLARE role_exists INT;
    DECLARE department_exists INT;

    SELECT COUNT(*) INTO role_exists FROM movie_production_companies.`role` WHERE name = NEW.employee_role;
    SELECT COUNT(*) INTO department_exists FROM movie_production_companies.`department` WHERE name = NEW.employee_role;

    IF role_exists = 0 AND department_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid employee role';
    END IF;
END$$

USE `movie_production_companies`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `movie_production_companies`.`crew-staff_insert`
AFTER INSERT ON `movie_production_companies`.`employee`
FOR EACH ROW
BEGIN
    IF NEW.employee_role IN (SELECT name FROM movie_production_companies.department) THEN
        INSERT INTO movie_production_companies.staff(staff_id, department_id)
        VALUES (NEW.id,
                (SELECT movie_production_companies.department.id 
                 FROM movie_production_companies.department 
                 WHERE department.name = NEW.employee_role));
                 
    ELSEIF NEW.employee_role IN (SELECT name FROM movie_production_companies.`role`) THEN
        INSERT INTO movie_production_companies.crew(crew_id, role_id)
        VALUES (NEW.id,
                (SELECT movie_production_companies.`role`.id 
                 FROM movie_production_companies.`role` 
                 WHERE `role`.name = NEW.employee_role));
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `log_employee_insert` 
AFTER INSERT ON `employee` 
FOR EACH ROW 
BEGIN
	CALL `activity_log_auto`('INSERT', 'Employee', NEW.email_address, CONCAT('New row added with ID: ', NEW.id));
END$$

USE `movie_production_companies`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `movie_production_companies`.`delete_employee_record`
BEFORE DELETE ON `movie_production_companies`.`employee`
FOR EACH ROW
BEGIN
		
        DECLARE employee_id_to_delete VARCHAR(115);
        
        SET employee_id_to_delete = OLD.id;
        
        DELETE FROM `movie_production_companies`.`crew`
        WHERE `crew_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`staff`
        WHERE `staff_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`staff_salary`
        WHERE `staff_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`crew_info`
        WHERE `crew_id` = employee_id_to_delete;
        
        DELETE FROM `movie_production_companies`.`phone_number`
        WHERE `employee_id` = employee_id_to_delete;
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` 
TRIGGER `log_employee_delete` 
AFTER DELETE ON `employee` 
FOR EACH ROW 
BEGIN
	CALL `activity_log_auto`('DELETE', 'Employee', OLD.email_address,  CONCAT('Deleted Row with id: ', OLD.id));
END$$

USE `movie_production_companies`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `movie_production_companies`.`movie_code_generator`
BEFORE INSERT ON `movie_production_companies`.`film`
FOR EACH ROW
BEGIN
	IF NEW.title IS NOT NULL THEN
    SET NEW.movie_code = UUID();
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `log_film_insert` 
AFTER INSERT ON `film` 
FOR EACH ROW 
BEGIN
	CALL `activity_log_auto`('INSERT', 'Film', NEW.title, CONCAT('New row added with movie title: ', NEW.title));
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `log_film_delete` 
AFTER DELETE ON `film` 
FOR EACH ROW 
BEGIN
	CALL `activity_log_auto`('DELETE', 'Film', OLD.title, CONCAT('Record of movie,', OLD.title, ', has been deleted'));
END$$

USE `movie_production_companies`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `movie_production_companies`.`check_crew_company`
BEFORE INSERT ON `movie_production_companies`.`crew_info`
FOR EACH ROW
BEGIN
    DECLARE film_company VARCHAR(144);
    DECLARE crew_company VARCHAR(144);

    SELECT company_id INTO film_company 
    FROM movie_production_companies.film 
    WHERE film.movie_code = NEW.movie_code;

    SELECT company_id INTO crew_company 
    FROM movie_production_companies.employee 
    WHERE employee.id = NEW.crew_id;

    -- Check if the company IDs match
    IF NOT (film_company = crew_company) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Crew member does not belong to the company that produced this film';
    END IF;
END$$

USE `movie_production_companies`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `movie_production_companies`.`grant_id_generaator`
BEFORE INSERT ON `movie_production_companies`.`grant_request`
FOR EACH ROW
BEGIN
	IF NEW.title IS NOT NULL 
    AND NEW.funding_organization IS NOT NULL 
    AND NEW.application_date IS NOT NULL THEN
	SET NEW.id = CONCAT(
			'GR', '-',
		    UPPER(LEFT(NEW.title, 1)), 
            FLOOR(100000 + RAND() * 900000), '-',
            UPPER(LEFT(NEW.funding_organization, 2)), 
            RIGHT(NEW.application_date, 1)
        );
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `log_grant_insert` 
AFTER INSERT ON `grant_request` 
FOR EACH ROW 
BEGIN
	CALL `activity_log_auto`('INSERT', 'Grant Request', NEW.title, CONCAT('New row added with ID: ', NEW.id));
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `log_grant_delete` 
AFTER DELETE ON `grant_request` 
FOR EACH ROW 
BEGIN
	CALL `activity_log_auto`('DELETE', 'Grant Request', OLD.title, CONCAT('Deleted Row with id: ', OLD.id));
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `phone_number_generator` 
BEFORE INSERT ON `phone_number` 
FOR EACH ROW 
BEGIN
	DECLARE isd VARCHAR(6);
	DECLARE zip INT;

	SELECT n.isd_code INTO isd FROM country n, company c, employee e
	WHERE n.code = c.country_code AND c.id = e.company_id AND e.id = NEW.employee_id;

	SELECT zip_code INTO zip FROM company c, employee e 
	WHERE c.id = e.company_id AND e.id = NEW.employee_id;

	SET @three_digits = FLOOR(100 + RAND() * 900);
	SET @four_digits = FLOOR(1000 + RAND() * 9000);

	IF NEW.employee_id IS NOT NULL THEN 
	SET NEW.phone = CONCAT('(', isd, ')', RIGHT(zip, 3), '-', @four_digits, '-', @three_digits);
	END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `log_shareholder_insert` 
AFTER INSERT ON `shareholder` 
FOR EACH ROW 
BEGIN
	CALL `log_insert_procedure`('INSERT', 'Shareholder', NEW.national_insurance_number, 
        CONCAT('New row added with ID: ', NEW.id));
END$$

USE `movie_production_companies`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `log_shareholder_delete` 
AFTER DELETE ON `shareholder` 
FOR EACH ROW 
BEGIN
	CALL `activity_log_auto`('DELETE', 'Shareholder', OLD.national_insurance_number, 
	CONCAT('Deleted Row with id: ', OLD.id));
END$$

USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER `movie_production_companies`.`log_salary_insert` 
AFTER INSERT ON `staff_salary` FOR EACH ROW
BEGIN
DECLARE email VARCHAR(115);
    SELECT email_address INTO email FROM employee e, staff_salary s 
    WHERE e.id = s.staff_id AND e.id = NEW.staff_id;
	CALL `activity_log_auto`('INSERT', 'Staff_Salary', NEW.staff_id,  CONCAT('Added new payroll record with staff email: ', email));
END$$

USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER `movie_production_companies`.`log_salary_delete` 
AFTER DELETE ON `staff_salary` 
FOR EACH ROW
BEGIN
	DECLARE email VARCHAR(115);
    SELECT email_address INTO email FROM employee e, staff_salary s 
    WHERE e.id = s.staff_id AND e.id = OLD.staff_id;
	CALL `activity_log_auto`('DELETE', 'Staff_Salary', OLD.staff_id,  CONCAT('Deleted payroll record with staff email: ', email));
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
