#LEVEL 1 exercise 1
#Creating a database
CREATE SCHEMA transaction;
#loading user csv file
CREATE TABLE IF NOT EXISTS user(
        id int PRIMARY KEY,
        name VARCHAR (20),
        surname VARCHAR (20),
        phone VARCHAR (50),
        email VARCHAR (50),
        birthdate VARCHAR (20),
        country VARCHAR (20),
        city VARCHAR (50),
        postal_code VARCHAR (20),
        address VARCHAR (100)
    );
    
SHOW VARIABLES LIKE "secure_file_priv";

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\SPRINT 4\\users_usa.csv'
INTO TABLE user
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\SPRINT 4\\users_uk.csv'
INTO TABLE user
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\SPRINT 4\\users_ca.csv'
INTO TABLE user
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

#loading companies csv file
CREATE TABLE IF NOT EXISTS companies(
        company_id VARCHAR (20) PRIMARY KEY,
        company_name VARCHAR (100),
        phone VARCHAR (50),
        email VARCHAR (50),
        country VARCHAR (50),
        website VARCHAR (50)
    );
    
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\SPRINT 4\\companies.csv'
INTO TABLE companies
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

#loading credit_cards csv file
CREATE TABLE IF NOT EXISTS credit_cards(
        id VARCHAR (20) PRIMARY KEY,
        user_id int,
        iban VARCHAR (50),
        pan VARCHAR (50),
        pin VARCHAR (4),
        cvv INT,
        track1 VARCHAR (100),
        track2 VARCHAR (100),
        expiring_date VARCHAR (10)
    );

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\SPRINT 4\\credit_cards.csv'
INTO TABLE credit_cards
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

#loading transactions csv file
CREATE TABLE IF NOT EXISTS transactions(
        id VARCHAR(50) PRIMARY KEY,
        card_id VARCHAR(20),
        business_id VARCHAR(20), 
		timestamp TIMESTAMP,
        amount DECIMAL(10, 2),
        declined BOOLEAN,
        product_ids VARCHAR (20),
        user_id INT,
        lat FLOAT,
        longitude FLOAT
    );
    
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\SPRINT 4\\transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
IGNORE 1 ROWS;

#loading products csv file
CREATE TABLE IF NOT EXISTS products(
        id INT PRIMARY KEY,
        product_name VARCHAR(50),
		price VARCHAR (50),
        colour VARCHAR (20),
        weight VARCHAR (10),
        warehouse_id VARCHAR (10)
    );
    
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\SPRINT 4\\products.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;

#Adding foreign keys
ALTER TABLE transactions
ADD FOREIGN KEY (card_id) REFERENCES credit_cards(id);

ALTER TABLE transactions
ADD FOREIGN KEY (business_id) REFERENCES companies(company_id);

ALTER TABLE transactions
ADD FOREIGN KEY (user_id) REFERENCES user(id);

#LEVEL 1 exercise 1

SELECT user.id, user.name
FROM user
GROUP BY user.id
HAVING (SELECT COUNT(transactions.id)
FROM transactions
WHERE user.id = transactions.user_id
HAVING COUNT(transactions.id) > 30);

#LEVEL 1 exercise 2

SELECT  ROUND(AVG (transactions.amount),2) as Average_Amount, credit_cards.iban
FROM transactions 
INNER JOIN credit_cards ON credit_cards.id = transactions.card_id
INNER JOIN companies ON companies.company_id = transactions.business_id
WHERE companies.company_name = 'Donec Ltd'
GROUP BY credit_cards.iban;

#to check if the above query is correct
SELECT  transactions.amount, companies.company_name, credit_cards.iban
FROM transactions 
INNER JOIN credit_cards ON credit_cards.id = transactions.card_id
INNER JOIN companies ON companies.company_id = transactions.business_id
WHERE companies.company_name = 'Donec Ltd';


