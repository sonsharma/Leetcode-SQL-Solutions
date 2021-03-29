# https://leetcode.com/problems/total-sales-amount-by-year/


SELECT s.product_id, p.product_name, report_year, total_amount
FROM (SELECT 
        product_id,
        "2018" as report_year,
        average_daily_sales*(DATEDIFF(LEAST(period_end, '2018-12-31'), GREATEST(period_start, '2018-01-01'))+1) as total_amount
    FROM Sales
    WHERE year(period_start) = 2018 or year(period_end) = 2018

    UNION ALL

    SELECT product_id, "2019" as report_year,
        average_daily_sales*(DATEDIFF(LEAST(period_end, '2019-12-31'), GREATEST(period_start, '2019-01-01'))+1) as total_amount
    FROM Sales
    WHERE year(period_start) <= 2019 and year(period_end) >= 2019
      

    UNION ALL

    SELECT 
        product_id,
        "2020" as report_year,
        average_daily_sales*(DATEDIFF(LEAST(period_end, '2020-12-31'), GREATEST(period_start, '2020-01-01'))+1) as total_amount
    FROM Sales
    WHERE year(period_start) = 2020 or year(period_end) = 2020) s LEFT JOIN Product p USING(product_id)
ORDER BY s.product_id, report_year


# Another solution
-- get periods of each product_id
-- count days in each period x daily sales = total amt
-- where, order
WITH CTE AS (Select '2018-01-01' period_start, '2018-12-31' period_end
            UNION
            Select '2019-01-01' period_start, '2019-12-31' period_end
            UNION
            Select '2020-01-01' period_start, '2020-12-31' period_end
            )

SELECT
    product_id,
    p.product_name,
    concat(year(c.period_end)) report_year,
    average_daily_sales*(ABS(DATEDIFF(GREATEST(s.period_start,c.period_start), LEAST(s.period_end, c.period_end)))+1) total_amount
FROM Sales s JOIN CTE c 
    JOIN Product p USING(product_id)
where greatest(s.period_start, c.period_start) <= c.period_end 
    and least(s.period_end, c.period_end) >= c.period_start
ORDER BY 1, 3