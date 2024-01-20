-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema movie_production_companies
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema movie_production_companies
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `movie_production_companies` DEFAULT CHARACTER SET utf8 ;
USE `movie_production_companies` ;

-- -----------------------------------------------------
-- Table `movie_production_companies`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`country` (
  `code` CHAR(3) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`kind_of_organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`kind_of_organization` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`registration_body`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`registration_body` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `country_code` CHAR(3) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `reg_country_fk_idx` (`country_code` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE,
  CONSTRAINT `reg_country_fk`
    FOREIGN KEY (`country_code`)
    REFERENCES `movie_production_companies`.`country` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`city` (
  `id` INT NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `country_code` CHAR(3) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `city_country_idx` (`country_code` ASC) VISIBLE,
  CONSTRAINT `city_country_fk`
    FOREIGN KEY (`country_code`)
    REFERENCES `movie_production_companies`.`country` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`company` (
  `id` VARCHAR(144) NOT NULL,
  `name` VARCHAR(144) NOT NULL,
  `address` VARCHAR(115) NOT NULL,
  `zip_code` INT NOT NULL,
  `city_id` INT NOT NULL,
  `country_code` CHAR(3) NOT NULL,
  `kind_of_organization_id` INT NOT NULL,
  `total_asset` DECIMAL(10,2) NOT NULL,
  `total_liability` DECIMAL(10,2) NOT NULL,
  `registration_body_id` INT NOT NULL,
  `registration_date` DATE NOT NULL,
  INDEX `country_id_idx` (`country_code` ASC) VISIBLE,
  INDEX `kind_of_organization_fk_idx` (`kind_of_organization_id` ASC) VISIBLE,
  INDEX `regulatory_body_fk_idx` (`registration_body_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `company_name_UNIQUE` (`name` ASC) VISIBLE,
  INDEX `company_fk_city_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `company_country_fk`
    FOREIGN KEY (`country_code`)
    REFERENCES `movie_production_companies`.`country` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `company_kind_of_organization_fk`
    FOREIGN KEY (`kind_of_organization_id`)
    REFERENCES `movie_production_companies`.`kind_of_organization` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `company_regulatory_body_fk`
    FOREIGN KEY (`registration_body_id`)
    REFERENCES `movie_production_companies`.`registration_body` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `company_fk_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `movie_production_companies`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`shareholder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`shareholder` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `company_id` VARCHAR(24) NOT NULL,
  `country_code` CHAR(3) NOT NULL,
  `place_of_birth` VARCHAR(75) NOT NULL,
  `mother's_maiden_name` VARCHAR(45) NOT NULL,
  `father's_first_name` VARCHAR(45) NOT NULL,
  `personal_telephone` VARCHAR(25) NOT NULL,
  `national_insurance_number` VARCHAR(30) NOT NULL,
  `passport_number` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `company_fk_idx` (`company_id` ASC) VISIBLE,
  INDEX `nation_fk_idx` (`country_code` ASC) VISIBLE,
  CONSTRAINT `shareholder_fk`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `nation_fk_for_shareholders`
    FOREIGN KEY (`country_code`)
    REFERENCES `movie_production_companies`.`country` (`code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`employee` (
  `id` VARCHAR(144) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `company_id` VARCHAR(144) NOT NULL,
  `division` ENUM('Crew', 'Staff') NOT NULL,
  `employee_role` ENUM('Director', 'Actor', 'Producer', 'Human Resources', 'Marketing and Finance', 'Public Relations', 'Asset Management', 'Legal Affairs', 'IT', 'Casting', 'Post-Production Services', 'Locations and Facilities', 'Research and Development') NOT NULL,
  `date_started` DATE NOT NULL,
  `email_address` VARCHAR(115) NOT NULL,
  UNIQUE INDEX `email_address_UNIQUE` (`email_address` ASC) VISIBLE,
  INDEX `company_fk_idx` (`company_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `employee_company_fk`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`phone_number`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`phone_number` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employee_id` VARCHAR(144) NOT NULL,
  `phone` VARCHAR(35) NOT NULL,
  `description` VARCHAR(45) NOT NULL DEFAULT 'Home',
  PRIMARY KEY (`id`),
  INDEX `employee_fk_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `employee_fk`
    FOREIGN KEY (`employee_id`)
    REFERENCES `movie_production_companies`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`id`, `name`),
  INDEX `role_name_index` (`name` ASC, `id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`crew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`crew` (
  `s_n` INT NOT NULL AUTO_INCREMENT,
  `employee_id` VARCHAR(144) NOT NULL,
  `role_id` INT NOT NULL,
  PRIMARY KEY (`s_n`),
  INDEX `employee_fk_idx` (`employee_id` ASC) VISIBLE,
  INDEX `role_fk_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `crew_employee_fk`
    FOREIGN KEY (`employee_id`)
    REFERENCES `movie_production_companies`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `crew_role_fk`
    FOREIGN KEY (`role_id`)
    REFERENCES `movie_production_companies`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`film` (
  `movie_code` VARCHAR(115) NOT NULL,
  `title` VARCHAR(115) NOT NULL,
  `company_id` VARCHAR(144) NOT NULL,
  `release_year` YEAR NOT NULL,
  `first_released` DATE NOT NULL,
  PRIMARY KEY (`movie_code`),
  INDEX `movie_code_index` (`movie_code` ASC) INVISIBLE,
  INDEX `films_company_id_idx` (`company_id` ASC) VISIBLE,
  UNIQUE INDEX `title_UNIQUE` (`title` ASC) VISIBLE,
  CONSTRAINT `films_company_id`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`department` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`staff` (
  `s_n` INT NOT NULL AUTO_INCREMENT,
  `employee_id` VARCHAR(144) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`s_n`),
  INDEX `employee_fk_idx` (`employee_id` ASC) VISIBLE,
  INDEX `department_fk_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `staff_employee_fk`
    FOREIGN KEY (`employee_id`)
    REFERENCES `movie_production_companies`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `staff_department_fk`
    FOREIGN KEY (`department_id`)
    REFERENCES `movie_production_companies`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
  `outcome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`crew_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`crew_info` (
  `employee_id` VARCHAR(144) NOT NULL,
  `movie_code` VARCHAR(115) NOT NULL,
  `role_id` INT NOT NULL,
  `description` VARCHAR(225) BINARY NOT NULL,
  `hourly_rate` DECIMAL(10,2) NULL,
  `daily_bonus` DECIMAL(10,2) NULL,
  `scene_bonus` DECIMAL(10,2) NULL,
  `completion_bonus` DECIMAL(10,2) NULL,
  `contractual_incentive` DECIMAL(10,2) NULL,
  INDEX `movie_code_fk_idx` (`movie_code` ASC) VISIBLE,
  INDEX `role_fk_idx` (`role_id` ASC) VISIBLE,
  PRIMARY KEY (`employee_id`, `movie_code`, `role_id`),
  CONSTRAINT `crewrole_emp_fk`
    FOREIGN KEY (`employee_id`)
    REFERENCES `movie_production_companies`.`crew` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `crewrole_movie_code_fk`
    FOREIGN KEY (`movie_code`)
    REFERENCES `movie_production_companies`.`film` (`movie_code`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `crewrole_role_fk`
    FOREIGN KEY (`role_id`)
    REFERENCES `movie_production_companies`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`company_grant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`company_grant` (
  `company_id` VARCHAR(144) NOT NULL,
  `grant_id` VARCHAR(24) NOT NULL,
  PRIMARY KEY (`company_id`, `grant_id`),
  INDEX `fk_companies_has_grant_grant1_idx` (`grant_id` ASC) VISIBLE,
  INDEX `fk_companies_has_grant_companies1_idx` (`company_id` ASC) VISIBLE,
  CONSTRAINT `fk_companies_has_grant_companies1`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_companies_has_grant_grant1`
    FOREIGN KEY (`grant_id`)
    REFERENCES `movie_production_companies`.`grant_request` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`department_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`department_address` (
  `department_id` INT NOT NULL,
  `company_id` VARCHAR(144) NOT NULL,
  `building` VARCHAR(144) NOT NULL,
  `address` VARCHAR(144) NOT NULL,
  PRIMARY KEY (`department_id`, `company_id`),
  INDEX `fk_department_has_companies_companies1_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_department_has_companies_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_has_companies_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `movie_production_companies`.`department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_department_has_companies_companies1`
    FOREIGN KEY (`company_id`)
    REFERENCES `movie_production_companies`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`staff_salary`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`staff_salary` (
  `employee_id` VARCHAR(144) NOT NULL,
  `working_hours` ENUM('Full-time', 'Part-time') NOT NULL,
  `job_level` ENUM('Entry', 'Mid', 'Senior', 'Executive') NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  INDEX `staff_salary_fk_idx` (`employee_id` ASC) VISIBLE,
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `staff_salary_fk`
    FOREIGN KEY (`employee_id`)
    REFERENCES `movie_production_companies`.`staff` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movie_production_companies`.`log_insert`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`log_insert` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_type` VARCHAR(45) NOT NULL,
  `table_name` VARCHAR(45) NOT NULL,
  `event_description` VARCHAR(45) NOT NULL,
  `user` VARCHAR(45) NOT NULL,
  `event_timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

USE `movie_production_companies` ;

-- -----------------------------------------------------
-- Placeholder table for view `movie_production_companies`.`company_info_full`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`company_info_full` (`company_name` INT, `address` INT, `city` INT, `zip_code` INT, `country` INT, `organization_type` INT, `registration_body` INT, `number_of_employees` INT, `net_value` INT);

-- -----------------------------------------------------
-- Placeholder table for view `movie_production_companies`.`employee_info_full`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movie_production_companies`.`employee_info_full` (`id` INT, `first_name` INT, `middle_name` INT, `last_name` INT, `company` INT, `date_of_birth` INT, `division` INT, `employee_role` INT, `date_started` INT, `email_address` INT, `phone` INT, `description` INT);

-- -----------------------------------------------------
-- procedure update_company_grant
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `update_company_grant`(IN company_name VARCHAR(144), IN grant_title VARCHAR(199))
BEGIN
	INSERT INTO company_grant(company_id, grant_id)
	VALUES (
			(SELECT id FROM company WHERE name = company_name),
			(SELECT id FROM grant_request WHERE title = grant_title)
            );
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure grant_status
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `grant_status` (IN grant_title VARCHAR(199), IN `status` ENUM('Successful', 'Unsuccessful'))
BEGIN
	UPDATE grant_request
	SET outcome = `status` 
	WHERE grant_request.title = grant_title;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_company
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `add_company`(IN new_company_name VARCHAR(199), IN address_name VARCHAR(199), IN city_name VARCHAR(75), 
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
-- procedure add_department_address
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `add_department_address` (IN dept_name VARCHAR(75), IN company_name VARCHAR(75), 
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
-- procedure update_company_department_address
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `update_company_department_address` (IN dept_name VARCHAR(75), IN company_name VARCHAR(75), 
													IN building_name VARCHAR(75), IN new_address VARCHAR(75))
BEGIN
	UPDATE department_address
    SET building = building_name AND 
    address = new_address
    WHERE dept_name = (SELECT department.name FROM department d, department_address da WHERE da.department_id = d.id)
    AND 
    company_name =  (SELECT company.name FROM company c, department_address da WHERE da.company_id = c.id)
 ;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure call_company
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `call_company` (IN company_name VARCHAR(199))
BEGIN
	SELECT * FROM company WHERE name = company_name;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure call_employee
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `call_employee` (IN email VARCHAR(75))
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
CREATE PROCEDURE `call_film` (IN film_name VARCHAR(122))
BEGIN
	SELECT * FROM film WHERE title = film_name;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure call_shareholder
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `call_shareholder` (IN shareholder_fn VARCHAR(50), IN shareholder_ln VARCHAR(50))
BEGIN
	SELECT * FROM shareholder s WHERE s.first_name = shareholder_fn AND s.last_name = shareholder_ln;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure get_employees_by_company
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE get_employees_by_company(IN company_name VARCHAR(255))
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
CREATE PROCEDURE `get_films_by_company` (company_name VARCHAR(200))
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
CREATE PROCEDURE `get_grant_details` (heading VARCHAR(200))
BEGIN
	SELECT application_date, desired_amount, outcome
    FROM grant_request
    WHERE title = heading;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure delete_shareholder_by_name
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE delete_shareholder_by_name(
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
-- procedure delete_company_record
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `delete_company_record`(
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
-- procedure delete_employee_record
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE delete_employee_record(
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
-- procedure get_shareholders_by_company
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `get_shareholders_by_company`(company_name VARCHAR(200))
BEGIN
	SELECT s.id, 
		s.first_name, 
        s.last_name, 
        s.country_code AS country, 
        s.place_of_birth
    FROM shareholder s
    JOIN company ON company.id = s.company_id
    JOIN country ON country.code = s.country_code
    WHERE company.name = company_name;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure update_company_by_name
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `update_company_by_name`(
    IN `current_name*` VARCHAR(144),
    IN new_name VARCHAR(144),
    IN address_name VARCHAR(199), 
    IN city_name VARCHAR(75), 
	IN zipcode INT, 
    IN country_name VARCHAR(199), 
    IN organization_kind VARCHAR(199), 
    IN asset DECIMAL(10, 2),
    IN liability DECIMAL(10, 2), 
    IN country_of_registration VARCHAR(100), 
    IN date_of_registration DATE)
BEGIN
    UPDATE `movie_production_companies`.`company`
    SET
        `name` = COALESCE(new_name, `name`), 
        `address` = COALESCE(address_name, `address`),
        `zip_code` = COALESCE(zipcode, `zip_code`),
        `city_id` = COALESCE((SELECT id FROM `city` WHERE `name` = city_name), `city_id`),
        `country_code` = COALESCE((SELECT `code` FROM `country` WHERE `name` = country_name), `country_code`),
        `kind_of_organization_id` = COALESCE((SELECT `id` FROM `kind_of_organization` WHERE `name` = organization_kind), `kind_of_organization_id`),
        `total_asset` = COALESCE(asset, `total_asset`),
        `total_liability` = COALESCE(liability, `total_liability`),
        `registration_body_id` = COALESCE((SELECT `id` FROM `registration_body` WHERE `country_code` = (SELECT `code` FROM `country` WHERE `name` = country_name)), `registration_body_id`),
        `registration_date` = COALESCE(date_of_registration, `registration_date`)
    WHERE
        `name` = `current_name*`;

END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure add_employee
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE add_employee(
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
-- procedure add_grant_request
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE add_grant_request(
    IN grant_title VARCHAR(199),
    IN funding_agency VARCHAR(135),
    IN max_monetary_value DECIMAL(10,2),
    IN new_desired_amount DECIMAL(10,2),
    IN new_application_date DATE,
    IN new_deadline DATE,
    IN `outcome (optional)` VARCHAR(45)
)
BEGIN
    INSERT INTO grant_request(
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
-- procedure add_film
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE add_film(
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
-- procedure add_shareholder
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `add_shareholder`(
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
-- procedure log_insert_procedure
-- -----------------------------------------------------

DELIMITER $$
USE `movie_production_companies`$$
CREATE PROCEDURE `log_insert_procedure`(
    IN log_type VARCHAR(50),
    IN entity VARCHAR(50),
    IN log_description VARCHAR(50)
)
BEGIN
    INSERT INTO log_insert (event_type, table_name, event_description, user)
    VALUES (log_type, entity, log_description, CURRENT_USER());
END;$$

DELIMITER ;

-- -----------------------------------------------------
-- View `movie_production_companies`.`company_info_full`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_production_companies`.`company_info_full`;
USE `movie_production_companies`;
CREATE  OR REPLACE VIEW `company_info_full` AS 
SELECT 
    c.name AS company_name,
    c.address,
    city.name AS city, 
    c.zip_code, 
    country.name AS country, 
    k.name AS organization_type, 
    r.name AS registration_body,
    (SELECT COUNT(*) FROM employee WHERE company_id = c.id) AS number_of_employees,
    total_asset - total_liability AS net_value
FROM 
    company c
JOIN 
    city ON c.city_id = city.id
JOIN 
    country ON c.country_code = country.code
JOIN 
    kind_of_organization k ON c.kind_of_organization_id = k.id
JOIN 
    registration_body r ON c.registration_body_id = r.id;

-- -----------------------------------------------------
-- View `movie_production_companies`.`employee_info_full`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movie_production_companies`.`employee_info_full`;
USE `movie_production_companies`;
CREATE  OR REPLACE VIEW `employee_info_full` AS
    SELECT 
        e.id,
        e.first_name,
        e.middle_name,
        e.last_name,
        c.name AS company,
        e.date_of_birth,
        e.division,
        e.employee_role,
        e.date_started,
        e.email_address,
        p.phone,
        p.description
    FROM
        employee e,
        phone_number p,
        company c
    WHERE
        e.id = p.employee_id
            AND e.company_id = c.id;
USE `movie_production_companies`;

DELIMITER $$
USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER `movie_production_companies`.`company_BEFORE_INSERT_pk_maker` 
BEFORE INSERT ON `company` 
FOR EACH ROW
BEGIN
	IF NEW.name IS NOT NULL THEN
        SET NEW.id = CONCAT(
		NEW.country_code, '-', 
        UPPER(LEFT(NEW.name, 3)), '-',
        FLOOR(100000 + RAND() * 900000)
        );
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER `movie_production_companies`.`employee_BEFORE_INSERT_id` 
BEFORE INSERT ON `employee` FOR EACH ROW
BEGIN
	IF NEW.employee_role IN ('Director', 'Actor', 'Producer') THEN 
    SET NEW.id = CONCAT(
		'CR-', FLOOR(100000 + RAND() * 900000), '-', 
        LEFT(NEW.first_name, 1), 
        LEFT(NEW.last_name, 1),
        RIGHT(NEW.date_of_birth, 1)
        );
	ELSEIF NEW.employee_role IN ('Human Resources', 'Marketing and Finance', 'Public Relations',
								'Asset Management', 'Legal Affairs', 'IT',
								'Casting', 'Post-Production Services', 
                                'Locations and Facilities', 'Research and Development') THEN
    SET NEW.id = CONCAT(
		'ST-', FLOOR(100000 + RAND() * 900000), '-', 
        LEFT(NEW.first_name, 1), 
        LEFT(NEW.last_name, 1),
        RIGHT(NEW.date_of_birth, 1)
		);
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER `movie_production_companies`.`employee_BEFORE_INSERT_division` 
BEFORE INSERT ON `employee` FOR EACH ROW
BEGIN
	IF NEW.employee_role IN ('Director', 'Actor', 'Producer') THEN
	SET NEW.division = 'Crew';
    
    ELSEIF NEW.employee_role IN ('Human Resources', 'Marketing and Finance', 'Public Relations',
								'Asset Management', 'Legal Affairs', 'IT',
								'Casting', 'Post-Production Services', 
                                'Locations and Facilities', 'Research and Development') THEN
    SET NEW.division = 'Staff'; 
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER 
`movie_production_companies`.`employee_AFTER_INSERT_crew-staff_update` 
AFTER INSERT ON `employee` FOR EACH ROW
BEGIN
	IF NEW.employee_role IN ('Director', 'Actor', 'Producer') THEN
	INSERT INTO movie_production_companies.crew(employee_id, role_id) 
    VALUES (NEW.id,
			(SELECT movie_production_companies.`role`.id 
            FROM movie_production_companies.`role` 
            WHERE `role`.name = NEW.employee_role));
    
    ELSEIF NEW.employee_role IN ('Human Resources', 'Marketing and Finance', 'Public Relations'
								'Asset Management', 'Legal Affairs', 'IT',
								'Casting', 'Post-Production Services', 
                                'Locations and Facilities', 'Research and Development') THEN
    INSERT INTO movie_production_companies.staff(employee_id, department_id) 
    VALUES (NEW.id,
			(SELECT movie_production_companies.department.id 
            FROM movie_production_companies.department 
            WHERE department.name = NEW.employee_role));
    
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER `movie_production_companies`.`employee_audit_insert` 
AFTER INSERT ON `employee` 
FOR EACH ROW
BEGIN
	CALL `log_insert_procedure`('INSERT', 'Employee', CONCAT('New row added with ID: ', NEW.id));
END$$

USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER 
`movie_production_companies`.`employee_BEFORE_DELETE_crew_staff_delete` 
BEFORE DELETE ON `employee` FOR EACH ROW
BEGIN
	IF OLD.employee_role IN ('Director', 'Actor', 'Producer') THEN
	DELETE FROM movie_production_companies.crew 
    WHERE OLD.id = crew.employee_id;
    
    ELSEIF OLD.employee_role IN ('Human Resources', 'Marketing and Finance', 'Public Relations'
								'Asset Management', 'Legal Affairs', 'IT',
								'Casting', 'Post-Production Services', 
                                'Locations and Facilities', 'Research and Development') THEN
    DELETE FROM movie_production_companies.staff
    WHERE OLD.id = staff.employee_id; 
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER `movie_production_companies`.`film_BEFORE_INSERT` 
BEFORE INSERT ON `film` FOR EACH ROW
BEGIN
	IF NEW.title IS NOT NULL THEN
    SET NEW.movie_code = UUID();
    END IF;
END$$

USE `movie_production_companies`$$
CREATE DEFINER = CURRENT_USER TRIGGER `movie_production_companies`.`grant_request_BEFORE_INSERT` 
BEFORE INSERT ON `grant_request` 
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


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
