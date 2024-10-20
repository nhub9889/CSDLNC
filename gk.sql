use gk;
CREATE TABLE IF NOT EXISTS `gk`.`author` (
  `idAuthor` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `Infor` TEXT(1024) NOT NULL,
  PRIMARY KEY (`idAuthor`))
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `gk`.`book` (
  `idBook` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `price` INT NOT NULL,
  `amount` INT NOT NULL,
  `page` INT NOT NULL,
  `DOI` VARCHAR(45) NULL,
  `year` YEAR NOT NULL,
  `pound` INT NULL,
  `length` INT NULL,
  `width` INT NULL,
  `ISBN` VARCHAR(45) NULL,
  `decription` TEXT(1024) NULL,
  PRIMARY KEY (`idBook`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci

CREATE TABLE IF NOT EXISTS `gk`.`book_has_author` (
  `book_idBook` VARCHAR(45) NOT NULL,
  `author_idAuthor` VARCHAR(45) NOT NULL,
  `date` DATE NOT NULL,
  PRIMARY KEY (`book_idBook`, `author_idAuthor`),
  INDEX `fk_book_has_author_author1_idx` (`author_idAuthor` ASC) VISIBLE,
  INDEX `fk_book_has_author_book1_idx` (`book_idBook` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_author_book1`
    FOREIGN KEY (`book_idBook`)
    REFERENCES `gk`.`book` (`idBook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_author_author1`
    FOREIGN KEY (`author_idAuthor`)
    REFERENCES `gk`.`author` (`idAuthor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci

CREATE TABLE IF NOT EXISTS `gk`.`category` (
  `idCategory` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci

CREATE TABLE IF NOT EXISTS `gk`.`book_has_category` (
  `book_idBook` VARCHAR(45) NOT NULL,
  `category_idCategory` INT NOT NULL,
  PRIMARY KEY (`book_idBook`, `category_idCategory`),
  INDEX `fk_book_has_category_category1_idx` (`category_idCategory` ASC) VISIBLE,
  INDEX `fk_book_has_category_book1_idx` (`book_idBook` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_category_book1`
    FOREIGN KEY (`book_idBook`)
    REFERENCES `gk`.`book` (`idBook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_category_category1`
    FOREIGN KEY (`category_idCategory`)
    REFERENCES `gk`.`category` (`idCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci

CREATE TABLE IF NOT EXISTS `gk`.`user` (
  `idUser` VARCHAR(256) NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(1024) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `type` TINYINT NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUser`),
  UNIQUE INDEX `idUser_UNIQUE` (`idUser` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci

CREATE TABLE IF NOT EXISTS `gk`.`cart` (
  `idCart` VARCHAR(55) NOT NULL,
  `user_idUser` VARCHAR(256) NOT NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`idCart`),
  INDEX `fk_cart_user1_idx` (`user_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_cart_user1`
    FOREIGN KEY (`user_idUser`)
    REFERENCES `gk`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `gk`.`media` (
  `idMedia` INT NOT NULL,
  `urlImage` VARCHAR(55) NULL,
  `urlVideo` VARCHAR(55) NULL,
  `product_idProduct` VARCHAR(45) NOT NULL,
  `urlMainImage` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idMedia`, `product_idProduct`),
  INDEX `fk_media_product1_idx` (`product_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_media_product1`
    FOREIGN KEY (`product_idProduct`)
    REFERENCES `gk`.`book` (`idBook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `gk`.`order` (
  `idOrder` VARCHAR(45) NOT NULL,
  `date` DATETIME NOT NULL,
  `sumPrice` VARCHAR(45) NOT NULL,
  `user_idUser` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`idOrder`, `user_idUser`),
  INDEX `fk_order_user1_idx` (`user_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`user_idUser`)
    REFERENCES `gk`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `gk`.`orderBook` (
  `idorderProduct` VARCHAR(45) NOT NULL,
  `amount` INT NOT NULL,
  `price` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `order_idOrder` VARCHAR(45) NOT NULL,
  `order_user_idUser` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`idorderProduct`, `order_idOrder`, `order_user_idUser`),
  INDEX `fk_orderProduct_order1_idx` (`order_idOrder` ASC, `order_user_idUser` ASC) VISIBLE,
  CONSTRAINT `fk_orderProduct_order1`
    FOREIGN KEY (`order_idOrder` , `order_user_idUser`)
    REFERENCES `gk`.`order` (`idOrder` , `user_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB

CREATE TABLE IF NOT EXISTS `gk`.`book_has_orderBook` (
  `book_idBook` VARCHAR(45) NOT NULL,
  `orderBook_idorderProduct` VARCHAR(45) NOT NULL,
  `orderBook_order_idOrder` VARCHAR(45) NOT NULL,
  `orderBook_order_user_idUser` VARCHAR(256) NOT NULL,
  `date` DATETIME NOT NULL,
  `price` INT NOT NULL,
  `image` VARCHAR(1024) NOT NULL,
  PRIMARY KEY (`book_idBook`, `orderBook_idorderProduct`, `orderBook_order_idOrder`, `orderBook_order_user_idUser`),
  INDEX `fk_book_has_orderBook_orderBook1_idx` (`orderBook_idorderProduct` ASC, `orderBook_order_idOrder` ASC, `orderBook_order_user_idUser` ASC) VISIBLE,
  INDEX `fk_book_has_orderBook_book1_idx` (`book_idBook` ASC) VISIBLE,
  CONSTRAINT `fk_book_has_orderBook_book1`
    FOREIGN KEY (`book_idBook`)
    REFERENCES `gk`.`book` (`idBook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_book_has_orderBook_orderBook1`
    FOREIGN KEY (`orderBook_idorderProduct` , `orderBook_order_idOrder` , `orderBook_order_user_idUser`)
    REFERENCES `gk`.`orderBook` (`idorderProduct` , `order_idOrder` , `order_user_idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci

CREATE TABLE IF NOT EXISTS `gk`.`cart_has_book` (
  `cart_idCart` VARCHAR(55) NOT NULL,
  `book_idBook` VARCHAR(45) NOT NULL,
  `urlMainImage` VARCHAR(45) NOT NULL,
  `year` YEAR NOT NULL,
  PRIMARY KEY (`cart_idCart`, `book_idBook`),
  INDEX `fk_cart_has_book_book1_idx` (`book_idBook` ASC) VISIBLE,
  INDEX `fk_cart_has_book_cart1_idx` (`cart_idCart` ASC) VISIBLE,
  CONSTRAINT `fk_cart_has_book_cart1`
    FOREIGN KEY (`cart_idCart`)
    REFERENCES `gk`.`cart` (`idCart`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_has_book_book1`
    FOREIGN KEY (`book_idBook`)
    REFERENCES `gk`.`book` (`idBook`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB