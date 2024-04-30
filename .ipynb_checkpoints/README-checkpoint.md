# Module_7_Challenge - Markdown Report

Note on the first part of the assignment (from the SQL queries): it wasn't clear where to put the responses to the questions which were to be derived based on the results from the queries, so I put the answers in the QUERY member, below each query.

Responses to questions in second part of assignment:

Question 1: What difference do you observe between the consumption patterns? Does the difference suggest a fraudulent transaction? Explain your rationale in the markdown report.

Answer: Both the combined plot "Transaction Amounts Less Than $5, by Date" and combined "Running Total of Transactions Under $2 by Date" reports indicate that cardholder 18 could have a problem.  In both graphs you can see that starting in November there seems to be a spike in the number of transactions under $2 for that cardholder.

Question 2: Are there any outliers for cardholder ID 25? How many outliers are there per month?  Do you notice any anomalies? Describe your observations and conclusions.

Answer: I determined outliers based on z-scores.  There were 6 transactions which fell more than 2 standard deviations from the mean: one in January, one in March, one in April, one in May, and two in June.  The context of the question was around being hacked in the first quarter (Jan-Mar), and indeed there does seem to be a spike in transactions > $1000 from March-June.  Two in particular which look suspicious are the $1486 charge to a food truck in May, and the $1813 charge to a bar in June.  I would propose to the customer that yes it's entirely possible the card was hacked, and recommend she get a new one.