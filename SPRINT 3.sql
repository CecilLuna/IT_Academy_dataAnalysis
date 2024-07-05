 -- level 1 exercise 1

CREATE TABLE IF NOT EXISTS credit_card (
        id VARCHAR (15) PRIMARY KEY,
        iban VARCHAR(100),
        pan VARCHAR (100),
        pin smallint,
        cvv smallint,
        expiring_date VARCHAR (15)
    );
ALTER TABLE transaction
ADD CONSTRAINT
FOREIGN KEY (credit_card_id)
REFERENCES credit_card(id);

   
   # level 1 exercise 2.1
UPDATE credit_card SET iban ='R323456312213576817699999' WHERE id='CcU-2938';
   
   #level 1 Exercise 3.1

INSERT INTO transaction (id, credit_card_id, company_id, user_id, lat, longitude, amount, declined) 
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999', '111.11', '0');


# level 1 exercise 4
ALTER TABLE credit_card DROP COLUMN pan;


#level 2 exercise 1 
DELETE FROM transaction WHERE id ='02C6201E-D90A-1859-B4EE-88D2986D3B02';

#level 2 exercise 2
CREATE VIEW MarketingView AS
SELECT company.company_name, company.phone, company.country, AVG(transaction.amount) as AveragePurchase
FROM company 
INNER JOIN transaction On company.id = transaction.company_id
GROUP BY company.company_name, company.phone, company.country
ORDER BY AVG(transaction.amount) DESC;

SELECT * 
FROM transactions.marketingview;

#level 2 exercise 3
SELECT company_name
FROM marketingview
WHERE country = 'Germany';

#Level 3 exercise 1
ALTER TABLE company DROP COLUMN website;


ALTER TABLE credit_card
MODIFY COLUMN id VARCHAR (20),
MODIFY COLUMN iban VARCHAR (50),
MODIFY COLUMN pin VARCHAR (4),
MODIFY COLUMN cvv INT,
MODIFY COLUMN expiring_date VARCHAR (10);

ALTER TABLE credit_card
ADD COLUMN fecha_actual DATE;

ALTER TABLE user RENAME data_user;

#Level 3 exercise 2

CREATE VIEW TechReport AS
SELECT transaction.id as TransactionID, data_user.name as UserFirstName, data_user.surname as UserLastName,
		credit_card.iban as CreditCardIBAN, company.company_name as CompanyName
FROM transaction
INNER JOIN data_user ON transaction.user_id = data_user.id
INNER JOIN credit_card ON transaction.credit_card_id = credit_card.id
INNER JOIN company ON transaction.company_id = company.id;

SELECT *
FROM techreport;

