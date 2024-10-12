-- -----------------------------------------------------
-- Schema baitap
-- -----------------------------------------------------
CREATE DATABASE baitap;
GO
USE baitap;
GO

-- -----------------------------------------------------
-- Table baitap.category
-- -----------------------------------------------------
CREATE TABLE category (
  idCategory VARCHAR(45) NOT NULL PRIMARY KEY,
  name VARCHAR(45) NOT NULL UNIQUE
);
GO

-- -----------------------------------------------------
-- Table baitap.depot
-- -----------------------------------------------------
CREATE TABLE depot (
  idDepot VARCHAR(45) NOT NULL PRIMARY KEY,
  position VARCHAR(45) NOT NULL
);
GO

-- -----------------------------------------------------
-- Table baitap.product
-- -----------------------------------------------------
CREATE TABLE product (
  idProduct VARCHAR(45) NOT NULL PRIMARY KEY,
  name VARCHAR(45) NOT NULL,
  detail TEXT NULL,
  price INT NOT NULL,
  amount INT NOT NULL
);
GO

-- -----------------------------------------------------
-- Table baitap.[user]
-- -----------------------------------------------------
CREATE TABLE [user] (
  idUser INT NOT NULL PRIMARY KEY,
  name VARCHAR(45) NOT NULL,
  password VARCHAR(45) NOT NULL,
  mail VARCHAR(45) NOT NULL,
  phone VARCHAR(45) NOT NULL,
  province VARCHAR(45) NOT NULL,
  city VARCHAR(45) NOT NULL,
  address VARCHAR(45) NOT NULL,
  district VARCHAR(45) NOT NULL
);
GO

-- -----------------------------------------------------
-- Table baitap.cart
-- -----------------------------------------------------
CREATE TABLE cart (
  User_idUser INT NOT NULL,
  Product_idProduct VARCHAR(45) NOT NULL,
  amount INT NOT NULL,
  date DATETIME NULL,
  PRIMARY KEY (User_idUser, Product_idProduct),
  CONSTRAINT fk_User_has_Product_Product1 FOREIGN KEY (Product_idProduct) REFERENCES product (idProduct),
  CONSTRAINT fk_User_has_Product_User1 FOREIGN KEY (User_idUser) REFERENCES [user] (idUser)
);
GO

-- -----------------------------------------------------
-- Table baitap.[order]
-- -----------------------------------------------------
CREATE TABLE [order] (
  idOrder VARCHAR(45) NOT NULL PRIMARY KEY,
  User_has_Product_User_idUser INT NOT NULL,
  User_has_Product_Product_idProduct VARCHAR(45) NOT NULL,
  date DATETIME NOT NULL,
  val FLOAT NOT NULL,
  fact_user_has_product_User_idUser INT NOT NULL,
  fact_user_has_product_Product_idProduct VARCHAR(45) NOT NULL,
  paid BIT NOT NULL,
  CONSTRAINT fk_order_fact_user_has_product FOREIGN KEY (fact_user_has_product_User_idUser, fact_user_has_product_Product_idProduct)
    REFERENCES cart (User_idUser, Product_idProduct)
);
GO

-- -----------------------------------------------------
-- Table baitap.detail
-- -----------------------------------------------------
CREATE TABLE detail (
  idDetail VARCHAR(45) NOT NULL PRIMARY KEY,
  status VARCHAR(45) NOT NULL,
  time DATETIME NOT NULL,
  location VARCHAR(45) NOT NULL,
  Order_idOrder VARCHAR(45) NOT NULL,
  order_User_has_Product_User_idUser INT NOT NULL,
  order_User_has_Product_Product_idProduct VARCHAR(45) NOT NULL,
  CONSTRAINT fk_detail_order FOREIGN KEY (order_User_has_Product_User_idUser, order_User_has_Product_Product_idProduct, Order_idOrder)
    REFERENCES [order] (User_has_Product_User_idUser, User_has_Product_Product_idProduct, idOrder)
);
GO

-- -----------------------------------------------------
-- Table baitap.payment
-- -----------------------------------------------------
CREATE TABLE payment (
  idPayment VARCHAR(45) NOT NULL PRIMARY KEY,
  paid CHAR(15) NULL,
  balance INT NULL,
  user_idUser INT NOT NULL,
  CONSTRAINT fk_payment_user FOREIGN KEY (user_idUser) REFERENCES [user] (idUser)
);
GO

-- -----------------------------------------------------
-- Table baitap.ship
-- -----------------------------------------------------
CREATE TABLE ship (
  idShip VARCHAR(45) NOT NULL PRIMARY KEY,
  status NVARCHAR(50) NULL,
  destination VARCHAR(45) NOT NULL
);
GO

-- -----------------------------------------------------
-- Table baitap.rate
-- -----------------------------------------------------
CREATE TABLE rate (
  rate_idRate VARCHAR(45) NOT NULL PRIMARY KEY,
  review TEXT NULL,
  star INT NULL,
  date DATE NULL,
  user_idUser INT NOT NULL,
  product_idProduct VARCHAR(45) NOT NULL,
  CONSTRAINT fk_rate_user FOREIGN KEY (user_idUser) REFERENCES [user] (idUser),
  CONSTRAINT fk_rate_product FOREIGN KEY (product_idProduct) REFERENCES product (idProduct)
);
GO

-- -----------------------------------------------------
-- Table baitap.product_has_category
-- -----------------------------------------------------
CREATE TABLE product_has_category (
  product_idProduct VARCHAR(45) NOT NULL,
  category_idCategory VARCHAR(45) NOT NULL,
  PRIMARY KEY (product_idProduct, category_idCategory),
  CONSTRAINT fk_product_has_category_product FOREIGN KEY (product_idProduct) REFERENCES product (idProduct),
  CONSTRAINT fk_product_has_category_category FOREIGN KEY (category_idCategory) REFERENCES category (idCategory)
);
GO

-- -----------------------------------------------------
-- Table baitap.detail_ship
-- -----------------------------------------------------
CREATE TABLE detail_ship (
  depot_idDepot VARCHAR(45) NOT NULL,
  ship_idShip VARCHAR(45) NOT NULL,
  detail_idDetail VARCHAR(45) NOT NULL,
  detail_Order_idOrder VARCHAR(45) NOT NULL,
  time DATETIME NOT NULL,
  PRIMARY KEY (depot_idDepot, ship_idShip, detail_idDetail, detail_Order_idOrder),
  CONSTRAINT fk_depot_has_ship_depot FOREIGN KEY (depot_idDepot) REFERENCES depot (idDepot),
  CONSTRAINT fk_depot_has_ship_ship FOREIGN KEY (ship_idShip) REFERENCES ship (idShip),
  CONSTRAINT fk_depot_has_ship_detail FOREIGN KEY (detail_idDetail, detail_Order_idOrder) REFERENCES detail (idDetail, Order_idOrder)
);
GO

-- -----------------------------------------------------
-- Table baitap.ads
-- -----------------------------------------------------
CREATE TABLE ads (
  product_idProduct VARCHAR(45) NOT NULL,
  product_idProduct1 VARCHAR(45) NOT NULL,
  used INT NOT NULL,
  coupon FLOAT NOT NULL,
  start DATETIME NOT NULL,
  [end] DATETIME NOT NULL,  -- "end" is a reserved keyword in MSSQL, so it's enclosed in brackets.
  content TEXT NOT NULL,
  PRIMARY KEY (product_idProduct, product_idProduct1),
  CONSTRAINT fk_ads_product1 FOREIGN KEY (product_idProduct) REFERENCES product (idProduct),
  CONSTRAINT fk_ads_product2 FOREIGN KEY (product_idProduct1) REFERENCES product (idProduct)
);
GO
