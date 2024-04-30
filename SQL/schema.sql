-- Drop tables
DROP TABLE IF EXISTS cardholder CASCADE;
DROP TABLE IF EXISTS credit_card CASCADE;
DROP TABLE IF EXISTS merchant CASCADE;
DROP TABLE IF EXISTS merchant_category CASCADE;
DROP TABLE IF EXISTS transactions CASCADE;

-- Create a table of cardholders
CREATE TABLE cardholder (
  cardholder_id INT PRIMARY KEY,
  cardholder_name VARCHAR NOT NULL
);

-- Create a table of credit cards
CREATE TABLE credit_card (
  credit_card_num VARCHAR(20) NOT NULL PRIMARY KEY,
  cardholder_id INT,
  FOREIGN KEY (cardholder_id) REFERENCES cardholder(cardholder_id)
);

CREATE TABLE merchant_category (
	merchant_category_id INT PRIMARY KEY NOT NULL,
	category_name varchar
);

CREATE TABLE merchant (
	merchant_id INT PRIMARY KEY,
	merchant_name varchar NOT NULL,
	merchant_category_id INT,
	FOREIGN KEY (merchant_category_id) REFERENCES merchant_category(merchant_category_id)
);

CREATE TABLE transactions (
	transaction_id INT PRIMARY KEY NOT NULL,
	transaction_date TIMESTAMP,
	transaction_amt DECIMAL(9,2),
	credit_card_num VARCHAR(20),
	merchant_id INT,
	FOREIGN KEY (credit_card_num) REFERENCES credit_card(credit_card_num),
	FOREIGN KEY (merchant_id) REFERENCES merchant(merchant_id)
);


