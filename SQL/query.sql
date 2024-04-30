-----  Queries for Part 1: the SQL part of the Assignment:

-- Sum the number of transactions less than $2.00 by cardholder_id
select cc.cardholder_id, count (*) from transactions trx
join credit_card cc on trx.credit_card_num = cc.credit_card_num
where trx.transaction_amt < 2.00
group by cc.cardholder_id
order by cc.cardholder_id;


-- Determine percentage of transactions less than $2.00 for each cardholder
SELECT cardholder_id, 100*COUNT(CASE WHEN trx.transaction_amt < 2.00 THEN 1 ELSE NULL END)
		/ count(*) percent_lt2
FROM transactions trx
join credit_card cc on trx.credit_card_num = cc.credit_card_num
group by cc.cardholder_id
order by percent_lt2 desc;


-- Select 100 highest dollar transactions made between 7am and 9am (this is what the instructions asked for)
select * from transactions
where cast(transaction_date as time) between '07:00:00' and '09:00:00'
order by transaction_amt desc
limit 100;

-- Select 100 lowest dollar transactions made between 7am and 9am (this seemed to be what the 
-- questions were then referencing)
select * from transactions
where cast(transaction_date as time) between '07:00:00' and '09:00:00'
order by transaction_amt 
limit 100;

-- Note on above two queries: from the instructions, the results from the queries above were
-- supposed to give us an indication of fraudulent activities.  However if that's the case,
-- nothing leaped out at me as obviously fraudulent.  So I went down a slightly different path, see
-- next query.

-- With the idea that someone would try to put through a low balance transaction to see if it goes through,
-- shortly before putting through a more expensive transaction, I looked for all larger (over $500) 
-- transactions which were immediately preceded by a lower balance (less than $2) transaction:
with sorted as (
	select *, lag(transaction_amt)  over (order by credit_card_num asc, transaction_date asc) as prev_amt
	from transactions
)
select * from sorted
where transaction_amt > 500 and prev_amt < 2.00;

--notice from the results of the previous query, credit card number 344119623920892 comes up the most
-- (3 times).  So, query on that number to find out which cardholder id it belongs to:
select * from credit_card where credit_card_num = '344119623920892';
-- From the results of that query, we can see that cardholder id 18 has the most instances
-- of a low dollar transaction immediately followed by a higher dollar transaction.

-- Determine the top 5 merchants prone to being hacked:
select merch.merchant_id, merch.merchant_name, count(*), mc.category_name
from transactions trx
join merchant merch on trx.merchant_id = merch.merchant_id
join merchant_category mc on merch.merchant_category_id = mc.merchant_category_id
where transaction_amt < 2.00
group by merch.merchant_id, mc.category_name
order by count desc;

-- Based on counts of transactions under $2 in the above query, the top 3 are:
-- Wood Ramirez (bar)
-- Baker Inc (food truck)
-- Hood Phillips (bar)
-- and then a tie for next place among 12 other businesses 
-- I would focus on the bars\pubs\restaurants, because a low value charge at
-- those establishments seems unlikely.  Food trucks and coffee shops seem much more 
-- likely to have low value charges, as people buy just coffee or a bottle of water.

----- Making the above queries into views:

create view tran_count_amt_lt_2 as
select cc.cardholder_id, count (*) from transactions trx
join credit_card cc on trx.credit_card_num = cc.credit_card_num
where trx.transaction_amt < 2.00
group by cc.cardholder_id
order by cc.cardholder_id;

create view tran_pct_lt_2 as
SELECT cardholder_id, 100*COUNT(CASE WHEN trx.transaction_amt < 2.00 THEN 1 ELSE NULL END)
		/ count(*) percent_lt2
FROM transactions trx
join credit_card cc on trx.credit_card_num = cc.credit_card_num
group by cc.cardholder_id
order by percent_lt2 desc;

create view high_amt_trans as
select * from transactions
where cast(transaction_date as time) between '07:00:00' and '09:00:00'
order by transaction_amt desc
limit 100;

create view low_amt_trans as
select * from transactions
where cast(transaction_date as time) between '07:00:00' and '09:00:00'
order by transaction_amt 
limit 100;

create view low_high_trans as
with sorted as (
	select *, lag(transaction_amt)  over (order by credit_card_num asc, transaction_date asc) as prev_amt
	from transactions
)
select * from sorted
where transaction_amt > 500 and prev_amt < 2.00;

create view top_5_merchants as
select merch.merchant_id, merch.merchant_name, count(*), mc.category_name
from transactions trx
join merchant merch on trx.merchant_id = merch.merchant_id
join merchant_category mc on merch.merchant_category_id = mc.merchant_category_id
where transaction_amt < 2.00
group by merch.merchant_id, mc.category_name
order by count desc;


-----  Queries for Part 2: the Python part of the Assignment:

-- extract transactions under $2.00 for cardholer ids 2 and 18:
select cc.cardholder_id, transaction_date, transaction_amt from transactions trx
join credit_card cc on cc.credit_card_num = trx.credit_card_num
where cc.cardholder_id in (2, 18)
and trx.transaction_amt < 2.00;

-- extract all transactions for cardholer ids 2 and 18:
select cc.cardholder_id, transaction_date, transaction_amt from transactions trx
join credit_card cc on cc.credit_card_num = trx.credit_card_num
where cc.cardholder_id in (2, 18);

-- extract all transactions between Jan and June for cardholder 25
select * from transactions 
where cast(transaction_date as date) between '01/01/2018' and '06/30/2018'
and credit_card_num in
	(select credit_card_num from credit_card
	where cardholder_id = 25);

-- select to determine which categories the outliers belong
select merchant_id, category_name from merchant_category mc 
join merchant merch on mc.merchant_category_id = merch.merchant_category_id
where merchant_id in (16, 40, 48, 64, 87, 96);

