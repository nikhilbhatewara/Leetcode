
# Since it always starts with DIAB1 but it could be in second or later place in the conditions column use the following

SELECT patient_id, patient_name, conditions
from patients
where conditions like '% DIAB1%' OR
    conditions like 'DIAB1%'
