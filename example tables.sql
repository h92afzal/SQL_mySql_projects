CREATE TABLE Purchases (
    customer_id INT,
    purchase_date DATE,
    amount_spent DECIMAL(10, 2)
);
INSERT INTO Purchases (customer_id, purchase_date, amount_spent) VALUES
(1, '2024-08-01', 100),
(1, '2024-08-02', 50),
(2, '2024-08-03', 200),
(3, '2024-08-01', 150),
(3, '2024-08-04', 300),
(4, '2024-08-02', 120),
(4, '2024-08-03', 130),
(5, '2024-08-01', 90),
(5, '2024-08-02', 110),
(6, '2024-08-05', 250);


CREATE TABLE Login (
    user_id INT,
    login_date DATE,
    device_type VARCHAR(20)
);
INSERT INTO Login (user_id, login_date, device_type) VALUES
(1, '2024-08-01', 'Mobile'),
(1, '2024-08-02', 'Mobile'),
(2, '2024-08-01', 'Desktop'),
(2, '2024-08-03', 'Mobile'),
(3, '2024-08-02', 'Desktop'),
(3, '2024-08-03', 'Desktop'),
(4, '2024-08-01', 'Tablet'),
(5, '2024-08-03', 'Mobile'),
(5, '2024-08-04', 'Mobile'),
(5, '2024-08-06', 'Desktop'),
(6, '2024-08-05', 'Desktop');

INSERT INTO Login values (7, '2024-08-01', 'Mobile');

CREATE TABLE Subscriptions (
    user_id INT,
    subscription_date DATE,
    plan_type VARCHAR(20)
);
INSERT INTO Subscriptions (user_id, subscription_date, plan_type) VALUES
(1, '2024-08-01', 'Basic'),
(1, '2024-08-07', 'Premium'),
(2, '2024-08-02', 'Basic'),
(2, '2024-08-08', 'Premium'),
(3, '2024-08-03', 'Basic'),
(4, '2024-08-01', 'Premium'),
(5, '2024-08-04', 'Basic'),
(6, '2024-08-01', 'Basic'),
(6, '2024-08-02', 'Standard'),
(7, '2024-08-05', 'Standard');

CREATE TABLE Orders (
    customer_id INT,
    order_date DATE,
    product_id VARCHAR(10),
    quantity INT
);

INSERT INTO Orders (customer_id, order_date, product_id, quantity) VALUES
(1, '2024-08-01', 'A', 2),
(1, '2024-08-02', 'B', 1),
(2, '2024-08-03', 'A', 1),
(3, '2024-08-01', 'C', 3),
(4, '2024-08-04', 'B', 2),
(5, '2024-08-02', 'A', 1),
(5, '2024-08-03', 'C', 1),
(6, '2024-08-05', 'B', 3),
(7, '2024-08-01', 'A', 2),
(7, '2024-08-02', 'C', 1);

CREATE TABLE Transactions (
    account_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(20),
    amount DECIMAL(10, 2)
);
INSERT INTO Transactions (account_id, transaction_date, transaction_type, amount) VALUES
(1, '2024-08-01', 'Deposit', 500),
(1, '2024-08-02', 'Withdrawal', 200),
(2, '2024-08-01', 'Deposit', 300),
(2, '2024-08-03', 'Withdrawal', 100),
(3, '2024-08-02', 'Deposit', 400),
(3, '2024-08-03', 'Withdrawal', 150),
(4, '2024-08-01', 'Deposit', 600),
(5, '2024-08-03', 'Withdrawal', 200),
(5, '2024-08-04', 'Deposit', 300),
(6, '2024-08-05', 'Deposit', 500);

CREATE TABLE PageViews (
    user_id INT,
    view_date DATE,
    page_id VARCHAR(20)
);
INSERT INTO PageViews (user_id, view_date, page_id) VALUES
(1, '2024-08-01', 'Home'),
(1, '2024-08-02', 'Products'),
(2, '2024-08-01', 'Home'),
(2, '2024-08-03', 'Contact'),
(3, '2024-08-02', 'Home'),
(3, '2024-08-03', 'Products'),
(4, '2024-08-01', 'About'),
(5, '2024-08-03', 'Home'),
(5, '2024-08-04', 'Products'),
(6, '2024-08-05', 'Contact');


