/*Function that takes in a date and returns the last day of the month of the day*/
CREATE FUNCTION public.last_day(date) RETURNS date
    LANGUAGE sql
    AS $_$

        SELECT (date_trunc('MONTH', $1) + INTERVAL '1 MONTH - 1 day')::date;
        
$_$;