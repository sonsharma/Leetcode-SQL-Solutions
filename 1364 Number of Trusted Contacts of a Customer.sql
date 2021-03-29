#https://leetcode.com/problems/number-of-trusted-contacts-of-a-customer/

-- Invoices - invoice_id, price
-- Join 1+Customers table ->customer_name
-- contacts_cnt -> 2+contacts
-- trusted_contacts_cnt -> check contacts email present in customers table or not
-- order invoice_id

WITH CTE AS (SELECT i.invoice_id, c.customer_name, i.price,
                    count(ct.user_id) as contacts_cnt,
                    SUM(IF(ct.contact_email in (SELECT email FROM Customers), 1, 0)) AS trusted_contacts_cnt
            FROM Invoices i 
                LEFT JOIN Customers c ON i.user_id = c.customer_id
                LEFT JOIN Contacts ct ON i.user_id = ct.user_id
            GROUP BY i.invoice_id
             ORDER BY i.invoice_id
            )
            
SELECT * FROM CTE
;