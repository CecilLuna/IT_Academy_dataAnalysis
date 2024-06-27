SELECT *
FROM company;

SELECT *
FROM transaction;

-- level 1 exercise 2.1
SELECT DISTINCT company.country
FROM company
INNER JOIN transaction 
	ON company.id = transaction.company_id
WHERE declined = 0;

-- level 1 exercise 2.2
SELECT COUNT(DISTINCT company.country) 
	as total_number_of_countries_purchasing
FROM company
INNER JOIN
    transaction ON company.id = transaction.company_id
WHERE
    declined = 0;

-- level 2 exercise 2.3
SELECT company.company_name,  ROUND (AVG (transaction.amount),2) as average
FROM transaction
INNER JOIN company on transaction.company_id = company.id
WHERE declined = 0
GROUP BY company.company_name
ORDER BY average DESC
LIMIT 1;

-- level 2 exercise 3.1
SELECT *
FROM transaction 
WHERE company_id IN (SELECT company.id
						FROM company
                        WHERE company.country = 'Germany');

-- level 1 exercise 3.2

SELECT company.company_name
FROM company
WHERE id IN (SELECT transaction.company_id
				FROM transaction
                WHERE amount > (SELECT avg (transaction.amount) FROM transaction));



-- level 1 exercise 3.3
SELECT company.company_name
FROM company
WHERE NOT EXISTS (SELECT transaction.company_id
					FROM transaction);
                  
-- level 2 exercise 1

SELECT date(timestamp) as date, SUM(transaction.amount) as amount
FROM transaction
WHERE declined = 0
GROUP BY date(timestamp) 
ORDER BY amount DESC
LIMIT 5;

-- level 2 exercise 2
SELECT company.country, AVG (transaction.amount) as average_sales
FROM transaction
INNER JOIN company ON company.id = transaction.company_id
WHERE declined = 0
GROUP BY company.country
ORDER BY average_sales DESC;


-- level 2 exercise 3.1
SELECT company.company_name, company.country, transaction.*
FROM company
INNER JOIN transaction ON company.id = transaction.company_id
WHERE country = (SELECT company.country
					FROM company
                    WHERE company_name = 'Non Institute')
AND company_name != 'Non Institute';

-- level 2 exercise 3.2
SELECT 
		(SELECT company.company_name
        FROM company
        WHERE company.id = transaction.company_id
        AND company_name != 'Non Institute'
        AND country IN (SELECT company.country 
								FROM company
                                WHERE company_name = 'Non Institute')) as company_name,
		(SELECT company.country
        FROM company
		WHERE company.id = transaction.company_id
        AND company_name != 'Non Institute'
        AND country IN (SELECT company.country FROM company WHERE company_name = 'Non Institute')) as country, 
        transaction.*
FROM transaction
HAVING company_name IS NOT NULL;

-- level 3 exercise 1
SELECT company.company_name, company.phone, company.country, DATE (t.timestamp) as date, t.amount
FROM transaction t
INNER JOIN company ON company.id = t.company_id
WHERE amount BETWEEN 100 AND 200
AND DATE (t.timestamp) IN ('2021-07-20','2021-04-29','2022-03-13')
ORDER by amount DESC;
-- level 3 exercise 2
SELECT company.company_name, count(declined) as number_of_transactions,
CASE
WHEN count(declined) > 4 THEN 'more than 4'
WHEN count(declined) < 4 THEN 'less than 4'
ELSE 'more than 4 transactions'
END AS transactions_assessment
FROM transaction t
INNER JOIN company ON company.id = t.company_id
WHERE declined = 0
GROUP BY company.company_name;
