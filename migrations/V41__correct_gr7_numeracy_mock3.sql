/*Q42 on grade 7 mock 3 correct answer value was incorrectly set to 8
Correct this to 1 on all historic responses*/
UPDATE
    responses
SET
    q42 = '1'
WHERE
    test = 'grade7_mock3'
    AND course = 'zm_gr7_revision'
    AND module = 'numeracy'
    AND q42 = '8';

