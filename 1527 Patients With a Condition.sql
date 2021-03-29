# https://leetcode.com/problems/patients-with-a-condition/
select patient_id,
       patient_name,
       conditions
from   patients
where  regexp_like(conditions, ' DIAB1|^DIAB1')	


#Another solution
SELECT
    *
FROM Patients
WHERE conditions REGEXP '^DIAB1' or conditions REGEXP ' DIAB1'