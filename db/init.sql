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


-- TRUNCATE TABLES
TRUNCATE TABLE pizzeria.order_item CASCADE;
TRUNCATE TABLE pizzeria.pizza_order CASCADE;
TRUNCATE TABLE pizzeria.customer CASCADE;
TRUNCATE TABLE pizzeria.pizza CASCADE;

-- INSERT CUSTOMERS
INSERT INTO pizzeria.customer (id_customer, name, address, email, phone_number) VALUES
('863264988', 'Drake Theory', 'P.O. Box 136, 4534 Lacinia St.', 'draketheory@hotmail.com', '(826) 607-2278'),
('617684636', 'Alexa Morgan', 'Ap #732-8087 Dui. Road', 'aleximorgan@hotmail.com', '(830) 212-2247'),
('474771564', 'Johanna Reigns', '925-3988 Purus. St.', 'johareigns@outlook.com', '(801) 370-4041'),
('394022487', 'Becky Alford', 'P.O. Box 341, 7572 Odio Rd.', 'beckytwobelts@icloud.com', '(559) 398-7689'),
('885583622', 'Brock Alford', '9063 Aliquam, Road', 'brockalford595@platzi.com', '(732) 218-4844'),
('531254932', 'Clarke Wyatt', '461-4278 Dignissim Av.', 'wyattplay@google.co', '(443) 263-8555'),
('762085429', 'Cody Rollins', '177-1125 Consequat Ave', 'codyforchamp@google.com', '(740) 271-3631'),
('363677933', 'Bianca Neal', 'Ap #937-4424 Vestibulum. Street', 'bianca0402@platzi.com', '(792) 406-8858'),
('192758012', 'Drew Watson', '705-6031 Aliquam Street', 'wangwatson@icloud.com', '(362) 881-5943'),
('110410415', 'Mercedes Balor', 'Ap #720-1833 Curabitur Av.', 'mercedesbalorclub@hotmail.com', '(688) 944-6619'),
('262132898', 'Karl Austin', '241-9121 Fames St.', 'stonecold@icloud.com', '(559) 596-3381'),
('644337170', 'Sami Rollins', 'Ap #308-4700 Mollis Av.', 'elgenerico@outlook.com', '(508) 518-2967'),
('782668115', 'Charlotte Riddle', 'Ap #696-6846 Ullamcorper Avenue', 'amityrogers@outlook.com', '(744) 344-7768'),
('182120056', 'Matthew Heyman', 'Ap #268-1749 Id St.', 'heymanboss@hotmail.com', '(185) 738-9267'),
('303265780', 'Shelton Owens', 'Ap #206-5413 Vivamus St.', 'figthowens@platzi.com', '(821) 880-6661');

-- INSERT PIZZAS
INSERT INTO pizzeria.pizza (name, description, price, vegetarian, vegan, available) VALUES
('Pepperoni', 'Pepperoni, Homemade Tomato Sauce & Mozzarella.', 23.0, FALSE, FALSE, TRUE),
('Margherita', 'Fior de Latte, Homemade Tomato Sauce, Extra Virgin Olive Oil & Basil.', 18.5, TRUE, FALSE, TRUE),
('Vegan Margherita', 'Fior de Latte, Homemade Tomato Sauce, Extra Virgin Olive Oil & Basil.', 22.0, TRUE, TRUE, TRUE),
('Avocado Festival', 'Hass Avocado, House Red Sauce, Sundried Tomatoes, Basil & Lemon Zest.', 19.95, TRUE, FALSE, TRUE),
('Hawaiian', 'Homemade Tomato Sauce, Mozzarella, Pineapple & Ham.', 20.5, FALSE, FALSE, FALSE),
('Goat Cheese', 'Portobello Mushrooms, Mozzarella, Parmesan & Goat Cheeses with Alfredo Sauce.', 24.0, FALSE, FALSE, TRUE),
('Mother Earth', 'Artichokes, Roasted Peppers, Rapini, Sundried Tomatoes, Onion, Shaved Green Bell Peppers & Sunny Seasoning.', 19.5, TRUE, FALSE, TRUE),
('Meat Lovers', 'Mild Italian Sausage, Pepperoni, Bacon, Homemade Tomato Sauce & Mozzarella.', 21.0, FALSE, FALSE, TRUE),
('Marinated BBQ Chicken', 'Marinated Chicken with Cilantro, Red Onions, Gouda, Parmesan & Mozzarella Cheeses.', 20.95, FALSE, FALSE, FALSE),
('Truffle Cashew Cream', 'Wild mushrooms, Baby Kale, Shiitake Bacon & Lemon Vinaigrette. Soy free.', 22.0, TRUE, TRUE, TRUE),
('Rico Mor', 'Beef Chorizo, Sundried Tomatoes, Salsa Verde, Pepper, Jalapeno & pistachios', 23.0, FALSE, FALSE, TRUE),
('Spinach Artichoke', 'Fresh Spinach, Marinated Artichoke Hearts, Garlic, Fior de Latte, Mozzarella & Parmesan.', 18.95, TRUE, FALSE, TRUE);

-- INSERT ORDERS
INSERT INTO pizzeria.pizza_order (id_customer, date, total, method, additional_notes) VALUES
('192758012', NOW() - INTERVAL '5 days', 42.95, 'D', 'Don''t be late pls.'),
('474771564', NOW() - INTERVAL '4 days', 62.0, 'S', NULL),
('182120056', NOW() - INTERVAL '3 days', 22.0, 'C', NULL),
('617684636', NOW() - INTERVAL '2 days', 42.0, 'S', NULL),
('192758012', NOW() - INTERVAL '1 day', 20.5, 'D', 'Please bring the jalapeños separately.'),
('782668115', NOW(), 23.0, 'D', NULL);

-- INSERT ORDER ITEMS
INSERT INTO pizzeria.order_item (id_order, id_item, id_pizza, quantity, price) VALUES
(1, 1, 1, 1, 23.0),
(1, 2, 4, 1, 19.95),
(2, 1, 2, 1, 18.5),
(2, 2, 6, 1, 24.0),
(2, 3, 7, 1, 19.5),
(3, 1, 3, 1, 22.0),
(4, 1, 8, 2, 42.0),
(5, 1, 10, 0.5, 11.0),
(5, 2, 12, 0.5, 9.5),
(6, 1, 11, 1, 23);

