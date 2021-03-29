# https://leetcode.com/problems/capital-gainloss/

-- calculate total buy/sell amount for each (1)
-- diff bet total sell- total buy 

SELECT
    stock_name, 
    SUM(IF(operation = 'Sell', price, 0)) - SUM(IF(operation = 'Buy', price, 0)) as capital_gain_loss
FROM Stocks
GROUP BY stock_name