# Module_7_Challenge - Markdown Report

Part 1 - Analysis from Queries: please see QUERY member in SQL folder for the actual queries.  
Analysis: Looking at just the counts of low value (less than $2) transactions by cardholder wasn't very helpful to me, because it was hard to know if the count was outside of cardholder behavior.  In other words, if someone has a count of 15, what does that mean?  It's hard to infer anything from just the count, without looking at behavioral patterns.  So, I chose next to look at percentage of transactions which were low value.  However that too is not too useful as a stand-alone piece of data - perhaps the cardholder uses their card frequently at a coffee shop.  Cardholder 18 did float to the top of that result though, indicating that it could be worth of a second look.

Next up was to look at transactions between 7 and 9am.  I wasn't sure if this instruction was asking for the low value transactions to indicate that the card was being hacked, or the actual higher value transactions which could be actual fraudulent purchases, so set up both queries.  These queries by themselves did not tell me much, although the instructions hinted that we should be able to tell something something from the results; alas, I could not.  I would argue though that it makes sense that there could be more valid low value transactions in the morning, as people buy their morning coffee and put it on their card.

With the idea that a hacker would put through a smaller charge to see if the card worked, followed soon thereafter by a larger charge, I set up a query to look for low value charges which were soon followed by a higher value charge. In looking at those results, card 344119623920892 frequently followed that pattern.  In querying the table, that card belongs to cardholder 18, so again this customer is worthy of additional analysis.

Lastly, looking at the top 5 establishments prone to being hacked, the results are:
-- Wood Ramirez (bar)
-- Baker Inc (food truck)
-- Hood Phillips (bar)
-- and then a tie for next place among 12 other businesses 
I would focus on the bars\pubs\restaurants, because a low value charge at those establishments seems unlikely.  Food trucks and coffee shops seem much more likely to have low value charges, as people buy just coffee or a bottle of water.


Part 2 - Analysis from python code
Question 1: What difference do you observe between the consumption patterns? Does the difference suggest a fraudulent transaction? Explain your rationale in the markdown report.

Answer: Both the combined plot "Transaction Amounts Less Than $5, by Date" and combined "Running Total of Transactions Under $2 by Date" reports indicate that cardholder 18 could have a problem, as was suspected from the results in the queries.  In both graphs you can see that starting in November there seems to be a spike in the number of transactions under $2 for that cardholder.

Question 2: Are there any outliers for cardholder ID 25? How many outliers are there per month?  Do you notice any anomalies? Describe your observations and conclusions.

Answer: I determined outliers based on z-scores.  There were 6 transactions which fell more than 2 standard deviations from the mean: one in January, one in March, one in April, one in May, and two in June.  The context of the question was around being hacked in the first quarter (Jan-Mar), and indeed there does seem to be a spike in transactions > $1000 from March-June.  Two in particular which look suspicious are the $1486 charge to a food truck in May, and the $1813 charge to a bar in June.  I would propose to the customer that yes it's entirely possible the card was hacked, and recommend she get a new one.

