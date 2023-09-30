## Creación de Bodega de datos
## ---------------------------

##
## sakila_datawh
## -------------
CREATE DATABASE IF NOT EXISTS sakila_datawh;
USE sakila_datawh;


-- Dimensión Cliente
-- Tabla dim_customer
CREATE TABLE IF NOT EXISTS dim_customer (

  customer_key INT(8) NOT NULL AUTO_INCREMENT,
  customer_id INT(8) NULL DEFAULT NULL,

  customer_first_name VARCHAR(45) NULL DEFAULT NULL,
  customer_last_name VARCHAR(45) NULL DEFAULT NULL,
  customer_name VARCHAR(90) NULL DEFAULT NULL,
  customer_active CHAR(3) NULL DEFAULT NULL,
  customer_address VARCHAR(64) NULL DEFAULT NULL,
  customer_district VARCHAR(20) NULL DEFAULT NULL,
  customer_city VARCHAR(50) NULL DEFAULT NULL,
  customer_country VARCHAR(50) NULL DEFAULT NULL,
  customer_valid_from DATE NULL DEFAULT NULL,
  customer_valid_through DATE NULL DEFAULT NULL,

  customer_last_update DATETIME NOT NULL DEFAULT (CURRENT_DATE),

  PRIMARY KEY (customer_key),
  UNIQUE INDEX customer_id (customer_id) VISIBLE
);


-- Dimension Tiempo
-- Tabla dim_date
CREATE TABLE IF NOT EXISTS dim_date (

  date_key INT(8) NOT NULL,
  date_value DATE NOT NULL,
  
  date_medium CHAR(16) NOT NULL,
  month_number TINYINT(3) NOT NULL,
  month_name CHAR(12) NOT NULL,
  year4 SMALLINT(5) NOT NULL,
  year_month_number CHAR(7) NOT NULL,
  
  PRIMARY KEY (date_key),
  UNIQUE INDEX date (date_value) VISIBLE,
  UNIQUE INDEX date_value (`date_value` ASC) VISIBLE
);


-- Dimensión Película
-- Tabla dim_film
CREATE TABLE IF NOT EXISTS dim_film (

  film_key INT(8) NOT NULL AUTO_INCREMENT,
  film_id INT(11) NOT NULL,
  
  film_title VARCHAR(64) NOT NULL,
  film_description TEXT NOT NULL,
  film_release_year SMALLINT(5) NOT NULL,
  film_language VARCHAR(20) NOT NULL,
  film_rental_duration TINYINT(3) NULL DEFAULT NULL,
  film_rental_rate DECIMAL(4,2) NULL DEFAULT NULL,
  film_duration INT(8) NULL DEFAULT NULL,
  film_replacement_cost DECIMAL(5,2) NULL DEFAULT NULL,
  film_rating_text VARCHAR(30) NULL DEFAULT NULL,
  film_category CHAR(30) NULL DEFAULT NULL,

  film_last_update DATETIME NOT NULL DEFAULT (CURRENT_DATE),

  PRIMARY KEY (film_key),
  UNIQUE INDEX film_id (film_id)
);


-- Dimensión Staff
-- Tabla dim_staff
CREATE TABLE IF NOT EXISTS dim_staff (

  staff_key INT(8) NOT NULL AUTO_INCREMENT,
  staff_id INT(8) NULL DEFAULT NULL,

  staff_first_name VARCHAR(45) NULL DEFAULT NULL,
  staff_last_name VARCHAR(45) NULL DEFAULT NULL,
  staff_store_id INT(8) NULL DEFAULT NULL,
  staff_active CHAR(3) NULL DEFAULT NULL,

  staff_last_update DATETIME NOT NULL DEFAULT (CURRENT_DATE),

  PRIMARY KEY (staff_key),
  UNIQUE INDEX staff_id (`staff_id`) VISIBLE
);


-- Dimensión Almacen
-- Tabla dim_store
CREATE TABLE IF NOT EXISTS dim_store (

  store_key INT(8) NOT NULL AUTO_INCREMENT,
  store_id INT(8) NULL DEFAULT NULL,

  store_address VARCHAR(64) NULL DEFAULT NULL,
  store_district VARCHAR(20) NULL DEFAULT NULL,
  store_city VARCHAR(50) NULL DEFAULT NULL,
  store_country VARCHAR(50) NULL DEFAULT NULL,
  store_manager_staff_id INT(8) NULL DEFAULT NULL,
  store_manager_first_name VARCHAR(45) NULL DEFAULT NULL,
  store_manager_last_name VARCHAR(45) NULL DEFAULT NULL,

  store_last_update DATETIME NOT NULL DEFAULT (CURRENT_DATE),

  PRIMARY KEY (store_key),
  UNIQUE INDEX store_id (store_id) VISIBLE,
  INDEX city USING BTREE (store_city) VISIBLE,
  INDEX country USING BTREE (store_city) VISIBLE
);


-- Hechos Alquiler
-- Tabla fact_rental
CREATE TABLE IF NOT EXISTS fact_rental (

  rental_id INT(11) NULL DEFAULT NULL,

  customer_key INT(8) NOT NULL,
  staff_key INT(8) NOT NULL,
  film_key INT(8) NOT NULL,
  store_key INT(8) NOT NULL,
  date_key INT(8) NOT NULL,

  count_returns INT(10) NOT NULL,
  count_rentals INT(8) NOT NULL,

  INDEX fk_customer_idx (customer_key ASC) VISIBLE,
  INDEX fk_stafk_idx (staff_key ASC) VISIBLE,
  INDEX fk_store_idx (store_key ASC) VISIBLE,
  INDEX fk_film_idx (film_key ASC) VISIBLE,
  INDEX fk_date_idx (date_key ASC) VISIBLE,
  CONSTRAINT fk_customer
    FOREIGN KEY (customer_key)
    REFERENCES dim_customer (customer_key)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_staff
    FOREIGN KEY (staff_key)
    REFERENCES dim_staff (staff_key)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_store
    FOREIGN KEY (store_key)
    REFERENCES dim_store (store_key)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_film
    FOREIGN KEY (film_key)
    REFERENCES dim_film (film_key)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT fk_date
    FOREIGN KEY (date_key)
    REFERENCES dim_date (date_key)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
);
