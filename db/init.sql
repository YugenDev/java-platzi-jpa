-- PostgreSQL Script

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS pizzeria CASCADE;

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS pizzeria;

-- -----------------------------------------------------
-- Table pizzeria.pizza
-- -----------------------------------------------------
DROP TABLE IF EXISTS pizzeria.pizza;

CREATE TABLE IF NOT EXISTS pizzeria.pizza (
  id_pizza SERIAL PRIMARY KEY,
  name VARCHAR(30) NOT NULL UNIQUE,
  description VARCHAR(150) NOT NULL,
  price NUMERIC(5,2) NOT NULL,
  vegetarian BOOLEAN,
  vegan BOOLEAN,
  available BOOLEAN NOT NULL
);

-- -----------------------------------------------------
-- Table pizzeria.customer
-- -----------------------------------------------------
DROP TABLE IF EXISTS pizzeria.customer;

CREATE TABLE IF NOT EXISTS pizzeria.customer (
  id_customer VARCHAR(15) NOT NULL PRIMARY KEY,
  name VARCHAR(60) NOT NULL,
  address VARCHAR(100),
  email VARCHAR(50) NOT NULL UNIQUE,
  phone_number VARCHAR(20)
);

-- -----------------------------------------------------
-- Table pizzeria.pizza_order
-- -----------------------------------------------------
DROP TABLE IF EXISTS pizzeria.pizza_order;

CREATE TABLE IF NOT EXISTS pizzeria.pizza_order (
  id_order SERIAL PRIMARY KEY,
  id_customer VARCHAR(15) NOT NULL,
  date TIMESTAMP NOT NULL,
  total NUMERIC(6,2) NOT NULL,
  method CHAR(1) NOT NULL CHECK (method IN ('D', 'S', 'C')),
  additional_notes VARCHAR(200),
  FOREIGN KEY (id_customer) REFERENCES pizzeria.customer (id_customer)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table pizzeria.order_item
-- -----------------------------------------------------
DROP TABLE IF EXISTS pizzeria.order_item;

CREATE TABLE IF NOT EXISTS pizzeria.order_item (
  id_item SERIAL,
  id_order INT NOT NULL,
  id_pizza INT NOT NULL,
  quantity NUMERIC(2,1) NOT NULL,
  price NUMERIC(5,2) NOT NULL,
  PRIMARY KEY (id_item, id_order),
  FOREIGN KEY (id_order) REFERENCES pizzeria.pizza_order (id_order)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (id_pizza) REFERENCES pizzeria.pizza (id_pizza)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

-- -----------------------------------------------------
-- Table pizzeria.user
-- -----------------------------------------------------
DROP TABLE IF EXISTS pizzeria.user;

CREATE TABLE IF NOT EXISTS pizzeria.user (
  username VARCHAR(20) NOT NULL PRIMARY KEY,
  password VARCHAR(200) NOT NULL,
  email VARCHAR(50),
  locked BOOLEAN NOT NULL,
  disabled BOOLEAN NOT NULL
);

-- -----------------------------------------------------
-- Table pizzeria.user_role
-- -----------------------------------------------------
DROP TABLE IF EXISTS pizzeria.user_role;

CREATE TABLE IF NOT EXISTS pizzeria.user_role (
  username VARCHAR(20) NOT NULL,
  role VARCHAR(20) NOT NULL CHECK (role IN ('CUSTOMER', 'ADMIN')),
  granted_date TIMESTAMP NOT NULL,
  PRIMARY KEY (username, role),
  FOREIGN KEY (username) REFERENCES pizzeria.user (username)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
