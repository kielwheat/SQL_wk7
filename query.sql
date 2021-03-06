-- Select transactions by credit card user
CREATE VIEW cc_transactions AS 
SELECT ch.name, cc.card, t.date, t.amount
FROM card_holder as ch
INNER JOIN credit_card AS cc ON cc.card_holder = ch.id
INNER JOIN transaction AS t ON t.card = cc.card
order by ch.name 
;

--Select highest 100 transactions from 7:00AM to 9:00AM
CREATE VIEW morning_transactions AS
SELECT amount, date
FROM transaction
WHERE CAST(date as time) > cast('7:00' as time) 
    and CAST(date as time) < cast ('9:00' as time)
ORDER BY amount DESC
LIMIT 100;


--Count number of transactions less than $2.00
CREATE VIEW frauded_cardholders AS
SELECT ch.name, COUNT(amount)
FROM transaction AS t
INNER JOIN credit_card AS cc ON cc.card = t.card
INNER JOIN card_holder AS ch ON ch.id = cc.card_holder
WHERE amount < 2.00
GROUP BY ch.name;

--Select the top 5 companies with transactions less than $2.00
CREATE VIEW top_5_frauded_merchants AS
SELECT COUNT(amount), m.name
FROM transaction AS t
INNER JOIN merchant AS m ON m.ID = t.id_merchant
WHERE amount < 2.00
GROUP BY m.name
ORDER BY count DESC
LIMIT 5;
